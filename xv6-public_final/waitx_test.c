// waitx_test.c
#include "types.h"
#include "stat.h"
#include "user.h"

// کار CPUبر (یه کار نسبتا سنگین با yield دوره‌ای)
static void
busy(int loops)
{
  volatile unsigned long x = 0;
  for(int i = 0; i < loops; i++){
    x += i*i;
    if(i % 1000000 == 0) yield();  // برای منصفانه‌تر شدن
  }
}

int
main(int argc, char *argv[])
{
  int n = 1;
  if(argc > 1) n = atoi(argv[1]);   // تعداد بچه‌ها (پیش‌فرض 1)

  if(n <= 1){
    // حالت ساده: فقط یک بچه
    int pid = fork();
    if(pid == 0){
      busy(20000000);
      exit();
    } else {
      int w=0, r=0;
      int ret = waitx(&w,&r);
      printf(1, "child %d finished -> rtime=%d, wtime=%d, turnaround=%d\n",
             ret, r, w, r+w);
    }
  } else {
    // حالت چندبچه‌ای: برای تست واقعی scheduling
    int total_w=0, total_r=0;
    for(int c=0; c<n; c++){
      int pid = fork();
      if(pid == 0){
        if(c % 2 == 0) sleep(20);  // بعضی‌ها تاخیر
        busy(10000000 + c*5000000);
        exit();
      }
    }

    for(int i=0; i<n; i++){
      int w=0, r=0;
      int pid = waitx(&w,&r);
      printf(1, "child %d -> rtime=%d, wtime=%d, turnaround=%d\n",
             pid, r, w, r+w);
      total_w += w;
      total_r += r;
    }
    printf(1, "avg wtime=%d, avg rtime=%d\n", total_w/n, total_r/n);
  }

  exit();
}

