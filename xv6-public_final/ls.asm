
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
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
  10:	bb 01 00 00 00       	mov    $0x1,%ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  1e:	83 fe 01             	cmp    $0x1,%esi
  21:	7e 27                	jle    4a <main+0x4a>
  23:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2a:	00 
  2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i = 1; i < argc; i++)
    ls(argv[i]);
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 34 9f             	push   (%edi,%ebx,4)
  for(i = 1; i < argc; i++)
  36:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
  39:	e8 c2 00 00 00       	call   100 <ls>
  for(i = 1; i < argc; i++)
  3e:	83 c4 10             	add    $0x10,%esp
  41:	39 de                	cmp    %ebx,%esi
  43:	75 eb                	jne    30 <main+0x30>
  exit();
  45:	e8 70 05 00 00       	call   5ba <exit>
    ls(".");
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	68 10 0b 00 00       	push   $0xb10
  52:	e8 a9 00 00 00       	call   100 <ls>
    exit();
  57:	e8 5e 05 00 00       	call   5ba <exit>
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p = path+strlen(path); p >= path && *p != '/'; p--)
  68:	83 ec 0c             	sub    $0xc,%esp
  6b:	56                   	push   %esi
  6c:	e8 6f 03 00 00       	call   3e0 <strlen>
  71:	83 c4 10             	add    $0x10,%esp
  74:	01 f0                	add    %esi,%eax
  76:	89 c3                	mov    %eax,%ebx
  78:	73 0f                	jae    89 <fmtname+0x29>
  7a:	eb 12                	jmp    8e <fmtname+0x2e>
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	8d 43 ff             	lea    -0x1(%ebx),%eax
  83:	39 f0                	cmp    %esi,%eax
  85:	72 0a                	jb     91 <fmtname+0x31>
  87:	89 c3                	mov    %eax,%ebx
  89:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  8c:	75 f2                	jne    80 <fmtname+0x20>
  p++;
  8e:	83 c3 01             	add    $0x1,%ebx
  if(strlen(p) >= DIRSIZ)
  91:	83 ec 0c             	sub    $0xc,%esp
  94:	53                   	push   %ebx
  95:	e8 46 03 00 00       	call   3e0 <strlen>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	83 f8 0d             	cmp    $0xd,%eax
  a0:	77 4a                	ja     ec <fmtname+0x8c>
  memmove(buf, p, strlen(p));
  a2:	83 ec 0c             	sub    $0xc,%esp
  a5:	53                   	push   %ebx
  a6:	e8 35 03 00 00       	call   3e0 <strlen>
  ab:	83 c4 0c             	add    $0xc,%esp
  ae:	50                   	push   %eax
  af:	53                   	push   %ebx
  b0:	68 a4 0e 00 00       	push   $0xea4
  b5:	e8 a6 04 00 00       	call   560 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ba:	89 1c 24             	mov    %ebx,(%esp)
  bd:	e8 1e 03 00 00       	call   3e0 <strlen>
  c2:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  c5:	bb a4 0e 00 00       	mov    $0xea4,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ca:	89 c6                	mov    %eax,%esi
  cc:	e8 0f 03 00 00       	call   3e0 <strlen>
  d1:	ba 0e 00 00 00       	mov    $0xe,%edx
  d6:	83 c4 0c             	add    $0xc,%esp
  d9:	29 f2                	sub    %esi,%edx
  db:	05 a4 0e 00 00       	add    $0xea4,%eax
  e0:	52                   	push   %edx
  e1:	6a 20                	push   $0x20
  e3:	50                   	push   %eax
  e4:	e8 27 03 00 00       	call   410 <memset>
  return buf;
  e9:	83 c4 10             	add    $0x10,%esp
}
  ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ef:	89 d8                	mov    %ebx,%eax
  f1:	5b                   	pop    %ebx
  f2:	5e                   	pop    %esi
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret
  f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fc:	00 
  fd:	8d 76 00             	lea    0x0(%esi),%esi

