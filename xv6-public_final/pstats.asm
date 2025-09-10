
_pstats:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "pstat.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
  struct pstat ps;

  if(getpinfo(&ps) < 0){
   f:	8d 9d e8 f1 ff ff    	lea    -0xe18(%ebp),%ebx
{
  15:	51                   	push   %ecx
  16:	81 ec 18 0e 00 00    	sub    $0xe18,%esp
  if(getpinfo(&ps) < 0){
  1c:	53                   	push   %ebx
  1d:	e8 c8 03 00 00       	call   3ea <getpinfo>
  22:	83 c4 10             	add    $0x10,%esp
  25:	85 c0                	test   %eax,%eax
  27:	78 70                	js     99 <main+0x99>
    printf(1, "getpinfo failed\n");
    exit();
  }

  printf(1, "PID\tTickets\tRtime\tRetime\tStime\n");
  29:	52                   	push   %edx
  2a:	8d b5 e8 f2 ff ff    	lea    -0xd18(%ebp),%esi
  30:	52                   	push   %edx
  31:	68 70 08 00 00       	push   $0x870
  36:	6a 01                	push   $0x1
  38:	e8 a3 04 00 00       	call   4e0 <printf>
  for(int i = 0; i < NPROC; i++){
  3d:	83 c4 10             	add    $0x10,%esp
  40:	eb 15                	jmp    57 <main+0x57>
  42:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  49:	00 
  4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  50:	83 c3 04             	add    $0x4,%ebx
  53:	39 f3                	cmp    %esi,%ebx
  55:	74 3d                	je     94 <main+0x94>
    if(ps.inuse[i]){
  57:	8b 03                	mov    (%ebx),%eax
  59:	85 c0                	test   %eax,%eax
  5b:	74 f3                	je     50 <main+0x50>
      printf(1, "%d\t%d\t%d\t%d\t%d\n",
  5d:	83 ec 04             	sub    $0x4,%esp
  60:	ff b3 00 06 00 00    	push   0x600(%ebx)
  for(int i = 0; i < NPROC; i++){
  66:	83 c3 04             	add    $0x4,%ebx
      printf(1, "%d\t%d\t%d\t%d\t%d\n",
  69:	ff b3 fc 06 00 00    	push   0x6fc(%ebx)
  6f:	ff b3 fc 04 00 00    	push   0x4fc(%ebx)
  75:	ff b3 fc 02 00 00    	push   0x2fc(%ebx)
  7b:	ff b3 fc 00 00 00    	push   0xfc(%ebx)
  81:	68 59 08 00 00       	push   $0x859
  86:	6a 01                	push   $0x1
  88:	e8 53 04 00 00       	call   4e0 <printf>
  8d:	83 c4 20             	add    $0x20,%esp
  for(int i = 0; i < NPROC; i++){
  90:	39 f3                	cmp    %esi,%ebx
  92:	75 c3                	jne    57 <main+0x57>
             ps.retime[i],
             ps.stime[i]);
    }
  }

  exit();
  94:	e8 a1 02 00 00       	call   33a <exit>
    printf(1, "getpinfo failed\n");
  99:	51                   	push   %ecx
  9a:	51                   	push   %ecx
  9b:	68 48 08 00 00       	push   $0x848
  a0:	6a 01                	push   $0x1
  a2:	e8 39 04 00 00       	call   4e0 <printf>
    exit();
  a7:	e8 8e 02 00 00       	call   33a <exit>
  ac:	66 90                	xchg   %ax,%ax
  ae:	66 90                	xchg   %ax,%ax
  b0:	66 90                	xchg   %ax,%ax
  b2:	66 90                	xchg   %ax,%ax
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  c0:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
  c1:	31 c0                	xor    %eax,%eax
{
  c3:	89 e5                	mov    %esp,%ebp
  c5:	53                   	push   %ebx
  c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
  d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  d7:	83 c0 01             	add    $0x1,%eax
  da:	84 d2                	test   %dl,%dl
  dc:	75 f2                	jne    d0 <strcpy+0x10>
  return os;
}
  de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  e1:	89 c8                	mov    %ecx,%eax
  e3:	c9                   	leave
  e4:	c3                   	ret
  e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ec:	00 
  ed:	8d 76 00             	lea    0x0(%esi),%esi

000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
  f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  fa:	0f b6 02             	movzbl (%edx),%eax
  fd:	84 c0                	test   %al,%al
  ff:	75 2f                	jne    130 <strcmp+0x40>
 101:	eb 4a                	jmp    14d <strcmp+0x5d>
 103:	eb 1b                	jmp    120 <strcmp+0x30>
 105:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10c:	00 
 10d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 114:	00 
 115:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11c:	00 
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 124:	83 c2 01             	add    $0x1,%edx
 127:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 12a:	84 c0                	test   %al,%al
 12c:	74 12                	je     140 <strcmp+0x50>
 12e:	89 d9                	mov    %ebx,%ecx
 130:	0f b6 19             	movzbl (%ecx),%ebx
 133:	38 c3                	cmp    %al,%bl
 135:	74 e9                	je     120 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 137:	29 d8                	sub    %ebx,%eax
}
 139:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 13c:	c9                   	leave
 13d:	c3                   	ret
 13e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 140:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 144:	31 c0                	xor    %eax,%eax
 146:	29 d8                	sub    %ebx,%eax
}
 148:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 14b:	c9                   	leave
 14c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 14d:	0f b6 19             	movzbl (%ecx),%ebx
 150:	31 c0                	xor    %eax,%eax
 152:	eb e3                	jmp    137 <strcmp+0x47>
 154:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 15b:	00 
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000160 <strlen>:

uint
strlen(const char *s)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 166:	80 3a 00             	cmpb   $0x0,(%edx)
 169:	74 15                	je     180 <strlen+0x20>
 16b:	31 c0                	xor    %eax,%eax
 16d:	8d 76 00             	lea    0x0(%esi),%esi
 170:	83 c0 01             	add    $0x1,%eax
 173:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 177:	89 c1                	mov    %eax,%ecx
 179:	75 f5                	jne    170 <strlen+0x10>
  return n;
}
 17b:	89 c8                	mov    %ecx,%eax
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret
 17f:	90                   	nop
  for(n = 0; s[n]; n++);
 180:	31 c9                	xor    %ecx,%ecx
}
 182:	5d                   	pop    %ebp
 183:	89 c8                	mov    %ecx,%eax
 185:	c3                   	ret
 186:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18d:	00 
 18e:	66 90                	xchg   %ax,%ax

00000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 197:	8b 4d 10             	mov    0x10(%ebp),%ecx
 19a:	8b 45 0c             	mov    0xc(%ebp),%eax
 19d:	89 d7                	mov    %edx,%edi
 19f:	fc                   	cld
 1a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1a2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1a5:	89 d0                	mov    %edx,%eax
 1a7:	c9                   	leave
 1a8:	c3                   	ret
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001b0 <strchr>:

char*
strchr(const char *s, char c)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ba:	0f b6 10             	movzbl (%eax),%edx
 1bd:	84 d2                	test   %dl,%dl
 1bf:	75 1a                	jne    1db <strchr+0x2b>
 1c1:	eb 25                	jmp    1e8 <strchr+0x38>
 1c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ca:	00 
 1cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1d0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1d4:	83 c0 01             	add    $0x1,%eax
 1d7:	84 d2                	test   %dl,%dl
 1d9:	74 0d                	je     1e8 <strchr+0x38>
    if(*s == c)
 1db:	38 d1                	cmp    %dl,%cl
 1dd:	75 f1                	jne    1d0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1df:	5d                   	pop    %ebp
 1e0:	c3                   	ret
 1e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1e8:	31 c0                	xor    %eax,%eax
}
 1ea:	5d                   	pop    %ebp
 1eb:	c3                   	ret
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001f0 <gets>:

