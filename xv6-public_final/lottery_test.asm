
_lottery_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  for(;;) x++;
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
   f:	8d bd d0 f1 ff ff    	lea    -0xe30(%ebp),%edi
  15:	53                   	push   %ebx
  setpolicy(2);
  int pids[3];
  int tix[3] = {10, 20, 40};

  for(int i = 0; i < 3; i++){
  16:	31 db                	xor    %ebx,%ebx
{
  18:	51                   	push   %ecx
  19:	81 ec 34 0e 00 00    	sub    $0xe34,%esp
  setpolicy(2);
  1f:	6a 02                	push   $0x2
  21:	e8 74 04 00 00       	call   49a <setpolicy>
  int tix[3] = {10, 20, 40};
  26:	83 c4 10             	add    $0x10,%esp
  29:	c7 85 dc f1 ff ff 0a 	movl   $0xa,-0xe24(%ebp)
  30:	00 00 00 
  33:	c7 85 e0 f1 ff ff 14 	movl   $0x14,-0xe20(%ebp)
  3a:	00 00 00 
  3d:	c7 85 e4 f1 ff ff 28 	movl   $0x28,-0xe1c(%ebp)
  44:	00 00 00 
    int pid = fork();
  47:	e8 a6 03 00 00       	call   3f2 <fork>
    if(pid == 0){
  4c:	85 c0                	test   %eax,%eax
  4e:	0f 84 ed 00 00 00    	je     141 <main+0x141>
      settickets(tix[i]);
      spin();
      exit();
    }
    pids[i] = pid;
  54:	89 04 9f             	mov    %eax,(%edi,%ebx,4)
  for(int i = 0; i < 3; i++){
  57:	83 c3 01             	add    $0x1,%ebx
  5a:	83 fb 03             	cmp    $0x3,%ebx
  5d:	75 e8                	jne    47 <main+0x47>
  }

  sleep(500);
  5f:	83 ec 0c             	sub    $0xc,%esp

  struct pstat ps;
  if(getpinfo(&ps) == 0){
  62:	8d b5 e8 f1 ff ff    	lea    -0xe18(%ebp),%esi
  sleep(500);
  68:	68 f4 01 00 00       	push   $0x1f4
  6d:	e8 e0 03 00 00       	call   452 <sleep>
  if(getpinfo(&ps) == 0){
  72:	89 34 24             	mov    %esi,(%esp)
  75:	e8 30 04 00 00       	call   4aa <getpinfo>
  7a:	83 c4 10             	add    $0x10,%esp
  7d:	85 c0                	test   %eax,%eax
  7f:	74 4c                	je     cd <main+0xcd>
        }
      }
    }
  }

  for(int i = 0; i < 3; i++) kill(pids[i]);
  81:	83 ec 0c             	sub    $0xc,%esp
  84:	ff b5 d0 f1 ff ff    	push   -0xe30(%ebp)
  8a:	e8 8b 03 00 00       	call   41a <kill>
  8f:	58                   	pop    %eax
  90:	ff b5 d4 f1 ff ff    	push   -0xe2c(%ebp)
  96:	e8 7f 03 00 00       	call   41a <kill>
  9b:	5a                   	pop    %edx
  9c:	ff b5 d8 f1 ff ff    	push   -0xe28(%ebp)
  a2:	e8 73 03 00 00       	call   41a <kill>
  a7:	83 c4 10             	add    $0x10,%esp
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(wait() > 0);
  b0:	e8 4d 03 00 00       	call   402 <wait>
  b5:	85 c0                	test   %eax,%eax
  b7:	7f f7                	jg     b0 <main+0xb0>
  printf(1, "Lottery test done\n");
  b9:	83 ec 08             	sub    $0x8,%esp
  bc:	68 37 09 00 00       	push   $0x937
  c1:	6a 01                	push   $0x1
  c3:	e8 d8 04 00 00       	call   5a0 <printf>
  exit();
  c8:	e8 2d 03 00 00       	call   3fa <exit>
  cd:	8d 8d e8 f2 ff ff    	lea    -0xd18(%ebp),%ecx
  d3:	8d 95 dc f1 ff ff    	lea    -0xe24(%ebp),%edx
  d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(int j = 0; j < 3; j++){
  e0:	89 fb                	mov    %edi,%ebx
        if(ps.inuse[i] && ps.pid[i] == pids[j]){
  e2:	8b 06                	mov    (%esi),%eax
  e4:	85 c0                	test   %eax,%eax
  e6:	74 0a                	je     f2 <main+0xf2>
  e8:	8b 86 00 01 00 00    	mov    0x100(%esi),%eax
  ee:	3b 03                	cmp    (%ebx),%eax
  f0:	74 16                	je     108 <main+0x108>
      for(int j = 0; j < 3; j++){
  f2:	83 c3 04             	add    $0x4,%ebx
  f5:	39 d3                	cmp    %edx,%ebx
  f7:	75 e9                	jne    e2 <main+0xe2>
    for(int i = 0; i < NPROC; i++){
  f9:	83 c6 04             	add    $0x4,%esi
  fc:	39 ce                	cmp    %ecx,%esi
  fe:	75 e0                	jne    e0 <main+0xe0>
 100:	e9 7c ff ff ff       	jmp    81 <main+0x81>
 105:	8d 76 00             	lea    0x0(%esi),%esi
          printf(1, "pid %d tickets=%d rtime=%d retime=%d stime=%d\n", ps.pid[i], ps.tickets[i], ps.rtime[i], ps.retime[i], ps.stime[i]);
 108:	83 ec 04             	sub    $0x4,%esp
 10b:	ff b6 00 06 00 00    	push   0x600(%esi)
 111:	ff b6 00 07 00 00    	push   0x700(%esi)
 117:	ff b6 00 05 00 00    	push   0x500(%esi)
 11d:	ff b6 00 03 00 00    	push   0x300(%esi)
 123:	50                   	push   %eax
 124:	68 08 09 00 00       	push   $0x908
 129:	6a 01                	push   $0x1
 12b:	e8 70 04 00 00       	call   5a0 <printf>
 130:	83 c4 20             	add    $0x20,%esp
 133:	8d 95 dc f1 ff ff    	lea    -0xe24(%ebp),%edx
 139:	8d 8d e8 f2 ff ff    	lea    -0xd18(%ebp),%ecx
 13f:	eb b1                	jmp    f2 <main+0xf2>
      settickets(tix[i]);
 141:	83 ec 0c             	sub    $0xc,%esp
 144:	ff b4 9d dc f1 ff ff 	push   -0xe24(%ebp,%ebx,4)
 14b:	e8 52 03 00 00       	call   4a2 <settickets>
  volatile unsigned long x = 0;
 150:	31 c0                	xor    %eax,%eax
 152:	83 c4 10             	add    $0x10,%esp
 155:	89 85 e8 f1 ff ff    	mov    %eax,-0xe18(%ebp)
 15b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(;;) x++;
 160:	8b 85 e8 f1 ff ff    	mov    -0xe18(%ebp),%eax
 166:	83 c0 01             	add    $0x1,%eax
 169:	89 85 e8 f1 ff ff    	mov    %eax,-0xe18(%ebp)
 16f:	eb ef                	jmp    160 <main+0x160>
 171:	66 90                	xchg   %ax,%ax
 173:	66 90                	xchg   %ax,%ax
 175:	66 90                	xchg   %ax,%ax
 177:	66 90                	xchg   %ax,%ax
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
 181:	31 c0                	xor    %eax,%eax
{
 183:	89 e5                	mov    %esp,%ebp
 185:	53                   	push   %ebx
 186:	8b 4d 08             	mov    0x8(%ebp),%ecx
 189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
 190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 197:	83 c0 01             	add    $0x1,%eax
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strcpy+0x10>
  return os;
}
 19e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1a1:	89 c8                	mov    %ecx,%eax
 1a3:	c9                   	leave
 1a4:	c3                   	ret
 1a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ac:	00 
 1ad:	8d 76 00             	lea    0x0(%esi),%esi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	75 2f                	jne    1f0 <strcmp+0x40>
 1c1:	eb 4a                	jmp    20d <strcmp+0x5d>
 1c3:	eb 1b                	jmp    1e0 <strcmp+0x30>
 1c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cc:	00 
 1cd:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1d4:	00 
 1d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1dc:	00 
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1e4:	83 c2 01             	add    $0x1,%edx
 1e7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1ea:	84 c0                	test   %al,%al
 1ec:	74 12                	je     200 <strcmp+0x50>
 1ee:	89 d9                	mov    %ebx,%ecx
 1f0:	0f b6 19             	movzbl (%ecx),%ebx
 1f3:	38 c3                	cmp    %al,%bl
 1f5:	74 e9                	je     1e0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 1f7:	29 d8                	sub    %ebx,%eax
}
 1f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fc:	c9                   	leave
 1fd:	c3                   	ret
 1fe:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 200:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 204:	31 c0                	xor    %eax,%eax
 206:	29 d8                	sub    %ebx,%eax
}
 208:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 20b:	c9                   	leave
 20c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 20d:	0f b6 19             	movzbl (%ecx),%ebx
 210:	31 c0                	xor    %eax,%eax
 212:	eb e3                	jmp    1f7 <strcmp+0x47>
 214:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21b:	00 
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000220 <strlen>:

uint
strlen(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 226:	80 3a 00             	cmpb   $0x0,(%edx)
 229:	74 15                	je     240 <strlen+0x20>
 22b:	31 c0                	xor    %eax,%eax
 22d:	8d 76 00             	lea    0x0(%esi),%esi
 230:	83 c0 01             	add    $0x1,%eax
 233:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 237:	89 c1                	mov    %eax,%ecx
 239:	75 f5                	jne    230 <strlen+0x10>
  return n;
}
 23b:	89 c8                	mov    %ecx,%eax
 23d:	5d                   	pop    %ebp
 23e:	c3                   	ret
 23f:	90                   	nop
  for(n = 0; s[n]; n++);
 240:	31 c9                	xor    %ecx,%ecx
}
 242:	5d                   	pop    %ebp
 243:	89 c8                	mov    %ecx,%eax
 245:	c3                   	ret
 246:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24d:	00 
 24e:	66 90                	xchg   %ax,%ax

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 257:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	89 d7                	mov    %edx,%edi
 25f:	fc                   	cld
 260:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 262:	8b 7d fc             	mov    -0x4(%ebp),%edi
 265:	89 d0                	mov    %edx,%eax
 267:	c9                   	leave
 268:	c3                   	ret
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	75 1a                	jne    29b <strchr+0x2b>
 281:	eb 25                	jmp    2a8 <strchr+0x38>
 283:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28a:	00 
 28b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 290:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 294:	83 c0 01             	add    $0x1,%eax
 297:	84 d2                	test   %dl,%dl
 299:	74 0d                	je     2a8 <strchr+0x38>
    if(*s == c)
 29b:	38 d1                	cmp    %dl,%cl
 29d:	75 f1                	jne    290 <strchr+0x20>
      return (char*)s;
  return 0;
}
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret
 2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2a8:	31 c0                	xor    %eax,%eax
}
 2aa:	5d                   	pop    %ebp
 2ab:	c3                   	ret
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 2b5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 2b8:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 2b9:	31 db                	xor    %ebx,%ebx
{
 2bb:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 2be:	eb 27                	jmp    2e7 <gets+0x37>
    cc = read(0, &c, 1);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	6a 01                	push   $0x1
 2c5:	56                   	push   %esi
 2c6:	6a 00                	push   $0x0
 2c8:	e8 45 01 00 00       	call   412 <read>
    if(cc < 1)
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	85 c0                	test   %eax,%eax
 2d2:	7e 1d                	jle    2f1 <gets+0x41>
      break;
    buf[i++] = c;
 2d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2d8:	8b 55 08             	mov    0x8(%ebp),%edx
 2db:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2df:	3c 0a                	cmp    $0xa,%al
 2e1:	74 10                	je     2f3 <gets+0x43>
 2e3:	3c 0d                	cmp    $0xd,%al
 2e5:	74 0c                	je     2f3 <gets+0x43>
  for(i = 0; i+1 < max; ){
 2e7:	89 df                	mov    %ebx,%edi
 2e9:	83 c3 01             	add    $0x1,%ebx
 2ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2ef:	7c cf                	jl     2c0 <gets+0x10>
 2f1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 2fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fd:	5b                   	pop    %ebx
 2fe:	5e                   	pop    %esi
 2ff:	5f                   	pop    %edi
 300:	5d                   	pop    %ebp
 301:	c3                   	ret
 302:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 309:	00 
 30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000310 <stat>:

int
stat(const char *n, struct stat *st)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 315:	83 ec 08             	sub    $0x8,%esp
 318:	6a 00                	push   $0x0
 31a:	ff 75 08             	push   0x8(%ebp)
 31d:	e8 40 01 00 00       	call   462 <open>
  if(fd < 0)
 322:	83 c4 10             	add    $0x10,%esp
 325:	85 c0                	test   %eax,%eax
 327:	78 27                	js     350 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	ff 75 0c             	push   0xc(%ebp)
 32f:	89 c3                	mov    %eax,%ebx
 331:	50                   	push   %eax
 332:	e8 f3 00 00 00       	call   42a <fstat>
  close(fd);
 337:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 33a:	89 c6                	mov    %eax,%esi
  close(fd);
 33c:	e8 51 01 00 00       	call   492 <close>
  return r;
 341:	83 c4 10             	add    $0x10,%esp
}
 344:	8d 65 f8             	lea    -0x8(%ebp),%esp
 347:	89 f0                	mov    %esi,%eax
 349:	5b                   	pop    %ebx
 34a:	5e                   	pop    %esi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret
 34d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
 355:	eb ed                	jmp    344 <stat+0x34>
 357:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35e:	00 
 35f:	90                   	nop

00000360 <atoi>:

int
atoi(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 367:	0f be 02             	movsbl (%edx),%eax
 36a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 36d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 370:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 375:	77 1e                	ja     395 <atoi+0x35>
 377:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 37e:	00 
 37f:	90                   	nop
    n = n*10 + *s++ - '0';
 380:	83 c2 01             	add    $0x1,%edx
 383:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 386:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 38a:	0f be 02             	movsbl (%edx),%eax
 38d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
  return n;
}
 395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 398:	89 c8                	mov    %ecx,%eax
 39a:	c9                   	leave
 39b:	c3                   	ret
 39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	8b 55 08             	mov    0x8(%ebp),%edx
 3a7:	8b 45 10             	mov    0x10(%ebp),%eax
 3aa:	56                   	push   %esi
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 3ae:	39 f2                	cmp    %esi,%edx
 3b0:	73 1e                	jae    3d0 <memmove+0x30>
    while(n-- > 0)
 3b2:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 3b5:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 3b7:	85 c0                	test   %eax,%eax
 3b9:	7e 0a                	jle    3c5 <memmove+0x25>
 3bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 3c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 3c1:	39 f9                	cmp    %edi,%ecx
 3c3:	75 fb                	jne    3c0 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3c5:	5e                   	pop    %esi
 3c6:	89 d0                	mov    %edx,%eax
 3c8:	5f                   	pop    %edi
 3c9:	5d                   	pop    %ebp
 3ca:	c3                   	ret
 3cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 3d0:	85 c0                	test   %eax,%eax
 3d2:	7e f1                	jle    3c5 <memmove+0x25>
    while(n-- > 0)
 3d4:	83 e8 01             	sub    $0x1,%eax
 3d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3de:	00 
 3df:	90                   	nop
      *--dst = *--src;
 3e0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 3e4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 3e7:	83 e8 01             	sub    $0x1,%eax
 3ea:	73 f4                	jae    3e0 <memmove+0x40>
}
 3ec:	5e                   	pop    %esi
 3ed:	89 d0                	mov    %edx,%eax
 3ef:	5f                   	pop    %edi
 3f0:	5d                   	pop    %ebp
 3f1:	c3                   	ret

