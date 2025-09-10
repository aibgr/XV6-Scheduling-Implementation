
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 88 08 00 00       	push   $0x888
  19:	e8 c4 03 00 00       	call   3e2 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 9f 00 00 00    	js     c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 87 03 00 00       	call   3ba <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 7b 03 00 00       	call   3ba <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  49:	00 
  4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  50:	83 ec 08             	sub    $0x8,%esp
  53:	68 90 08 00 00       	push   $0x890
  58:	6a 01                	push   $0x1
  5a:	e8 c1 04 00 00       	call   520 <printf>
    pid = fork();
  5f:	e8 0e 03 00 00       	call   372 <fork>
    if(pid < 0){
  64:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  67:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  69:	85 c0                	test   %eax,%eax
  6b:	78 24                	js     91 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  6d:	74 35                	je     a4 <main+0xa4>
  6f:	90                   	nop
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  70:	e8 0d 03 00 00       	call   382 <wait>
  75:	85 c0                	test   %eax,%eax
  77:	78 d7                	js     50 <main+0x50>
  79:	39 c3                	cmp    %eax,%ebx
  7b:	74 d3                	je     50 <main+0x50>
      printf(1, "zombie!\n");
  7d:	83 ec 08             	sub    $0x8,%esp
  80:	68 cf 08 00 00       	push   $0x8cf
  85:	6a 01                	push   $0x1
  87:	e8 94 04 00 00       	call   520 <printf>
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	eb df                	jmp    70 <main+0x70>
      printf(1, "init: fork failed\n");
  91:	53                   	push   %ebx
  92:	53                   	push   %ebx
  93:	68 a3 08 00 00       	push   $0x8a3
  98:	6a 01                	push   $0x1
  9a:	e8 81 04 00 00       	call   520 <printf>
      exit();
  9f:	e8 d6 02 00 00       	call   37a <exit>
      exec("sh", argv);
  a4:	50                   	push   %eax
  a5:	50                   	push   %eax
  a6:	68 e4 0b 00 00       	push   $0xbe4
  ab:	68 b6 08 00 00       	push   $0x8b6
  b0:	e8 ed 02 00 00       	call   3a2 <exec>
      printf(1, "init: exec sh failed\n");
  b5:	5a                   	pop    %edx
  b6:	59                   	pop    %ecx
  b7:	68 b9 08 00 00       	push   $0x8b9
  bc:	6a 01                	push   $0x1
  be:	e8 5d 04 00 00       	call   520 <printf>
      exit();
  c3:	e8 b2 02 00 00       	call   37a <exit>
    mknod("console", 1, 1);
  c8:	50                   	push   %eax
  c9:	6a 01                	push   $0x1
  cb:	6a 01                	push   $0x1
  cd:	68 88 08 00 00       	push   $0x888
  d2:	e8 1b 03 00 00       	call   3f2 <mknod>
    open("console", O_RDWR);
  d7:	58                   	pop    %eax
  d8:	5a                   	pop    %edx
  d9:	6a 02                	push   $0x2
  db:	68 88 08 00 00       	push   $0x888
  e0:	e8 fd 02 00 00       	call   3e2 <open>
  e5:	83 c4 10             	add    $0x10,%esp
  e8:	e9 3c ff ff ff       	jmp    29 <main+0x29>
  ed:	66 90                	xchg   %ax,%ax
  ef:	66 90                	xchg   %ax,%ax
  f1:	66 90                	xchg   %ax,%ax
  f3:	66 90                	xchg   %ax,%ax
  f5:	66 90                	xchg   %ax,%ax
  f7:	66 90                	xchg   %ax,%ax
  f9:	66 90                	xchg   %ax,%ax
  fb:	66 90                	xchg   %ax,%ax
  fd:	66 90                	xchg   %ax,%ax
  ff:	90                   	nop

00000100 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 100:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
 101:	31 c0                	xor    %eax,%eax
{
 103:	89 e5                	mov    %esp,%ebp
 105:	53                   	push   %ebx
 106:	8b 4d 08             	mov    0x8(%ebp),%ecx
 109:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
 110:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 114:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 117:	83 c0 01             	add    $0x1,%eax
 11a:	84 d2                	test   %dl,%dl
 11c:	75 f2                	jne    110 <strcpy+0x10>
  return os;
}
 11e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 121:	89 c8                	mov    %ecx,%eax
 123:	c9                   	leave
 124:	c3                   	ret
 125:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12c:	00 
 12d:	8d 76 00             	lea    0x0(%esi),%esi

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 13a:	0f b6 02             	movzbl (%edx),%eax
 13d:	84 c0                	test   %al,%al
 13f:	75 2f                	jne    170 <strcmp+0x40>
 141:	eb 4a                	jmp    18d <strcmp+0x5d>
 143:	eb 1b                	jmp    160 <strcmp+0x30>
 145:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14c:	00 
 14d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 154:	00 
 155:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 15c:	00 
 15d:	8d 76 00             	lea    0x0(%esi),%esi
 160:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 164:	83 c2 01             	add    $0x1,%edx
 167:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 16a:	84 c0                	test   %al,%al
 16c:	74 12                	je     180 <strcmp+0x50>
 16e:	89 d9                	mov    %ebx,%ecx
 170:	0f b6 19             	movzbl (%ecx),%ebx
 173:	38 c3                	cmp    %al,%bl
 175:	74 e9                	je     160 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 177:	29 d8                	sub    %ebx,%eax
}
 179:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 17c:	c9                   	leave
 17d:	c3                   	ret
 17e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 180:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 184:	31 c0                	xor    %eax,%eax
 186:	29 d8                	sub    %ebx,%eax
}
 188:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 18b:	c9                   	leave
 18c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 18d:	0f b6 19             	movzbl (%ecx),%ebx
 190:	31 c0                	xor    %eax,%eax
 192:	eb e3                	jmp    177 <strcmp+0x47>
 194:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19b:	00 
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 1a6:	80 3a 00             	cmpb   $0x0,(%edx)
 1a9:	74 15                	je     1c0 <strlen+0x20>
 1ab:	31 c0                	xor    %eax,%eax
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	83 c0 01             	add    $0x1,%eax
 1b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1b7:	89 c1                	mov    %eax,%ecx
 1b9:	75 f5                	jne    1b0 <strlen+0x10>
  return n;
}
 1bb:	89 c8                	mov    %ecx,%eax
 1bd:	5d                   	pop    %ebp
 1be:	c3                   	ret
 1bf:	90                   	nop
  for(n = 0; s[n]; n++);
 1c0:	31 c9                	xor    %ecx,%ecx
}
 1c2:	5d                   	pop    %ebp
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	c3                   	ret
 1c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cd:	00 
 1ce:	66 90                	xchg   %ax,%ax

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1e5:	89 d0                	mov    %edx,%eax
 1e7:	c9                   	leave
 1e8:	c3                   	ret
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	75 1a                	jne    21b <strchr+0x2b>
 201:	eb 25                	jmp    228 <strchr+0x38>
 203:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20a:	00 
 20b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 210:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 214:	83 c0 01             	add    $0x1,%eax
 217:	84 d2                	test   %dl,%dl
 219:	74 0d                	je     228 <strchr+0x38>
    if(*s == c)
 21b:	38 d1                	cmp    %dl,%cl
 21d:	75 f1                	jne    210 <strchr+0x20>
      return (char*)s;
  return 0;
}
 21f:	5d                   	pop    %ebp
 220:	c3                   	ret
 221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 228:	31 c0                	xor    %eax,%eax
}
 22a:	5d                   	pop    %ebp
 22b:	c3                   	ret
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 235:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 238:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 239:	31 db                	xor    %ebx,%ebx
{
 23b:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 23e:	eb 27                	jmp    267 <gets+0x37>
    cc = read(0, &c, 1);
 240:	83 ec 04             	sub    $0x4,%esp
 243:	6a 01                	push   $0x1
 245:	56                   	push   %esi
 246:	6a 00                	push   $0x0
 248:	e8 45 01 00 00       	call   392 <read>
    if(cc < 1)
 24d:	83 c4 10             	add    $0x10,%esp
 250:	85 c0                	test   %eax,%eax
 252:	7e 1d                	jle    271 <gets+0x41>
      break;
    buf[i++] = c;
 254:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 258:	8b 55 08             	mov    0x8(%ebp),%edx
 25b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 25f:	3c 0a                	cmp    $0xa,%al
 261:	74 10                	je     273 <gets+0x43>
 263:	3c 0d                	cmp    $0xd,%al
 265:	74 0c                	je     273 <gets+0x43>
  for(i = 0; i+1 < max; ){
 267:	89 df                	mov    %ebx,%edi
 269:	83 c3 01             	add    $0x1,%ebx
 26c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 26f:	7c cf                	jl     240 <gets+0x10>
 271:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 27a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 27d:	5b                   	pop    %ebx
 27e:	5e                   	pop    %esi
 27f:	5f                   	pop    %edi
 280:	5d                   	pop    %ebp
 281:	c3                   	ret
 282:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 289:	00 
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 295:	83 ec 08             	sub    $0x8,%esp
 298:	6a 00                	push   $0x0
 29a:	ff 75 08             	push   0x8(%ebp)
 29d:	e8 40 01 00 00       	call   3e2 <open>
  if(fd < 0)
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	78 27                	js     2d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	ff 75 0c             	push   0xc(%ebp)
 2af:	89 c3                	mov    %eax,%ebx
 2b1:	50                   	push   %eax
 2b2:	e8 f3 00 00 00       	call   3aa <fstat>
  close(fd);
 2b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ba:	89 c6                	mov    %eax,%esi
  close(fd);
 2bc:	e8 51 01 00 00       	call   412 <close>
  return r;
 2c1:	83 c4 10             	add    $0x10,%esp
}
 2c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2c7:	89 f0                	mov    %esi,%eax
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2d5:	eb ed                	jmp    2c4 <stat+0x34>
 2d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2de:	00 
 2df:	90                   	nop

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e7:	0f be 02             	movsbl (%edx),%eax
 2ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2f5:	77 1e                	ja     315 <atoi+0x35>
 2f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2fe:	00 
 2ff:	90                   	nop
    n = n*10 + *s++ - '0';
 300:	83 c2 01             	add    $0x1,%edx
 303:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 306:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 30a:	0f be 02             	movsbl (%edx),%eax
 30d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x20>
  return n;
}
 315:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 318:	89 c8                	mov    %ecx,%eax
 31a:	c9                   	leave
 31b:	c3                   	ret
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	8b 55 08             	mov    0x8(%ebp),%edx
 327:	8b 45 10             	mov    0x10(%ebp),%eax
 32a:	56                   	push   %esi
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 32e:	39 f2                	cmp    %esi,%edx
 330:	73 1e                	jae    350 <memmove+0x30>
    while(n-- > 0)
 332:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 335:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 337:	85 c0                	test   %eax,%eax
 339:	7e 0a                	jle    345 <memmove+0x25>
 33b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 340:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 341:	39 f9                	cmp    %edi,%ecx
 343:	75 fb                	jne    340 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 345:	5e                   	pop    %esi
 346:	89 d0                	mov    %edx,%eax
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret
 34b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 350:	85 c0                	test   %eax,%eax
 352:	7e f1                	jle    345 <memmove+0x25>
    while(n-- > 0)
 354:	83 e8 01             	sub    $0x1,%eax
 357:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35e:	00 
 35f:	90                   	nop
      *--dst = *--src;
 360:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 364:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 367:	83 e8 01             	sub    $0x1,%eax
 36a:	73 f4                	jae    360 <memmove+0x40>
}
 36c:	5e                   	pop    %esi
 36d:	89 d0                	mov    %edx,%eax
 36f:	5f                   	pop    %edi
 370:	5d                   	pop    %ebp
 371:	c3                   	ret

