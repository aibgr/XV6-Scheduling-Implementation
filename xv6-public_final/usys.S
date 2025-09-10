# usys.S
# User-space syscall stubs.
# Each function loads the syscall number into %eax,
# triggers the software interrupt (int $T_SYSCALL),
# and returns to user code.

#include "syscall.h"
#include "traps.h"

#define SYSCALL(name) \
  .globl name;        \
  name:               \
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(pipe)
SYSCALL(read)
SYSCALL(kill)
SYSCALL(exec)
SYSCALL(fstat)
SYSCALL(chdir)
SYSCALL(dup)
SYSCALL(getpid)
SYSCALL(sbrk)
SYSCALL(sleep)
SYSCALL(uptime)
SYSCALL(open)
SYSCALL(write)
SYSCALL(mknod)
SYSCALL(unlink)
SYSCALL(link)
SYSCALL(mkdir)
SYSCALL(close)

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
SYSCALL(settickets)
SYSCALL(getpinfo)
SYSCALL(waitx)
SYSCALL(yield)
