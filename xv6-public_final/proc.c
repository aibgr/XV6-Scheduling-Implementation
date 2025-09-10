/*
 * proc.c
 *
 * Round-Robin (default), FCFS و Lottery
 */

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "traps.h"
#include "pstat.h"   // برای getpinfo

extern uint ticks;   // اعلان خارجی شمارنده‌ی تیک (تعریف در trap.c)

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

/* --- project additions --- */
int scheduling_policy = 0; /* 0=RR (default), 1=FCFS,
2=LOTTERY */
int curpolicy(void){ return scheduling_policy; }

static unsigned long rand_seed = 1;
static unsigned int krand(void) {
  rand_seed = rand_seed * 1664525UL + 1013904223UL;
  return (unsigned int)(rand_seed);
}
/* ------------------------- */

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid(void) {
  return mycpu() - cpus;
}

struct cpu*
mycpu(void)
{
  int apicid, i;

  if(readeflags() & FL_IF)
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so we are not rescheduled while reading proc
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

// Look in the process table for an UNUSED proc.
struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start at forkret -> trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  /* initialize accounting fields */
  p->ctime = ticks;
  p->etime = 0;
  p->rtime = 0;
  p->retime = 0;
  p->stime = 0;

  /* default tickets */
  p->tickets = 10;
  p->original_tickets = 10;

  return p;
}

// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  acquire(&ptable.lock);
  p->state = RUNNABLE;
  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from parent.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  // inherit tickets from parent; set child's original to its initial tickets
  np->tickets = (curproc->tickets > 0 ? curproc->tickets : 1);
  np->original_tickets = np->tickets;

  pid = np->pid;

  acquire(&ptable.lock);
  np->state = RUNNABLE;
  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Account exit time and go zombie.
  curproc->etime = ticks;
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
  for(;;){
    // Scan for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }
    // No point waiting if no children or we're killed.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }
    // Wait for a child to exit.
    sleep(curproc, &ptable.lock);
  }
}

// Extended: waitx -> returns child's rtime and wtime
int
waitx(int *wtime, int *rtime)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  if(wtime == 0 || rtime == 0)
    return -1;

  acquire(&ptable.lock);
  for(;;){
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        pid = p->pid;

        // گزارش زمان‌ها: rtime از خود پروسه، wtime = etime - ctime - rtime
        int rt = (int)p->rtime;
        int wt = (int)p->etime - (int)p->ctime - rt;
        if(wt < 0) wt = 0; // گارد

        // کپی به آدرس کاربر بعدا در sys_waitx با argptr پاس داده می‌شود
        *rtime = rt;
        *wtime = wt;

        // پاک‌سازی
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;

        release(&ptable.lock);
        return pid;
      }
    }
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }
    sleep(curproc, &ptable.lock);
  }
}

// Per-CPU process scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;

  for(;;){
    // Enable interrupts on this processor.
    sti();

    acquire(&ptable.lock);

    if(scheduling_policy == 1){
      // FCFS: انتخاب قدیمی‌ترین ctime بین RUNNABLE ها (غیر پیش‌دستانه)
      struct proc *best = 0;
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state != RUNNABLE) continue;
        if(best == 0 || p->ctime < best->ctime)
          best = p;
      }
      if(best){
        c->proc = best;
        switchuvm(best);
        best->state = RUNNING;

        // مهم: قفل را نگه می‌داریم؛ خود پروسه در forkret/sched آن را آزاد می‌کند
        swtch(&(c->scheduler), best->context);
        switchkvm();
        c->proc = 0;
      }
    } else if(scheduling_policy == 2){
      // Lottery
      int totaltix = 0;
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state == RUNNABLE){
          int t = (p->tickets > 0 ? p->tickets : 1);
          // از سرریز جلوگیری کنیم 
          if(totaltix <= 0x7fffffff - t)
            totaltix += t;
          else
            totaltix = 0x7fffffff;
        }
      }
      if(totaltix > 0){
        unsigned int r = krand() % (unsigned int)totaltix;
        int acc = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
          if(p->state != RUNNABLE) continue;
          int t = (p->tickets > 0 ? p->tickets : 1);
          acc += t;
          if(acc > (int)r){
            c->proc = p;
            switchuvm(p);
            p->state = RUNNING;

            swtch(&(c->scheduler), p->context);
            switchkvm();
            c->proc = 0;
            break;
          }
        }
      }
    } else {
      // Round-Robin
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state != RUNNABLE) continue;
        c->proc = p;
        switchuvm(p);
        p->state = RUNNING;

        swtch(&(c->scheduler), p->context);
        switchkvm();
        c->proc = 0;
      }
    }

    release(&ptable.lock);
  }
}

void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags() & FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  // نگه داشتن قفل طبق قرارداد
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler() will swtch here.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }
  // Return to trapret (set up in allocproc)
}

// Atomically release lock and sleep on chan. Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if(p == 0)
    panic("sleep");
  if(lk == 0)
    panic("sleep without lk");

  // Acquire ptable.lock in order to change p->state and then call sched.
  if(lk != &ptable.lock){
    acquire(&ptable.lock);
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){
    release(&ptable.lock);
    acquire(lk);
  }
}

// Wake up all processes sleeping on chan. The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

// Debug dump
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s (tix=%d run=%u sleep=%u ready=%u)\n",
            p->pid, state, p->name, p->tickets, p->rtime, p->stime, p->retime);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
      cprintf("\n");
    }
  }
}

/* ---- Project syscalls ---- */

int
setpolicy(int policy)
{
  if(policy < 0 || policy > 2)
    return -1;
  scheduling_policy = policy;
  return 0;
}

int
settickets(int n)
{
  if(n < 1)
    return -1;
  acquire(&ptable.lock);
  struct proc *p = myproc();
  p->tickets = n;
  // original_tickets را ثابت نگه می‌داریم تا «مقدار اولیه» باقی بماند
  release(&ptable.lock);
  return 0;
}

int
getpinfo(struct pstat *ps)
{
  if(ps == 0)
    return -1;

  acquire(&ptable.lock);
  for(int i = 0; i < NPROC; i++){
    struct proc *p = &ptable.proc[i];
    ps->inuse[i]            = (p->state != UNUSED);
    ps->pid[i]              = p->pid;
    ps->tickets[i]          = p->tickets;
    ps->original_tickets[i] = p->original_tickets;
    ps->rtime[i]            = (int)p->rtime;
    ps->stime[i]            = (int)p->stime;
    ps->retime[i]           = (int)p->retime;
    ps->ctime[i]            = (int)p->ctime;
    ps->etime[i]            = (int)p->etime;
  }
  release(&ptable.lock);
  return 0;
}

