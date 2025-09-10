
_fcfs_test:     file format elf32-i386


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
  11:	83 ec 44             	sub    $0x44,%esp
  if(setpolicy(1) < 0){ // 1 = FCFS
  14:	6a 01                	push   $0x1
  16:	e8 1f 04 00 00       	call   43a <setpolicy>
  1b:	83 c4 10             	add    $0x10,%esp
  1e:	85 c0                	test   %eax,%eax
  20:	0f 88 9c 00 00 00    	js     c2 <main+0xc2>
  }

  int order[3];
  int idx=0;

  int a = fork();
  26:	e8 67 03 00 00       	call   392 <fork>
  2b:	89 c3                	mov    %eax,%ebx
  if(a == 0){ burn(15); exit(); }
  2d:	85 c0                	test   %eax,%eax
  2f:	75 0a                	jne    3b <main+0x3b>
  31:	e8 aa 00 00 00       	call   e0 <burn.constprop.0>
  36:	e8 5f 03 00 00       	call   39a <exit>

  sleep(10); // تاخیر ایجاد کنیم (B بعد از A بیاد)
  3b:	83 ec 0c             	sub    $0xc,%esp
  3e:	6a 0a                	push   $0xa
  40:	e8 ad 03 00 00       	call   3f2 <sleep>
  int b = fork();
  45:	e8 48 03 00 00       	call   392 <fork>
  if(b == 0){ burn(15); exit(); }
  4a:	83 c4 10             	add    $0x10,%esp
  int b = fork();
  4d:	89 c6                	mov    %eax,%esi
  if(b == 0){ burn(15); exit(); }
  4f:	85 c0                	test   %eax,%eax
  51:	74 de                	je     31 <main+0x31>

  sleep(10); // C بعد از B
  53:	83 ec 0c             	sub    $0xc,%esp
  56:	6a 0a                	push   $0xa
  58:	e8 95 03 00 00       	call   3f2 <sleep>
  int c = fork();
  5d:	e8 30 03 00 00       	call   392 <fork>
  if(c == 0){ burn(15); exit(); }
  62:	83 c4 10             	add    $0x10,%esp
  65:	85 c0                	test   %eax,%eax
  67:	74 c8                	je     31 <main+0x31>
  int idx=0;
  69:	31 ff                	xor    %edi,%edi
  6b:	89 5d c4             	mov    %ebx,-0x3c(%ebp)
  6e:	89 fb                	mov    %edi,%ebx
  70:	89 c7                	mov    %eax,%edi

  for(int i=0;i<3;i++){
    int w=0,r=0;
  72:	31 c0                	xor    %eax,%eax
    int p = waitx(&w,&r);
  74:	52                   	push   %edx
    order[idx++] = p;
  75:	83 c3 01             	add    $0x1,%ebx
    int w=0,r=0;
  78:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  7b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int p = waitx(&w,&r);
  7e:	8d 45 d8             	lea    -0x28(%ebp),%eax
  81:	52                   	push   %edx
  82:	50                   	push   %eax
  83:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  86:	50                   	push   %eax
  87:	e8 c6 03 00 00       	call   452 <waitx>
  for(int i=0;i<3;i++){
  8c:	83 c4 10             	add    $0x10,%esp
    order[idx++] = p;
  8f:	89 44 9d d8          	mov    %eax,-0x28(%ebp,%ebx,4)
  for(int i=0;i<3;i++){
  93:	83 fb 03             	cmp    $0x3,%ebx
  96:	75 da                	jne    72 <main+0x72>
  }

  printf(1, "FCFS completion order: %d -> %d -> %d (expected: A:%d, B:%d, C:%d)\n",
  98:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  9b:	57                   	push   %edi
  9c:	56                   	push   %esi
  9d:	53                   	push   %ebx
  9e:	ff 75 e4             	push   -0x1c(%ebp)
  a1:	ff 75 e0             	push   -0x20(%ebp)
  a4:	ff 75 dc             	push   -0x24(%ebp)
  a7:	68 c8 08 00 00       	push   $0x8c8
  ac:	6a 01                	push   $0x1
  ae:	e8 8d 04 00 00       	call   540 <printf>
         order[0], order[1], order[2], a,b,c);

  // بازگشت به RR
  setpolicy(0);
  b3:	83 c4 14             	add    $0x14,%esp
  b6:	6a 00                	push   $0x0
  b8:	e8 7d 03 00 00       	call   43a <setpolicy>
  exit();
  bd:	e8 d8 02 00 00       	call   39a <exit>
    printf(1, "fcfs: setpolicy failed\n");
  c2:	51                   	push   %ecx
  c3:	51                   	push   %ecx
  c4:	68 a8 08 00 00       	push   $0x8a8
  c9:	6a 01                	push   $0x1
  cb:	e8 70 04 00 00       	call   540 <printf>
    exit();
  d0:	e8 c5 02 00 00       	call   39a <exit>
  d5:	66 90                	xchg   %ax,%ax
  d7:	66 90                	xchg   %ax,%ax
  d9:	66 90                	xchg   %ax,%ax
  db:	66 90                	xchg   %ax,%ax
  dd:	66 90                	xchg   %ax,%ax
  df:	90                   	nop

000000e0 <burn.constprop.0>:
static void burn(int ms)
  e0:	55                   	push   %ebp
  volatile int z=0;
  e1:	b9 0f 00 00 00       	mov    $0xf,%ecx
static void burn(int ms)
  e6:	89 e5                	mov    %esp,%ebp
  e8:	83 ec 10             	sub    $0x10,%esp
  volatile int z=0;
  eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(int i=0;i<1000000;i++) z += i;
  f2:	31 c0                	xor    %eax,%eax
  f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fb:	00 
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 100:	8b 55 fc             	mov    -0x4(%ebp),%edx
 103:	01 c2                	add    %eax,%edx
 105:	83 c0 01             	add    $0x1,%eax
 108:	89 55 fc             	mov    %edx,-0x4(%ebp)
 10b:	3d 40 42 0f 00       	cmp    $0xf4240,%eax
 110:	75 ee                	jne    100 <burn.constprop.0+0x20>
  for(int t=0;t<ms;t++){
 112:	83 e9 01             	sub    $0x1,%ecx
 115:	75 db                	jne    f2 <burn.constprop.0+0x12>
}
 117:	c9                   	leave
 118:	c3                   	ret
 119:	66 90                	xchg   %ax,%ax
 11b:	66 90                	xchg   %ax,%ax
 11d:	66 90                	xchg   %ax,%ax
 11f:	90                   	nop

00000120 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 120:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
 121:	31 c0                	xor    %eax,%eax
{
 123:	89 e5                	mov    %esp,%ebp
 125:	53                   	push   %ebx
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
 130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 137:	83 c0 01             	add    $0x1,%eax
 13a:	84 d2                	test   %dl,%dl
 13c:	75 f2                	jne    130 <strcpy+0x10>
  return os;
}
 13e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 141:	89 c8                	mov    %ecx,%eax
 143:	c9                   	leave
 144:	c3                   	ret
 145:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14c:	00 
 14d:	8d 76 00             	lea    0x0(%esi),%esi

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 55 08             	mov    0x8(%ebp),%edx
 157:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 15a:	0f b6 02             	movzbl (%edx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	75 2f                	jne    190 <strcmp+0x40>
 161:	eb 4a                	jmp    1ad <strcmp+0x5d>
 163:	eb 1b                	jmp    180 <strcmp+0x30>
 165:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16c:	00 
 16d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 174:	00 
 175:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17c:	00 
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 184:	83 c2 01             	add    $0x1,%edx
 187:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 18a:	84 c0                	test   %al,%al
 18c:	74 12                	je     1a0 <strcmp+0x50>
 18e:	89 d9                	mov    %ebx,%ecx
 190:	0f b6 19             	movzbl (%ecx),%ebx
 193:	38 c3                	cmp    %al,%bl
 195:	74 e9                	je     180 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 197:	29 d8                	sub    %ebx,%eax
}
 199:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 19c:	c9                   	leave
 19d:	c3                   	ret
 19e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 1a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1a4:	31 c0                	xor    %eax,%eax
 1a6:	29 d8                	sub    %ebx,%eax
}
 1a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1ab:	c9                   	leave
 1ac:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1ad:	0f b6 19             	movzbl (%ecx),%ebx
 1b0:	31 c0                	xor    %eax,%eax
 1b2:	eb e3                	jmp    197 <strcmp+0x47>
 1b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1bb:	00 
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 1c6:	80 3a 00             	cmpb   $0x0,(%edx)
 1c9:	74 15                	je     1e0 <strlen+0x20>
 1cb:	31 c0                	xor    %eax,%eax
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	83 c0 01             	add    $0x1,%eax
 1d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1d7:	89 c1                	mov    %eax,%ecx
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
  return n;
}
 1db:	89 c8                	mov    %ecx,%eax
 1dd:	5d                   	pop    %ebp
 1de:	c3                   	ret
 1df:	90                   	nop
  for(n = 0; s[n]; n++);
 1e0:	31 c9                	xor    %ecx,%ecx
}
 1e2:	5d                   	pop    %ebp
 1e3:	89 c8                	mov    %ecx,%eax
 1e5:	c3                   	ret
 1e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ed:	00 
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	8b 7d fc             	mov    -0x4(%ebp),%edi
 205:	89 d0                	mov    %edx,%eax
 207:	c9                   	leave
 208:	c3                   	ret
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 21a:	0f b6 10             	movzbl (%eax),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	75 1a                	jne    23b <strchr+0x2b>
 221:	eb 25                	jmp    248 <strchr+0x38>
 223:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22a:	00 
 22b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 230:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 234:	83 c0 01             	add    $0x1,%eax
 237:	84 d2                	test   %dl,%dl
 239:	74 0d                	je     248 <strchr+0x38>
    if(*s == c)
 23b:	38 d1                	cmp    %dl,%cl
 23d:	75 f1                	jne    230 <strchr+0x20>
      return (char*)s;
  return 0;
}
 23f:	5d                   	pop    %ebp
 240:	c3                   	ret
 241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 248:	31 c0                	xor    %eax,%eax
}
 24a:	5d                   	pop    %ebp
 24b:	c3                   	ret
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 255:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 258:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 259:	31 db                	xor    %ebx,%ebx
{
 25b:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 25e:	eb 27                	jmp    287 <gets+0x37>
    cc = read(0, &c, 1);
 260:	83 ec 04             	sub    $0x4,%esp
 263:	6a 01                	push   $0x1
 265:	56                   	push   %esi
 266:	6a 00                	push   $0x0
 268:	e8 45 01 00 00       	call   3b2 <read>
    if(cc < 1)
 26d:	83 c4 10             	add    $0x10,%esp
 270:	85 c0                	test   %eax,%eax
 272:	7e 1d                	jle    291 <gets+0x41>
      break;
    buf[i++] = c;
 274:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 278:	8b 55 08             	mov    0x8(%ebp),%edx
 27b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 27f:	3c 0a                	cmp    $0xa,%al
 281:	74 10                	je     293 <gets+0x43>
 283:	3c 0d                	cmp    $0xd,%al
 285:	74 0c                	je     293 <gets+0x43>
  for(i = 0; i+1 < max; ){
 287:	89 df                	mov    %ebx,%edi
 289:	83 c3 01             	add    $0x1,%ebx
 28c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 28f:	7c cf                	jl     260 <gets+0x10>
 291:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 29a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 29d:	5b                   	pop    %ebx
 29e:	5e                   	pop    %esi
 29f:	5f                   	pop    %edi
 2a0:	5d                   	pop    %ebp
 2a1:	c3                   	ret
 2a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2a9:	00 
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 2b5:	83 ec 08             	sub    $0x8,%esp
 2b8:	6a 00                	push   $0x0
 2ba:	ff 75 08             	push   0x8(%ebp)
 2bd:	e8 40 01 00 00       	call   402 <open>
  if(fd < 0)
 2c2:	83 c4 10             	add    $0x10,%esp
 2c5:	85 c0                	test   %eax,%eax
 2c7:	78 27                	js     2f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2c9:	83 ec 08             	sub    $0x8,%esp
 2cc:	ff 75 0c             	push   0xc(%ebp)
 2cf:	89 c3                	mov    %eax,%ebx
 2d1:	50                   	push   %eax
 2d2:	e8 f3 00 00 00       	call   3ca <fstat>
  close(fd);
 2d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2da:	89 c6                	mov    %eax,%esi
  close(fd);
 2dc:	e8 51 01 00 00       	call   432 <close>
  return r;
 2e1:	83 c4 10             	add    $0x10,%esp
}
 2e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2e7:	89 f0                	mov    %esi,%eax
 2e9:	5b                   	pop    %ebx
 2ea:	5e                   	pop    %esi
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2f5:	eb ed                	jmp    2e4 <stat+0x34>
 2f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2fe:	00 
 2ff:	90                   	nop

00000300 <atoi>:

int
atoi(const char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	53                   	push   %ebx
 304:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 307:	0f be 02             	movsbl (%edx),%eax
 30a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 30d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 310:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 315:	77 1e                	ja     335 <atoi+0x35>
 317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31e:	00 
 31f:	90                   	nop
    n = n*10 + *s++ - '0';
 320:	83 c2 01             	add    $0x1,%edx
 323:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 326:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 32a:	0f be 02             	movsbl (%edx),%eax
 32d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 330:	80 fb 09             	cmp    $0x9,%bl
 333:	76 eb                	jbe    320 <atoi+0x20>
  return n;
}
 335:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 338:	89 c8                	mov    %ecx,%eax
 33a:	c9                   	leave
 33b:	c3                   	ret
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	8b 55 08             	mov    0x8(%ebp),%edx
 347:	8b 45 10             	mov    0x10(%ebp),%eax
 34a:	56                   	push   %esi
 34b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 34e:	39 f2                	cmp    %esi,%edx
 350:	73 1e                	jae    370 <memmove+0x30>
    while(n-- > 0)
 352:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 355:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 357:	85 c0                	test   %eax,%eax
 359:	7e 0a                	jle    365 <memmove+0x25>
 35b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 360:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 361:	39 f9                	cmp    %edi,%ecx
 363:	75 fb                	jne    360 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 365:	5e                   	pop    %esi
 366:	89 d0                	mov    %edx,%eax
 368:	5f                   	pop    %edi
 369:	5d                   	pop    %ebp
 36a:	c3                   	ret
 36b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 370:	85 c0                	test   %eax,%eax
 372:	7e f1                	jle    365 <memmove+0x25>
    while(n-- > 0)
 374:	83 e8 01             	sub    $0x1,%eax
 377:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 37e:	00 
 37f:	90                   	nop
      *--dst = *--src;
 380:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 384:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 387:	83 e8 01             	sub    $0x1,%eax
 38a:	73 f4                	jae    380 <memmove+0x40>
}
 38c:	5e                   	pop    %esi
 38d:	89 d0                	mov    %edx,%eax
 38f:	5f                   	pop    %edi
 390:	5d                   	pop    %ebp
 391:	c3                   	ret

