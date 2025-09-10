// lotto.c
#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"

static void cpu_bound(int loops){
  volatile int z=0;
  for(int i=0;i<loops;i++){
    for(int j=0;j<200000;j++) z += j;
    if((i % 3)==0) yield();
  }
}

int
main(void)
{
  if(setpolicy(2) < 0){ // 2 = LOTTERY
    printf(1, "lotto: setpolicy failed\n");
    exit();
  }

  int pids[3];
  int tix[3] = {10, 20, 40};

  for(int k=0;k<3;k++){
    int pid = fork();
    if(pid < 0){
      printf(1, "lotto: fork failed\n");
      exit();
    }
    if(pid == 0){
      settickets(tix[k]);
      cpu_bound(30);   // مشغول CPU
      exit();
    }
    pids[k] = pid;
  }

  // کمی صبر کن، سپس pinfo بگیر
  sleep(200);

  struct pstat ps;
  if(getpinfo(&ps) == 0){
    int rtime[3] = {0,0,0};
    for(int i=0;i<NPROC;i++){
      for(int k=0;k<3;k++){
        if(ps.inuse[i] && ps.pid[i] == pids[k]){
          rtime[k] = ps.rtime[i];
        }
      }
    }
    printf(1, "tickets vs rtime (approx proportional):\n");
    for(int k=0;k<3;k++)
      printf(1, "pid=%d tickets=%d rtime=%d\n", pids[k], tix[k], rtime[k]);
  } else {
    printf(1, "lotto: getpinfo failed\n");
  }

  // صبر برای اتمام بچه‌ها
  for(int k=0;k<3;k++){
    int w=0, r=0;
    waitx(&w,&r);
  }
  // برگرد به RR
  setpolicy(0);
  exit();
}

