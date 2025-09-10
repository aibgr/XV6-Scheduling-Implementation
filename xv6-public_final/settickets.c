#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  if(argc != 2){
    printf(1, "usage: settickets N\n");
    exit();
  }

  int n = atoi(argv[1]);
  if(settickets(n) < 0)
    printf(1, "settickets failed\n");

  exit();
}

