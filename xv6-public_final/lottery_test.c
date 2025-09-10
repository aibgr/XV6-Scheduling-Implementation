\
#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"

static void spin(){
  volatile unsigned long x = 0;
  for(;;) x++;
}

int
main(void)
{
  setpolicy(2);
  int pids[3];
  int tix[3] = {10, 20, 40};

  for(int i = 0; i < 3; i++){
    int pid = fork();
    if(pid == 0){
      settickets(tix[i]);
      spin();
      exit();
    }
    pids[i] = pid;
  }

  sleep(500);

  struct pstat ps;
  if(getpinfo(&ps) == 0){
    for(int i = 0; i < NPROC; i++){
      for(int j = 0; j < 3; j++){
        if(ps.inuse[i] && ps.pid[i] == pids[j]){
          printf(1, "pid %d tickets=%d rtime=%d retime=%d stime=%d\n", ps.pid[i], ps.tickets[i], ps.rtime[i], ps.retime[i], ps.stime[i]);
        }
      }
    }
  }

  for(int i = 0; i < 3; i++) kill(pids[i]);
  while(wait() > 0);
  printf(1, "Lottery test done\n");
  exit();
}
