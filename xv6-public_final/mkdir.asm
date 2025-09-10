
_mkdir:     file format elf32-i386


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
   d:	57                   	push   %edi
   e:	bf 01 00 00 00       	mov    $0x1,%edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  1c:	8b 31                	mov    (%ecx),%esi
  1e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  21:	83 fe 01             	cmp    $0x1,%esi
  24:	7e 3e                	jle    64 <main+0x64>
  26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2d:	00 
  2e:	66 90                	xchg   %ax,%ax
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	push   (%ebx)
  35:	e8 50 03 00 00       	call   38a <mkdir>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 0f                	js     50 <main+0x50>
  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  4b:	e8 aa 02 00 00       	call   2fa <exit>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	50                   	push   %eax
  51:	ff 33                	push   (%ebx)
  53:	68 1f 08 00 00       	push   $0x81f
  58:	6a 02                	push   $0x2
  5a:	e8 41 04 00 00       	call   4a0 <printf>
      break;
  5f:	83 c4 10             	add    $0x10,%esp
  62:	eb e7                	jmp    4b <main+0x4b>
    printf(2, "Usage: mkdir files...\n");
  64:	52                   	push   %edx
  65:	52                   	push   %edx
  66:	68 08 08 00 00       	push   $0x808
  6b:	6a 02                	push   $0x2
  6d:	e8 2e 04 00 00       	call   4a0 <printf>
    exit();
  72:	e8 83 02 00 00       	call   2fa <exit>
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
  81:	31 c0                	xor    %eax,%eax
{
  83:	89 e5                	mov    %esp,%ebp
  85:	53                   	push   %ebx
  86:	8b 4d 08             	mov    0x8(%ebp),%ecx
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
  90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  97:	83 c0 01             	add    $0x1,%eax
  9a:	84 d2                	test   %dl,%dl
  9c:	75 f2                	jne    90 <strcpy+0x10>
  return os;
}
  9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  a1:	89 c8                	mov    %ecx,%eax
  a3:	c9                   	leave
  a4:	c3                   	ret
  a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ac:	00 
  ad:	8d 76 00             	lea    0x0(%esi),%esi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 2f                	jne    f0 <strcmp+0x40>
  c1:	eb 4a                	jmp    10d <strcmp+0x5d>
  c3:	eb 1b                	jmp    e0 <strcmp+0x30>
  c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  cc:	00 
  cd:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  d4:	00 
  d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  dc:	00 
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  e4:	83 c2 01             	add    $0x1,%edx
  e7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  ea:	84 c0                	test   %al,%al
  ec:	74 12                	je     100 <strcmp+0x50>
  ee:	89 d9                	mov    %ebx,%ecx
  f0:	0f b6 19             	movzbl (%ecx),%ebx
  f3:	38 c3                	cmp    %al,%bl
  f5:	74 e9                	je     e0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
  f7:	29 d8                	sub    %ebx,%eax
}
  f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  fc:	c9                   	leave
  fd:	c3                   	ret
  fe:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 100:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 104:	31 c0                	xor    %eax,%eax
 106:	29 d8                	sub    %ebx,%eax
}
 108:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 10b:	c9                   	leave
 10c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 10d:	0f b6 19             	movzbl (%ecx),%ebx
 110:	31 c0                	xor    %eax,%eax
 112:	eb e3                	jmp    f7 <strcmp+0x47>
 114:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11b:	00 
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000120 <strlen>:

uint
strlen(const char *s)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 126:	80 3a 00             	cmpb   $0x0,(%edx)
 129:	74 15                	je     140 <strlen+0x20>
 12b:	31 c0                	xor    %eax,%eax
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	83 c0 01             	add    $0x1,%eax
 133:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 137:	89 c1                	mov    %eax,%ecx
 139:	75 f5                	jne    130 <strlen+0x10>
  return n;
}
 13b:	89 c8                	mov    %ecx,%eax
 13d:	5d                   	pop    %ebp
 13e:	c3                   	ret
 13f:	90                   	nop
  for(n = 0; s[n]; n++);
 140:	31 c9                	xor    %ecx,%ecx
}
 142:	5d                   	pop    %ebp
 143:	89 c8                	mov    %ecx,%eax
 145:	c3                   	ret
 146:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14d:	00 
 14e:	66 90                	xchg   %ax,%ax

00000150 <memset>:

