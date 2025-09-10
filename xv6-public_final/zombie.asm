
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 9c 02 00 00       	call   2b2 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 ee 02 00 00       	call   312 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 8e 02 00 00       	call   2ba <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax
  30:	66 90                	xchg   %ax,%ax
  32:	66 90                	xchg   %ax,%ax
  34:	66 90                	xchg   %ax,%ax
  36:	66 90                	xchg   %ax,%ax
  38:	66 90                	xchg   %ax,%ax
  3a:	66 90                	xchg   %ax,%ax
  3c:	66 90                	xchg   %ax,%ax
  3e:	66 90                	xchg   %ax,%ax

00000040 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  40:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
  41:	31 c0                	xor    %eax,%eax
{
  43:	89 e5                	mov    %esp,%ebp
  45:	53                   	push   %ebx
  46:	8b 4d 08             	mov    0x8(%ebp),%ecx
  49:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
  50:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  54:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  57:	83 c0 01             	add    $0x1,%eax
  5a:	84 d2                	test   %dl,%dl
  5c:	75 f2                	jne    50 <strcpy+0x10>
  return os;
}
  5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  61:	89 c8                	mov    %ecx,%eax
  63:	c9                   	leave
  64:	c3                   	ret
  65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  6c:	00 
  6d:	8d 76 00             	lea    0x0(%esi),%esi