00000100 <ls>:
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
 106:	81 ec 54 02 00 00    	sub    $0x254,%esp
 10c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, O_RDONLY)) < 0){   // <== اینجا قبلاً 0 بود
 10f:	6a 00                	push   $0x0
 111:	57                   	push   %edi
 112:	e8 0b 05 00 00       	call   622 <open>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	0f 88 8e 01 00 00    	js     2b0 <ls+0x1b0>
  if(fstat(fd, &st) < 0){
 122:	83 ec 08             	sub    $0x8,%esp
 125:	8d b5 c8 fd ff ff    	lea    -0x238(%ebp),%esi
 12b:	89 c3                	mov    %eax,%ebx
 12d:	56                   	push   %esi
 12e:	50                   	push   %eax
 12f:	e8 b6 04 00 00       	call   5ea <fstat>
 134:	83 c4 10             	add    $0x10,%esp
 137:	85 c0                	test   %eax,%eax
 139:	0f 88 b1 01 00 00    	js     2f0 <ls+0x1f0>
  switch(st.type){
 13f:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 146:	66 83 f8 01          	cmp    $0x1,%ax
 14a:	74 54                	je     1a0 <ls+0xa0>
 14c:	66 83 f8 02          	cmp    $0x2,%ax
 150:	75 37                	jne    189 <ls+0x89>
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 152:	8b 95 d4 fd ff ff    	mov    -0x22c(%ebp),%edx
 158:	83 ec 0c             	sub    $0xc,%esp
 15b:	8b b5 cc fd ff ff    	mov    -0x234(%ebp),%esi
 161:	89 95 c4 fd ff ff    	mov    %edx,-0x23c(%ebp)
 167:	57                   	push   %edi
 168:	e8 f3 fe ff ff       	call   60 <fmtname>
 16d:	8b 95 c4 fd ff ff    	mov    -0x23c(%ebp),%edx
 173:	59                   	pop    %ecx
 174:	5f                   	pop    %edi
 175:	52                   	push   %edx
 176:	56                   	push   %esi
 177:	6a 02                	push   $0x2
 179:	50                   	push   %eax
 17a:	68 f0 0a 00 00       	push   $0xaf0
 17f:	6a 01                	push   $0x1
 181:	e8 da 05 00 00       	call   760 <printf>
    break;
 186:	83 c4 20             	add    $0x20,%esp
  close(fd);
 189:	83 ec 0c             	sub    $0xc,%esp
 18c:	53                   	push   %ebx
 18d:	e8 c0 04 00 00       	call   652 <close>
 192:	83 c4 10             	add    $0x10,%esp
}
 195:	8d 65 f4             	lea    -0xc(%ebp),%esp
 198:	5b                   	pop    %ebx
 199:	5e                   	pop    %esi
 19a:	5f                   	pop    %edi
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret
 19d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a0:	83 ec 0c             	sub    $0xc,%esp
 1a3:	57                   	push   %edi
 1a4:	e8 37 02 00 00       	call   3e0 <strlen>
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	83 c0 10             	add    $0x10,%eax
 1af:	3d 00 02 00 00       	cmp    $0x200,%eax
 1b4:	0f 87 16 01 00 00    	ja     2d0 <ls+0x1d0>
    strcpy(buf, path);
 1ba:	83 ec 08             	sub    $0x8,%esp
 1bd:	57                   	push   %edi
 1be:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 1c4:	57                   	push   %edi
 1c5:	e8 76 01 00 00       	call   340 <strcpy>
    p = buf+strlen(buf);
 1ca:	89 3c 24             	mov    %edi,(%esp)
 1cd:	e8 0e 02 00 00       	call   3e0 <strlen>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1d2:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1d5:	01 f8                	add    %edi,%eax
    *p++ = '/';
 1d7:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 1da:	89 85 b8 fd ff ff    	mov    %eax,-0x248(%ebp)
    *p++ = '/';
 1e0:	89 8d b4 fd ff ff    	mov    %ecx,-0x24c(%ebp)
 1e6:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 ec 04             	sub    $0x4,%esp
 1f3:	8d 85 d8 fd ff ff    	lea    -0x228(%ebp),%eax
 1f9:	6a 10                	push   $0x10
 1fb:	50                   	push   %eax
 1fc:	53                   	push   %ebx
 1fd:	e8 d0 03 00 00       	call   5d2 <read>
 202:	83 c4 10             	add    $0x10,%esp
 205:	83 f8 10             	cmp    $0x10,%eax
 208:	0f 85 7b ff ff ff    	jne    189 <ls+0x89>
      if(de.inum == 0)
 20e:	66 83 bd d8 fd ff ff 	cmpw   $0x0,-0x228(%ebp)
 215:	00 
 216:	74 d8                	je     1f0 <ls+0xf0>
      memmove(p, de.name, DIRSIZ);
 218:	83 ec 04             	sub    $0x4,%esp
 21b:	8d 85 da fd ff ff    	lea    -0x226(%ebp),%eax
 221:	6a 0e                	push   $0xe
 223:	50                   	push   %eax
 224:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
 22a:	e8 31 03 00 00       	call   560 <memmove>
      p[DIRSIZ] = 0;
 22f:	8b 85 b8 fd ff ff    	mov    -0x248(%ebp),%eax
 235:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 239:	58                   	pop    %eax
 23a:	5a                   	pop    %edx
 23b:	56                   	push   %esi
 23c:	57                   	push   %edi
 23d:	e8 8e 02 00 00       	call   4d0 <stat>
 242:	83 c4 10             	add    $0x10,%esp
 245:	85 c0                	test   %eax,%eax
 247:	0f 88 cb 00 00 00    	js     318 <ls+0x218>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 24d:	8b 8d d4 fd ff ff    	mov    -0x22c(%ebp),%ecx
 253:	8b 95 cc fd ff ff    	mov    -0x234(%ebp),%edx
 259:	83 ec 0c             	sub    $0xc,%esp
 25c:	0f bf 85 d0 fd ff ff 	movswl -0x230(%ebp),%eax
 263:	89 8d bc fd ff ff    	mov    %ecx,-0x244(%ebp)
 269:	89 95 c0 fd ff ff    	mov    %edx,-0x240(%ebp)
 26f:	89 85 c4 fd ff ff    	mov    %eax,-0x23c(%ebp)
 275:	57                   	push   %edi
 276:	e8 e5 fd ff ff       	call   60 <fmtname>
 27b:	5a                   	pop    %edx
 27c:	59                   	pop    %ecx
 27d:	8b 8d bc fd ff ff    	mov    -0x244(%ebp),%ecx
 283:	51                   	push   %ecx
 284:	8b 95 c0 fd ff ff    	mov    -0x240(%ebp),%edx
 28a:	52                   	push   %edx
 28b:	ff b5 c4 fd ff ff    	push   -0x23c(%ebp)
 291:	50                   	push   %eax
 292:	68 f0 0a 00 00       	push   $0xaf0
 297:	6a 01                	push   $0x1
 299:	e8 c2 04 00 00       	call   760 <printf>
 29e:	83 c4 20             	add    $0x20,%esp
 2a1:	e9 4a ff ff ff       	jmp    1f0 <ls+0xf0>
 2a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ad:	00 
 2ae:	66 90                	xchg   %ax,%ax
    printf(2, "ls: cannot open %s\n", path);
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	57                   	push   %edi
 2b4:	68 c8 0a 00 00       	push   $0xac8
 2b9:	6a 02                	push   $0x2
 2bb:	e8 a0 04 00 00       	call   760 <printf>
    return;
 2c0:	83 c4 10             	add    $0x10,%esp
}
 2c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret
 2cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      printf(1, "ls: path too long\n");
 2d0:	83 ec 08             	sub    $0x8,%esp
 2d3:	68 fd 0a 00 00       	push   $0xafd
 2d8:	6a 01                	push   $0x1
 2da:	e8 81 04 00 00       	call   760 <printf>
      break;
 2df:	83 c4 10             	add    $0x10,%esp
 2e2:	e9 a2 fe ff ff       	jmp    189 <ls+0x89>
 2e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ee:	00 
 2ef:	90                   	nop
    printf(2, "ls: cannot stat %s\n", path);
 2f0:	83 ec 04             	sub    $0x4,%esp
 2f3:	57                   	push   %edi
 2f4:	68 dc 0a 00 00       	push   $0xadc
 2f9:	6a 02                	push   $0x2
 2fb:	e8 60 04 00 00       	call   760 <printf>
    close(fd);
 300:	89 1c 24             	mov    %ebx,(%esp)
 303:	e8 4a 03 00 00       	call   652 <close>
    return;
 308:	83 c4 10             	add    $0x10,%esp
}
 30b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30e:	5b                   	pop    %ebx
 30f:	5e                   	pop    %esi
 310:	5f                   	pop    %edi
 311:	5d                   	pop    %ebp
 312:	c3                   	ret
 313:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 318:	83 ec 04             	sub    $0x4,%esp
 31b:	57                   	push   %edi
 31c:	68 dc 0a 00 00       	push   $0xadc
 321:	6a 01                	push   $0x1
 323:	e8 38 04 00 00       	call   760 <printf>
        continue;
 328:	83 c4 10             	add    $0x10,%esp
 32b:	e9 c0 fe ff ff       	jmp    1f0 <ls+0xf0>
 330:	66 90                	xchg   %ax,%ax
 332:	66 90                	xchg   %ax,%ax
 334:	66 90                	xchg   %ax,%ax
 336:	66 90                	xchg   %ax,%ax
 338:	66 90                	xchg   %ax,%ax
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 340:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
 341:	31 c0                	xor    %eax,%eax
{
 343:	89 e5                	mov    %esp,%ebp
 345:	53                   	push   %ebx
 346:	8b 4d 08             	mov    0x8(%ebp),%ecx
 349:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
 350:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 354:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 357:	83 c0 01             	add    $0x1,%eax
 35a:	84 d2                	test   %dl,%dl
 35c:	75 f2                	jne    350 <strcpy+0x10>
  return os;
}
 35e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 361:	89 c8                	mov    %ecx,%eax
 363:	c9                   	leave
 364:	c3                   	ret
 365:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 36c:	00 
 36d:	8d 76 00             	lea    0x0(%esi),%esi

