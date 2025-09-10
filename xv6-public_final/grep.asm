
_grep:     file format elf32-i386


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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	7e 6f                	jle    90 <main+0x90>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  21:	8b 43 04             	mov    0x4(%ebx),%eax
  24:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  27:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  2b:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
  30:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  33:	74 6e                	je     a3 <main+0xa3>
  35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  3c:	00 
  3d:	8d 76 00             	lea    0x0(%esi),%esi
    if((fd = open(argv[i], 0)) < 0){
  40:	83 ec 08             	sub    $0x8,%esp
  43:	6a 00                	push   $0x0
  45:	ff 33                	push   (%ebx)
  47:	e8 56 06 00 00       	call   6a2 <open>
  4c:	83 c4 10             	add    $0x10,%esp
  4f:	89 c7                	mov    %eax,%edi
  51:	85 c0                	test   %eax,%eax
  53:	78 27                	js     7c <main+0x7c>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  55:	83 ec 08             	sub    $0x8,%esp
  for(i = 2; i < argc; i++){
  58:	83 c6 01             	add    $0x1,%esi
  5b:	83 c3 04             	add    $0x4,%ebx
    grep(pattern, fd);
  5e:	50                   	push   %eax
  5f:	ff 75 e0             	push   -0x20(%ebp)
  62:	e8 a9 01 00 00       	call   210 <grep>
    close(fd);
  67:	89 3c 24             	mov    %edi,(%esp)
  6a:	e8 63 06 00 00       	call   6d2 <close>
  for(i = 2; i < argc; i++){
  6f:	83 c4 10             	add    $0x10,%esp
  72:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  75:	7f c9                	jg     40 <main+0x40>
  }
  exit();
  77:	e8 be 05 00 00       	call   63a <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
  7c:	50                   	push   %eax
  7d:	ff 33                	push   (%ebx)
  7f:	68 68 0b 00 00       	push   $0xb68
  84:	6a 01                	push   $0x1
  86:	e8 55 07 00 00       	call   7e0 <printf>
      exit();
  8b:	e8 aa 05 00 00       	call   63a <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  90:	51                   	push   %ecx
  91:	51                   	push   %ecx
  92:	68 48 0b 00 00       	push   $0xb48
  97:	6a 02                	push   $0x2
  99:	e8 42 07 00 00       	call   7e0 <printf>
    exit();
  9e:	e8 97 05 00 00       	call   63a <exit>
    grep(pattern, 0);
  a3:	52                   	push   %edx
  a4:	52                   	push   %edx
  a5:	6a 00                	push   $0x0
  a7:	50                   	push   %eax
  a8:	e8 63 01 00 00       	call   210 <grep>
    exit();
  ad:	e8 88 05 00 00       	call   63a <exit>
  b2:	66 90                	xchg   %ax,%ax
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 1c             	sub    $0x1c,%esp
  c9:	8b 75 08             	mov    0x8(%ebp),%esi
  cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '\0')
  cf:	0f b6 16             	movzbl (%esi),%edx
  d2:	84 d2                	test   %dl,%dl
  d4:	0f 84 a6 00 00 00    	je     180 <matchhere+0xc0>
    return 1;
  if(re[1] == '*')
  da:	0f b6 46 01          	movzbl 0x1(%esi),%eax
  de:	3c 2a                	cmp    $0x2a,%al
  e0:	74 3f                	je     121 <matchhere+0x61>
  e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  e9:	00 
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  f0:	0f b6 0b             	movzbl (%ebx),%ecx
  if(re[0] == '$' && re[1] == '\0')
  f3:	80 fa 24             	cmp    $0x24,%dl
  f6:	74 68                	je     160 <matchhere+0xa0>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  f8:	84 c9                	test   %cl,%cl
  fa:	0f 84 90 00 00 00    	je     190 <matchhere+0xd0>
 100:	80 fa 2e             	cmp    $0x2e,%dl
 103:	74 08                	je     10d <matchhere+0x4d>
 105:	38 d1                	cmp    %dl,%cl
 107:	0f 85 83 00 00 00    	jne    190 <matchhere+0xd0>
    return matchhere(re+1, text+1);
 10d:	83 c3 01             	add    $0x1,%ebx
 110:	83 c6 01             	add    $0x1,%esi
  if(re[0] == '\0')
 113:	84 c0                	test   %al,%al
 115:	74 69                	je     180 <matchhere+0xc0>
{
 117:	89 c2                	mov    %eax,%edx
  if(re[1] == '*')
 119:	0f b6 46 01          	movzbl 0x1(%esi),%eax
 11d:	3c 2a                	cmp    $0x2a,%al
 11f:	75 cf                	jne    f0 <matchhere+0x30>
    return matchstar(re[0], re+2, text);
 121:	83 c6 02             	add    $0x2,%esi
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
 124:	80 fa 2e             	cmp    $0x2e,%dl
 127:	0f 94 c0             	sete   %al
 12a:	89 c7                	mov    %eax,%edi
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(matchhere(re, text))
 130:	83 ec 08             	sub    $0x8,%esp
 133:	88 55 e7             	mov    %dl,-0x19(%ebp)
 136:	53                   	push   %ebx
 137:	56                   	push   %esi
 138:	e8 83 ff ff ff       	call   c0 <matchhere>
 13d:	83 c4 10             	add    $0x10,%esp
 140:	85 c0                	test   %eax,%eax
 142:	75 41                	jne    185 <matchhere+0xc5>
  }while(*text!='\0' && (*text++==c || c=='.'));
 144:	0f b6 0b             	movzbl (%ebx),%ecx
 147:	84 c9                	test   %cl,%cl
 149:	74 3a                	je     185 <matchhere+0xc5>
 14b:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
 14f:	83 c3 01             	add    $0x1,%ebx
 152:	38 d1                	cmp    %dl,%cl
 154:	74 da                	je     130 <matchhere+0x70>
 156:	89 f9                	mov    %edi,%ecx
 158:	84 c9                	test   %cl,%cl
 15a:	75 d4                	jne    130 <matchhere+0x70>
 15c:	eb 27                	jmp    185 <matchhere+0xc5>
 15e:	66 90                	xchg   %ax,%ax
  if(re[0] == '$' && re[1] == '\0')
 160:	84 c0                	test   %al,%al
 162:	74 36                	je     19a <matchhere+0xda>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 164:	84 c9                	test   %cl,%cl
 166:	74 28                	je     190 <matchhere+0xd0>
 168:	80 f9 24             	cmp    $0x24,%cl
 16b:	75 23                	jne    190 <matchhere+0xd0>
    return matchhere(re+1, text+1);
 16d:	83 c3 01             	add    $0x1,%ebx
 170:	83 c6 01             	add    $0x1,%esi
{
 173:	89 c2                	mov    %eax,%edx
 175:	eb a2                	jmp    119 <matchhere+0x59>
 177:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17e:	00 
 17f:	90                   	nop
    return 1;
 180:	b8 01 00 00 00       	mov    $0x1,%eax
}
 185:	8d 65 f4             	lea    -0xc(%ebp),%esp
 188:	5b                   	pop    %ebx
 189:	5e                   	pop    %esi
 18a:	5f                   	pop    %edi
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
 193:	31 c0                	xor    %eax,%eax
}
 195:	5b                   	pop    %ebx
 196:	5e                   	pop    %esi
 197:	5f                   	pop    %edi
 198:	5d                   	pop    %ebp
 199:	c3                   	ret
    return *text == '\0';
 19a:	31 c0                	xor    %eax,%eax
 19c:	84 c9                	test   %cl,%cl
 19e:	0f 94 c0             	sete   %al
 1a1:	eb e2                	jmp    185 <matchhere+0xc5>
 1a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1aa:	00 
 1ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