00000392 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 392:	b8 01 00 00 00       	mov    $0x1,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret

0000039a <exit>:
SYSCALL(exit)
 39a:	b8 02 00 00 00       	mov    $0x2,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret

000003a2 <wait>:
SYSCALL(wait)
 3a2:	b8 03 00 00 00       	mov    $0x3,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret

000003aa <pipe>:
SYSCALL(pipe)
 3aa:	b8 04 00 00 00       	mov    $0x4,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret

000003b2 <read>:
SYSCALL(read)
 3b2:	b8 05 00 00 00       	mov    $0x5,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret

000003ba <kill>:
SYSCALL(kill)
 3ba:	b8 06 00 00 00       	mov    $0x6,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret

000003c2 <exec>:
SYSCALL(exec)
 3c2:	b8 07 00 00 00       	mov    $0x7,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret

000003ca <fstat>:
SYSCALL(fstat)
 3ca:	b8 08 00 00 00       	mov    $0x8,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret

000003d2 <chdir>:
SYSCALL(chdir)
 3d2:	b8 09 00 00 00       	mov    $0x9,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret

000003da <dup>:
SYSCALL(dup)
 3da:	b8 0a 00 00 00       	mov    $0xa,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret

000003e2 <getpid>:
SYSCALL(getpid)
 3e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret

000003ea <sbrk>:
SYSCALL(sbrk)
 3ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret

000003f2 <sleep>:
SYSCALL(sleep)
 3f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret

000003fa <uptime>:
SYSCALL(uptime)
 3fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret

00000402 <open>:
SYSCALL(open)
 402:	b8 0f 00 00 00       	mov    $0xf,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret

0000040a <write>:
SYSCALL(write)
 40a:	b8 10 00 00 00       	mov    $0x10,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret

00000412 <mknod>:
SYSCALL(mknod)
 412:	b8 11 00 00 00       	mov    $0x11,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret

0000041a <unlink>:
SYSCALL(unlink)
 41a:	b8 12 00 00 00       	mov    $0x12,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret

00000422 <link>:
SYSCALL(link)
 422:	b8 13 00 00 00       	mov    $0x13,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret

0000042a <mkdir>:
SYSCALL(mkdir)
 42a:	b8 14 00 00 00       	mov    $0x14,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret

00000432 <close>:
SYSCALL(close)
 432:	b8 15 00 00 00       	mov    $0x15,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret

0000043a <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 43a:	b8 16 00 00 00       	mov    $0x16,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret

00000442 <settickets>:
SYSCALL(settickets)
 442:	b8 17 00 00 00       	mov    $0x17,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret

0000044a <getpinfo>:
SYSCALL(getpinfo)
 44a:	b8 18 00 00 00       	mov    $0x18,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret

00000452 <waitx>:
SYSCALL(waitx)
 452:	b8 19 00 00 00       	mov    $0x19,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret

0000045a <yield>:
SYSCALL(yield)
 45a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret
 462:	66 90                	xchg   %ax,%ax
 464:	66 90                	xchg   %ax,%ax
 466:	66 90                	xchg   %ax,%ax
 468:	66 90                	xchg   %ax,%ax
 46a:	66 90                	xchg   %ax,%ax
 46c:	66 90                	xchg   %ax,%ax
 46e:	66 90                	xchg   %ax,%ax
 470:	66 90                	xchg   %ax,%ax
 472:	66 90                	xchg   %ax,%ax
 474:	66 90                	xchg   %ax,%ax
 476:	66 90                	xchg   %ax,%ax
 478:	66 90                	xchg   %ax,%ax
 47a:	66 90                	xchg   %ax,%ax
 47c:	66 90                	xchg   %ax,%ax
 47e:	66 90                	xchg   %ax,%ax

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 488:	89 d1                	mov    %edx,%ecx
{
 48a:	83 ec 3c             	sub    $0x3c,%esp
 48d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 490:	85 d2                	test   %edx,%edx
 492:	0f 89 98 00 00 00    	jns    530 <printint+0xb0>
 498:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 49c:	0f 84 8e 00 00 00    	je     530 <printint+0xb0>
    x = -xx;
 4a2:	f7 d9                	neg    %ecx
    neg = 1;
 4a4:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 4a9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4ac:	31 f6                	xor    %esi,%esi
 4ae:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4b5:	00 
 4b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4bd:	00 
 4be:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 4c0:	89 c8                	mov    %ecx,%eax
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	89 f7                	mov    %esi,%edi
 4c6:	f7 f3                	div    %ebx
 4c8:	8d 76 01             	lea    0x1(%esi),%esi
 4cb:	0f b6 92 64 09 00 00 	movzbl 0x964(%edx),%edx
 4d2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4d6:	89 ca                	mov    %ecx,%edx
 4d8:	89 c1                	mov    %eax,%ecx
 4da:	39 da                	cmp    %ebx,%edx
 4dc:	73 e2                	jae    4c0 <printint+0x40>
  if(neg)
 4de:	8b 45 c0             	mov    -0x40(%ebp),%eax
 4e1:	85 c0                	test   %eax,%eax
 4e3:	74 07                	je     4ec <printint+0x6c>
    buf[i++] = '-';
 4e5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 4ea:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 4ec:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4ef:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 4f2:	01 df                	add    %ebx,%edi
 4f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4fb:	00 
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 500:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 503:	83 ec 04             	sub    $0x4,%esp
 506:	88 45 d7             	mov    %al,-0x29(%ebp)
 509:	8d 45 d7             	lea    -0x29(%ebp),%eax
 50c:	6a 01                	push   $0x1
 50e:	50                   	push   %eax
 50f:	56                   	push   %esi
 510:	e8 f5 fe ff ff       	call   40a <write>
  while(--i >= 0)
 515:	89 f8                	mov    %edi,%eax
 517:	83 c4 10             	add    $0x10,%esp
 51a:	83 ef 01             	sub    $0x1,%edi
 51d:	39 d8                	cmp    %ebx,%eax
 51f:	75 df                	jne    500 <printint+0x80>
}
 521:	8d 65 f4             	lea    -0xc(%ebp),%esp
 524:	5b                   	pop    %ebx
 525:	5e                   	pop    %esi
 526:	5f                   	pop    %edi
 527:	5d                   	pop    %ebp
 528:	c3                   	ret
 529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 530:	31 c0                	xor    %eax,%eax
 532:	e9 72 ff ff ff       	jmp    4a9 <printint+0x29>
 537:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53e:	00 
 53f:	90                   	nop