void*
memset(void *dst, int c, uint n)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 157:	8b 4d 10             	mov    0x10(%ebp),%ecx
 15a:	8b 45 0c             	mov    0xc(%ebp),%eax
 15d:	89 d7                	mov    %edx,%edi
 15f:	fc                   	cld
 160:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 162:	8b 7d fc             	mov    -0x4(%ebp),%edi
 165:	89 d0                	mov    %edx,%eax
 167:	c9                   	leave
 168:	c3                   	ret
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <strchr>:

char*
strchr(const char *s, char c)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 17a:	0f b6 10             	movzbl (%eax),%edx
 17d:	84 d2                	test   %dl,%dl
 17f:	75 1a                	jne    19b <strchr+0x2b>
 181:	eb 25                	jmp    1a8 <strchr+0x38>
 183:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18a:	00 
 18b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 190:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 194:	83 c0 01             	add    $0x1,%eax
 197:	84 d2                	test   %dl,%dl
 199:	74 0d                	je     1a8 <strchr+0x38>
    if(*s == c)
 19b:	38 d1                	cmp    %dl,%cl
 19d:	75 f1                	jne    190 <strchr+0x20>
      return (char*)s;
  return 0;
}
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret
 1a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1a8:	31 c0                	xor    %eax,%eax
}
 1aa:	5d                   	pop    %ebp
 1ab:	c3                   	ret
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <gets>:

char*
gets(char *buf, int max)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 1b5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 1b8:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 1b9:	31 db                	xor    %ebx,%ebx
{
 1bb:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 1be:	eb 27                	jmp    1e7 <gets+0x37>
    cc = read(0, &c, 1);
 1c0:	83 ec 04             	sub    $0x4,%esp
 1c3:	6a 01                	push   $0x1
 1c5:	56                   	push   %esi
 1c6:	6a 00                	push   $0x0
 1c8:	e8 45 01 00 00       	call   312 <read>
    if(cc < 1)
 1cd:	83 c4 10             	add    $0x10,%esp
 1d0:	85 c0                	test   %eax,%eax
 1d2:	7e 1d                	jle    1f1 <gets+0x41>
      break;
    buf[i++] = c;
 1d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1d8:	8b 55 08             	mov    0x8(%ebp),%edx
 1db:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1df:	3c 0a                	cmp    $0xa,%al
 1e1:	74 10                	je     1f3 <gets+0x43>
 1e3:	3c 0d                	cmp    $0xd,%al
 1e5:	74 0c                	je     1f3 <gets+0x43>
  for(i = 0; i+1 < max; ){
 1e7:	89 df                	mov    %ebx,%edi
 1e9:	83 c3 01             	add    $0x1,%ebx
 1ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1ef:	7c cf                	jl     1c0 <gets+0x10>
 1f1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 1fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1fd:	5b                   	pop    %ebx
 1fe:	5e                   	pop    %esi
 1ff:	5f                   	pop    %edi
 200:	5d                   	pop    %ebp
 201:	c3                   	ret
 202:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 209:	00 
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	push   0x8(%ebp)
 21d:	e8 40 01 00 00       	call   362 <open>
  if(fd < 0)
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	push   0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 f3 00 00 00       	call   32a <fstat>
  close(fd);
 237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 23a:	89 c6                	mov    %eax,%esi
  close(fd);
 23c:	e8 51 01 00 00       	call   392 <close>
  return r;
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25e:	00 
 25f:	90                   	nop

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 02             	movsbl (%edx),%eax
 26a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 26d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 270:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 275:	77 1e                	ja     295 <atoi+0x35>
 277:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27e:	00 
 27f:	90                   	nop
    n = n*10 + *s++ - '0';
 280:	83 c2 01             	add    $0x1,%edx
 283:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 286:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 28a:	0f be 02             	movsbl (%edx),%eax
 28d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 298:	89 c8                	mov    %ecx,%eax
 29a:	c9                   	leave
 29b:	c3                   	ret
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
 2a7:	8b 45 10             	mov    0x10(%ebp),%eax
 2aa:	56                   	push   %esi
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 2ae:	39 f2                	cmp    %esi,%edx
 2b0:	73 1e                	jae    2d0 <memmove+0x30>
    while(n-- > 0)
 2b2:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 2b5:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 2b7:	85 c0                	test   %eax,%eax
 2b9:	7e 0a                	jle    2c5 <memmove+0x25>
 2bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 2c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 2c1:	39 f9                	cmp    %edi,%ecx
 2c3:	75 fb                	jne    2c0 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2c5:	5e                   	pop    %esi
 2c6:	89 d0                	mov    %edx,%eax
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret
 2cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 2d0:	85 c0                	test   %eax,%eax
 2d2:	7e f1                	jle    2c5 <memmove+0x25>
    while(n-- > 0)
 2d4:	83 e8 01             	sub    $0x1,%eax
 2d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2de:	00 
 2df:	90                   	nop
      *--dst = *--src;
 2e0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 2e4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 2e7:	83 e8 01             	sub    $0x1,%eax
 2ea:	73 f4                	jae    2e0 <memmove+0x40>
}
 2ec:	5e                   	pop    %esi
 2ed:	89 d0                	mov    %edx,%eax
 2ef:	5f                   	pop    %edi
 2f0:	5d                   	pop    %ebp
 2f1:	c3                   	ret

000002f2 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 2f2:	b8 01 00 00 00       	mov    $0x1,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret

000002fa <exit>:
SYSCALL(exit)
 2fa:	b8 02 00 00 00       	mov    $0x2,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret

00000302 <wait>:
SYSCALL(wait)
 302:	b8 03 00 00 00       	mov    $0x3,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret

0000030a <pipe>:
SYSCALL(pipe)
 30a:	b8 04 00 00 00       	mov    $0x4,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret

00000312 <read>:
SYSCALL(read)
 312:	b8 05 00 00 00       	mov    $0x5,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret

0000031a <kill>:
SYSCALL(kill)
 31a:	b8 06 00 00 00       	mov    $0x6,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret

00000322 <exec>:
SYSCALL(exec)
 322:	b8 07 00 00 00       	mov    $0x7,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret

0000032a <fstat>:
SYSCALL(fstat)
 32a:	b8 08 00 00 00       	mov    $0x8,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret

00000332 <chdir>:
SYSCALL(chdir)
 332:	b8 09 00 00 00       	mov    $0x9,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret

0000033a <dup>:
SYSCALL(dup)
 33a:	b8 0a 00 00 00       	mov    $0xa,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret

00000342 <getpid>:
SYSCALL(getpid)
 342:	b8 0b 00 00 00       	mov    $0xb,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret

0000034a <sbrk>:
SYSCALL(sbrk)
 34a:	b8 0c 00 00 00       	mov    $0xc,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret

00000352 <sleep>:
SYSCALL(sleep)
 352:	b8 0d 00 00 00       	mov    $0xd,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret

0000035a <uptime>:
SYSCALL(uptime)
 35a:	b8 0e 00 00 00       	mov    $0xe,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret

00000362 <open>:
SYSCALL(open)
 362:	b8 0f 00 00 00       	mov    $0xf,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret

0000036a <write>:
SYSCALL(write)
 36a:	b8 10 00 00 00       	mov    $0x10,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret

00000372 <mknod>:
SYSCALL(mknod)
 372:	b8 11 00 00 00       	mov    $0x11,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret

0000037a <unlink>:
SYSCALL(unlink)
 37a:	b8 12 00 00 00       	mov    $0x12,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret

00000382 <link>:
SYSCALL(link)
 382:	b8 13 00 00 00       	mov    $0x13,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret

0000038a <mkdir>:
SYSCALL(mkdir)
 38a:	b8 14 00 00 00       	mov    $0x14,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret

00000392 <close>:
SYSCALL(close)
 392:	b8 15 00 00 00       	mov    $0x15,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret

0000039a <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 39a:	b8 16 00 00 00       	mov    $0x16,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret

000003a2 <settickets>:
SYSCALL(settickets)
 3a2:	b8 17 00 00 00       	mov    $0x17,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret

000003aa <getpinfo>:
SYSCALL(getpinfo)
 3aa:	b8 18 00 00 00       	mov    $0x18,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret

000003b2 <waitx>:
SYSCALL(waitx)
 3b2:	b8 19 00 00 00       	mov    $0x19,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret

000003ba <yield>:
SYSCALL(yield)
 3ba:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret
 3c2:	66 90                	xchg   %ax,%ax
 3c4:	66 90                	xchg   %ax,%ax
 3c6:	66 90                	xchg   %ax,%ax
 3c8:	66 90                	xchg   %ax,%ax
 3ca:	66 90                	xchg   %ax,%ax
 3cc:	66 90                	xchg   %ax,%ax
 3ce:	66 90                	xchg   %ax,%ax
 3d0:	66 90                	xchg   %ax,%ax
 3d2:	66 90                	xchg   %ax,%ax
 3d4:	66 90                	xchg   %ax,%ax
 3d6:	66 90                	xchg   %ax,%ax
 3d8:	66 90                	xchg   %ax,%ax
 3da:	66 90                	xchg   %ax,%ax
 3dc:	66 90                	xchg   %ax,%ax
 3de:	66 90                	xchg   %ax,%ax

000003e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3e8:	89 d1                	mov    %edx,%ecx
{
 3ea:	83 ec 3c             	sub    $0x3c,%esp
 3ed:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 3f0:	85 d2                	test   %edx,%edx
 3f2:	0f 89 98 00 00 00    	jns    490 <printint+0xb0>
 3f8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3fc:	0f 84 8e 00 00 00    	je     490 <printint+0xb0>
    x = -xx;
 402:	f7 d9                	neg    %ecx
    neg = 1;
 404:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 409:	89 45 c0             	mov    %eax,-0x40(%ebp)
 40c:	31 f6                	xor    %esi,%esi
 40e:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 415:	00 
 416:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41d:	00 
 41e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 420:	89 c8                	mov    %ecx,%eax
 422:	31 d2                	xor    %edx,%edx
 424:	89 f7                	mov    %esi,%edi
 426:	f7 f3                	div    %ebx
 428:	8d 76 01             	lea    0x1(%esi),%esi
 42b:	0f b6 92 9c 08 00 00 	movzbl 0x89c(%edx),%edx
 432:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 436:	89 ca                	mov    %ecx,%edx
 438:	89 c1                	mov    %eax,%ecx
 43a:	39 da                	cmp    %ebx,%edx
 43c:	73 e2                	jae    420 <printint+0x40>
  if(neg)
 43e:	8b 45 c0             	mov    -0x40(%ebp),%eax
 441:	85 c0                	test   %eax,%eax
 443:	74 07                	je     44c <printint+0x6c>
    buf[i++] = '-';
 445:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 44a:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 44c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 44f:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 452:	01 df                	add    %ebx,%edi
 454:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45b:	00 
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 460:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 463:	83 ec 04             	sub    $0x4,%esp
 466:	88 45 d7             	mov    %al,-0x29(%ebp)
 469:	8d 45 d7             	lea    -0x29(%ebp),%eax
 46c:	6a 01                	push   $0x1
 46e:	50                   	push   %eax
 46f:	56                   	push   %esi
 470:	e8 f5 fe ff ff       	call   36a <write>
  while(--i >= 0)
 475:	89 f8                	mov    %edi,%eax
 477:	83 c4 10             	add    $0x10,%esp
 47a:	83 ef 01             	sub    $0x1,%edi
 47d:	39 d8                	cmp    %ebx,%eax
 47f:	75 df                	jne    460 <printint+0x80>
}
 481:	8d 65 f4             	lea    -0xc(%ebp),%esp
 484:	5b                   	pop    %ebx
 485:	5e                   	pop    %esi
 486:	5f                   	pop    %edi
 487:	5d                   	pop    %ebp
 488:	c3                   	ret
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 490:	31 c0                	xor    %eax,%eax
 492:	e9 72 ff ff ff       	jmp    409 <printint+0x29>
 497:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49e:	00 
 49f:	90                   	nop

000004a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4ac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4af:	0f b6 13             	movzbl (%ebx),%edx
 4b2:	83 c3 01             	add    $0x1,%ebx
 4b5:	84 d2                	test   %dl,%dl
 4b7:	0f 84 a0 00 00 00    	je     55d <printf+0xbd>
 4bd:	8d 45 10             	lea    0x10(%ebp),%eax
 4c0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 4c3:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4c6:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 4c9:	eb 28                	jmp    4f3 <printf+0x53>
 4cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 4d0:	83 ec 04             	sub    $0x4,%esp
 4d3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 4d9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 4dc:	6a 01                	push   $0x1
 4de:	50                   	push   %eax
 4df:	56                   	push   %esi
 4e0:	e8 85 fe ff ff       	call   36a <write>
  for(i = 0; fmt[i]; i++){
 4e5:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4e9:	83 c4 10             	add    $0x10,%esp
 4ec:	84 d2                	test   %dl,%dl
 4ee:	74 6d                	je     55d <printf+0xbd>
    c = fmt[i] & 0xff;
 4f0:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 4f3:	83 f8 25             	cmp    $0x25,%eax
 4f6:	75 d8                	jne    4d0 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 4f8:	0f b6 13             	movzbl (%ebx),%edx
 4fb:	84 d2                	test   %dl,%dl
 4fd:	74 5e                	je     55d <printf+0xbd>
    c = fmt[i] & 0xff;
 4ff:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 502:	80 fa 25             	cmp    $0x25,%dl
 505:	0f 84 1d 01 00 00    	je     628 <printf+0x188>
 50b:	83 e8 63             	sub    $0x63,%eax
 50e:	83 f8 15             	cmp    $0x15,%eax
 511:	77 0d                	ja     520 <printf+0x80>
 513:	ff 24 85 44 08 00 00 	jmp    *0x844(,%eax,4)
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 526:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 529:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 52d:	6a 01                	push   $0x1
 52f:	51                   	push   %ecx
 530:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 533:	56                   	push   %esi
 534:	e8 31 fe ff ff       	call   36a <write>
        putc(fd, c);
 539:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 53d:	83 c4 0c             	add    $0xc,%esp
 540:	88 55 e7             	mov    %dl,-0x19(%ebp)
 543:	6a 01                	push   $0x1
 545:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 548:	51                   	push   %ecx
 549:	56                   	push   %esi
 54a:	e8 1b fe ff ff       	call   36a <write>
  for(i = 0; fmt[i]; i++){
 54f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 553:	83 c3 02             	add    $0x2,%ebx
 556:	83 c4 10             	add    $0x10,%esp
 559:	84 d2                	test   %dl,%dl
 55b:	75 93                	jne    4f0 <printf+0x50>
      }
      state = 0;
    }
  }
}
 55d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 560:	5b                   	pop    %ebx
 561:	5e                   	pop    %esi
 562:	5f                   	pop    %edi
 563:	5d                   	pop    %ebp
 564:	c3                   	ret
 565:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 568:	83 ec 0c             	sub    $0xc,%esp
 56b:	8b 17                	mov    (%edi),%edx
 56d:	b9 10 00 00 00       	mov    $0x10,%ecx
 572:	89 f0                	mov    %esi,%eax
 574:	6a 00                	push   $0x0
        ap++;
 576:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 579:	e8 62 fe ff ff       	call   3e0 <printint>
  for(i = 0; fmt[i]; i++){
 57e:	eb cf                	jmp    54f <printf+0xaf>
        s = (char*)*ap;
 580:	8b 07                	mov    (%edi),%eax
        ap++;
 582:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 585:	85 c0                	test   %eax,%eax
 587:	0f 84 b3 00 00 00    	je     640 <printf+0x1a0>
        while(*s != 0){
 58d:	0f b6 10             	movzbl (%eax),%edx
 590:	84 d2                	test   %dl,%dl
 592:	0f 84 ba 00 00 00    	je     652 <printf+0x1b2>
 598:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 59b:	89 c7                	mov    %eax,%edi
 59d:	89 d0                	mov    %edx,%eax
 59f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5a2:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5a5:	89 fb                	mov    %edi,%ebx
 5a7:	89 cf                	mov    %ecx,%edi
 5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5b0:	83 ec 04             	sub    $0x4,%esp
 5b3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 5b6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 5b9:	6a 01                	push   $0x1
 5bb:	57                   	push   %edi
 5bc:	56                   	push   %esi
 5bd:	e8 a8 fd ff ff       	call   36a <write>
        while(*s != 0){
 5c2:	0f b6 03             	movzbl (%ebx),%eax
 5c5:	83 c4 10             	add    $0x10,%esp
 5c8:	84 c0                	test   %al,%al
 5ca:	75 e4                	jne    5b0 <printf+0x110>
 5cc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5cf:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5d3:	83 c3 02             	add    $0x2,%ebx
 5d6:	84 d2                	test   %dl,%dl
 5d8:	0f 85 e5 fe ff ff    	jne    4c3 <printf+0x23>
 5de:	e9 7a ff ff ff       	jmp    55d <printf+0xbd>
 5e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5e8:	83 ec 0c             	sub    $0xc,%esp
 5eb:	8b 17                	mov    (%edi),%edx
 5ed:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5f2:	89 f0                	mov    %esi,%eax
 5f4:	6a 01                	push   $0x1
        ap++;
 5f6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 5f9:	e8 e2 fd ff ff       	call   3e0 <printint>
  for(i = 0; fmt[i]; i++){
 5fe:	e9 4c ff ff ff       	jmp    54f <printf+0xaf>
 603:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 608:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 60a:	83 ec 04             	sub    $0x4,%esp
 60d:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 610:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 613:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 616:	6a 01                	push   $0x1
 618:	51                   	push   %ecx
 619:	56                   	push   %esi
 61a:	e8 4b fd ff ff       	call   36a <write>
  for(i = 0; fmt[i]; i++){
 61f:	e9 2b ff ff ff       	jmp    54f <printf+0xaf>
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 628:	83 ec 04             	sub    $0x4,%esp
 62b:	88 55 e7             	mov    %dl,-0x19(%ebp)
 62e:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 631:	6a 01                	push   $0x1
 633:	e9 10 ff ff ff       	jmp    548 <printf+0xa8>
 638:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 63f:	00 
          s = "(null)";
 640:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 643:	b8 28 00 00 00       	mov    $0x28,%eax
 648:	bf 3b 08 00 00       	mov    $0x83b,%edi
 64d:	e9 4d ff ff ff       	jmp    59f <printf+0xff>
  for(i = 0; fmt[i]; i++){
 652:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 656:	83 c3 02             	add    $0x2,%ebx
 659:	84 d2                	test   %dl,%dl
 65b:	0f 85 8f fe ff ff    	jne    4f0 <printf+0x50>
 661:	e9 f7 fe ff ff       	jmp    55d <printf+0xbd>
 666:	66 90                	xchg   %ax,%ax
 668:	66 90                	xchg   %ax,%ax
 66a:	66 90                	xchg   %ax,%ax
 66c:	66 90                	xchg   %ax,%ax
 66e:	66 90                	xchg   %ax,%ax
 670:	66 90                	xchg   %ax,%ax
 672:	66 90                	xchg   %ax,%ax
 674:	66 90                	xchg   %ax,%ax
 676:	66 90                	xchg   %ax,%ax
 678:	66 90                	xchg   %ax,%ax
 67a:	66 90                	xchg   %ax,%ax
 67c:	66 90                	xchg   %ax,%ax
 67e:	66 90                	xchg   %ax,%ax

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	a1 54 0b 00 00       	mov    0xb54,%eax
{
 686:	89 e5                	mov    %esp,%ebp
 688:	57                   	push   %edi
 689:	56                   	push   %esi
 68a:	53                   	push   %ebx
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 68e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 698:	00 
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a4:	39 ca                	cmp    %ecx,%edx
 6a6:	73 30                	jae    6d8 <free+0x58>
 6a8:	39 c1                	cmp    %eax,%ecx
 6aa:	72 04                	jb     6b0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ac:	39 c2                	cmp    %eax,%edx
 6ae:	72 f0                	jb     6a0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6b6:	39 f8                	cmp    %edi,%eax
 6b8:	74 36                	je     6f0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6bd:	8b 42 04             	mov    0x4(%edx),%eax
 6c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6c3:	39 f1                	cmp    %esi,%ecx
 6c5:	74 40                	je     707 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6c7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6c9:	5b                   	pop    %ebx
  freep = p;
 6ca:	89 15 54 0b 00 00    	mov    %edx,0xb54
}
 6d0:	5e                   	pop    %esi
 6d1:	5f                   	pop    %edi
 6d2:	5d                   	pop    %ebp
 6d3:	c3                   	ret
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d8:	39 c2                	cmp    %eax,%edx
 6da:	72 c4                	jb     6a0 <free+0x20>
 6dc:	39 c1                	cmp    %eax,%ecx
 6de:	73 c0                	jae    6a0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 6e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6e6:	39 f8                	cmp    %edi,%eax
 6e8:	75 d0                	jne    6ba <free+0x3a>
 6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 6f0:	03 70 04             	add    0x4(%eax),%esi
 6f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f6:	8b 02                	mov    (%edx),%eax
 6f8:	8b 00                	mov    (%eax),%eax
 6fa:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6fd:	8b 42 04             	mov    0x4(%edx),%eax
 700:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 703:	39 f1                	cmp    %esi,%ecx
 705:	75 c0                	jne    6c7 <free+0x47>
    p->s.size += bp->s.size;
 707:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 70a:	89 15 54 0b 00 00    	mov    %edx,0xb54
    p->s.size += bp->s.size;
 710:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 713:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 716:	89 0a                	mov    %ecx,(%edx)
}
 718:	5b                   	pop    %ebx
 719:	5e                   	pop    %esi
 71a:	5f                   	pop    %edi
 71b:	5d                   	pop    %ebp
 71c:	c3                   	ret
 71d:	8d 76 00             	lea    0x0(%esi),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 15 54 0b 00 00    	mov    0xb54,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 78 07             	lea    0x7(%eax),%edi
 735:	c1 ef 03             	shr    $0x3,%edi
 738:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 73b:	85 d2                	test   %edx,%edx
 73d:	0f 84 8d 00 00 00    	je     7d0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 743:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 745:	8b 48 04             	mov    0x4(%eax),%ecx
 748:	39 f9                	cmp    %edi,%ecx
 74a:	73 64                	jae    7b0 <malloc+0x90>
  if(nu < 4096)
 74c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 751:	39 df                	cmp    %ebx,%edi
 753:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 756:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 75d:	eb 0a                	jmp    769 <malloc+0x49>
 75f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 760:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 762:	8b 48 04             	mov    0x4(%eax),%ecx
 765:	39 f9                	cmp    %edi,%ecx
 767:	73 47                	jae    7b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 769:	89 c2                	mov    %eax,%edx
 76b:	39 05 54 0b 00 00    	cmp    %eax,0xb54
 771:	75 ed                	jne    760 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 773:	83 ec 0c             	sub    $0xc,%esp
 776:	56                   	push   %esi
 777:	e8 ce fb ff ff       	call   34a <sbrk>
  if(p == (char*)-1)
 77c:	83 c4 10             	add    $0x10,%esp
 77f:	83 f8 ff             	cmp    $0xffffffff,%eax
 782:	74 1c                	je     7a0 <malloc+0x80>
  hp->s.size = nu;
 784:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 787:	83 ec 0c             	sub    $0xc,%esp
 78a:	83 c0 08             	add    $0x8,%eax
 78d:	50                   	push   %eax
 78e:	e8 ed fe ff ff       	call   680 <free>
  return freep;
 793:	8b 15 54 0b 00 00    	mov    0xb54,%edx
      if((p = morecore(nunits)) == 0)
 799:	83 c4 10             	add    $0x10,%esp
 79c:	85 d2                	test   %edx,%edx
 79e:	75 c0                	jne    760 <malloc+0x40>
        return 0;
  }
}
 7a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7a3:	31 c0                	xor    %eax,%eax
}
 7a5:	5b                   	pop    %ebx
 7a6:	5e                   	pop    %esi
 7a7:	5f                   	pop    %edi
 7a8:	5d                   	pop    %ebp
 7a9:	c3                   	ret
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7b0:	39 cf                	cmp    %ecx,%edi
 7b2:	74 4c                	je     800 <malloc+0xe0>
        p->s.size -= nunits;
 7b4:	29 f9                	sub    %edi,%ecx
 7b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7bf:	89 15 54 0b 00 00    	mov    %edx,0xb54
}
 7c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7c8:	83 c0 08             	add    $0x8,%eax
}
 7cb:	5b                   	pop    %ebx
 7cc:	5e                   	pop    %esi
 7cd:	5f                   	pop    %edi
 7ce:	5d                   	pop    %ebp
 7cf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 7d0:	c7 05 54 0b 00 00 58 	movl   $0xb58,0xb54
 7d7:	0b 00 00 
    base.s.size = 0;
 7da:	b8 58 0b 00 00       	mov    $0xb58,%eax
    base.s.ptr = freep = prevp = &base;
 7df:	c7 05 58 0b 00 00 58 	movl   $0xb58,0xb58
 7e6:	0b 00 00 
    base.s.size = 0;
 7e9:	c7 05 5c 0b 00 00 00 	movl   $0x0,0xb5c
 7f0:	00 00 00 
    if(p->s.size >= nunits){
 7f3:	e9 54 ff ff ff       	jmp    74c <malloc+0x2c>
 7f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ff:	00 
        prevp->s.ptr = p->s.ptr;
 800:	8b 08                	mov    (%eax),%ecx
 802:	89 0a                	mov    %ecx,(%edx)
 804:	eb b9                	jmp    7bf <malloc+0x9f>
