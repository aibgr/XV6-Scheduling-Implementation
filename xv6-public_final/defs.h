#ifndef XV6_DEFS_H
#define XV6_DEFS_H
// defs.h
// Kernel-wide function declarations. Keep this file small.

struct buf;
struct context;
struct file;
struct inode;
struct pipe;
struct proc;
struct spinlock;
struct stat;
struct superblock;
struct pstat;  // for scheduling project
struct cpu;    // forward declaration for mycpu()

// bio.c
void            binit(void);
struct buf*     bread(uint, uint);
void            brelse(struct buf*);
void            bwrite(struct buf*);

// console.c
void            consoleinit(void);
void            cprintf(char*, ...);
void            consoleintr(int(*)(void));
void            panic(char*) __attribute__((noreturn));

// exec.c
int             exec(char*, char**);

// file.c
struct file*    filealloc(void);
void            fileclose(struct file*);
struct file*    filedup(struct file*);
void            fileinit(void);
int             fileread(struct file*, char*, int n);
int             filestat(struct file*, struct stat*);
int             filewrite(struct file*, char*, int n);

// fs.c
void            readsb(int dev, struct superblock *sb);
int             dirlink(struct inode*, char*, uint);
struct inode*   dirlookup(struct inode*, char*, uint*);
struct inode*   ialloc(uint, short);
struct inode*   idup(struct inode*);
void            iinit(int dev);
void            ilock(struct inode*);
void            iput(struct inode*);
void            iunlock(struct inode*);
void            iunlockput(struct inode*);
void            iupdate(struct inode*);
int             namecmp(const char*, const char*);
struct inode*   namei(char*);
struct inode*   nameiparent(char*, char*);
int             readi(struct inode*, char*, uint, uint);
void            stati(struct inode*, struct stat*);
int             writei(struct inode*, char*, uint, uint);

// ide.c
void            ideinit(void);
void            ideintr(void);
void            iderw(struct buf*);

// ioapic.c
void            ioapicenable(int irq, int cpu);
void            ioapicinit(void);

// kalloc.c
char*           kalloc(void);
void            kfree(char*);
void            kinit1(void*, void*);
void            kinit2(void*, void*);

// kbd.c
void            kbdintr(void);

// lapic.c
int             cpunum(void);
int             lapicid(void);
void            lapiceoi(void);
void            lapicinit(void);
void            lapicstartap(uchar, uint);
void            microdelay(int);

// log.c
void            initlog(int dev);
void            log_write(struct buf*);
void            begin_op(void);
void            end_op(void);

// mp.c
extern int      ismp;
void            mpinit(void);

// picirq.c
void            picenable(int);
void            picinit(void);

// pipe.c
int             pipealloc(struct file**, struct file**);
void            pipeclose(struct pipe*, int);
int             piperead(struct pipe*, char*, int);
int             pipewrite(struct pipe*, char*, int);

// proc.c
int             cpuid(void);
struct cpu*     mycpu(void);
struct proc*    myproc(void);
void            pinit(void);
void            scheduler(void);
void            sched(void);
void            yield(void);
void            forkret(void);
void            exit(void) __attribute__((noreturn));
int             wait(void);
int             waitx(int *wtime, int *rtime);   // NEW
int             growproc(int);
int             fork(void);
int             kill(int);
int             curpolicy(void);

// struct proc* allocproc(void);  // DO NOT expose; it's static in proc.c
void            wakeup(void*);
void            sleep(void*, struct spinlock*);
int             settickets(int number);          // NEW
int             setpolicy(int policy);           // NEW
int             getpinfo(struct pstat *ps);      // NEW
void            procdump(void);
void            userinit(void);

// swtch.S
void            swtch(struct context**, struct context*);

// spinlock.c
void            acquire(struct spinlock*);
void            getcallerpcs(void*, uint*);
int             holding(struct spinlock*);
void            initlock(struct spinlock*, char*);
void            release(struct spinlock*);
void            pushcli(void);
void            popcli(void);

// string.c
int             memcmp(const void*, const void*, uint);
void*           memmove(void*, const void*, uint);
void*           memset(void*, int, uint);
char*           safestrcpy(char*, const char*, int);
int             strlen(const char*);
int             strncmp(const char*, const char*, uint);  // fixed
char*           strncpy(char*, const char*, int);

// syscall.c
int             argint(int, int*);
int             argptr(int, char**, int);  // fixed
int             argstr(int, char**);
int             fetchint(uint, int*);
int             fetchstr(uint, char**);
void            syscall(void);

// timer.c
void            timerinit(void);

// trap.c
void            idtinit(void);
extern uint     ticks;
void            tvinit(void);
extern struct spinlock tickslock;

// uart.c
void            uartinit(void);
void            uartintr(void);
void            uartputc(int);

// vm.c
void            seginit(void);
void            kvmalloc(void);
void            vmenable(void);
void            switchkvm(void);
void            switchuvm(struct proc*);
int             copyout(pde_t*, uint, void*, uint);
pde_t*          copyuvm(pde_t*, uint);
void            freevm(pde_t*);
void            inituvm(pde_t*, char*, uint);
int             loaduvm(pde_t*, char*, struct inode*, uint, uint);
pde_t*          setupkvm(void);
char*           uva2ka(pde_t*, char*);
int             allocuvm(pde_t*, uint, uint);
int             deallocuvm(pde_t*, uint, uint);
void            clearpteu(pde_t *pgdir, char *uva);

// sysfile.c
int             sys_chdir(void);
int             sys_close(void);
int             sys_dup(void);
int             sys_exec(void);
int             sys_exit(void);
int             sys_fork(void);
int             sys_fstat(void);
int             sys_getpid(void);
int             sys_kill(void);
int             sys_link(void);
int             sys_mkdir(void);
int             sys_mknod(void);
int             sys_open(void);
int             sys_pipe(void);
int             sys_read(void);
int             sys_sbrk(void);
int             sys_sleep(void);
int             sys_unlink(void);
int             sys_wait(void);
int             sys_write(void);
int             sys_uptime(void);
int             sys_setpolicy(void);    // NEW
int             sys_settickets(void);   // NEW
int             sys_getpinfo(void);     // NEW
int             sys_waitx(void);        // NEW

#endif // XV6_DEFS_H