char*
gets(char *buf, int max)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 1f5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 1f8:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 1f9:	31 db                	xor    %ebx,%ebx
{
 1fb:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 1fe:	eb 27                	jmp    227 <gets+0x37>
    cc = read(0, &c, 1);
 200:	83 ec 04             	sub    $0x4,%esp
 203:	6a 01                	push   $0x1
 205:	56                   	push   %esi
 206:	6a 00                	push   $0x0
 208:	e8 45 01 00 00       	call   352 <read>
    if(cc < 1)
 20d:	83 c4 10             	add    $0x10,%esp
 210:	85 c0                	test   %eax,%eax
 212:	7e 1d                	jle    231 <gets+0x41>
      break;
    buf[i++] = c;
 214:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 218:	8b 55 08             	mov    0x8(%ebp),%edx
 21b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 21f:	3c 0a                	cmp    $0xa,%al
 221:	74 10                	je     233 <gets+0x43>
 223:	3c 0d                	cmp    $0xd,%al
 225:	74 0c                	je     233 <gets+0x43>
  for(i = 0; i+1 < max; ){
 227:	89 df                	mov    %ebx,%edi
 229:	83 c3 01             	add    $0x1,%ebx
 22c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 22f:	7c cf                	jl     200 <gets+0x10>
 231:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 23a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 23d:	5b                   	pop    %ebx
 23e:	5e                   	pop    %esi
 23f:	5f                   	pop    %edi
 240:	5d                   	pop    %ebp
 241:	c3                   	ret
 242:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 249:	00 
 24a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000250 <stat>:

int
stat(const char *n, struct stat *st)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 255:	83 ec 08             	sub    $0x8,%esp
 258:	6a 00                	push   $0x0
 25a:	ff 75 08             	push   0x8(%ebp)
 25d:	e8 40 01 00 00       	call   3a2 <open>
  if(fd < 0)
 262:	83 c4 10             	add    $0x10,%esp
 265:	85 c0                	test   %eax,%eax
 267:	78 27                	js     290 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 269:	83 ec 08             	sub    $0x8,%esp
 26c:	ff 75 0c             	push   0xc(%ebp)
 26f:	89 c3                	mov    %eax,%ebx
 271:	50                   	push   %eax
 272:	e8 f3 00 00 00       	call   36a <fstat>
  close(fd);
 277:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 27a:	89 c6                	mov    %eax,%esi
  close(fd);
 27c:	e8 51 01 00 00       	call   3d2 <close>
  return r;
 281:	83 c4 10             	add    $0x10,%esp
}
 284:	8d 65 f8             	lea    -0x8(%ebp),%esp
 287:	89 f0                	mov    %esi,%eax
 289:	5b                   	pop    %ebx
 28a:	5e                   	pop    %esi
 28b:	5d                   	pop    %ebp
 28c:	c3                   	ret
 28d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 290:	be ff ff ff ff       	mov    $0xffffffff,%esi
 295:	eb ed                	jmp    284 <stat+0x34>
 297:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29e:	00 
 29f:	90                   	nop

000002a0 <atoi>:

int
atoi(const char *s)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	53                   	push   %ebx
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2a7:	0f be 02             	movsbl (%edx),%eax
 2aa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2ad:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2b0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2b5:	77 1e                	ja     2d5 <atoi+0x35>
 2b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2be:	00 
 2bf:	90                   	nop
    n = n*10 + *s++ - '0';
 2c0:	83 c2 01             	add    $0x1,%edx
 2c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2ca:	0f be 02             	movsbl (%edx),%eax
 2cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2d0:	80 fb 09             	cmp    $0x9,%bl
 2d3:	76 eb                	jbe    2c0 <atoi+0x20>
  return n;
}
 2d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2d8:	89 c8                	mov    %ecx,%eax
 2da:	c9                   	leave
 2db:	c3                   	ret
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	57                   	push   %edi
 2e4:	8b 55 08             	mov    0x8(%ebp),%edx
 2e7:	8b 45 10             	mov    0x10(%ebp),%eax
 2ea:	56                   	push   %esi
 2eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 2ee:	39 f2                	cmp    %esi,%edx
 2f0:	73 1e                	jae    310 <memmove+0x30>
    while(n-- > 0)
 2f2:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 2f5:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 2f7:	85 c0                	test   %eax,%eax
 2f9:	7e 0a                	jle    305 <memmove+0x25>
 2fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 300:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 301:	39 f9                	cmp    %edi,%ecx
 303:	75 fb                	jne    300 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 305:	5e                   	pop    %esi
 306:	89 d0                	mov    %edx,%eax
 308:	5f                   	pop    %edi
 309:	5d                   	pop    %ebp
 30a:	c3                   	ret
 30b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 310:	85 c0                	test   %eax,%eax
 312:	7e f1                	jle    305 <memmove+0x25>
    while(n-- > 0)
 314:	83 e8 01             	sub    $0x1,%eax
 317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31e:	00 
 31f:	90                   	nop
      *--dst = *--src;
 320:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 324:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 327:	83 e8 01             	sub    $0x1,%eax
 32a:	73 f4                	jae    320 <memmove+0x40>
}
 32c:	5e                   	pop    %esi
 32d:	89 d0                	mov    %edx,%eax
 32f:	5f                   	pop    %edi
 330:	5d                   	pop    %ebp
 331:	c3                   	ret

