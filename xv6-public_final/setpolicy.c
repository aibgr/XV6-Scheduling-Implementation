#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  if(argc != 2){
    printf(1, "usage: setpolicy {0|1|2}\n");
    exit();
  }

  int pol = atoi(argv[1]);
  if(setpolicy(pol) < 0)
    printf(1, "setpolicy failed\n");

  exit();
}

