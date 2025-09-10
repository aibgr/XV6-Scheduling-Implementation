#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[];  // in vectors.S: array of 256 entry pointers

struct spinlock tickslock;
uint ticks;

/*
 * دسترسی به policy جاری:
 * - برای اینکه trap.c بدونه الان کدوم scheduler فعاله (FCFS یا غیر FCFS)
 * - implement شدن curpolicy() در proc.c (یا میتونی از یک extern int scheduling_policy استفاده کنی)
 */
extern int curpolicy(void);

/*
 * ptable در proc.c تعریف شده (شکلِ یکسان باید در proc.c وجود داشته باشه).
 * این extern به ما اجازه میده جدول پروسه‌ها رو ببینیم (برای حسابداری زمان).
 */
extern struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

void
tvinit(void)
{
  int i;
  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  lidt(idt, sizeof(idt));
}

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  struct proc *p = myproc();  // ممکن است NULL باشد

  if(tf->trapno == T_SYSCALL){
    if(p && p->killed)
      exit();
    if(p)
      p->tf = tf;
    syscall();
    if(p && p->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    /* Update global ticks only on CPU 0 (like original xv6). */
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);

      /* حسابداری زمان‌ها برای همه پروسه‌ها.
         این کار زیر قفل ptable انجام می‌شود تا حالت‌ها ثابت باشند. */
      acquire(&ptable.lock);
      for(struct proc *q = ptable.proc; q < &ptable.proc[NPROC]; q++){
        switch(q->state){
        case RUNNING:
          q->rtime++;
          break;
        case RUNNABLE:
          q->retime++;
          break;
        case SLEEPING:
          q->stime++;
          break;
        default:
          break;
        }
      }
      release(&ptable.lock);
    }
    lapiceoi();
    break;

  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;

  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;

  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;

  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
    break;

  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
    break;

  default:
    if(p == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "eip 0x%x addr 0x%x--kill proc\n",
            p->pid, p->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    p->killed = 1;
  }

  // Force process exit if it has been killed and is in user space.
  if(p && p->killed && (tf->cs&3) == DPL_USER)
    exit();

  /*
   * پیش‌دِ‌امپت: وقتی timer interrupt رخ داد و پردازه در حال اجرای user-space است،
   * و policy فعلیِ scheduler اجازهٔ preemption می‌دهد (یعنی FCFS نیست) -> yield.
   *
   * گارد‌ها:
   *  - p وجود دارد
   *  - p در وضعیت RUNNING است
   *  - تله از نوع timer است
   *  - curpolicy() != 1  (1 = FCFS => غیرقابل‌پیش‌دستی)
   *
   * توجه: yield() خودش ptable.lock را می‌گیرد. در اینجا ما قفل‌ها را آزاد کرده‌ایم.
   */
  if(p && p->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER){
    if(curpolicy() != 1) {
      yield();
    }
  }

  // ممکن است بعد از yield یا syscall پردازه کشته شده باشد.
  if(p && p->killed && (tf->cs&3) == DPL_USER)
    exit();
}