00000332 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 332:	b8 01 00 00 00       	mov    $0x1,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret

0000033a <exit>:
SYSCALL(exit)
 33a:	b8 02 00 00 00       	mov    $0x2,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret

00000342 <wait>:
SYSCALL(wait)
 342:	b8 03 00 00 00       	mov    $0x3,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret

0000034a <pipe>:
SYSCALL(pipe)
 34a:	b8 04 00 00 00       	mov    $0x4,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret

00000352 <read>:
SYSCALL(read)
 352:	b8 05 00 00 00       	mov    $0x5,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret

0000035a <kill>:
SYSCALL(kill)
 35a:	b8 06 00 00 00       	mov    $0x6,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret

00000362 <exec>:
SYSCALL(exec)
 362:	b8 07 00 00 00       	mov    $0x7,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret

0000036a <fstat>:
SYSCALL(fstat)
 36a:	b8 08 00 00 00       	mov    $0x8,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret

00000372 <chdir>:
SYSCALL(chdir)
 372:	b8 09 00 00 00       	mov    $0x9,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret

0000037a <dup>:
SYSCALL(dup)
 37a:	b8 0a 00 00 00       	mov    $0xa,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret

00000382 <getpid>:
SYSCALL(getpid)
 382:	b8 0b 00 00 00       	mov    $0xb,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret

0000038a <sbrk>:
SYSCALL(sbrk)
 38a:	b8 0c 00 00 00       	mov    $0xc,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret

00000392 <sleep>:
SYSCALL(sleep)
 392:	b8 0d 00 00 00       	mov    $0xd,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret

0000039a <uptime>:
SYSCALL(uptime)
 39a:	b8 0e 00 00 00       	mov    $0xe,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret

000003a2 <open>:
SYSCALL(open)
 3a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret

000003aa <write>:
SYSCALL(write)
 3aa:	b8 10 00 00 00       	mov    $0x10,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret

000003b2 <mknod>:
SYSCALL(mknod)
 3b2:	b8 11 00 00 00       	mov    $0x11,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret

000003ba <unlink>:
SYSCALL(unlink)
 3ba:	b8 12 00 00 00       	mov    $0x12,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret

000003c2 <link>:
SYSCALL(link)
 3c2:	b8 13 00 00 00       	mov    $0x13,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret

000003ca <mkdir>:
SYSCALL(mkdir)
 3ca:	b8 14 00 00 00       	mov    $0x14,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret

000003d2 <close>:
SYSCALL(close)
 3d2:	b8 15 00 00 00       	mov    $0x15,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret

000003da <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 3da:	b8 16 00 00 00       	mov    $0x16,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret

000003e2 <settickets>:
SYSCALL(settickets)
 3e2:	b8 17 00 00 00       	mov    $0x17,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret

000003ea <getpinfo>:
SYSCALL(getpinfo)
 3ea:	b8 18 00 00 00       	mov    $0x18,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret

000003f2 <waitx>:
SYSCALL(waitx)
 3f2:	b8 19 00 00 00       	mov    $0x19,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret

000003fa <yield>:
SYSCALL(yield)
 3fa:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret
 402:	66 90                	xchg   %ax,%ax
 404:	66 90                	xchg   %ax,%ax
 406:	66 90                	xchg   %ax,%ax
 408:	66 90                	xchg   %ax,%ax
 40a:	66 90                	xchg   %ax,%ax
 40c:	66 90                	xchg   %ax,%ax
 40e:	66 90                	xchg   %ax,%ax
 410:	66 90                	xchg   %ax,%ax
 412:	66 90                	xchg   %ax,%ax
 414:	66 90                	xchg   %ax,%ax
 416:	66 90                	xchg   %ax,%ax
 418:	66 90                	xchg   %ax,%ax
 41a:	66 90                	xchg   %ax,%ax
 41c:	66 90                	xchg   %ax,%ax
 41e:	66 90                	xchg   %ax,%ax

