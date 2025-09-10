// sleeplock.h
#ifndef _SLEEPLOCK_H_
#define _SLEEPLOCK_H_

#include "spinlock.h"

struct sleeplock {
  uint locked;        // Is the lock held?
  struct spinlock lk; // spinlock protecting this sleep lock
  char *name;         // Name of lock
  int pid;            // Process holding lock
};

void initsleeplock(struct sleeplock *lk, char *name);
void acquiresleep(struct sleeplock *lk);
void releasesleep(struct sleeplock *lk);
int holdingsleep(struct sleeplock *lk);

#endif // _SLEEPLOCK_H_