00000370 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	8b 55 08             	mov    0x8(%ebp),%edx
 377:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 37a:	0f b6 02             	movzbl (%edx),%eax
 37d:	84 c0                	test   %al,%al
 37f:	75 2f                	jne    3b0 <strcmp+0x40>
 381:	eb 4a                	jmp    3cd <strcmp+0x5d>
 383:	eb 1b                	jmp    3a0 <strcmp+0x30>
 385:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 38c:	00 
 38d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 394:	00 
 395:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 39c:	00 
 39d:	8d 76 00             	lea    0x0(%esi),%esi
 3a0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 3a4:	83 c2 01             	add    $0x1,%edx
 3a7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 3aa:	84 c0                	test   %al,%al
 3ac:	74 12                	je     3c0 <strcmp+0x50>
 3ae:	89 d9                	mov    %ebx,%ecx
 3b0:	0f b6 19             	movzbl (%ecx),%ebx
 3b3:	38 c3                	cmp    %al,%bl
 3b5:	74 e9                	je     3a0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 3b7:	29 d8                	sub    %ebx,%eax
}
 3b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3bc:	c9                   	leave
 3bd:	c3                   	ret
 3be:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 3c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 3c4:	31 c0                	xor    %eax,%eax
 3c6:	29 d8                	sub    %ebx,%eax
}
 3c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3cb:	c9                   	leave
 3cc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 3cd:	0f b6 19             	movzbl (%ecx),%ebx
 3d0:	31 c0                	xor    %eax,%eax
 3d2:	eb e3                	jmp    3b7 <strcmp+0x47>
 3d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3db:	00 
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003e0 <strlen>:

uint
strlen(const char *s)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 3e6:	80 3a 00             	cmpb   $0x0,(%edx)
 3e9:	74 15                	je     400 <strlen+0x20>
 3eb:	31 c0                	xor    %eax,%eax
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	83 c0 01             	add    $0x1,%eax
 3f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 3f7:	89 c1                	mov    %eax,%ecx
 3f9:	75 f5                	jne    3f0 <strlen+0x10>
  return n;
}
 3fb:	89 c8                	mov    %ecx,%eax
 3fd:	5d                   	pop    %ebp
 3fe:	c3                   	ret
 3ff:	90                   	nop
  for(n = 0; s[n]; n++);
 400:	31 c9                	xor    %ecx,%ecx
}
 402:	5d                   	pop    %ebp
 403:	89 c8                	mov    %ecx,%eax
 405:	c3                   	ret
 406:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40d:	00 
 40e:	66 90                	xchg   %ax,%ax

00000410 <memset>:

void*
memset(void *dst, int c, uint n)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 417:	8b 4d 10             	mov    0x10(%ebp),%ecx
 41a:	8b 45 0c             	mov    0xc(%ebp),%eax
 41d:	89 d7                	mov    %edx,%edi
 41f:	fc                   	cld
 420:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 422:	8b 7d fc             	mov    -0x4(%ebp),%edi
 425:	89 d0                	mov    %edx,%eax
 427:	c9                   	leave
 428:	c3                   	ret
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000430 <strchr>:

char*
strchr(const char *s, char c)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 45 08             	mov    0x8(%ebp),%eax
 436:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 43a:	0f b6 10             	movzbl (%eax),%edx
 43d:	84 d2                	test   %dl,%dl
 43f:	75 1a                	jne    45b <strchr+0x2b>
 441:	eb 25                	jmp    468 <strchr+0x38>
 443:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 44a:	00 
 44b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 450:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 454:	83 c0 01             	add    $0x1,%eax
 457:	84 d2                	test   %dl,%dl
 459:	74 0d                	je     468 <strchr+0x38>
    if(*s == c)
 45b:	38 d1                	cmp    %dl,%cl
 45d:	75 f1                	jne    450 <strchr+0x20>
      return (char*)s;
  return 0;
}
 45f:	5d                   	pop    %ebp
 460:	c3                   	ret
 461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 468:	31 c0                	xor    %eax,%eax
}
 46a:	5d                   	pop    %ebp
 46b:	c3                   	ret
 46c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000470 <gets>:

char*
gets(char *buf, int max)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 475:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 478:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 479:	31 db                	xor    %ebx,%ebx
{
 47b:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 47e:	eb 27                	jmp    4a7 <gets+0x37>
    cc = read(0, &c, 1);
 480:	83 ec 04             	sub    $0x4,%esp
 483:	6a 01                	push   $0x1
 485:	56                   	push   %esi
 486:	6a 00                	push   $0x0
 488:	e8 45 01 00 00       	call   5d2 <read>
    if(cc < 1)
 48d:	83 c4 10             	add    $0x10,%esp
 490:	85 c0                	test   %eax,%eax
 492:	7e 1d                	jle    4b1 <gets+0x41>
      break;
    buf[i++] = c;
 494:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 498:	8b 55 08             	mov    0x8(%ebp),%edx
 49b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 49f:	3c 0a                	cmp    $0xa,%al
 4a1:	74 10                	je     4b3 <gets+0x43>
 4a3:	3c 0d                	cmp    $0xd,%al
 4a5:	74 0c                	je     4b3 <gets+0x43>
  for(i = 0; i+1 < max; ){
 4a7:	89 df                	mov    %ebx,%edi
 4a9:	83 c3 01             	add    $0x1,%ebx
 4ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4af:	7c cf                	jl     480 <gets+0x10>
 4b1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 4b3:	8b 45 08             	mov    0x8(%ebp),%eax
 4b6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 4ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4bd:	5b                   	pop    %ebx
 4be:	5e                   	pop    %esi
 4bf:	5f                   	pop    %edi
 4c0:	5d                   	pop    %ebp
 4c1:	c3                   	ret
 4c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4c9:	00 
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	56                   	push   %esi
 4d4:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 4d5:	83 ec 08             	sub    $0x8,%esp
 4d8:	6a 00                	push   $0x0
 4da:	ff 75 08             	push   0x8(%ebp)
 4dd:	e8 40 01 00 00       	call   622 <open>
  if(fd < 0)
 4e2:	83 c4 10             	add    $0x10,%esp
 4e5:	85 c0                	test   %eax,%eax
 4e7:	78 27                	js     510 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4e9:	83 ec 08             	sub    $0x8,%esp
 4ec:	ff 75 0c             	push   0xc(%ebp)
 4ef:	89 c3                	mov    %eax,%ebx
 4f1:	50                   	push   %eax
 4f2:	e8 f3 00 00 00       	call   5ea <fstat>
  close(fd);
 4f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4fa:	89 c6                	mov    %eax,%esi
  close(fd);
 4fc:	e8 51 01 00 00       	call   652 <close>
  return r;
 501:	83 c4 10             	add    $0x10,%esp
}
 504:	8d 65 f8             	lea    -0x8(%ebp),%esp
 507:	89 f0                	mov    %esi,%eax
 509:	5b                   	pop    %ebx
 50a:	5e                   	pop    %esi
 50b:	5d                   	pop    %ebp
 50c:	c3                   	ret
 50d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 510:	be ff ff ff ff       	mov    $0xffffffff,%esi
 515:	eb ed                	jmp    504 <stat+0x34>
 517:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51e:	00 
 51f:	90                   	nop

00000520 <atoi>:

int
atoi(const char *s)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	53                   	push   %ebx
 524:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 527:	0f be 02             	movsbl (%edx),%eax
 52a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 52d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 530:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 535:	77 1e                	ja     555 <atoi+0x35>
 537:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53e:	00 
 53f:	90                   	nop
    n = n*10 + *s++ - '0';
 540:	83 c2 01             	add    $0x1,%edx
 543:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 546:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 54a:	0f be 02             	movsbl (%edx),%eax
 54d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 550:	80 fb 09             	cmp    $0x9,%bl
 553:	76 eb                	jbe    540 <atoi+0x20>
  return n;
}
 555:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 558:	89 c8                	mov    %ecx,%eax
 55a:	c9                   	leave
 55b:	c3                   	ret
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000560 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	8b 55 08             	mov    0x8(%ebp),%edx
 567:	8b 45 10             	mov    0x10(%ebp),%eax
 56a:	56                   	push   %esi
 56b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 56e:	39 f2                	cmp    %esi,%edx
 570:	73 1e                	jae    590 <memmove+0x30>
    while(n-- > 0)
 572:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 575:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 577:	85 c0                	test   %eax,%eax
 579:	7e 0a                	jle    585 <memmove+0x25>
 57b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 580:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 581:	39 f9                	cmp    %edi,%ecx
 583:	75 fb                	jne    580 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 585:	5e                   	pop    %esi
 586:	89 d0                	mov    %edx,%eax
 588:	5f                   	pop    %edi
 589:	5d                   	pop    %ebp
 58a:	c3                   	ret
 58b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 590:	85 c0                	test   %eax,%eax
 592:	7e f1                	jle    585 <memmove+0x25>
    while(n-- > 0)
 594:	83 e8 01             	sub    $0x1,%eax
 597:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59e:	00 
 59f:	90                   	nop
      *--dst = *--src;
 5a0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 5a4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 5a7:	83 e8 01             	sub    $0x1,%eax
 5aa:	73 f4                	jae    5a0 <memmove+0x40>
}
 5ac:	5e                   	pop    %esi
 5ad:	89 d0                	mov    %edx,%eax
 5af:	5f                   	pop    %edi
 5b0:	5d                   	pop    %ebp
 5b1:	c3                   	ret

