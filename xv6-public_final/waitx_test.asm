
_waitx_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
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
  11:	83 ec 28             	sub    $0x28,%esp
  int n = 1;
  if(argc > 1) n = atoi(argv[1]);   // تعداد بچه‌ها (پیش‌فرض 1)
  14:	83 39 01             	cmpl   $0x1,(%ecx)
{
  17:	8b 41 04             	mov    0x4(%ecx),%eax
  if(argc > 1) n = atoi(argv[1]);   // تعداد بچه‌ها (پیش‌فرض 1)
  1a:	7e 17                	jle    33 <main+0x33>
  1c:	83 ec 0c             	sub    $0xc,%esp
  1f:	ff 70 04             	push   0x4(%eax)
             ret, r, w, r+w);
    }
  } else {
    // حالت چندبچه‌ای: برای تست واقعی scheduling
    int total_w=0, total_r=0;
    for(int c=0; c<n; c++){
  22:	31 f6                	xor    %esi,%esi
  if(argc > 1) n = atoi(argv[1]);   // تعداد بچه‌ها (پیش‌فرض 1)
  24:	e8 b7 03 00 00       	call   3e0 <atoi>
  if(n <= 1){
  29:	83 c4 10             	add    $0x10,%esp
  if(argc > 1) n = atoi(argv[1]);   // تعداد بچه‌ها (پیش‌فرض 1)
  2c:	89 c7                	mov    %eax,%edi
  if(n <= 1){
  2e:	83 f8 01             	cmp    $0x1,%eax
  31:	7f 4f                	jg     82 <main+0x82>
    int pid = fork();
  33:	e8 3a 04 00 00       	call   472 <fork>
    if(pid == 0){
  38:	85 c0                	test   %eax,%eax
  3a:	0f 84 e6 00 00 00    	je     126 <main+0x126>
      int ret = waitx(&w,&r);
  40:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  43:	53                   	push   %ebx
      int w=0, r=0;
  44:	31 c9                	xor    %ecx,%ecx
      int ret = waitx(&w,&r);
  46:	53                   	push   %ebx
  47:	50                   	push   %eax
  48:	8d 45 e0             	lea    -0x20(%ebp),%eax
  4b:	50                   	push   %eax
      int w=0, r=0;
  4c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  4f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      int ret = waitx(&w,&r);
  52:	e8 db 04 00 00       	call   532 <waitx>
      printf(1, "child %d finished -> rtime=%d, wtime=%d, turnaround=%d\n",
  57:	8b 55 e0             	mov    -0x20(%ebp),%edx
  5a:	5e                   	pop    %esi
      int ret = waitx(&w,&r);
  5b:	89 c1                	mov    %eax,%ecx
      printf(1, "child %d finished -> rtime=%d, wtime=%d, turnaround=%d\n",
  5d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  60:	5f                   	pop    %edi
  61:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
  64:	53                   	push   %ebx
  65:	52                   	push   %edx
  66:	50                   	push   %eax
  67:	51                   	push   %ecx
  68:	68 88 09 00 00       	push   $0x988
  6d:	6a 01                	push   $0x1
  6f:	e8 ac 05 00 00       	call   620 <printf>
  74:	83 c4 20             	add    $0x20,%esp
      total_r += r;
    }
    printf(1, "avg wtime=%d, avg rtime=%d\n", total_w/n, total_r/n);
  }

  exit();
  77:	e8 fe 03 00 00       	call   47a <exit>
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	89 de                	mov    %ebx,%esi
      int pid = fork();
  82:	e8 eb 03 00 00       	call   472 <fork>
      if(pid == 0){
  87:	85 c0                	test   %eax,%eax
  89:	0f 84 a6 00 00 00    	je     135 <main+0x135>
    for(int c=0; c<n; c++){
  8f:	8d 5e 01             	lea    0x1(%esi),%ebx
  92:	39 df                	cmp    %ebx,%edi
  94:	75 ea                	jne    80 <main+0x80>
    int total_w=0, total_r=0;
  96:	31 d2                	xor    %edx,%edx
  98:	89 75 d0             	mov    %esi,-0x30(%ebp)
  9b:	31 c0                	xor    %eax,%eax
    for(int i=0; i<n; i++){
  9d:	31 ff                	xor    %edi,%edi
    int total_w=0, total_r=0;
  9f:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  a2:	89 5d cc             	mov    %ebx,-0x34(%ebp)
  a5:	89 c3                	mov    %eax,%ebx
  a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ae:	00 
  af:	90                   	nop
      int pid = waitx(&w,&r);
  b0:	83 ec 08             	sub    $0x8,%esp
  b3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
      int w=0, r=0;
  b6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
      int pid = waitx(&w,&r);
  bd:	50                   	push   %eax
  be:	8d 45 e0             	lea    -0x20(%ebp),%eax
  c1:	50                   	push   %eax
      int w=0, r=0;
  c2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      int pid = waitx(&w,&r);
  c9:	e8 64 04 00 00       	call   532 <waitx>
      printf(1, "child %d -> rtime=%d, wtime=%d, turnaround=%d\n",
  ce:	8b 55 e0             	mov    -0x20(%ebp),%edx
  d1:	83 c4 08             	add    $0x8,%esp
      int pid = waitx(&w,&r);
  d4:	89 c1                	mov    %eax,%ecx
      printf(1, "child %d -> rtime=%d, wtime=%d, turnaround=%d\n",
  d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  d9:	8d 34 10             	lea    (%eax,%edx,1),%esi
  dc:	56                   	push   %esi
  dd:	52                   	push   %edx
  de:	50                   	push   %eax
  df:	51                   	push   %ecx
  e0:	68 c0 09 00 00       	push   $0x9c0
  e5:	6a 01                	push   $0x1
  e7:	e8 34 05 00 00       	call   620 <printf>
      total_w += w;
  ec:	8b 55 e0             	mov    -0x20(%ebp),%edx
  ef:	89 f8                	mov    %edi,%eax
  f1:	01 55 d4             	add    %edx,-0x2c(%ebp)
      total_r += r;
  f4:	03 5d e4             	add    -0x1c(%ebp),%ebx
    for(int i=0; i<n; i++){
  f7:	83 c7 01             	add    $0x1,%edi
  fa:	83 c4 20             	add    $0x20,%esp
  fd:	39 45 d0             	cmp    %eax,-0x30(%ebp)
 100:	75 ae                	jne    b0 <main+0xb0>
    printf(1, "avg wtime=%d, avg rtime=%d\n", total_w/n, total_r/n);
 102:	89 d8                	mov    %ebx,%eax
 104:	8b 5d cc             	mov    -0x34(%ebp),%ebx
 107:	99                   	cltd
 108:	f7 fb                	idiv   %ebx
 10a:	50                   	push   %eax
 10b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 10e:	99                   	cltd
 10f:	f7 fb                	idiv   %ebx
 111:	50                   	push   %eax
 112:	68 ef 09 00 00       	push   $0x9ef
 117:	6a 01                	push   $0x1
 119:	e8 02 05 00 00       	call   620 <printf>
 11e:	83 c4 10             	add    $0x10,%esp
 121:	e9 51 ff ff ff       	jmp    77 <main+0x77>
      busy(20000000);
 126:	b8 00 2d 31 01       	mov    $0x1312d00,%eax
 12b:	e8 50 00 00 00       	call   180 <busy>
      exit();
 130:	e8 45 03 00 00       	call   47a <exit>
        if(c % 2 == 0) sleep(20);  // بعضی‌ها تاخیر
 135:	f7 c6 01 00 00 00    	test   $0x1,%esi
 13b:	74 15                	je     152 <main+0x152>
        busy(10000000 + c*5000000);
 13d:	69 c6 40 4b 4c 00    	imul   $0x4c4b40,%esi,%eax
 143:	05 80 96 98 00       	add    $0x989680,%eax
 148:	e8 33 00 00 00       	call   180 <busy>
        exit();
 14d:	e8 28 03 00 00       	call   47a <exit>
        if(c % 2 == 0) sleep(20);  // بعضی‌ها تاخیر
 152:	83 ec 0c             	sub    $0xc,%esp
 155:	6a 14                	push   $0x14
 157:	e8 76 03 00 00       	call   4d2 <sleep>
 15c:	83 c4 10             	add    $0x10,%esp
 15f:	eb dc                	jmp    13d <main+0x13d>
 161:	66 90                	xchg   %ax,%ax
 163:	66 90                	xchg   %ax,%ax
 165:	66 90                	xchg   %ax,%ax
 167:	66 90                	xchg   %ax,%ax
 169:	66 90                	xchg   %ax,%ax
 16b:	66 90                	xchg   %ax,%ax
 16d:	66 90                	xchg   %ax,%ax
 16f:	66 90                	xchg   %ax,%ax
 171:	66 90                	xchg   %ax,%ax
 173:	66 90                	xchg   %ax,%ax
 175:	66 90                	xchg   %ax,%ax
 177:	66 90                	xchg   %ax,%ax
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <busy>:
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	56                   	push   %esi
 184:	89 c6                	mov    %eax,%esi
 186:	53                   	push   %ebx
  for(int i = 0; i < loops; i++){
 187:	31 db                	xor    %ebx,%ebx
{
 189:	83 ec 10             	sub    $0x10,%esp
  volatile unsigned long x = 0;
 18c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  for(int i = 0; i < loops; i++){
 193:	eb 32                	jmp    1c7 <busy+0x47>
 195:	eb 29                	jmp    1c0 <busy+0x40>
 197:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19e:	00 
 19f:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1a6:	00 
 1a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ae:	00 
 1af:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1b6:	00 
 1b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1be:	00 
 1bf:	90                   	nop
 1c0:	83 c3 01             	add    $0x1,%ebx
 1c3:	39 de                	cmp    %ebx,%esi
 1c5:	74 29                	je     1f0 <busy+0x70>
    x += i*i;
 1c7:	89 d8                	mov    %ebx,%eax
 1c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1cc:	0f af c3             	imul   %ebx,%eax
 1cf:	01 d0                	add    %edx,%eax
 1d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 1d4:	69 c3 39 61 c2 68    	imul   $0x68c26139,%ebx,%eax
 1da:	c1 c8 06             	ror    $0x6,%eax
    if(i % 1000000 == 0) yield();  // برای منصفانه‌تر شدن
 1dd:	3d c6 10 00 00       	cmp    $0x10c6,%eax
 1e2:	77 dc                	ja     1c0 <busy+0x40>
 1e4:	e8 51 03 00 00       	call   53a <yield>
  for(int i = 0; i < loops; i++){
 1e9:	83 c3 01             	add    $0x1,%ebx
 1ec:	39 de                	cmp    %ebx,%esi
 1ee:	75 d7                	jne    1c7 <busy+0x47>
}
 1f0:	83 c4 10             	add    $0x10,%esp
 1f3:	5b                   	pop    %ebx
 1f4:	5e                   	pop    %esi
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret
 1f7:	66 90                	xchg   %ax,%ax
 1f9:	66 90                	xchg   %ax,%ax
 1fb:	66 90                	xchg   %ax,%ax
 1fd:	66 90                	xchg   %ax,%ax
 1ff:	90                   	nop

00000200 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 200:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
 201:	31 c0                	xor    %eax,%eax
{
 203:	89 e5                	mov    %esp,%ebp
 205:	53                   	push   %ebx
 206:	8b 4d 08             	mov    0x8(%ebp),%ecx
 209:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
 210:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 214:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 217:	83 c0 01             	add    $0x1,%eax
 21a:	84 d2                	test   %dl,%dl
 21c:	75 f2                	jne    210 <strcpy+0x10>
  return os;
}
 21e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 221:	89 c8                	mov    %ecx,%eax
 223:	c9                   	leave
 224:	c3                   	ret
 225:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22c:	00 
 22d:	8d 76 00             	lea    0x0(%esi),%esi

00000230 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	53                   	push   %ebx
 234:	8b 55 08             	mov    0x8(%ebp),%edx
 237:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 23a:	0f b6 02             	movzbl (%edx),%eax
 23d:	84 c0                	test   %al,%al
 23f:	75 2f                	jne    270 <strcmp+0x40>
 241:	eb 4a                	jmp    28d <strcmp+0x5d>
 243:	eb 1b                	jmp    260 <strcmp+0x30>
 245:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24c:	00 
 24d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 254:	00 
 255:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25c:	00 
 25d:	8d 76 00             	lea    0x0(%esi),%esi
 260:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 264:	83 c2 01             	add    $0x1,%edx
 267:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 26a:	84 c0                	test   %al,%al
 26c:	74 12                	je     280 <strcmp+0x50>
 26e:	89 d9                	mov    %ebx,%ecx
 270:	0f b6 19             	movzbl (%ecx),%ebx
 273:	38 c3                	cmp    %al,%bl
 275:	74 e9                	je     260 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 277:	29 d8                	sub    %ebx,%eax
}
 279:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 27c:	c9                   	leave
 27d:	c3                   	ret
 27e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 280:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 284:	31 c0                	xor    %eax,%eax
 286:	29 d8                	sub    %ebx,%eax
}
 288:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 28b:	c9                   	leave
 28c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 28d:	0f b6 19             	movzbl (%ecx),%ebx
 290:	31 c0                	xor    %eax,%eax
 292:	eb e3                	jmp    277 <strcmp+0x47>
 294:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29b:	00 
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <strlen>:

uint
strlen(const char *s)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 2a6:	80 3a 00             	cmpb   $0x0,(%edx)
 2a9:	74 15                	je     2c0 <strlen+0x20>
 2ab:	31 c0                	xor    %eax,%eax
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
 2b0:	83 c0 01             	add    $0x1,%eax
 2b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 2b7:	89 c1                	mov    %eax,%ecx
 2b9:	75 f5                	jne    2b0 <strlen+0x10>
  return n;
}
 2bb:	89 c8                	mov    %ecx,%eax
 2bd:	5d                   	pop    %ebp
 2be:	c3                   	ret
 2bf:	90                   	nop
  for(n = 0; s[n]; n++);
 2c0:	31 c9                	xor    %ecx,%ecx
}
 2c2:	5d                   	pop    %ebp
 2c3:	89 c8                	mov    %ecx,%eax
 2c5:	c3                   	ret
 2c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2cd:	00 
 2ce:	66 90                	xchg   %ax,%ax

000002d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2da:	8b 45 0c             	mov    0xc(%ebp),%eax
 2dd:	89 d7                	mov    %edx,%edi
 2df:	fc                   	cld
 2e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 2e5:	89 d0                	mov    %edx,%eax
 2e7:	c9                   	leave
 2e8:	c3                   	ret
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002f0 <strchr>:

char*
strchr(const char *s, char c)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2fa:	0f b6 10             	movzbl (%eax),%edx
 2fd:	84 d2                	test   %dl,%dl
 2ff:	75 1a                	jne    31b <strchr+0x2b>
 301:	eb 25                	jmp    328 <strchr+0x38>
 303:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 30a:	00 
 30b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 310:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 314:	83 c0 01             	add    $0x1,%eax
 317:	84 d2                	test   %dl,%dl
 319:	74 0d                	je     328 <strchr+0x38>
    if(*s == c)
 31b:	38 d1                	cmp    %dl,%cl
 31d:	75 f1                	jne    310 <strchr+0x20>
      return (char*)s;
  return 0;
}
 31f:	5d                   	pop    %ebp
 320:	c3                   	ret
 321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 328:	31 c0                	xor    %eax,%eax
}
 32a:	5d                   	pop    %ebp
 32b:	c3                   	ret
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000330 <gets>:

char*
gets(char *buf, int max)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 335:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 338:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 339:	31 db                	xor    %ebx,%ebx
{
 33b:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 33e:	eb 27                	jmp    367 <gets+0x37>
    cc = read(0, &c, 1);
 340:	83 ec 04             	sub    $0x4,%esp
 343:	6a 01                	push   $0x1
 345:	56                   	push   %esi
 346:	6a 00                	push   $0x0
 348:	e8 45 01 00 00       	call   492 <read>
    if(cc < 1)
 34d:	83 c4 10             	add    $0x10,%esp
 350:	85 c0                	test   %eax,%eax
 352:	7e 1d                	jle    371 <gets+0x41>
      break;
    buf[i++] = c;
 354:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 358:	8b 55 08             	mov    0x8(%ebp),%edx
 35b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 35f:	3c 0a                	cmp    $0xa,%al
 361:	74 10                	je     373 <gets+0x43>
 363:	3c 0d                	cmp    $0xd,%al
 365:	74 0c                	je     373 <gets+0x43>
  for(i = 0; i+1 < max; ){
 367:	89 df                	mov    %ebx,%edi
 369:	83 c3 01             	add    $0x1,%ebx
 36c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 36f:	7c cf                	jl     340 <gets+0x10>
 371:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 373:	8b 45 08             	mov    0x8(%ebp),%eax
 376:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 37a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 37d:	5b                   	pop    %ebx
 37e:	5e                   	pop    %esi
 37f:	5f                   	pop    %edi
 380:	5d                   	pop    %ebp
 381:	c3                   	ret
 382:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 389:	00 
 38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000390 <stat>:

int
stat(const char *n, struct stat *st)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	56                   	push   %esi
 394:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 395:	83 ec 08             	sub    $0x8,%esp
 398:	6a 00                	push   $0x0
 39a:	ff 75 08             	push   0x8(%ebp)
 39d:	e8 40 01 00 00       	call   4e2 <open>
  if(fd < 0)
 3a2:	83 c4 10             	add    $0x10,%esp
 3a5:	85 c0                	test   %eax,%eax
 3a7:	78 27                	js     3d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3a9:	83 ec 08             	sub    $0x8,%esp
 3ac:	ff 75 0c             	push   0xc(%ebp)
 3af:	89 c3                	mov    %eax,%ebx
 3b1:	50                   	push   %eax
 3b2:	e8 f3 00 00 00       	call   4aa <fstat>
  close(fd);
 3b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 3ba:	89 c6                	mov    %eax,%esi
  close(fd);
 3bc:	e8 51 01 00 00       	call   512 <close>
  return r;
 3c1:	83 c4 10             	add    $0x10,%esp
}
 3c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3c7:	89 f0                	mov    %esi,%eax
 3c9:	5b                   	pop    %ebx
 3ca:	5e                   	pop    %esi
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3d5:	eb ed                	jmp    3c4 <stat+0x34>
 3d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3de:	00 
 3df:	90                   	nop

000003e0 <atoi>:

int
atoi(const char *s)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	53                   	push   %ebx
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e7:	0f be 02             	movsbl (%edx),%eax
 3ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3f5:	77 1e                	ja     415 <atoi+0x35>
 3f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3fe:	00 
 3ff:	90                   	nop
    n = n*10 + *s++ - '0';
 400:	83 c2 01             	add    $0x1,%edx
 403:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 406:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 40a:	0f be 02             	movsbl (%edx),%eax
 40d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 410:	80 fb 09             	cmp    $0x9,%bl
 413:	76 eb                	jbe    400 <atoi+0x20>
  return n;
}
 415:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 418:	89 c8                	mov    %ecx,%eax
 41a:	c9                   	leave
 41b:	c3                   	ret
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000420 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	8b 55 08             	mov    0x8(%ebp),%edx
 427:	8b 45 10             	mov    0x10(%ebp),%eax
 42a:	56                   	push   %esi
 42b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 42e:	39 f2                	cmp    %esi,%edx
 430:	73 1e                	jae    450 <memmove+0x30>
    while(n-- > 0)
 432:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 435:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 437:	85 c0                	test   %eax,%eax
 439:	7e 0a                	jle    445 <memmove+0x25>
 43b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 440:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 441:	39 f9                	cmp    %edi,%ecx
 443:	75 fb                	jne    440 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 445:	5e                   	pop    %esi
 446:	89 d0                	mov    %edx,%eax
 448:	5f                   	pop    %edi
 449:	5d                   	pop    %ebp
 44a:	c3                   	ret
 44b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 450:	85 c0                	test   %eax,%eax
 452:	7e f1                	jle    445 <memmove+0x25>
    while(n-- > 0)
 454:	83 e8 01             	sub    $0x1,%eax
 457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45e:	00 
 45f:	90                   	nop
      *--dst = *--src;
 460:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 464:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 467:	83 e8 01             	sub    $0x1,%eax
 46a:	73 f4                	jae    460 <memmove+0x40>
}
 46c:	5e                   	pop    %esi
 46d:	89 d0                	mov    %edx,%eax
 46f:	5f                   	pop    %edi
 470:	5d                   	pop    %ebp
 471:	c3                   	ret

00000472 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 472:	b8 01 00 00 00       	mov    $0x1,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret

0000047a <exit>:
SYSCALL(exit)
 47a:	b8 02 00 00 00       	mov    $0x2,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret

00000482 <wait>:
SYSCALL(wait)
 482:	b8 03 00 00 00       	mov    $0x3,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret

0000048a <pipe>:
SYSCALL(pipe)
 48a:	b8 04 00 00 00       	mov    $0x4,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret

00000492 <read>:
SYSCALL(read)
 492:	b8 05 00 00 00       	mov    $0x5,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret

0000049a <kill>:
SYSCALL(kill)
 49a:	b8 06 00 00 00       	mov    $0x6,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret

000004a2 <exec>:
SYSCALL(exec)
 4a2:	b8 07 00 00 00       	mov    $0x7,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret

000004aa <fstat>:
SYSCALL(fstat)
 4aa:	b8 08 00 00 00       	mov    $0x8,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret

000004b2 <chdir>:
SYSCALL(chdir)
 4b2:	b8 09 00 00 00       	mov    $0x9,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret

000004ba <dup>:
SYSCALL(dup)
 4ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret

000004c2 <getpid>:
SYSCALL(getpid)
 4c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret

000004ca <sbrk>:
SYSCALL(sbrk)
 4ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret

000004d2 <sleep>:
SYSCALL(sleep)
 4d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret

000004da <uptime>:
SYSCALL(uptime)
 4da:	b8 0e 00 00 00       	mov    $0xe,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret

000004e2 <open>:
SYSCALL(open)
 4e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret

000004ea <write>:
SYSCALL(write)
 4ea:	b8 10 00 00 00       	mov    $0x10,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret

000004f2 <mknod>:
SYSCALL(mknod)
 4f2:	b8 11 00 00 00       	mov    $0x11,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret

000004fa <unlink>:
SYSCALL(unlink)
 4fa:	b8 12 00 00 00       	mov    $0x12,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret

00000502 <link>:
SYSCALL(link)
 502:	b8 13 00 00 00       	mov    $0x13,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret

0000050a <mkdir>:
SYSCALL(mkdir)
 50a:	b8 14 00 00 00       	mov    $0x14,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret

00000512 <close>:
SYSCALL(close)
 512:	b8 15 00 00 00       	mov    $0x15,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret

0000051a <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 51a:	b8 16 00 00 00       	mov    $0x16,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret

00000522 <settickets>:
SYSCALL(settickets)
 522:	b8 17 00 00 00       	mov    $0x17,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret

0000052a <getpinfo>:
SYSCALL(getpinfo)
 52a:	b8 18 00 00 00       	mov    $0x18,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret

00000532 <waitx>:
SYSCALL(waitx)
 532:	b8 19 00 00 00       	mov    $0x19,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret

0000053a <yield>:
SYSCALL(yield)
 53a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret
 542:	66 90                	xchg   %ax,%ax
 544:	66 90                	xchg   %ax,%ax
 546:	66 90                	xchg   %ax,%ax
 548:	66 90                	xchg   %ax,%ax
 54a:	66 90                	xchg   %ax,%ax
 54c:	66 90                	xchg   %ax,%ax
 54e:	66 90                	xchg   %ax,%ax
 550:	66 90                	xchg   %ax,%ax
 552:	66 90                	xchg   %ax,%ax
 554:	66 90                	xchg   %ax,%ax
 556:	66 90                	xchg   %ax,%ax
 558:	66 90                	xchg   %ax,%ax
 55a:	66 90                	xchg   %ax,%ax
 55c:	66 90                	xchg   %ax,%ax
 55e:	66 90                	xchg   %ax,%ax

00000560 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 568:	89 d1                	mov    %edx,%ecx
{
 56a:	83 ec 3c             	sub    $0x3c,%esp
 56d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 570:	85 d2                	test   %edx,%edx
 572:	0f 89 98 00 00 00    	jns    610 <printint+0xb0>
 578:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 57c:	0f 84 8e 00 00 00    	je     610 <printint+0xb0>
    x = -xx;
 582:	f7 d9                	neg    %ecx
    neg = 1;
 584:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 589:	89 45 c0             	mov    %eax,-0x40(%ebp)
 58c:	31 f6                	xor    %esi,%esi
 58e:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 595:	00 
 596:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59d:	00 
 59e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 5a0:	89 c8                	mov    %ecx,%eax
 5a2:	31 d2                	xor    %edx,%edx
 5a4:	89 f7                	mov    %esi,%edi
 5a6:	f7 f3                	div    %ebx
 5a8:	8d 76 01             	lea    0x1(%esi),%esi
 5ab:	0f b6 92 6c 0a 00 00 	movzbl 0xa6c(%edx),%edx
 5b2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 5b6:	89 ca                	mov    %ecx,%edx
 5b8:	89 c1                	mov    %eax,%ecx
 5ba:	39 da                	cmp    %ebx,%edx
 5bc:	73 e2                	jae    5a0 <printint+0x40>
  if(neg)
 5be:	8b 45 c0             	mov    -0x40(%ebp),%eax
 5c1:	85 c0                	test   %eax,%eax
 5c3:	74 07                	je     5cc <printint+0x6c>
    buf[i++] = '-';
 5c5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 5ca:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 5cc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 5cf:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 5d2:	01 df                	add    %ebx,%edi
 5d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5db:	00 
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 5e0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
 5e6:	88 45 d7             	mov    %al,-0x29(%ebp)
 5e9:	8d 45 d7             	lea    -0x29(%ebp),%eax
 5ec:	6a 01                	push   $0x1
 5ee:	50                   	push   %eax
 5ef:	56                   	push   %esi
 5f0:	e8 f5 fe ff ff       	call   4ea <write>
  while(--i >= 0)
 5f5:	89 f8                	mov    %edi,%eax
 5f7:	83 c4 10             	add    $0x10,%esp
 5fa:	83 ef 01             	sub    $0x1,%edi
 5fd:	39 d8                	cmp    %ebx,%eax
 5ff:	75 df                	jne    5e0 <printint+0x80>
}
 601:	8d 65 f4             	lea    -0xc(%ebp),%esp
 604:	5b                   	pop    %ebx
 605:	5e                   	pop    %esi
 606:	5f                   	pop    %edi
 607:	5d                   	pop    %ebp
 608:	c3                   	ret
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 610:	31 c0                	xor    %eax,%eax
 612:	e9 72 ff ff ff       	jmp    589 <printint+0x29>
 617:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 61e:	00 
 61f:	90                   	nop

00000620 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 629:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 62c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 62f:	0f b6 13             	movzbl (%ebx),%edx
 632:	83 c3 01             	add    $0x1,%ebx
 635:	84 d2                	test   %dl,%dl
 637:	0f 84 a0 00 00 00    	je     6dd <printf+0xbd>
 63d:	8d 45 10             	lea    0x10(%ebp),%eax
 640:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 643:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 646:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 649:	eb 28                	jmp    673 <printf+0x53>
 64b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 650:	83 ec 04             	sub    $0x4,%esp
 653:	8d 45 e7             	lea    -0x19(%ebp),%eax
 656:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 659:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 65c:	6a 01                	push   $0x1
 65e:	50                   	push   %eax
 65f:	56                   	push   %esi
 660:	e8 85 fe ff ff       	call   4ea <write>
  for(i = 0; fmt[i]; i++){
 665:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 669:	83 c4 10             	add    $0x10,%esp
 66c:	84 d2                	test   %dl,%dl
 66e:	74 6d                	je     6dd <printf+0xbd>
    c = fmt[i] & 0xff;
 670:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 673:	83 f8 25             	cmp    $0x25,%eax
 676:	75 d8                	jne    650 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 678:	0f b6 13             	movzbl (%ebx),%edx
 67b:	84 d2                	test   %dl,%dl
 67d:	74 5e                	je     6dd <printf+0xbd>
    c = fmt[i] & 0xff;
 67f:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 682:	80 fa 25             	cmp    $0x25,%dl
 685:	0f 84 1d 01 00 00    	je     7a8 <printf+0x188>
 68b:	83 e8 63             	sub    $0x63,%eax
 68e:	83 f8 15             	cmp    $0x15,%eax
 691:	77 0d                	ja     6a0 <printf+0x80>
 693:	ff 24 85 14 0a 00 00 	jmp    *0xa14(,%eax,4)
 69a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 6a6:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6a9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 6ad:	6a 01                	push   $0x1
 6af:	51                   	push   %ecx
 6b0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 6b3:	56                   	push   %esi
 6b4:	e8 31 fe ff ff       	call   4ea <write>
        putc(fd, c);
 6b9:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 6bd:	83 c4 0c             	add    $0xc,%esp
 6c0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 6c3:	6a 01                	push   $0x1
 6c5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 6c8:	51                   	push   %ecx
 6c9:	56                   	push   %esi
 6ca:	e8 1b fe ff ff       	call   4ea <write>
  for(i = 0; fmt[i]; i++){
 6cf:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 6d3:	83 c3 02             	add    $0x2,%ebx
 6d6:	83 c4 10             	add    $0x10,%esp
 6d9:	84 d2                	test   %dl,%dl
 6db:	75 93                	jne    670 <printf+0x50>
      }
      state = 0;
    }
  }
}
 6dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6e0:	5b                   	pop    %ebx
 6e1:	5e                   	pop    %esi
 6e2:	5f                   	pop    %edi
 6e3:	5d                   	pop    %ebp
 6e4:	c3                   	ret
 6e5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 6e8:	83 ec 0c             	sub    $0xc,%esp
 6eb:	8b 17                	mov    (%edi),%edx
 6ed:	b9 10 00 00 00       	mov    $0x10,%ecx
 6f2:	89 f0                	mov    %esi,%eax
 6f4:	6a 00                	push   $0x0
        ap++;
 6f6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 6f9:	e8 62 fe ff ff       	call   560 <printint>
  for(i = 0; fmt[i]; i++){
 6fe:	eb cf                	jmp    6cf <printf+0xaf>
        s = (char*)*ap;
 700:	8b 07                	mov    (%edi),%eax
        ap++;
 702:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 705:	85 c0                	test   %eax,%eax
 707:	0f 84 b3 00 00 00    	je     7c0 <printf+0x1a0>
        while(*s != 0){
 70d:	0f b6 10             	movzbl (%eax),%edx
 710:	84 d2                	test   %dl,%dl
 712:	0f 84 ba 00 00 00    	je     7d2 <printf+0x1b2>
 718:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 71b:	89 c7                	mov    %eax,%edi
 71d:	89 d0                	mov    %edx,%eax
 71f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 722:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 725:	89 fb                	mov    %edi,%ebx
 727:	89 cf                	mov    %ecx,%edi
 729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 730:	83 ec 04             	sub    $0x4,%esp
 733:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 736:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 739:	6a 01                	push   $0x1
 73b:	57                   	push   %edi
 73c:	56                   	push   %esi
 73d:	e8 a8 fd ff ff       	call   4ea <write>
        while(*s != 0){
 742:	0f b6 03             	movzbl (%ebx),%eax
 745:	83 c4 10             	add    $0x10,%esp
 748:	84 c0                	test   %al,%al
 74a:	75 e4                	jne    730 <printf+0x110>
 74c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 74f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 753:	83 c3 02             	add    $0x2,%ebx
 756:	84 d2                	test   %dl,%dl
 758:	0f 85 e5 fe ff ff    	jne    643 <printf+0x23>
 75e:	e9 7a ff ff ff       	jmp    6dd <printf+0xbd>
 763:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 768:	83 ec 0c             	sub    $0xc,%esp
 76b:	8b 17                	mov    (%edi),%edx
 76d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 772:	89 f0                	mov    %esi,%eax
 774:	6a 01                	push   $0x1
        ap++;
 776:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 779:	e8 e2 fd ff ff       	call   560 <printint>
  for(i = 0; fmt[i]; i++){
 77e:	e9 4c ff ff ff       	jmp    6cf <printf+0xaf>
 783:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 788:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 78a:	83 ec 04             	sub    $0x4,%esp
 78d:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 790:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 793:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 796:	6a 01                	push   $0x1
 798:	51                   	push   %ecx
 799:	56                   	push   %esi
 79a:	e8 4b fd ff ff       	call   4ea <write>
  for(i = 0; fmt[i]; i++){
 79f:	e9 2b ff ff ff       	jmp    6cf <printf+0xaf>
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 7a8:	83 ec 04             	sub    $0x4,%esp
 7ab:	88 55 e7             	mov    %dl,-0x19(%ebp)
 7ae:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 7b1:	6a 01                	push   $0x1
 7b3:	e9 10 ff ff ff       	jmp    6c8 <printf+0xa8>
 7b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7bf:	00 
          s = "(null)";
 7c0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 7c3:	b8 28 00 00 00       	mov    $0x28,%eax
 7c8:	bf 0b 0a 00 00       	mov    $0xa0b,%edi
 7cd:	e9 4d ff ff ff       	jmp    71f <printf+0xff>
  for(i = 0; fmt[i]; i++){
 7d2:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 7d6:	83 c3 02             	add    $0x2,%ebx
 7d9:	84 d2                	test   %dl,%dl
 7db:	0f 85 8f fe ff ff    	jne    670 <printf+0x50>
 7e1:	e9 f7 fe ff ff       	jmp    6dd <printf+0xbd>
 7e6:	66 90                	xchg   %ax,%ax
 7e8:	66 90                	xchg   %ax,%ax
 7ea:	66 90                	xchg   %ax,%ax
 7ec:	66 90                	xchg   %ax,%ax
 7ee:	66 90                	xchg   %ax,%ax
 7f0:	66 90                	xchg   %ax,%ax
 7f2:	66 90                	xchg   %ax,%ax
 7f4:	66 90                	xchg   %ax,%ax
 7f6:	66 90                	xchg   %ax,%ax
 7f8:	66 90                	xchg   %ax,%ax
 7fa:	66 90                	xchg   %ax,%ax
 7fc:	66 90                	xchg   %ax,%ax
 7fe:	66 90                	xchg   %ax,%ax

00000800 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 800:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 801:	a1 4c 0d 00 00       	mov    0xd4c,%eax
{
 806:	89 e5                	mov    %esp,%ebp
 808:	57                   	push   %edi
 809:	56                   	push   %esi
 80a:	53                   	push   %ebx
 80b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 80e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 811:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 818:	00 
 819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 820:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 822:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 824:	39 ca                	cmp    %ecx,%edx
 826:	73 30                	jae    858 <free+0x58>
 828:	39 c1                	cmp    %eax,%ecx
 82a:	72 04                	jb     830 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82c:	39 c2                	cmp    %eax,%edx
 82e:	72 f0                	jb     820 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 830:	8b 73 fc             	mov    -0x4(%ebx),%esi
 833:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 836:	39 f8                	cmp    %edi,%eax
 838:	74 36                	je     870 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 83a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 83d:	8b 42 04             	mov    0x4(%edx),%eax
 840:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 843:	39 f1                	cmp    %esi,%ecx
 845:	74 40                	je     887 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 847:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 849:	5b                   	pop    %ebx
  freep = p;
 84a:	89 15 4c 0d 00 00    	mov    %edx,0xd4c
}
 850:	5e                   	pop    %esi
 851:	5f                   	pop    %edi
 852:	5d                   	pop    %ebp
 853:	c3                   	ret
 854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 858:	39 c2                	cmp    %eax,%edx
 85a:	72 c4                	jb     820 <free+0x20>
 85c:	39 c1                	cmp    %eax,%ecx
 85e:	73 c0                	jae    820 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 860:	8b 73 fc             	mov    -0x4(%ebx),%esi
 863:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 866:	39 f8                	cmp    %edi,%eax
 868:	75 d0                	jne    83a <free+0x3a>
 86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 870:	03 70 04             	add    0x4(%eax),%esi
 873:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 876:	8b 02                	mov    (%edx),%eax
 878:	8b 00                	mov    (%eax),%eax
 87a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 87d:	8b 42 04             	mov    0x4(%edx),%eax
 880:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 883:	39 f1                	cmp    %esi,%ecx
 885:	75 c0                	jne    847 <free+0x47>
    p->s.size += bp->s.size;
 887:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 88a:	89 15 4c 0d 00 00    	mov    %edx,0xd4c
    p->s.size += bp->s.size;
 890:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 893:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 896:	89 0a                	mov    %ecx,(%edx)
}
 898:	5b                   	pop    %ebx
 899:	5e                   	pop    %esi
 89a:	5f                   	pop    %edi
 89b:	5d                   	pop    %ebp
 89c:	c3                   	ret
 89d:	8d 76 00             	lea    0x0(%esi),%esi

000008a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	56                   	push   %esi
 8a5:	53                   	push   %ebx
 8a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8ac:	8b 15 4c 0d 00 00    	mov    0xd4c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b2:	8d 78 07             	lea    0x7(%eax),%edi
 8b5:	c1 ef 03             	shr    $0x3,%edi
 8b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8bb:	85 d2                	test   %edx,%edx
 8bd:	0f 84 8d 00 00 00    	je     950 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8c5:	8b 48 04             	mov    0x4(%eax),%ecx
 8c8:	39 f9                	cmp    %edi,%ecx
 8ca:	73 64                	jae    930 <malloc+0x90>
  if(nu < 4096)
 8cc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 8d1:	39 df                	cmp    %ebx,%edi
 8d3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 8d6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 8dd:	eb 0a                	jmp    8e9 <malloc+0x49>
 8df:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8e2:	8b 48 04             	mov    0x4(%eax),%ecx
 8e5:	39 f9                	cmp    %edi,%ecx
 8e7:	73 47                	jae    930 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e9:	89 c2                	mov    %eax,%edx
 8eb:	39 05 4c 0d 00 00    	cmp    %eax,0xd4c
 8f1:	75 ed                	jne    8e0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 8f3:	83 ec 0c             	sub    $0xc,%esp
 8f6:	56                   	push   %esi
 8f7:	e8 ce fb ff ff       	call   4ca <sbrk>
  if(p == (char*)-1)
 8fc:	83 c4 10             	add    $0x10,%esp
 8ff:	83 f8 ff             	cmp    $0xffffffff,%eax
 902:	74 1c                	je     920 <malloc+0x80>
  hp->s.size = nu;
 904:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 907:	83 ec 0c             	sub    $0xc,%esp
 90a:	83 c0 08             	add    $0x8,%eax
 90d:	50                   	push   %eax
 90e:	e8 ed fe ff ff       	call   800 <free>
  return freep;
 913:	8b 15 4c 0d 00 00    	mov    0xd4c,%edx
      if((p = morecore(nunits)) == 0)
 919:	83 c4 10             	add    $0x10,%esp
 91c:	85 d2                	test   %edx,%edx
 91e:	75 c0                	jne    8e0 <malloc+0x40>
        return 0;
  }
}
 920:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 923:	31 c0                	xor    %eax,%eax
}
 925:	5b                   	pop    %ebx
 926:	5e                   	pop    %esi
 927:	5f                   	pop    %edi
 928:	5d                   	pop    %ebp
 929:	c3                   	ret
 92a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 930:	39 cf                	cmp    %ecx,%edi
 932:	74 4c                	je     980 <malloc+0xe0>
        p->s.size -= nunits;
 934:	29 f9                	sub    %edi,%ecx
 936:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 939:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 93c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 93f:	89 15 4c 0d 00 00    	mov    %edx,0xd4c
}
 945:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 948:	83 c0 08             	add    $0x8,%eax
}
 94b:	5b                   	pop    %ebx
 94c:	5e                   	pop    %esi
 94d:	5f                   	pop    %edi
 94e:	5d                   	pop    %ebp
 94f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 950:	c7 05 4c 0d 00 00 50 	movl   $0xd50,0xd4c
 957:	0d 00 00 
    base.s.size = 0;
 95a:	b8 50 0d 00 00       	mov    $0xd50,%eax
    base.s.ptr = freep = prevp = &base;
 95f:	c7 05 50 0d 00 00 50 	movl   $0xd50,0xd50
 966:	0d 00 00 
    base.s.size = 0;
 969:	c7 05 54 0d 00 00 00 	movl   $0x0,0xd54
 970:	00 00 00 
    if(p->s.size >= nunits){
 973:	e9 54 ff ff ff       	jmp    8cc <malloc+0x2c>
 978:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 97f:	00 
        prevp->s.ptr = p->s.ptr;
 980:	8b 08                	mov    (%eax),%ecx
 982:	89 0a                	mov    %ecx,(%edx)
 984:	eb b9                	jmp    93f <malloc+0x9f>
