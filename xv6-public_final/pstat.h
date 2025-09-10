// pstat.h
// Process statistics returned by getpinfo() for scheduling projects
// Units for all times: clock ticks.

#ifndef XV6_PSTAT_H
#define XV6_PSTAT_H

#include "param.h"   // for NPROC

struct pstat {
  int inuse[NPROC];            // 1 if entry is active (process slot in use), else 0
  int pid[NPROC];              // PID (0 if not in use)
  int state[NPROC];            // enum procstate as int
  // Lottery fields
  int tickets[NPROC];          // current tickets
  int original_tickets[NPROC]; // tickets at creation

  // Accounting (ticks)
  int rtime[NPROC];            // total running time
  int stime[NPROC];            // total sleeping time
  int retime[NPROC];           // total ready (runnable but not running) time

  // Lifecycle (ticks since boot)
  int ctime[NPROC];            // creation time (when proc entered EMBRYO/RUNNABLE)
  int etime[NPROC];            // end time; 0 if not finished yet
    char name[NPROC][16];
};

#endif // XV6_PSTAT_H

