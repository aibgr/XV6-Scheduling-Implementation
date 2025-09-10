
_settickets:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(argc != 2){
  11:	83 39 02             	cmpl   $0x2,(%ecx)
{
  14:	8b 41 04             	mov    0x4(%ecx),%eax
  if(argc != 2){
  17:	74 13                	je     2c <main+0x2c>
    printf(1, "usage: settickets N\n");
  19:	52                   	push   %edx
  1a:	52                   	push   %edx
  1b:	68 e8 07 00 00       	push   $0x7e8
  20:	6a 01                	push   $0x1
  22:	e8 59 04 00 00       	call   480 <printf>
    exit();
  27:	e8 ae 02 00 00       	call   2da <exit>
  }

  int n = atoi(argv[1]);
  2c:	83 ec 0c             	sub    $0xc,%esp
  2f:	ff 70 04             	push   0x4(%eax)
  32:	e8 09 02 00 00       	call   240 <atoi>
  if(settickets(n) < 0)
  37:	89 04 24             	mov    %eax,(%esp)
  3a:	e8 43 03 00 00       	call   382 <settickets>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	85 c0                	test   %eax,%eax
  44:	78 05                	js     4b <main+0x4b>
    printf(1, "settickets failed\n");

  exit();
  46:	e8 8f 02 00 00       	call   2da <exit>
    printf(1, "settickets failed\n");
  4b:	50                   	push   %eax
  4c:	50                   	push   %eax
  4d:	68 fd 07 00 00       	push   $0x7fd
  52:	6a 01                	push   $0x1
  54:	e8 27 04 00 00       	call   480 <printf>
  59:	83 c4 10             	add    $0x10,%esp
  5c:	eb e8                	jmp    46 <main+0x46>
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
  61:	31 c0                	xor    %eax,%eax
{
  63:	89 e5                	mov    %esp,%ebp
  65:	53                   	push   %ebx
  66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
  70:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  74:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  77:	83 c0 01             	add    $0x1,%eax
  7a:	84 d2                	test   %dl,%dl
  7c:	75 f2                	jne    70 <strcpy+0x10>
  return os;
}
  7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  81:	89 c8                	mov    %ecx,%eax
  83:	c9                   	leave
  84:	c3                   	ret
  85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  8c:	00 
  8d:	8d 76 00             	lea    0x0(%esi),%esi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	75 2f                	jne    d0 <strcmp+0x40>
  a1:	eb 4a                	jmp    ed <strcmp+0x5d>
  a3:	eb 1b                	jmp    c0 <strcmp+0x30>
  a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ac:	00 
  ad:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  b4:	00 
  b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  bc:	00 
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  c4:	83 c2 01             	add    $0x1,%edx
  c7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  ca:	84 c0                	test   %al,%al
  cc:	74 12                	je     e0 <strcmp+0x50>
  ce:	89 d9                	mov    %ebx,%ecx
  d0:	0f b6 19             	movzbl (%ecx),%ebx
  d3:	38 c3                	cmp    %al,%bl
  d5:	74 e9                	je     c0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
  d7:	29 d8                	sub    %ebx,%eax
}
  d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  dc:	c9                   	leave
  dd:	c3                   	ret
  de:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  e0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  e4:	31 c0                	xor    %eax,%eax
  e6:	29 d8                	sub    %ebx,%eax
}
  e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  eb:	c9                   	leave
  ec:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  ed:	0f b6 19             	movzbl (%ecx),%ebx
  f0:	31 c0                	xor    %eax,%eax
  f2:	eb e3                	jmp    d7 <strcmp+0x47>
  f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fb:	00 
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 106:	80 3a 00             	cmpb   $0x0,(%edx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 c0                	xor    %eax,%eax
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c0 01             	add    $0x1,%eax
 113:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 117:	89 c1                	mov    %eax,%ecx
 119:	75 f5                	jne    110 <strlen+0x10>
  return n;
}
 11b:	89 c8                	mov    %ecx,%eax
 11d:	5d                   	pop    %ebp
 11e:	c3                   	ret
 11f:	90                   	nop
  for(n = 0; s[n]; n++);
 120:	31 c9                	xor    %ecx,%ecx
}
 122:	5d                   	pop    %ebp
 123:	89 c8                	mov    %ecx,%eax
 125:	c3                   	ret
 126:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12d:	00 
 12e:	66 90                	xchg   %ax,%ax

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	8b 7d fc             	mov    -0x4(%ebp),%edi
 145:	89 d0                	mov    %edx,%eax
 147:	c9                   	leave
 148:	c3                   	ret
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	75 1a                	jne    17b <strchr+0x2b>
 161:	eb 25                	jmp    188 <strchr+0x38>
 163:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16a:	00 
 16b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 170:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 174:	83 c0 01             	add    $0x1,%eax
 177:	84 d2                	test   %dl,%dl
 179:	74 0d                	je     188 <strchr+0x38>
    if(*s == c)
 17b:	38 d1                	cmp    %dl,%cl
 17d:	75 f1                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
}
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret
 181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 188:	31 c0                	xor    %eax,%eax
}
 18a:	5d                   	pop    %ebp
 18b:	c3                   	ret
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 195:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 198:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 199:	31 db                	xor    %ebx,%ebx
{
 19b:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 19e:	eb 27                	jmp    1c7 <gets+0x37>
    cc = read(0, &c, 1);
 1a0:	83 ec 04             	sub    $0x4,%esp
 1a3:	6a 01                	push   $0x1
 1a5:	56                   	push   %esi
 1a6:	6a 00                	push   $0x0
 1a8:	e8 45 01 00 00       	call   2f2 <read>
    if(cc < 1)
 1ad:	83 c4 10             	add    $0x10,%esp
 1b0:	85 c0                	test   %eax,%eax
 1b2:	7e 1d                	jle    1d1 <gets+0x41>
      break;
    buf[i++] = c;
 1b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b8:	8b 55 08             	mov    0x8(%ebp),%edx
 1bb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1bf:	3c 0a                	cmp    $0xa,%al
 1c1:	74 10                	je     1d3 <gets+0x43>
 1c3:	3c 0d                	cmp    $0xd,%al
 1c5:	74 0c                	je     1d3 <gets+0x43>
  for(i = 0; i+1 < max; ){
 1c7:	89 df                	mov    %ebx,%edi
 1c9:	83 c3 01             	add    $0x1,%ebx
 1cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1cf:	7c cf                	jl     1a0 <gets+0x10>
 1d1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 1da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1dd:	5b                   	pop    %ebx
 1de:	5e                   	pop    %esi
 1df:	5f                   	pop    %edi
 1e0:	5d                   	pop    %ebp
 1e1:	c3                   	ret
 1e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1e9:	00 
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 1f5:	83 ec 08             	sub    $0x8,%esp
 1f8:	6a 00                	push   $0x0
 1fa:	ff 75 08             	push   0x8(%ebp)
 1fd:	e8 40 01 00 00       	call   342 <open>
  if(fd < 0)
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 27                	js     230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	ff 75 0c             	push   0xc(%ebp)
 20f:	89 c3                	mov    %eax,%ebx
 211:	50                   	push   %eax
 212:	e8 f3 00 00 00       	call   30a <fstat>
  close(fd);
 217:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 21a:	89 c6                	mov    %eax,%esi
  close(fd);
 21c:	e8 51 01 00 00       	call   372 <close>
  return r;
 221:	83 c4 10             	add    $0x10,%esp
}
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	89 f0                	mov    %esi,%eax
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb ed                	jmp    224 <stat+0x34>
 237:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23e:	00 
 23f:	90                   	nop

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 02             	movsbl (%edx),%eax
 24a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 24d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 250:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 255:	77 1e                	ja     275 <atoi+0x35>
 257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25e:	00 
 25f:	90                   	nop
    n = n*10 + *s++ - '0';
 260:	83 c2 01             	add    $0x1,%edx
 263:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 266:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 26a:	0f be 02             	movsbl (%edx),%eax
 26d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 278:	89 c8                	mov    %ecx,%eax
 27a:	c9                   	leave
 27b:	c3                   	ret
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	8b 55 08             	mov    0x8(%ebp),%edx
 287:	8b 45 10             	mov    0x10(%ebp),%eax
 28a:	56                   	push   %esi
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 28e:	39 f2                	cmp    %esi,%edx
 290:	73 1e                	jae    2b0 <memmove+0x30>
    while(n-- > 0)
 292:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 295:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 297:	85 c0                	test   %eax,%eax
 299:	7e 0a                	jle    2a5 <memmove+0x25>
 29b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 2a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 2a1:	39 f9                	cmp    %edi,%ecx
 2a3:	75 fb                	jne    2a0 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a5:	5e                   	pop    %esi
 2a6:	89 d0                	mov    %edx,%eax
 2a8:	5f                   	pop    %edi
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret
 2ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 2b0:	85 c0                	test   %eax,%eax
 2b2:	7e f1                	jle    2a5 <memmove+0x25>
    while(n-- > 0)
 2b4:	83 e8 01             	sub    $0x1,%eax
 2b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2be:	00 
 2bf:	90                   	nop
      *--dst = *--src;
 2c0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 2c4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 2c7:	83 e8 01             	sub    $0x1,%eax
 2ca:	73 f4                	jae    2c0 <memmove+0x40>
}
 2cc:	5e                   	pop    %esi
 2cd:	89 d0                	mov    %edx,%eax
 2cf:	5f                   	pop    %edi
 2d0:	5d                   	pop    %ebp
 2d1:	c3                   	ret