00000420 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 428:	89 d1                	mov    %edx,%ecx
{
 42a:	83 ec 3c             	sub    $0x3c,%esp
 42d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 430:	85 d2                	test   %edx,%edx
 432:	0f 89 98 00 00 00    	jns    4d0 <printint+0xb0>
 438:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 43c:	0f 84 8e 00 00 00    	je     4d0 <printint+0xb0>
    x = -xx;
 442:	f7 d9                	neg    %ecx
    neg = 1;
 444:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 449:	89 45 c0             	mov    %eax,-0x40(%ebp)
 44c:	31 f6                	xor    %esi,%esi
 44e:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 455:	00 
 456:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45d:	00 
 45e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 460:	89 c8                	mov    %ecx,%eax
 462:	31 d2                	xor    %edx,%edx
 464:	89 f7                	mov    %esi,%edi
 466:	f7 f3                	div    %ebx
 468:	8d 76 01             	lea    0x1(%esi),%esi
 46b:	0f b6 92 e8 08 00 00 	movzbl 0x8e8(%edx),%edx
 472:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 476:	89 ca                	mov    %ecx,%edx
 478:	89 c1                	mov    %eax,%ecx
 47a:	39 da                	cmp    %ebx,%edx
 47c:	73 e2                	jae    460 <printint+0x40>
  if(neg)
 47e:	8b 45 c0             	mov    -0x40(%ebp),%eax
 481:	85 c0                	test   %eax,%eax
 483:	74 07                	je     48c <printint+0x6c>
    buf[i++] = '-';
 485:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 48a:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 48c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 48f:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 492:	01 df                	add    %ebx,%edi
 494:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49b:	00 
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 4a0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4a3:	83 ec 04             	sub    $0x4,%esp
 4a6:	88 45 d7             	mov    %al,-0x29(%ebp)
 4a9:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4ac:	6a 01                	push   $0x1
 4ae:	50                   	push   %eax
 4af:	56                   	push   %esi
 4b0:	e8 f5 fe ff ff       	call   3aa <write>
  while(--i >= 0)
 4b5:	89 f8                	mov    %edi,%eax
 4b7:	83 c4 10             	add    $0x10,%esp
 4ba:	83 ef 01             	sub    $0x1,%edi
 4bd:	39 d8                	cmp    %ebx,%eax
 4bf:	75 df                	jne    4a0 <printint+0x80>
}
 4c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c4:	5b                   	pop    %ebx
 4c5:	5e                   	pop    %esi
 4c6:	5f                   	pop    %edi
 4c7:	5d                   	pop    %ebp
 4c8:	c3                   	ret
 4c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4d0:	31 c0                	xor    %eax,%eax
 4d2:	e9 72 ff ff ff       	jmp    449 <printint+0x29>
 4d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4de:	00 
 4df:	90                   	nop