000001b0 <match>:
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
 1b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '^')
 1bb:	80 3b 5e             	cmpb   $0x5e,(%ebx)
 1be:	75 11                	jne    1d1 <match+0x21>
 1c0:	eb 2e                	jmp    1f0 <match+0x40>
 1c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1c8:	83 c6 01             	add    $0x1,%esi
 1cb:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 1cf:	74 11                	je     1e2 <match+0x32>
    if(matchhere(re, text))
 1d1:	83 ec 08             	sub    $0x8,%esp
 1d4:	56                   	push   %esi
 1d5:	53                   	push   %ebx
 1d6:	e8 e5 fe ff ff       	call   c0 <matchhere>
 1db:	83 c4 10             	add    $0x10,%esp
 1de:	85 c0                	test   %eax,%eax
 1e0:	74 e6                	je     1c8 <match+0x18>
}
 1e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e5:	5b                   	pop    %ebx
 1e6:	5e                   	pop    %esi
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return matchhere(re+1, text);
 1f0:	83 c3 01             	add    $0x1,%ebx
 1f3:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 1f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1f9:	5b                   	pop    %ebx
 1fa:	5e                   	pop    %esi
 1fb:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 1fc:	e9 bf fe ff ff       	jmp    c0 <matchhere>
 201:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 208:	00 
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000210 <grep>:
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
  m = 0;
 214:	31 ff                	xor    %edi,%edi
{
 216:	56                   	push   %esi
 217:	53                   	push   %ebx
 218:	83 ec 1c             	sub    $0x1c,%esp
 21b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 21e:	89 7d e0             	mov    %edi,-0x20(%ebp)
    return matchhere(re+1, text);
 221:	8d 43 01             	lea    0x1(%ebx),%eax
 224:	89 45 dc             	mov    %eax,-0x24(%ebp)
 227:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22e:	00 
 22f:	90                   	nop
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 230:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 233:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 238:	83 ec 04             	sub    $0x4,%esp
 23b:	29 c8                	sub    %ecx,%eax
 23d:	50                   	push   %eax
 23e:	8d 81 80 0f 00 00    	lea    0xf80(%ecx),%eax
 244:	50                   	push   %eax
 245:	ff 75 0c             	push   0xc(%ebp)
 248:	e8 05 04 00 00       	call   652 <read>
 24d:	83 c4 10             	add    $0x10,%esp
 250:	85 c0                	test   %eax,%eax
 252:	0f 8e fd 00 00 00    	jle    355 <grep+0x145>
    m += n;
 258:	01 45 e0             	add    %eax,-0x20(%ebp)
 25b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    buf[m] = '\0';
 25e:	bf 80 0f 00 00       	mov    $0xf80,%edi
 263:	89 de                	mov    %ebx,%esi
 265:	c6 81 80 0f 00 00 00 	movb   $0x0,0xf80(%ecx)
    while((q = strchr(p, '\n')) != 0){
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 270:	83 ec 08             	sub    $0x8,%esp
 273:	6a 0a                	push   $0xa
 275:	57                   	push   %edi
 276:	e8 35 02 00 00       	call   4b0 <strchr>
 27b:	83 c4 10             	add    $0x10,%esp
 27e:	89 c2                	mov    %eax,%edx
 280:	85 c0                	test   %eax,%eax
 282:	0f 84 88 00 00 00    	je     310 <grep+0x100>
      *q = 0;
 288:	c6 02 00             	movb   $0x0,(%edx)
  if(re[0] == '^')
 28b:	80 3e 5e             	cmpb   $0x5e,(%esi)
 28e:	74 58                	je     2e8 <grep+0xd8>
 290:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 293:	89 d3                	mov    %edx,%ebx
 295:	eb 12                	jmp    2a9 <grep+0x99>
 297:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29e:	00 
 29f:	90                   	nop
  }while(*text++ != '\0');
 2a0:	83 c7 01             	add    $0x1,%edi
 2a3:	80 7f ff 00          	cmpb   $0x0,-0x1(%edi)
 2a7:	74 37                	je     2e0 <grep+0xd0>
    if(matchhere(re, text))
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	57                   	push   %edi
 2ad:	56                   	push   %esi
 2ae:	e8 0d fe ff ff       	call   c0 <matchhere>
 2b3:	83 c4 10             	add    $0x10,%esp
 2b6:	85 c0                	test   %eax,%eax
 2b8:	74 e6                	je     2a0 <grep+0x90>
        write(1, p, q+1 - p);
 2ba:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2bd:	89 da                	mov    %ebx,%edx
 2bf:	8d 5b 01             	lea    0x1(%ebx),%ebx
 2c2:	89 d8                	mov    %ebx,%eax
 2c4:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
 2c7:	c6 02 0a             	movb   $0xa,(%edx)
        write(1, p, q+1 - p);
 2ca:	29 f8                	sub    %edi,%eax
 2cc:	50                   	push   %eax
 2cd:	57                   	push   %edi
 2ce:	89 df                	mov    %ebx,%edi
 2d0:	6a 01                	push   $0x1
 2d2:	e8 d3 03 00 00       	call   6aa <write>
 2d7:	83 c4 10             	add    $0x10,%esp
 2da:	eb 94                	jmp    270 <grep+0x60>
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2e0:	8d 7b 01             	lea    0x1(%ebx),%edi
      p = q+1;
 2e3:	eb 8b                	jmp    270 <grep+0x60>
 2e5:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
 2e8:	83 ec 08             	sub    $0x8,%esp
 2eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 2ee:	57                   	push   %edi
 2ef:	ff 75 dc             	push   -0x24(%ebp)
 2f2:	e8 c9 fd ff ff       	call   c0 <matchhere>
        write(1, p, q+1 - p);
 2f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return matchhere(re+1, text);
 2fa:	83 c4 10             	add    $0x10,%esp
        write(1, p, q+1 - p);
 2fd:	8d 5a 01             	lea    0x1(%edx),%ebx
      if(match(pattern, p)){
 300:	85 c0                	test   %eax,%eax
 302:	75 be                	jne    2c2 <grep+0xb2>
        write(1, p, q+1 - p);
 304:	89 df                	mov    %ebx,%edi
 306:	e9 65 ff ff ff       	jmp    270 <grep+0x60>
 30b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p == buf)
 310:	89 f3                	mov    %esi,%ebx
 312:	81 ff 80 0f 00 00    	cmp    $0xf80,%edi
 318:	74 2f                	je     349 <grep+0x139>
    if(m > 0){
 31a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 31d:	85 c0                	test   %eax,%eax
 31f:	0f 8e 0b ff ff ff    	jle    230 <grep+0x20>
      m -= p - buf;
 325:	89 f8                	mov    %edi,%eax
      memmove(buf, p, m);
 327:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 32a:	2d 80 0f 00 00       	sub    $0xf80,%eax
 32f:	29 45 e0             	sub    %eax,-0x20(%ebp)
 332:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      memmove(buf, p, m);
 335:	51                   	push   %ecx
 336:	57                   	push   %edi
 337:	68 80 0f 00 00       	push   $0xf80
 33c:	e8 9f 02 00 00       	call   5e0 <memmove>
 341:	83 c4 10             	add    $0x10,%esp
 344:	e9 e7 fe ff ff       	jmp    230 <grep+0x20>
      m = 0;
 349:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 350:	e9 db fe ff ff       	jmp    230 <grep+0x20>
}
 355:	8d 65 f4             	lea    -0xc(%ebp),%esp
 358:	5b                   	pop    %ebx
 359:	5e                   	pop    %esi
 35a:	5f                   	pop    %edi
 35b:	5d                   	pop    %ebp
 35c:	c3                   	ret
 35d:	8d 76 00             	lea    0x0(%esi),%esi

00000360 <matchstar>:
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	83 ec 1c             	sub    $0x1c,%esp
 369:	8b 5d 08             	mov    0x8(%ebp),%ebx
 36c:	8b 75 0c             	mov    0xc(%ebp),%esi
 36f:	8b 7d 10             	mov    0x10(%ebp),%edi
  }while(*text!='\0' && (*text++==c || c=='.'));
 372:	83 fb 2e             	cmp    $0x2e,%ebx
 375:	0f 94 45 e7          	sete   -0x19(%ebp)
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(matchhere(re, text))
 380:	83 ec 08             	sub    $0x8,%esp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	e8 36 fd ff ff       	call   c0 <matchhere>
 38a:	83 c4 10             	add    $0x10,%esp
 38d:	89 c1                	mov    %eax,%ecx
 38f:	85 c0                	test   %eax,%eax
 391:	75 14                	jne    3a7 <matchstar+0x47>
  }while(*text!='\0' && (*text++==c || c=='.'));
 393:	0f be 07             	movsbl (%edi),%eax
 396:	84 c0                	test   %al,%al
 398:	74 0d                	je     3a7 <matchstar+0x47>
 39a:	83 c7 01             	add    $0x1,%edi
 39d:	39 d8                	cmp    %ebx,%eax
 39f:	74 df                	je     380 <matchstar+0x20>
 3a1:	80 7d e7 00          	cmpb   $0x0,-0x19(%ebp)
 3a5:	75 d9                	jne    380 <matchstar+0x20>
}
 3a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3aa:	89 c8                	mov    %ecx,%eax
 3ac:	5b                   	pop    %ebx
 3ad:	5e                   	pop    %esi
 3ae:	5f                   	pop    %edi
 3af:	5d                   	pop    %ebp
 3b0:	c3                   	ret
 3b1:	66 90                	xchg   %ax,%ax
 3b3:	66 90                	xchg   %ax,%ax
 3b5:	66 90                	xchg   %ax,%ax
 3b7:	66 90                	xchg   %ax,%ax
 3b9:	66 90                	xchg   %ax,%ax
 3bb:	66 90                	xchg   %ax,%ax
 3bd:	66 90                	xchg   %ax,%ax
 3bf:	90                   	nop