00000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 55 08             	mov    0x8(%ebp),%edx
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  7a:	0f b6 02             	movzbl (%edx),%eax
  7d:	84 c0                	test   %al,%al
  7f:	75 2f                	jne    b0 <strcmp+0x40>
  81:	eb 4a                	jmp    cd <strcmp+0x5d>
  83:	eb 1b                	jmp    a0 <strcmp+0x30>
  85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  8c:	00 
  8d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  94:	00 
  95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  9c:	00 
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  a4:	83 c2 01             	add    $0x1,%edx
  a7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  aa:	84 c0                	test   %al,%al
  ac:	74 12                	je     c0 <strcmp+0x50>
  ae:	89 d9                	mov    %ebx,%ecx
  b0:	0f b6 19             	movzbl (%ecx),%ebx
  b3:	38 c3                	cmp    %al,%bl
  b5:	74 e9                	je     a0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
  b7:	29 d8                	sub    %ebx,%eax
}
  b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  bc:	c9                   	leave
  bd:	c3                   	ret
  be:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  c4:	31 c0                	xor    %eax,%eax
  c6:	29 d8                	sub    %ebx,%eax
}
  c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  cb:	c9                   	leave
  cc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  cd:	0f b6 19             	movzbl (%ecx),%ebx
  d0:	31 c0                	xor    %eax,%eax
  d2:	eb e3                	jmp    b7 <strcmp+0x47>
  d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  db:	00 
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
  e6:	80 3a 00             	cmpb   $0x0,(%edx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 c0                	xor    %eax,%eax
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c0 01             	add    $0x1,%eax
  f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  f7:	89 c1                	mov    %eax,%ecx
  f9:	75 f5                	jne    f0 <strlen+0x10>
  return n;
}
  fb:	89 c8                	mov    %ecx,%eax
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret
  ff:	90                   	nop
  for(n = 0; s[n]; n++);
 100:	31 c9                	xor    %ecx,%ecx
}
 102:	5d                   	pop    %ebp
 103:	89 c8                	mov    %ecx,%eax
 105:	c3                   	ret
 106:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10d:	00 
 10e:	66 90                	xchg   %ax,%ax

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	8b 7d fc             	mov    -0x4(%ebp),%edi
 125:	89 d0                	mov    %edx,%eax
 127:	c9                   	leave
 128:	c3                   	ret
 129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	75 1a                	jne    15b <strchr+0x2b>
 141:	eb 25                	jmp    168 <strchr+0x38>
 143:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14a:	00 
 14b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 150:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 154:	83 c0 01             	add    $0x1,%eax
 157:	84 d2                	test   %dl,%dl
 159:	74 0d                	je     168 <strchr+0x38>
    if(*s == c)
 15b:	38 d1                	cmp    %dl,%cl
 15d:	75 f1                	jne    150 <strchr+0x20>
      return (char*)s;
  return 0;
}
 15f:	5d                   	pop    %ebp
 160:	c3                   	ret
 161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 168:	31 c0                	xor    %eax,%eax
}
 16a:	5d                   	pop    %ebp
 16b:	c3                   	ret
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 175:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 178:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 179:	31 db                	xor    %ebx,%ebx
{
 17b:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 17e:	eb 27                	jmp    1a7 <gets+0x37>
    cc = read(0, &c, 1);
 180:	83 ec 04             	sub    $0x4,%esp
 183:	6a 01                	push   $0x1
 185:	56                   	push   %esi
 186:	6a 00                	push   $0x0
 188:	e8 45 01 00 00       	call   2d2 <read>
    if(cc < 1)
 18d:	83 c4 10             	add    $0x10,%esp
 190:	85 c0                	test   %eax,%eax
 192:	7e 1d                	jle    1b1 <gets+0x41>
      break;
    buf[i++] = c;
 194:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 198:	8b 55 08             	mov    0x8(%ebp),%edx
 19b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 19f:	3c 0a                	cmp    $0xa,%al
 1a1:	74 10                	je     1b3 <gets+0x43>
 1a3:	3c 0d                	cmp    $0xd,%al
 1a5:	74 0c                	je     1b3 <gets+0x43>
  for(i = 0; i+1 < max; ){
 1a7:	89 df                	mov    %ebx,%edi
 1a9:	83 c3 01             	add    $0x1,%ebx
 1ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1af:	7c cf                	jl     180 <gets+0x10>
 1b1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 1ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1bd:	5b                   	pop    %ebx
 1be:	5e                   	pop    %esi
 1bf:	5f                   	pop    %edi
 1c0:	5d                   	pop    %ebp
 1c1:	c3                   	ret
 1c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1c9:	00 
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 1d5:	83 ec 08             	sub    $0x8,%esp
 1d8:	6a 00                	push   $0x0
 1da:	ff 75 08             	push   0x8(%ebp)
 1dd:	e8 40 01 00 00       	call   322 <open>
  if(fd < 0)
 1e2:	83 c4 10             	add    $0x10,%esp
 1e5:	85 c0                	test   %eax,%eax
 1e7:	78 27                	js     210 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1e9:	83 ec 08             	sub    $0x8,%esp
 1ec:	ff 75 0c             	push   0xc(%ebp)
 1ef:	89 c3                	mov    %eax,%ebx
 1f1:	50                   	push   %eax
 1f2:	e8 f3 00 00 00       	call   2ea <fstat>
  close(fd);
 1f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1fa:	89 c6                	mov    %eax,%esi
  close(fd);
 1fc:	e8 51 01 00 00       	call   352 <close>
  return r;
 201:	83 c4 10             	add    $0x10,%esp
}
 204:	8d 65 f8             	lea    -0x8(%ebp),%esp
 207:	89 f0                	mov    %esi,%eax
 209:	5b                   	pop    %ebx
 20a:	5e                   	pop    %esi
 20b:	5d                   	pop    %ebp
 20c:	c3                   	ret
 20d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 210:	be ff ff ff ff       	mov    $0xffffffff,%esi
 215:	eb ed                	jmp    204 <stat+0x34>
 217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21e:	00 
 21f:	90                   	nop

00000220 <atoi>:

int
atoi(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 227:	0f be 02             	movsbl (%edx),%eax
 22a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 22d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 230:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 235:	77 1e                	ja     255 <atoi+0x35>
 237:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23e:	00 
 23f:	90                   	nop
    n = n*10 + *s++ - '0';
 240:	83 c2 01             	add    $0x1,%edx
 243:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 246:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 24a:	0f be 02             	movsbl (%edx),%eax
 24d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 250:	80 fb 09             	cmp    $0x9,%bl
 253:	76 eb                	jbe    240 <atoi+0x20>
  return n;
}
 255:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 258:	89 c8                	mov    %ecx,%eax
 25a:	c9                   	leave
 25b:	c3                   	ret
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	8b 55 08             	mov    0x8(%ebp),%edx
 267:	8b 45 10             	mov    0x10(%ebp),%eax
 26a:	56                   	push   %esi
 26b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 26e:	39 f2                	cmp    %esi,%edx
 270:	73 1e                	jae    290 <memmove+0x30>
    while(n-- > 0)
 272:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 275:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 277:	85 c0                	test   %eax,%eax
 279:	7e 0a                	jle    285 <memmove+0x25>
 27b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 280:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 281:	39 f9                	cmp    %edi,%ecx
 283:	75 fb                	jne    280 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 285:	5e                   	pop    %esi
 286:	89 d0                	mov    %edx,%eax
 288:	5f                   	pop    %edi
 289:	5d                   	pop    %ebp
 28a:	c3                   	ret
 28b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 290:	85 c0                	test   %eax,%eax
 292:	7e f1                	jle    285 <memmove+0x25>
    while(n-- > 0)
 294:	83 e8 01             	sub    $0x1,%eax
 297:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29e:	00 
 29f:	90                   	nop
      *--dst = *--src;
 2a0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 2a4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 2a7:	83 e8 01             	sub    $0x1,%eax
 2aa:	73 f4                	jae    2a0 <memmove+0x40>
}
 2ac:	5e                   	pop    %esi
 2ad:	89 d0                	mov    %edx,%eax
 2af:	5f                   	pop    %edi
 2b0:	5d                   	pop    %ebp
 2b1:	c3                   	ret