000005b2 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 5b2:	b8 01 00 00 00       	mov    $0x1,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret

000005ba <exit>:
SYSCALL(exit)
 5ba:	b8 02 00 00 00       	mov    $0x2,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret

000005c2 <wait>:
SYSCALL(wait)
 5c2:	b8 03 00 00 00       	mov    $0x3,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret

000005ca <pipe>:
SYSCALL(pipe)
 5ca:	b8 04 00 00 00       	mov    $0x4,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret

000005d2 <read>:
SYSCALL(read)
 5d2:	b8 05 00 00 00       	mov    $0x5,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret

000005da <kill>:
SYSCALL(kill)
 5da:	b8 06 00 00 00       	mov    $0x6,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret

000005e2 <exec>:
SYSCALL(exec)
 5e2:	b8 07 00 00 00       	mov    $0x7,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret

000005ea <fstat>:
SYSCALL(fstat)
 5ea:	b8 08 00 00 00       	mov    $0x8,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret

000005f2 <chdir>:
SYSCALL(chdir)
 5f2:	b8 09 00 00 00       	mov    $0x9,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret

000005fa <dup>:
SYSCALL(dup)
 5fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret

00000602 <getpid>:
SYSCALL(getpid)
 602:	b8 0b 00 00 00       	mov    $0xb,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret

0000060a <sbrk>:
SYSCALL(sbrk)
 60a:	b8 0c 00 00 00       	mov    $0xc,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret

00000612 <sleep>:
SYSCALL(sleep)
 612:	b8 0d 00 00 00       	mov    $0xd,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret

0000061a <uptime>:
SYSCALL(uptime)
 61a:	b8 0e 00 00 00       	mov    $0xe,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret

00000622 <open>:
SYSCALL(open)
 622:	b8 0f 00 00 00       	mov    $0xf,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret

0000062a <write>:
SYSCALL(write)
 62a:	b8 10 00 00 00       	mov    $0x10,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret

00000632 <mknod>:
SYSCALL(mknod)
 632:	b8 11 00 00 00       	mov    $0x11,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret

0000063a <unlink>:
SYSCALL(unlink)
 63a:	b8 12 00 00 00       	mov    $0x12,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret

00000642 <link>:
SYSCALL(link)
 642:	b8 13 00 00 00       	mov    $0x13,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret

0000064a <mkdir>:
SYSCALL(mkdir)
 64a:	b8 14 00 00 00       	mov    $0x14,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret

00000652 <close>:
SYSCALL(close)
 652:	b8 15 00 00 00       	mov    $0x15,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret

0000065a <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 65a:	b8 16 00 00 00       	mov    $0x16,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret

00000662 <settickets>:
SYSCALL(settickets)
 662:	b8 17 00 00 00       	mov    $0x17,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret

0000066a <getpinfo>:
SYSCALL(getpinfo)
 66a:	b8 18 00 00 00       	mov    $0x18,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret

00000672 <waitx>:
SYSCALL(waitx)
 672:	b8 19 00 00 00       	mov    $0x19,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret

0000067a <yield>:
SYSCALL(yield)
 67a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret
 682:	66 90                	xchg   %ax,%ax
 684:	66 90                	xchg   %ax,%ax
 686:	66 90                	xchg   %ax,%ax
 688:	66 90                	xchg   %ax,%ax
 68a:	66 90                	xchg   %ax,%ax
 68c:	66 90                	xchg   %ax,%ax
 68e:	66 90                	xchg   %ax,%ax
 690:	66 90                	xchg   %ax,%ax
 692:	66 90                	xchg   %ax,%ax
 694:	66 90                	xchg   %ax,%ax
 696:	66 90                	xchg   %ax,%ax
 698:	66 90                	xchg   %ax,%ax
 69a:	66 90                	xchg   %ax,%ax
 69c:	66 90                	xchg   %ax,%ax
 69e:	66 90                	xchg   %ax,%ax