00000372 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 372:	b8 01 00 00 00       	mov    $0x1,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret

0000037a <exit>:
SYSCALL(exit)
 37a:	b8 02 00 00 00       	mov    $0x2,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret

00000382 <wait>:
SYSCALL(wait)
 382:	b8 03 00 00 00       	mov    $0x3,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret

0000038a <pipe>:
SYSCALL(pipe)
 38a:	b8 04 00 00 00       	mov    $0x4,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret

00000392 <read>:
SYSCALL(read)
 392:	b8 05 00 00 00       	mov    $0x5,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret

0000039a <kill>:
SYSCALL(kill)
 39a:	b8 06 00 00 00       	mov    $0x6,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret

000003a2 <exec>:
SYSCALL(exec)
 3a2:	b8 07 00 00 00       	mov    $0x7,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret

000003aa <fstat>:
SYSCALL(fstat)
 3aa:	b8 08 00 00 00       	mov    $0x8,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret

000003b2 <chdir>:
SYSCALL(chdir)
 3b2:	b8 09 00 00 00       	mov    $0x9,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret

000003ba <dup>:
SYSCALL(dup)
 3ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret

000003c2 <getpid>:
SYSCALL(getpid)
 3c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret

000003ca <sbrk>:
SYSCALL(sbrk)
 3ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret

000003d2 <sleep>:
SYSCALL(sleep)
 3d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret

000003da <uptime>:
SYSCALL(uptime)
 3da:	b8 0e 00 00 00       	mov    $0xe,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret

000003e2 <open>:
SYSCALL(open)
 3e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret

000003ea <write>:
SYSCALL(write)
 3ea:	b8 10 00 00 00       	mov    $0x10,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret

000003f2 <mknod>:
SYSCALL(mknod)
 3f2:	b8 11 00 00 00       	mov    $0x11,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret

000003fa <unlink>:
SYSCALL(unlink)
 3fa:	b8 12 00 00 00       	mov    $0x12,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret

00000402 <link>:
SYSCALL(link)
 402:	b8 13 00 00 00       	mov    $0x13,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret

0000040a <mkdir>:
SYSCALL(mkdir)
 40a:	b8 14 00 00 00       	mov    $0x14,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret

00000412 <close>:
SYSCALL(close)
 412:	b8 15 00 00 00       	mov    $0x15,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret

0000041a <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 41a:	b8 16 00 00 00       	mov    $0x16,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret

00000422 <settickets>:
SYSCALL(settickets)
 422:	b8 17 00 00 00       	mov    $0x17,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret

0000042a <getpinfo>:
SYSCALL(getpinfo)
 42a:	b8 18 00 00 00       	mov    $0x18,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret

00000432 <waitx>:
SYSCALL(waitx)
 432:	b8 19 00 00 00       	mov    $0x19,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret

0000043a <yield>:
SYSCALL(yield)
 43a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret
 442:	66 90                	xchg   %ax,%ax
 444:	66 90                	xchg   %ax,%ax
 446:	66 90                	xchg   %ax,%ax
 448:	66 90                	xchg   %ax,%ax
 44a:	66 90                	xchg   %ax,%ax
 44c:	66 90                	xchg   %ax,%ax
 44e:	66 90                	xchg   %ax,%ax
 450:	66 90                	xchg   %ax,%ax
 452:	66 90                	xchg   %ax,%ax
 454:	66 90                	xchg   %ax,%ax
 456:	66 90                	xchg   %ax,%ax
 458:	66 90                	xchg   %ax,%ax
 45a:	66 90                	xchg   %ax,%ax
 45c:	66 90                	xchg   %ax,%ax
 45e:	66 90                	xchg   %ax,%ax

00000460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 468:	89 d1                	mov    %edx,%ecx
{
 46a:	83 ec 3c             	sub    $0x3c,%esp
 46d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 470:	85 d2                	test   %edx,%edx
 472:	0f 89 98 00 00 00    	jns    510 <printint+0xb0>
 478:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 47c:	0f 84 8e 00 00 00    	je     510 <printint+0xb0>
    x = -xx;
 482:	f7 d9                	neg    %ecx
    neg = 1;
 484:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 489:	89 45 c0             	mov    %eax,-0x40(%ebp)
 48c:	31 f6                	xor    %esi,%esi
 48e:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 495:	00 
 496:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49d:	00 
 49e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 4a0:	89 c8                	mov    %ecx,%eax
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	89 f7                	mov    %esi,%edi
 4a6:	f7 f3                	div    %ebx
 4a8:	8d 76 01             	lea    0x1(%esi),%esi
 4ab:	0f b6 92 38 09 00 00 	movzbl 0x938(%edx),%edx
 4b2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4b6:	89 ca                	mov    %ecx,%edx
 4b8:	89 c1                	mov    %eax,%ecx
 4ba:	39 da                	cmp    %ebx,%edx
 4bc:	73 e2                	jae    4a0 <printint+0x40>
  if(neg)
 4be:	8b 45 c0             	mov    -0x40(%ebp),%eax
 4c1:	85 c0                	test   %eax,%eax
 4c3:	74 07                	je     4cc <printint+0x6c>
    buf[i++] = '-';
 4c5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 4ca:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 4cc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4cf:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 4d2:	01 df                	add    %ebx,%edi
 4d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4db:	00 
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 4e0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4e3:	83 ec 04             	sub    $0x4,%esp
 4e6:	88 45 d7             	mov    %al,-0x29(%ebp)
 4e9:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4ec:	6a 01                	push   $0x1
 4ee:	50                   	push   %eax
 4ef:	56                   	push   %esi
 4f0:	e8 f5 fe ff ff       	call   3ea <write>
  while(--i >= 0)
 4f5:	89 f8                	mov    %edi,%eax
 4f7:	83 c4 10             	add    $0x10,%esp
 4fa:	83 ef 01             	sub    $0x1,%edi
 4fd:	39 d8                	cmp    %ebx,%eax
 4ff:	75 df                	jne    4e0 <printint+0x80>
}
 501:	8d 65 f4             	lea    -0xc(%ebp),%esp
 504:	5b                   	pop    %ebx
 505:	5e                   	pop    %esi
 506:	5f                   	pop    %edi
 507:	5d                   	pop    %ebp
 508:	c3                   	ret
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 510:	31 c0                	xor    %eax,%eax
 512:	e9 72 ff ff ff       	jmp    489 <printint+0x29>
 517:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51e:	00 
 51f:	90                   	nop