000002b2 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 2b2:	b8 01 00 00 00       	mov    $0x1,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret

000002ba <exit>:
SYSCALL(exit)
 2ba:	b8 02 00 00 00       	mov    $0x2,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret

000002c2 <wait>:
SYSCALL(wait)
 2c2:	b8 03 00 00 00       	mov    $0x3,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret

000002ca <pipe>:
SYSCALL(pipe)
 2ca:	b8 04 00 00 00       	mov    $0x4,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret

000002d2 <read>:
SYSCALL(read)
 2d2:	b8 05 00 00 00       	mov    $0x5,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret

000002da <kill>:
SYSCALL(kill)
 2da:	b8 06 00 00 00       	mov    $0x6,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret

000002e2 <exec>:
SYSCALL(exec)
 2e2:	b8 07 00 00 00       	mov    $0x7,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret

000002ea <fstat>:
SYSCALL(fstat)
 2ea:	b8 08 00 00 00       	mov    $0x8,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret

000002f2 <chdir>:
SYSCALL(chdir)
 2f2:	b8 09 00 00 00       	mov    $0x9,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret

000002fa <dup>:
SYSCALL(dup)
 2fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret

00000302 <getpid>:
SYSCALL(getpid)
 302:	b8 0b 00 00 00       	mov    $0xb,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret

0000030a <sbrk>:
SYSCALL(sbrk)
 30a:	b8 0c 00 00 00       	mov    $0xc,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret

00000312 <sleep>:
SYSCALL(sleep)
 312:	b8 0d 00 00 00       	mov    $0xd,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret

0000031a <uptime>:
SYSCALL(uptime)
 31a:	b8 0e 00 00 00       	mov    $0xe,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret

00000322 <open>:
SYSCALL(open)
 322:	b8 0f 00 00 00       	mov    $0xf,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret

0000032a <write>:
SYSCALL(write)
 32a:	b8 10 00 00 00       	mov    $0x10,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret

00000332 <mknod>:
SYSCALL(mknod)
 332:	b8 11 00 00 00       	mov    $0x11,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret

0000033a <unlink>:
SYSCALL(unlink)
 33a:	b8 12 00 00 00       	mov    $0x12,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret

00000342 <link>:
SYSCALL(link)
 342:	b8 13 00 00 00       	mov    $0x13,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret

0000034a <mkdir>:
SYSCALL(mkdir)
 34a:	b8 14 00 00 00       	mov    $0x14,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret

00000352 <close>:
SYSCALL(close)
 352:	b8 15 00 00 00       	mov    $0x15,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret

0000035a <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 35a:	b8 16 00 00 00       	mov    $0x16,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret

00000362 <settickets>:
SYSCALL(settickets)
 362:	b8 17 00 00 00       	mov    $0x17,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret

0000036a <getpinfo>:
SYSCALL(getpinfo)
 36a:	b8 18 00 00 00       	mov    $0x18,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret

00000372 <waitx>:
SYSCALL(waitx)
 372:	b8 19 00 00 00       	mov    $0x19,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret

0000037a <yield>:
SYSCALL(yield)
 37a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret
 382:	66 90                	xchg   %ax,%ax
 384:	66 90                	xchg   %ax,%ax
 386:	66 90                	xchg   %ax,%ax
 388:	66 90                	xchg   %ax,%ax
 38a:	66 90                	xchg   %ax,%ax
 38c:	66 90                	xchg   %ax,%ax
 38e:	66 90                	xchg   %ax,%ax
 390:	66 90                	xchg   %ax,%ax
 392:	66 90                	xchg   %ax,%ax
 394:	66 90                	xchg   %ax,%ax
 396:	66 90                	xchg   %ax,%ax
 398:	66 90                	xchg   %ax,%ax
 39a:	66 90                	xchg   %ax,%ax
 39c:	66 90                	xchg   %ax,%ax
 39e:	66 90                	xchg   %ax,%ax

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3a8:	89 d1                	mov    %edx,%ecx
{
 3aa:	83 ec 3c             	sub    $0x3c,%esp
 3ad:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 3b0:	85 d2                	test   %edx,%edx
 3b2:	0f 89 98 00 00 00    	jns    450 <printint+0xb0>
 3b8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3bc:	0f 84 8e 00 00 00    	je     450 <printint+0xb0>
    x = -xx;
 3c2:	f7 d9                	neg    %ecx
    neg = 1;
 3c4:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 3c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3cc:	31 f6                	xor    %esi,%esi
 3ce:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3d5:	00 
 3d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3dd:	00 
 3de:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 3e0:	89 c8                	mov    %ecx,%eax
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	89 f7                	mov    %esi,%edi
 3e6:	f7 f3                	div    %ebx
 3e8:	8d 76 01             	lea    0x1(%esi),%esi
 3eb:	0f b6 92 28 08 00 00 	movzbl 0x828(%edx),%edx
 3f2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 3f6:	89 ca                	mov    %ecx,%edx
 3f8:	89 c1                	mov    %eax,%ecx
 3fa:	39 da                	cmp    %ebx,%edx
 3fc:	73 e2                	jae    3e0 <printint+0x40>
  if(neg)
 3fe:	8b 45 c0             	mov    -0x40(%ebp),%eax
 401:	85 c0                	test   %eax,%eax
 403:	74 07                	je     40c <printint+0x6c>
    buf[i++] = '-';
 405:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 40a:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 40c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 40f:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 412:	01 df                	add    %ebx,%edi
 414:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41b:	00 
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 420:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 423:	83 ec 04             	sub    $0x4,%esp
 426:	88 45 d7             	mov    %al,-0x29(%ebp)
 429:	8d 45 d7             	lea    -0x29(%ebp),%eax
 42c:	6a 01                	push   $0x1
 42e:	50                   	push   %eax
 42f:	56                   	push   %esi
 430:	e8 f5 fe ff ff       	call   32a <write>
  while(--i >= 0)
 435:	89 f8                	mov    %edi,%eax
 437:	83 c4 10             	add    $0x10,%esp
 43a:	83 ef 01             	sub    $0x1,%edi
 43d:	39 d8                	cmp    %ebx,%eax
 43f:	75 df                	jne    420 <printint+0x80>
}
 441:	8d 65 f4             	lea    -0xc(%ebp),%esp
 444:	5b                   	pop    %ebx
 445:	5e                   	pop    %esi
 446:	5f                   	pop    %edi
 447:	5d                   	pop    %ebp
 448:	c3                   	ret
 449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 450:	31 c0                	xor    %eax,%eax
 452:	e9 72 ff ff ff       	jmp    3c9 <printint+0x29>
 457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45e:	00 
 45f:	90                   	nop

