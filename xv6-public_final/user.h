// user.h — User-space API for xv6 + scheduling project extensions
#ifndef _USER_H_
#define _USER_H_

#include "types.h"   // for uint and basic integer typedefs

struct stat;
struct rtcdate;
struct pstat;        // forward-declare; users include "pstat.h" when accessing fields

/* ---------- System calls ---------- */
int   fork(void);
int   wait(void);
int   pipe(int*);
int   write(int, const void*, int);
int   read(int, void*, int);
int   close(int);
int   kill(int);
int   exec(char*, char**);
int   open(const char*, int);
int   mknod(const char*, short, short);
int   unlink(const char*);
int   fstat(int fd, struct stat*);
int   link(const char*, const char*);
int   mkdir(const char*);
int   chdir(const char*);
int   dup(int);
int   getpid(void);
char* sbrk(int);
int   sleep(int);
int   uptime(void);
int yield(void); 
int   exit(void) __attribute__((noreturn));

/* ---------- Extended syscalls (scheduling project) ---------- */
int   setpolicy(int policy);              // 0=RR, 1=FCFS, 2=LOTTERY
int   settickets(int tickets);            // per-process lottery tickets
int   getpinfo(struct pstat *ps);         // fill scheduling/accounting info
int   waitx(int *wtime, int *rtime);      // wait + return wait/run times

/* ---------- ulib.c (userland library) ---------- */
int    stat(const char*, struct stat*);
char*  strcpy(char*, const char*);
void*  memmove(void*, const void*, int);
char*  strchr(const char*, char);
int    strcmp(const char*, const char*);
void   printf(int, const char*, ...);
char*  gets(char*, int max);
uint   strlen(const char*);
void*  memset(void*, int, uint);
void*  malloc(uint);
void   free(void*);
int    atoi(const char*);

#endif // _USER_H_

