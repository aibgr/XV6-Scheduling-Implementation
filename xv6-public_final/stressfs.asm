
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
  int fd, i;
  char path[] = "stressfs0";
   7:	b8 30 00 00 00       	mov    $0x30,%eax
{
   c:	ff 71 fc             	push   -0x4(%ecx)
   f:	55                   	push   %ebp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %edi
  13:	56                   	push   %esi
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
  14:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
{
  1a:	53                   	push   %ebx

  for(i = 0; i < 4; i++)
  1b:	31 db                	xor    %ebx,%ebx
{
  1d:	51                   	push   %ecx
  1e:	81 ec 20 02 00 00    	sub    $0x220,%esp
  char path[] = "stressfs0";
  24:	66 89 85 e6 fd ff ff 	mov    %ax,-0x21a(%ebp)
  printf(1, "stressfs starting\n");
  2b:	68 c8 08 00 00       	push   $0x8c8
  30:	6a 01                	push   $0x1
  char path[] = "stressfs0";
  32:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  39:	74 72 65 
  3c:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  43:	73 66 73 
  printf(1, "stressfs starting\n");
  46:	e8 15 05 00 00       	call   560 <printf>
  memset(data, 'a', sizeof(data));
  4b:	83 c4 0c             	add    $0xc,%esp
  4e:	68 00 02 00 00       	push   $0x200
  53:	6a 61                	push   $0x61
  55:	56                   	push   %esi
  56:	e8 b5 01 00 00       	call   210 <memset>
  5b:	83 c4 10             	add    $0x10,%esp
    if(fork() > 0)
  5e:	e8 4f 03 00 00       	call   3b2 <fork>
  63:	85 c0                	test   %eax,%eax
  65:	0f 8f bf 00 00 00    	jg     12a <main+0x12a>
  for(i = 0; i < 4; i++)
  6b:	83 c3 01             	add    $0x1,%ebx
  6e:	83 fb 04             	cmp    $0x4,%ebx
  71:	75 eb                	jne    5e <main+0x5e>
  73:	bf 04 00 00 00       	mov    $0x4,%edi
      break;

  printf(1, "write %d\n", i);
  78:	83 ec 04             	sub    $0x4,%esp
  7b:	53                   	push   %ebx

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  7c:	bb 14 00 00 00       	mov    $0x14,%ebx
  printf(1, "write %d\n", i);
  81:	68 db 08 00 00       	push   $0x8db
  86:	6a 01                	push   $0x1
  88:	e8 d3 04 00 00       	call   560 <printf>
  path[8] += i;
  8d:	89 f8                	mov    %edi,%eax
  fd = open(path, O_CREATE | O_RDWR);
  8f:	5f                   	pop    %edi
  path[8] += i;
  90:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  96:	58                   	pop    %eax
  97:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  9d:	68 02 02 00 00       	push   $0x202
  a2:	50                   	push   %eax
  a3:	e8 7a 03 00 00       	call   422 <open>
  a8:	83 c4 10             	add    $0x10,%esp
  ab:	89 c7                	mov    %eax,%edi
  for(i = 0; i < 20; i++)
  ad:	8d 76 00             	lea    0x0(%esi),%esi
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	68 00 02 00 00       	push   $0x200
  b8:	56                   	push   %esi
  b9:	57                   	push   %edi
  ba:	e8 6b 03 00 00       	call   42a <write>
  for(i = 0; i < 20; i++)
  bf:	83 c4 10             	add    $0x10,%esp
  c2:	83 eb 01             	sub    $0x1,%ebx
  c5:	75 e9                	jne    b0 <main+0xb0>
  close(fd);
  c7:	83 ec 0c             	sub    $0xc,%esp
  ca:	57                   	push   %edi
  cb:	e8 82 03 00 00       	call   452 <close>

  printf(1, "read\n");
  d0:	58                   	pop    %eax
  d1:	5a                   	pop    %edx
  d2:	68 e5 08 00 00       	push   $0x8e5
  d7:	6a 01                	push   $0x1
  d9:	e8 82 04 00 00       	call   560 <printf>

  fd = open(path, O_RDONLY);
  de:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  e4:	59                   	pop    %ecx
  e5:	5b                   	pop    %ebx
  e6:	6a 00                	push   $0x0
  e8:	bb 14 00 00 00       	mov    $0x14,%ebx
  ed:	50                   	push   %eax
  ee:	e8 2f 03 00 00       	call   422 <open>
  f3:	83 c4 10             	add    $0x10,%esp
  f6:	89 c7                	mov    %eax,%edi
  for (i = 0; i < 20; i++)
  f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ff:	00 
    read(fd, data, sizeof(data));
 100:	83 ec 04             	sub    $0x4,%esp
 103:	68 00 02 00 00       	push   $0x200
 108:	56                   	push   %esi
 109:	57                   	push   %edi
 10a:	e8 c3 02 00 00       	call   3d2 <read>
  for (i = 0; i < 20; i++)
 10f:	83 c4 10             	add    $0x10,%esp
 112:	83 eb 01             	sub    $0x1,%ebx
 115:	75 e9                	jne    100 <main+0x100>
  close(fd);
 117:	83 ec 0c             	sub    $0xc,%esp
 11a:	57                   	push   %edi
 11b:	e8 32 03 00 00       	call   452 <close>

  wait();
 120:	e8 9d 02 00 00       	call   3c2 <wait>

  exit();
 125:	e8 90 02 00 00       	call   3ba <exit>
  path[8] += i;
 12a:	89 df                	mov    %ebx,%edi
 12c:	e9 47 ff ff ff       	jmp    78 <main+0x78>
 131:	66 90                	xchg   %ax,%ax
 133:	66 90                	xchg   %ax,%ax
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 140:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
 141:	31 c0                	xor    %eax,%eax
{
 143:	89 e5                	mov    %esp,%ebp
 145:	53                   	push   %ebx
 146:	8b 4d 08             	mov    0x8(%ebp),%ecx
 149:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
 150:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 154:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 157:	83 c0 01             	add    $0x1,%eax
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strcpy+0x10>
  return os;
}
 15e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 161:	89 c8                	mov    %ecx,%eax
 163:	c9                   	leave
 164:	c3                   	ret
 165:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16c:	00 
 16d:	8d 76 00             	lea    0x0(%esi),%esi

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 55 08             	mov    0x8(%ebp),%edx
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 17a:	0f b6 02             	movzbl (%edx),%eax
 17d:	84 c0                	test   %al,%al
 17f:	75 2f                	jne    1b0 <strcmp+0x40>
 181:	eb 4a                	jmp    1cd <strcmp+0x5d>
 183:	eb 1b                	jmp    1a0 <strcmp+0x30>
 185:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18c:	00 
 18d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 194:	00 
 195:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19c:	00 
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1a4:	83 c2 01             	add    $0x1,%edx
 1a7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1aa:	84 c0                	test   %al,%al
 1ac:	74 12                	je     1c0 <strcmp+0x50>
 1ae:	89 d9                	mov    %ebx,%ecx
 1b0:	0f b6 19             	movzbl (%ecx),%ebx
 1b3:	38 c3                	cmp    %al,%bl
 1b5:	74 e9                	je     1a0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 1b7:	29 d8                	sub    %ebx,%eax
}
 1b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1bc:	c9                   	leave
 1bd:	c3                   	ret
 1be:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 1c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1c4:	31 c0                	xor    %eax,%eax
 1c6:	29 d8                	sub    %ebx,%eax
}
 1c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1cb:	c9                   	leave
 1cc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1cd:	0f b6 19             	movzbl (%ecx),%ebx
 1d0:	31 c0                	xor    %eax,%eax
 1d2:	eb e3                	jmp    1b7 <strcmp+0x47>
 1d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1db:	00 
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001e0 <strlen>:

uint
strlen(const char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 1e6:	80 3a 00             	cmpb   $0x0,(%edx)
 1e9:	74 15                	je     200 <strlen+0x20>
 1eb:	31 c0                	xor    %eax,%eax
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	83 c0 01             	add    $0x1,%eax
 1f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1f7:	89 c1                	mov    %eax,%ecx
 1f9:	75 f5                	jne    1f0 <strlen+0x10>
  return n;
}
 1fb:	89 c8                	mov    %ecx,%eax
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret
 1ff:	90                   	nop
  for(n = 0; s[n]; n++);
 200:	31 c9                	xor    %ecx,%ecx
}
 202:	5d                   	pop    %ebp
 203:	89 c8                	mov    %ecx,%eax
 205:	c3                   	ret
 206:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20d:	00 
 20e:	66 90                	xchg   %ax,%ax