000002d2 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 2d2:	b8 01 00 00 00       	mov    $0x1,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret

000002da <exit>:
SYSCALL(exit)
 2da:	b8 02 00 00 00       	mov    $0x2,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret

000002e2 <wait>:
SYSCALL(wait)
 2e2:	b8 03 00 00 00       	mov    $0x3,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret

000002ea <pipe>:
SYSCALL(pipe)
 2ea:	b8 04 00 00 00       	mov    $0x4,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret

000002f2 <read>:
SYSCALL(read)
 2f2:	b8 05 00 00 00       	mov    $0x5,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret

000002fa <kill>:
SYSCALL(kill)
 2fa:	b8 06 00 00 00       	mov    $0x6,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret

00000302 <exec>:
SYSCALL(exec)
 302:	b8 07 00 00 00       	mov    $0x7,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret

0000030a <fstat>:
SYSCALL(fstat)
 30a:	b8 08 00 00 00       	mov    $0x8,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret

00000312 <chdir>:
SYSCALL(chdir)
 312:	b8 09 00 00 00       	mov    $0x9,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret

0000031a <dup>:
SYSCALL(dup)
 31a:	b8 0a 00 00 00       	mov    $0xa,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret

00000322 <getpid>:
SYSCALL(getpid)
 322:	b8 0b 00 00 00       	mov    $0xb,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret

0000032a <sbrk>:
SYSCALL(sbrk)
 32a:	b8 0c 00 00 00       	mov    $0xc,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret

00000332 <sleep>:
SYSCALL(sleep)
 332:	b8 0d 00 00 00       	mov    $0xd,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret

0000033a <uptime>:
SYSCALL(uptime)
 33a:	b8 0e 00 00 00       	mov    $0xe,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret

00000342 <open>:
SYSCALL(open)
 342:	b8 0f 00 00 00       	mov    $0xf,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret

0000034a <write>:
SYSCALL(write)
 34a:	b8 10 00 00 00       	mov    $0x10,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret

00000352 <mknod>:
SYSCALL(mknod)
 352:	b8 11 00 00 00       	mov    $0x11,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret

0000035a <unlink>:
SYSCALL(unlink)
 35a:	b8 12 00 00 00       	mov    $0x12,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret

00000362 <link>:
SYSCALL(link)
 362:	b8 13 00 00 00       	mov    $0x13,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret

0000036a <mkdir>:
SYSCALL(mkdir)
 36a:	b8 14 00 00 00       	mov    $0x14,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret

00000372 <close>:
SYSCALL(close)
 372:	b8 15 00 00 00       	mov    $0x15,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret

0000037a <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 37a:	b8 16 00 00 00       	mov    $0x16,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret

00000382 <settickets>:
SYSCALL(settickets)
 382:	b8 17 00 00 00       	mov    $0x17,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret

0000038a <getpinfo>:
SYSCALL(getpinfo)
 38a:	b8 18 00 00 00       	mov    $0x18,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret

00000392 <waitx>:
SYSCALL(waitx)
 392:	b8 19 00 00 00       	mov    $0x19,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret

0000039a <yield>:
SYSCALL(yield)
 39a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret
 3a2:	66 90                	xchg   %ax,%ax
 3a4:	66 90                	xchg   %ax,%ax
 3a6:	66 90                	xchg   %ax,%ax
 3a8:	66 90                	xchg   %ax,%ax
 3aa:	66 90                	xchg   %ax,%ax
 3ac:	66 90                	xchg   %ax,%ax
 3ae:	66 90                	xchg   %ax,%ax
 3b0:	66 90                	xchg   %ax,%ax
 3b2:	66 90                	xchg   %ax,%ax
 3b4:	66 90                	xchg   %ax,%ax
 3b6:	66 90                	xchg   %ax,%ax
 3b8:	66 90                	xchg   %ax,%ax
 3ba:	66 90                	xchg   %ax,%ax
 3bc:	66 90                	xchg   %ax,%ax
 3be:	66 90                	xchg   %ax,%ax