000003f2 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 3f2:	b8 01 00 00 00       	mov    $0x1,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret

000003fa <exit>:
SYSCALL(exit)
 3fa:	b8 02 00 00 00       	mov    $0x2,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret

00000402 <wait>:
SYSCALL(wait)
 402:	b8 03 00 00 00       	mov    $0x3,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret

0000040a <pipe>:
SYSCALL(pipe)
 40a:	b8 04 00 00 00       	mov    $0x4,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret

00000412 <read>:
SYSCALL(read)
 412:	b8 05 00 00 00       	mov    $0x5,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret

0000041a <kill>:
SYSCALL(kill)
 41a:	b8 06 00 00 00       	mov    $0x6,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret

00000422 <exec>:
SYSCALL(exec)
 422:	b8 07 00 00 00       	mov    $0x7,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret

0000042a <fstat>:
SYSCALL(fstat)
 42a:	b8 08 00 00 00       	mov    $0x8,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret

00000432 <chdir>:
SYSCALL(chdir)
 432:	b8 09 00 00 00       	mov    $0x9,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret

0000043a <dup>:
SYSCALL(dup)
 43a:	b8 0a 00 00 00       	mov    $0xa,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret

00000442 <getpid>:
SYSCALL(getpid)
 442:	b8 0b 00 00 00       	mov    $0xb,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret

0000044a <sbrk>:
SYSCALL(sbrk)
 44a:	b8 0c 00 00 00       	mov    $0xc,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret

00000452 <sleep>:
SYSCALL(sleep)
 452:	b8 0d 00 00 00       	mov    $0xd,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret

0000045a <uptime>:
SYSCALL(uptime)
 45a:	b8 0e 00 00 00       	mov    $0xe,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret

00000462 <open>:
SYSCALL(open)
 462:	b8 0f 00 00 00       	mov    $0xf,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret

0000046a <write>:
SYSCALL(write)
 46a:	b8 10 00 00 00       	mov    $0x10,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret

00000472 <mknod>:
SYSCALL(mknod)
 472:	b8 11 00 00 00       	mov    $0x11,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret

0000047a <unlink>:
SYSCALL(unlink)
 47a:	b8 12 00 00 00       	mov    $0x12,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret

00000482 <link>:
SYSCALL(link)
 482:	b8 13 00 00 00       	mov    $0x13,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret

0000048a <mkdir>:
SYSCALL(mkdir)
 48a:	b8 14 00 00 00       	mov    $0x14,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret

00000492 <close>:
SYSCALL(close)
 492:	b8 15 00 00 00       	mov    $0x15,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret

0000049a <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 49a:	b8 16 00 00 00       	mov    $0x16,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret

000004a2 <settickets>:
SYSCALL(settickets)
 4a2:	b8 17 00 00 00       	mov    $0x17,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret

000004aa <getpinfo>:
SYSCALL(getpinfo)
 4aa:	b8 18 00 00 00       	mov    $0x18,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret

000004b2 <waitx>:
SYSCALL(waitx)
 4b2:	b8 19 00 00 00       	mov    $0x19,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret

000004ba <yield>:
SYSCALL(yield)
 4ba:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret
 4c2:	66 90                	xchg   %ax,%ax
 4c4:	66 90                	xchg   %ax,%ax
 4c6:	66 90                	xchg   %ax,%ax
 4c8:	66 90                	xchg   %ax,%ax
 4ca:	66 90                	xchg   %ax,%ax
 4cc:	66 90                	xchg   %ax,%ax
 4ce:	66 90                	xchg   %ax,%ax
 4d0:	66 90                	xchg   %ax,%ax
 4d2:	66 90                	xchg   %ax,%ax
 4d4:	66 90                	xchg   %ax,%ax
 4d6:	66 90                	xchg   %ax,%ax
 4d8:	66 90                	xchg   %ax,%ax
 4da:	66 90                	xchg   %ax,%ax
 4dc:	66 90                	xchg   %ax,%ax
 4de:	66 90                	xchg   %ax,%ax