000004e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4ec:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4ef:	0f b6 13             	movzbl (%ebx),%edx
 4f2:	83 c3 01             	add    $0x1,%ebx
 4f5:	84 d2                	test   %dl,%dl
 4f7:	0f 84 a0 00 00 00    	je     59d <printf+0xbd>
 4fd:	8d 45 10             	lea    0x10(%ebp),%eax
 500:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 503:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 506:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 509:	eb 28                	jmp    533 <printf+0x53>
 50b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 510:	83 ec 04             	sub    $0x4,%esp
 513:	8d 45 e7             	lea    -0x19(%ebp),%eax
 516:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 519:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 51c:	6a 01                	push   $0x1
 51e:	50                   	push   %eax
 51f:	56                   	push   %esi
 520:	e8 85 fe ff ff       	call   3aa <write>
  for(i = 0; fmt[i]; i++){
 525:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 529:	83 c4 10             	add    $0x10,%esp
 52c:	84 d2                	test   %dl,%dl
 52e:	74 6d                	je     59d <printf+0xbd>
    c = fmt[i] & 0xff;
 530:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 533:	83 f8 25             	cmp    $0x25,%eax
 536:	75 d8                	jne    510 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 538:	0f b6 13             	movzbl (%ebx),%edx
 53b:	84 d2                	test   %dl,%dl
 53d:	74 5e                	je     59d <printf+0xbd>
    c = fmt[i] & 0xff;
 53f:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 542:	80 fa 25             	cmp    $0x25,%dl
 545:	0f 84 1d 01 00 00    	je     668 <printf+0x188>
 54b:	83 e8 63             	sub    $0x63,%eax
 54e:	83 f8 15             	cmp    $0x15,%eax
 551:	77 0d                	ja     560 <printf+0x80>
 553:	ff 24 85 90 08 00 00 	jmp    *0x890(,%eax,4)
 55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 560:	83 ec 04             	sub    $0x4,%esp
 563:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 566:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 569:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 56d:	6a 01                	push   $0x1
 56f:	51                   	push   %ecx
 570:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 573:	56                   	push   %esi
 574:	e8 31 fe ff ff       	call   3aa <write>
        putc(fd, c);
 579:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 57d:	83 c4 0c             	add    $0xc,%esp
 580:	88 55 e7             	mov    %dl,-0x19(%ebp)
 583:	6a 01                	push   $0x1
 585:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 588:	51                   	push   %ecx
 589:	56                   	push   %esi
 58a:	e8 1b fe ff ff       	call   3aa <write>
  for(i = 0; fmt[i]; i++){
 58f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 593:	83 c3 02             	add    $0x2,%ebx
 596:	83 c4 10             	add    $0x10,%esp
 599:	84 d2                	test   %dl,%dl
 59b:	75 93                	jne    530 <printf+0x50>
      }
      state = 0;
    }
  }
}
 59d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5a0:	5b                   	pop    %ebx
 5a1:	5e                   	pop    %esi
 5a2:	5f                   	pop    %edi
 5a3:	5d                   	pop    %ebp
 5a4:	c3                   	ret
 5a5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5a8:	83 ec 0c             	sub    $0xc,%esp
 5ab:	8b 17                	mov    (%edi),%edx
 5ad:	b9 10 00 00 00       	mov    $0x10,%ecx
 5b2:	89 f0                	mov    %esi,%eax
 5b4:	6a 00                	push   $0x0
        ap++;
 5b6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 5b9:	e8 62 fe ff ff       	call   420 <printint>
  for(i = 0; fmt[i]; i++){
 5be:	eb cf                	jmp    58f <printf+0xaf>
        s = (char*)*ap;
 5c0:	8b 07                	mov    (%edi),%eax
        ap++;
 5c2:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 5c5:	85 c0                	test   %eax,%eax
 5c7:	0f 84 b3 00 00 00    	je     680 <printf+0x1a0>
        while(*s != 0){
 5cd:	0f b6 10             	movzbl (%eax),%edx
 5d0:	84 d2                	test   %dl,%dl
 5d2:	0f 84 ba 00 00 00    	je     692 <printf+0x1b2>
 5d8:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5db:	89 c7                	mov    %eax,%edi
 5dd:	89 d0                	mov    %edx,%eax
 5df:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5e2:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5e5:	89 fb                	mov    %edi,%ebx
 5e7:	89 cf                	mov    %ecx,%edi
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5f0:	83 ec 04             	sub    $0x4,%esp
 5f3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 5f6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 5f9:	6a 01                	push   $0x1
 5fb:	57                   	push   %edi
 5fc:	56                   	push   %esi
 5fd:	e8 a8 fd ff ff       	call   3aa <write>
        while(*s != 0){
 602:	0f b6 03             	movzbl (%ebx),%eax
 605:	83 c4 10             	add    $0x10,%esp
 608:	84 c0                	test   %al,%al
 60a:	75 e4                	jne    5f0 <printf+0x110>
 60c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 60f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 613:	83 c3 02             	add    $0x2,%ebx
 616:	84 d2                	test   %dl,%dl
 618:	0f 85 e5 fe ff ff    	jne    503 <printf+0x23>
 61e:	e9 7a ff ff ff       	jmp    59d <printf+0xbd>
 623:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 628:	83 ec 0c             	sub    $0xc,%esp
 62b:	8b 17                	mov    (%edi),%edx
 62d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 632:	89 f0                	mov    %esi,%eax
 634:	6a 01                	push   $0x1
        ap++;
 636:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 639:	e8 e2 fd ff ff       	call   420 <printint>
  for(i = 0; fmt[i]; i++){
 63e:	e9 4c ff ff ff       	jmp    58f <printf+0xaf>
 643:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 648:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 64a:	83 ec 04             	sub    $0x4,%esp
 64d:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 650:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 653:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 656:	6a 01                	push   $0x1
 658:	51                   	push   %ecx
 659:	56                   	push   %esi
 65a:	e8 4b fd ff ff       	call   3aa <write>
  for(i = 0; fmt[i]; i++){
 65f:	e9 2b ff ff ff       	jmp    58f <printf+0xaf>
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 668:	83 ec 04             	sub    $0x4,%esp
 66b:	88 55 e7             	mov    %dl,-0x19(%ebp)
 66e:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 671:	6a 01                	push   $0x1
 673:	e9 10 ff ff ff       	jmp    588 <printf+0xa8>
 678:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 67f:	00 
          s = "(null)";
 680:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 683:	b8 28 00 00 00       	mov    $0x28,%eax
 688:	bf 69 08 00 00       	mov    $0x869,%edi
 68d:	e9 4d ff ff ff       	jmp    5df <printf+0xff>
  for(i = 0; fmt[i]; i++){
 692:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 696:	83 c3 02             	add    $0x2,%ebx
 699:	84 d2                	test   %dl,%dl
 69b:	0f 85 8f fe ff ff    	jne    530 <printf+0x50>
 6a1:	e9 f7 fe ff ff       	jmp    59d <printf+0xbd>
 6a6:	66 90                	xchg   %ax,%ax
 6a8:	66 90                	xchg   %ax,%ax
 6aa:	66 90                	xchg   %ax,%ax
 6ac:	66 90                	xchg   %ax,%ax
 6ae:	66 90                	xchg   %ax,%ax
 6b0:	66 90                	xchg   %ax,%ax
 6b2:	66 90                	xchg   %ax,%ax
 6b4:	66 90                	xchg   %ax,%ax
 6b6:	66 90                	xchg   %ax,%ax
 6b8:	66 90                	xchg   %ax,%ax
 6ba:	66 90                	xchg   %ax,%ax
 6bc:	66 90                	xchg   %ax,%ax
 6be:	66 90                	xchg   %ax,%ax

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 98 0b 00 00       	mov    0xb98,%eax
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6d8:	00 
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6e0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e4:	39 ca                	cmp    %ecx,%edx
 6e6:	73 30                	jae    718 <free+0x58>
 6e8:	39 c1                	cmp    %eax,%ecx
 6ea:	72 04                	jb     6f0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ec:	39 c2                	cmp    %eax,%edx
 6ee:	72 f0                	jb     6e0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6f3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6f6:	39 f8                	cmp    %edi,%eax
 6f8:	74 36                	je     730 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6fa:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6fd:	8b 42 04             	mov    0x4(%edx),%eax
 700:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 703:	39 f1                	cmp    %esi,%ecx
 705:	74 40                	je     747 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 707:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 709:	5b                   	pop    %ebx
  freep = p;
 70a:	89 15 98 0b 00 00    	mov    %edx,0xb98
}
 710:	5e                   	pop    %esi
 711:	5f                   	pop    %edi
 712:	5d                   	pop    %ebp
 713:	c3                   	ret
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 718:	39 c2                	cmp    %eax,%edx
 71a:	72 c4                	jb     6e0 <free+0x20>
 71c:	39 c1                	cmp    %eax,%ecx
 71e:	73 c0                	jae    6e0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 720:	8b 73 fc             	mov    -0x4(%ebx),%esi
 723:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 726:	39 f8                	cmp    %edi,%eax
 728:	75 d0                	jne    6fa <free+0x3a>
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 730:	03 70 04             	add    0x4(%eax),%esi
 733:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 736:	8b 02                	mov    (%edx),%eax
 738:	8b 00                	mov    (%eax),%eax
 73a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 73d:	8b 42 04             	mov    0x4(%edx),%eax
 740:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 743:	39 f1                	cmp    %esi,%ecx
 745:	75 c0                	jne    707 <free+0x47>
    p->s.size += bp->s.size;
 747:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 74a:	89 15 98 0b 00 00    	mov    %edx,0xb98
    p->s.size += bp->s.size;
 750:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 753:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 756:	89 0a                	mov    %ecx,(%edx)
}
 758:	5b                   	pop    %ebx
 759:	5e                   	pop    %esi
 75a:	5f                   	pop    %edi
 75b:	5d                   	pop    %ebp
 75c:	c3                   	ret
 75d:	8d 76 00             	lea    0x0(%esi),%esi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 15 98 0b 00 00    	mov    0xb98,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 78 07             	lea    0x7(%eax),%edi
 775:	c1 ef 03             	shr    $0x3,%edi
 778:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 77b:	85 d2                	test   %edx,%edx
 77d:	0f 84 8d 00 00 00    	je     810 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 783:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 785:	8b 48 04             	mov    0x4(%eax),%ecx
 788:	39 f9                	cmp    %edi,%ecx
 78a:	73 64                	jae    7f0 <malloc+0x90>
  if(nu < 4096)
 78c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 791:	39 df                	cmp    %ebx,%edi
 793:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 796:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 79d:	eb 0a                	jmp    7a9 <malloc+0x49>
 79f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7a2:	8b 48 04             	mov    0x4(%eax),%ecx
 7a5:	39 f9                	cmp    %edi,%ecx
 7a7:	73 47                	jae    7f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a9:	89 c2                	mov    %eax,%edx
 7ab:	39 05 98 0b 00 00    	cmp    %eax,0xb98
 7b1:	75 ed                	jne    7a0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7b3:	83 ec 0c             	sub    $0xc,%esp
 7b6:	56                   	push   %esi
 7b7:	e8 ce fb ff ff       	call   38a <sbrk>
  if(p == (char*)-1)
 7bc:	83 c4 10             	add    $0x10,%esp
 7bf:	83 f8 ff             	cmp    $0xffffffff,%eax
 7c2:	74 1c                	je     7e0 <malloc+0x80>
  hp->s.size = nu;
 7c4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7c7:	83 ec 0c             	sub    $0xc,%esp
 7ca:	83 c0 08             	add    $0x8,%eax
 7cd:	50                   	push   %eax
 7ce:	e8 ed fe ff ff       	call   6c0 <free>
  return freep;
 7d3:	8b 15 98 0b 00 00    	mov    0xb98,%edx
      if((p = morecore(nunits)) == 0)
 7d9:	83 c4 10             	add    $0x10,%esp
 7dc:	85 d2                	test   %edx,%edx
 7de:	75 c0                	jne    7a0 <malloc+0x40>
        return 0;
  }
}
 7e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7e3:	31 c0                	xor    %eax,%eax
}
 7e5:	5b                   	pop    %ebx
 7e6:	5e                   	pop    %esi
 7e7:	5f                   	pop    %edi
 7e8:	5d                   	pop    %ebp
 7e9:	c3                   	ret
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7f0:	39 cf                	cmp    %ecx,%edi
 7f2:	74 4c                	je     840 <malloc+0xe0>
        p->s.size -= nunits;
 7f4:	29 f9                	sub    %edi,%ecx
 7f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7fc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7ff:	89 15 98 0b 00 00    	mov    %edx,0xb98
}
 805:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 808:	83 c0 08             	add    $0x8,%eax
}
 80b:	5b                   	pop    %ebx
 80c:	5e                   	pop    %esi
 80d:	5f                   	pop    %edi
 80e:	5d                   	pop    %ebp
 80f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 810:	c7 05 98 0b 00 00 9c 	movl   $0xb9c,0xb98
 817:	0b 00 00 
    base.s.size = 0;
 81a:	b8 9c 0b 00 00       	mov    $0xb9c,%eax
    base.s.ptr = freep = prevp = &base;
 81f:	c7 05 9c 0b 00 00 9c 	movl   $0xb9c,0xb9c
 826:	0b 00 00 
    base.s.size = 0;
 829:	c7 05 a0 0b 00 00 00 	movl   $0x0,0xba0
 830:	00 00 00 
    if(p->s.size >= nunits){
 833:	e9 54 ff ff ff       	jmp    78c <malloc+0x2c>
 838:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 83f:	00 
        prevp->s.ptr = p->s.ptr;
 840:	8b 08                	mov    (%eax),%ecx
 842:	89 0a                	mov    %ecx,(%edx)
 844:	eb b9                	jmp    7ff <malloc+0x9f>