000003c0 <strcpy>:
#include "fcntl.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 3c0:	55                   	push   %ebp
  char *os = s;
  while((*s++ = *t++) != 0);
 3c1:	31 c0                	xor    %eax,%eax
{
 3c3:	89 e5                	mov    %esp,%ebp
 3c5:	53                   	push   %ebx
 3c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0);
 3d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 3d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 3d7:	83 c0 01             	add    $0x1,%eax
 3da:	84 d2                	test   %dl,%dl
 3dc:	75 f2                	jne    3d0 <strcpy+0x10>
  return os;
}
 3de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3e1:	89 c8                	mov    %ecx,%eax
 3e3:	c9                   	leave
 3e4:	c3                   	ret
 3e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ec:	00 
 3ed:	8d 76 00             	lea    0x0(%esi),%esi

000003f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	53                   	push   %ebx
 3f4:	8b 55 08             	mov    0x8(%ebp),%edx
 3f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 3fa:	0f b6 02             	movzbl (%edx),%eax
 3fd:	84 c0                	test   %al,%al
 3ff:	75 2f                	jne    430 <strcmp+0x40>
 401:	eb 4a                	jmp    44d <strcmp+0x5d>
 403:	eb 1b                	jmp    420 <strcmp+0x30>
 405:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40c:	00 
 40d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 414:	00 
 415:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41c:	00 
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 424:	83 c2 01             	add    $0x1,%edx
 427:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 42a:	84 c0                	test   %al,%al
 42c:	74 12                	je     440 <strcmp+0x50>
 42e:	89 d9                	mov    %ebx,%ecx
 430:	0f b6 19             	movzbl (%ecx),%ebx
 433:	38 c3                	cmp    %al,%bl
 435:	74 e9                	je     420 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 437:	29 d8                	sub    %ebx,%eax
}
 439:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 43c:	c9                   	leave
 43d:	c3                   	ret
 43e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 440:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 444:	31 c0                	xor    %eax,%eax
 446:	29 d8                	sub    %ebx,%eax
}
 448:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 44b:	c9                   	leave
 44c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 44d:	0f b6 19             	movzbl (%ecx),%ebx
 450:	31 c0                	xor    %eax,%eax
 452:	eb e3                	jmp    437 <strcmp+0x47>
 454:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45b:	00 
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000460 <strlen>:

uint
strlen(const char *s)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;
  for(n = 0; s[n]; n++);
 466:	80 3a 00             	cmpb   $0x0,(%edx)
 469:	74 15                	je     480 <strlen+0x20>
 46b:	31 c0                	xor    %eax,%eax
 46d:	8d 76 00             	lea    0x0(%esi),%esi
 470:	83 c0 01             	add    $0x1,%eax
 473:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 477:	89 c1                	mov    %eax,%ecx
 479:	75 f5                	jne    470 <strlen+0x10>
  return n;
}
 47b:	89 c8                	mov    %ecx,%eax
 47d:	5d                   	pop    %ebp
 47e:	c3                   	ret
 47f:	90                   	nop
  for(n = 0; s[n]; n++);
 480:	31 c9                	xor    %ecx,%ecx
}
 482:	5d                   	pop    %ebp
 483:	89 c8                	mov    %ecx,%eax
 485:	c3                   	ret
 486:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 48d:	00 
 48e:	66 90                	xchg   %ax,%ax

00000490 <memset>:

void*
memset(void *dst, int c, uint n)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	8b 55 08             	mov    0x8(%ebp),%edx

// String operations
static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 497:	8b 4d 10             	mov    0x10(%ebp),%ecx
 49a:	8b 45 0c             	mov    0xc(%ebp),%eax
 49d:	89 d7                	mov    %edx,%edi
 49f:	fc                   	cld
 4a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 4a2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 4a5:	89 d0                	mov    %edx,%eax
 4a7:	c9                   	leave
 4a8:	c3                   	ret
 4a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004b0 <strchr>:

char*
strchr(const char *s, char c)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	8b 45 08             	mov    0x8(%ebp),%eax
 4b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 4ba:	0f b6 10             	movzbl (%eax),%edx
 4bd:	84 d2                	test   %dl,%dl
 4bf:	75 1a                	jne    4db <strchr+0x2b>
 4c1:	eb 25                	jmp    4e8 <strchr+0x38>
 4c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ca:	00 
 4cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4d0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 4d4:	83 c0 01             	add    $0x1,%eax
 4d7:	84 d2                	test   %dl,%dl
 4d9:	74 0d                	je     4e8 <strchr+0x38>
    if(*s == c)
 4db:	38 d1                	cmp    %dl,%cl
 4dd:	75 f1                	jne    4d0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 4df:	5d                   	pop    %ebp
 4e0:	c3                   	ret
 4e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 4e8:	31 c0                	xor    %eax,%eax
}
 4ea:	5d                   	pop    %ebp
 4eb:	c3                   	ret
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004f0 <gets>:

