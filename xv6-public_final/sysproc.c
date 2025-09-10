// sysproc.c
#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "pstat.h"   


int settickets(int n);
int setpolicy(int policy);
int getpinfo(struct pstat *ps);
int waitx(int *wtime, int *rtime);

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;
  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr, n;
  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)  // n را بگیر
    return -1;
  if(n < 0)              // گارد منفی‌بودن
    return -1;

  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < (uint)n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// tickets from start
int
sys_uptime(void)
{
  uint xticks;
  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

/* ===== syscalls افزوده‌شده به زمان‌بند ===== */

int
sys_settickets(void)
{
  int n;
  if(argint(0, &n) < 0)
    return -1;
  if(n <= 0)            // گارد مقدار نامعتبر
    return -1;
  return settickets(n);
}

int
sys_setpolicy(void)
{
  int p;
  if(argint(0, &p) < 0)
    return -1;
  // گارد: فقط سیاست‌های شناخته‌شده  (مثلاً 0=RR, 1=LBS, 2=PBS)
  if(p < 0 || p > 2)
    return -1;
  return setpolicy(p);
}

int
sys_getpinfo(void)
{
  struct pstat *ps;
  if(argptr(0, (void*)&ps, sizeof(*ps)) < 0) // اعتبارسنجی و طول صحیح
    return -1;
  if(ps == 0)  // گارد Null
    return -1;
  return getpinfo(ps);
}

int
sys_waitx(void)
{
  int *w, *r;
  if(argptr(0, (void*)&w, sizeof(*w)) < 0 || w == 0)
    return -1;
  if(argptr(1, (void*)&r, sizeof(*r)) < 0 || r == 0)
    return -1;
  return waitx(w, r);
}


int
sys_yield(void)
{
  yield();
  return 0;
}