00000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 217:	8b 4d 10             	mov    0x10(%ebp),%ecx
 21a:	8b 45 0c             	mov    0xc(%ebp),%eax
 21d:	89 d7                	mov    %edx,%edi
 21f:	fc                   	cld
 220:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 222:	8b 7d fc             	mov    -0x4(%ebp),%edi
 225:	89 d0                	mov    %edx,%eax
 227:	c9                   	leave
 228:	c3                   	ret
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000230 <strchr>:

char*
strchr(const char *s, char c)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 23a:	0f b6 10             	movzbl (%eax),%edx
 23d:	84 d2                	test   %dl,%dl
 23f:	75 1a                	jne    25b <strchr+0x2b>
 241:	eb 25                	jmp    268 <strchr+0x38>
 243:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24a:	00 
 24b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 250:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 254:	83 c0 01             	add    $0x1,%eax
 257:	84 d2                	test   %dl,%dl
 259:	74 0d                	je     268 <strchr+0x38>
    if(*s == c)
 25b:	38 d1                	cmp    %dl,%cl
 25d:	75 f1                	jne    250 <strchr+0x20>
      return (char*)s;
  return 0;
}
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret
 261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 268:	31 c0                	xor    %eax,%eax
}
 26a:	5d                   	pop    %ebp
 26b:	c3                   	ret
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <gets>:

char*
gets(char *buf, int max)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 275:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 278:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 279:	31 db                	xor    %ebx,%ebx
{
 27b:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 27e:	eb 27                	jmp    2a7 <gets+0x37>
    cc = read(0, &c, 1);
 280:	83 ec 04             	sub    $0x4,%esp
 283:	6a 01                	push   $0x1
 285:	56                   	push   %esi
 286:	6a 00                	push   $0x0
 288:	e8 45 01 00 00       	call   3d2 <read>
    if(cc < 1)
 28d:	83 c4 10             	add    $0x10,%esp
 290:	85 c0                	test   %eax,%eax
 292:	7e 1d                	jle    2b1 <gets+0x41>
      break;
    buf[i++] = c;
 294:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 298:	8b 55 08             	mov    0x8(%ebp),%edx
 29b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 29f:	3c 0a                	cmp    $0xa,%al
 2a1:	74 10                	je     2b3 <gets+0x43>
 2a3:	3c 0d                	cmp    $0xd,%al
 2a5:	74 0c                	je     2b3 <gets+0x43>
  for(i = 0; i+1 < max; ){
 2a7:	89 df                	mov    %ebx,%edi
 2a9:	83 c3 01             	add    $0x1,%ebx
 2ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2af:	7c cf                	jl     280 <gets+0x10>
 2b1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 2ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2bd:	5b                   	pop    %ebx
 2be:	5e                   	pop    %esi
 2bf:	5f                   	pop    %edi
 2c0:	5d                   	pop    %ebp
 2c1:	c3                   	ret
 2c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2c9:	00 
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	6a 00                	push   $0x0
 2da:	ff 75 08             	push   0x8(%ebp)
 2dd:	e8 40 01 00 00       	call   422 <open>
  if(fd < 0)
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 27                	js     310 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	push   0xc(%ebp)
 2ef:	89 c3                	mov    %eax,%ebx
 2f1:	50                   	push   %eax
 2f2:	e8 f3 00 00 00       	call   3ea <fstat>
  close(fd);
 2f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2fa:	89 c6                	mov    %eax,%esi
  close(fd);
 2fc:	e8 51 01 00 00       	call   452 <close>
  return r;
 301:	83 c4 10             	add    $0x10,%esp
}
 304:	8d 65 f8             	lea    -0x8(%ebp),%esp
 307:	89 f0                	mov    %esi,%eax
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret
 30d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb ed                	jmp    304 <stat+0x34>
 317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31e:	00 
 31f:	90                   	nop

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 02             	movsbl (%edx),%eax
 32a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 32d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 330:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 335:	77 1e                	ja     355 <atoi+0x35>
 337:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 33e:	00 
 33f:	90                   	nop
    n = n*10 + *s++ - '0';
 340:	83 c2 01             	add    $0x1,%edx
 343:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 346:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 34a:	0f be 02             	movsbl (%edx),%eax
 34d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 358:	89 c8                	mov    %ecx,%eax
 35a:	c9                   	leave
 35b:	c3                   	ret
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	8b 55 08             	mov    0x8(%ebp),%edx
 367:	8b 45 10             	mov    0x10(%ebp),%eax
 36a:	56                   	push   %esi
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 36e:	39 f2                	cmp    %esi,%edx
 370:	73 1e                	jae    390 <memmove+0x30>
    while(n-- > 0)
 372:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 375:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 377:	85 c0                	test   %eax,%eax
 379:	7e 0a                	jle    385 <memmove+0x25>
 37b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 380:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 381:	39 f9                	cmp    %edi,%ecx
 383:	75 fb                	jne    380 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 385:	5e                   	pop    %esi
 386:	89 d0                	mov    %edx,%eax
 388:	5f                   	pop    %edi
 389:	5d                   	pop    %ebp
 38a:	c3                   	ret
 38b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 390:	85 c0                	test   %eax,%eax
 392:	7e f1                	jle    385 <memmove+0x25>
    while(n-- > 0)
 394:	83 e8 01             	sub    $0x1,%eax
 397:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 39e:	00 
 39f:	90                   	nop
      *--dst = *--src;
 3a0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 3a4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 3a7:	83 e8 01             	sub    $0x1,%eax
 3aa:	73 f4                	jae    3a0 <memmove+0x40>
}
 3ac:	5e                   	pop    %esi
 3ad:	89 d0                	mov    %edx,%eax
 3af:	5f                   	pop    %edi
 3b0:	5d                   	pop    %ebp
 3b1:	c3                   	ret

