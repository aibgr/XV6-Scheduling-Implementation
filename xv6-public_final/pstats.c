#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"

int
main(void)
{
  struct pstat ps;

  if(getpinfo(&ps) < 0){
    printf(1, "getpinfo failed\n");
    exit();
  }

  printf(1, "PID\tTickets\tRtime\tRetime\tStime\n");
  for(int i = 0; i < NPROC; i++){
    if(ps.inuse[i]){
      printf(1, "%d\t%d\t%d\t%d\t%d\n",
             ps.pid[i],
             ps.tickets[i],
             ps.rtime[i],
             ps.retime[i],
             ps.stime[i]);
    }
  }

  exit();
}