00000460 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 469:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 46c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 46f:	0f b6 13             	movzbl (%ebx),%edx
 472:	83 c3 01             	add    $0x1,%ebx
 475:	84 d2                	test   %dl,%dl
 477:	0f 84 a0 00 00 00    	je     51d <printf+0xbd>
 47d:	8d 45 10             	lea    0x10(%ebp),%eax
 480:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 483:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 486:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 489:	eb 28                	jmp    4b3 <printf+0x53>
 48b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 490:	83 ec 04             	sub    $0x4,%esp
 493:	8d 45 e7             	lea    -0x19(%ebp),%eax
 496:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 499:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 49c:	6a 01                	push   $0x1
 49e:	50                   	push   %eax
 49f:	56                   	push   %esi
 4a0:	e8 85 fe ff ff       	call   32a <write>
  for(i = 0; fmt[i]; i++){
 4a5:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4a9:	83 c4 10             	add    $0x10,%esp
 4ac:	84 d2                	test   %dl,%dl
 4ae:	74 6d                	je     51d <printf+0xbd>
    c = fmt[i] & 0xff;
 4b0:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 4b3:	83 f8 25             	cmp    $0x25,%eax
 4b6:	75 d8                	jne    490 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 4b8:	0f b6 13             	movzbl (%ebx),%edx
 4bb:	84 d2                	test   %dl,%dl
 4bd:	74 5e                	je     51d <printf+0xbd>
    c = fmt[i] & 0xff;
 4bf:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 4c2:	80 fa 25             	cmp    $0x25,%dl
 4c5:	0f 84 1d 01 00 00    	je     5e8 <printf+0x188>
 4cb:	83 e8 63             	sub    $0x63,%eax
 4ce:	83 f8 15             	cmp    $0x15,%eax
 4d1:	77 0d                	ja     4e0 <printf+0x80>
 4d3:	ff 24 85 d0 07 00 00 	jmp    *0x7d0(,%eax,4)
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 4e0:	83 ec 04             	sub    $0x4,%esp
 4e3:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 4e6:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4e9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4ed:	6a 01                	push   $0x1
 4ef:	51                   	push   %ecx
 4f0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 4f3:	56                   	push   %esi
 4f4:	e8 31 fe ff ff       	call   32a <write>
        putc(fd, c);
 4f9:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 4fd:	83 c4 0c             	add    $0xc,%esp
 500:	88 55 e7             	mov    %dl,-0x19(%ebp)
 503:	6a 01                	push   $0x1
 505:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 508:	51                   	push   %ecx
 509:	56                   	push   %esi
 50a:	e8 1b fe ff ff       	call   32a <write>
  for(i = 0; fmt[i]; i++){
 50f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 513:	83 c3 02             	add    $0x2,%ebx
 516:	83 c4 10             	add    $0x10,%esp
 519:	84 d2                	test   %dl,%dl
 51b:	75 93                	jne    4b0 <printf+0x50>
      }
      state = 0;
    }
  }
}
 51d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 520:	5b                   	pop    %ebx
 521:	5e                   	pop    %esi
 522:	5f                   	pop    %edi
 523:	5d                   	pop    %ebp
 524:	c3                   	ret
 525:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 528:	83 ec 0c             	sub    $0xc,%esp
 52b:	8b 17                	mov    (%edi),%edx
 52d:	b9 10 00 00 00       	mov    $0x10,%ecx
 532:	89 f0                	mov    %esi,%eax
 534:	6a 00                	push   $0x0
        ap++;
 536:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 539:	e8 62 fe ff ff       	call   3a0 <printint>
  for(i = 0; fmt[i]; i++){
 53e:	eb cf                	jmp    50f <printf+0xaf>
        s = (char*)*ap;
 540:	8b 07                	mov    (%edi),%eax
        ap++;
 542:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 545:	85 c0                	test   %eax,%eax
 547:	0f 84 b3 00 00 00    	je     600 <printf+0x1a0>
        while(*s != 0){
 54d:	0f b6 10             	movzbl (%eax),%edx
 550:	84 d2                	test   %dl,%dl
 552:	0f 84 ba 00 00 00    	je     612 <printf+0x1b2>
 558:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 55b:	89 c7                	mov    %eax,%edi
 55d:	89 d0                	mov    %edx,%eax
 55f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 562:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 565:	89 fb                	mov    %edi,%ebx
 567:	89 cf                	mov    %ecx,%edi
 569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 570:	83 ec 04             	sub    $0x4,%esp
 573:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 576:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 579:	6a 01                	push   $0x1
 57b:	57                   	push   %edi
 57c:	56                   	push   %esi
 57d:	e8 a8 fd ff ff       	call   32a <write>
        while(*s != 0){
 582:	0f b6 03             	movzbl (%ebx),%eax
 585:	83 c4 10             	add    $0x10,%esp
 588:	84 c0                	test   %al,%al
 58a:	75 e4                	jne    570 <printf+0x110>
 58c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 58f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 593:	83 c3 02             	add    $0x2,%ebx
 596:	84 d2                	test   %dl,%dl
 598:	0f 85 e5 fe ff ff    	jne    483 <printf+0x23>
 59e:	e9 7a ff ff ff       	jmp    51d <printf+0xbd>
 5a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5a8:	83 ec 0c             	sub    $0xc,%esp
 5ab:	8b 17                	mov    (%edi),%edx
 5ad:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5b2:	89 f0                	mov    %esi,%eax
 5b4:	6a 01                	push   $0x1
        ap++;
 5b6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 5b9:	e8 e2 fd ff ff       	call   3a0 <printint>
  for(i = 0; fmt[i]; i++){
 5be:	e9 4c ff ff ff       	jmp    50f <printf+0xaf>
 5c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5c8:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 5ca:	83 ec 04             	sub    $0x4,%esp
 5cd:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 5d0:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 5d3:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5d6:	6a 01                	push   $0x1
 5d8:	51                   	push   %ecx
 5d9:	56                   	push   %esi
 5da:	e8 4b fd ff ff       	call   32a <write>
  for(i = 0; fmt[i]; i++){
 5df:	e9 2b ff ff ff       	jmp    50f <printf+0xaf>
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5e8:	83 ec 04             	sub    $0x4,%esp
 5eb:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5ee:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5f1:	6a 01                	push   $0x1
 5f3:	e9 10 ff ff ff       	jmp    508 <printf+0xa8>
 5f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ff:	00 
          s = "(null)";
 600:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 603:	b8 28 00 00 00       	mov    $0x28,%eax
 608:	bf c8 07 00 00       	mov    $0x7c8,%edi
 60d:	e9 4d ff ff ff       	jmp    55f <printf+0xff>
  for(i = 0; fmt[i]; i++){
 612:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 616:	83 c3 02             	add    $0x2,%ebx
 619:	84 d2                	test   %dl,%dl
 61b:	0f 85 8f fe ff ff    	jne    4b0 <printf+0x50>
 621:	e9 f7 fe ff ff       	jmp    51d <printf+0xbd>
 626:	66 90                	xchg   %ax,%ax
 628:	66 90                	xchg   %ax,%ax
 62a:	66 90                	xchg   %ax,%ax
 62c:	66 90                	xchg   %ax,%ax
 62e:	66 90                	xchg   %ax,%ax
 630:	66 90                	xchg   %ax,%ax
 632:	66 90                	xchg   %ax,%ax
 634:	66 90                	xchg   %ax,%ax
 636:	66 90                	xchg   %ax,%ax
 638:	66 90                	xchg   %ax,%ax
 63a:	66 90                	xchg   %ax,%ax
 63c:	66 90                	xchg   %ax,%ax
 63e:	66 90                	xchg   %ax,%ax

00000640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 640:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	a1 d0 0a 00 00       	mov    0xad0,%eax
{
 646:	89 e5                	mov    %esp,%ebp
 648:	57                   	push   %edi
 649:	56                   	push   %esi
 64a:	53                   	push   %ebx
 64b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 64e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 658:	00 
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 660:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 662:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 664:	39 ca                	cmp    %ecx,%edx
 666:	73 30                	jae    698 <free+0x58>
 668:	39 c1                	cmp    %eax,%ecx
 66a:	72 04                	jb     670 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66c:	39 c2                	cmp    %eax,%edx
 66e:	72 f0                	jb     660 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 670:	8b 73 fc             	mov    -0x4(%ebx),%esi
 673:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 676:	39 f8                	cmp    %edi,%eax
 678:	74 36                	je     6b0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 67a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 67d:	8b 42 04             	mov    0x4(%edx),%eax
 680:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 683:	39 f1                	cmp    %esi,%ecx
 685:	74 40                	je     6c7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 687:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 689:	5b                   	pop    %ebx
  freep = p;
 68a:	89 15 d0 0a 00 00    	mov    %edx,0xad0
}
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 698:	39 c2                	cmp    %eax,%edx
 69a:	72 c4                	jb     660 <free+0x20>
 69c:	39 c1                	cmp    %eax,%ecx
 69e:	73 c0                	jae    660 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 6a0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6a3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6a6:	39 f8                	cmp    %edi,%eax
 6a8:	75 d0                	jne    67a <free+0x3a>
 6aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 6b0:	03 70 04             	add    0x4(%eax),%esi
 6b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b6:	8b 02                	mov    (%edx),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6bd:	8b 42 04             	mov    0x4(%edx),%eax
 6c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6c3:	39 f1                	cmp    %esi,%ecx
 6c5:	75 c0                	jne    687 <free+0x47>
    p->s.size += bp->s.size;
 6c7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 6ca:	89 15 d0 0a 00 00    	mov    %edx,0xad0
    p->s.size += bp->s.size;
 6d0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6d3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6d6:	89 0a                	mov    %ecx,(%edx)
}
 6d8:	5b                   	pop    %ebx
 6d9:	5e                   	pop    %esi
 6da:	5f                   	pop    %edi
 6db:	5d                   	pop    %ebp
 6dc:	c3                   	ret
 6dd:	8d 76 00             	lea    0x0(%esi),%esi

000006e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ec:	8b 15 d0 0a 00 00    	mov    0xad0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f2:	8d 78 07             	lea    0x7(%eax),%edi
 6f5:	c1 ef 03             	shr    $0x3,%edi
 6f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6fb:	85 d2                	test   %edx,%edx
 6fd:	0f 84 8d 00 00 00    	je     790 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 703:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 705:	8b 48 04             	mov    0x4(%eax),%ecx
 708:	39 f9                	cmp    %edi,%ecx
 70a:	73 64                	jae    770 <malloc+0x90>
  if(nu < 4096)
 70c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 711:	39 df                	cmp    %ebx,%edi
 713:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 716:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 71d:	eb 0a                	jmp    729 <malloc+0x49>
 71f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 720:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 722:	8b 48 04             	mov    0x4(%eax),%ecx
 725:	39 f9                	cmp    %edi,%ecx
 727:	73 47                	jae    770 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 729:	89 c2                	mov    %eax,%edx
 72b:	39 05 d0 0a 00 00    	cmp    %eax,0xad0
 731:	75 ed                	jne    720 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 733:	83 ec 0c             	sub    $0xc,%esp
 736:	56                   	push   %esi
 737:	e8 ce fb ff ff       	call   30a <sbrk>
  if(p == (char*)-1)
 73c:	83 c4 10             	add    $0x10,%esp
 73f:	83 f8 ff             	cmp    $0xffffffff,%eax
 742:	74 1c                	je     760 <malloc+0x80>
  hp->s.size = nu;
 744:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 747:	83 ec 0c             	sub    $0xc,%esp
 74a:	83 c0 08             	add    $0x8,%eax
 74d:	50                   	push   %eax
 74e:	e8 ed fe ff ff       	call   640 <free>
  return freep;
 753:	8b 15 d0 0a 00 00    	mov    0xad0,%edx
      if((p = morecore(nunits)) == 0)
 759:	83 c4 10             	add    $0x10,%esp
 75c:	85 d2                	test   %edx,%edx
 75e:	75 c0                	jne    720 <malloc+0x40>
        return 0;
  }
}
 760:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 763:	31 c0                	xor    %eax,%eax
}
 765:	5b                   	pop    %ebx
 766:	5e                   	pop    %esi
 767:	5f                   	pop    %edi
 768:	5d                   	pop    %ebp
 769:	c3                   	ret
 76a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 770:	39 cf                	cmp    %ecx,%edi
 772:	74 4c                	je     7c0 <malloc+0xe0>
        p->s.size -= nunits;
 774:	29 f9                	sub    %edi,%ecx
 776:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 779:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 77c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 77f:	89 15 d0 0a 00 00    	mov    %edx,0xad0
}
 785:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 788:	83 c0 08             	add    $0x8,%eax
}
 78b:	5b                   	pop    %ebx
 78c:	5e                   	pop    %esi
 78d:	5f                   	pop    %edi
 78e:	5d                   	pop    %ebp
 78f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 790:	c7 05 d0 0a 00 00 d4 	movl   $0xad4,0xad0
 797:	0a 00 00 
    base.s.size = 0;
 79a:	b8 d4 0a 00 00       	mov    $0xad4,%eax
    base.s.ptr = freep = prevp = &base;
 79f:	c7 05 d4 0a 00 00 d4 	movl   $0xad4,0xad4
 7a6:	0a 00 00 
    base.s.size = 0;
 7a9:	c7 05 d8 0a 00 00 00 	movl   $0x0,0xad8
 7b0:	00 00 00 
    if(p->s.size >= nunits){
 7b3:	e9 54 ff ff ff       	jmp    70c <malloc+0x2c>
 7b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7bf:	00 
        prevp->s.ptr = p->s.ptr;
 7c0:	8b 08                	mov    (%eax),%ecx
 7c2:	89 0a                	mov    %ecx,(%edx)
 7c4:	eb b9                	jmp    77f <malloc+0x9f>