000003b2 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 3b2:	b8 01 00 00 00       	mov    $0x1,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret

000003ba <exit>:
SYSCALL(exit)
 3ba:	b8 02 00 00 00       	mov    $0x2,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret

000003c2 <wait>:
SYSCALL(wait)
 3c2:	b8 03 00 00 00       	mov    $0x3,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret

000003ca <pipe>:
SYSCALL(pipe)
 3ca:	b8 04 00 00 00       	mov    $0x4,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret

000003d2 <read>:
SYSCALL(read)
 3d2:	b8 05 00 00 00       	mov    $0x5,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret

000003da <kill>:
SYSCALL(kill)
 3da:	b8 06 00 00 00       	mov    $0x6,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret

000003e2 <exec>:
SYSCALL(exec)
 3e2:	b8 07 00 00 00       	mov    $0x7,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret

000003ea <fstat>:
SYSCALL(fstat)
 3ea:	b8 08 00 00 00       	mov    $0x8,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret

000003f2 <chdir>:
SYSCALL(chdir)
 3f2:	b8 09 00 00 00       	mov    $0x9,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret

000003fa <dup>:
SYSCALL(dup)
 3fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret

00000402 <getpid>:
SYSCALL(getpid)
 402:	b8 0b 00 00 00       	mov    $0xb,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret

0000040a <sbrk>:
SYSCALL(sbrk)
 40a:	b8 0c 00 00 00       	mov    $0xc,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret

00000412 <sleep>:
SYSCALL(sleep)
 412:	b8 0d 00 00 00       	mov    $0xd,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret

0000041a <uptime>:
SYSCALL(uptime)
 41a:	b8 0e 00 00 00       	mov    $0xe,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret

00000422 <open>:
SYSCALL(open)
 422:	b8 0f 00 00 00       	mov    $0xf,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret

0000042a <write>:
SYSCALL(write)
 42a:	b8 10 00 00 00       	mov    $0x10,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret

00000432 <mknod>:
SYSCALL(mknod)
 432:	b8 11 00 00 00       	mov    $0x11,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret

0000043a <unlink>:
SYSCALL(unlink)
 43a:	b8 12 00 00 00       	mov    $0x12,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret

00000442 <link>:
SYSCALL(link)
 442:	b8 13 00 00 00       	mov    $0x13,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret

0000044a <mkdir>:
SYSCALL(mkdir)
 44a:	b8 14 00 00 00       	mov    $0x14,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret

00000452 <close>:
SYSCALL(close)
 452:	b8 15 00 00 00       	mov    $0x15,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret

0000045a <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 45a:	b8 16 00 00 00       	mov    $0x16,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret

00000462 <settickets>:
SYSCALL(settickets)
 462:	b8 17 00 00 00       	mov    $0x17,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret

0000046a <getpinfo>:
SYSCALL(getpinfo)
 46a:	b8 18 00 00 00       	mov    $0x18,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret

00000472 <waitx>:
SYSCALL(waitx)
 472:	b8 19 00 00 00       	mov    $0x19,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret

0000047a <yield>:
SYSCALL(yield)
 47a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret
 482:	66 90                	xchg   %ax,%ax
 484:	66 90                	xchg   %ax,%ax
 486:	66 90                	xchg   %ax,%ax
 488:	66 90                	xchg   %ax,%ax
 48a:	66 90                	xchg   %ax,%ax
 48c:	66 90                	xchg   %ax,%ax
 48e:	66 90                	xchg   %ax,%ax
 490:	66 90                	xchg   %ax,%ax
 492:	66 90                	xchg   %ax,%ax
 494:	66 90                	xchg   %ax,%ax
 496:	66 90                	xchg   %ax,%ax
 498:	66 90                	xchg   %ax,%ax
 49a:	66 90                	xchg   %ax,%ax
 49c:	66 90                	xchg   %ax,%ax
 49e:	66 90                	xchg   %ax,%ax

000004a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4a8:	89 d1                	mov    %edx,%ecx
{
 4aa:	83 ec 3c             	sub    $0x3c,%esp
 4ad:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 4b0:	85 d2                	test   %edx,%edx
 4b2:	0f 89 98 00 00 00    	jns    550 <printint+0xb0>
 4b8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4bc:	0f 84 8e 00 00 00    	je     550 <printint+0xb0>
    x = -xx;
 4c2:	f7 d9                	neg    %ecx
    neg = 1;
 4c4:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 4c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4cc:	31 f6                	xor    %esi,%esi
 4ce:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4d5:	00 
 4d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4dd:	00 
 4de:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 4e0:	89 c8                	mov    %ecx,%eax
 4e2:	31 d2                	xor    %edx,%edx
 4e4:	89 f7                	mov    %esi,%edi
 4e6:	f7 f3                	div    %ebx
 4e8:	8d 76 01             	lea    0x1(%esi),%esi
 4eb:	0f b6 92 4c 09 00 00 	movzbl 0x94c(%edx),%edx
 4f2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4f6:	89 ca                	mov    %ecx,%edx
 4f8:	89 c1                	mov    %eax,%ecx
 4fa:	39 da                	cmp    %ebx,%edx
 4fc:	73 e2                	jae    4e0 <printint+0x40>
  if(neg)
 4fe:	8b 45 c0             	mov    -0x40(%ebp),%eax
 501:	85 c0                	test   %eax,%eax
 503:	74 07                	je     50c <printint+0x6c>
    buf[i++] = '-';
 505:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 50a:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 50c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 50f:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 512:	01 df                	add    %ebx,%edi
 514:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51b:	00 
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 520:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 523:	83 ec 04             	sub    $0x4,%esp
 526:	88 45 d7             	mov    %al,-0x29(%ebp)
 529:	8d 45 d7             	lea    -0x29(%ebp),%eax
 52c:	6a 01                	push   $0x1
 52e:	50                   	push   %eax
 52f:	56                   	push   %esi
 530:	e8 f5 fe ff ff       	call   42a <write>
  while(--i >= 0)
 535:	89 f8                	mov    %edi,%eax
 537:	83 c4 10             	add    $0x10,%esp
 53a:	83 ef 01             	sub    $0x1,%edi
 53d:	39 d8                	cmp    %ebx,%eax
 53f:	75 df                	jne    520 <printint+0x80>
}
 541:	8d 65 f4             	lea    -0xc(%ebp),%esp
 544:	5b                   	pop    %ebx
 545:	5e                   	pop    %esi
 546:	5f                   	pop    %edi
 547:	5d                   	pop    %ebp
 548:	c3                   	ret
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 550:	31 c0                	xor    %eax,%eax
 552:	e9 72 ff ff ff       	jmp    4c9 <printint+0x29>
 557:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55e:	00 
 55f:	90                   	nop

