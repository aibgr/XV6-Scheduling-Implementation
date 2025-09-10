// spinlock.c
#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

// یک مموری-بریر برای جلوگیری از reorder
#define mb() __sync_synchronize()

// Initialize a spinlock.
void
initlock(struct spinlock *lk, char *name)
{
  lk->name   = name;
  lk->locked = 0;
  lk->cpu    = 0;
#ifdef DEBUG
  for(int i = 0; i < 10; i++) lk->pcs[i] = 0;
#endif
}

// Disable interrupts and remember the nesting depth.
void
pushcli(void)
{
  int eflags = readeflags();
  cli();
  if(mycpu()->ncli++ == 0)
    mycpu()->intena = (eflags & FL_IF) != 0;
}

// Pop one level; re-enable interrupts if this is the outermost level.
void
popcli(void)
{
  if(readeflags() & FL_IF)
    panic("popcli - interruptible");

  struct cpu *c = mycpu();
  if(--c->ncli < 0)
    panic("popcli");

  if(c->ncli == 0 && c->intena)
    sti();
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lk)
{
  int r;
  pushcli();
  r = (lk->locked && lk->cpu == mycpu());
  popcli();
  return r;
}

// Acquire the lock.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
    ;

  // Memory barrier so later loads/stores don't move before lock.
  mb();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}

// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

#ifdef DEBUG
  for(int i = 0; i < 10; i++) lk->pcs[i] = 0;
#else
  lk->pcs[0] = 0;
#endif
  lk->cpu = 0;

  // Memory barrier so prior writes are visible before unlock.
  mb();

  // The xchg is atomic.
  xchg(&lk->locked, 0);

  popcli();
}

// Fill pcs[] with the program counters of the callers.
// pcs[0] is the caller of getcallerpcs, pcs[1] the caller's caller, etc.
void
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  // با فرض نگه‌داری فریم‌پوینتر (gcc با -fno-omit-frame-pointer)
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];       // saved %eip
    ebp = (uint*)ebp[0];   // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}