00000520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 529:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 52c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 52f:	0f b6 13             	movzbl (%ebx),%edx
 532:	83 c3 01             	add    $0x1,%ebx
 535:	84 d2                	test   %dl,%dl
 537:	0f 84 a0 00 00 00    	je     5dd <printf+0xbd>
 53d:	8d 45 10             	lea    0x10(%ebp),%eax
 540:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 543:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 546:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 549:	eb 28                	jmp    573 <printf+0x53>
 54b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 550:	83 ec 04             	sub    $0x4,%esp
 553:	8d 45 e7             	lea    -0x19(%ebp),%eax
 556:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 559:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 55c:	6a 01                	push   $0x1
 55e:	50                   	push   %eax
 55f:	56                   	push   %esi
 560:	e8 85 fe ff ff       	call   3ea <write>
  for(i = 0; fmt[i]; i++){
 565:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 569:	83 c4 10             	add    $0x10,%esp
 56c:	84 d2                	test   %dl,%dl
 56e:	74 6d                	je     5dd <printf+0xbd>
    c = fmt[i] & 0xff;
 570:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 573:	83 f8 25             	cmp    $0x25,%eax
 576:	75 d8                	jne    550 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 578:	0f b6 13             	movzbl (%ebx),%edx
 57b:	84 d2                	test   %dl,%dl
 57d:	74 5e                	je     5dd <printf+0xbd>
    c = fmt[i] & 0xff;
 57f:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 582:	80 fa 25             	cmp    $0x25,%dl
 585:	0f 84 1d 01 00 00    	je     6a8 <printf+0x188>
 58b:	83 e8 63             	sub    $0x63,%eax
 58e:	83 f8 15             	cmp    $0x15,%eax
 591:	77 0d                	ja     5a0 <printf+0x80>
 593:	ff 24 85 e0 08 00 00 	jmp    *0x8e0(,%eax,4)
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5a6:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5a9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 5ad:	6a 01                	push   $0x1
 5af:	51                   	push   %ecx
 5b0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 5b3:	56                   	push   %esi
 5b4:	e8 31 fe ff ff       	call   3ea <write>
        putc(fd, c);
 5b9:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 5bd:	83 c4 0c             	add    $0xc,%esp
 5c0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5c3:	6a 01                	push   $0x1
 5c5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 5c8:	51                   	push   %ecx
 5c9:	56                   	push   %esi
 5ca:	e8 1b fe ff ff       	call   3ea <write>
  for(i = 0; fmt[i]; i++){
 5cf:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5d3:	83 c3 02             	add    $0x2,%ebx
 5d6:	83 c4 10             	add    $0x10,%esp
 5d9:	84 d2                	test   %dl,%dl
 5db:	75 93                	jne    570 <printf+0x50>
      }
      state = 0;
    }
  }
}
 5dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e0:	5b                   	pop    %ebx
 5e1:	5e                   	pop    %esi
 5e2:	5f                   	pop    %edi
 5e3:	5d                   	pop    %ebp
 5e4:	c3                   	ret
 5e5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5e8:	83 ec 0c             	sub    $0xc,%esp
 5eb:	8b 17                	mov    (%edi),%edx
 5ed:	b9 10 00 00 00       	mov    $0x10,%ecx
 5f2:	89 f0                	mov    %esi,%eax
 5f4:	6a 00                	push   $0x0
        ap++;
 5f6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 5f9:	e8 62 fe ff ff       	call   460 <printint>
  for(i = 0; fmt[i]; i++){
 5fe:	eb cf                	jmp    5cf <printf+0xaf>
        s = (char*)*ap;
 600:	8b 07                	mov    (%edi),%eax
        ap++;
 602:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 605:	85 c0                	test   %eax,%eax
 607:	0f 84 b3 00 00 00    	je     6c0 <printf+0x1a0>
        while(*s != 0){
 60d:	0f b6 10             	movzbl (%eax),%edx
 610:	84 d2                	test   %dl,%dl
 612:	0f 84 ba 00 00 00    	je     6d2 <printf+0x1b2>
 618:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 61b:	89 c7                	mov    %eax,%edi
 61d:	89 d0                	mov    %edx,%eax
 61f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 622:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 625:	89 fb                	mov    %edi,%ebx
 627:	89 cf                	mov    %ecx,%edi
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 630:	83 ec 04             	sub    $0x4,%esp
 633:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 636:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 639:	6a 01                	push   $0x1
 63b:	57                   	push   %edi
 63c:	56                   	push   %esi
 63d:	e8 a8 fd ff ff       	call   3ea <write>
        while(*s != 0){
 642:	0f b6 03             	movzbl (%ebx),%eax
 645:	83 c4 10             	add    $0x10,%esp
 648:	84 c0                	test   %al,%al
 64a:	75 e4                	jne    630 <printf+0x110>
 64c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 64f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 653:	83 c3 02             	add    $0x2,%ebx
 656:	84 d2                	test   %dl,%dl
 658:	0f 85 e5 fe ff ff    	jne    543 <printf+0x23>
 65e:	e9 7a ff ff ff       	jmp    5dd <printf+0xbd>
 663:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 668:	83 ec 0c             	sub    $0xc,%esp
 66b:	8b 17                	mov    (%edi),%edx
 66d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 672:	89 f0                	mov    %esi,%eax
 674:	6a 01                	push   $0x1
        ap++;
 676:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 679:	e8 e2 fd ff ff       	call   460 <printint>
  for(i = 0; fmt[i]; i++){
 67e:	e9 4c ff ff ff       	jmp    5cf <printf+0xaf>
 683:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 688:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 68a:	83 ec 04             	sub    $0x4,%esp
 68d:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 690:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 693:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 696:	6a 01                	push   $0x1
 698:	51                   	push   %ecx
 699:	56                   	push   %esi
 69a:	e8 4b fd ff ff       	call   3ea <write>
  for(i = 0; fmt[i]; i++){
 69f:	e9 2b ff ff ff       	jmp    5cf <printf+0xaf>
 6a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6a8:	83 ec 04             	sub    $0x4,%esp
 6ab:	88 55 e7             	mov    %dl,-0x19(%ebp)
 6ae:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 6b1:	6a 01                	push   $0x1
 6b3:	e9 10 ff ff ff       	jmp    5c8 <printf+0xa8>
 6b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6bf:	00 
          s = "(null)";
 6c0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 6c3:	b8 28 00 00 00       	mov    $0x28,%eax
 6c8:	bf d8 08 00 00       	mov    $0x8d8,%edi
 6cd:	e9 4d ff ff ff       	jmp    61f <printf+0xff>
  for(i = 0; fmt[i]; i++){
 6d2:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 6d6:	83 c3 02             	add    $0x2,%ebx
 6d9:	84 d2                	test   %dl,%dl
 6db:	0f 85 8f fe ff ff    	jne    570 <printf+0x50>
 6e1:	e9 f7 fe ff ff       	jmp    5dd <printf+0xbd>
 6e6:	66 90                	xchg   %ax,%ax
 6e8:	66 90                	xchg   %ax,%ax
 6ea:	66 90                	xchg   %ax,%ax
 6ec:	66 90                	xchg   %ax,%ax
 6ee:	66 90                	xchg   %ax,%ax
 6f0:	66 90                	xchg   %ax,%ax
 6f2:	66 90                	xchg   %ax,%ax
 6f4:	66 90                	xchg   %ax,%ax
 6f6:	66 90                	xchg   %ax,%ax
 6f8:	66 90                	xchg   %ax,%ax
 6fa:	66 90                	xchg   %ax,%ax
 6fc:	66 90                	xchg   %ax,%ax
 6fe:	66 90                	xchg   %ax,%ax

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 ec 0b 00 00       	mov    0xbec,%eax
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 70e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 718:	00 
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 720:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 722:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 724:	39 ca                	cmp    %ecx,%edx
 726:	73 30                	jae    758 <free+0x58>
 728:	39 c1                	cmp    %eax,%ecx
 72a:	72 04                	jb     730 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72c:	39 c2                	cmp    %eax,%edx
 72e:	72 f0                	jb     720 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 730:	8b 73 fc             	mov    -0x4(%ebx),%esi
 733:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 736:	39 f8                	cmp    %edi,%eax
 738:	74 36                	je     770 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 73a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 73d:	8b 42 04             	mov    0x4(%edx),%eax
 740:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 743:	39 f1                	cmp    %esi,%ecx
 745:	74 40                	je     787 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 747:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 749:	5b                   	pop    %ebx
  freep = p;
 74a:	89 15 ec 0b 00 00    	mov    %edx,0xbec
}
 750:	5e                   	pop    %esi
 751:	5f                   	pop    %edi
 752:	5d                   	pop    %ebp
 753:	c3                   	ret
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 758:	39 c2                	cmp    %eax,%edx
 75a:	72 c4                	jb     720 <free+0x20>
 75c:	39 c1                	cmp    %eax,%ecx
 75e:	73 c0                	jae    720 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 760:	8b 73 fc             	mov    -0x4(%ebx),%esi
 763:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 766:	39 f8                	cmp    %edi,%eax
 768:	75 d0                	jne    73a <free+0x3a>
 76a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 770:	03 70 04             	add    0x4(%eax),%esi
 773:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 776:	8b 02                	mov    (%edx),%eax
 778:	8b 00                	mov    (%eax),%eax
 77a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 77d:	8b 42 04             	mov    0x4(%edx),%eax
 780:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 783:	39 f1                	cmp    %esi,%ecx
 785:	75 c0                	jne    747 <free+0x47>
    p->s.size += bp->s.size;
 787:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 78a:	89 15 ec 0b 00 00    	mov    %edx,0xbec
    p->s.size += bp->s.size;
 790:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 793:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 796:	89 0a                	mov    %ecx,(%edx)
}
 798:	5b                   	pop    %ebx
 799:	5e                   	pop    %esi
 79a:	5f                   	pop    %edi
 79b:	5d                   	pop    %ebp
 79c:	c3                   	ret
 79d:	8d 76 00             	lea    0x0(%esi),%esi

000007a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	57                   	push   %edi
 7a4:	56                   	push   %esi
 7a5:	53                   	push   %ebx
 7a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ac:	8b 15 ec 0b 00 00    	mov    0xbec,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b2:	8d 78 07             	lea    0x7(%eax),%edi
 7b5:	c1 ef 03             	shr    $0x3,%edi
 7b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7bb:	85 d2                	test   %edx,%edx
 7bd:	0f 84 8d 00 00 00    	je     850 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7c5:	8b 48 04             	mov    0x4(%eax),%ecx
 7c8:	39 f9                	cmp    %edi,%ecx
 7ca:	73 64                	jae    830 <malloc+0x90>
  if(nu < 4096)
 7cc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7d1:	39 df                	cmp    %ebx,%edi
 7d3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7d6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7dd:	eb 0a                	jmp    7e9 <malloc+0x49>
 7df:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7e2:	8b 48 04             	mov    0x4(%eax),%ecx
 7e5:	39 f9                	cmp    %edi,%ecx
 7e7:	73 47                	jae    830 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e9:	89 c2                	mov    %eax,%edx
 7eb:	39 05 ec 0b 00 00    	cmp    %eax,0xbec
 7f1:	75 ed                	jne    7e0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7f3:	83 ec 0c             	sub    $0xc,%esp
 7f6:	56                   	push   %esi
 7f7:	e8 ce fb ff ff       	call   3ca <sbrk>
  if(p == (char*)-1)
 7fc:	83 c4 10             	add    $0x10,%esp
 7ff:	83 f8 ff             	cmp    $0xffffffff,%eax
 802:	74 1c                	je     820 <malloc+0x80>
  hp->s.size = nu;
 804:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 807:	83 ec 0c             	sub    $0xc,%esp
 80a:	83 c0 08             	add    $0x8,%eax
 80d:	50                   	push   %eax
 80e:	e8 ed fe ff ff       	call   700 <free>
  return freep;
 813:	8b 15 ec 0b 00 00    	mov    0xbec,%edx
      if((p = morecore(nunits)) == 0)
 819:	83 c4 10             	add    $0x10,%esp
 81c:	85 d2                	test   %edx,%edx
 81e:	75 c0                	jne    7e0 <malloc+0x40>
        return 0;
  }
}
 820:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 823:	31 c0                	xor    %eax,%eax
}
 825:	5b                   	pop    %ebx
 826:	5e                   	pop    %esi
 827:	5f                   	pop    %edi
 828:	5d                   	pop    %ebp
 829:	c3                   	ret
 82a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 830:	39 cf                	cmp    %ecx,%edi
 832:	74 4c                	je     880 <malloc+0xe0>
        p->s.size -= nunits;
 834:	29 f9                	sub    %edi,%ecx
 836:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 839:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 83c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 83f:	89 15 ec 0b 00 00    	mov    %edx,0xbec
}
 845:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 848:	83 c0 08             	add    $0x8,%eax
}
 84b:	5b                   	pop    %ebx
 84c:	5e                   	pop    %esi
 84d:	5f                   	pop    %edi
 84e:	5d                   	pop    %ebp
 84f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 850:	c7 05 ec 0b 00 00 f0 	movl   $0xbf0,0xbec
 857:	0b 00 00 
    base.s.size = 0;
 85a:	b8 f0 0b 00 00       	mov    $0xbf0,%eax
    base.s.ptr = freep = prevp = &base;
 85f:	c7 05 f0 0b 00 00 f0 	movl   $0xbf0,0xbf0
 866:	0b 00 00 
    base.s.size = 0;
 869:	c7 05 f4 0b 00 00 00 	movl   $0x0,0xbf4
 870:	00 00 00 
    if(p->s.size >= nunits){
 873:	e9 54 ff ff ff       	jmp    7cc <malloc+0x2c>
 878:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 87f:	00 
        prevp->s.ptr = p->s.ptr;
 880:	8b 08                	mov    (%eax),%ecx
 882:	89 0a                	mov    %ecx,(%edx)
 884:	eb b9                	jmp    83f <malloc+0x9f>
