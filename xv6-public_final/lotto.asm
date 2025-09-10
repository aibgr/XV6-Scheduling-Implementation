
_lotto:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec 54 0e 00 00    	sub    $0xe54,%esp
  if(setpolicy(2) < 0){ // 2 = LOTTERY
  17:	6a 02                	push   $0x2
  19:	e8 7c 05 00 00       	call   59a <setpolicy>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 a9 01 00 00    	js     1d2 <main+0x1d2>
    printf(1, "lotto: setpolicy failed\n");
    exit();
  }

  int pids[3];
  int tix[3] = {10, 20, 40};
  29:	c7 85 d0 f1 ff ff 0a 	movl   $0xa,-0xe30(%ebp)
  30:	00 00 00 

  for(int k=0;k<3;k++){
  33:	31 f6                	xor    %esi,%esi
  int tix[3] = {10, 20, 40};
  35:	c7 85 d4 f1 ff ff 14 	movl   $0x14,-0xe2c(%ebp)
  3c:	00 00 00 
  3f:	c7 85 d8 f1 ff ff 28 	movl   $0x28,-0xe28(%ebp)
  46:	00 00 00 
    int pid = fork();
  49:	e8 a4 04 00 00       	call   4f2 <fork>
    if(pid < 0){
  4e:	85 c0                	test   %eax,%eax
  50:	0f 88 ff 01 00 00    	js     255 <main+0x255>
      printf(1, "lotto: fork failed\n");
      exit();
    }
    if(pid == 0){
  56:	0f 84 89 01 00 00    	je     1e5 <main+0x1e5>
      settickets(tix[k]);
      cpu_bound(30);   // مشغول CPU
      exit();
    }
    pids[k] = pid;
  5c:	8d 9d c4 f1 ff ff    	lea    -0xe3c(%ebp),%ebx
  62:	89 04 b3             	mov    %eax,(%ebx,%esi,4)
  for(int k=0;k<3;k++){
  65:	83 c6 01             	add    $0x1,%esi
  68:	83 fe 03             	cmp    $0x3,%esi
  6b:	75 dc                	jne    49 <main+0x49>
  }

  // کمی صبر کن، سپس pinfo بگیر
  sleep(200);
  6d:	83 ec 0c             	sub    $0xc,%esp

  struct pstat ps;
  if(getpinfo(&ps) == 0){
  70:	8d b5 e8 f1 ff ff    	lea    -0xe18(%ebp),%esi
  sleep(200);
  76:	68 c8 00 00 00       	push   $0xc8
  7b:	e8 d2 04 00 00       	call   552 <sleep>
  if(getpinfo(&ps) == 0){
  80:	89 34 24             	mov    %esi,(%esp)
  83:	e8 22 05 00 00       	call   5aa <getpinfo>
  88:	83 c4 10             	add    $0x10,%esp
  8b:	85 c0                	test   %eax,%eax
  8d:	0f 85 ec 00 00 00    	jne    17f <main+0x17f>
    int rtime[3] = {0,0,0};
  93:	89 85 b4 f1 ff ff    	mov    %eax,-0xe4c(%ebp)
  99:	31 ff                	xor    %edi,%edi
  9b:	89 f2                	mov    %esi,%edx
  9d:	89 bd dc f1 ff ff    	mov    %edi,-0xe24(%ebp)
  a3:	89 bd e0 f1 ff ff    	mov    %edi,-0xe20(%ebp)
  a9:	89 bd e4 f1 ff ff    	mov    %edi,-0xe1c(%ebp)
    for(int i=0;i<NPROC;i++){
  af:	8d bd dc f1 ff ff    	lea    -0xe24(%ebp),%edi
  b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  bc:	00 
  bd:	8d 76 00             	lea    0x0(%esi),%esi
      for(int k=0;k<3;k++){
        if(ps.inuse[i] && ps.pid[i] == pids[k]){
  c0:	8b 0a                	mov    (%edx),%ecx
      for(int k=0;k<3;k++){
  c2:	31 c0                	xor    %eax,%eax
        if(ps.inuse[i] && ps.pid[i] == pids[k]){
  c4:	85 c9                	test   %ecx,%ecx
  c6:	0f 85 d4 00 00 00    	jne    1a0 <main+0x1a0>
      for(int k=0;k<3;k++){
  cc:	83 c0 01             	add    $0x1,%eax
  cf:	83 f8 03             	cmp    $0x3,%eax
  d2:	75 f8                	jne    cc <main+0xcc>
    for(int i=0;i<NPROC;i++){
  d4:	83 c2 04             	add    $0x4,%edx
  d7:	8d 85 e8 f2 ff ff    	lea    -0xd18(%ebp),%eax
  dd:	39 d0                	cmp    %edx,%eax
  df:	75 df                	jne    c0 <main+0xc0>
          rtime[k] = ps.rtime[i];
        }
      }
    }
    printf(1, "tickets vs rtime (approx proportional):\n");
  e1:	52                   	push   %edx
  e2:	8b 8d b4 f1 ff ff    	mov    -0xe4c(%ebp),%ecx
  e8:	8d b5 d0 f1 ff ff    	lea    -0xe30(%ebp),%esi
  ee:	52                   	push   %edx
  ef:	68 70 0a 00 00       	push   $0xa70
  f4:	6a 01                	push   $0x1
  f6:	89 8d b0 f1 ff ff    	mov    %ecx,-0xe50(%ebp)
  fc:	e8 9f 05 00 00       	call   6a0 <printf>
 101:	83 c4 10             	add    $0x10,%esp
 104:	89 bd b4 f1 ff ff    	mov    %edi,-0xe4c(%ebp)
 10a:	8b bd b0 f1 ff ff    	mov    -0xe50(%ebp),%edi
    for(int k=0;k<3;k++)
      printf(1, "pid=%d tickets=%d rtime=%d\n", pids[k], tix[k], rtime[k]);
 110:	8b 85 b4 f1 ff ff    	mov    -0xe4c(%ebp),%eax
 116:	83 ec 0c             	sub    $0xc,%esp
 119:	ff 34 b8             	push   (%eax,%edi,4)
 11c:	ff 34 be             	push   (%esi,%edi,4)
 11f:	ff 34 bb             	push   (%ebx,%edi,4)
    for(int k=0;k<3;k++)
 122:	83 c7 01             	add    $0x1,%edi
      printf(1, "pid=%d tickets=%d rtime=%d\n", pids[k], tix[k], rtime[k]);
 125:	68 35 0a 00 00       	push   $0xa35
 12a:	6a 01                	push   $0x1
 12c:	e8 6f 05 00 00       	call   6a0 <printf>
    for(int k=0;k<3;k++)
 131:	83 c4 20             	add    $0x20,%esp
 134:	83 ff 03             	cmp    $0x3,%edi
 137:	75 d7                	jne    110 <main+0x110>
 139:	8b bd b4 f1 ff ff    	mov    -0xe4c(%ebp),%edi
      for(int k=0;k<3;k++){
 13f:	bb 03 00 00 00       	mov    $0x3,%ebx
 144:	8d b5 c0 f1 ff ff    	lea    -0xe40(%ebp),%esi
    printf(1, "lotto: getpinfo failed\n");
  }

  // صبر برای اتمام بچه‌ها
  for(int k=0;k<3;k++){
    int w=0, r=0;
 14a:	c7 85 c0 f1 ff ff 00 	movl   $0x0,-0xe40(%ebp)
 151:	00 00 00 
    waitx(&w,&r);
 154:	83 ec 08             	sub    $0x8,%esp
 157:	57                   	push   %edi
 158:	56                   	push   %esi
    int w=0, r=0;
 159:	c7 85 dc f1 ff ff 00 	movl   $0x0,-0xe24(%ebp)
 160:	00 00 00 
    waitx(&w,&r);
 163:	e8 4a 04 00 00       	call   5b2 <waitx>
  for(int k=0;k<3;k++){
 168:	83 c4 10             	add    $0x10,%esp
 16b:	83 eb 01             	sub    $0x1,%ebx
 16e:	75 da                	jne    14a <main+0x14a>
  }
  // برگرد به RR
  setpolicy(0);
 170:	83 ec 0c             	sub    $0xc,%esp
 173:	6a 00                	push   $0x0
 175:	e8 20 04 00 00       	call   59a <setpolicy>
  exit();
 17a:	e8 7b 03 00 00       	call   4fa <exit>
    printf(1, "lotto: getpinfo failed\n");
 17f:	50                   	push   %eax
 180:	8d bd dc f1 ff ff    	lea    -0xe24(%ebp),%edi
 186:	50                   	push   %eax
 187:	68 51 0a 00 00       	push   $0xa51
 18c:	6a 01                	push   $0x1
 18e:	e8 0d 05 00 00       	call   6a0 <printf>
 193:	83 c4 10             	add    $0x10,%esp
 196:	eb a7                	jmp    13f <main+0x13f>
 198:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19f:	00 
 1a0:	8b 8a 00 01 00 00    	mov    0x100(%edx),%ecx
        if(ps.inuse[i] && ps.pid[i] == pids[k]){
 1a6:	3b 0c 83             	cmp    (%ebx,%eax,4),%ecx
 1a9:	75 09                	jne    1b4 <main+0x1b4>
          rtime[k] = ps.rtime[i];
 1ab:	8b b2 00 05 00 00    	mov    0x500(%edx),%esi
 1b1:	89 34 87             	mov    %esi,(%edi,%eax,4)
      for(int k=0;k<3;k++){
 1b4:	83 c0 01             	add    $0x1,%eax
 1b7:	83 f8 03             	cmp    $0x3,%eax
 1ba:	75 ea                	jne    1a6 <main+0x1a6>
    for(int i=0;i<NPROC;i++){
 1bc:	83 c2 04             	add    $0x4,%edx
 1bf:	8d 85 e8 f2 ff ff    	lea    -0xd18(%ebp),%eax
 1c5:	39 d0                	cmp    %edx,%eax
 1c7:	0f 85 f3 fe ff ff    	jne    c0 <main+0xc0>
 1cd:	e9 0f ff ff ff       	jmp    e1 <main+0xe1>
    printf(1, "lotto: setpolicy failed\n");
 1d2:	50                   	push   %eax
 1d3:	50                   	push   %eax
 1d4:	68 08 0a 00 00       	push   $0xa08
 1d9:	6a 01                	push   $0x1
 1db:	e8 c0 04 00 00       	call   6a0 <printf>
    exit();
 1e0:	e8 15 03 00 00       	call   4fa <exit>
      settickets(tix[k]);
 1e5:	83 ec 0c             	sub    $0xc,%esp
 1e8:	ff b4 b5 d0 f1 ff ff 	push   -0xe30(%ebp,%esi,4)
  for(int i=0;i<loops;i++){
 1ef:	31 db                	xor    %ebx,%ebx
 1f1:	be 03 00 00 00       	mov    $0x3,%esi
      settickets(tix[k]);
 1f6:	e8 a7 03 00 00       	call   5a2 <settickets>
  volatile int z=0;
 1fb:	31 c0                	xor    %eax,%eax
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	89 85 e8 f1 ff ff    	mov    %eax,-0xe18(%ebp)
    for(int j=0;j<200000;j++) z += j;
 206:	31 c0                	xor    %eax,%eax
 208:	eb 16                	jmp    220 <main+0x220>
 20a:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 211:	00 
 212:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 219:	00 
 21a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 220:	8b 95 e8 f1 ff ff    	mov    -0xe18(%ebp),%edx
 226:	01 c2                	add    %eax,%edx
 228:	83 c0 01             	add    $0x1,%eax
 22b:	89 95 e8 f1 ff ff    	mov    %edx,-0xe18(%ebp)
 231:	3d 40 0d 03 00       	cmp    $0x30d40,%eax
 236:	75 e8                	jne    220 <main+0x220>
    if((i % 3)==0) yield();
 238:	89 d8                	mov    %ebx,%eax
 23a:	99                   	cltd
 23b:	f7 fe                	idiv   %esi
 23d:	85 d2                	test   %edx,%edx
 23f:	74 0d                	je     24e <main+0x24e>
  for(int i=0;i<loops;i++){
 241:	83 c3 01             	add    $0x1,%ebx
 244:	83 fb 1e             	cmp    $0x1e,%ebx
 247:	75 bd                	jne    206 <main+0x206>
      exit();
 249:	e8 ac 02 00 00       	call   4fa <exit>
    if((i % 3)==0) yield();
 24e:	e8 67 03 00 00       	call   5ba <yield>
 253:	eb ec                	jmp    241 <main+0x241>
      printf(1, "lotto: fork failed\n");
 255:	50                   	push   %eax
 256:	50                   	push   %eax
 257:	68 21 0a 00 00       	push   $0xa21
 25c:	6a 01                	push   $0x1
 25e:	e8 3d 04 00 00       	call   6a0 <printf>
      exit();
 263:	e8 92 02 00 00       	call   4fa <exit>
 268:	66 90                	xchg   %ax,%ax
 26a:	66 90                	xchg   %ax,%ax
 26c:	66 90                	xchg   %ax,%ax
 26e:	66 90                	xchg   %ax,%ax
 270:	66 90                	xchg   %ax,%ax
 272:	66 90                	xchg   %ax,%ax
 274:	66 90                	xchg   %ax,%ax
 276:	66 90                	xchg   %ax,%ax
 278:	66 90                	xchg   %ax,%ax
 27a:	66 90                	xchg   %ax,%ax
 27c:	66 90                	xchg   %ax,%ax
 27e:	66 90                	xchg   %ax,%ax

00000280 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 280:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
 281:	31 c0                	xor    %eax,%eax
{
 283:	89 e5                	mov    %esp,%ebp
 285:	53                   	push   %ebx
 286:	8b 4d 08             	mov    0x8(%ebp),%ecx
 289:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
 290:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 294:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 297:	83 c0 01             	add    $0x1,%eax
 29a:	84 d2                	test   %dl,%dl
 29c:	75 f2                	jne    290 <strcpy+0x10>
  return os;
}
 29e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2a1:	89 c8                	mov    %ecx,%eax
 2a3:	c9                   	leave
 2a4:	c3                   	ret
 2a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ac:	00 
 2ad:	8d 76 00             	lea    0x0(%esi),%esi

000002b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
 2b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2ba:	0f b6 02             	movzbl (%edx),%eax
 2bd:	84 c0                	test   %al,%al
 2bf:	75 2f                	jne    2f0 <strcmp+0x40>
 2c1:	eb 4a                	jmp    30d <strcmp+0x5d>
 2c3:	eb 1b                	jmp    2e0 <strcmp+0x30>
 2c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2cc:	00 
 2cd:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2d4:	00 
 2d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2dc:	00 
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
 2e0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 2e4:	83 c2 01             	add    $0x1,%edx
 2e7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 2ea:	84 c0                	test   %al,%al
 2ec:	74 12                	je     300 <strcmp+0x50>
 2ee:	89 d9                	mov    %ebx,%ecx
 2f0:	0f b6 19             	movzbl (%ecx),%ebx
 2f3:	38 c3                	cmp    %al,%bl
 2f5:	74 e9                	je     2e0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 2f7:	29 d8                	sub    %ebx,%eax
}
 2f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2fc:	c9                   	leave
 2fd:	c3                   	ret
 2fe:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 300:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 304:	31 c0                	xor    %eax,%eax
 306:	29 d8                	sub    %ebx,%eax
}
 308:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 30b:	c9                   	leave
 30c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 30d:	0f b6 19             	movzbl (%ecx),%ebx
 310:	31 c0                	xor    %eax,%eax
 312:	eb e3                	jmp    2f7 <strcmp+0x47>
 314:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31b:	00 
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <strlen>:

uint
strlen(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 326:	80 3a 00             	cmpb   $0x0,(%edx)
 329:	74 15                	je     340 <strlen+0x20>
 32b:	31 c0                	xor    %eax,%eax
 32d:	8d 76 00             	lea    0x0(%esi),%esi
 330:	83 c0 01             	add    $0x1,%eax
 333:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 337:	89 c1                	mov    %eax,%ecx
 339:	75 f5                	jne    330 <strlen+0x10>
  return n;
}
 33b:	89 c8                	mov    %ecx,%eax
 33d:	5d                   	pop    %ebp
 33e:	c3                   	ret
 33f:	90                   	nop
  for(n = 0; s[n]; n++);
 340:	31 c9                	xor    %ecx,%ecx
}
 342:	5d                   	pop    %ebp
 343:	89 c8                	mov    %ecx,%eax
 345:	c3                   	ret
 346:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34d:	00 
 34e:	66 90                	xchg   %ax,%ax

00000350 <memset>:

void*
memset(void *dst, int c, uint n)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 357:	8b 4d 10             	mov    0x10(%ebp),%ecx
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	89 d7                	mov    %edx,%edi
 35f:	fc                   	cld
 360:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 362:	8b 7d fc             	mov    -0x4(%ebp),%edi
 365:	89 d0                	mov    %edx,%eax
 367:	c9                   	leave
 368:	c3                   	ret
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000370 <strchr>:

char*
strchr(const char *s, char c)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 45 08             	mov    0x8(%ebp),%eax
 376:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 37a:	0f b6 10             	movzbl (%eax),%edx
 37d:	84 d2                	test   %dl,%dl
 37f:	75 1a                	jne    39b <strchr+0x2b>
 381:	eb 25                	jmp    3a8 <strchr+0x38>
 383:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 38a:	00 
 38b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 390:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 394:	83 c0 01             	add    $0x1,%eax
 397:	84 d2                	test   %dl,%dl
 399:	74 0d                	je     3a8 <strchr+0x38>
    if(*s == c)
 39b:	38 d1                	cmp    %dl,%cl
 39d:	75 f1                	jne    390 <strchr+0x20>
      return (char*)s;
  return 0;
}
 39f:	5d                   	pop    %ebp
 3a0:	c3                   	ret
 3a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 3a8:	31 c0                	xor    %eax,%eax
}
 3aa:	5d                   	pop    %ebp
 3ab:	c3                   	ret
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003b0 <gets>:

char*
gets(char *buf, int max)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 3b5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 3b8:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 3b9:	31 db                	xor    %ebx,%ebx
{
 3bb:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 3be:	eb 27                	jmp    3e7 <gets+0x37>
    cc = read(0, &c, 1);
 3c0:	83 ec 04             	sub    $0x4,%esp
 3c3:	6a 01                	push   $0x1
 3c5:	56                   	push   %esi
 3c6:	6a 00                	push   $0x0
 3c8:	e8 45 01 00 00       	call   512 <read>
    if(cc < 1)
 3cd:	83 c4 10             	add    $0x10,%esp
 3d0:	85 c0                	test   %eax,%eax
 3d2:	7e 1d                	jle    3f1 <gets+0x41>
      break;
    buf[i++] = c;
 3d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3d8:	8b 55 08             	mov    0x8(%ebp),%edx
 3db:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3df:	3c 0a                	cmp    $0xa,%al
 3e1:	74 10                	je     3f3 <gets+0x43>
 3e3:	3c 0d                	cmp    $0xd,%al
 3e5:	74 0c                	je     3f3 <gets+0x43>
  for(i = 0; i+1 < max; ){
 3e7:	89 df                	mov    %ebx,%edi
 3e9:	83 c3 01             	add    $0x1,%ebx
 3ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3ef:	7c cf                	jl     3c0 <gets+0x10>
 3f1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
 3f6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 3fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3fd:	5b                   	pop    %ebx
 3fe:	5e                   	pop    %esi
 3ff:	5f                   	pop    %edi
 400:	5d                   	pop    %ebp
 401:	c3                   	ret
 402:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 409:	00 
 40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000410 <stat>:

int
stat(const char *n, struct stat *st)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 415:	83 ec 08             	sub    $0x8,%esp
 418:	6a 00                	push   $0x0
 41a:	ff 75 08             	push   0x8(%ebp)
 41d:	e8 40 01 00 00       	call   562 <open>
  if(fd < 0)
 422:	83 c4 10             	add    $0x10,%esp
 425:	85 c0                	test   %eax,%eax
 427:	78 27                	js     450 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 429:	83 ec 08             	sub    $0x8,%esp
 42c:	ff 75 0c             	push   0xc(%ebp)
 42f:	89 c3                	mov    %eax,%ebx
 431:	50                   	push   %eax
 432:	e8 f3 00 00 00       	call   52a <fstat>
  close(fd);
 437:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 43a:	89 c6                	mov    %eax,%esi
  close(fd);
 43c:	e8 51 01 00 00       	call   592 <close>
  return r;
 441:	83 c4 10             	add    $0x10,%esp
}
 444:	8d 65 f8             	lea    -0x8(%ebp),%esp
 447:	89 f0                	mov    %esi,%eax
 449:	5b                   	pop    %ebx
 44a:	5e                   	pop    %esi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret
 44d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 450:	be ff ff ff ff       	mov    $0xffffffff,%esi
 455:	eb ed                	jmp    444 <stat+0x34>
 457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45e:	00 
 45f:	90                   	nop

00000460 <atoi>:

int
atoi(const char *s)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	53                   	push   %ebx
 464:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 467:	0f be 02             	movsbl (%edx),%eax
 46a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 46d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 470:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 475:	77 1e                	ja     495 <atoi+0x35>
 477:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 47e:	00 
 47f:	90                   	nop
    n = n*10 + *s++ - '0';
 480:	83 c2 01             	add    $0x1,%edx
 483:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 486:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 48a:	0f be 02             	movsbl (%edx),%eax
 48d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 490:	80 fb 09             	cmp    $0x9,%bl
 493:	76 eb                	jbe    480 <atoi+0x20>
  return n;
}
 495:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 498:	89 c8                	mov    %ecx,%eax
 49a:	c9                   	leave
 49b:	c3                   	ret
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	8b 55 08             	mov    0x8(%ebp),%edx
 4a7:	8b 45 10             	mov    0x10(%ebp),%eax
 4aa:	56                   	push   %esi
 4ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 4ae:	39 f2                	cmp    %esi,%edx
 4b0:	73 1e                	jae    4d0 <memmove+0x30>
    while(n-- > 0)
 4b2:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 4b5:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 4b7:	85 c0                	test   %eax,%eax
 4b9:	7e 0a                	jle    4c5 <memmove+0x25>
 4bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 4c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 4c1:	39 f9                	cmp    %edi,%ecx
 4c3:	75 fb                	jne    4c0 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4c5:	5e                   	pop    %esi
 4c6:	89 d0                	mov    %edx,%eax
 4c8:	5f                   	pop    %edi
 4c9:	5d                   	pop    %ebp
 4ca:	c3                   	ret
 4cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 4d0:	85 c0                	test   %eax,%eax
 4d2:	7e f1                	jle    4c5 <memmove+0x25>
    while(n-- > 0)
 4d4:	83 e8 01             	sub    $0x1,%eax
 4d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4de:	00 
 4df:	90                   	nop
      *--dst = *--src;
 4e0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 4e4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 4e7:	83 e8 01             	sub    $0x1,%eax
 4ea:	73 f4                	jae    4e0 <memmove+0x40>
}
 4ec:	5e                   	pop    %esi
 4ed:	89 d0                	mov    %edx,%eax
 4ef:	5f                   	pop    %edi
 4f0:	5d                   	pop    %ebp
 4f1:	c3                   	ret

000004f2 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 4f2:	b8 01 00 00 00       	mov    $0x1,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret

000004fa <exit>:
SYSCALL(exit)
 4fa:	b8 02 00 00 00       	mov    $0x2,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret

00000502 <wait>:
SYSCALL(wait)
 502:	b8 03 00 00 00       	mov    $0x3,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret

0000050a <pipe>:
SYSCALL(pipe)
 50a:	b8 04 00 00 00       	mov    $0x4,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret

00000512 <read>:
SYSCALL(read)
 512:	b8 05 00 00 00       	mov    $0x5,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret

0000051a <kill>:
SYSCALL(kill)
 51a:	b8 06 00 00 00       	mov    $0x6,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret

00000522 <exec>:
SYSCALL(exec)
 522:	b8 07 00 00 00       	mov    $0x7,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret

0000052a <fstat>:
SYSCALL(fstat)
 52a:	b8 08 00 00 00       	mov    $0x8,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret

00000532 <chdir>:
SYSCALL(chdir)
 532:	b8 09 00 00 00       	mov    $0x9,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret

0000053a <dup>:
SYSCALL(dup)
 53a:	b8 0a 00 00 00       	mov    $0xa,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret

00000542 <getpid>:
SYSCALL(getpid)
 542:	b8 0b 00 00 00       	mov    $0xb,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret

0000054a <sbrk>:
SYSCALL(sbrk)
 54a:	b8 0c 00 00 00       	mov    $0xc,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret

00000552 <sleep>:
SYSCALL(sleep)
 552:	b8 0d 00 00 00       	mov    $0xd,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret

0000055a <uptime>:
SYSCALL(uptime)
 55a:	b8 0e 00 00 00       	mov    $0xe,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret

00000562 <open>:
SYSCALL(open)
 562:	b8 0f 00 00 00       	mov    $0xf,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret

0000056a <write>:
SYSCALL(write)
 56a:	b8 10 00 00 00       	mov    $0x10,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret

00000572 <mknod>:
SYSCALL(mknod)
 572:	b8 11 00 00 00       	mov    $0x11,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret

0000057a <unlink>:
SYSCALL(unlink)
 57a:	b8 12 00 00 00       	mov    $0x12,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret

00000582 <link>:
SYSCALL(link)
 582:	b8 13 00 00 00       	mov    $0x13,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret

0000058a <mkdir>:
SYSCALL(mkdir)
 58a:	b8 14 00 00 00       	mov    $0x14,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret

00000592 <close>:
SYSCALL(close)
 592:	b8 15 00 00 00       	mov    $0x15,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret

0000059a <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 59a:	b8 16 00 00 00       	mov    $0x16,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret

000005a2 <settickets>:
SYSCALL(settickets)
 5a2:	b8 17 00 00 00       	mov    $0x17,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret

000005aa <getpinfo>:
SYSCALL(getpinfo)
 5aa:	b8 18 00 00 00       	mov    $0x18,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret

000005b2 <waitx>:
SYSCALL(waitx)
 5b2:	b8 19 00 00 00       	mov    $0x19,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret

000005ba <yield>:
SYSCALL(yield)
 5ba:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret
 5c2:	66 90                	xchg   %ax,%ax
 5c4:	66 90                	xchg   %ax,%ax
 5c6:	66 90                	xchg   %ax,%ax
 5c8:	66 90                	xchg   %ax,%ax
 5ca:	66 90                	xchg   %ax,%ax
 5cc:	66 90                	xchg   %ax,%ax
 5ce:	66 90                	xchg   %ax,%ax
 5d0:	66 90                	xchg   %ax,%ax
 5d2:	66 90                	xchg   %ax,%ax
 5d4:	66 90                	xchg   %ax,%ax
 5d6:	66 90                	xchg   %ax,%ax
 5d8:	66 90                	xchg   %ax,%ax
 5da:	66 90                	xchg   %ax,%ax
 5dc:	66 90                	xchg   %ax,%ax
 5de:	66 90                	xchg   %ax,%ax

000005e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
 5e6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5e8:	89 d1                	mov    %edx,%ecx
{
 5ea:	83 ec 3c             	sub    $0x3c,%esp
 5ed:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 5f0:	85 d2                	test   %edx,%edx
 5f2:	0f 89 98 00 00 00    	jns    690 <printint+0xb0>
 5f8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 5fc:	0f 84 8e 00 00 00    	je     690 <printint+0xb0>
    x = -xx;
 602:	f7 d9                	neg    %ecx
    neg = 1;
 604:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 609:	89 45 c0             	mov    %eax,-0x40(%ebp)
 60c:	31 f6                	xor    %esi,%esi
 60e:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 615:	00 
 616:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 61d:	00 
 61e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 620:	89 c8                	mov    %ecx,%eax
 622:	31 d2                	xor    %edx,%edx
 624:	89 f7                	mov    %esi,%edi
 626:	f7 f3                	div    %ebx
 628:	8d 76 01             	lea    0x1(%esi),%esi
 62b:	0f b6 92 f4 0a 00 00 	movzbl 0xaf4(%edx),%edx
 632:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 636:	89 ca                	mov    %ecx,%edx
 638:	89 c1                	mov    %eax,%ecx
 63a:	39 da                	cmp    %ebx,%edx
 63c:	73 e2                	jae    620 <printint+0x40>
  if(neg)
 63e:	8b 45 c0             	mov    -0x40(%ebp),%eax
 641:	85 c0                	test   %eax,%eax
 643:	74 07                	je     64c <printint+0x6c>
    buf[i++] = '-';
 645:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 64a:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 64c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 64f:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 652:	01 df                	add    %ebx,%edi
 654:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 65b:	00 
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 660:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 663:	83 ec 04             	sub    $0x4,%esp
 666:	88 45 d7             	mov    %al,-0x29(%ebp)
 669:	8d 45 d7             	lea    -0x29(%ebp),%eax
 66c:	6a 01                	push   $0x1
 66e:	50                   	push   %eax
 66f:	56                   	push   %esi
 670:	e8 f5 fe ff ff       	call   56a <write>
  while(--i >= 0)
 675:	89 f8                	mov    %edi,%eax
 677:	83 c4 10             	add    $0x10,%esp
 67a:	83 ef 01             	sub    $0x1,%edi
 67d:	39 d8                	cmp    %ebx,%eax
 67f:	75 df                	jne    660 <printint+0x80>
}
 681:	8d 65 f4             	lea    -0xc(%ebp),%esp
 684:	5b                   	pop    %ebx
 685:	5e                   	pop    %esi
 686:	5f                   	pop    %edi
 687:	5d                   	pop    %ebp
 688:	c3                   	ret
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 690:	31 c0                	xor    %eax,%eax
 692:	e9 72 ff ff ff       	jmp    609 <printint+0x29>
 697:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 69e:	00 
 69f:	90                   	nop

000006a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 6ac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 6af:	0f b6 13             	movzbl (%ebx),%edx
 6b2:	83 c3 01             	add    $0x1,%ebx
 6b5:	84 d2                	test   %dl,%dl
 6b7:	0f 84 a0 00 00 00    	je     75d <printf+0xbd>
 6bd:	8d 45 10             	lea    0x10(%ebp),%eax
 6c0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 6c3:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6c6:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 6c9:	eb 28                	jmp    6f3 <printf+0x53>
 6cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6d0:	83 ec 04             	sub    $0x4,%esp
 6d3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6d6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 6d9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 6dc:	6a 01                	push   $0x1
 6de:	50                   	push   %eax
 6df:	56                   	push   %esi
 6e0:	e8 85 fe ff ff       	call   56a <write>
  for(i = 0; fmt[i]; i++){
 6e5:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6e9:	83 c4 10             	add    $0x10,%esp
 6ec:	84 d2                	test   %dl,%dl
 6ee:	74 6d                	je     75d <printf+0xbd>
    c = fmt[i] & 0xff;
 6f0:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 6f3:	83 f8 25             	cmp    $0x25,%eax
 6f6:	75 d8                	jne    6d0 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 6f8:	0f b6 13             	movzbl (%ebx),%edx
 6fb:	84 d2                	test   %dl,%dl
 6fd:	74 5e                	je     75d <printf+0xbd>
    c = fmt[i] & 0xff;
 6ff:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 702:	80 fa 25             	cmp    $0x25,%dl
 705:	0f 84 1d 01 00 00    	je     828 <printf+0x188>
 70b:	83 e8 63             	sub    $0x63,%eax
 70e:	83 f8 15             	cmp    $0x15,%eax
 711:	77 0d                	ja     720 <printf+0x80>
 713:	ff 24 85 9c 0a 00 00 	jmp    *0xa9c(,%eax,4)
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 720:	83 ec 04             	sub    $0x4,%esp
 723:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 726:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 729:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 72d:	6a 01                	push   $0x1
 72f:	51                   	push   %ecx
 730:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 733:	56                   	push   %esi
 734:	e8 31 fe ff ff       	call   56a <write>
        putc(fd, c);
 739:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 73d:	83 c4 0c             	add    $0xc,%esp
 740:	88 55 e7             	mov    %dl,-0x19(%ebp)
 743:	6a 01                	push   $0x1
 745:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 748:	51                   	push   %ecx
 749:	56                   	push   %esi
 74a:	e8 1b fe ff ff       	call   56a <write>
  for(i = 0; fmt[i]; i++){
 74f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 753:	83 c3 02             	add    $0x2,%ebx
 756:	83 c4 10             	add    $0x10,%esp
 759:	84 d2                	test   %dl,%dl
 75b:	75 93                	jne    6f0 <printf+0x50>
      }
      state = 0;
    }
  }
}
 75d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 760:	5b                   	pop    %ebx
 761:	5e                   	pop    %esi
 762:	5f                   	pop    %edi
 763:	5d                   	pop    %ebp
 764:	c3                   	ret
 765:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 768:	83 ec 0c             	sub    $0xc,%esp
 76b:	8b 17                	mov    (%edi),%edx
 76d:	b9 10 00 00 00       	mov    $0x10,%ecx
 772:	89 f0                	mov    %esi,%eax
 774:	6a 00                	push   $0x0
        ap++;
 776:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 779:	e8 62 fe ff ff       	call   5e0 <printint>
  for(i = 0; fmt[i]; i++){
 77e:	eb cf                	jmp    74f <printf+0xaf>
        s = (char*)*ap;
 780:	8b 07                	mov    (%edi),%eax
        ap++;
 782:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 785:	85 c0                	test   %eax,%eax
 787:	0f 84 b3 00 00 00    	je     840 <printf+0x1a0>
        while(*s != 0){
 78d:	0f b6 10             	movzbl (%eax),%edx
 790:	84 d2                	test   %dl,%dl
 792:	0f 84 ba 00 00 00    	je     852 <printf+0x1b2>
 798:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 79b:	89 c7                	mov    %eax,%edi
 79d:	89 d0                	mov    %edx,%eax
 79f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 7a2:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 7a5:	89 fb                	mov    %edi,%ebx
 7a7:	89 cf                	mov    %ecx,%edi
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 7b0:	83 ec 04             	sub    $0x4,%esp
 7b3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 7b6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 7b9:	6a 01                	push   $0x1
 7bb:	57                   	push   %edi
 7bc:	56                   	push   %esi
 7bd:	e8 a8 fd ff ff       	call   56a <write>
        while(*s != 0){
 7c2:	0f b6 03             	movzbl (%ebx),%eax
 7c5:	83 c4 10             	add    $0x10,%esp
 7c8:	84 c0                	test   %al,%al
 7ca:	75 e4                	jne    7b0 <printf+0x110>
 7cc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 7cf:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 7d3:	83 c3 02             	add    $0x2,%ebx
 7d6:	84 d2                	test   %dl,%dl
 7d8:	0f 85 e5 fe ff ff    	jne    6c3 <printf+0x23>
 7de:	e9 7a ff ff ff       	jmp    75d <printf+0xbd>
 7e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 7e8:	83 ec 0c             	sub    $0xc,%esp
 7eb:	8b 17                	mov    (%edi),%edx
 7ed:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7f2:	89 f0                	mov    %esi,%eax
 7f4:	6a 01                	push   $0x1
        ap++;
 7f6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 7f9:	e8 e2 fd ff ff       	call   5e0 <printint>
  for(i = 0; fmt[i]; i++){
 7fe:	e9 4c ff ff ff       	jmp    74f <printf+0xaf>
 803:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 808:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 80a:	83 ec 04             	sub    $0x4,%esp
 80d:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 810:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 813:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 816:	6a 01                	push   $0x1
 818:	51                   	push   %ecx
 819:	56                   	push   %esi
 81a:	e8 4b fd ff ff       	call   56a <write>
  for(i = 0; fmt[i]; i++){
 81f:	e9 2b ff ff ff       	jmp    74f <printf+0xaf>
 824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 828:	83 ec 04             	sub    $0x4,%esp
 82b:	88 55 e7             	mov    %dl,-0x19(%ebp)
 82e:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 831:	6a 01                	push   $0x1
 833:	e9 10 ff ff ff       	jmp    748 <printf+0xa8>
 838:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 83f:	00 
          s = "(null)";
 840:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 843:	b8 28 00 00 00       	mov    $0x28,%eax
 848:	bf 69 0a 00 00       	mov    $0xa69,%edi
 84d:	e9 4d ff ff ff       	jmp    79f <printf+0xff>
  for(i = 0; fmt[i]; i++){
 852:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 856:	83 c3 02             	add    $0x2,%ebx
 859:	84 d2                	test   %dl,%dl
 85b:	0f 85 8f fe ff ff    	jne    6f0 <printf+0x50>
 861:	e9 f7 fe ff ff       	jmp    75d <printf+0xbd>
 866:	66 90                	xchg   %ax,%ax
 868:	66 90                	xchg   %ax,%ax
 86a:	66 90                	xchg   %ax,%ax
 86c:	66 90                	xchg   %ax,%ax
 86e:	66 90                	xchg   %ax,%ax
 870:	66 90                	xchg   %ax,%ax
 872:	66 90                	xchg   %ax,%ax
 874:	66 90                	xchg   %ax,%ax
 876:	66 90                	xchg   %ax,%ax
 878:	66 90                	xchg   %ax,%ax
 87a:	66 90                	xchg   %ax,%ax
 87c:	66 90                	xchg   %ax,%ax
 87e:	66 90                	xchg   %ax,%ax

00000880 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 880:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 881:	a1 a8 0d 00 00       	mov    0xda8,%eax
{
 886:	89 e5                	mov    %esp,%ebp
 888:	57                   	push   %edi
 889:	56                   	push   %esi
 88a:	53                   	push   %ebx
 88b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 88e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 891:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 898:	00 
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8a0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a4:	39 ca                	cmp    %ecx,%edx
 8a6:	73 30                	jae    8d8 <free+0x58>
 8a8:	39 c1                	cmp    %eax,%ecx
 8aa:	72 04                	jb     8b0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ac:	39 c2                	cmp    %eax,%edx
 8ae:	72 f0                	jb     8a0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8b6:	39 f8                	cmp    %edi,%eax
 8b8:	74 36                	je     8f0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 8ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8bd:	8b 42 04             	mov    0x4(%edx),%eax
 8c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 8c3:	39 f1                	cmp    %esi,%ecx
 8c5:	74 40                	je     907 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8c7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8c9:	5b                   	pop    %ebx
  freep = p;
 8ca:	89 15 a8 0d 00 00    	mov    %edx,0xda8
}
 8d0:	5e                   	pop    %esi
 8d1:	5f                   	pop    %edi
 8d2:	5d                   	pop    %ebp
 8d3:	c3                   	ret
 8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d8:	39 c2                	cmp    %eax,%edx
 8da:	72 c4                	jb     8a0 <free+0x20>
 8dc:	39 c1                	cmp    %eax,%ecx
 8de:	73 c0                	jae    8a0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 8e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8e6:	39 f8                	cmp    %edi,%eax
 8e8:	75 d0                	jne    8ba <free+0x3a>
 8ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 8f0:	03 70 04             	add    0x4(%eax),%esi
 8f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f6:	8b 02                	mov    (%edx),%eax
 8f8:	8b 00                	mov    (%eax),%eax
 8fa:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 8fd:	8b 42 04             	mov    0x4(%edx),%eax
 900:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 903:	39 f1                	cmp    %esi,%ecx
 905:	75 c0                	jne    8c7 <free+0x47>
    p->s.size += bp->s.size;
 907:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 90a:	89 15 a8 0d 00 00    	mov    %edx,0xda8
    p->s.size += bp->s.size;
 910:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 913:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 916:	89 0a                	mov    %ecx,(%edx)
}
 918:	5b                   	pop    %ebx
 919:	5e                   	pop    %esi
 91a:	5f                   	pop    %edi
 91b:	5d                   	pop    %ebp
 91c:	c3                   	ret
 91d:	8d 76 00             	lea    0x0(%esi),%esi

00000920 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	57                   	push   %edi
 924:	56                   	push   %esi
 925:	53                   	push   %ebx
 926:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 929:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 92c:	8b 15 a8 0d 00 00    	mov    0xda8,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 932:	8d 78 07             	lea    0x7(%eax),%edi
 935:	c1 ef 03             	shr    $0x3,%edi
 938:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 93b:	85 d2                	test   %edx,%edx
 93d:	0f 84 8d 00 00 00    	je     9d0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 943:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 945:	8b 48 04             	mov    0x4(%eax),%ecx
 948:	39 f9                	cmp    %edi,%ecx
 94a:	73 64                	jae    9b0 <malloc+0x90>
  if(nu < 4096)
 94c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 951:	39 df                	cmp    %ebx,%edi
 953:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 956:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 95d:	eb 0a                	jmp    969 <malloc+0x49>
 95f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 960:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 962:	8b 48 04             	mov    0x4(%eax),%ecx
 965:	39 f9                	cmp    %edi,%ecx
 967:	73 47                	jae    9b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 969:	89 c2                	mov    %eax,%edx
 96b:	39 05 a8 0d 00 00    	cmp    %eax,0xda8
 971:	75 ed                	jne    960 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 973:	83 ec 0c             	sub    $0xc,%esp
 976:	56                   	push   %esi
 977:	e8 ce fb ff ff       	call   54a <sbrk>
  if(p == (char*)-1)
 97c:	83 c4 10             	add    $0x10,%esp
 97f:	83 f8 ff             	cmp    $0xffffffff,%eax
 982:	74 1c                	je     9a0 <malloc+0x80>
  hp->s.size = nu;
 984:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 987:	83 ec 0c             	sub    $0xc,%esp
 98a:	83 c0 08             	add    $0x8,%eax
 98d:	50                   	push   %eax
 98e:	e8 ed fe ff ff       	call   880 <free>
  return freep;
 993:	8b 15 a8 0d 00 00    	mov    0xda8,%edx
      if((p = morecore(nunits)) == 0)
 999:	83 c4 10             	add    $0x10,%esp
 99c:	85 d2                	test   %edx,%edx
 99e:	75 c0                	jne    960 <malloc+0x40>
        return 0;
  }
}
 9a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 9a3:	31 c0                	xor    %eax,%eax
}
 9a5:	5b                   	pop    %ebx
 9a6:	5e                   	pop    %esi
 9a7:	5f                   	pop    %edi
 9a8:	5d                   	pop    %ebp
 9a9:	c3                   	ret
 9aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 9b0:	39 cf                	cmp    %ecx,%edi
 9b2:	74 4c                	je     a00 <malloc+0xe0>
        p->s.size -= nunits;
 9b4:	29 f9                	sub    %edi,%ecx
 9b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 9bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 9bf:	89 15 a8 0d 00 00    	mov    %edx,0xda8
}
 9c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 9c8:	83 c0 08             	add    $0x8,%eax
}
 9cb:	5b                   	pop    %ebx
 9cc:	5e                   	pop    %esi
 9cd:	5f                   	pop    %edi
 9ce:	5d                   	pop    %ebp
 9cf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 9d0:	c7 05 a8 0d 00 00 ac 	movl   $0xdac,0xda8
 9d7:	0d 00 00 
    base.s.size = 0;
 9da:	b8 ac 0d 00 00       	mov    $0xdac,%eax
    base.s.ptr = freep = prevp = &base;
 9df:	c7 05 ac 0d 00 00 ac 	movl   $0xdac,0xdac
 9e6:	0d 00 00 
    base.s.size = 0;
 9e9:	c7 05 b0 0d 00 00 00 	movl   $0x0,0xdb0
 9f0:	00 00 00 
    if(p->s.size >= nunits){
 9f3:	e9 54 ff ff ff       	jmp    94c <malloc+0x2c>
 9f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9ff:	00 
        prevp->s.ptr = p->s.ptr;
 a00:	8b 08                	mov    (%eax),%ecx
 a02:	89 0a                	mov    %ecx,(%edx)
 a04:	eb b9                	jmp    9bf <malloc+0x9f>