000006a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6a8:	89 d1                	mov    %edx,%ecx
{
 6aa:	83 ec 3c             	sub    $0x3c,%esp
 6ad:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 6b0:	85 d2                	test   %edx,%edx
 6b2:	0f 89 98 00 00 00    	jns    750 <printint+0xb0>
 6b8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6bc:	0f 84 8e 00 00 00    	je     750 <printint+0xb0>
    x = -xx;
 6c2:	f7 d9                	neg    %ecx
    neg = 1;
 6c4:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 6c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6cc:	31 f6                	xor    %esi,%esi
 6ce:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6d5:	00 
 6d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6dd:	00 
 6de:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 6e0:	89 c8                	mov    %ecx,%eax
 6e2:	31 d2                	xor    %edx,%edx
 6e4:	89 f7                	mov    %esi,%edi
 6e6:	f7 f3                	div    %ebx
 6e8:	8d 76 01             	lea    0x1(%esi),%esi
 6eb:	0f b6 92 74 0b 00 00 	movzbl 0xb74(%edx),%edx
 6f2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 6f6:	89 ca                	mov    %ecx,%edx
 6f8:	89 c1                	mov    %eax,%ecx
 6fa:	39 da                	cmp    %ebx,%edx
 6fc:	73 e2                	jae    6e0 <printint+0x40>
  if(neg)
 6fe:	8b 45 c0             	mov    -0x40(%ebp),%eax
 701:	85 c0                	test   %eax,%eax
 703:	74 07                	je     70c <printint+0x6c>
    buf[i++] = '-';
 705:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 70a:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 70c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 70f:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 712:	01 df                	add    %ebx,%edi
 714:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 71b:	00 
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 720:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 723:	83 ec 04             	sub    $0x4,%esp
 726:	88 45 d7             	mov    %al,-0x29(%ebp)
 729:	8d 45 d7             	lea    -0x29(%ebp),%eax
 72c:	6a 01                	push   $0x1
 72e:	50                   	push   %eax
 72f:	56                   	push   %esi
 730:	e8 f5 fe ff ff       	call   62a <write>
  while(--i >= 0)
 735:	89 f8                	mov    %edi,%eax
 737:	83 c4 10             	add    $0x10,%esp
 73a:	83 ef 01             	sub    $0x1,%edi
 73d:	39 d8                	cmp    %ebx,%eax
 73f:	75 df                	jne    720 <printint+0x80>
}
 741:	8d 65 f4             	lea    -0xc(%ebp),%esp
 744:	5b                   	pop    %ebx
 745:	5e                   	pop    %esi
 746:	5f                   	pop    %edi
 747:	5d                   	pop    %ebp
 748:	c3                   	ret
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 750:	31 c0                	xor    %eax,%eax
 752:	e9 72 ff ff ff       	jmp    6c9 <printint+0x29>
 757:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 75e:	00 
 75f:	90                   	nop

