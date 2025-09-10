// pinfo.c
#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"

static const char* stname(int s){
  switch(s){
    case 0: return "UNUSED";
    case 1: return "EMBRYO";
    case 2: return "SLEEP ";
    case 3: return "RUNNBL";
    case 4: return "RUN   ";
    case 5: return "ZOMBIE";
    default:return "UNK   ";
  }
}

int
main(void)
{
  struct pstat ps;
  if(getpinfo(&ps) < 0){
    printf(1, "pinfo: getpinfo failed\n");
    exit();
  }
  printf(1, "PID   STATE   TICKETS ORIG  R   S   Q   CT   ET   NAME\n");
  for(int i=0;i<NPROC;i++){
    if(!ps.inuse[i]) continue;
    printf(1, "%-5d %-6s  %-7d %-5d %-3d %-3d %-3d %-4d %-4d %s\n",
      ps.pid[i], stname(ps.state[i]),
      ps.tickets[i], ps.original_tickets[i],
      ps.rtime[i], ps.stime[i], ps.retime[i],
      ps.ctime[i], ps.etime[i], ps.name[i]);
  }
  exit();
}

