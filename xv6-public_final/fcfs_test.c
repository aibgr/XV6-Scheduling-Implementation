// fcfs_test.c
#include "types.h"
#include "stat.h"
#include "user.h"

static void burn(int ms)
{
  volatile int z=0;
  for(int t=0;t<ms;t++){
    for(int i=0;i<1000000;i++) z += i;
    // FCFS نباید preempt شود، yield نزنیم
  }
}

int
main(void)
{
  if(setpolicy(1) < 0){ // 1 = FCFS
    printf(1, "fcfs: setpolicy failed\n");
    exit();
  }

  int order[3];
  int idx=0;

  int a = fork();
  if(a == 0){ burn(15); exit(); }

  sleep(10); // تاخیر ایجاد کنیم (B بعد از A بیاد)
  int b = fork();
  if(b == 0){ burn(15); exit(); }

  sleep(10); // C بعد از B
  int c = fork();
  if(c == 0){ burn(15); exit(); }

  for(int i=0;i<3;i++){
    int w=0,r=0;
    int p = waitx(&w,&r);
    order[idx++] = p;
  }

  printf(1, "FCFS completion order: %d -> %d -> %d (expected: A:%d, B:%d, C:%d)\n",
         order[0], order[1], order[2], a,b,c);

  // بازگشت به RR
  setpolicy(0);
  exit();
}