00000760 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 769:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 76c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 76f:	0f b6 13             	movzbl (%ebx),%edx
 772:	83 c3 01             	add    $0x1,%ebx
 775:	84 d2                	test   %dl,%dl
 777:	0f 84 a0 00 00 00    	je     81d <printf+0xbd>
 77d:	8d 45 10             	lea    0x10(%ebp),%eax
 780:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 783:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 786:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 789:	eb 28                	jmp    7b3 <printf+0x53>
 78b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 790:	83 ec 04             	sub    $0x4,%esp
 793:	8d 45 e7             	lea    -0x19(%ebp),%eax
 796:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 799:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 79c:	6a 01                	push   $0x1
 79e:	50                   	push   %eax
 79f:	56                   	push   %esi
 7a0:	e8 85 fe ff ff       	call   62a <write>
  for(i = 0; fmt[i]; i++){
 7a5:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 7a9:	83 c4 10             	add    $0x10,%esp
 7ac:	84 d2                	test   %dl,%dl
 7ae:	74 6d                	je     81d <printf+0xbd>
    c = fmt[i] & 0xff;
 7b0:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 7b3:	83 f8 25             	cmp    $0x25,%eax
 7b6:	75 d8                	jne    790 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 7b8:	0f b6 13             	movzbl (%ebx),%edx
 7bb:	84 d2                	test   %dl,%dl
 7bd:	74 5e                	je     81d <printf+0xbd>
    c = fmt[i] & 0xff;
 7bf:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 7c2:	80 fa 25             	cmp    $0x25,%dl
 7c5:	0f 84 1d 01 00 00    	je     8e8 <printf+0x188>
 7cb:	83 e8 63             	sub    $0x63,%eax
 7ce:	83 f8 15             	cmp    $0x15,%eax
 7d1:	77 0d                	ja     7e0 <printf+0x80>
 7d3:	ff 24 85 1c 0b 00 00 	jmp    *0xb1c(,%eax,4)
 7da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7e0:	83 ec 04             	sub    $0x4,%esp
 7e3:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 7e6:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7e9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 7ed:	6a 01                	push   $0x1
 7ef:	51                   	push   %ecx
 7f0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 7f3:	56                   	push   %esi
 7f4:	e8 31 fe ff ff       	call   62a <write>
        putc(fd, c);
 7f9:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 7fd:	83 c4 0c             	add    $0xc,%esp
 800:	88 55 e7             	mov    %dl,-0x19(%ebp)
 803:	6a 01                	push   $0x1
 805:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 808:	51                   	push   %ecx
 809:	56                   	push   %esi
 80a:	e8 1b fe ff ff       	call   62a <write>
  for(i = 0; fmt[i]; i++){
 80f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 813:	83 c3 02             	add    $0x2,%ebx
 816:	83 c4 10             	add    $0x10,%esp
 819:	84 d2                	test   %dl,%dl
 81b:	75 93                	jne    7b0 <printf+0x50>
      }
      state = 0;
    }
  }
}
 81d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 820:	5b                   	pop    %ebx
 821:	5e                   	pop    %esi
 822:	5f                   	pop    %edi
 823:	5d                   	pop    %ebp
 824:	c3                   	ret
 825:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 828:	83 ec 0c             	sub    $0xc,%esp
 82b:	8b 17                	mov    (%edi),%edx
 82d:	b9 10 00 00 00       	mov    $0x10,%ecx
 832:	89 f0                	mov    %esi,%eax
 834:	6a 00                	push   $0x0
        ap++;
 836:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 839:	e8 62 fe ff ff       	call   6a0 <printint>
  for(i = 0; fmt[i]; i++){
 83e:	eb cf                	jmp    80f <printf+0xaf>
        s = (char*)*ap;
 840:	8b 07                	mov    (%edi),%eax
        ap++;
 842:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 845:	85 c0                	test   %eax,%eax
 847:	0f 84 b3 00 00 00    	je     900 <printf+0x1a0>
        while(*s != 0){
 84d:	0f b6 10             	movzbl (%eax),%edx
 850:	84 d2                	test   %dl,%dl
 852:	0f 84 ba 00 00 00    	je     912 <printf+0x1b2>
 858:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 85b:	89 c7                	mov    %eax,%edi
 85d:	89 d0                	mov    %edx,%eax
 85f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 862:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 865:	89 fb                	mov    %edi,%ebx
 867:	89 cf                	mov    %ecx,%edi
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 870:	83 ec 04             	sub    $0x4,%esp
 873:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 876:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 879:	6a 01                	push   $0x1
 87b:	57                   	push   %edi
 87c:	56                   	push   %esi
 87d:	e8 a8 fd ff ff       	call   62a <write>
        while(*s != 0){
 882:	0f b6 03             	movzbl (%ebx),%eax
 885:	83 c4 10             	add    $0x10,%esp
 888:	84 c0                	test   %al,%al
 88a:	75 e4                	jne    870 <printf+0x110>
 88c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 88f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 893:	83 c3 02             	add    $0x2,%ebx
 896:	84 d2                	test   %dl,%dl
 898:	0f 85 e5 fe ff ff    	jne    783 <printf+0x23>
 89e:	e9 7a ff ff ff       	jmp    81d <printf+0xbd>
 8a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 8a8:	83 ec 0c             	sub    $0xc,%esp
 8ab:	8b 17                	mov    (%edi),%edx
 8ad:	b9 0a 00 00 00       	mov    $0xa,%ecx
 8b2:	89 f0                	mov    %esi,%eax
 8b4:	6a 01                	push   $0x1
        ap++;
 8b6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 8b9:	e8 e2 fd ff ff       	call   6a0 <printint>
  for(i = 0; fmt[i]; i++){
 8be:	e9 4c ff ff ff       	jmp    80f <printf+0xaf>
 8c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 8c8:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 8ca:	83 ec 04             	sub    $0x4,%esp
 8cd:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 8d0:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 8d3:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8d6:	6a 01                	push   $0x1
 8d8:	51                   	push   %ecx
 8d9:	56                   	push   %esi
 8da:	e8 4b fd ff ff       	call   62a <write>
  for(i = 0; fmt[i]; i++){
 8df:	e9 2b ff ff ff       	jmp    80f <printf+0xaf>
 8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 8e8:	83 ec 04             	sub    $0x4,%esp
 8eb:	88 55 e7             	mov    %dl,-0x19(%ebp)
 8ee:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 8f1:	6a 01                	push   $0x1
 8f3:	e9 10 ff ff ff       	jmp    808 <printf+0xa8>
 8f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8ff:	00 
          s = "(null)";
 900:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 903:	b8 28 00 00 00       	mov    $0x28,%eax
 908:	bf 12 0b 00 00       	mov    $0xb12,%edi
 90d:	e9 4d ff ff ff       	jmp    85f <printf+0xff>
  for(i = 0; fmt[i]; i++){
 912:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 916:	83 c3 02             	add    $0x2,%ebx
 919:	84 d2                	test   %dl,%dl
 91b:	0f 85 8f fe ff ff    	jne    7b0 <printf+0x50>
 921:	e9 f7 fe ff ff       	jmp    81d <printf+0xbd>
 926:	66 90                	xchg   %ax,%ax
 928:	66 90                	xchg   %ax,%ax
 92a:	66 90                	xchg   %ax,%ax
 92c:	66 90                	xchg   %ax,%ax
 92e:	66 90                	xchg   %ax,%ax
 930:	66 90                	xchg   %ax,%ax
 932:	66 90                	xchg   %ax,%ax
 934:	66 90                	xchg   %ax,%ax
 936:	66 90                	xchg   %ax,%ax
 938:	66 90                	xchg   %ax,%ax
 93a:	66 90                	xchg   %ax,%ax
 93c:	66 90                	xchg   %ax,%ax
 93e:	66 90                	xchg   %ax,%ax

00000940 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 940:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 941:	a1 b4 0e 00 00       	mov    0xeb4,%eax
{
 946:	89 e5                	mov    %esp,%ebp
 948:	57                   	push   %edi
 949:	56                   	push   %esi
 94a:	53                   	push   %ebx
 94b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 94e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 951:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 958:	00 
 959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 960:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 962:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 964:	39 ca                	cmp    %ecx,%edx
 966:	73 30                	jae    998 <free+0x58>
 968:	39 c1                	cmp    %eax,%ecx
 96a:	72 04                	jb     970 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 96c:	39 c2                	cmp    %eax,%edx
 96e:	72 f0                	jb     960 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 970:	8b 73 fc             	mov    -0x4(%ebx),%esi
 973:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 976:	39 f8                	cmp    %edi,%eax
 978:	74 36                	je     9b0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 97a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 97d:	8b 42 04             	mov    0x4(%edx),%eax
 980:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 983:	39 f1                	cmp    %esi,%ecx
 985:	74 40                	je     9c7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 987:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 989:	5b                   	pop    %ebx
  freep = p;
 98a:	89 15 b4 0e 00 00    	mov    %edx,0xeb4
}
 990:	5e                   	pop    %esi
 991:	5f                   	pop    %edi
 992:	5d                   	pop    %ebp
 993:	c3                   	ret
 994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 998:	39 c2                	cmp    %eax,%edx
 99a:	72 c4                	jb     960 <free+0x20>
 99c:	39 c1                	cmp    %eax,%ecx
 99e:	73 c0                	jae    960 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 9a0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9a3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9a6:	39 f8                	cmp    %edi,%eax
 9a8:	75 d0                	jne    97a <free+0x3a>
 9aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 9b0:	03 70 04             	add    0x4(%eax),%esi
 9b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9b6:	8b 02                	mov    (%edx),%eax
 9b8:	8b 00                	mov    (%eax),%eax
 9ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 9bd:	8b 42 04             	mov    0x4(%edx),%eax
 9c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 9c3:	39 f1                	cmp    %esi,%ecx
 9c5:	75 c0                	jne    987 <free+0x47>
    p->s.size += bp->s.size;
 9c7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 9ca:	89 15 b4 0e 00 00    	mov    %edx,0xeb4
    p->s.size += bp->s.size;
 9d0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 9d3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 9d6:	89 0a                	mov    %ecx,(%edx)
}
 9d8:	5b                   	pop    %ebx
 9d9:	5e                   	pop    %esi
 9da:	5f                   	pop    %edi
 9db:	5d                   	pop    %ebp
 9dc:	c3                   	ret
 9dd:	8d 76 00             	lea    0x0(%esi),%esi

000009e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	57                   	push   %edi
 9e4:	56                   	push   %esi
 9e5:	53                   	push   %ebx
 9e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9ec:	8b 15 b4 0e 00 00    	mov    0xeb4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f2:	8d 78 07             	lea    0x7(%eax),%edi
 9f5:	c1 ef 03             	shr    $0x3,%edi
 9f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 9fb:	85 d2                	test   %edx,%edx
 9fd:	0f 84 8d 00 00 00    	je     a90 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a03:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a05:	8b 48 04             	mov    0x4(%eax),%ecx
 a08:	39 f9                	cmp    %edi,%ecx
 a0a:	73 64                	jae    a70 <malloc+0x90>
  if(nu < 4096)
 a0c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a11:	39 df                	cmp    %ebx,%edi
 a13:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a16:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a1d:	eb 0a                	jmp    a29 <malloc+0x49>
 a1f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a20:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a22:	8b 48 04             	mov    0x4(%eax),%ecx
 a25:	39 f9                	cmp    %edi,%ecx
 a27:	73 47                	jae    a70 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a29:	89 c2                	mov    %eax,%edx
 a2b:	39 05 b4 0e 00 00    	cmp    %eax,0xeb4
 a31:	75 ed                	jne    a20 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 a33:	83 ec 0c             	sub    $0xc,%esp
 a36:	56                   	push   %esi
 a37:	e8 ce fb ff ff       	call   60a <sbrk>
  if(p == (char*)-1)
 a3c:	83 c4 10             	add    $0x10,%esp
 a3f:	83 f8 ff             	cmp    $0xffffffff,%eax
 a42:	74 1c                	je     a60 <malloc+0x80>
  hp->s.size = nu;
 a44:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a47:	83 ec 0c             	sub    $0xc,%esp
 a4a:	83 c0 08             	add    $0x8,%eax
 a4d:	50                   	push   %eax
 a4e:	e8 ed fe ff ff       	call   940 <free>
  return freep;
 a53:	8b 15 b4 0e 00 00    	mov    0xeb4,%edx
      if((p = morecore(nunits)) == 0)
 a59:	83 c4 10             	add    $0x10,%esp
 a5c:	85 d2                	test   %edx,%edx
 a5e:	75 c0                	jne    a20 <malloc+0x40>
        return 0;
  }
}
 a60:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a63:	31 c0                	xor    %eax,%eax
}
 a65:	5b                   	pop    %ebx
 a66:	5e                   	pop    %esi
 a67:	5f                   	pop    %edi
 a68:	5d                   	pop    %ebp
 a69:	c3                   	ret
 a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a70:	39 cf                	cmp    %ecx,%edi
 a72:	74 4c                	je     ac0 <malloc+0xe0>
        p->s.size -= nunits;
 a74:	29 f9                	sub    %edi,%ecx
 a76:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a79:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a7c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a7f:	89 15 b4 0e 00 00    	mov    %edx,0xeb4
}
 a85:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 a88:	83 c0 08             	add    $0x8,%eax
}
 a8b:	5b                   	pop    %ebx
 a8c:	5e                   	pop    %esi
 a8d:	5f                   	pop    %edi
 a8e:	5d                   	pop    %ebp
 a8f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 a90:	c7 05 b4 0e 00 00 b8 	movl   $0xeb8,0xeb4
 a97:	0e 00 00 
    base.s.size = 0;
 a9a:	b8 b8 0e 00 00       	mov    $0xeb8,%eax
    base.s.ptr = freep = prevp = &base;
 a9f:	c7 05 b8 0e 00 00 b8 	movl   $0xeb8,0xeb8
 aa6:	0e 00 00 
    base.s.size = 0;
 aa9:	c7 05 bc 0e 00 00 00 	movl   $0x0,0xebc
 ab0:	00 00 00 
    if(p->s.size >= nunits){
 ab3:	e9 54 ff ff ff       	jmp    a0c <malloc+0x2c>
 ab8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 abf:	00 
        prevp->s.ptr = p->s.ptr;
 ac0:	8b 08                	mov    (%eax),%ecx
 ac2:	89 0a                	mov    %ecx,(%edx)
 ac4:	eb b9                	jmp    a7f <malloc+0x9f>