char*
gets(char *buf, int max)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i = 0; i+1 < max; ){
    cc = read(0, &c, 1);
 4f5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 4f8:	53                   	push   %ebx
  for(i = 0; i+1 < max; ){
 4f9:	31 db                	xor    %ebx,%ebx
{
 4fb:	83 ec 1c             	sub    $0x1c,%esp
  for(i = 0; i+1 < max; ){
 4fe:	eb 27                	jmp    527 <gets+0x37>
    cc = read(0, &c, 1);
 500:	83 ec 04             	sub    $0x4,%esp
 503:	6a 01                	push   $0x1
 505:	56                   	push   %esi
 506:	6a 00                	push   $0x0
 508:	e8 45 01 00 00       	call   652 <read>
    if(cc < 1)
 50d:	83 c4 10             	add    $0x10,%esp
 510:	85 c0                	test   %eax,%eax
 512:	7e 1d                	jle    531 <gets+0x41>
      break;
    buf[i++] = c;
 514:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 518:	8b 55 08             	mov    0x8(%ebp),%edx
 51b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 51f:	3c 0a                	cmp    $0xa,%al
 521:	74 10                	je     533 <gets+0x43>
 523:	3c 0d                	cmp    $0xd,%al
 525:	74 0c                	je     533 <gets+0x43>
  for(i = 0; i+1 < max; ){
 527:	89 df                	mov    %ebx,%edi
 529:	83 c3 01             	add    $0x1,%ebx
 52c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 52f:	7c cf                	jl     500 <gets+0x10>
 531:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 533:	8b 45 08             	mov    0x8(%ebp),%eax
 536:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 53a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 53d:	5b                   	pop    %ebx
 53e:	5e                   	pop    %esi
 53f:	5f                   	pop    %edi
 540:	5d                   	pop    %ebp
 541:	c3                   	ret
 542:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 549:	00 
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000550 <stat>:

int
stat(const char *n, struct stat *st)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	56                   	push   %esi
 554:	53                   	push   %ebx
  int fd, r;

  fd = open(n, O_RDONLY);
 555:	83 ec 08             	sub    $0x8,%esp
 558:	6a 00                	push   $0x0
 55a:	ff 75 08             	push   0x8(%ebp)
 55d:	e8 40 01 00 00       	call   6a2 <open>
  if(fd < 0)
 562:	83 c4 10             	add    $0x10,%esp
 565:	85 c0                	test   %eax,%eax
 567:	78 27                	js     590 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 569:	83 ec 08             	sub    $0x8,%esp
 56c:	ff 75 0c             	push   0xc(%ebp)
 56f:	89 c3                	mov    %eax,%ebx
 571:	50                   	push   %eax
 572:	e8 f3 00 00 00       	call   66a <fstat>
  close(fd);
 577:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 57a:	89 c6                	mov    %eax,%esi
  close(fd);
 57c:	e8 51 01 00 00       	call   6d2 <close>
  return r;
 581:	83 c4 10             	add    $0x10,%esp
}
 584:	8d 65 f8             	lea    -0x8(%ebp),%esp
 587:	89 f0                	mov    %esi,%eax
 589:	5b                   	pop    %ebx
 58a:	5e                   	pop    %esi
 58b:	5d                   	pop    %ebp
 58c:	c3                   	ret
 58d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 590:	be ff ff ff ff       	mov    $0xffffffff,%esi
 595:	eb ed                	jmp    584 <stat+0x34>
 597:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59e:	00 
 59f:	90                   	nop

000005a0 <atoi>:

int
atoi(const char *s)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	53                   	push   %ebx
 5a4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5a7:	0f be 02             	movsbl (%edx),%eax
 5aa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 5ad:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 5b0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 5b5:	77 1e                	ja     5d5 <atoi+0x35>
 5b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5be:	00 
 5bf:	90                   	nop
    n = n*10 + *s++ - '0';
 5c0:	83 c2 01             	add    $0x1,%edx
 5c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 5c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 5ca:	0f be 02             	movsbl (%edx),%eax
 5cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 5d0:	80 fb 09             	cmp    $0x9,%bl
 5d3:	76 eb                	jbe    5c0 <atoi+0x20>
  return n;
}
 5d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5d8:	89 c8                	mov    %ecx,%eax
 5da:	c9                   	leave
 5db:	c3                   	ret
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	8b 55 08             	mov    0x8(%ebp),%edx
 5e7:	8b 45 10             	mov    0x10(%ebp),%eax
 5ea:	56                   	push   %esi
 5eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if(src > dst){
 5ee:	39 f2                	cmp    %esi,%edx
 5f0:	73 1e                	jae    610 <memmove+0x30>
    while(n-- > 0)
 5f2:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  dst = vdst;
 5f5:	89 d7                	mov    %edx,%edi
    while(n-- > 0)
 5f7:	85 c0                	test   %eax,%eax
 5f9:	7e 0a                	jle    605 <memmove+0x25>
 5fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      *dst++ = *src++;
 600:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
 601:	39 f9                	cmp    %edi,%ecx
 603:	75 fb                	jne    600 <memmove+0x20>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 605:	5e                   	pop    %esi
 606:	89 d0                	mov    %edx,%eax
 608:	5f                   	pop    %edi
 609:	5d                   	pop    %ebp
 60a:	c3                   	ret
 60b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
 610:	85 c0                	test   %eax,%eax
 612:	7e f1                	jle    605 <memmove+0x25>
    while(n-- > 0)
 614:	83 e8 01             	sub    $0x1,%eax
 617:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 61e:	00 
 61f:	90                   	nop
      *--dst = *--src;
 620:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
 624:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
 627:	83 e8 01             	sub    $0x1,%eax
 62a:	73 f4                	jae    620 <memmove+0x40>
}
 62c:	5e                   	pop    %esi
 62d:	89 d0                	mov    %edx,%eax
 62f:	5f                   	pop    %edi
 630:	5d                   	pop    %ebp
 631:	c3                   	ret

00000632 <fork>:
    movl $SYS_##name, %eax; \
    int  $T_SYSCALL;  \
    ret

/* ---- Standard syscalls ---- */
SYSCALL(fork)
 632:	b8 01 00 00 00       	mov    $0x1,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret

0000063a <exit>:
SYSCALL(exit)
 63a:	b8 02 00 00 00       	mov    $0x2,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret

00000642 <wait>:
SYSCALL(wait)
 642:	b8 03 00 00 00       	mov    $0x3,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret

0000064a <pipe>:
SYSCALL(pipe)
 64a:	b8 04 00 00 00       	mov    $0x4,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret

00000652 <read>:
SYSCALL(read)
 652:	b8 05 00 00 00       	mov    $0x5,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret

0000065a <kill>:
SYSCALL(kill)
 65a:	b8 06 00 00 00       	mov    $0x6,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret

00000662 <exec>:
SYSCALL(exec)
 662:	b8 07 00 00 00       	mov    $0x7,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret

0000066a <fstat>:
SYSCALL(fstat)
 66a:	b8 08 00 00 00       	mov    $0x8,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret

00000672 <chdir>:
SYSCALL(chdir)
 672:	b8 09 00 00 00       	mov    $0x9,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret

0000067a <dup>:
SYSCALL(dup)
 67a:	b8 0a 00 00 00       	mov    $0xa,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret

00000682 <getpid>:
SYSCALL(getpid)
 682:	b8 0b 00 00 00       	mov    $0xb,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret

0000068a <sbrk>:
SYSCALL(sbrk)
 68a:	b8 0c 00 00 00       	mov    $0xc,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret

00000692 <sleep>:
SYSCALL(sleep)
 692:	b8 0d 00 00 00       	mov    $0xd,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret

0000069a <uptime>:
SYSCALL(uptime)
 69a:	b8 0e 00 00 00       	mov    $0xe,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret

000006a2 <open>:
SYSCALL(open)
 6a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret

000006aa <write>:
SYSCALL(write)
 6aa:	b8 10 00 00 00       	mov    $0x10,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret

000006b2 <mknod>:
SYSCALL(mknod)
 6b2:	b8 11 00 00 00       	mov    $0x11,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret

000006ba <unlink>:
SYSCALL(unlink)
 6ba:	b8 12 00 00 00       	mov    $0x12,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret

000006c2 <link>:
SYSCALL(link)
 6c2:	b8 13 00 00 00       	mov    $0x13,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret

000006ca <mkdir>:
SYSCALL(mkdir)
 6ca:	b8 14 00 00 00       	mov    $0x14,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret

000006d2 <close>:
SYSCALL(close)
 6d2:	b8 15 00 00 00       	mov    $0x15,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret

000006da <setpolicy>:

/* ---- Extended syscalls (scheduling project) ---- */
SYSCALL(setpolicy)
 6da:	b8 16 00 00 00       	mov    $0x16,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret

000006e2 <settickets>:
SYSCALL(settickets)
 6e2:	b8 17 00 00 00       	mov    $0x17,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret

000006ea <getpinfo>:
SYSCALL(getpinfo)
 6ea:	b8 18 00 00 00       	mov    $0x18,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret

000006f2 <waitx>:
SYSCALL(waitx)
 6f2:	b8 19 00 00 00       	mov    $0x19,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret

000006fa <yield>:
SYSCALL(yield)
 6fa:	b8 1a 00 00 00       	mov    $0x1a,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret
 702:	66 90                	xchg   %ax,%ax
 704:	66 90                	xchg   %ax,%ax
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

00000720 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 728:	89 d1                	mov    %edx,%ecx
{
 72a:	83 ec 3c             	sub    $0x3c,%esp
 72d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(sgn && xx < 0){
 730:	85 d2                	test   %edx,%edx
 732:	0f 89 98 00 00 00    	jns    7d0 <printint+0xb0>
 738:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 73c:	0f 84 8e 00 00 00    	je     7d0 <printint+0xb0>
    x = -xx;
 742:	f7 d9                	neg    %ecx
    neg = 1;
 744:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 749:	89 45 c0             	mov    %eax,-0x40(%ebp)
 74c:	31 f6                	xor    %esi,%esi
 74e:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 755:	00 
 756:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 75d:	00 
 75e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 760:	89 c8                	mov    %ecx,%eax
 762:	31 d2                	xor    %edx,%edx
 764:	89 f7                	mov    %esi,%edi
 766:	f7 f3                	div    %ebx
 768:	8d 76 01             	lea    0x1(%esi),%esi
 76b:	0f b6 92 e0 0b 00 00 	movzbl 0xbe0(%edx),%edx
 772:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 776:	89 ca                	mov    %ecx,%edx
 778:	89 c1                	mov    %eax,%ecx
 77a:	39 da                	cmp    %ebx,%edx
 77c:	73 e2                	jae    760 <printint+0x40>
  if(neg)
 77e:	8b 45 c0             	mov    -0x40(%ebp),%eax
 781:	85 c0                	test   %eax,%eax
 783:	74 07                	je     78c <printint+0x6c>
    buf[i++] = '-';
 785:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 78a:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 78c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 78f:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 792:	01 df                	add    %ebx,%edi
 794:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 79b:	00 
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 7a0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 7a3:	83 ec 04             	sub    $0x4,%esp
 7a6:	88 45 d7             	mov    %al,-0x29(%ebp)
 7a9:	8d 45 d7             	lea    -0x29(%ebp),%eax
 7ac:	6a 01                	push   $0x1
 7ae:	50                   	push   %eax
 7af:	56                   	push   %esi
 7b0:	e8 f5 fe ff ff       	call   6aa <write>
  while(--i >= 0)
 7b5:	89 f8                	mov    %edi,%eax
 7b7:	83 c4 10             	add    $0x10,%esp
 7ba:	83 ef 01             	sub    $0x1,%edi
 7bd:	39 d8                	cmp    %ebx,%eax
 7bf:	75 df                	jne    7a0 <printint+0x80>
}
 7c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7c4:	5b                   	pop    %ebx
 7c5:	5e                   	pop    %esi
 7c6:	5f                   	pop    %edi
 7c7:	5d                   	pop    %ebp
 7c8:	c3                   	ret
 7c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7d0:	31 c0                	xor    %eax,%eax
 7d2:	e9 72 ff ff ff       	jmp    749 <printint+0x29>
 7d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7de:	00 
 7df:	90                   	nop

000007e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 7ec:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 7ef:	0f b6 13             	movzbl (%ebx),%edx
 7f2:	83 c3 01             	add    $0x1,%ebx
 7f5:	84 d2                	test   %dl,%dl
 7f7:	0f 84 a0 00 00 00    	je     89d <printf+0xbd>
 7fd:	8d 45 10             	lea    0x10(%ebp),%eax
 800:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 803:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 806:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 809:	eb 28                	jmp    833 <printf+0x53>
 80b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 810:	83 ec 04             	sub    $0x4,%esp
 813:	8d 45 e7             	lea    -0x19(%ebp),%eax
 816:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 819:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 81c:	6a 01                	push   $0x1
 81e:	50                   	push   %eax
 81f:	56                   	push   %esi
 820:	e8 85 fe ff ff       	call   6aa <write>
  for(i = 0; fmt[i]; i++){
 825:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 829:	83 c4 10             	add    $0x10,%esp
 82c:	84 d2                	test   %dl,%dl
 82e:	74 6d                	je     89d <printf+0xbd>
    c = fmt[i] & 0xff;
 830:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 833:	83 f8 25             	cmp    $0x25,%eax
 836:	75 d8                	jne    810 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 838:	0f b6 13             	movzbl (%ebx),%edx
 83b:	84 d2                	test   %dl,%dl
 83d:	74 5e                	je     89d <printf+0xbd>
    c = fmt[i] & 0xff;
 83f:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 842:	80 fa 25             	cmp    $0x25,%dl
 845:	0f 84 1d 01 00 00    	je     968 <printf+0x188>
 84b:	83 e8 63             	sub    $0x63,%eax
 84e:	83 f8 15             	cmp    $0x15,%eax
 851:	77 0d                	ja     860 <printf+0x80>
 853:	ff 24 85 88 0b 00 00 	jmp    *0xb88(,%eax,4)
 85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 860:	83 ec 04             	sub    $0x4,%esp
 863:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 866:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 869:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 86d:	6a 01                	push   $0x1
 86f:	51                   	push   %ecx
 870:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 873:	56                   	push   %esi
 874:	e8 31 fe ff ff       	call   6aa <write>
        putc(fd, c);
 879:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 87d:	83 c4 0c             	add    $0xc,%esp
 880:	88 55 e7             	mov    %dl,-0x19(%ebp)
 883:	6a 01                	push   $0x1
 885:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 888:	51                   	push   %ecx
 889:	56                   	push   %esi
 88a:	e8 1b fe ff ff       	call   6aa <write>
  for(i = 0; fmt[i]; i++){
 88f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 893:	83 c3 02             	add    $0x2,%ebx
 896:	83 c4 10             	add    $0x10,%esp
 899:	84 d2                	test   %dl,%dl
 89b:	75 93                	jne    830 <printf+0x50>
      }
      state = 0;
    }
  }
}
 89d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8a0:	5b                   	pop    %ebx
 8a1:	5e                   	pop    %esi
 8a2:	5f                   	pop    %edi
 8a3:	5d                   	pop    %ebp
 8a4:	c3                   	ret
 8a5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 8a8:	83 ec 0c             	sub    $0xc,%esp
 8ab:	8b 17                	mov    (%edi),%edx
 8ad:	b9 10 00 00 00       	mov    $0x10,%ecx
 8b2:	89 f0                	mov    %esi,%eax
 8b4:	6a 00                	push   $0x0
        ap++;
 8b6:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 8b9:	e8 62 fe ff ff       	call   720 <printint>
  for(i = 0; fmt[i]; i++){
 8be:	eb cf                	jmp    88f <printf+0xaf>
        s = (char*)*ap;
 8c0:	8b 07                	mov    (%edi),%eax
        ap++;
 8c2:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 8c5:	85 c0                	test   %eax,%eax
 8c7:	0f 84 b3 00 00 00    	je     980 <printf+0x1a0>
        while(*s != 0){
 8cd:	0f b6 10             	movzbl (%eax),%edx
 8d0:	84 d2                	test   %dl,%dl
 8d2:	0f 84 ba 00 00 00    	je     992 <printf+0x1b2>
 8d8:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 8db:	89 c7                	mov    %eax,%edi
 8dd:	89 d0                	mov    %edx,%eax
 8df:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 8e2:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8e5:	89 fb                	mov    %edi,%ebx
 8e7:	89 cf                	mov    %ecx,%edi
 8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 8f0:	83 ec 04             	sub    $0x4,%esp
 8f3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 8f6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 8f9:	6a 01                	push   $0x1
 8fb:	57                   	push   %edi
 8fc:	56                   	push   %esi
 8fd:	e8 a8 fd ff ff       	call   6aa <write>
        while(*s != 0){
 902:	0f b6 03             	movzbl (%ebx),%eax
 905:	83 c4 10             	add    $0x10,%esp
 908:	84 c0                	test   %al,%al
 90a:	75 e4                	jne    8f0 <printf+0x110>
 90c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 90f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 913:	83 c3 02             	add    $0x2,%ebx
 916:	84 d2                	test   %dl,%dl
 918:	0f 85 e5 fe ff ff    	jne    803 <printf+0x23>
 91e:	e9 7a ff ff ff       	jmp    89d <printf+0xbd>
 923:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 928:	83 ec 0c             	sub    $0xc,%esp
 92b:	8b 17                	mov    (%edi),%edx
 92d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 932:	89 f0                	mov    %esi,%eax
 934:	6a 01                	push   $0x1
        ap++;
 936:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 10, 1);
 939:	e8 e2 fd ff ff       	call   720 <printint>
  for(i = 0; fmt[i]; i++){
 93e:	e9 4c ff ff ff       	jmp    88f <printf+0xaf>
 943:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 948:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 94a:	83 ec 04             	sub    $0x4,%esp
 94d:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        ap++;
 950:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 953:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 956:	6a 01                	push   $0x1
 958:	51                   	push   %ecx
 959:	56                   	push   %esi
 95a:	e8 4b fd ff ff       	call   6aa <write>
  for(i = 0; fmt[i]; i++){
 95f:	e9 2b ff ff ff       	jmp    88f <printf+0xaf>
 964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 968:	83 ec 04             	sub    $0x4,%esp
 96b:	88 55 e7             	mov    %dl,-0x19(%ebp)
 96e:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 971:	6a 01                	push   $0x1
 973:	e9 10 ff ff ff       	jmp    888 <printf+0xa8>
 978:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 97f:	00 
          s = "(null)";
 980:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 983:	b8 28 00 00 00       	mov    $0x28,%eax
 988:	bf 7e 0b 00 00       	mov    $0xb7e,%edi
 98d:	e9 4d ff ff ff       	jmp    8df <printf+0xff>
  for(i = 0; fmt[i]; i++){
 992:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 996:	83 c3 02             	add    $0x2,%ebx
 999:	84 d2                	test   %dl,%dl
 99b:	0f 85 8f fe ff ff    	jne    830 <printf+0x50>
 9a1:	e9 f7 fe ff ff       	jmp    89d <printf+0xbd>
 9a6:	66 90                	xchg   %ax,%ax
 9a8:	66 90                	xchg   %ax,%ax
 9aa:	66 90                	xchg   %ax,%ax
 9ac:	66 90                	xchg   %ax,%ax
 9ae:	66 90                	xchg   %ax,%ax
 9b0:	66 90                	xchg   %ax,%ax
 9b2:	66 90                	xchg   %ax,%ax
 9b4:	66 90                	xchg   %ax,%ax
 9b6:	66 90                	xchg   %ax,%ax
 9b8:	66 90                	xchg   %ax,%ax
 9ba:	66 90                	xchg   %ax,%ax
 9bc:	66 90                	xchg   %ax,%ax
 9be:	66 90                	xchg   %ax,%ax

000009c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c1:	a1 80 13 00 00       	mov    0x1380,%eax
{
 9c6:	89 e5                	mov    %esp,%ebp
 9c8:	57                   	push   %edi
 9c9:	56                   	push   %esi
 9ca:	53                   	push   %ebx
 9cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 9ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9d8:	00 
 9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9e0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9e2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e4:	39 ca                	cmp    %ecx,%edx
 9e6:	73 30                	jae    a18 <free+0x58>
 9e8:	39 c1                	cmp    %eax,%ecx
 9ea:	72 04                	jb     9f0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ec:	39 c2                	cmp    %eax,%edx
 9ee:	72 f0                	jb     9e0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9f3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9f6:	39 f8                	cmp    %edi,%eax
 9f8:	74 36                	je     a30 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 9fa:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9fd:	8b 42 04             	mov    0x4(%edx),%eax
 a00:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a03:	39 f1                	cmp    %esi,%ecx
 a05:	74 40                	je     a47 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a07:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a09:	5b                   	pop    %ebx
  freep = p;
 a0a:	89 15 80 13 00 00    	mov    %edx,0x1380
}
 a10:	5e                   	pop    %esi
 a11:	5f                   	pop    %edi
 a12:	5d                   	pop    %ebp
 a13:	c3                   	ret
 a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a18:	39 c2                	cmp    %eax,%edx
 a1a:	72 c4                	jb     9e0 <free+0x20>
 a1c:	39 c1                	cmp    %eax,%ecx
 a1e:	73 c0                	jae    9e0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 a20:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a23:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a26:	39 f8                	cmp    %edi,%eax
 a28:	75 d0                	jne    9fa <free+0x3a>
 a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 a30:	03 70 04             	add    0x4(%eax),%esi
 a33:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a36:	8b 02                	mov    (%edx),%eax
 a38:	8b 00                	mov    (%eax),%eax
 a3a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 a3d:	8b 42 04             	mov    0x4(%edx),%eax
 a40:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a43:	39 f1                	cmp    %esi,%ecx
 a45:	75 c0                	jne    a07 <free+0x47>
    p->s.size += bp->s.size;
 a47:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 a4a:	89 15 80 13 00 00    	mov    %edx,0x1380
    p->s.size += bp->s.size;
 a50:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 a53:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 a56:	89 0a                	mov    %ecx,(%edx)
}
 a58:	5b                   	pop    %ebx
 a59:	5e                   	pop    %esi
 a5a:	5f                   	pop    %edi
 a5b:	5d                   	pop    %ebp
 a5c:	c3                   	ret
 a5d:	8d 76 00             	lea    0x0(%esi),%esi

00000a60 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a60:	55                   	push   %ebp
 a61:	89 e5                	mov    %esp,%ebp
 a63:	57                   	push   %edi
 a64:	56                   	push   %esi
 a65:	53                   	push   %ebx
 a66:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a69:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a6c:	8b 15 80 13 00 00    	mov    0x1380,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a72:	8d 78 07             	lea    0x7(%eax),%edi
 a75:	c1 ef 03             	shr    $0x3,%edi
 a78:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a7b:	85 d2                	test   %edx,%edx
 a7d:	0f 84 8d 00 00 00    	je     b10 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a83:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a85:	8b 48 04             	mov    0x4(%eax),%ecx
 a88:	39 f9                	cmp    %edi,%ecx
 a8a:	73 64                	jae    af0 <malloc+0x90>
  if(nu < 4096)
 a8c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a91:	39 df                	cmp    %ebx,%edi
 a93:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a96:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a9d:	eb 0a                	jmp    aa9 <malloc+0x49>
 a9f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 aa2:	8b 48 04             	mov    0x4(%eax),%ecx
 aa5:	39 f9                	cmp    %edi,%ecx
 aa7:	73 47                	jae    af0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 aa9:	89 c2                	mov    %eax,%edx
 aab:	39 05 80 13 00 00    	cmp    %eax,0x1380
 ab1:	75 ed                	jne    aa0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 ab3:	83 ec 0c             	sub    $0xc,%esp
 ab6:	56                   	push   %esi
 ab7:	e8 ce fb ff ff       	call   68a <sbrk>
  if(p == (char*)-1)
 abc:	83 c4 10             	add    $0x10,%esp
 abf:	83 f8 ff             	cmp    $0xffffffff,%eax
 ac2:	74 1c                	je     ae0 <malloc+0x80>
  hp->s.size = nu;
 ac4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 ac7:	83 ec 0c             	sub    $0xc,%esp
 aca:	83 c0 08             	add    $0x8,%eax
 acd:	50                   	push   %eax
 ace:	e8 ed fe ff ff       	call   9c0 <free>
  return freep;
 ad3:	8b 15 80 13 00 00    	mov    0x1380,%edx
      if((p = morecore(nunits)) == 0)
 ad9:	83 c4 10             	add    $0x10,%esp
 adc:	85 d2                	test   %edx,%edx
 ade:	75 c0                	jne    aa0 <malloc+0x40>
        return 0;
  }
}
 ae0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 ae3:	31 c0                	xor    %eax,%eax
}
 ae5:	5b                   	pop    %ebx
 ae6:	5e                   	pop    %esi
 ae7:	5f                   	pop    %edi
 ae8:	5d                   	pop    %ebp
 ae9:	c3                   	ret
 aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 af0:	39 cf                	cmp    %ecx,%edi
 af2:	74 4c                	je     b40 <malloc+0xe0>
        p->s.size -= nunits;
 af4:	29 f9                	sub    %edi,%ecx
 af6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 af9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 afc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 aff:	89 15 80 13 00 00    	mov    %edx,0x1380
}
 b05:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b08:	83 c0 08             	add    $0x8,%eax
}
 b0b:	5b                   	pop    %ebx
 b0c:	5e                   	pop    %esi
 b0d:	5f                   	pop    %edi
 b0e:	5d                   	pop    %ebp
 b0f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 b10:	c7 05 80 13 00 00 84 	movl   $0x1384,0x1380
 b17:	13 00 00 
    base.s.size = 0;
 b1a:	b8 84 13 00 00       	mov    $0x1384,%eax
    base.s.ptr = freep = prevp = &base;
 b1f:	c7 05 84 13 00 00 84 	movl   $0x1384,0x1384
 b26:	13 00 00 
    base.s.size = 0;
 b29:	c7 05 88 13 00 00 00 	movl   $0x0,0x1388
 b30:	00 00 00 
    if(p->s.size >= nunits){
 b33:	e9 54 ff ff ff       	jmp    a8c <malloc+0x2c>
 b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b3f:	00 
        prevp->s.ptr = p->s.ptr;
 b40:	8b 08                	mov    (%eax),%ecx
 b42:	89 0a                	mov    %ecx,(%edx)
 b44:	eb b9                	jmp    aff <malloc+0x9f>