00000540 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
 546:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 549:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 54c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 54f:	0f b6 13             	movzbl (%ebx),%edx
 552:	83 c3 01             	add    $0x1,%ebx
 555:	84 d2                	test   %dl,%dl
 557:	0f 84 a0 00 00 00    	je     5fd <printf+0xbd>
 55d:	8d 45 10             	lea    0x10(%ebp),%eax
 560:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 563:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 566:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 569:	eb 28                	jmp    593 <printf+0x53>
 56b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 570:	83 ec 04             	sub    $0x4,%esp
 573:	8d 45 e7             	lea    -0x19(%ebp),%eax
 576:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 579:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 57c:	6a 01                	push   $0x1
 57e:	50                   	push   %eax
 57f:	56                   	push   %esi
 580:	e8 85 fe ff ff       	call   40a <write>
  for(i = 0; fmt[i]; i++){
 585:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 589:	83 c4 10             	add    $0x10,%esp
 58c:	84 d2                	test   %dl,%dl
 58e:	74 6d                	je     5fd <printf+0xbd>
    c = fmt[i] & 0xff;
 590:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 593:	83 f8 25             	cmp    $0x25,%eax
 596:	75 d8                	jne    570 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 598:	0f b6 13             	movzbl (%ebx),%edx
 59b:	84 d2                	test   %dl,%dl
 59d:	74 5e                	je     5fd <printf+0xbd>
    c = fmt[i] & 0xff;
 59f:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 5a2:	80 fa 25             	cmp    $0x25,%dl
 5a5:	0f 84 1d 01 00 00    	je     6c8 <printf+0x188>
 5ab:	83 e8 63             	sub    $0x63,%eax
 5ae:	83 f8 15             	cmp    $0x15,%eax
 5b1:	77 0d                	ja     5c0 <printf+0x80>
 5b3:	ff 24 85 0c 09 00 00 	jmp    *0x90c(,%eax,4)
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5c6:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5c9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 5cd:	6a 01                	push   $0x1
 5cf:	51                   	push   %ecx
 5d0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 5d3:	56                   	push   %esi
 5d4:	e8 31 fe ff ff       	call   40a <write>
        putc(fd, c);
 5d9:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 5dd:	83 c4 0c             	add    $0xc,%esp
 5e0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5e3:	6a 01                	push   $0x1
 5e5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 5e8:	51                   	push   %ecx
 5e9:	56                   	push   %esi
 5ea:	e8 1b fe ff ff       	call   40a <write>
  for(i = 0; fmt[i]; i++){
 5ef:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5f3:	83 c3 02             	add    $0x2,%ebx
 5f6:	83 c4 10             	add    $0x10,%esp
 5f9:	84 d2                	test   %dl,%dl
 5fb:	75 93                	jne    590 <printf+0x50>
      }
      state = 0;
    }
  }
}
 5fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 600:	5b                   	pop    %ebx
 601:	5e                   	pop    %esi
 602:	5f                   	pop    %edi
 603:	5d                   	pop    %ebp
 604:	c3                   	ret
 605:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 608:	83 ec 0c             	sub    $0xc,%esp
 60b:	8b 17                	mov    (%edi),%edx
 60d:	b9 10 00 00 00       	mov    $0x10,%ecx
 612:	89 f0                	mov    %esi,%eax
 614:	6a 00                	push   $0x0
        ap++;
 616:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 619:	e8 62 fe ff ff       	call   480 <printint>
  for(i = 0; fmt[i]; i++){
 61e:	eb cf                	jmp    5ef <printf+0xaf>
        s = (char*)*ap;
 620:	8b 07                	mov    (%edi),%eax
        ap++;
 622:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 625:	85 c0                	test   %eax,%eax
 627:	0f 84 b3 00 00 00    	je     6e0 <printf+0x1a0>
        while(*s != 0){
 62d:	0f b6 10             	movzbl (%eax),%edx
 630:	84 d2                	test   %dl,%dl
 632:	0f 84 ba 00 00 00    	je     6f2 <printf+0x1b2>
 638:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 63b:	89 c7                	mov    %eax,%edi
 63d:	89 d0                	mov    %edx,%eax
 63f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 642:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 645:	89 fb                	mov    %edi,%ebx
 647:	89 cf                	mov    %ecx,%edi
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 650:	83 ec 04             	sub    $0x4,%esp
 653:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 656:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 659:	6a 01                	push   $0x1
 65b:	57                   	push   %edi
 65c:	56                   	push   %esi
 65d:	e8 a8 fd ff ff       	call   40a <write>
        while(*s != 0){
 662:	0f b6 03             	movzbl (%ebx),%eax
 665:	83 c4 10             	add    $0x10,%esp
 668:	84 c0                	test   %al,%al
 66a:	75 e4                	jne    650 <printf+0x110>
 66c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 66f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 673:	83 c3 02             	add    $0x2,%ebx
 676:	84 d2                	test   %dl,%dl
 678:	0f 85 e5 fe ff ff    	jne    563 <printf+0x23>
 67e:	e9 7a ff ff ff       	jmp    5fd <printf+0xbd>
 683:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 688:	83 ec 0c             	sub    $0xc,%esp
 68b:	8b 17                	mov    (%edi),%edx
 68d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 692:	89 f0                	mov    %esi,%eax
 694:	6a 01                	push   $0x1
        ap++;
 696:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 699:	e8 e2 fd ff ff       	call   480 <printint>
  for(i = 0; fmt[i]; i++){
 69e:	e9 4c ff ff ff       	jmp    5ef <printf+0xaf>
 6a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 6a8:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 6aa:	83 ec 04             	sub    $0x4,%esp
 6ad:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 6b0:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 6b3:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6b6:	6a 01                	push   $0x1
 6b8:	51                   	push   %ecx
 6b9:	56                   	push   %esi
 6ba:	e8 4b fd ff ff       	call   40a <write>
  for(i = 0; fmt[i]; i++){
 6bf:	e9 2b ff ff ff       	jmp    5ef <printf+0xaf>
 6c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6c8:	83 ec 04             	sub    $0x4,%esp
 6cb:	88 55 e7             	mov    %dl,-0x19(%ebp)
 6ce:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 6d1:	6a 01                	push   $0x1
 6d3:	e9 10 ff ff ff       	jmp    5e8 <printf+0xa8>
 6d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6df:	00 
          s = "(null)";
 6e0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 6e3:	b8 28 00 00 00       	mov    $0x28,%eax
 6e8:	bf c0 08 00 00       	mov    $0x8c0,%edi
 6ed:	e9 4d ff ff ff       	jmp    63f <printf+0xff>
  for(i = 0; fmt[i]; i++){
 6f2:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 6f6:	83 c3 02             	add    $0x2,%ebx
 6f9:	84 d2                	test   %dl,%dl
 6fb:	0f 85 8f fe ff ff    	jne    590 <printf+0x50>
 701:	e9 f7 fe ff ff       	jmp    5fd <printf+0xbd>
 706:	66 90                	xchg   %ax,%ax
 708:	66 90                	xchg   %ax,%ax
 70a:	66 90                	xchg   %ax,%ax
 70c:	66 90                	xchg   %ax,%ax
 70e:	66 90                	xchg   %ax,%ax
 710:	66 90                	xchg   %ax,%ax
 712:	66 90                	xchg   %ax,%ax
 714:	66 90                	xchg   %ax,%ax
 716:	66 90                	xchg   %ax,%ax
 718:	66 90                	xchg   %ax,%ax
 71a:	66 90                	xchg   %ax,%ax
 71c:	66 90                	xchg   %ax,%ax
 71e:	66 90                	xchg   %ax,%ax

00000720 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 720:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 721:	a1 38 0c 00 00       	mov    0xc38,%eax
{
 726:	89 e5                	mov    %esp,%ebp
 728:	57                   	push   %edi
 729:	56                   	push   %esi
 72a:	53                   	push   %ebx
 72b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 72e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 738:	00 
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 740:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 742:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 744:	39 ca                	cmp    %ecx,%edx
 746:	73 30                	jae    778 <free+0x58>
 748:	39 c1                	cmp    %eax,%ecx
 74a:	72 04                	jb     750 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74c:	39 c2                	cmp    %eax,%edx
 74e:	72 f0                	jb     740 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 750:	8b 73 fc             	mov    -0x4(%ebx),%esi
 753:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 756:	39 f8                	cmp    %edi,%eax
 758:	74 36                	je     790 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 75a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 75d:	8b 42 04             	mov    0x4(%edx),%eax
 760:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 763:	39 f1                	cmp    %esi,%ecx
 765:	74 40                	je     7a7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 767:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 769:	5b                   	pop    %ebx
  freep = p;
 76a:	89 15 38 0c 00 00    	mov    %edx,0xc38
}
 770:	5e                   	pop    %esi
 771:	5f                   	pop    %edi
 772:	5d                   	pop    %ebp
 773:	c3                   	ret
 774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 778:	39 c2                	cmp    %eax,%edx
 77a:	72 c4                	jb     740 <free+0x20>
 77c:	39 c1                	cmp    %eax,%ecx
 77e:	73 c0                	jae    740 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 780:	8b 73 fc             	mov    -0x4(%ebx),%esi
 783:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 786:	39 f8                	cmp    %edi,%eax
 788:	75 d0                	jne    75a <free+0x3a>
 78a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 790:	03 70 04             	add    0x4(%eax),%esi
 793:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 796:	8b 02                	mov    (%edx),%eax
 798:	8b 00                	mov    (%eax),%eax
 79a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 79d:	8b 42 04             	mov    0x4(%edx),%eax
 7a0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7a3:	39 f1                	cmp    %esi,%ecx
 7a5:	75 c0                	jne    767 <free+0x47>
    p->s.size += bp->s.size;
 7a7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 7aa:	89 15 38 0c 00 00    	mov    %edx,0xc38
    p->s.size += bp->s.size;
 7b0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7b3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7b6:	89 0a                	mov    %ecx,(%edx)
}
 7b8:	5b                   	pop    %ebx
 7b9:	5e                   	pop    %esi
 7ba:	5f                   	pop    %edi
 7bb:	5d                   	pop    %ebp
 7bc:	c3                   	ret
 7bd:	8d 76 00             	lea    0x0(%esi),%esi

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7cc:	8b 15 38 0c 00 00    	mov    0xc38,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d2:	8d 78 07             	lea    0x7(%eax),%edi
 7d5:	c1 ef 03             	shr    $0x3,%edi
 7d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7db:	85 d2                	test   %edx,%edx
 7dd:	0f 84 8d 00 00 00    	je     870 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7e5:	8b 48 04             	mov    0x4(%eax),%ecx
 7e8:	39 f9                	cmp    %edi,%ecx
 7ea:	73 64                	jae    850 <malloc+0x90>
  if(nu < 4096)
 7ec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7f1:	39 df                	cmp    %ebx,%edi
 7f3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7f6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7fd:	eb 0a                	jmp    809 <malloc+0x49>
 7ff:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 800:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 802:	8b 48 04             	mov    0x4(%eax),%ecx
 805:	39 f9                	cmp    %edi,%ecx
 807:	73 47                	jae    850 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 809:	89 c2                	mov    %eax,%edx
 80b:	39 05 38 0c 00 00    	cmp    %eax,0xc38
 811:	75 ed                	jne    800 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 813:	83 ec 0c             	sub    $0xc,%esp
 816:	56                   	push   %esi
 817:	e8 ce fb ff ff       	call   3ea <sbrk>
  if(p == (char*)-1)
 81c:	83 c4 10             	add    $0x10,%esp
 81f:	83 f8 ff             	cmp    $0xffffffff,%eax
 822:	74 1c                	je     840 <malloc+0x80>
  hp->s.size = nu;
 824:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 827:	83 ec 0c             	sub    $0xc,%esp
 82a:	83 c0 08             	add    $0x8,%eax
 82d:	50                   	push   %eax
 82e:	e8 ed fe ff ff       	call   720 <free>
  return freep;
 833:	8b 15 38 0c 00 00    	mov    0xc38,%edx
      if((p = morecore(nunits)) == 0)
 839:	83 c4 10             	add    $0x10,%esp
 83c:	85 d2                	test   %edx,%edx
 83e:	75 c0                	jne    800 <malloc+0x40>
        return 0;
  }
}
 840:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 843:	31 c0                	xor    %eax,%eax
}
 845:	5b                   	pop    %ebx
 846:	5e                   	pop    %esi
 847:	5f                   	pop    %edi
 848:	5d                   	pop    %ebp
 849:	c3                   	ret
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 850:	39 cf                	cmp    %ecx,%edi
 852:	74 4c                	je     8a0 <malloc+0xe0>
        p->s.size -= nunits;
 854:	29 f9                	sub    %edi,%ecx
 856:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 859:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 85c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 85f:	89 15 38 0c 00 00    	mov    %edx,0xc38
}
 865:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 868:	83 c0 08             	add    $0x8,%eax
}
 86b:	5b                   	pop    %ebx
 86c:	5e                   	pop    %esi
 86d:	5f                   	pop    %edi
 86e:	5d                   	pop    %ebp
 86f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 870:	c7 05 38 0c 00 00 3c 	movl   $0xc3c,0xc38
 877:	0c 00 00 
    base.s.size = 0;
 87a:	b8 3c 0c 00 00       	mov    $0xc3c,%eax
    base.s.ptr = freep = prevp = &base;
 87f:	c7 05 3c 0c 00 00 3c 	movl   $0xc3c,0xc3c
 886:	0c 00 00 
    base.s.size = 0;
 889:	c7 05 40 0c 00 00 00 	movl   $0x0,0xc40
 890:	00 00 00 
    if(p->s.size >= nunits){
 893:	e9 54 ff ff ff       	jmp    7ec <malloc+0x2c>
 898:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 89f:	00 
        prevp->s.ptr = p->s.ptr;
 8a0:	8b 08                	mov    (%eax),%ecx
 8a2:	89 0a                	mov    %ecx,(%edx)
 8a4:	eb b9                	jmp    85f <malloc+0x9f>