000003c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3c8:	89 d1                	mov    %edx,%ecx
{
 3ca:	83 ec 3c             	sub    $0x3c,%esp
 3cd:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 3d0:	85 d2                	test   %edx,%edx
 3d2:	0f 89 98 00 00 00    	jns    470 <printint+0xb0>
 3d8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3dc:	0f 84 8e 00 00 00    	je     470 <printint+0xb0>
    x = -xx;
 3e2:	f7 d9                	neg    %ecx
    neg = 1;
 3e4:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 3e9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3ec:	31 f6                	xor    %esi,%esi
 3ee:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3f5:	00 
 3f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3fd:	00 
 3fe:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 400:	89 c8                	mov    %ecx,%eax
 402:	31 d2                	xor    %edx,%edx
 404:	89 f7                	mov    %esi,%edi
 406:	f7 f3                	div    %ebx
 408:	8d 76 01             	lea    0x1(%esi),%esi
 40b:	0f b6 92 70 08 00 00 	movzbl 0x870(%edx),%edx
 412:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 416:	89 ca                	mov    %ecx,%edx
 418:	89 c1                	mov    %eax,%ecx
 41a:	39 da                	cmp    %ebx,%edx
 41c:	73 e2                	jae    400 <printint+0x40>
  if(neg)
 41e:	8b 45 c0             	mov    -0x40(%ebp),%eax
 421:	85 c0                	test   %eax,%eax
 423:	74 07                	je     42c <printint+0x6c>
    buf[i++] = '-';
 425:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 42a:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 42c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 42f:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 432:	01 df                	add    %ebx,%edi
 434:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43b:	00 
 43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 440:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 443:	83 ec 04             	sub    $0x4,%esp
 446:	88 45 d7             	mov    %al,-0x29(%ebp)
 449:	8d 45 d7             	lea    -0x29(%ebp),%eax
 44c:	6a 01                	push   $0x1
 44e:	50                   	push   %eax
 44f:	56                   	push   %esi
 450:	e8 f5 fe ff ff       	call   34a <write>
  while(--i >= 0)
 455:	89 f8                	mov    %edi,%eax
 457:	83 c4 10             	add    $0x10,%esp
 45a:	83 ef 01             	sub    $0x1,%edi
 45d:	39 d8                	cmp    %ebx,%eax
 45f:	75 df                	jne    440 <printint+0x80>
}
 461:	8d 65 f4             	lea    -0xc(%ebp),%esp
 464:	5b                   	pop    %ebx
 465:	5e                   	pop    %esi
 466:	5f                   	pop    %edi
 467:	5d                   	pop    %ebp
 468:	c3                   	ret
 469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 470:	31 c0                	xor    %eax,%eax
 472:	e9 72 ff ff ff       	jmp    3e9 <printint+0x29>
 477:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 47e:	00 
 47f:	90                   	nop

