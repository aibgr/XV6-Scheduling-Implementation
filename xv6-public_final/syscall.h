// syscall.h
// System call numbers (must match syscall table in syscall.c)

#ifndef XV6_SYSCALL_H
#define XV6_SYSCALL_H

/* ---- Standard syscalls ---- */
#define SYS_fork        1   // create process
#define SYS_exit        2   // terminate process
#define SYS_wait        3   // wait for child
#define SYS_pipe        4   // create pipe
#define SYS_read        5   // read from file
#define SYS_kill        6   // kill process
#define SYS_exec        7   // execute program
#define SYS_fstat       8   // get file status
#define SYS_chdir       9   // change directory
#define SYS_dup        10   // duplicate fd
#define SYS_getpid     11   // get process id
#define SYS_sbrk       12   // change data segment size
#define SYS_sleep      13   // sleep n ticks
#define SYS_uptime     14   // uptime in ticks
#define SYS_open       15   // open file
#define SYS_write      16   // write to file
#define SYS_mknod      17   // create device file
#define SYS_unlink     18   // unlink file
#define SYS_link       19   // link file
#define SYS_mkdir      20   // make directory
#define SYS_close      21   // close fd

/* ---- Extended syscalls (scheduling project) ---- */
#define SYS_setpolicy  22   // set scheduling policy
#define SYS_settickets 23   // set tickets for Lottery
#define SYS_getpinfo   24   // get process info (pstat)
#define SYS_waitx      25   // wait + return wtime/rtime
#define SYS_yield      26

#endif // XV6_SYSCALL_H