00000560 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 569:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 56c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 56f:	0f b6 13             	movzbl (%ebx),%edx
 572:	83 c3 01             	add    $0x1,%ebx
 575:	84 d2                	test   %dl,%dl
 577:	0f 84 a0 00 00 00    	je     61d <printf+0xbd>
 57d:	8d 45 10             	lea    0x10(%ebp),%eax
 580:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 583:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 586:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 589:	eb 28                	jmp    5b3 <printf+0x53>
 58b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 590:	83 ec 04             	sub    $0x4,%esp
 593:	8d 45 e7             	lea    -0x19(%ebp),%eax
 596:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 599:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 59c:	6a 01                	push   $0x1
 59e:	50                   	push   %eax
 59f:	56                   	push   %esi
 5a0:	e8 85 fe ff ff       	call   42a <write>
  for(i = 0; fmt[i]; i++){
 5a5:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5a9:	83 c4 10             	add    $0x10,%esp
 5ac:	84 d2                	test   %dl,%dl
 5ae:	74 6d                	je     61d <printf+0xbd>
    c = fmt[i] & 0xff;
 5b0:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 5b3:	83 f8 25             	cmp    $0x25,%eax
 5b6:	75 d8                	jne    590 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 5b8:	0f b6 13             	movzbl (%ebx),%edx
 5bb:	84 d2                	test   %dl,%dl
 5bd:	74 5e                	je     61d <printf+0xbd>
    c = fmt[i] & 0xff;
 5bf:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 5c2:	80 fa 25             	cmp    $0x25,%dl
 5c5:	0f 84 1d 01 00 00    	je     6e8 <printf+0x188>
 5cb:	83 e8 63             	sub    $0x63,%eax
 5ce:	83 f8 15             	cmp    $0x15,%eax
 5d1:	77 0d                	ja     5e0 <printf+0x80>
 5d3:	ff 24 85 f4 08 00 00 	jmp    *0x8f4(,%eax,4)
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5e6:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 5ed:	6a 01                	push   $0x1
 5ef:	51                   	push   %ecx
 5f0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 5f3:	56                   	push   %esi
 5f4:	e8 31 fe ff ff       	call   42a <write>
        putc(fd, c);
 5f9:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 5fd:	83 c4 0c             	add    $0xc,%esp
 600:	88 55 e7             	mov    %dl,-0x19(%ebp)
 603:	6a 01                	push   $0x1
 605:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 608:	51                   	push   %ecx
 609:	56                   	push   %esi
 60a:	e8 1b fe ff ff       	call   42a <write>
  for(i = 0; fmt[i]; i++){
 60f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 613:	83 c3 02             	add    $0x2,%ebx
 616:	83 c4 10             	add    $0x10,%esp
 619:	84 d2                	test   %dl,%dl
 61b:	75 93                	jne    5b0 <printf+0x50>
      }
      state = 0;
    }
  }
}
 61d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 620:	5b                   	pop    %ebx
 621:	5e                   	pop    %esi
 622:	5f                   	pop    %edi
 623:	5d                   	pop    %ebp
 624:	c3                   	ret
 625:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 628:	83 ec 0c             	sub    $0xc,%esp
 62b:	8b 17                	mov    (%edi),%edx
 62d:	b9 10 00 00 00       	mov    $0x10,%ecx
 632:	89 f0                	mov    %esi,%eax
 634:	6a 00                	push   $0x0
        ap++;
 636:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 639:	e8 62 fe ff ff       	call   4a0 <printint>
  for(i = 0; fmt[i]; i++){
 63e:	eb cf                	jmp    60f <printf+0xaf>
        s = (char*)*ap;
 640:	8b 07                	mov    (%edi),%eax
        ap++;
 642:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 645:	85 c0                	test   %eax,%eax
 647:	0f 84 b3 00 00 00    	je     700 <printf+0x1a0>
        while(*s != 0){
 64d:	0f b6 10             	movzbl (%eax),%edx
 650:	84 d2                	test   %dl,%dl
 652:	0f 84 ba 00 00 00    	je     712 <printf+0x1b2>
 658:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 65b:	89 c7                	mov    %eax,%edi
 65d:	89 d0                	mov    %edx,%eax
 65f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 662:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 665:	89 fb                	mov    %edi,%ebx
 667:	89 cf                	mov    %ecx,%edi
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 670:	83 ec 04             	sub    $0x4,%esp
 673:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 676:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 679:	6a 01                	push   $0x1
 67b:	57                   	push   %edi
 67c:	56                   	push   %esi
 67d:	e8 a8 fd ff ff       	call   42a <write>
        while(*s != 0){
 682:	0f b6 03             	movzbl (%ebx),%eax
 685:	83 c4 10             	add    $0x10,%esp
 688:	84 c0                	test   %al,%al
 68a:	75 e4                	jne    670 <printf+0x110>
 68c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 68f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 693:	83 c3 02             	add    $0x2,%ebx
 696:	84 d2                	test   %dl,%dl
 698:	0f 85 e5 fe ff ff    	jne    583 <printf+0x23>
 69e:	e9 7a ff ff ff       	jmp    61d <printf+0xbd>
 6a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6a8:	83 ec 0c             	sub    $0xc,%esp
 6ab:	8b 17                	mov    (%edi),%edx
 6ad:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6b2:	89 f0                	mov    %esi,%eax
 6b4:	6a 01                	push   $0x1
        ap++;
 6b6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 6b9:	e8 e2 fd ff ff       	call   4a0 <printint>
  for(i = 0; fmt[i]; i++){
 6be:	e9 4c ff ff ff       	jmp    60f <printf+0xaf>
 6c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 6c8:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 6ca:	83 ec 04             	sub    $0x4,%esp
 6cd:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 6d0:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 6d3:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6d6:	6a 01                	push   $0x1
 6d8:	51                   	push   %ecx
 6d9:	56                   	push   %esi
 6da:	e8 4b fd ff ff       	call   42a <write>
  for(i = 0; fmt[i]; i++){
 6df:	e9 2b ff ff ff       	jmp    60f <printf+0xaf>
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6e8:	83 ec 04             	sub    $0x4,%esp
 6eb:	88 55 e7             	mov    %dl,-0x19(%ebp)
 6ee:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 6f1:	6a 01                	push   $0x1
 6f3:	e9 10 ff ff ff       	jmp    608 <printf+0xa8>
 6f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6ff:	00 
          s = "(null)";
 700:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 703:	b8 28 00 00 00       	mov    $0x28,%eax
 708:	bf eb 08 00 00       	mov    $0x8eb,%edi
 70d:	e9 4d ff ff ff       	jmp    65f <printf+0xff>
  for(i = 0; fmt[i]; i++){
 712:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 716:	83 c3 02             	add    $0x2,%ebx
 719:	84 d2                	test   %dl,%dl
 71b:	0f 85 8f fe ff ff    	jne    5b0 <printf+0x50>
 721:	e9 f7 fe ff ff       	jmp    61d <printf+0xbd>
 726:	66 90                	xchg   %ax,%ax
 728:	66 90                	xchg   %ax,%ax
 72a:	66 90                	xchg   %ax,%ax
 72c:	66 90                	xchg   %ax,%ax
 72e:	66 90                	xchg   %ax,%ax
 730:	66 90                	xchg   %ax,%ax
 732:	66 90                	xchg   %ax,%ax
 734:	66 90                	xchg   %ax,%ax
 736:	66 90                	xchg   %ax,%ax
 738:	66 90                	xchg   %ax,%ax
 73a:	66 90                	xchg   %ax,%ax
 73c:	66 90                	xchg   %ax,%ax
 73e:	66 90                	xchg   %ax,%ax

00000740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 740:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	a1 04 0c 00 00       	mov    0xc04,%eax
{
 746:	89 e5                	mov    %esp,%ebp
 748:	57                   	push   %edi
 749:	56                   	push   %esi
 74a:	53                   	push   %ebx
 74b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 74e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 758:	00 
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 760:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 762:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 764:	39 ca                	cmp    %ecx,%edx
 766:	73 30                	jae    798 <free+0x58>
 768:	39 c1                	cmp    %eax,%ecx
 76a:	72 04                	jb     770 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76c:	39 c2                	cmp    %eax,%edx
 76e:	72 f0                	jb     760 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 770:	8b 73 fc             	mov    -0x4(%ebx),%esi
 773:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 776:	39 f8                	cmp    %edi,%eax
 778:	74 36                	je     7b0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 77a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 77d:	8b 42 04             	mov    0x4(%edx),%eax
 780:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 783:	39 f1                	cmp    %esi,%ecx
 785:	74 40                	je     7c7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 787:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 789:	5b                   	pop    %ebx
  freep = p;
 78a:	89 15 04 0c 00 00    	mov    %edx,0xc04
}
 790:	5e                   	pop    %esi
 791:	5f                   	pop    %edi
 792:	5d                   	pop    %ebp
 793:	c3                   	ret
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 798:	39 c2                	cmp    %eax,%edx
 79a:	72 c4                	jb     760 <free+0x20>
 79c:	39 c1                	cmp    %eax,%ecx
 79e:	73 c0                	jae    760 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 7a0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7a3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7a6:	39 f8                	cmp    %edi,%eax
 7a8:	75 d0                	jne    77a <free+0x3a>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 7b0:	03 70 04             	add    0x4(%eax),%esi
 7b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b6:	8b 02                	mov    (%edx),%eax
 7b8:	8b 00                	mov    (%eax),%eax
 7ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 7bd:	8b 42 04             	mov    0x4(%edx),%eax
 7c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7c3:	39 f1                	cmp    %esi,%ecx
 7c5:	75 c0                	jne    787 <free+0x47>
    p->s.size += bp->s.size;
 7c7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 7ca:	89 15 04 0c 00 00    	mov    %edx,0xc04
    p->s.size += bp->s.size;
 7d0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7d3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7d6:	89 0a                	mov    %ecx,(%edx)
}
 7d8:	5b                   	pop    %ebx
 7d9:	5e                   	pop    %esi
 7da:	5f                   	pop    %edi
 7db:	5d                   	pop    %ebp
 7dc:	c3                   	ret
 7dd:	8d 76 00             	lea    0x0(%esi),%esi

000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ec:	8b 15 04 0c 00 00    	mov    0xc04,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f2:	8d 78 07             	lea    0x7(%eax),%edi
 7f5:	c1 ef 03             	shr    $0x3,%edi
 7f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7fb:	85 d2                	test   %edx,%edx
 7fd:	0f 84 8d 00 00 00    	je     890 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 803:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 805:	8b 48 04             	mov    0x4(%eax),%ecx
 808:	39 f9                	cmp    %edi,%ecx
 80a:	73 64                	jae    870 <malloc+0x90>
  if(nu < 4096)
 80c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 811:	39 df                	cmp    %ebx,%edi
 813:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 816:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 81d:	eb 0a                	jmp    829 <malloc+0x49>
 81f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 820:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 822:	8b 48 04             	mov    0x4(%eax),%ecx
 825:	39 f9                	cmp    %edi,%ecx
 827:	73 47                	jae    870 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 829:	89 c2                	mov    %eax,%edx
 82b:	39 05 04 0c 00 00    	cmp    %eax,0xc04
 831:	75 ed                	jne    820 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 833:	83 ec 0c             	sub    $0xc,%esp
 836:	56                   	push   %esi
 837:	e8 ce fb ff ff       	call   40a <sbrk>
  if(p == (char*)-1)
 83c:	83 c4 10             	add    $0x10,%esp
 83f:	83 f8 ff             	cmp    $0xffffffff,%eax
 842:	74 1c                	je     860 <malloc+0x80>
  hp->s.size = nu;
 844:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 847:	83 ec 0c             	sub    $0xc,%esp
 84a:	83 c0 08             	add    $0x8,%eax
 84d:	50                   	push   %eax
 84e:	e8 ed fe ff ff       	call   740 <free>
  return freep;
 853:	8b 15 04 0c 00 00    	mov    0xc04,%edx
      if((p = morecore(nunits)) == 0)
 859:	83 c4 10             	add    $0x10,%esp
 85c:	85 d2                	test   %edx,%edx
 85e:	75 c0                	jne    820 <malloc+0x40>
        return 0;
  }
}
 860:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 863:	31 c0                	xor    %eax,%eax
}
 865:	5b                   	pop    %ebx
 866:	5e                   	pop    %esi
 867:	5f                   	pop    %edi
 868:	5d                   	pop    %ebp
 869:	c3                   	ret
 86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 870:	39 cf                	cmp    %ecx,%edi
 872:	74 4c                	je     8c0 <malloc+0xe0>
        p->s.size -= nunits;
 874:	29 f9                	sub    %edi,%ecx
 876:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 879:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 87c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 87f:	89 15 04 0c 00 00    	mov    %edx,0xc04
}
 885:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 888:	83 c0 08             	add    $0x8,%eax
}
 88b:	5b                   	pop    %ebx
 88c:	5e                   	pop    %esi
 88d:	5f                   	pop    %edi
 88e:	5d                   	pop    %ebp
 88f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 890:	c7 05 04 0c 00 00 08 	movl   $0xc08,0xc04
 897:	0c 00 00 
    base.s.size = 0;
 89a:	b8 08 0c 00 00       	mov    $0xc08,%eax
    base.s.ptr = freep = prevp = &base;
 89f:	c7 05 08 0c 00 00 08 	movl   $0xc08,0xc08
 8a6:	0c 00 00 
    base.s.size = 0;
 8a9:	c7 05 0c 0c 00 00 00 	movl   $0x0,0xc0c
 8b0:	00 00 00 
    if(p->s.size >= nunits){
 8b3:	e9 54 ff ff ff       	jmp    80c <malloc+0x2c>
 8b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8bf:	00 
        prevp->s.ptr = p->s.ptr;
 8c0:	8b 08                	mov    (%eax),%ecx
 8c2:	89 0a                	mov    %ecx,(%edx)
 8c4:	eb b9                	jmp    87f <malloc+0x9f>