000004e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4e8:	89 d1                	mov    %edx,%ecx
{
 4ea:	83 ec 3c             	sub    $0x3c,%esp
 4ed:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 4f0:	85 d2                	test   %edx,%edx
 4f2:	0f 89 98 00 00 00    	jns    590 <printint+0xb0>
 4f8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4fc:	0f 84 8e 00 00 00    	je     590 <printint+0xb0>
    x = -xx;
 502:	f7 d9                	neg    %ecx
    neg = 1;
 504:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 509:	89 45 c0             	mov    %eax,-0x40(%ebp)
 50c:	31 f6                	xor    %esi,%esi
 50e:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 515:	00 
 516:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51d:	00 
 51e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 520:	89 c8                	mov    %ecx,%eax
 522:	31 d2                	xor    %edx,%edx
 524:	89 f7                	mov    %esi,%edi
 526:	f7 f3                	div    %ebx
 528:	8d 76 01             	lea    0x1(%esi),%esi
 52b:	0f b6 92 ac 09 00 00 	movzbl 0x9ac(%edx),%edx
 532:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 536:	89 ca                	mov    %ecx,%edx
 538:	89 c1                	mov    %eax,%ecx
 53a:	39 da                	cmp    %ebx,%edx
 53c:	73 e2                	jae    520 <printint+0x40>
  if(neg)
 53e:	8b 45 c0             	mov    -0x40(%ebp),%eax
 541:	85 c0                	test   %eax,%eax
 543:	74 07                	je     54c <printint+0x6c>
    buf[i++] = '-';
 545:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 54a:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 54c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 54f:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 552:	01 df                	add    %ebx,%edi
 554:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55b:	00 
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 560:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 563:	83 ec 04             	sub    $0x4,%esp
 566:	88 45 d7             	mov    %al,-0x29(%ebp)
 569:	8d 45 d7             	lea    -0x29(%ebp),%eax
 56c:	6a 01                	push   $0x1
 56e:	50                   	push   %eax
 56f:	56                   	push   %esi
 570:	e8 f5 fe ff ff       	call   46a <write>
  while(--i >= 0)
 575:	89 f8                	mov    %edi,%eax
 577:	83 c4 10             	add    $0x10,%esp
 57a:	83 ef 01             	sub    $0x1,%edi
 57d:	39 d8                	cmp    %ebx,%eax
 57f:	75 df                	jne    560 <printint+0x80>
}
 581:	8d 65 f4             	lea    -0xc(%ebp),%esp
 584:	5b                   	pop    %ebx
 585:	5e                   	pop    %esi
 586:	5f                   	pop    %edi
 587:	5d                   	pop    %ebp
 588:	c3                   	ret
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 590:	31 c0                	xor    %eax,%eax
 592:	e9 72 ff ff ff       	jmp    509 <printint+0x29>
 597:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59e:	00 
 59f:	90                   	nop