00000480 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 489:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 48c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 48f:	0f b6 13             	movzbl (%ebx),%edx
 492:	83 c3 01             	add    $0x1,%ebx
 495:	84 d2                	test   %dl,%dl
 497:	0f 84 a0 00 00 00    	je     53d <printf+0xbd>
 49d:	8d 45 10             	lea    0x10(%ebp),%eax
 4a0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 4a3:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4a6:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 4a9:	eb 28                	jmp    4d3 <printf+0x53>
 4ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 4b0:	83 ec 04             	sub    $0x4,%esp
 4b3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4b6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 4b9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 4bc:	6a 01                	push   $0x1
 4be:	50                   	push   %eax
 4bf:	56                   	push   %esi
 4c0:	e8 85 fe ff ff       	call   34a <write>
  for(i = 0; fmt[i]; i++){
 4c5:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4c9:	83 c4 10             	add    $0x10,%esp
 4cc:	84 d2                	test   %dl,%dl
 4ce:	74 6d                	je     53d <printf+0xbd>
    c = fmt[i] & 0xff;
 4d0:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 4d3:	83 f8 25             	cmp    $0x25,%eax
 4d6:	75 d8                	jne    4b0 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 4d8:	0f b6 13             	movzbl (%ebx),%edx
 4db:	84 d2                	test   %dl,%dl
 4dd:	74 5e                	je     53d <printf+0xbd>
    c = fmt[i] & 0xff;
 4df:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 4e2:	80 fa 25             	cmp    $0x25,%dl
 4e5:	0f 84 1d 01 00 00    	je     608 <printf+0x188>
 4eb:	83 e8 63             	sub    $0x63,%eax
 4ee:	83 f8 15             	cmp    $0x15,%eax
 4f1:	77 0d                	ja     500 <printf+0x80>
 4f3:	ff 24 85 18 08 00 00 	jmp    *0x818(,%eax,4)
 4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 500:	83 ec 04             	sub    $0x4,%esp
 503:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 506:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 509:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 50d:	6a 01                	push   $0x1
 50f:	51                   	push   %ecx
 510:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 513:	56                   	push   %esi
 514:	e8 31 fe ff ff       	call   34a <write>
        putc(fd, c);
 519:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 51d:	83 c4 0c             	add    $0xc,%esp
 520:	88 55 e7             	mov    %dl,-0x19(%ebp)
 523:	6a 01                	push   $0x1
 525:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 528:	51                   	push   %ecx
 529:	56                   	push   %esi
 52a:	e8 1b fe ff ff       	call   34a <write>
  for(i = 0; fmt[i]; i++){
 52f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 533:	83 c3 02             	add    $0x2,%ebx
 536:	83 c4 10             	add    $0x10,%esp
 539:	84 d2                	test   %dl,%dl
 53b:	75 93                	jne    4d0 <printf+0x50>
      }
      state = 0;
    }
  }
}
 53d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 540:	5b                   	pop    %ebx
 541:	5e                   	pop    %esi
 542:	5f                   	pop    %edi
 543:	5d                   	pop    %ebp
 544:	c3                   	ret
 545:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 548:	83 ec 0c             	sub    $0xc,%esp
 54b:	8b 17                	mov    (%edi),%edx
 54d:	b9 10 00 00 00       	mov    $0x10,%ecx
 552:	89 f0                	mov    %esi,%eax
 554:	6a 00                	push   $0x0
        ap++;
 556:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 559:	e8 62 fe ff ff       	call   3c0 <printint>
  for(i = 0; fmt[i]; i++){
 55e:	eb cf                	jmp    52f <printf+0xaf>
        s = (char*)*ap;
 560:	8b 07                	mov    (%edi),%eax
        ap++;
 562:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 565:	85 c0                	test   %eax,%eax
 567:	0f 84 b3 00 00 00    	je     620 <printf+0x1a0>
        while(*s != 0){
 56d:	0f b6 10             	movzbl (%eax),%edx
 570:	84 d2                	test   %dl,%dl
 572:	0f 84 ba 00 00 00    	je     632 <printf+0x1b2>
 578:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 57b:	89 c7                	mov    %eax,%edi
 57d:	89 d0                	mov    %edx,%eax
 57f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 582:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 585:	89 fb                	mov    %edi,%ebx
 587:	89 cf                	mov    %ecx,%edi
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 590:	83 ec 04             	sub    $0x4,%esp
 593:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 596:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 599:	6a 01                	push   $0x1
 59b:	57                   	push   %edi
 59c:	56                   	push   %esi
 59d:	e8 a8 fd ff ff       	call   34a <write>
        while(*s != 0){
 5a2:	0f b6 03             	movzbl (%ebx),%eax
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	84 c0                	test   %al,%al
 5aa:	75 e4                	jne    590 <printf+0x110>
 5ac:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5af:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5b3:	83 c3 02             	add    $0x2,%ebx
 5b6:	84 d2                	test   %dl,%dl
 5b8:	0f 85 e5 fe ff ff    	jne    4a3 <printf+0x23>
 5be:	e9 7a ff ff ff       	jmp    53d <printf+0xbd>
 5c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5c8:	83 ec 0c             	sub    $0xc,%esp
 5cb:	8b 17                	mov    (%edi),%edx
 5cd:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d2:	89 f0                	mov    %esi,%eax
 5d4:	6a 01                	push   $0x1
        ap++;
 5d6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 5d9:	e8 e2 fd ff ff       	call   3c0 <printint>
  for(i = 0; fmt[i]; i++){
 5de:	e9 4c ff ff ff       	jmp    52f <printf+0xaf>
 5e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5e8:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 5ea:	83 ec 04             	sub    $0x4,%esp
 5ed:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 5f0:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 5f3:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5f6:	6a 01                	push   $0x1
 5f8:	51                   	push   %ecx
 5f9:	56                   	push   %esi
 5fa:	e8 4b fd ff ff       	call   34a <write>
  for(i = 0; fmt[i]; i++){
 5ff:	e9 2b ff ff ff       	jmp    52f <printf+0xaf>
 604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 608:	83 ec 04             	sub    $0x4,%esp
 60b:	88 55 e7             	mov    %dl,-0x19(%ebp)
 60e:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 611:	6a 01                	push   $0x1
 613:	e9 10 ff ff ff       	jmp    528 <printf+0xa8>
 618:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 61f:	00 
          s = "(null)";
 620:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 623:	b8 28 00 00 00       	mov    $0x28,%eax
 628:	bf 10 08 00 00       	mov    $0x810,%edi
 62d:	e9 4d ff ff ff       	jmp    57f <printf+0xff>
  for(i = 0; fmt[i]; i++){
 632:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 636:	83 c3 02             	add    $0x2,%ebx
 639:	84 d2                	test   %dl,%dl
 63b:	0f 85 8f fe ff ff    	jne    4d0 <printf+0x50>
 641:	e9 f7 fe ff ff       	jmp    53d <printf+0xbd>
 646:	66 90                	xchg   %ax,%ax
 648:	66 90                	xchg   %ax,%ax
 64a:	66 90                	xchg   %ax,%ax
 64c:	66 90                	xchg   %ax,%ax
 64e:	66 90                	xchg   %ax,%ax
 650:	66 90                	xchg   %ax,%ax
 652:	66 90                	xchg   %ax,%ax
 654:	66 90                	xchg   %ax,%ax
 656:	66 90                	xchg   %ax,%ax
 658:	66 90                	xchg   %ax,%ax
 65a:	66 90                	xchg   %ax,%ax
 65c:	66 90                	xchg   %ax,%ax
 65e:	66 90                	xchg   %ax,%ax

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	a1 18 0b 00 00       	mov    0xb18,%eax
{
 666:	89 e5                	mov    %esp,%ebp
 668:	57                   	push   %edi
 669:	56                   	push   %esi
 66a:	53                   	push   %ebx
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 66e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 671:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 678:	00 
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 680:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 682:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 684:	39 ca                	cmp    %ecx,%edx
 686:	73 30                	jae    6b8 <free+0x58>
 688:	39 c1                	cmp    %eax,%ecx
 68a:	72 04                	jb     690 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 68c:	39 c2                	cmp    %eax,%edx
 68e:	72 f0                	jb     680 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 690:	8b 73 fc             	mov    -0x4(%ebx),%esi
 693:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 696:	39 f8                	cmp    %edi,%eax
 698:	74 36                	je     6d0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 69a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 69d:	8b 42 04             	mov    0x4(%edx),%eax
 6a0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6a3:	39 f1                	cmp    %esi,%ecx
 6a5:	74 40                	je     6e7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6a7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6a9:	5b                   	pop    %ebx
  freep = p;
 6aa:	89 15 18 0b 00 00    	mov    %edx,0xb18
}
 6b0:	5e                   	pop    %esi
 6b1:	5f                   	pop    %edi
 6b2:	5d                   	pop    %ebp
 6b3:	c3                   	ret
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b8:	39 c2                	cmp    %eax,%edx
 6ba:	72 c4                	jb     680 <free+0x20>
 6bc:	39 c1                	cmp    %eax,%ecx
 6be:	73 c0                	jae    680 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 6c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6c6:	39 f8                	cmp    %edi,%eax
 6c8:	75 d0                	jne    69a <free+0x3a>
 6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 6d0:	03 70 04             	add    0x4(%eax),%esi
 6d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d6:	8b 02                	mov    (%edx),%eax
 6d8:	8b 00                	mov    (%eax),%eax
 6da:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6dd:	8b 42 04             	mov    0x4(%edx),%eax
 6e0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6e3:	39 f1                	cmp    %esi,%ecx
 6e5:	75 c0                	jne    6a7 <free+0x47>
    p->s.size += bp->s.size;
 6e7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 6ea:	89 15 18 0b 00 00    	mov    %edx,0xb18
    p->s.size += bp->s.size;
 6f0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6f3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6f6:	89 0a                	mov    %ecx,(%edx)
}
 6f8:	5b                   	pop    %ebx
 6f9:	5e                   	pop    %esi
 6fa:	5f                   	pop    %edi
 6fb:	5d                   	pop    %ebp
 6fc:	c3                   	ret
 6fd:	8d 76 00             	lea    0x0(%esi),%esi

00000700 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	57                   	push   %edi
 704:	56                   	push   %esi
 705:	53                   	push   %ebx
 706:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 709:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 70c:	8b 15 18 0b 00 00    	mov    0xb18,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 712:	8d 78 07             	lea    0x7(%eax),%edi
 715:	c1 ef 03             	shr    $0x3,%edi
 718:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 71b:	85 d2                	test   %edx,%edx
 71d:	0f 84 8d 00 00 00    	je     7b0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 723:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 725:	8b 48 04             	mov    0x4(%eax),%ecx
 728:	39 f9                	cmp    %edi,%ecx
 72a:	73 64                	jae    790 <malloc+0x90>
  if(nu < 4096)
 72c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 731:	39 df                	cmp    %ebx,%edi
 733:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 736:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 73d:	eb 0a                	jmp    749 <malloc+0x49>
 73f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 740:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 742:	8b 48 04             	mov    0x4(%eax),%ecx
 745:	39 f9                	cmp    %edi,%ecx
 747:	73 47                	jae    790 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 749:	89 c2                	mov    %eax,%edx
 74b:	39 05 18 0b 00 00    	cmp    %eax,0xb18
 751:	75 ed                	jne    740 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 753:	83 ec 0c             	sub    $0xc,%esp
 756:	56                   	push   %esi
 757:	e8 ce fb ff ff       	call   32a <sbrk>
  if(p == (char*)-1)
 75c:	83 c4 10             	add    $0x10,%esp
 75f:	83 f8 ff             	cmp    $0xffffffff,%eax
 762:	74 1c                	je     780 <malloc+0x80>
  hp->s.size = nu;
 764:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 767:	83 ec 0c             	sub    $0xc,%esp
 76a:	83 c0 08             	add    $0x8,%eax
 76d:	50                   	push   %eax
 76e:	e8 ed fe ff ff       	call   660 <free>
  return freep;
 773:	8b 15 18 0b 00 00    	mov    0xb18,%edx
      if((p = morecore(nunits)) == 0)
 779:	83 c4 10             	add    $0x10,%esp
 77c:	85 d2                	test   %edx,%edx
 77e:	75 c0                	jne    740 <malloc+0x40>
        return 0;
  }
}
 780:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 783:	31 c0                	xor    %eax,%eax
}
 785:	5b                   	pop    %ebx
 786:	5e                   	pop    %esi
 787:	5f                   	pop    %edi
 788:	5d                   	pop    %ebp
 789:	c3                   	ret
 78a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 790:	39 cf                	cmp    %ecx,%edi
 792:	74 4c                	je     7e0 <malloc+0xe0>
        p->s.size -= nunits;
 794:	29 f9                	sub    %edi,%ecx
 796:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 799:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 79c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 79f:	89 15 18 0b 00 00    	mov    %edx,0xb18
}
 7a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7a8:	83 c0 08             	add    $0x8,%eax
}
 7ab:	5b                   	pop    %ebx
 7ac:	5e                   	pop    %esi
 7ad:	5f                   	pop    %edi
 7ae:	5d                   	pop    %ebp
 7af:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 7b0:	c7 05 18 0b 00 00 1c 	movl   $0xb1c,0xb18
 7b7:	0b 00 00 
    base.s.size = 0;
 7ba:	b8 1c 0b 00 00       	mov    $0xb1c,%eax
    base.s.ptr = freep = prevp = &base;
 7bf:	c7 05 1c 0b 00 00 1c 	movl   $0xb1c,0xb1c
 7c6:	0b 00 00 
    base.s.size = 0;
 7c9:	c7 05 20 0b 00 00 00 	movl   $0x0,0xb20
 7d0:	00 00 00 
    if(p->s.size >= nunits){
 7d3:	e9 54 ff ff ff       	jmp    72c <malloc+0x2c>
 7d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7df:	00 
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 08                	mov    (%eax),%ecx
 7e2:	89 0a                	mov    %ecx,(%edx)
 7e4:	eb b9                	jmp    79f <malloc+0x9f>