000005a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
 5a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 5ac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 5af:	0f b6 13             	movzbl (%ebx),%edx
 5b2:	83 c3 01             	add    $0x1,%ebx
 5b5:	84 d2                	test   %dl,%dl
 5b7:	0f 84 a0 00 00 00    	je     65d <printf+0xbd>
 5bd:	8d 45 10             	lea    0x10(%ebp),%eax
 5c0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 5c3:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5c6:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 5c9:	eb 28                	jmp    5f3 <printf+0x53>
 5cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5d6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 5d9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 5dc:	6a 01                	push   $0x1
 5de:	50                   	push   %eax
 5df:	56                   	push   %esi
 5e0:	e8 85 fe ff ff       	call   46a <write>
  for(i = 0; fmt[i]; i++){
 5e5:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5e9:	83 c4 10             	add    $0x10,%esp
 5ec:	84 d2                	test   %dl,%dl
 5ee:	74 6d                	je     65d <printf+0xbd>
    c = fmt[i] & 0xff;
 5f0:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 5f3:	83 f8 25             	cmp    $0x25,%eax
 5f6:	75 d8                	jne    5d0 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 5f8:	0f b6 13             	movzbl (%ebx),%edx
 5fb:	84 d2                	test   %dl,%dl
 5fd:	74 5e                	je     65d <printf+0xbd>
    c = fmt[i] & 0xff;
 5ff:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 602:	80 fa 25             	cmp    $0x25,%dl
 605:	0f 84 1d 01 00 00    	je     728 <printf+0x188>
 60b:	83 e8 63             	sub    $0x63,%eax
 60e:	83 f8 15             	cmp    $0x15,%eax
 611:	77 0d                	ja     620 <printf+0x80>
 613:	ff 24 85 54 09 00 00 	jmp    *0x954(,%eax,4)
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 620:	83 ec 04             	sub    $0x4,%esp
 623:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 626:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 629:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 62d:	6a 01                	push   $0x1
 62f:	51                   	push   %ecx
 630:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 633:	56                   	push   %esi
 634:	e8 31 fe ff ff       	call   46a <write>
        putc(fd, c);
 639:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 63d:	83 c4 0c             	add    $0xc,%esp
 640:	88 55 e7             	mov    %dl,-0x19(%ebp)
 643:	6a 01                	push   $0x1
 645:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 648:	51                   	push   %ecx
 649:	56                   	push   %esi
 64a:	e8 1b fe ff ff       	call   46a <write>
  for(i = 0; fmt[i]; i++){
 64f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 653:	83 c3 02             	add    $0x2,%ebx
 656:	83 c4 10             	add    $0x10,%esp
 659:	84 d2                	test   %dl,%dl
 65b:	75 93                	jne    5f0 <printf+0x50>
      }
      state = 0;
    }
  }
}
 65d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 660:	5b                   	pop    %ebx
 661:	5e                   	pop    %esi
 662:	5f                   	pop    %edi
 663:	5d                   	pop    %ebp
 664:	c3                   	ret
 665:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 668:	83 ec 0c             	sub    $0xc,%esp
 66b:	8b 17                	mov    (%edi),%edx
 66d:	b9 10 00 00 00       	mov    $0x10,%ecx
 672:	89 f0                	mov    %esi,%eax
 674:	6a 00                	push   $0x0
        ap++;
 676:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 679:	e8 62 fe ff ff       	call   4e0 <printint>
  for(i = 0; fmt[i]; i++){
 67e:	eb cf                	jmp    64f <printf+0xaf>
        s = (char*)*ap;
 680:	8b 07                	mov    (%edi),%eax
        ap++;
 682:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 685:	85 c0                	test   %eax,%eax
 687:	0f 84 b3 00 00 00    	je     740 <printf+0x1a0>
        while(*s != 0){
 68d:	0f b6 10             	movzbl (%eax),%edx
 690:	84 d2                	test   %dl,%dl
 692:	0f 84 ba 00 00 00    	je     752 <printf+0x1b2>
 698:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 69b:	89 c7                	mov    %eax,%edi
 69d:	89 d0                	mov    %edx,%eax
 69f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 6a2:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6a5:	89 fb                	mov    %edi,%ebx
 6a7:	89 cf                	mov    %ecx,%edi
 6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6b0:	83 ec 04             	sub    $0x4,%esp
 6b3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 6b6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 6b9:	6a 01                	push   $0x1
 6bb:	57                   	push   %edi
 6bc:	56                   	push   %esi
 6bd:	e8 a8 fd ff ff       	call   46a <write>
        while(*s != 0){
 6c2:	0f b6 03             	movzbl (%ebx),%eax
 6c5:	83 c4 10             	add    $0x10,%esp
 6c8:	84 c0                	test   %al,%al
 6ca:	75 e4                	jne    6b0 <printf+0x110>
 6cc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 6cf:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 6d3:	83 c3 02             	add    $0x2,%ebx
 6d6:	84 d2                	test   %dl,%dl
 6d8:	0f 85 e5 fe ff ff    	jne    5c3 <printf+0x23>
 6de:	e9 7a ff ff ff       	jmp    65d <printf+0xbd>
 6e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6e8:	83 ec 0c             	sub    $0xc,%esp
 6eb:	8b 17                	mov    (%edi),%edx
 6ed:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6f2:	89 f0                	mov    %esi,%eax
 6f4:	6a 01                	push   $0x1
        ap++;
 6f6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 6f9:	e8 e2 fd ff ff       	call   4e0 <printint>
  for(i = 0; fmt[i]; i++){
 6fe:	e9 4c ff ff ff       	jmp    64f <printf+0xaf>
 703:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 708:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 70a:	83 ec 04             	sub    $0x4,%esp
 70d:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 710:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 713:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 716:	6a 01                	push   $0x1
 718:	51                   	push   %ecx
 719:	56                   	push   %esi
 71a:	e8 4b fd ff ff       	call   46a <write>
  for(i = 0; fmt[i]; i++){
 71f:	e9 2b ff ff ff       	jmp    64f <printf+0xaf>
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 728:	83 ec 04             	sub    $0x4,%esp
 72b:	88 55 e7             	mov    %dl,-0x19(%ebp)
 72e:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 731:	6a 01                	push   $0x1
 733:	e9 10 ff ff ff       	jmp    648 <printf+0xa8>
 738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 73f:	00 
          s = "(null)";
 740:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 743:	b8 28 00 00 00       	mov    $0x28,%eax
 748:	bf 4a 09 00 00       	mov    $0x94a,%edi
 74d:	e9 4d ff ff ff       	jmp    69f <printf+0xff>
  for(i = 0; fmt[i]; i++){
 752:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 756:	83 c3 02             	add    $0x2,%ebx
 759:	84 d2                	test   %dl,%dl
 75b:	0f 85 8f fe ff ff    	jne    5f0 <printf+0x50>
 761:	e9 f7 fe ff ff       	jmp    65d <printf+0xbd>
 766:	66 90                	xchg   %ax,%ax
 768:	66 90                	xchg   %ax,%ax
 76a:	66 90                	xchg   %ax,%ax
 76c:	66 90                	xchg   %ax,%ax
 76e:	66 90                	xchg   %ax,%ax
 770:	66 90                	xchg   %ax,%ax
 772:	66 90                	xchg   %ax,%ax
 774:	66 90                	xchg   %ax,%ax
 776:	66 90                	xchg   %ax,%ax
 778:	66 90                	xchg   %ax,%ax
 77a:	66 90                	xchg   %ax,%ax
 77c:	66 90                	xchg   %ax,%ax
 77e:	66 90                	xchg   %ax,%ax

00000780 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 780:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 781:	a1 64 0c 00 00       	mov    0xc64,%eax
{
 786:	89 e5                	mov    %esp,%ebp
 788:	57                   	push   %edi
 789:	56                   	push   %esi
 78a:	53                   	push   %ebx
 78b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 78e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 791:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 798:	00 
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7a0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a4:	39 ca                	cmp    %ecx,%edx
 7a6:	73 30                	jae    7d8 <free+0x58>
 7a8:	39 c1                	cmp    %eax,%ecx
 7aa:	72 04                	jb     7b0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ac:	39 c2                	cmp    %eax,%edx
 7ae:	72 f0                	jb     7a0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7b6:	39 f8                	cmp    %edi,%eax
 7b8:	74 36                	je     7f0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7bd:	8b 42 04             	mov    0x4(%edx),%eax
 7c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7c3:	39 f1                	cmp    %esi,%ecx
 7c5:	74 40                	je     807 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7c7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7c9:	5b                   	pop    %ebx
  freep = p;
 7ca:	89 15 64 0c 00 00    	mov    %edx,0xc64
}
 7d0:	5e                   	pop    %esi
 7d1:	5f                   	pop    %edi
 7d2:	5d                   	pop    %ebp
 7d3:	c3                   	ret
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d8:	39 c2                	cmp    %eax,%edx
 7da:	72 c4                	jb     7a0 <free+0x20>
 7dc:	39 c1                	cmp    %eax,%ecx
 7de:	73 c0                	jae    7a0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 7e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7e6:	39 f8                	cmp    %edi,%eax
 7e8:	75 d0                	jne    7ba <free+0x3a>
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 7f0:	03 70 04             	add    0x4(%eax),%esi
 7f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f6:	8b 02                	mov    (%edx),%eax
 7f8:	8b 00                	mov    (%eax),%eax
 7fa:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 7fd:	8b 42 04             	mov    0x4(%edx),%eax
 800:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 803:	39 f1                	cmp    %esi,%ecx
 805:	75 c0                	jne    7c7 <free+0x47>
    p->s.size += bp->s.size;
 807:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 80a:	89 15 64 0c 00 00    	mov    %edx,0xc64
    p->s.size += bp->s.size;
 810:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 813:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 816:	89 0a                	mov    %ecx,(%edx)
}
 818:	5b                   	pop    %ebx
 819:	5e                   	pop    %esi
 81a:	5f                   	pop    %edi
 81b:	5d                   	pop    %ebp
 81c:	c3                   	ret
 81d:	8d 76 00             	lea    0x0(%esi),%esi

00000820 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	57                   	push   %edi
 824:	56                   	push   %esi
 825:	53                   	push   %ebx
 826:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 829:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 82c:	8b 15 64 0c 00 00    	mov    0xc64,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 832:	8d 78 07             	lea    0x7(%eax),%edi
 835:	c1 ef 03             	shr    $0x3,%edi
 838:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 83b:	85 d2                	test   %edx,%edx
 83d:	0f 84 8d 00 00 00    	je     8d0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 843:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 845:	8b 48 04             	mov    0x4(%eax),%ecx
 848:	39 f9                	cmp    %edi,%ecx
 84a:	73 64                	jae    8b0 <malloc+0x90>
  if(nu < 4096)
 84c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 851:	39 df                	cmp    %ebx,%edi
 853:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 856:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 85d:	eb 0a                	jmp    869 <malloc+0x49>
 85f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 860:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 862:	8b 48 04             	mov    0x4(%eax),%ecx
 865:	39 f9                	cmp    %edi,%ecx
 867:	73 47                	jae    8b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 869:	89 c2                	mov    %eax,%edx
 86b:	39 05 64 0c 00 00    	cmp    %eax,0xc64
 871:	75 ed                	jne    860 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 873:	83 ec 0c             	sub    $0xc,%esp
 876:	56                   	push   %esi
 877:	e8 ce fb ff ff       	call   44a <sbrk>
  if(p == (char*)-1)
 87c:	83 c4 10             	add    $0x10,%esp
 87f:	83 f8 ff             	cmp    $0xffffffff,%eax
 882:	74 1c                	je     8a0 <malloc+0x80>
  hp->s.size = nu;
 884:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 887:	83 ec 0c             	sub    $0xc,%esp
 88a:	83 c0 08             	add    $0x8,%eax
 88d:	50                   	push   %eax
 88e:	e8 ed fe ff ff       	call   780 <free>
  return freep;
 893:	8b 15 64 0c 00 00    	mov    0xc64,%edx
      if((p = morecore(nunits)) == 0)
 899:	83 c4 10             	add    $0x10,%esp
 89c:	85 d2                	test   %edx,%edx
 89e:	75 c0                	jne    860 <malloc+0x40>
        return 0;
  }
}
 8a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8a3:	31 c0                	xor    %eax,%eax
}
 8a5:	5b                   	pop    %ebx
 8a6:	5e                   	pop    %esi
 8a7:	5f                   	pop    %edi
 8a8:	5d                   	pop    %ebp
 8a9:	c3                   	ret
 8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8b0:	39 cf                	cmp    %ecx,%edi
 8b2:	74 4c                	je     900 <malloc+0xe0>
        p->s.size -= nunits;
 8b4:	29 f9                	sub    %edi,%ecx
 8b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 8bf:	89 15 64 0c 00 00    	mov    %edx,0xc64
}
 8c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8c8:	83 c0 08             	add    $0x8,%eax
}
 8cb:	5b                   	pop    %ebx
 8cc:	5e                   	pop    %esi
 8cd:	5f                   	pop    %edi
 8ce:	5d                   	pop    %ebp
 8cf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 8d0:	c7 05 64 0c 00 00 68 	movl   $0xc68,0xc64
 8d7:	0c 00 00 
    base.s.size = 0;
 8da:	b8 68 0c 00 00       	mov    $0xc68,%eax
    base.s.ptr = freep = prevp = &base;
 8df:	c7 05 68 0c 00 00 68 	movl   $0xc68,0xc68
 8e6:	0c 00 00 
    base.s.size = 0;
 8e9:	c7 05 6c 0c 00 00 00 	movl   $0x0,0xc6c
 8f0:	00 00 00 
    if(p->s.size >= nunits){
 8f3:	e9 54 ff ff ff       	jmp    84c <malloc+0x2c>
 8f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8ff:	00 
        prevp->s.ptr = p->s.ptr;
 900:	8b 08                	mov    (%eax),%ecx
 902:	89 0a                	mov    %ecx,(%edx)
 904:	eb b9                	jmp    8bf <malloc+0x9f>
