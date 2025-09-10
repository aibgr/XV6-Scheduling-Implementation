
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 90 6d 11 80       	mov    $0x80116d90,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 30 31 10 80       	mov    $0x80103130,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
  initlock(&bcache.lock, "bcache");

  // Create linked list of buffers.
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 7a 10 80       	push   $0x80107a60
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 05 4a 00 00       	call   80104a60 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 7a 10 80       	push   $0x80107a67
80100097:	50                   	push   %eax
80100098:	e8 83 48 00 00       	call   80104920 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 b7 4a 00 00       	call   80104ba0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 4a                	jmp    80100165 <bread+0x95>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 1d                	jne    8010014b <bread+0x7b>
8010012e:	eb 79                	jmp    801001a9 <bread+0xd9>
80100130:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100137:	00 
80100138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010013f:	00 
80100140:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100143:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100149:	74 5e                	je     801001a9 <bread+0xd9>
    if(b->refcnt == 0){
8010014b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010014e:	85 c0                	test   %eax,%eax
80100150:	75 ee                	jne    80100140 <bread+0x70>
      b->dev = dev;
80100152:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
80100155:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;      // جایگزین b->valid = 0
80100158:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
8010015e:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100165:	83 ec 0c             	sub    $0xc,%esp
80100168:	68 20 b5 10 80       	push   $0x8010b520
8010016d:	e8 ae 4b 00 00       	call   80104d20 <release>
      acquiresleep(&b->lock);
80100172:	8d 43 0c             	lea    0xc(%ebx),%eax
80100175:	89 04 24             	mov    %eax,(%esp)
80100178:	e8 e3 47 00 00       	call   80104960 <acquiresleep>
      return b;
8010017d:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)){
80100180:	f6 03 02             	testb  $0x2,(%ebx)
80100183:	74 0b                	je     80100190 <bread+0xc0>
    iderw(b);
    b->flags |= B_VALID;
  }
  return b;
}
80100185:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100188:	89 d8                	mov    %ebx,%eax
8010018a:	5b                   	pop    %ebx
8010018b:	5e                   	pop    %esi
8010018c:	5f                   	pop    %edi
8010018d:	5d                   	pop    %ebp
8010018e:	c3                   	ret
8010018f:	90                   	nop
    iderw(b);
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	53                   	push   %ebx
80100194:	e8 a7 21 00 00       	call   80102340 <iderw>
    b->flags |= B_VALID;
80100199:	83 0b 02             	orl    $0x2,(%ebx)
8010019c:	83 c4 10             	add    $0x10,%esp
}
8010019f:	8d 65 f4             	lea    -0xc(%ebp),%esp
801001a2:	89 d8                	mov    %ebx,%eax
801001a4:	5b                   	pop    %ebx
801001a5:	5e                   	pop    %esi
801001a6:	5f                   	pop    %edi
801001a7:	5d                   	pop    %ebp
801001a8:	c3                   	ret
  panic("bget: no buffers");
801001a9:	83 ec 0c             	sub    $0xc,%esp
801001ac:	68 6e 7a 10 80       	push   $0x80107a6e
801001b1:	e8 ea 01 00 00       	call   801003a0 <panic>
801001b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001bd:	00 
801001be:	66 90                	xchg   %ax,%ax

801001c0 <bwrite>:

// Write b's contents to disk. Must be locked.
void
bwrite(struct buf *b)
{
801001c0:	55                   	push   %ebp
801001c1:	89 e5                	mov    %esp,%ebp
801001c3:	53                   	push   %ebx
801001c4:	83 ec 10             	sub    $0x10,%esp
801001c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ca:	8d 43 0c             	lea    0xc(%ebx),%eax
801001cd:	50                   	push   %eax
801001ce:	e8 2d 48 00 00       	call   80104a00 <holdingsleep>
801001d3:	83 c4 10             	add    $0x10,%esp
801001d6:	85 c0                	test   %eax,%eax
801001d8:	74 0f                	je     801001e9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001da:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001dd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001e3:	c9                   	leave
  iderw(b);
801001e4:	e9 57 21 00 00       	jmp    80102340 <iderw>
    panic("bwrite");
801001e9:	83 ec 0c             	sub    $0xc,%esp
801001ec:	68 7f 7a 10 80       	push   $0x80107a7f
801001f1:	e8 aa 01 00 00       	call   801003a0 <panic>
801001f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001fd:	00 
801001fe:	66 90                	xchg   %ax,%ax

80100200 <brelse>:

// Release a locked buffer.
void
brelse(struct buf *b)
{
80100200:	55                   	push   %ebp
80100201:	89 e5                	mov    %esp,%ebp
80100203:	56                   	push   %esi
80100204:	53                   	push   %ebx
80100205:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
80100208:	8d 73 0c             	lea    0xc(%ebx),%esi
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 ec 47 00 00       	call   80104a00 <holdingsleep>
80100214:	83 c4 10             	add    $0x10,%esp
80100217:	85 c0                	test   %eax,%eax
80100219:	74 63                	je     8010027e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010021b:	83 ec 0c             	sub    $0xc,%esp
8010021e:	56                   	push   %esi
8010021f:	e8 9c 47 00 00       	call   801049c0 <releasesleep>

  acquire(&bcache.lock);
80100224:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010022b:	e8 70 49 00 00       	call   80104ba0 <acquire>
  b->refcnt--;
80100230:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if(b->refcnt == 0){
80100233:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100236:	83 e8 01             	sub    $0x1,%eax
80100239:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if(b->refcnt == 0){
8010023c:	85 c0                	test   %eax,%eax
8010023e:	75 2c                	jne    8010026c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	8b 43 50             	mov    0x50(%ebx),%eax
80100246:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100249:	8b 53 54             	mov    0x54(%ebx),%edx
8010024c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010024f:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100254:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010025b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010025e:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100263:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100266:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  release(&bcache.lock);
8010026c:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100273:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100276:	5b                   	pop    %ebx
80100277:	5e                   	pop    %esi
80100278:	5d                   	pop    %ebp
  release(&bcache.lock);
80100279:	e9 a2 4a 00 00       	jmp    80104d20 <release>
    panic("brelse");
8010027e:	83 ec 0c             	sub    $0xc,%esp
80100281:	68 86 7a 10 80       	push   $0x80107a86
80100286:	e8 15 01 00 00       	call   801003a0 <panic>
8010028b:	66 90                	xchg   %ax,%ax
8010028d:	66 90                	xchg   %ax,%ax
8010028f:	66 90                	xchg   %ax,%ax
80100291:	66 90                	xchg   %ax,%ax
80100293:	66 90                	xchg   %ax,%ax
80100295:	66 90                	xchg   %ax,%ax
80100297:	66 90                	xchg   %ax,%ax
80100299:	66 90                	xchg   %ax,%ax
8010029b:	66 90                	xchg   %ax,%ax
8010029d:	66 90                	xchg   %ax,%ax
8010029f:	90                   	nop

801002a0 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
801002a0:	55                   	push   %ebp
801002a1:	89 e5                	mov    %esp,%ebp
801002a3:	57                   	push   %edi
801002a4:	56                   	push   %esi
801002a5:	53                   	push   %ebx
801002a6:	83 ec 18             	sub    $0x18,%esp
801002a9:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
801002af:	ff 75 08             	push   0x8(%ebp)
  target = n;
801002b2:	89 df                	mov    %ebx,%edi
  iunlock(ip);
801002b4:	e8 17 16 00 00       	call   801018d0 <iunlock>
  acquire(&cons.lock);
801002b9:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002c0:	e8 db 48 00 00       	call   80104ba0 <acquire>
  while(n > 0){
801002c5:	83 c4 10             	add    $0x10,%esp
801002c8:	85 db                	test   %ebx,%ebx
801002ca:	0f 8e 94 00 00 00    	jle    80100364 <consoleread+0xc4>
    while(input.r == input.w){
801002d0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d5:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
801002db:	74 25                	je     80100302 <consoleread+0x62>
801002dd:	eb 59                	jmp    80100338 <consoleread+0x98>
801002df:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002e0:	83 ec 08             	sub    $0x8,%esp
801002e3:	68 20 ff 10 80       	push   $0x8010ff20
801002e8:	68 00 ff 10 80       	push   $0x8010ff00
801002ed:	e8 5e 42 00 00       	call   80104550 <sleep>
    while(input.r == input.w){
801002f2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002f7:	83 c4 10             	add    $0x10,%esp
801002fa:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100300:	75 36                	jne    80100338 <consoleread+0x98>
      if(myproc()->killed){
80100302:	e8 b9 36 00 00       	call   801039c0 <myproc>
80100307:	8b 48 24             	mov    0x24(%eax),%ecx
8010030a:	85 c9                	test   %ecx,%ecx
8010030c:	74 d2                	je     801002e0 <consoleread+0x40>
        release(&cons.lock);
8010030e:	83 ec 0c             	sub    $0xc,%esp
80100311:	68 20 ff 10 80       	push   $0x8010ff20
80100316:	e8 05 4a 00 00       	call   80104d20 <release>
        ilock(ip);
8010031b:	5a                   	pop    %edx
8010031c:	ff 75 08             	push   0x8(%ebp)
8010031f:	e8 cc 14 00 00       	call   801017f0 <ilock>
        return -1;
80100324:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100327:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010032a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010032f:	5b                   	pop    %ebx
80100330:	5e                   	pop    %esi
80100331:	5f                   	pop    %edi
80100332:	5d                   	pop    %ebp
80100333:	c3                   	ret
80100334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100338:	8d 50 01             	lea    0x1(%eax),%edx
8010033b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100341:	89 c2                	mov    %eax,%edx
80100343:	83 e2 7f             	and    $0x7f,%edx
80100346:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010034d:	80 f9 04             	cmp    $0x4,%cl
80100350:	74 37                	je     80100389 <consoleread+0xe9>
    *dst++ = c;
80100352:	83 c6 01             	add    $0x1,%esi
    --n;
80100355:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100358:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010035b:	83 f9 0a             	cmp    $0xa,%ecx
8010035e:	0f 85 64 ff ff ff    	jne    801002c8 <consoleread+0x28>
  release(&cons.lock);
80100364:	83 ec 0c             	sub    $0xc,%esp
80100367:	68 20 ff 10 80       	push   $0x8010ff20
8010036c:	e8 af 49 00 00       	call   80104d20 <release>
  ilock(ip);
80100371:	58                   	pop    %eax
80100372:	ff 75 08             	push   0x8(%ebp)
80100375:	e8 76 14 00 00       	call   801017f0 <ilock>
  return target - n;
8010037a:	89 f8                	mov    %edi,%eax
8010037c:	83 c4 10             	add    $0x10,%esp
}
8010037f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100382:	29 d8                	sub    %ebx,%eax
}
80100384:	5b                   	pop    %ebx
80100385:	5e                   	pop    %esi
80100386:	5f                   	pop    %edi
80100387:	5d                   	pop    %ebp
80100388:	c3                   	ret
      if(n < target){
80100389:	39 fb                	cmp    %edi,%ebx
8010038b:	73 d7                	jae    80100364 <consoleread+0xc4>
        input.r--;
8010038d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100392:	eb d0                	jmp    80100364 <consoleread+0xc4>
80100394:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010039b:	00 
8010039c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801003a0 <panic>:
{
801003a0:	55                   	push   %ebp
801003a1:	89 e5                	mov    %esp,%ebp
801003a3:	53                   	push   %ebx
801003a4:	83 ec 34             	sub    $0x34,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801003a7:	fa                   	cli
  cons.locking = 0;
801003a8:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
801003af:	00 00 00 
  getcallerpcs(&s, pcs);
801003b2:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
801003b5:	e8 d6 25 00 00       	call   80102990 <lapicid>
801003ba:	83 ec 08             	sub    $0x8,%esp
801003bd:	50                   	push   %eax
801003be:	68 8d 7a 10 80       	push   $0x80107a8d
801003c3:	e8 08 03 00 00       	call   801006d0 <cprintf>
  cprintf(s);
801003c8:	58                   	pop    %eax
801003c9:	ff 75 08             	push   0x8(%ebp)
801003cc:	e8 ff 02 00 00       	call   801006d0 <cprintf>
  cprintf("\n");
801003d1:	c7 04 24 06 7f 10 80 	movl   $0x80107f06,(%esp)
801003d8:	e8 f3 02 00 00       	call   801006d0 <cprintf>
  getcallerpcs(&s, pcs);
801003dd:	8d 45 08             	lea    0x8(%ebp),%eax
801003e0:	5a                   	pop    %edx
801003e1:	59                   	pop    %ecx
801003e2:	53                   	push   %ebx
801003e3:	50                   	push   %eax
801003e4:	e8 c7 49 00 00       	call   80104db0 <getcallerpcs>
  for(i=0; i<10; i++)
801003e9:	83 c4 10             	add    $0x10,%esp
801003ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003f0:	83 ec 08             	sub    $0x8,%esp
801003f3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003f5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f8:	68 a1 7a 10 80       	push   $0x80107aa1
801003fd:	e8 ce 02 00 00       	call   801006d0 <cprintf>
  for(i=0; i<10; i++)
80100402:	8d 45 f8             	lea    -0x8(%ebp),%eax
80100405:	83 c4 10             	add    $0x10,%esp
80100408:	39 c3                	cmp    %eax,%ebx
8010040a:	75 e4                	jne    801003f0 <panic+0x50>
  panicked = 1; // freeze other CPU
8010040c:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
80100413:	00 00 00 
  for(;;)
80100416:	eb fe                	jmp    80100416 <panic+0x76>
80100418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010041f:	00 

80100420 <consputc.part.0>:
consputc(int c)
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
80100429:	3d 00 01 00 00       	cmp    $0x100,%eax
8010042e:	0f 84 cc 00 00 00    	je     80100500 <consputc.part.0+0xe0>
    uartputc(c);
80100434:	83 ec 0c             	sub    $0xc,%esp
80100437:	89 c3                	mov    %eax,%ebx
80100439:	50                   	push   %eax
8010043a:	e8 51 61 00 00       	call   80106590 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100444:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100449:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044a:	be d5 03 00 00       	mov    $0x3d5,%esi
8010044f:	89 f2                	mov    %esi,%edx
80100451:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100452:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100455:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010045a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010045f:	c1 e1 08             	shl    $0x8,%ecx
80100462:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100463:	89 f2                	mov    %esi,%edx
80100465:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100466:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
80100469:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010046c:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010046e:	83 fb 0a             	cmp    $0xa,%ebx
80100471:	75 75                	jne    801004e8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100473:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100478:	f7 e2                	mul    %edx
8010047a:	c1 ea 06             	shr    $0x6,%edx
8010047d:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100480:	c1 e0 04             	shl    $0x4,%eax
80100483:	8d 70 50             	lea    0x50(%eax),%esi
  if(pos < 0 || pos > 25*80)
80100486:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
8010048c:	0f 8f 24 01 00 00    	jg     801005b6 <consputc.part.0+0x196>
  if((pos/80) >= 24){  // Scroll up.
80100492:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100498:	0f 8f c2 00 00 00    	jg     80100560 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
8010049e:	89 f0                	mov    %esi,%eax
  outb(CRTPORT+1, pos);
801004a0:	89 f1                	mov    %esi,%ecx
  crt[pos] = ' ' | 0x0700;
801004a2:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos>>8);
801004a9:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ac:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b1:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004b6:	ee                   	out    %al,(%dx)
801004b7:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801004bc:	89 f8                	mov    %edi,%eax
801004be:	89 da                	mov    %ebx,%edx
801004c0:	ee                   	out    %al,(%dx)
801004c1:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c6:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004cb:	ee                   	out    %al,(%dx)
801004cc:	89 c8                	mov    %ecx,%eax
801004ce:	89 da                	mov    %ebx,%edx
801004d0:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d1:	b8 20 07 00 00       	mov    $0x720,%eax
801004d6:	66 89 06             	mov    %ax,(%esi)
}
801004d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004dc:	5b                   	pop    %ebx
801004dd:	5e                   	pop    %esi
801004de:	5f                   	pop    %edi
801004df:	5d                   	pop    %ebp
801004e0:	c3                   	ret
801004e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004e8:	0f b6 db             	movzbl %bl,%ebx
801004eb:	8d 70 01             	lea    0x1(%eax),%esi
801004ee:	80 cf 07             	or     $0x7,%bh
801004f1:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801004f8:	80 
801004f9:	eb 8b                	jmp    80100486 <consputc.part.0+0x66>
801004fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 86 60 00 00       	call   80106590 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 7a 60 00 00       	call   80106590 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 6e 60 00 00       	call   80106590 <uartputc>
80100522:	b8 0e 00 00 00       	mov    $0xe,%eax
80100527:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010052c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010052d:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100532:	89 da                	mov    %ebx,%edx
80100534:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100535:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100538:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010053d:	b8 0f 00 00 00       	mov    $0xf,%eax
80100542:	c1 e1 08             	shl    $0x8,%ecx
80100545:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100546:	89 da                	mov    %ebx,%edx
80100548:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100549:	0f b6 f0             	movzbl %al,%esi
    if(pos > 0) --pos;
8010054c:	83 c4 10             	add    $0x10,%esp
8010054f:	09 ce                	or     %ecx,%esi
80100551:	74 55                	je     801005a8 <consputc.part.0+0x188>
80100553:	83 ee 01             	sub    $0x1,%esi
80100556:	e9 2b ff ff ff       	jmp    80100486 <consputc.part.0+0x66>
8010055b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100560:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100563:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010056d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100572:	68 60 0e 00 00       	push   $0xe60
80100577:	68 a0 80 0b 80       	push   $0x800b80a0
8010057c:	68 00 80 0b 80       	push   $0x800b8000
80100581:	e8 4a 49 00 00       	call   80104ed0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100586:	b8 80 07 00 00       	mov    $0x780,%eax
8010058b:	83 c4 0c             	add    $0xc,%esp
8010058e:	29 d8                	sub    %ebx,%eax
80100590:	01 c0                	add    %eax,%eax
80100592:	50                   	push   %eax
80100593:	6a 00                	push   $0x0
80100595:	56                   	push   %esi
80100596:	e8 a5 48 00 00       	call   80104e40 <memset>
  outb(CRTPORT+1, pos);
8010059b:	89 d9                	mov    %ebx,%ecx
8010059d:	83 c4 10             	add    $0x10,%esp
801005a0:	e9 07 ff ff ff       	jmp    801004ac <consputc.part.0+0x8c>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
801005a8:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801005ad:	31 c9                	xor    %ecx,%ecx
801005af:	31 ff                	xor    %edi,%edi
801005b1:	e9 f6 fe ff ff       	jmp    801004ac <consputc.part.0+0x8c>
    panic("pos under/overflow");
801005b6:	83 ec 0c             	sub    $0xc,%esp
801005b9:	68 a5 7a 10 80       	push   $0x80107aa5
801005be:	e8 dd fd ff ff       	call   801003a0 <panic>
801005c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801005ca:	00 
801005cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801005d0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005d0:	55                   	push   %ebp
801005d1:	89 e5                	mov    %esp,%ebp
801005d3:	57                   	push   %edi
801005d4:	56                   	push   %esi
801005d5:	53                   	push   %ebx
801005d6:	83 ec 18             	sub    $0x18,%esp
801005d9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005dc:	ff 75 08             	push   0x8(%ebp)
801005df:	e8 ec 12 00 00       	call   801018d0 <iunlock>
  acquire(&cons.lock);
801005e4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005eb:	e8 b0 45 00 00       	call   80104ba0 <acquire>
  for(i = 0; i < n; i++)
801005f0:	83 c4 10             	add    $0x10,%esp
801005f3:	85 f6                	test   %esi,%esi
801005f5:	7e 28                	jle    8010061f <consolewrite+0x4f>
801005f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005fa:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005fd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100603:	85 d2                	test   %edx,%edx
80100605:	74 09                	je     80100610 <consolewrite+0x40>
  asm volatile("cli");
80100607:	fa                   	cli
    for(;;)
80100608:	eb fe                	jmp    80100608 <consolewrite+0x38>
8010060a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100610:	0f b6 03             	movzbl (%ebx),%eax
  for(i = 0; i < n; i++)
80100613:	83 c3 01             	add    $0x1,%ebx
80100616:	e8 05 fe ff ff       	call   80100420 <consputc.part.0>
8010061b:	39 fb                	cmp    %edi,%ebx
8010061d:	75 de                	jne    801005fd <consolewrite+0x2d>
  release(&cons.lock);
8010061f:	83 ec 0c             	sub    $0xc,%esp
80100622:	68 20 ff 10 80       	push   $0x8010ff20
80100627:	e8 f4 46 00 00       	call   80104d20 <release>
  ilock(ip);
8010062c:	58                   	pop    %eax
8010062d:	ff 75 08             	push   0x8(%ebp)
80100630:	e8 bb 11 00 00       	call   801017f0 <ilock>

  return n;
}
80100635:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100638:	89 f0                	mov    %esi,%eax
8010063a:	5b                   	pop    %ebx
8010063b:	5e                   	pop    %esi
8010063c:	5f                   	pop    %edi
8010063d:	5d                   	pop    %ebp
8010063e:	c3                   	ret
8010063f:	90                   	nop

80100640 <printint>:
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
80100644:	56                   	push   %esi
80100645:	53                   	push   %ebx
80100646:	89 d3                	mov    %edx,%ebx
80100648:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010064b:	85 c0                	test   %eax,%eax
8010064d:	79 05                	jns    80100654 <printint+0x14>
8010064f:	83 e1 01             	and    $0x1,%ecx
80100652:	75 5f                	jne    801006b3 <printint+0x73>
    x = xx;
80100654:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010065b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010065d:	31 f6                	xor    %esi,%esi
8010065f:	90                   	nop
    buf[i++] = digits[x % base];
80100660:	89 c8                	mov    %ecx,%eax
80100662:	31 d2                	xor    %edx,%edx
80100664:	89 f7                	mov    %esi,%edi
80100666:	f7 f3                	div    %ebx
80100668:	8d 76 01             	lea    0x1(%esi),%esi
8010066b:	0f b6 92 58 7f 10 80 	movzbl -0x7fef80a8(%edx),%edx
80100672:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100676:	89 ca                	mov    %ecx,%edx
80100678:	89 c1                	mov    %eax,%ecx
8010067a:	39 da                	cmp    %ebx,%edx
8010067c:	73 e2                	jae    80100660 <printint+0x20>
  if(sign)
8010067e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100681:	85 d2                	test   %edx,%edx
80100683:	74 07                	je     8010068c <printint+0x4c>
    buf[i++] = '-';
80100685:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
8010068a:	89 f7                	mov    %esi,%edi
  while(--i >= 0)
8010068c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010068f:	01 df                	add    %ebx,%edi
  if(panicked){
80100691:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100696:	85 c0                	test   %eax,%eax
80100698:	74 06                	je     801006a0 <printint+0x60>
8010069a:	fa                   	cli
    for(;;)
8010069b:	eb fe                	jmp    8010069b <printint+0x5b>
8010069d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i]);
801006a0:	0f be 07             	movsbl (%edi),%eax
801006a3:	e8 78 fd ff ff       	call   80100420 <consputc.part.0>
  while(--i >= 0)
801006a8:	8d 47 ff             	lea    -0x1(%edi),%eax
801006ab:	39 df                	cmp    %ebx,%edi
801006ad:	74 11                	je     801006c0 <printint+0x80>
801006af:	89 c7                	mov    %eax,%edi
801006b1:	eb de                	jmp    80100691 <printint+0x51>
    x = -xx;
801006b3:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
801006b5:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801006bc:	89 c1                	mov    %eax,%ecx
801006be:	eb 9d                	jmp    8010065d <printint+0x1d>
}
801006c0:	83 c4 2c             	add    $0x2c,%esp
801006c3:	5b                   	pop    %ebx
801006c4:	5e                   	pop    %esi
801006c5:	5f                   	pop    %edi
801006c6:	5d                   	pop    %ebp
801006c7:	c3                   	ret
801006c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801006cf:	00 

801006d0 <cprintf>:
{
801006d0:	55                   	push   %ebp
801006d1:	89 e5                	mov    %esp,%ebp
801006d3:	57                   	push   %edi
801006d4:	56                   	push   %esi
801006d5:	53                   	push   %ebx
801006d6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006d9:	8b 3d 54 ff 10 80    	mov    0x8010ff54,%edi
  if (fmt == 0)
801006df:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
801006e2:	85 ff                	test   %edi,%edi
801006e4:	0f 85 06 01 00 00    	jne    801007f0 <cprintf+0x120>
  if (fmt == 0)
801006ea:	85 f6                	test   %esi,%esi
801006ec:	0f 84 b7 01 00 00    	je     801008a9 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f2:	0f b6 06             	movzbl (%esi),%eax
801006f5:	85 c0                	test   %eax,%eax
801006f7:	74 5f                	je     80100758 <cprintf+0x88>
  argp = (uint*)(void*)(&fmt + 1);
801006f9:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801006ff:	31 db                	xor    %ebx,%ebx
80100701:	89 d7                	mov    %edx,%edi
    if(c != '%'){
80100703:	83 f8 25             	cmp    $0x25,%eax
80100706:	75 58                	jne    80100760 <cprintf+0x90>
    c = fmt[++i] & 0xff;
80100708:	83 c3 01             	add    $0x1,%ebx
8010070b:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
8010070f:	85 c9                	test   %ecx,%ecx
80100711:	74 3a                	je     8010074d <cprintf+0x7d>
    switch(c){
80100713:	83 f9 70             	cmp    $0x70,%ecx
80100716:	0f 84 b4 00 00 00    	je     801007d0 <cprintf+0x100>
8010071c:	7f 72                	jg     80100790 <cprintf+0xc0>
8010071e:	83 f9 25             	cmp    $0x25,%ecx
80100721:	74 4d                	je     80100770 <cprintf+0xa0>
80100723:	83 f9 64             	cmp    $0x64,%ecx
80100726:	75 76                	jne    8010079e <cprintf+0xce>
      printint(*argp++, 10, 1);
80100728:	8d 47 04             	lea    0x4(%edi),%eax
8010072b:	b9 01 00 00 00       	mov    $0x1,%ecx
80100730:	ba 0a 00 00 00       	mov    $0xa,%edx
80100735:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100738:	8b 07                	mov    (%edi),%eax
8010073a:	e8 01 ff ff ff       	call   80100640 <printint>
8010073f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100742:	83 c3 01             	add    $0x1,%ebx
80100745:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100749:	85 c0                	test   %eax,%eax
8010074b:	75 b6                	jne    80100703 <cprintf+0x33>
8010074d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
80100750:	85 ff                	test   %edi,%edi
80100752:	0f 85 bb 00 00 00    	jne    80100813 <cprintf+0x143>
}
80100758:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010075b:	5b                   	pop    %ebx
8010075c:	5e                   	pop    %esi
8010075d:	5f                   	pop    %edi
8010075e:	5d                   	pop    %ebp
8010075f:	c3                   	ret
  if(panicked){
80100760:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100766:	85 c9                	test   %ecx,%ecx
80100768:	74 19                	je     80100783 <cprintf+0xb3>
8010076a:	fa                   	cli
    for(;;)
8010076b:	eb fe                	jmp    8010076b <cprintf+0x9b>
8010076d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100770:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100776:	85 c9                	test   %ecx,%ecx
80100778:	0f 85 f2 00 00 00    	jne    80100870 <cprintf+0x1a0>
8010077e:	b8 25 00 00 00       	mov    $0x25,%eax
80100783:	e8 98 fc ff ff       	call   80100420 <consputc.part.0>
      break;
80100788:	eb b8                	jmp    80100742 <cprintf+0x72>
8010078a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100790:	83 f9 73             	cmp    $0x73,%ecx
80100793:	0f 84 8f 00 00 00    	je     80100828 <cprintf+0x158>
80100799:	83 f9 78             	cmp    $0x78,%ecx
8010079c:	74 32                	je     801007d0 <cprintf+0x100>
  if(panicked){
8010079e:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
801007a4:	85 d2                	test   %edx,%edx
801007a6:	0f 85 b8 00 00 00    	jne    80100864 <cprintf+0x194>
801007ac:	b8 25 00 00 00       	mov    $0x25,%eax
801007b1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801007b4:	e8 67 fc ff ff       	call   80100420 <consputc.part.0>
801007b9:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007be:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801007c1:	85 c0                	test   %eax,%eax
801007c3:	0f 84 cd 00 00 00    	je     80100896 <cprintf+0x1c6>
801007c9:	fa                   	cli
    for(;;)
801007ca:	eb fe                	jmp    801007ca <cprintf+0xfa>
801007cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
801007d0:	8d 47 04             	lea    0x4(%edi),%eax
801007d3:	31 c9                	xor    %ecx,%ecx
801007d5:	ba 10 00 00 00       	mov    $0x10,%edx
801007da:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007dd:	8b 07                	mov    (%edi),%eax
801007df:	e8 5c fe ff ff       	call   80100640 <printint>
801007e4:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
801007e7:	e9 56 ff ff ff       	jmp    80100742 <cprintf+0x72>
801007ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007f0:	83 ec 0c             	sub    $0xc,%esp
801007f3:	68 20 ff 10 80       	push   $0x8010ff20
801007f8:	e8 a3 43 00 00       	call   80104ba0 <acquire>
  if (fmt == 0)
801007fd:	83 c4 10             	add    $0x10,%esp
80100800:	85 f6                	test   %esi,%esi
80100802:	0f 84 a1 00 00 00    	je     801008a9 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100808:	0f b6 06             	movzbl (%esi),%eax
8010080b:	85 c0                	test   %eax,%eax
8010080d:	0f 85 e6 fe ff ff    	jne    801006f9 <cprintf+0x29>
    release(&cons.lock);
80100813:	83 ec 0c             	sub    $0xc,%esp
80100816:	68 20 ff 10 80       	push   $0x8010ff20
8010081b:	e8 00 45 00 00       	call   80104d20 <release>
80100820:	83 c4 10             	add    $0x10,%esp
80100823:	e9 30 ff ff ff       	jmp    80100758 <cprintf+0x88>
      if((s = (char*)*argp++) == 0)
80100828:	8b 17                	mov    (%edi),%edx
8010082a:	8d 47 04             	lea    0x4(%edi),%eax
8010082d:	85 d2                	test   %edx,%edx
8010082f:	74 27                	je     80100858 <cprintf+0x188>
      for(; *s; s++)
80100831:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100834:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100836:	84 c9                	test   %cl,%cl
80100838:	74 68                	je     801008a2 <cprintf+0x1d2>
8010083a:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010083d:	89 fb                	mov    %edi,%ebx
8010083f:	89 f7                	mov    %esi,%edi
80100841:	89 c6                	mov    %eax,%esi
80100843:	0f be c1             	movsbl %cl,%eax
  if(panicked){
80100846:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010084c:	85 d2                	test   %edx,%edx
8010084e:	74 28                	je     80100878 <cprintf+0x1a8>
80100850:	fa                   	cli
    for(;;)
80100851:	eb fe                	jmp    80100851 <cprintf+0x181>
80100853:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100858:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
8010085d:	bf b8 7a 10 80       	mov    $0x80107ab8,%edi
80100862:	eb d6                	jmp    8010083a <cprintf+0x16a>
80100864:	fa                   	cli
    for(;;)
80100865:	eb fe                	jmp    80100865 <cprintf+0x195>
80100867:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010086e:	00 
8010086f:	90                   	nop
80100870:	fa                   	cli
80100871:	eb fe                	jmp    80100871 <cprintf+0x1a1>
80100873:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100878:	e8 a3 fb ff ff       	call   80100420 <consputc.part.0>
      for(; *s; s++)
8010087d:	0f be 43 01          	movsbl 0x1(%ebx),%eax
80100881:	83 c3 01             	add    $0x1,%ebx
80100884:	84 c0                	test   %al,%al
80100886:	75 be                	jne    80100846 <cprintf+0x176>
      if((s = (char*)*argp++) == 0)
80100888:	89 f0                	mov    %esi,%eax
8010088a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010088d:	89 fe                	mov    %edi,%esi
8010088f:	89 c7                	mov    %eax,%edi
80100891:	e9 ac fe ff ff       	jmp    80100742 <cprintf+0x72>
80100896:	89 c8                	mov    %ecx,%eax
80100898:	e8 83 fb ff ff       	call   80100420 <consputc.part.0>
      break;
8010089d:	e9 a0 fe ff ff       	jmp    80100742 <cprintf+0x72>
      if((s = (char*)*argp++) == 0)
801008a2:	89 c7                	mov    %eax,%edi
801008a4:	e9 99 fe ff ff       	jmp    80100742 <cprintf+0x72>
    panic("null fmt");
801008a9:	83 ec 0c             	sub    $0xc,%esp
801008ac:	68 bf 7a 10 80       	push   $0x80107abf
801008b1:	e8 ea fa ff ff       	call   801003a0 <panic>
801008b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801008bd:	00 
801008be:	66 90                	xchg   %ax,%ax

801008c0 <consoleintr>:
{
801008c0:	55                   	push   %ebp
801008c1:	89 e5                	mov    %esp,%ebp
801008c3:	57                   	push   %edi
  int c, doprocdump = 0;
801008c4:	31 ff                	xor    %edi,%edi
{
801008c6:	56                   	push   %esi
801008c7:	53                   	push   %ebx
801008c8:	83 ec 18             	sub    $0x18,%esp
801008cb:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801008ce:	68 20 ff 10 80       	push   $0x8010ff20
801008d3:	e8 c8 42 00 00       	call   80104ba0 <acquire>
  while((c = getc()) >= 0){
801008d8:	83 c4 10             	add    $0x10,%esp
801008db:	ff d6                	call   *%esi
801008dd:	89 c3                	mov    %eax,%ebx
801008df:	85 c0                	test   %eax,%eax
801008e1:	78 22                	js     80100905 <consoleintr+0x45>
    switch(c){
801008e3:	83 fb 15             	cmp    $0x15,%ebx
801008e6:	74 40                	je     80100928 <consoleintr+0x68>
801008e8:	7f 76                	jg     80100960 <consoleintr+0xa0>
801008ea:	83 fb 08             	cmp    $0x8,%ebx
801008ed:	74 76                	je     80100965 <consoleintr+0xa5>
801008ef:	83 fb 10             	cmp    $0x10,%ebx
801008f2:	0f 85 32 01 00 00    	jne    80100a2a <consoleintr+0x16a>
  while((c = getc()) >= 0){
801008f8:	ff d6                	call   *%esi
    switch(c){
801008fa:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
801008ff:	89 c3                	mov    %eax,%ebx
80100901:	85 c0                	test   %eax,%eax
80100903:	79 de                	jns    801008e3 <consoleintr+0x23>
  release(&cons.lock);
80100905:	83 ec 0c             	sub    $0xc,%esp
80100908:	68 20 ff 10 80       	push   $0x8010ff20
8010090d:	e8 0e 44 00 00       	call   80104d20 <release>
  if(doprocdump) {
80100912:	83 c4 10             	add    $0x10,%esp
80100915:	85 ff                	test   %edi,%edi
80100917:	0f 85 71 01 00 00    	jne    80100a8e <consoleintr+0x1ce>
}
8010091d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100920:	5b                   	pop    %ebx
80100921:	5e                   	pop    %esi
80100922:	5f                   	pop    %edi
80100923:	5d                   	pop    %ebp
80100924:	c3                   	ret
80100925:	8d 76 00             	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100928:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010092d:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
80100933:	74 a6                	je     801008db <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100935:	83 e8 01             	sub    $0x1,%eax
80100938:	89 c2                	mov    %eax,%edx
8010093a:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
8010093d:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100944:	74 95                	je     801008db <consoleintr+0x1b>
  if(panicked){
80100946:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
8010094c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100951:	85 d2                	test   %edx,%edx
80100953:	74 3b                	je     80100990 <consoleintr+0xd0>
80100955:	fa                   	cli
    for(;;)
80100956:	eb fe                	jmp    80100956 <consoleintr+0x96>
80100958:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010095f:	00 
    switch(c){
80100960:	83 fb 7f             	cmp    $0x7f,%ebx
80100963:	75 4b                	jne    801009b0 <consoleintr+0xf0>
      if(input.e != input.w){
80100965:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010096a:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100970:	0f 84 65 ff ff ff    	je     801008db <consoleintr+0x1b>
        input.e--;
80100976:	83 e8 01             	sub    $0x1,%eax
80100979:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
8010097e:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100983:	85 c0                	test   %eax,%eax
80100985:	0f 84 f4 00 00 00    	je     80100a7f <consoleintr+0x1bf>
8010098b:	fa                   	cli
    for(;;)
8010098c:	eb fe                	jmp    8010098c <consoleintr+0xcc>
8010098e:	66 90                	xchg   %ax,%ax
80100990:	b8 00 01 00 00       	mov    $0x100,%eax
80100995:	e8 86 fa ff ff       	call   80100420 <consputc.part.0>
      while(input.e != input.w &&
8010099a:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010099f:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009a5:	75 8e                	jne    80100935 <consoleintr+0x75>
801009a7:	e9 2f ff ff ff       	jmp    801008db <consoleintr+0x1b>
801009ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009b0:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009b5:	89 c2                	mov    %eax,%edx
801009b7:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801009bd:	83 fa 7f             	cmp    $0x7f,%edx
801009c0:	0f 87 15 ff ff ff    	ja     801008db <consoleintr+0x1b>
  if(panicked){
801009c6:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
801009cc:	8d 50 01             	lea    0x1(%eax),%edx
801009cf:	83 e0 7f             	and    $0x7f,%eax
801009d2:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
801009d8:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  if(panicked){
801009de:	85 c9                	test   %ecx,%ecx
801009e0:	0f 85 b4 00 00 00    	jne    80100a9a <consoleintr+0x1da>
801009e6:	89 d8                	mov    %ebx,%eax
801009e8:	e8 33 fa ff ff       	call   80100420 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009ed:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009f2:	83 fb 0a             	cmp    $0xa,%ebx
801009f5:	74 19                	je     80100a10 <consoleintr+0x150>
801009f7:	83 fb 04             	cmp    $0x4,%ebx
801009fa:	74 14                	je     80100a10 <consoleintr+0x150>
801009fc:	8b 0d 00 ff 10 80    	mov    0x8010ff00,%ecx
80100a02:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
80100a08:	39 c2                	cmp    %eax,%edx
80100a0a:	0f 85 cb fe ff ff    	jne    801008db <consoleintr+0x1b>
          wakeup(&input.r);
80100a10:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a13:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
80100a18:	68 00 ff 10 80       	push   $0x8010ff00
80100a1d:	e8 ee 3b 00 00       	call   80104610 <wakeup>
80100a22:	83 c4 10             	add    $0x10,%esp
80100a25:	e9 b1 fe ff ff       	jmp    801008db <consoleintr+0x1b>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a2a:	85 db                	test   %ebx,%ebx
80100a2c:	0f 84 a9 fe ff ff    	je     801008db <consoleintr+0x1b>
80100a32:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100a37:	89 c2                	mov    %eax,%edx
80100a39:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
80100a3f:	83 fa 7f             	cmp    $0x7f,%edx
80100a42:	0f 87 93 fe ff ff    	ja     801008db <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a48:	8d 50 01             	lea    0x1(%eax),%edx
  if(panicked){
80100a4b:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
80100a51:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100a54:	83 fb 0d             	cmp    $0xd,%ebx
80100a57:	0f 85 75 ff ff ff    	jne    801009d2 <consoleintr+0x112>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a5d:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
80100a63:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
  if(panicked){
80100a6a:	85 c9                	test   %ecx,%ecx
80100a6c:	75 2c                	jne    80100a9a <consoleintr+0x1da>
80100a6e:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a73:	e8 a8 f9 ff ff       	call   80100420 <consputc.part.0>
          input.w = input.e;
80100a78:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100a7d:	eb 91                	jmp    80100a10 <consoleintr+0x150>
80100a7f:	b8 00 01 00 00       	mov    $0x100,%eax
80100a84:	e8 97 f9 ff ff       	call   80100420 <consputc.part.0>
80100a89:	e9 4d fe ff ff       	jmp    801008db <consoleintr+0x1b>
}
80100a8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a91:	5b                   	pop    %ebx
80100a92:	5e                   	pop    %esi
80100a93:	5f                   	pop    %edi
80100a94:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a95:	e9 66 3c 00 00       	jmp    80104700 <procdump>
80100a9a:	fa                   	cli
    for(;;)
80100a9b:	eb fe                	jmp    80100a9b <consoleintr+0x1db>
80100a9d:	8d 76 00             	lea    0x0(%esi),%esi

80100aa0 <consoleinit>:

void
consoleinit(void)
{
80100aa0:	55                   	push   %ebp
80100aa1:	89 e5                	mov    %esp,%ebp
80100aa3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100aa6:	68 c8 7a 10 80       	push   $0x80107ac8
80100aab:	68 20 ff 10 80       	push   $0x8010ff20
80100ab0:	e8 ab 3f 00 00       	call   80104a60 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100ab5:	58                   	pop    %eax
80100ab6:	5a                   	pop    %edx
80100ab7:	6a 00                	push   $0x0
80100ab9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100abb:	c7 05 ac 0a 11 80 d0 	movl   $0x801005d0,0x80110aac
80100ac2:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100ac5:	c7 05 a8 0a 11 80 a0 	movl   $0x801002a0,0x80110aa8
80100acc:	02 10 80 
  cons.locking = 1;
80100acf:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100ad6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100ad9:	e8 22 1a 00 00       	call   80102500 <ioapicenable>
}
80100ade:	83 c4 10             	add    $0x10,%esp
80100ae1:	c9                   	leave
80100ae2:	c3                   	ret
80100ae3:	66 90                	xchg   %ax,%ax
80100ae5:	66 90                	xchg   %ax,%ax
80100ae7:	66 90                	xchg   %ax,%ax
80100ae9:	66 90                	xchg   %ax,%ax
80100aeb:	66 90                	xchg   %ax,%ax
80100aed:	66 90                	xchg   %ax,%ax
80100aef:	90                   	nop

80100af0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100af0:	55                   	push   %ebp
80100af1:	89 e5                	mov    %esp,%ebp
80100af3:	57                   	push   %edi
80100af4:	56                   	push   %esi
80100af5:	53                   	push   %ebx
80100af6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100afc:	e8 bf 2e 00 00       	call   801039c0 <myproc>
80100b01:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100b07:	e8 34 23 00 00       	call   80102e40 <begin_op>

  if((ip = namei(path)) == 0){
80100b0c:	83 ec 0c             	sub    $0xc,%esp
80100b0f:	ff 75 08             	push   0x8(%ebp)
80100b12:	e8 e9 15 00 00       	call   80102100 <namei>
80100b17:	83 c4 10             	add    $0x10,%esp
80100b1a:	85 c0                	test   %eax,%eax
80100b1c:	0f 84 30 03 00 00    	je     80100e52 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b22:	83 ec 0c             	sub    $0xc,%esp
80100b25:	89 c7                	mov    %eax,%edi
80100b27:	50                   	push   %eax
80100b28:	e8 c3 0c 00 00       	call   801017f0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b2d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b33:	6a 34                	push   $0x34
80100b35:	6a 00                	push   $0x0
80100b37:	50                   	push   %eax
80100b38:	57                   	push   %edi
80100b39:	e8 c2 0f 00 00       	call   80101b00 <readi>
80100b3e:	83 c4 20             	add    $0x20,%esp
80100b41:	83 f8 34             	cmp    $0x34,%eax
80100b44:	0f 85 01 01 00 00    	jne    80100c4b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b4a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b51:	45 4c 46 
80100b54:	0f 85 f1 00 00 00    	jne    80100c4b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b5a:	e8 c1 6b 00 00       	call   80107720 <setupkvm>
80100b5f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b65:	85 c0                	test   %eax,%eax
80100b67:	0f 84 de 00 00 00    	je     80100c4b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b6d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b74:	00 
80100b75:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b7b:	0f 84 a1 02 00 00    	je     80100e22 <exec+0x332>
  sz = 0;
80100b81:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b88:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b8b:	31 db                	xor    %ebx,%ebx
80100b8d:	e9 8c 00 00 00       	jmp    80100c1e <exec+0x12e>
80100b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100b98:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b9f:	75 6c                	jne    80100c0d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100ba1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ba7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100bad:	0f 82 87 00 00 00    	jb     80100c3a <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100bb3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100bb9:	72 7f                	jb     80100c3a <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bbb:	83 ec 04             	sub    $0x4,%esp
80100bbe:	50                   	push   %eax
80100bbf:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100bc5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bcb:	e8 80 69 00 00       	call   80107550 <allocuvm>
80100bd0:	83 c4 10             	add    $0x10,%esp
80100bd3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bd9:	85 c0                	test   %eax,%eax
80100bdb:	74 5d                	je     80100c3a <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100bdd:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100be3:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100be8:	75 50                	jne    80100c3a <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bea:	83 ec 0c             	sub    $0xc,%esp
80100bed:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100bf3:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100bf9:	57                   	push   %edi
80100bfa:	50                   	push   %eax
80100bfb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c01:	e8 7a 68 00 00       	call   80107480 <loaduvm>
80100c06:	83 c4 20             	add    $0x20,%esp
80100c09:	85 c0                	test   %eax,%eax
80100c0b:	78 2d                	js     80100c3a <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c0d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c14:	83 c3 01             	add    $0x1,%ebx
80100c17:	83 c6 20             	add    $0x20,%esi
80100c1a:	39 d8                	cmp    %ebx,%eax
80100c1c:	7e 52                	jle    80100c70 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c1e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c24:	6a 20                	push   $0x20
80100c26:	56                   	push   %esi
80100c27:	50                   	push   %eax
80100c28:	57                   	push   %edi
80100c29:	e8 d2 0e 00 00       	call   80101b00 <readi>
80100c2e:	83 c4 10             	add    $0x10,%esp
80100c31:	83 f8 20             	cmp    $0x20,%eax
80100c34:	0f 84 5e ff ff ff    	je     80100b98 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100c3a:	83 ec 0c             	sub    $0xc,%esp
80100c3d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c43:	e8 58 6a 00 00       	call   801076a0 <freevm>
  if(ip){
80100c48:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100c4b:	83 ec 0c             	sub    $0xc,%esp
80100c4e:	57                   	push   %edi
80100c4f:	e8 2c 0e 00 00       	call   80101a80 <iunlockput>
    end_op();
80100c54:	e8 57 22 00 00       	call   80102eb0 <end_op>
80100c59:	83 c4 10             	add    $0x10,%esp
    return -1;
80100c5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100c61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c64:	5b                   	pop    %ebx
80100c65:	5e                   	pop    %esi
80100c66:	5f                   	pop    %edi
80100c67:	5d                   	pop    %ebp
80100c68:	c3                   	ret
80100c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100c70:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c76:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100c7c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c82:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100c88:	83 ec 0c             	sub    $0xc,%esp
80100c8b:	57                   	push   %edi
80100c8c:	e8 ef 0d 00 00       	call   80101a80 <iunlockput>
  end_op();
80100c91:	e8 1a 22 00 00       	call   80102eb0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c96:	83 c4 0c             	add    $0xc,%esp
80100c99:	53                   	push   %ebx
80100c9a:	56                   	push   %esi
80100c9b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100ca1:	56                   	push   %esi
80100ca2:	e8 a9 68 00 00       	call   80107550 <allocuvm>
80100ca7:	83 c4 10             	add    $0x10,%esp
80100caa:	89 c7                	mov    %eax,%edi
80100cac:	85 c0                	test   %eax,%eax
80100cae:	0f 84 86 00 00 00    	je     80100d3a <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cb4:	83 ec 08             	sub    $0x8,%esp
80100cb7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100cbd:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cbf:	50                   	push   %eax
80100cc0:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100cc1:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cc3:	e8 f8 6a 00 00       	call   801077c0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100cc8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ccb:	83 c4 10             	add    $0x10,%esp
80100cce:	8b 10                	mov    (%eax),%edx
80100cd0:	85 d2                	test   %edx,%edx
80100cd2:	0f 84 56 01 00 00    	je     80100e2e <exec+0x33e>
80100cd8:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100cde:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100ce1:	eb 23                	jmp    80100d06 <exec+0x216>
80100ce3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100ce8:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100ceb:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100cf2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100cf8:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100cfb:	85 d2                	test   %edx,%edx
80100cfd:	74 51                	je     80100d50 <exec+0x260>
    if(argc >= MAXARG)
80100cff:	83 f8 20             	cmp    $0x20,%eax
80100d02:	74 36                	je     80100d3a <exec+0x24a>
80100d04:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d06:	83 ec 0c             	sub    $0xc,%esp
80100d09:	52                   	push   %edx
80100d0a:	e8 31 43 00 00       	call   80105040 <strlen>
80100d0f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d11:	58                   	pop    %eax
80100d12:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d15:	83 eb 01             	sub    $0x1,%ebx
80100d18:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d1b:	e8 20 43 00 00       	call   80105040 <strlen>
80100d20:	83 c0 01             	add    $0x1,%eax
80100d23:	50                   	push   %eax
80100d24:	ff 34 b7             	push   (%edi,%esi,4)
80100d27:	53                   	push   %ebx
80100d28:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d2e:	e8 4d 6c 00 00       	call   80107980 <copyout>
80100d33:	83 c4 20             	add    $0x20,%esp
80100d36:	85 c0                	test   %eax,%eax
80100d38:	79 ae                	jns    80100ce8 <exec+0x1f8>
    freevm(pgdir);
80100d3a:	83 ec 0c             	sub    $0xc,%esp
80100d3d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d43:	e8 58 69 00 00       	call   801076a0 <freevm>
80100d48:	83 c4 10             	add    $0x10,%esp
80100d4b:	e9 0c ff ff ff       	jmp    80100c5c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d50:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100d57:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d5d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100d63:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100d66:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100d69:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100d70:	00 00 00 00 
  ustack[1] = argc;
80100d74:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100d7a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d81:	ff ff ff 
  ustack[1] = argc;
80100d84:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d8a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100d8c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d8e:	29 d0                	sub    %edx,%eax
80100d90:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d96:	56                   	push   %esi
80100d97:	51                   	push   %ecx
80100d98:	53                   	push   %ebx
80100d99:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d9f:	e8 dc 6b 00 00       	call   80107980 <copyout>
80100da4:	83 c4 10             	add    $0x10,%esp
80100da7:	85 c0                	test   %eax,%eax
80100da9:	78 8f                	js     80100d3a <exec+0x24a>
  for(last=s=path; *s; s++)
80100dab:	8b 45 08             	mov    0x8(%ebp),%eax
80100dae:	8b 55 08             	mov    0x8(%ebp),%edx
80100db1:	0f b6 00             	movzbl (%eax),%eax
80100db4:	84 c0                	test   %al,%al
80100db6:	74 17                	je     80100dcf <exec+0x2df>
80100db8:	89 d1                	mov    %edx,%ecx
80100dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100dc0:	83 c1 01             	add    $0x1,%ecx
80100dc3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100dc5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100dc8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100dcb:	84 c0                	test   %al,%al
80100dcd:	75 f1                	jne    80100dc0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100dcf:	83 ec 04             	sub    $0x4,%esp
80100dd2:	6a 10                	push   $0x10
80100dd4:	52                   	push   %edx
80100dd5:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100ddb:	8d 46 6c             	lea    0x6c(%esi),%eax
80100dde:	50                   	push   %eax
80100ddf:	e8 1c 42 00 00       	call   80105000 <safestrcpy>
  curproc->pgdir = pgdir;
80100de4:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100dea:	89 f0                	mov    %esi,%eax
80100dec:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100def:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100df1:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100df4:	89 c1                	mov    %eax,%ecx
80100df6:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dfc:	8b 40 18             	mov    0x18(%eax),%eax
80100dff:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100e02:	8b 41 18             	mov    0x18(%ecx),%eax
80100e05:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100e08:	89 0c 24             	mov    %ecx,(%esp)
80100e0b:	e8 e0 64 00 00       	call   801072f0 <switchuvm>
  freevm(oldpgdir);
80100e10:	89 34 24             	mov    %esi,(%esp)
80100e13:	e8 88 68 00 00       	call   801076a0 <freevm>
  return 0;
80100e18:	83 c4 10             	add    $0x10,%esp
80100e1b:	31 c0                	xor    %eax,%eax
80100e1d:	e9 3f fe ff ff       	jmp    80100c61 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e22:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100e27:	31 f6                	xor    %esi,%esi
80100e29:	e9 5a fe ff ff       	jmp    80100c88 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100e2e:	be 10 00 00 00       	mov    $0x10,%esi
80100e33:	ba 04 00 00 00       	mov    $0x4,%edx
80100e38:	b8 03 00 00 00       	mov    $0x3,%eax
80100e3d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100e44:	00 00 00 
80100e47:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e4d:	e9 17 ff ff ff       	jmp    80100d69 <exec+0x279>
    end_op();
80100e52:	e8 59 20 00 00       	call   80102eb0 <end_op>
    cprintf("exec: fail\n");
80100e57:	83 ec 0c             	sub    $0xc,%esp
80100e5a:	68 d0 7a 10 80       	push   $0x80107ad0
80100e5f:	e8 6c f8 ff ff       	call   801006d0 <cprintf>
    return -1;
80100e64:	83 c4 10             	add    $0x10,%esp
80100e67:	e9 f0 fd ff ff       	jmp    80100c5c <exec+0x16c>
80100e6c:	66 90                	xchg   %ax,%ax
80100e6e:	66 90                	xchg   %ax,%ax
80100e70:	66 90                	xchg   %ax,%ax
80100e72:	66 90                	xchg   %ax,%ax
80100e74:	66 90                	xchg   %ax,%ax
80100e76:	66 90                	xchg   %ax,%ax
80100e78:	66 90                	xchg   %ax,%ax
80100e7a:	66 90                	xchg   %ax,%ax
80100e7c:	66 90                	xchg   %ax,%ax
80100e7e:	66 90                	xchg   %ax,%ax

80100e80 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e80:	55                   	push   %ebp
80100e81:	89 e5                	mov    %esp,%ebp
80100e83:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e86:	68 dc 7a 10 80       	push   $0x80107adc
80100e8b:	68 60 ff 10 80       	push   $0x8010ff60
80100e90:	e8 cb 3b 00 00       	call   80104a60 <initlock>
}
80100e95:	83 c4 10             	add    $0x10,%esp
80100e98:	c9                   	leave
80100e99:	c3                   	ret
80100e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ea0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100ea0:	55                   	push   %ebp
80100ea1:	89 e5                	mov    %esp,%ebp
80100ea3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ea4:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100ea9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100eac:	68 60 ff 10 80       	push   $0x8010ff60
80100eb1:	e8 ea 3c 00 00       	call   80104ba0 <acquire>
80100eb6:	83 c4 10             	add    $0x10,%esp
80100eb9:	eb 10                	jmp    80100ecb <filealloc+0x2b>
80100ebb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ec0:	83 c3 1c             	add    $0x1c,%ebx
80100ec3:	81 fb 84 0a 11 80    	cmp    $0x80110a84,%ebx
80100ec9:	74 25                	je     80100ef0 <filealloc+0x50>
    if(f->ref == 0){
80100ecb:	8b 43 04             	mov    0x4(%ebx),%eax
80100ece:	85 c0                	test   %eax,%eax
80100ed0:	75 ee                	jne    80100ec0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100ed2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100ed5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100edc:	68 60 ff 10 80       	push   $0x8010ff60
80100ee1:	e8 3a 3e 00 00       	call   80104d20 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100ee6:	89 d8                	mov    %ebx,%eax
      return f;
80100ee8:	83 c4 10             	add    $0x10,%esp
}
80100eeb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100eee:	c9                   	leave
80100eef:	c3                   	ret
  release(&ftable.lock);
80100ef0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100ef3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100ef5:	68 60 ff 10 80       	push   $0x8010ff60
80100efa:	e8 21 3e 00 00       	call   80104d20 <release>
}
80100eff:	89 d8                	mov    %ebx,%eax
  return 0;
80100f01:	83 c4 10             	add    $0x10,%esp
}
80100f04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f07:	c9                   	leave
80100f08:	c3                   	ret
80100f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 10             	sub    $0x10,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f1a:	68 60 ff 10 80       	push   $0x8010ff60
80100f1f:	e8 7c 3c 00 00       	call   80104ba0 <acquire>
  if(f->ref < 1)
80100f24:	8b 43 04             	mov    0x4(%ebx),%eax
80100f27:	83 c4 10             	add    $0x10,%esp
80100f2a:	85 c0                	test   %eax,%eax
80100f2c:	7e 1a                	jle    80100f48 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f2e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100f31:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100f34:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f37:	68 60 ff 10 80       	push   $0x8010ff60
80100f3c:	e8 df 3d 00 00       	call   80104d20 <release>
  return f;
}
80100f41:	89 d8                	mov    %ebx,%eax
80100f43:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f46:	c9                   	leave
80100f47:	c3                   	ret
    panic("filedup");
80100f48:	83 ec 0c             	sub    $0xc,%esp
80100f4b:	68 e3 7a 10 80       	push   $0x80107ae3
80100f50:	e8 4b f4 ff ff       	call   801003a0 <panic>
80100f55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f5c:	00 
80100f5d:	8d 76 00             	lea    0x0(%esi),%esi

80100f60 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 28             	sub    $0x28,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f6c:	68 60 ff 10 80       	push   $0x8010ff60
80100f71:	e8 2a 3c 00 00       	call   80104ba0 <acquire>
  if(f->ref < 1)
80100f76:	8b 53 04             	mov    0x4(%ebx),%edx
80100f79:	83 c4 10             	add    $0x10,%esp
80100f7c:	85 d2                	test   %edx,%edx
80100f7e:	0f 8e a5 00 00 00    	jle    80101029 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100f84:	83 ea 01             	sub    $0x1,%edx
80100f87:	89 53 04             	mov    %edx,0x4(%ebx)
80100f8a:	75 44                	jne    80100fd0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f8c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f90:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f93:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f95:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f9b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f9e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100fa1:	8b 43 10             	mov    0x10(%ebx),%eax
80100fa4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100fa7:	68 60 ff 10 80       	push   $0x8010ff60
80100fac:	e8 6f 3d 00 00       	call   80104d20 <release>

  if(ff.type == FD_PIPE)
80100fb1:	83 c4 10             	add    $0x10,%esp
80100fb4:	83 ff 01             	cmp    $0x1,%edi
80100fb7:	74 57                	je     80101010 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100fb9:	83 ff 02             	cmp    $0x2,%edi
80100fbc:	74 2a                	je     80100fe8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100fbe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc1:	5b                   	pop    %ebx
80100fc2:	5e                   	pop    %esi
80100fc3:	5f                   	pop    %edi
80100fc4:	5d                   	pop    %ebp
80100fc5:	c3                   	ret
80100fc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fcd:	00 
80100fce:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80100fd0:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80100fd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fda:	5b                   	pop    %ebx
80100fdb:	5e                   	pop    %esi
80100fdc:	5f                   	pop    %edi
80100fdd:	5d                   	pop    %ebp
    release(&ftable.lock);
80100fde:	e9 3d 3d 00 00       	jmp    80104d20 <release>
80100fe3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80100fe8:	e8 53 1e 00 00       	call   80102e40 <begin_op>
    iput(ff.ip);
80100fed:	83 ec 0c             	sub    $0xc,%esp
80100ff0:	ff 75 e0             	push   -0x20(%ebp)
80100ff3:	e8 28 09 00 00       	call   80101920 <iput>
    end_op();
80100ff8:	83 c4 10             	add    $0x10,%esp
}
80100ffb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ffe:	5b                   	pop    %ebx
80100fff:	5e                   	pop    %esi
80101000:	5f                   	pop    %edi
80101001:	5d                   	pop    %ebp
    end_op();
80101002:	e9 a9 1e 00 00       	jmp    80102eb0 <end_op>
80101007:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010100e:	00 
8010100f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101010:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101014:	83 ec 08             	sub    $0x8,%esp
80101017:	53                   	push   %ebx
80101018:	56                   	push   %esi
80101019:	e8 d2 25 00 00       	call   801035f0 <pipeclose>
8010101e:	83 c4 10             	add    $0x10,%esp
}
80101021:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101024:	5b                   	pop    %ebx
80101025:	5e                   	pop    %esi
80101026:	5f                   	pop    %edi
80101027:	5d                   	pop    %ebp
80101028:	c3                   	ret
    panic("fileclose");
80101029:	83 ec 0c             	sub    $0xc,%esp
8010102c:	68 eb 7a 10 80       	push   $0x80107aeb
80101031:	e8 6a f3 ff ff       	call   801003a0 <panic>
80101036:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010103d:	00 
8010103e:	66 90                	xchg   %ax,%ax

80101040 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101040:	55                   	push   %ebp
80101041:	89 e5                	mov    %esp,%ebp
80101043:	53                   	push   %ebx
80101044:	83 ec 04             	sub    $0x4,%esp
80101047:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010104a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010104d:	75 31                	jne    80101080 <filestat+0x40>
    ilock(f->ip);
8010104f:	83 ec 0c             	sub    $0xc,%esp
80101052:	ff 73 10             	push   0x10(%ebx)
80101055:	e8 96 07 00 00       	call   801017f0 <ilock>
    stati(f->ip, st);
8010105a:	58                   	pop    %eax
8010105b:	5a                   	pop    %edx
8010105c:	ff 75 0c             	push   0xc(%ebp)
8010105f:	ff 73 10             	push   0x10(%ebx)
80101062:	e8 69 0a 00 00       	call   80101ad0 <stati>
    iunlock(f->ip);
80101067:	59                   	pop    %ecx
80101068:	ff 73 10             	push   0x10(%ebx)
8010106b:	e8 60 08 00 00       	call   801018d0 <iunlock>
    return 0;
  }
  return -1;
}
80101070:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101073:	83 c4 10             	add    $0x10,%esp
80101076:	31 c0                	xor    %eax,%eax
}
80101078:	c9                   	leave
80101079:	c3                   	ret
8010107a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101080:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101083:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101088:	c9                   	leave
80101089:	c3                   	ret
8010108a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101090 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101090:	55                   	push   %ebp
80101091:	89 e5                	mov    %esp,%ebp
80101093:	57                   	push   %edi
80101094:	56                   	push   %esi
80101095:	53                   	push   %ebx
80101096:	83 ec 0c             	sub    $0xc,%esp
80101099:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010109c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010109f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801010a2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010a6:	74 60                	je     80101108 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801010a8:	8b 03                	mov    (%ebx),%eax
801010aa:	83 f8 01             	cmp    $0x1,%eax
801010ad:	74 41                	je     801010f0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010af:	83 f8 02             	cmp    $0x2,%eax
801010b2:	75 5b                	jne    8010110f <fileread+0x7f>
    ilock(f->ip);
801010b4:	83 ec 0c             	sub    $0xc,%esp
801010b7:	ff 73 10             	push   0x10(%ebx)
801010ba:	e8 31 07 00 00       	call   801017f0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010bf:	57                   	push   %edi
801010c0:	ff 73 14             	push   0x14(%ebx)
801010c3:	56                   	push   %esi
801010c4:	ff 73 10             	push   0x10(%ebx)
801010c7:	e8 34 0a 00 00       	call   80101b00 <readi>
801010cc:	83 c4 20             	add    $0x20,%esp
801010cf:	89 c6                	mov    %eax,%esi
801010d1:	85 c0                	test   %eax,%eax
801010d3:	7e 03                	jle    801010d8 <fileread+0x48>
      f->off += r;
801010d5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801010d8:	83 ec 0c             	sub    $0xc,%esp
801010db:	ff 73 10             	push   0x10(%ebx)
801010de:	e8 ed 07 00 00       	call   801018d0 <iunlock>
    return r;
801010e3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	89 f0                	mov    %esi,%eax
801010eb:	5b                   	pop    %ebx
801010ec:	5e                   	pop    %esi
801010ed:	5f                   	pop    %edi
801010ee:	5d                   	pop    %ebp
801010ef:	c3                   	ret
    return piperead(f->pipe, addr, n);
801010f0:	8b 43 0c             	mov    0xc(%ebx),%eax
801010f3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010f9:	5b                   	pop    %ebx
801010fa:	5e                   	pop    %esi
801010fb:	5f                   	pop    %edi
801010fc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801010fd:	e9 ae 26 00 00       	jmp    801037b0 <piperead>
80101102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101108:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010110d:	eb d7                	jmp    801010e6 <fileread+0x56>
  panic("fileread");
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	68 f5 7a 10 80       	push   $0x80107af5
80101117:	e8 84 f2 ff ff       	call   801003a0 <panic>
8010111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101120 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	57                   	push   %edi
80101124:	56                   	push   %esi
80101125:	53                   	push   %ebx
80101126:	83 ec 1c             	sub    $0x1c,%esp
80101129:	8b 7d 08             	mov    0x8(%ebp),%edi
8010112c:	8b 45 10             	mov    0x10(%ebp),%eax
8010112f:	8b 55 0c             	mov    0xc(%ebp),%edx
  int r;

  if(f->writable == 0)
80101132:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
{
80101136:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101139:	0f 84 b6 00 00 00    	je     801011f5 <filewrite+0xd5>
    return -1;
  if(f->type == FD_PIPE)
8010113f:	8b 07                	mov    (%edi),%eax
80101141:	83 f8 01             	cmp    $0x1,%eax
80101144:	0f 84 ba 00 00 00    	je     80101204 <filewrite+0xe4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010114a:	83 f8 02             	cmp    $0x2,%eax
8010114d:	0f 85 c3 00 00 00    	jne    80101216 <filewrite+0xf6>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101153:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101156:	31 f6                	xor    %esi,%esi
    while(i < n){
80101158:	85 c0                	test   %eax,%eax
8010115a:	0f 8e 90 00 00 00    	jle    801011f0 <filewrite+0xd0>
    int i = 0;
80101160:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101163:	eb 28                	jmp    8010118d <filewrite+0x6d>
80101165:	8d 76 00             	lea    0x0(%esi),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101168:	01 47 14             	add    %eax,0x14(%edi)
      iunlock(f->ip);
8010116b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010116e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101171:	51                   	push   %ecx
80101172:	e8 59 07 00 00       	call   801018d0 <iunlock>
      end_op();
80101177:	e8 34 1d 00 00       	call   80102eb0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010117c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010117f:	83 c4 10             	add    $0x10,%esp
80101182:	39 d8                	cmp    %ebx,%eax
80101184:	75 5d                	jne    801011e3 <filewrite+0xc3>
        panic("short filewrite");
      i += r;
80101186:	01 c6                	add    %eax,%esi
    while(i < n){
80101188:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010118b:	7e 63                	jle    801011f0 <filewrite+0xd0>
      int n1 = n - i;
8010118d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
      if(n1 > max)
80101190:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101195:	29 f3                	sub    %esi,%ebx
      if(n1 > max)
80101197:	39 c3                	cmp    %eax,%ebx
80101199:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
8010119c:	e8 9f 1c 00 00       	call   80102e40 <begin_op>
      ilock(f->ip);
801011a1:	83 ec 0c             	sub    $0xc,%esp
801011a4:	ff 77 10             	push   0x10(%edi)
801011a7:	e8 44 06 00 00       	call   801017f0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011ac:	53                   	push   %ebx
801011ad:	ff 77 14             	push   0x14(%edi)
801011b0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011b3:	01 f0                	add    %esi,%eax
801011b5:	50                   	push   %eax
801011b6:	ff 77 10             	push   0x10(%edi)
801011b9:	e8 42 0a 00 00       	call   80101c00 <writei>
      iunlock(f->ip);
801011be:	8b 4f 10             	mov    0x10(%edi),%ecx
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011c1:	83 c4 20             	add    $0x20,%esp
801011c4:	85 c0                	test   %eax,%eax
801011c6:	7f a0                	jg     80101168 <filewrite+0x48>
      iunlock(f->ip);
801011c8:	83 ec 0c             	sub    $0xc,%esp
801011cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011ce:	51                   	push   %ecx
801011cf:	e8 fc 06 00 00       	call   801018d0 <iunlock>
      end_op();
801011d4:	e8 d7 1c 00 00       	call   80102eb0 <end_op>
      if(r < 0)
801011d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011dc:	83 c4 10             	add    $0x10,%esp
801011df:	85 c0                	test   %eax,%eax
801011e1:	75 0d                	jne    801011f0 <filewrite+0xd0>
        panic("short filewrite");
801011e3:	83 ec 0c             	sub    $0xc,%esp
801011e6:	68 fe 7a 10 80       	push   $0x80107afe
801011eb:	e8 b0 f1 ff ff       	call   801003a0 <panic>
    }
    return i == n ? n : -1;
801011f0:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801011f3:	74 05                	je     801011fa <filewrite+0xda>
    return -1;
801011f5:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
801011fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011fd:	89 f0                	mov    %esi,%eax
801011ff:	5b                   	pop    %ebx
80101200:	5e                   	pop    %esi
80101201:	5f                   	pop    %edi
80101202:	5d                   	pop    %ebp
80101203:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
80101204:	8b 47 0c             	mov    0xc(%edi),%eax
80101207:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010120a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010120d:	5b                   	pop    %ebx
8010120e:	5e                   	pop    %esi
8010120f:	5f                   	pop    %edi
80101210:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101211:	e9 7a 24 00 00       	jmp    80103690 <pipewrite>
  panic("filewrite");
80101216:	83 ec 0c             	sub    $0xc,%esp
80101219:	68 04 7b 10 80       	push   $0x80107b04
8010121e:	e8 7d f1 ff ff       	call   801003a0 <panic>
80101223:	66 90                	xchg   %ax,%ax
80101225:	66 90                	xchg   %ax,%ax
80101227:	66 90                	xchg   %ax,%ax
80101229:	66 90                	xchg   %ax,%ax
8010122b:	66 90                	xchg   %ax,%ax
8010122d:	66 90                	xchg   %ax,%ax
8010122f:	90                   	nop

80101230 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101230:	55                   	push   %ebp
80101231:	89 e5                	mov    %esp,%ebp
80101233:	57                   	push   %edi
80101234:	56                   	push   %esi
80101235:	53                   	push   %ebx
80101236:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101239:	8b 0d 54 27 11 80    	mov    0x80112754,%ecx
{
8010123f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101242:	85 c9                	test   %ecx,%ecx
80101244:	0f 84 8c 00 00 00    	je     801012d6 <balloc+0xa6>
8010124a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010124c:	89 f8                	mov    %edi,%eax
8010124e:	83 ec 08             	sub    $0x8,%esp
80101251:	89 fe                	mov    %edi,%esi
80101253:	c1 f8 0c             	sar    $0xc,%eax
80101256:	03 05 6c 27 11 80    	add    0x8011276c,%eax
8010125c:	50                   	push   %eax
8010125d:	ff 75 dc             	push   -0x24(%ebp)
80101260:	e8 6b ee ff ff       	call   801000d0 <bread>
80101265:	83 c4 10             	add    $0x10,%esp
80101268:	89 7d d8             	mov    %edi,-0x28(%ebp)
8010126b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010126e:	a1 54 27 11 80       	mov    0x80112754,%eax
80101273:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101276:	31 c0                	xor    %eax,%eax
80101278:	eb 32                	jmp    801012ac <balloc+0x7c>
8010127a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101280:	89 c1                	mov    %eax,%ecx
80101282:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101287:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010128a:	83 e1 07             	and    $0x7,%ecx
8010128d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010128f:	89 c1                	mov    %eax,%ecx
80101291:	c1 f9 03             	sar    $0x3,%ecx
80101294:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101299:	89 fa                	mov    %edi,%edx
8010129b:	85 df                	test   %ebx,%edi
8010129d:	74 49                	je     801012e8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010129f:	83 c0 01             	add    $0x1,%eax
801012a2:	83 c6 01             	add    $0x1,%esi
801012a5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012aa:	74 07                	je     801012b3 <balloc+0x83>
801012ac:	8b 55 e0             	mov    -0x20(%ebp),%edx
801012af:	39 d6                	cmp    %edx,%esi
801012b1:	72 cd                	jb     80101280 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801012b3:	8b 7d d8             	mov    -0x28(%ebp),%edi
801012b6:	83 ec 0c             	sub    $0xc,%esp
801012b9:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012bc:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
801012c2:	e8 39 ef ff ff       	call   80100200 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012c7:	83 c4 10             	add    $0x10,%esp
801012ca:	3b 3d 54 27 11 80    	cmp    0x80112754,%edi
801012d0:	0f 82 76 ff ff ff    	jb     8010124c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
801012d6:	83 ec 0c             	sub    $0xc,%esp
801012d9:	68 0e 7b 10 80       	push   $0x80107b0e
801012de:	e8 bd f0 ff ff       	call   801003a0 <panic>
801012e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801012e8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012eb:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012ee:	09 da                	or     %ebx,%edx
801012f0:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012f4:	57                   	push   %edi
801012f5:	e8 26 1d 00 00       	call   80103020 <log_write>
        brelse(bp);
801012fa:	89 3c 24             	mov    %edi,(%esp)
801012fd:	e8 fe ee ff ff       	call   80100200 <brelse>
  bp = bread(dev, bno);
80101302:	58                   	pop    %eax
80101303:	5a                   	pop    %edx
80101304:	56                   	push   %esi
80101305:	ff 75 dc             	push   -0x24(%ebp)
80101308:	e8 c3 ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
8010130d:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101310:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101312:	8d 40 5c             	lea    0x5c(%eax),%eax
80101315:	68 00 02 00 00       	push   $0x200
8010131a:	6a 00                	push   $0x0
8010131c:	50                   	push   %eax
8010131d:	e8 1e 3b 00 00       	call   80104e40 <memset>
  log_write(bp);
80101322:	89 1c 24             	mov    %ebx,(%esp)
80101325:	e8 f6 1c 00 00       	call   80103020 <log_write>
  brelse(bp);
8010132a:	89 1c 24             	mov    %ebx,(%esp)
8010132d:	e8 ce ee ff ff       	call   80100200 <brelse>
}
80101332:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101335:	89 f0                	mov    %esi,%eax
80101337:	5b                   	pop    %ebx
80101338:	5e                   	pop    %esi
80101339:	5f                   	pop    %edi
8010133a:	5d                   	pop    %ebp
8010133b:	c3                   	ret
8010133c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101340 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101340:	55                   	push   %ebp
80101341:	89 e5                	mov    %esp,%ebp
80101343:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101344:	31 ff                	xor    %edi,%edi
{
80101346:	56                   	push   %esi
80101347:	89 c6                	mov    %eax,%esi
80101349:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010134a:	bb 34 0b 11 80       	mov    $0x80110b34,%ebx
{
8010134f:	83 ec 28             	sub    $0x28,%esp
80101352:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101355:	68 00 0b 11 80       	push   $0x80110b00
8010135a:	e8 41 38 00 00       	call   80104ba0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010135f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101362:	83 c4 10             	add    $0x10,%esp
80101365:	eb 1b                	jmp    80101382 <iget+0x42>
80101367:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010136e:	00 
8010136f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101370:	39 33                	cmp    %esi,(%ebx)
80101372:	74 74                	je     801013e8 <iget+0xa8>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101374:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010137a:	81 fb 54 27 11 80    	cmp    $0x80112754,%ebx
80101380:	74 2e                	je     801013b0 <iget+0x70>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101382:	8b 43 08             	mov    0x8(%ebx),%eax
80101385:	85 c0                	test   %eax,%eax
80101387:	7f e7                	jg     80101370 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101389:	85 ff                	test   %edi,%edi
8010138b:	75 e7                	jne    80101374 <iget+0x34>
8010138d:	85 c0                	test   %eax,%eax
8010138f:	75 7e                	jne    8010140f <iget+0xcf>
      empty = ip;
80101391:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101393:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101399:	81 fb 54 27 11 80    	cmp    $0x80112754,%ebx
8010139f:	75 e1                	jne    80101382 <iget+0x42>
801013a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801013a8:	00 
801013a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801013b0:	85 ff                	test   %edi,%edi
801013b2:	74 79                	je     8010142d <iget+0xed>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801013b4:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801013b7:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
801013b9:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
801013bc:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
801013c3:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
801013ca:	68 00 0b 11 80       	push   $0x80110b00
801013cf:	e8 4c 39 00 00       	call   80104d20 <release>

  return ip;
801013d4:	83 c4 10             	add    $0x10,%esp
}
801013d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013da:	89 f8                	mov    %edi,%eax
801013dc:	5b                   	pop    %ebx
801013dd:	5e                   	pop    %esi
801013de:	5f                   	pop    %edi
801013df:	5d                   	pop    %ebp
801013e0:	c3                   	ret
801013e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013e8:	39 53 04             	cmp    %edx,0x4(%ebx)
801013eb:	75 87                	jne    80101374 <iget+0x34>
      ip->ref++;
801013ed:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
801013f0:	83 ec 0c             	sub    $0xc,%esp
      return ip;
801013f3:	89 df                	mov    %ebx,%edi
      ip->ref++;
801013f5:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
801013f8:	68 00 0b 11 80       	push   $0x80110b00
801013fd:	e8 1e 39 00 00       	call   80104d20 <release>
      return ip;
80101402:	83 c4 10             	add    $0x10,%esp
}
80101405:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101408:	89 f8                	mov    %edi,%eax
8010140a:	5b                   	pop    %ebx
8010140b:	5e                   	pop    %esi
8010140c:	5f                   	pop    %edi
8010140d:	5d                   	pop    %ebp
8010140e:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010140f:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101415:	81 fb 54 27 11 80    	cmp    $0x80112754,%ebx
8010141b:	74 10                	je     8010142d <iget+0xed>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010141d:	8b 43 08             	mov    0x8(%ebx),%eax
80101420:	85 c0                	test   %eax,%eax
80101422:	0f 8f 48 ff ff ff    	jg     80101370 <iget+0x30>
80101428:	e9 60 ff ff ff       	jmp    8010138d <iget+0x4d>
    panic("iget: no inodes");
8010142d:	83 ec 0c             	sub    $0xc,%esp
80101430:	68 24 7b 10 80       	push   $0x80107b24
80101435:	e8 66 ef ff ff       	call   801003a0 <panic>
8010143a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101440 <bfree>:
{
80101440:	55                   	push   %ebp
80101441:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80101443:	89 d0                	mov    %edx,%eax
80101445:	c1 e8 0c             	shr    $0xc,%eax
{
80101448:	89 e5                	mov    %esp,%ebp
8010144a:	56                   	push   %esi
8010144b:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
8010144c:	03 05 6c 27 11 80    	add    0x8011276c,%eax
{
80101452:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101454:	83 ec 08             	sub    $0x8,%esp
80101457:	50                   	push   %eax
80101458:	51                   	push   %ecx
80101459:	e8 72 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010145e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101460:	c1 fb 03             	sar    $0x3,%ebx
80101463:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101466:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101468:	83 e1 07             	and    $0x7,%ecx
8010146b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101470:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101476:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101478:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010147d:	85 c1                	test   %eax,%ecx
8010147f:	74 23                	je     801014a4 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80101481:	f7 d0                	not    %eax
  log_write(bp);
80101483:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101486:	21 c8                	and    %ecx,%eax
80101488:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010148c:	56                   	push   %esi
8010148d:	e8 8e 1b 00 00       	call   80103020 <log_write>
  brelse(bp);
80101492:	89 34 24             	mov    %esi,(%esp)
80101495:	e8 66 ed ff ff       	call   80100200 <brelse>
}
8010149a:	83 c4 10             	add    $0x10,%esp
8010149d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014a0:	5b                   	pop    %ebx
801014a1:	5e                   	pop    %esi
801014a2:	5d                   	pop    %ebp
801014a3:	c3                   	ret
    panic("freeing free block");
801014a4:	83 ec 0c             	sub    $0xc,%esp
801014a7:	68 34 7b 10 80       	push   $0x80107b34
801014ac:	e8 ef ee ff ff       	call   801003a0 <panic>
801014b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801014b8:	00 
801014b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801014c0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014c0:	55                   	push   %ebp
801014c1:	89 e5                	mov    %esp,%ebp
801014c3:	57                   	push   %edi
801014c4:	56                   	push   %esi
801014c5:	89 c6                	mov    %eax,%esi
801014c7:	53                   	push   %ebx
801014c8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014cb:	83 fa 0b             	cmp    $0xb,%edx
801014ce:	0f 86 8c 00 00 00    	jbe    80101560 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801014d4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801014d7:	83 fb 7f             	cmp    $0x7f,%ebx
801014da:	0f 87 a2 00 00 00    	ja     80101582 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801014e0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801014e6:	85 c0                	test   %eax,%eax
801014e8:	74 5e                	je     80101548 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801014ea:	83 ec 08             	sub    $0x8,%esp
801014ed:	50                   	push   %eax
801014ee:	ff 36                	push   (%esi)
801014f0:	e8 db eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801014f5:	83 c4 10             	add    $0x10,%esp
801014f8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801014fc:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
801014fe:	8b 3b                	mov    (%ebx),%edi
80101500:	85 ff                	test   %edi,%edi
80101502:	74 1c                	je     80101520 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101504:	83 ec 0c             	sub    $0xc,%esp
80101507:	52                   	push   %edx
80101508:	e8 f3 ec ff ff       	call   80100200 <brelse>
8010150d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101510:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101513:	89 f8                	mov    %edi,%eax
80101515:	5b                   	pop    %ebx
80101516:	5e                   	pop    %esi
80101517:	5f                   	pop    %edi
80101518:	5d                   	pop    %ebp
80101519:	c3                   	ret
8010151a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101520:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101523:	8b 06                	mov    (%esi),%eax
80101525:	e8 06 fd ff ff       	call   80101230 <balloc>
      log_write(bp);
8010152a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010152d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101530:	89 03                	mov    %eax,(%ebx)
80101532:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101534:	52                   	push   %edx
80101535:	e8 e6 1a 00 00       	call   80103020 <log_write>
8010153a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010153d:	83 c4 10             	add    $0x10,%esp
80101540:	eb c2                	jmp    80101504 <bmap+0x44>
80101542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101548:	8b 06                	mov    (%esi),%eax
8010154a:	e8 e1 fc ff ff       	call   80101230 <balloc>
8010154f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101555:	eb 93                	jmp    801014ea <bmap+0x2a>
80101557:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010155e:	00 
8010155f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101560:	8d 5a 14             	lea    0x14(%edx),%ebx
80101563:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101567:	85 ff                	test   %edi,%edi
80101569:	75 a5                	jne    80101510 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010156b:	8b 00                	mov    (%eax),%eax
8010156d:	e8 be fc ff ff       	call   80101230 <balloc>
80101572:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101576:	89 c7                	mov    %eax,%edi
}
80101578:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010157b:	5b                   	pop    %ebx
8010157c:	89 f8                	mov    %edi,%eax
8010157e:	5e                   	pop    %esi
8010157f:	5f                   	pop    %edi
80101580:	5d                   	pop    %ebp
80101581:	c3                   	ret
  panic("bmap: out of range");
80101582:	83 ec 0c             	sub    $0xc,%esp
80101585:	68 47 7b 10 80       	push   $0x80107b47
8010158a:	e8 11 ee ff ff       	call   801003a0 <panic>
8010158f:	90                   	nop

80101590 <readsb>:
{
80101590:	55                   	push   %ebp
80101591:	89 e5                	mov    %esp,%ebp
80101593:	56                   	push   %esi
80101594:	53                   	push   %ebx
80101595:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101598:	83 ec 08             	sub    $0x8,%esp
8010159b:	6a 01                	push   $0x1
8010159d:	ff 75 08             	push   0x8(%ebp)
801015a0:	e8 2b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015a5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015a8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015aa:	8d 40 5c             	lea    0x5c(%eax),%eax
801015ad:	6a 1c                	push   $0x1c
801015af:	50                   	push   %eax
801015b0:	56                   	push   %esi
801015b1:	e8 1a 39 00 00       	call   80104ed0 <memmove>
  brelse(bp);
801015b6:	83 c4 10             	add    $0x10,%esp
801015b9:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801015bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015bf:	5b                   	pop    %ebx
801015c0:	5e                   	pop    %esi
801015c1:	5d                   	pop    %ebp
  brelse(bp);
801015c2:	e9 39 ec ff ff       	jmp    80100200 <brelse>
801015c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801015ce:	00 
801015cf:	90                   	nop

801015d0 <iinit>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	53                   	push   %ebx
801015d4:	bb 40 0b 11 80       	mov    $0x80110b40,%ebx
801015d9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801015dc:	68 5a 7b 10 80       	push   $0x80107b5a
801015e1:	68 00 0b 11 80       	push   $0x80110b00
801015e6:	e8 75 34 00 00       	call   80104a60 <initlock>
  for(i = 0; i < NINODE; i++) {
801015eb:	83 c4 10             	add    $0x10,%esp
801015ee:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801015f0:	83 ec 08             	sub    $0x8,%esp
801015f3:	68 61 7b 10 80       	push   $0x80107b61
801015f8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801015f9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801015ff:	e8 1c 33 00 00       	call   80104920 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101604:	83 c4 10             	add    $0x10,%esp
80101607:	81 fb 60 27 11 80    	cmp    $0x80112760,%ebx
8010160d:	75 e1                	jne    801015f0 <iinit+0x20>
  bp = bread(dev, 1);
8010160f:	83 ec 08             	sub    $0x8,%esp
80101612:	6a 01                	push   $0x1
80101614:	ff 75 08             	push   0x8(%ebp)
80101617:	e8 b4 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010161c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010161f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101621:	8d 40 5c             	lea    0x5c(%eax),%eax
80101624:	6a 1c                	push   $0x1c
80101626:	50                   	push   %eax
80101627:	68 54 27 11 80       	push   $0x80112754
8010162c:	e8 9f 38 00 00       	call   80104ed0 <memmove>
  brelse(bp);
80101631:	89 1c 24             	mov    %ebx,(%esp)
80101634:	e8 c7 eb ff ff       	call   80100200 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101639:	ff 35 6c 27 11 80    	push   0x8011276c
8010163f:	ff 35 68 27 11 80    	push   0x80112768
80101645:	ff 35 64 27 11 80    	push   0x80112764
8010164b:	ff 35 60 27 11 80    	push   0x80112760
80101651:	ff 35 5c 27 11 80    	push   0x8011275c
80101657:	ff 35 58 27 11 80    	push   0x80112758
8010165d:	ff 35 54 27 11 80    	push   0x80112754
80101663:	68 6c 7f 10 80       	push   $0x80107f6c
80101668:	e8 63 f0 ff ff       	call   801006d0 <cprintf>
}
8010166d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101670:	83 c4 30             	add    $0x30,%esp
80101673:	c9                   	leave
80101674:	c3                   	ret
80101675:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010167c:	00 
8010167d:	8d 76 00             	lea    0x0(%esi),%esi

80101680 <ialloc>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	57                   	push   %edi
80101684:	56                   	push   %esi
80101685:	53                   	push   %ebx
80101686:	83 ec 1c             	sub    $0x1c,%esp
80101689:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010168c:	83 3d 5c 27 11 80 01 	cmpl   $0x1,0x8011275c
{
80101693:	8b 75 08             	mov    0x8(%ebp),%esi
80101696:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101699:	0f 86 91 00 00 00    	jbe    80101730 <ialloc+0xb0>
8010169f:	bf 01 00 00 00       	mov    $0x1,%edi
801016a4:	eb 21                	jmp    801016c7 <ialloc+0x47>
801016a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801016ad:	00 
801016ae:	66 90                	xchg   %ax,%ax
    brelse(bp);
801016b0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801016b3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801016b6:	53                   	push   %ebx
801016b7:	e8 44 eb ff ff       	call   80100200 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801016bc:	83 c4 10             	add    $0x10,%esp
801016bf:	3b 3d 5c 27 11 80    	cmp    0x8011275c,%edi
801016c5:	73 69                	jae    80101730 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801016c7:	89 f8                	mov    %edi,%eax
801016c9:	83 ec 08             	sub    $0x8,%esp
801016cc:	c1 e8 03             	shr    $0x3,%eax
801016cf:	03 05 68 27 11 80    	add    0x80112768,%eax
801016d5:	50                   	push   %eax
801016d6:	56                   	push   %esi
801016d7:	e8 f4 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801016dc:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801016df:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801016e1:	89 f8                	mov    %edi,%eax
801016e3:	83 e0 07             	and    $0x7,%eax
801016e6:	c1 e0 06             	shl    $0x6,%eax
801016e9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016ed:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016f1:	75 bd                	jne    801016b0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801016f3:	83 ec 04             	sub    $0x4,%esp
801016f6:	6a 40                	push   $0x40
801016f8:	6a 00                	push   $0x0
801016fa:	51                   	push   %ecx
801016fb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801016fe:	e8 3d 37 00 00       	call   80104e40 <memset>
      dip->type = type;
80101703:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101707:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010170a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010170d:	89 1c 24             	mov    %ebx,(%esp)
80101710:	e8 0b 19 00 00       	call   80103020 <log_write>
      brelse(bp);
80101715:	89 1c 24             	mov    %ebx,(%esp)
80101718:	e8 e3 ea ff ff       	call   80100200 <brelse>
      return iget(dev, inum);
8010171d:	83 c4 10             	add    $0x10,%esp
}
80101720:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101723:	89 fa                	mov    %edi,%edx
}
80101725:	5b                   	pop    %ebx
      return iget(dev, inum);
80101726:	89 f0                	mov    %esi,%eax
}
80101728:	5e                   	pop    %esi
80101729:	5f                   	pop    %edi
8010172a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010172b:	e9 10 fc ff ff       	jmp    80101340 <iget>
  panic("ialloc: no inodes");
80101730:	83 ec 0c             	sub    $0xc,%esp
80101733:	68 67 7b 10 80       	push   $0x80107b67
80101738:	e8 63 ec ff ff       	call   801003a0 <panic>
8010173d:	8d 76 00             	lea    0x0(%esi),%esi

80101740 <iupdate>:
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	56                   	push   %esi
80101744:	53                   	push   %ebx
80101745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101748:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010174b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010174e:	83 ec 08             	sub    $0x8,%esp
80101751:	c1 e8 03             	shr    $0x3,%eax
80101754:	03 05 68 27 11 80    	add    0x80112768,%eax
8010175a:	50                   	push   %eax
8010175b:	ff 73 a4             	push   -0x5c(%ebx)
8010175e:	e8 6d e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101763:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101767:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010176a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010176c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010176f:	83 e0 07             	and    $0x7,%eax
80101772:	c1 e0 06             	shl    $0x6,%eax
80101775:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101779:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010177c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101780:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101783:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101787:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010178b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010178f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101793:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101797:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010179a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010179d:	6a 34                	push   $0x34
8010179f:	53                   	push   %ebx
801017a0:	50                   	push   %eax
801017a1:	e8 2a 37 00 00       	call   80104ed0 <memmove>
  log_write(bp);
801017a6:	89 34 24             	mov    %esi,(%esp)
801017a9:	e8 72 18 00 00       	call   80103020 <log_write>
  brelse(bp);
801017ae:	83 c4 10             	add    $0x10,%esp
801017b1:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017b7:	5b                   	pop    %ebx
801017b8:	5e                   	pop    %esi
801017b9:	5d                   	pop    %ebp
  brelse(bp);
801017ba:	e9 41 ea ff ff       	jmp    80100200 <brelse>
801017bf:	90                   	nop

801017c0 <idup>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	53                   	push   %ebx
801017c4:	83 ec 10             	sub    $0x10,%esp
801017c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801017ca:	68 00 0b 11 80       	push   $0x80110b00
801017cf:	e8 cc 33 00 00       	call   80104ba0 <acquire>
  ip->ref++;
801017d4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017d8:	c7 04 24 00 0b 11 80 	movl   $0x80110b00,(%esp)
801017df:	e8 3c 35 00 00       	call   80104d20 <release>
}
801017e4:	89 d8                	mov    %ebx,%eax
801017e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017e9:	c9                   	leave
801017ea:	c3                   	ret
801017eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801017f0 <ilock>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	56                   	push   %esi
801017f4:	53                   	push   %ebx
801017f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801017f8:	85 db                	test   %ebx,%ebx
801017fa:	0f 84 b7 00 00 00    	je     801018b7 <ilock+0xc7>
80101800:	8b 53 08             	mov    0x8(%ebx),%edx
80101803:	85 d2                	test   %edx,%edx
80101805:	0f 8e ac 00 00 00    	jle    801018b7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010180b:	83 ec 0c             	sub    $0xc,%esp
8010180e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101811:	50                   	push   %eax
80101812:	e8 49 31 00 00       	call   80104960 <acquiresleep>
  if(ip->valid == 0){
80101817:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010181a:	83 c4 10             	add    $0x10,%esp
8010181d:	85 c0                	test   %eax,%eax
8010181f:	74 0f                	je     80101830 <ilock+0x40>
}
80101821:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101824:	5b                   	pop    %ebx
80101825:	5e                   	pop    %esi
80101826:	5d                   	pop    %ebp
80101827:	c3                   	ret
80101828:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010182f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101830:	8b 43 04             	mov    0x4(%ebx),%eax
80101833:	83 ec 08             	sub    $0x8,%esp
80101836:	c1 e8 03             	shr    $0x3,%eax
80101839:	03 05 68 27 11 80    	add    0x80112768,%eax
8010183f:	50                   	push   %eax
80101840:	ff 33                	push   (%ebx)
80101842:	e8 89 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101847:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010184a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010184c:	8b 43 04             	mov    0x4(%ebx),%eax
8010184f:	83 e0 07             	and    $0x7,%eax
80101852:	c1 e0 06             	shl    $0x6,%eax
80101855:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101859:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010185c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010185f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101863:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101867:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010186b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010186f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101873:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101877:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010187b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010187e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101881:	6a 34                	push   $0x34
80101883:	50                   	push   %eax
80101884:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101887:	50                   	push   %eax
80101888:	e8 43 36 00 00       	call   80104ed0 <memmove>
    brelse(bp);
8010188d:	89 34 24             	mov    %esi,(%esp)
80101890:	e8 6b e9 ff ff       	call   80100200 <brelse>
    if(ip->type == 0)
80101895:	83 c4 10             	add    $0x10,%esp
80101898:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010189d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801018a4:	0f 85 77 ff ff ff    	jne    80101821 <ilock+0x31>
      panic("ilock: no type");
801018aa:	83 ec 0c             	sub    $0xc,%esp
801018ad:	68 7f 7b 10 80       	push   $0x80107b7f
801018b2:	e8 e9 ea ff ff       	call   801003a0 <panic>
    panic("ilock");
801018b7:	83 ec 0c             	sub    $0xc,%esp
801018ba:	68 79 7b 10 80       	push   $0x80107b79
801018bf:	e8 dc ea ff ff       	call   801003a0 <panic>
801018c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801018cb:	00 
801018cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018d0 <iunlock>:
{
801018d0:	55                   	push   %ebp
801018d1:	89 e5                	mov    %esp,%ebp
801018d3:	56                   	push   %esi
801018d4:	53                   	push   %ebx
801018d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801018d8:	85 db                	test   %ebx,%ebx
801018da:	74 28                	je     80101904 <iunlock+0x34>
801018dc:	83 ec 0c             	sub    $0xc,%esp
801018df:	8d 73 0c             	lea    0xc(%ebx),%esi
801018e2:	56                   	push   %esi
801018e3:	e8 18 31 00 00       	call   80104a00 <holdingsleep>
801018e8:	83 c4 10             	add    $0x10,%esp
801018eb:	85 c0                	test   %eax,%eax
801018ed:	74 15                	je     80101904 <iunlock+0x34>
801018ef:	8b 43 08             	mov    0x8(%ebx),%eax
801018f2:	85 c0                	test   %eax,%eax
801018f4:	7e 0e                	jle    80101904 <iunlock+0x34>
  releasesleep(&ip->lock);
801018f6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801018f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018fc:	5b                   	pop    %ebx
801018fd:	5e                   	pop    %esi
801018fe:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801018ff:	e9 bc 30 00 00       	jmp    801049c0 <releasesleep>
    panic("iunlock");
80101904:	83 ec 0c             	sub    $0xc,%esp
80101907:	68 8e 7b 10 80       	push   $0x80107b8e
8010190c:	e8 8f ea ff ff       	call   801003a0 <panic>
80101911:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101918:	00 
80101919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101920 <iput>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	57                   	push   %edi
80101924:	56                   	push   %esi
80101925:	53                   	push   %ebx
80101926:	83 ec 28             	sub    $0x28,%esp
80101929:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010192c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010192f:	57                   	push   %edi
80101930:	e8 2b 30 00 00       	call   80104960 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101935:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101938:	83 c4 10             	add    $0x10,%esp
8010193b:	85 d2                	test   %edx,%edx
8010193d:	74 07                	je     80101946 <iput+0x26>
8010193f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101944:	74 32                	je     80101978 <iput+0x58>
  releasesleep(&ip->lock);
80101946:	83 ec 0c             	sub    $0xc,%esp
80101949:	57                   	push   %edi
8010194a:	e8 71 30 00 00       	call   801049c0 <releasesleep>
  acquire(&icache.lock);
8010194f:	c7 04 24 00 0b 11 80 	movl   $0x80110b00,(%esp)
80101956:	e8 45 32 00 00       	call   80104ba0 <acquire>
  ip->ref--;
8010195b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010195f:	83 c4 10             	add    $0x10,%esp
80101962:	c7 45 08 00 0b 11 80 	movl   $0x80110b00,0x8(%ebp)
}
80101969:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010196c:	5b                   	pop    %ebx
8010196d:	5e                   	pop    %esi
8010196e:	5f                   	pop    %edi
8010196f:	5d                   	pop    %ebp
  release(&icache.lock);
80101970:	e9 ab 33 00 00       	jmp    80104d20 <release>
80101975:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101978:	83 ec 0c             	sub    $0xc,%esp
8010197b:	68 00 0b 11 80       	push   $0x80110b00
80101980:	e8 1b 32 00 00       	call   80104ba0 <acquire>
    int r = ip->ref;
80101985:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101988:	c7 04 24 00 0b 11 80 	movl   $0x80110b00,(%esp)
8010198f:	e8 8c 33 00 00       	call   80104d20 <release>
    if(r == 1){
80101994:	83 c4 10             	add    $0x10,%esp
80101997:	83 fe 01             	cmp    $0x1,%esi
8010199a:	75 aa                	jne    80101946 <iput+0x26>
8010199c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801019a2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019a5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801019a8:	89 df                	mov    %ebx,%edi
801019aa:	89 cb                	mov    %ecx,%ebx
801019ac:	eb 09                	jmp    801019b7 <iput+0x97>
801019ae:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801019b0:	83 c6 04             	add    $0x4,%esi
801019b3:	39 de                	cmp    %ebx,%esi
801019b5:	74 19                	je     801019d0 <iput+0xb0>
    if(ip->addrs[i]){
801019b7:	8b 16                	mov    (%esi),%edx
801019b9:	85 d2                	test   %edx,%edx
801019bb:	74 f3                	je     801019b0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801019bd:	8b 07                	mov    (%edi),%eax
801019bf:	e8 7c fa ff ff       	call   80101440 <bfree>
      ip->addrs[i] = 0;
801019c4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801019ca:	eb e4                	jmp    801019b0 <iput+0x90>
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801019d0:	89 fb                	mov    %edi,%ebx
801019d2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019d5:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801019db:	85 c0                	test   %eax,%eax
801019dd:	75 2d                	jne    80101a0c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801019df:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801019e2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019e9:	53                   	push   %ebx
801019ea:	e8 51 fd ff ff       	call   80101740 <iupdate>
      ip->type = 0;
801019ef:	31 c0                	xor    %eax,%eax
801019f1:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801019f5:	89 1c 24             	mov    %ebx,(%esp)
801019f8:	e8 43 fd ff ff       	call   80101740 <iupdate>
      ip->valid = 0;
801019fd:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a04:	83 c4 10             	add    $0x10,%esp
80101a07:	e9 3a ff ff ff       	jmp    80101946 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a0c:	83 ec 08             	sub    $0x8,%esp
80101a0f:	50                   	push   %eax
80101a10:	ff 33                	push   (%ebx)
80101a12:	e8 b9 e6 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101a17:	83 c4 10             	add    $0x10,%esp
80101a1a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a1d:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101a23:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a26:	8d 70 5c             	lea    0x5c(%eax),%esi
80101a29:	89 cf                	mov    %ecx,%edi
80101a2b:	eb 0a                	jmp    80101a37 <iput+0x117>
80101a2d:	8d 76 00             	lea    0x0(%esi),%esi
80101a30:	83 c6 04             	add    $0x4,%esi
80101a33:	39 fe                	cmp    %edi,%esi
80101a35:	74 0f                	je     80101a46 <iput+0x126>
      if(a[j])
80101a37:	8b 16                	mov    (%esi),%edx
80101a39:	85 d2                	test   %edx,%edx
80101a3b:	74 f3                	je     80101a30 <iput+0x110>
        bfree(ip->dev, a[j]);
80101a3d:	8b 03                	mov    (%ebx),%eax
80101a3f:	e8 fc f9 ff ff       	call   80101440 <bfree>
80101a44:	eb ea                	jmp    80101a30 <iput+0x110>
    brelse(bp);
80101a46:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a49:	83 ec 0c             	sub    $0xc,%esp
80101a4c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a4f:	50                   	push   %eax
80101a50:	e8 ab e7 ff ff       	call   80100200 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a55:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a5b:	8b 03                	mov    (%ebx),%eax
80101a5d:	e8 de f9 ff ff       	call   80101440 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a62:	83 c4 10             	add    $0x10,%esp
80101a65:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a6c:	00 00 00 
80101a6f:	e9 6b ff ff ff       	jmp    801019df <iput+0xbf>
80101a74:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a7b:	00 
80101a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a80 <iunlockput>:
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	56                   	push   %esi
80101a84:	53                   	push   %ebx
80101a85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a88:	85 db                	test   %ebx,%ebx
80101a8a:	74 34                	je     80101ac0 <iunlockput+0x40>
80101a8c:	83 ec 0c             	sub    $0xc,%esp
80101a8f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a92:	56                   	push   %esi
80101a93:	e8 68 2f 00 00       	call   80104a00 <holdingsleep>
80101a98:	83 c4 10             	add    $0x10,%esp
80101a9b:	85 c0                	test   %eax,%eax
80101a9d:	74 21                	je     80101ac0 <iunlockput+0x40>
80101a9f:	8b 43 08             	mov    0x8(%ebx),%eax
80101aa2:	85 c0                	test   %eax,%eax
80101aa4:	7e 1a                	jle    80101ac0 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101aa6:	83 ec 0c             	sub    $0xc,%esp
80101aa9:	56                   	push   %esi
80101aaa:	e8 11 2f 00 00       	call   801049c0 <releasesleep>
  iput(ip);
80101aaf:	83 c4 10             	add    $0x10,%esp
80101ab2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101ab5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101ab8:	5b                   	pop    %ebx
80101ab9:	5e                   	pop    %esi
80101aba:	5d                   	pop    %ebp
  iput(ip);
80101abb:	e9 60 fe ff ff       	jmp    80101920 <iput>
    panic("iunlock");
80101ac0:	83 ec 0c             	sub    $0xc,%esp
80101ac3:	68 8e 7b 10 80       	push   $0x80107b8e
80101ac8:	e8 d3 e8 ff ff       	call   801003a0 <panic>
80101acd:	8d 76 00             	lea    0x0(%esi),%esi

80101ad0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ad6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ad9:	8b 0a                	mov    (%edx),%ecx
80101adb:	89 08                	mov    %ecx,(%eax)
  st->ino = ip->inum;
80101add:	8b 4a 04             	mov    0x4(%edx),%ecx
80101ae0:	89 48 04             	mov    %ecx,0x4(%eax)
  st->type = ip->type;
80101ae3:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101ae7:	66 89 48 08          	mov    %cx,0x8(%eax)
  st->nlink = ip->nlink;
80101aeb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101aef:	66 89 48 0a          	mov    %cx,0xa(%eax)
  st->size = ip->size;
80101af3:	8b 52 58             	mov    0x58(%edx),%edx
80101af6:	89 50 0c             	mov    %edx,0xc(%eax)
}
80101af9:	5d                   	pop    %ebp
80101afa:	c3                   	ret
80101afb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101b00 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	57                   	push   %edi
80101b04:	56                   	push   %esi
80101b05:	53                   	push   %ebx
80101b06:	83 ec 1c             	sub    $0x1c,%esp
80101b09:	8b 75 08             	mov    0x8(%ebp),%esi
80101b0c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b0f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b12:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101b17:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101b1a:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101b1d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101b20:	0f 84 aa 00 00 00    	je     80101bd0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b26:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101b29:	8b 56 58             	mov    0x58(%esi),%edx
80101b2c:	39 fa                	cmp    %edi,%edx
80101b2e:	0f 82 bd 00 00 00    	jb     80101bf1 <readi+0xf1>
80101b34:	89 f9                	mov    %edi,%ecx
80101b36:	31 db                	xor    %ebx,%ebx
80101b38:	01 c1                	add    %eax,%ecx
80101b3a:	0f 92 c3             	setb   %bl
80101b3d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101b40:	0f 82 ab 00 00 00    	jb     80101bf1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b46:	89 d3                	mov    %edx,%ebx
80101b48:	29 fb                	sub    %edi,%ebx
80101b4a:	39 ca                	cmp    %ecx,%edx
80101b4c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b4f:	85 c0                	test   %eax,%eax
80101b51:	74 73                	je     80101bc6 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101b53:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101b56:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b60:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b63:	89 fa                	mov    %edi,%edx
80101b65:	c1 ea 09             	shr    $0x9,%edx
80101b68:	89 d8                	mov    %ebx,%eax
80101b6a:	e8 51 f9 ff ff       	call   801014c0 <bmap>
80101b6f:	83 ec 08             	sub    $0x8,%esp
80101b72:	50                   	push   %eax
80101b73:	ff 33                	push   (%ebx)
80101b75:	e8 56 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b7d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b82:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b84:	89 f8                	mov    %edi,%eax
80101b86:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b8b:	29 f3                	sub    %esi,%ebx
80101b8d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b8f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b93:	39 d9                	cmp    %ebx,%ecx
80101b95:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b98:	83 c4 0c             	add    $0xc,%esp
80101b9b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b9c:	01 de                	add    %ebx,%esi
80101b9e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101ba0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ba3:	50                   	push   %eax
80101ba4:	ff 75 e0             	push   -0x20(%ebp)
80101ba7:	e8 24 33 00 00       	call   80104ed0 <memmove>
    brelse(bp);
80101bac:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101baf:	89 14 24             	mov    %edx,(%esp)
80101bb2:	e8 49 e6 ff ff       	call   80100200 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bb7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101bba:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101bbd:	83 c4 10             	add    $0x10,%esp
80101bc0:	39 de                	cmp    %ebx,%esi
80101bc2:	72 9c                	jb     80101b60 <readi+0x60>
80101bc4:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101bc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bc9:	5b                   	pop    %ebx
80101bca:	5e                   	pop    %esi
80101bcb:	5f                   	pop    %edi
80101bcc:	5d                   	pop    %ebp
80101bcd:	c3                   	ret
80101bce:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101bd0:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101bd4:	66 83 fa 09          	cmp    $0x9,%dx
80101bd8:	77 17                	ja     80101bf1 <readi+0xf1>
80101bda:	8b 14 d5 a0 0a 11 80 	mov    -0x7feef560(,%edx,8),%edx
80101be1:	85 d2                	test   %edx,%edx
80101be3:	74 0c                	je     80101bf1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101be5:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101be8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101beb:	5b                   	pop    %ebx
80101bec:	5e                   	pop    %esi
80101bed:	5f                   	pop    %edi
80101bee:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101bef:	ff e2                	jmp    *%edx
      return -1;
80101bf1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bf6:	eb ce                	jmp    80101bc6 <readi+0xc6>
80101bf8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101bff:	00 

80101c00 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	57                   	push   %edi
80101c04:	56                   	push   %esi
80101c05:	53                   	push   %ebx
80101c06:	83 ec 1c             	sub    $0x1c,%esp
80101c09:	8b 45 08             	mov    0x8(%ebp),%eax
80101c0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101c0f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c12:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c17:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101c1a:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101c1d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101c20:	0f 84 ba 00 00 00    	je     80101ce0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c26:	39 78 58             	cmp    %edi,0x58(%eax)
80101c29:	0f 82 ea 00 00 00    	jb     80101d19 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c2f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101c32:	89 f2                	mov    %esi,%edx
80101c34:	01 fa                	add    %edi,%edx
80101c36:	0f 82 dd 00 00 00    	jb     80101d19 <writei+0x119>
80101c3c:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101c42:	0f 87 d1 00 00 00    	ja     80101d19 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c48:	85 f6                	test   %esi,%esi
80101c4a:	0f 84 85 00 00 00    	je     80101cd5 <writei+0xd5>
80101c50:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101c57:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c60:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101c63:	89 fa                	mov    %edi,%edx
80101c65:	c1 ea 09             	shr    $0x9,%edx
80101c68:	89 f0                	mov    %esi,%eax
80101c6a:	e8 51 f8 ff ff       	call   801014c0 <bmap>
80101c6f:	83 ec 08             	sub    $0x8,%esp
80101c72:	50                   	push   %eax
80101c73:	ff 36                	push   (%esi)
80101c75:	e8 56 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c7a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c7d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c80:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c85:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c87:	89 f8                	mov    %edi,%eax
80101c89:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c8e:	29 d3                	sub    %edx,%ebx
80101c90:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c92:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c96:	39 d9                	cmp    %ebx,%ecx
80101c98:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c9b:	83 c4 0c             	add    $0xc,%esp
80101c9e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c9f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101ca1:	ff 75 dc             	push   -0x24(%ebp)
80101ca4:	50                   	push   %eax
80101ca5:	e8 26 32 00 00       	call   80104ed0 <memmove>
    log_write(bp);
80101caa:	89 34 24             	mov    %esi,(%esp)
80101cad:	e8 6e 13 00 00       	call   80103020 <log_write>
    brelse(bp);
80101cb2:	89 34 24             	mov    %esi,(%esp)
80101cb5:	e8 46 e5 ff ff       	call   80100200 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cba:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101cbd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101cc0:	83 c4 10             	add    $0x10,%esp
80101cc3:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101cc6:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101cc9:	39 d8                	cmp    %ebx,%eax
80101ccb:	72 93                	jb     80101c60 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101ccd:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cd0:	39 78 58             	cmp    %edi,0x58(%eax)
80101cd3:	72 33                	jb     80101d08 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101cd5:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101cd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cdb:	5b                   	pop    %ebx
80101cdc:	5e                   	pop    %esi
80101cdd:	5f                   	pop    %edi
80101cde:	5d                   	pop    %ebp
80101cdf:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ce0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ce4:	66 83 f8 09          	cmp    $0x9,%ax
80101ce8:	77 2f                	ja     80101d19 <writei+0x119>
80101cea:	8b 04 c5 a4 0a 11 80 	mov    -0x7feef55c(,%eax,8),%eax
80101cf1:	85 c0                	test   %eax,%eax
80101cf3:	74 24                	je     80101d19 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80101cf5:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101cf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cfb:	5b                   	pop    %ebx
80101cfc:	5e                   	pop    %esi
80101cfd:	5f                   	pop    %edi
80101cfe:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101cff:	ff e0                	jmp    *%eax
80101d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101d08:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101d0b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101d0e:	50                   	push   %eax
80101d0f:	e8 2c fa ff ff       	call   80101740 <iupdate>
80101d14:	83 c4 10             	add    $0x10,%esp
80101d17:	eb bc                	jmp    80101cd5 <writei+0xd5>
      return -1;
80101d19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d1e:	eb b8                	jmp    80101cd8 <writei+0xd8>

80101d20 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d26:	6a 0e                	push   $0xe
80101d28:	ff 75 0c             	push   0xc(%ebp)
80101d2b:	ff 75 08             	push   0x8(%ebp)
80101d2e:	e8 0d 32 00 00       	call   80104f40 <strncmp>
}
80101d33:	c9                   	leave
80101d34:	c3                   	ret
80101d35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d3c:	00 
80101d3d:	8d 76 00             	lea    0x0(%esi),%esi

80101d40 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	56                   	push   %esi
80101d45:	53                   	push   %ebx
80101d46:	83 ec 1c             	sub    $0x1c,%esp
80101d49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d4c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d51:	0f 85 8d 00 00 00    	jne    80101de4 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d57:	8b 53 58             	mov    0x58(%ebx),%edx
80101d5a:	31 ff                	xor    %edi,%edi
80101d5c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d5f:	85 d2                	test   %edx,%edx
80101d61:	74 46                	je     80101da9 <dirlookup+0x69>
80101d63:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d6a:	00 
80101d6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d70:	6a 10                	push   $0x10
80101d72:	57                   	push   %edi
80101d73:	56                   	push   %esi
80101d74:	53                   	push   %ebx
80101d75:	e8 86 fd ff ff       	call   80101b00 <readi>
80101d7a:	83 c4 10             	add    $0x10,%esp
80101d7d:	83 f8 10             	cmp    $0x10,%eax
80101d80:	75 55                	jne    80101dd7 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
80101d82:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d87:	74 18                	je     80101da1 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
80101d89:	83 ec 04             	sub    $0x4,%esp
80101d8c:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d8f:	6a 0e                	push   $0xe
80101d91:	50                   	push   %eax
80101d92:	ff 75 0c             	push   0xc(%ebp)
80101d95:	e8 a6 31 00 00       	call   80104f40 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d9a:	83 c4 10             	add    $0x10,%esp
80101d9d:	85 c0                	test   %eax,%eax
80101d9f:	74 17                	je     80101db8 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101da1:	83 c7 10             	add    $0x10,%edi
80101da4:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101da7:	72 c7                	jb     80101d70 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101da9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101dac:	31 c0                	xor    %eax,%eax
}
80101dae:	5b                   	pop    %ebx
80101daf:	5e                   	pop    %esi
80101db0:	5f                   	pop    %edi
80101db1:	5d                   	pop    %ebp
80101db2:	c3                   	ret
80101db3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101db8:	8b 45 10             	mov    0x10(%ebp),%eax
80101dbb:	85 c0                	test   %eax,%eax
80101dbd:	74 05                	je     80101dc4 <dirlookup+0x84>
        *poff = off;
80101dbf:	8b 45 10             	mov    0x10(%ebp),%eax
80101dc2:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101dc4:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101dc8:	8b 03                	mov    (%ebx),%eax
80101dca:	e8 71 f5 ff ff       	call   80101340 <iget>
}
80101dcf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd2:	5b                   	pop    %ebx
80101dd3:	5e                   	pop    %esi
80101dd4:	5f                   	pop    %edi
80101dd5:	5d                   	pop    %ebp
80101dd6:	c3                   	ret
      panic("dirlookup read");
80101dd7:	83 ec 0c             	sub    $0xc,%esp
80101dda:	68 a8 7b 10 80       	push   $0x80107ba8
80101ddf:	e8 bc e5 ff ff       	call   801003a0 <panic>
    panic("dirlookup not DIR");
80101de4:	83 ec 0c             	sub    $0xc,%esp
80101de7:	68 96 7b 10 80       	push   $0x80107b96
80101dec:	e8 af e5 ff ff       	call   801003a0 <panic>
80101df1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101df8:	00 
80101df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e00 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	89 c3                	mov    %eax,%ebx
80101e08:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e0b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101e0e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e11:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101e14:	0f 84 be 01 00 00    	je     80101fd8 <namex+0x1d8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e1a:	e8 a1 1b 00 00       	call   801039c0 <myproc>
  acquire(&icache.lock);
80101e1f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101e22:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101e25:	68 00 0b 11 80       	push   $0x80110b00
80101e2a:	e8 71 2d 00 00       	call   80104ba0 <acquire>
  ip->ref++;
80101e2f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e33:	c7 04 24 00 0b 11 80 	movl   $0x80110b00,(%esp)
80101e3a:	e8 e1 2e 00 00       	call   80104d20 <release>
80101e3f:	83 c4 10             	add    $0x10,%esp
80101e42:	eb 0f                	jmp    80101e53 <namex+0x53>
80101e44:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e4b:	00 
80101e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e50:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e53:	0f b6 03             	movzbl (%ebx),%eax
80101e56:	3c 2f                	cmp    $0x2f,%al
80101e58:	74 f6                	je     80101e50 <namex+0x50>
  if(*path == 0)
80101e5a:	84 c0                	test   %al,%al
80101e5c:	0f 84 1e 01 00 00    	je     80101f80 <namex+0x180>
  while(*path != '/' && *path != 0)
80101e62:	0f b6 03             	movzbl (%ebx),%eax
80101e65:	84 c0                	test   %al,%al
80101e67:	0f 84 28 01 00 00    	je     80101f95 <namex+0x195>
80101e6d:	89 df                	mov    %ebx,%edi
80101e6f:	3c 2f                	cmp    $0x2f,%al
80101e71:	0f 84 1e 01 00 00    	je     80101f95 <namex+0x195>
80101e77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e7e:	00 
80101e7f:	90                   	nop
80101e80:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101e84:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101e87:	3c 2f                	cmp    $0x2f,%al
80101e89:	74 04                	je     80101e8f <namex+0x8f>
80101e8b:	84 c0                	test   %al,%al
80101e8d:	75 f1                	jne    80101e80 <namex+0x80>
  len = path - s;
80101e8f:	89 f8                	mov    %edi,%eax
80101e91:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101e93:	83 f8 0d             	cmp    $0xd,%eax
80101e96:	0f 8e b4 00 00 00    	jle    80101f50 <namex+0x150>
    memmove(name, s, DIRSIZ);
80101e9c:	83 ec 04             	sub    $0x4,%esp
80101e9f:	6a 0e                	push   $0xe
80101ea1:	53                   	push   %ebx
80101ea2:	89 fb                	mov    %edi,%ebx
80101ea4:	ff 75 e4             	push   -0x1c(%ebp)
80101ea7:	e8 24 30 00 00       	call   80104ed0 <memmove>
80101eac:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101eaf:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101eb2:	75 14                	jne    80101ec8 <namex+0xc8>
80101eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101eb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ebf:	00 
    path++;
80101ec0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ec3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101ec6:	74 f8                	je     80101ec0 <namex+0xc0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101ec8:	83 ec 0c             	sub    $0xc,%esp
80101ecb:	56                   	push   %esi
80101ecc:	e8 1f f9 ff ff       	call   801017f0 <ilock>
    if(ip->type != T_DIR){
80101ed1:	83 c4 10             	add    $0x10,%esp
80101ed4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101ed9:	0f 85 bf 00 00 00    	jne    80101f9e <namex+0x19e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101edf:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ee2:	85 c0                	test   %eax,%eax
80101ee4:	74 09                	je     80101eef <namex+0xef>
80101ee6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ee9:	0f 84 ff 00 00 00    	je     80101fee <namex+0x1ee>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101eef:	83 ec 04             	sub    $0x4,%esp
80101ef2:	6a 00                	push   $0x0
80101ef4:	ff 75 e4             	push   -0x1c(%ebp)
80101ef7:	56                   	push   %esi
80101ef8:	e8 43 fe ff ff       	call   80101d40 <dirlookup>
80101efd:	83 c4 10             	add    $0x10,%esp
80101f00:	89 c7                	mov    %eax,%edi
80101f02:	85 c0                	test   %eax,%eax
80101f04:	0f 84 94 00 00 00    	je     80101f9e <namex+0x19e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f0a:	83 ec 0c             	sub    $0xc,%esp
80101f0d:	8d 4e 0c             	lea    0xc(%esi),%ecx
80101f10:	51                   	push   %ecx
80101f11:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101f14:	e8 e7 2a 00 00       	call   80104a00 <holdingsleep>
80101f19:	83 c4 10             	add    $0x10,%esp
80101f1c:	85 c0                	test   %eax,%eax
80101f1e:	0f 84 0a 01 00 00    	je     8010202e <namex+0x22e>
80101f24:	8b 56 08             	mov    0x8(%esi),%edx
80101f27:	85 d2                	test   %edx,%edx
80101f29:	0f 8e ff 00 00 00    	jle    8010202e <namex+0x22e>
  releasesleep(&ip->lock);
80101f2f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101f32:	83 ec 0c             	sub    $0xc,%esp
80101f35:	51                   	push   %ecx
80101f36:	e8 85 2a 00 00       	call   801049c0 <releasesleep>
  iput(ip);
80101f3b:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101f3e:	89 fe                	mov    %edi,%esi
  iput(ip);
80101f40:	e8 db f9 ff ff       	call   80101920 <iput>
80101f45:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f48:	e9 06 ff ff ff       	jmp    80101e53 <namex+0x53>
80101f4d:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101f50:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f53:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80101f56:	83 ec 04             	sub    $0x4,%esp
80101f59:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101f5c:	50                   	push   %eax
80101f5d:	53                   	push   %ebx
    name[len] = 0;
80101f5e:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101f60:	ff 75 e4             	push   -0x1c(%ebp)
80101f63:	e8 68 2f 00 00       	call   80104ed0 <memmove>
    name[len] = 0;
80101f68:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101f6b:	83 c4 10             	add    $0x10,%esp
80101f6e:	c6 01 00             	movb   $0x0,(%ecx)
80101f71:	e9 39 ff ff ff       	jmp    80101eaf <namex+0xaf>
80101f76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f7d:	00 
80101f7e:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80101f80:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f83:	85 c0                	test   %eax,%eax
80101f85:	0f 85 93 00 00 00    	jne    8010201e <namex+0x21e>
    iput(ip);
    return 0;
  }
  return ip;
}
80101f8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f8e:	89 f0                	mov    %esi,%eax
80101f90:	5b                   	pop    %ebx
80101f91:	5e                   	pop    %esi
80101f92:	5f                   	pop    %edi
80101f93:	5d                   	pop    %ebp
80101f94:	c3                   	ret
  while(*path != '/' && *path != 0)
80101f95:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f98:	89 df                	mov    %ebx,%edi
80101f9a:	31 c0                	xor    %eax,%eax
80101f9c:	eb b8                	jmp    80101f56 <namex+0x156>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f9e:	83 ec 0c             	sub    $0xc,%esp
80101fa1:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101fa4:	53                   	push   %ebx
80101fa5:	e8 56 2a 00 00       	call   80104a00 <holdingsleep>
80101faa:	83 c4 10             	add    $0x10,%esp
80101fad:	85 c0                	test   %eax,%eax
80101faf:	74 7d                	je     8010202e <namex+0x22e>
80101fb1:	8b 4e 08             	mov    0x8(%esi),%ecx
80101fb4:	85 c9                	test   %ecx,%ecx
80101fb6:	7e 76                	jle    8010202e <namex+0x22e>
  releasesleep(&ip->lock);
80101fb8:	83 ec 0c             	sub    $0xc,%esp
80101fbb:	53                   	push   %ebx
80101fbc:	e8 ff 29 00 00       	call   801049c0 <releasesleep>
  iput(ip);
80101fc1:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101fc4:	31 f6                	xor    %esi,%esi
  iput(ip);
80101fc6:	e8 55 f9 ff ff       	call   80101920 <iput>
      return 0;
80101fcb:	83 c4 10             	add    $0x10,%esp
}
80101fce:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fd1:	89 f0                	mov    %esi,%eax
80101fd3:	5b                   	pop    %ebx
80101fd4:	5e                   	pop    %esi
80101fd5:	5f                   	pop    %edi
80101fd6:	5d                   	pop    %ebp
80101fd7:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80101fd8:	ba 01 00 00 00       	mov    $0x1,%edx
80101fdd:	b8 01 00 00 00       	mov    $0x1,%eax
80101fe2:	e8 59 f3 ff ff       	call   80101340 <iget>
80101fe7:	89 c6                	mov    %eax,%esi
80101fe9:	e9 65 fe ff ff       	jmp    80101e53 <namex+0x53>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fee:	83 ec 0c             	sub    $0xc,%esp
80101ff1:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101ff4:	53                   	push   %ebx
80101ff5:	e8 06 2a 00 00       	call   80104a00 <holdingsleep>
80101ffa:	83 c4 10             	add    $0x10,%esp
80101ffd:	85 c0                	test   %eax,%eax
80101fff:	74 2d                	je     8010202e <namex+0x22e>
80102001:	8b 7e 08             	mov    0x8(%esi),%edi
80102004:	85 ff                	test   %edi,%edi
80102006:	7e 26                	jle    8010202e <namex+0x22e>
  releasesleep(&ip->lock);
80102008:	83 ec 0c             	sub    $0xc,%esp
8010200b:	53                   	push   %ebx
8010200c:	e8 af 29 00 00       	call   801049c0 <releasesleep>
}
80102011:	83 c4 10             	add    $0x10,%esp
}
80102014:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102017:	89 f0                	mov    %esi,%eax
80102019:	5b                   	pop    %ebx
8010201a:	5e                   	pop    %esi
8010201b:	5f                   	pop    %edi
8010201c:	5d                   	pop    %ebp
8010201d:	c3                   	ret
    iput(ip);
8010201e:	83 ec 0c             	sub    $0xc,%esp
80102021:	56                   	push   %esi
      return 0;
80102022:	31 f6                	xor    %esi,%esi
    iput(ip);
80102024:	e8 f7 f8 ff ff       	call   80101920 <iput>
    return 0;
80102029:	83 c4 10             	add    $0x10,%esp
8010202c:	eb a0                	jmp    80101fce <namex+0x1ce>
    panic("iunlock");
8010202e:	83 ec 0c             	sub    $0xc,%esp
80102031:	68 8e 7b 10 80       	push   $0x80107b8e
80102036:	e8 65 e3 ff ff       	call   801003a0 <panic>
8010203b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102040 <dirlink>:
{
80102040:	55                   	push   %ebp
80102041:	89 e5                	mov    %esp,%ebp
80102043:	57                   	push   %edi
80102044:	56                   	push   %esi
80102045:	53                   	push   %ebx
80102046:	83 ec 20             	sub    $0x20,%esp
80102049:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010204c:	6a 00                	push   $0x0
8010204e:	ff 75 0c             	push   0xc(%ebp)
80102051:	53                   	push   %ebx
80102052:	e8 e9 fc ff ff       	call   80101d40 <dirlookup>
80102057:	83 c4 10             	add    $0x10,%esp
8010205a:	85 c0                	test   %eax,%eax
8010205c:	75 67                	jne    801020c5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010205e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102061:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102064:	85 ff                	test   %edi,%edi
80102066:	74 29                	je     80102091 <dirlink+0x51>
80102068:	31 ff                	xor    %edi,%edi
8010206a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010206d:	eb 09                	jmp    80102078 <dirlink+0x38>
8010206f:	90                   	nop
80102070:	83 c7 10             	add    $0x10,%edi
80102073:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102076:	73 19                	jae    80102091 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102078:	6a 10                	push   $0x10
8010207a:	57                   	push   %edi
8010207b:	56                   	push   %esi
8010207c:	53                   	push   %ebx
8010207d:	e8 7e fa ff ff       	call   80101b00 <readi>
80102082:	83 c4 10             	add    $0x10,%esp
80102085:	83 f8 10             	cmp    $0x10,%eax
80102088:	75 4e                	jne    801020d8 <dirlink+0x98>
    if(de.inum == 0)
8010208a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010208f:	75 df                	jne    80102070 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102091:	83 ec 04             	sub    $0x4,%esp
80102094:	8d 45 da             	lea    -0x26(%ebp),%eax
80102097:	6a 0e                	push   $0xe
80102099:	ff 75 0c             	push   0xc(%ebp)
8010209c:	50                   	push   %eax
8010209d:	e8 ee 2e 00 00       	call   80104f90 <strncpy>
  de.inum = inum;
801020a2:	8b 45 10             	mov    0x10(%ebp),%eax
801020a5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020a9:	6a 10                	push   $0x10
801020ab:	57                   	push   %edi
801020ac:	56                   	push   %esi
801020ad:	53                   	push   %ebx
801020ae:	e8 4d fb ff ff       	call   80101c00 <writei>
801020b3:	83 c4 20             	add    $0x20,%esp
801020b6:	83 f8 10             	cmp    $0x10,%eax
801020b9:	75 2a                	jne    801020e5 <dirlink+0xa5>
  return 0;
801020bb:	31 c0                	xor    %eax,%eax
}
801020bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020c0:	5b                   	pop    %ebx
801020c1:	5e                   	pop    %esi
801020c2:	5f                   	pop    %edi
801020c3:	5d                   	pop    %ebp
801020c4:	c3                   	ret
    iput(ip);
801020c5:	83 ec 0c             	sub    $0xc,%esp
801020c8:	50                   	push   %eax
801020c9:	e8 52 f8 ff ff       	call   80101920 <iput>
    return -1;
801020ce:	83 c4 10             	add    $0x10,%esp
801020d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020d6:	eb e5                	jmp    801020bd <dirlink+0x7d>
      panic("dirlink read");
801020d8:	83 ec 0c             	sub    $0xc,%esp
801020db:	68 b7 7b 10 80       	push   $0x80107bb7
801020e0:	e8 bb e2 ff ff       	call   801003a0 <panic>
    panic("dirlink");
801020e5:	83 ec 0c             	sub    $0xc,%esp
801020e8:	68 0a 7e 10 80       	push   $0x80107e0a
801020ed:	e8 ae e2 ff ff       	call   801003a0 <panic>
801020f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020f9:	00 
801020fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102100 <namei>:

struct inode*
namei(char *path)
{
80102100:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102101:	31 d2                	xor    %edx,%edx
{
80102103:	89 e5                	mov    %esp,%ebp
80102105:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102108:	8b 45 08             	mov    0x8(%ebp),%eax
8010210b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010210e:	e8 ed fc ff ff       	call   80101e00 <namex>
}
80102113:	c9                   	leave
80102114:	c3                   	ret
80102115:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010211c:	00 
8010211d:	8d 76 00             	lea    0x0(%esi),%esi

80102120 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102120:	55                   	push   %ebp
  return namex(path, 1, name);
80102121:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102126:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102128:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010212b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010212e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010212f:	e9 cc fc ff ff       	jmp    80101e00 <namex>
80102134:	66 90                	xchg   %ax,%ax
80102136:	66 90                	xchg   %ax,%ax
80102138:	66 90                	xchg   %ax,%ax
8010213a:	66 90                	xchg   %ax,%ax
8010213c:	66 90                	xchg   %ax,%ax
8010213e:	66 90                	xchg   %ax,%ax

80102140 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	57                   	push   %edi
80102144:	56                   	push   %esi
80102145:	53                   	push   %ebx
80102146:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102149:	85 c0                	test   %eax,%eax
8010214b:	0f 84 b4 00 00 00    	je     80102205 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102151:	8b 70 08             	mov    0x8(%eax),%esi
80102154:	89 c3                	mov    %eax,%ebx
80102156:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010215c:	0f 87 96 00 00 00    	ja     801021f8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102162:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102167:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010216e:	00 
8010216f:	90                   	nop
80102170:	89 ca                	mov    %ecx,%edx
80102172:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102173:	83 e0 c0             	and    $0xffffffc0,%eax
80102176:	3c 40                	cmp    $0x40,%al
80102178:	75 f6                	jne    80102170 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010217a:	31 ff                	xor    %edi,%edi
8010217c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102181:	89 f8                	mov    %edi,%eax
80102183:	ee                   	out    %al,(%dx)
80102184:	b8 01 00 00 00       	mov    $0x1,%eax
80102189:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010218e:	ee                   	out    %al,(%dx)
8010218f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102194:	89 f0                	mov    %esi,%eax
80102196:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102197:	89 f0                	mov    %esi,%eax
80102199:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010219e:	c1 f8 08             	sar    $0x8,%eax
801021a1:	ee                   	out    %al,(%dx)
801021a2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801021a7:	89 f8                	mov    %edi,%eax
801021a9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801021aa:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801021ae:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021b3:	c1 e0 04             	shl    $0x4,%eax
801021b6:	83 e0 10             	and    $0x10,%eax
801021b9:	83 c8 e0             	or     $0xffffffe0,%eax
801021bc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801021bd:	f6 03 04             	testb  $0x4,(%ebx)
801021c0:	75 16                	jne    801021d8 <idestart+0x98>
801021c2:	b8 20 00 00 00       	mov    $0x20,%eax
801021c7:	89 ca                	mov    %ecx,%edx
801021c9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801021ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021cd:	5b                   	pop    %ebx
801021ce:	5e                   	pop    %esi
801021cf:	5f                   	pop    %edi
801021d0:	5d                   	pop    %ebp
801021d1:	c3                   	ret
801021d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021d8:	b8 30 00 00 00       	mov    $0x30,%eax
801021dd:	89 ca                	mov    %ecx,%edx
801021df:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801021e0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801021e5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801021e8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021ed:	fc                   	cld
801021ee:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801021f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021f3:	5b                   	pop    %ebx
801021f4:	5e                   	pop    %esi
801021f5:	5f                   	pop    %edi
801021f6:	5d                   	pop    %ebp
801021f7:	c3                   	ret
    panic("incorrect blockno");
801021f8:	83 ec 0c             	sub    $0xc,%esp
801021fb:	68 cd 7b 10 80       	push   $0x80107bcd
80102200:	e8 9b e1 ff ff       	call   801003a0 <panic>
    panic("idestart");
80102205:	83 ec 0c             	sub    $0xc,%esp
80102208:	68 c4 7b 10 80       	push   $0x80107bc4
8010220d:	e8 8e e1 ff ff       	call   801003a0 <panic>
80102212:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102219:	00 
8010221a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102220 <ideinit>:
{
80102220:	55                   	push   %ebp
80102221:	89 e5                	mov    %esp,%ebp
80102223:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102226:	68 df 7b 10 80       	push   $0x80107bdf
8010222b:	68 a0 27 11 80       	push   $0x801127a0
80102230:	e8 2b 28 00 00       	call   80104a60 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102235:	58                   	pop    %eax
80102236:	a1 20 29 11 80       	mov    0x80112920,%eax
8010223b:	5a                   	pop    %edx
8010223c:	83 e8 01             	sub    $0x1,%eax
8010223f:	50                   	push   %eax
80102240:	6a 0e                	push   $0xe
80102242:	e8 b9 02 00 00       	call   80102500 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102247:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010224a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010224f:	90                   	nop
80102250:	ec                   	in     (%dx),%al
80102251:	83 e0 c0             	and    $0xffffffc0,%eax
80102254:	3c 40                	cmp    $0x40,%al
80102256:	75 f8                	jne    80102250 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102258:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010225d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102262:	ee                   	out    %al,(%dx)
80102263:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102268:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010226d:	eb 06                	jmp    80102275 <ideinit+0x55>
8010226f:	90                   	nop
  for(i=0; i<1000; i++){
80102270:	83 e9 01             	sub    $0x1,%ecx
80102273:	74 0f                	je     80102284 <ideinit+0x64>
80102275:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102276:	84 c0                	test   %al,%al
80102278:	74 f6                	je     80102270 <ideinit+0x50>
      havedisk1 = 1;
8010227a:	c7 05 80 27 11 80 01 	movl   $0x1,0x80112780
80102281:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102284:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102289:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010228e:	ee                   	out    %al,(%dx)
}
8010228f:	c9                   	leave
80102290:	c3                   	ret
80102291:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102298:	00 
80102299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801022a0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801022a0:	55                   	push   %ebp
801022a1:	89 e5                	mov    %esp,%ebp
801022a3:	57                   	push   %edi
801022a4:	56                   	push   %esi
801022a5:	53                   	push   %ebx
801022a6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801022a9:	68 a0 27 11 80       	push   $0x801127a0
801022ae:	e8 ed 28 00 00       	call   80104ba0 <acquire>

  if((b = idequeue) == 0){
801022b3:	8b 1d 84 27 11 80    	mov    0x80112784,%ebx
801022b9:	83 c4 10             	add    $0x10,%esp
801022bc:	85 db                	test   %ebx,%ebx
801022be:	74 63                	je     80102323 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801022c0:	8b 43 58             	mov    0x58(%ebx),%eax
801022c3:	a3 84 27 11 80       	mov    %eax,0x80112784

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801022c8:	8b 33                	mov    (%ebx),%esi
801022ca:	f7 c6 04 00 00 00    	test   $0x4,%esi
801022d0:	75 2f                	jne    80102301 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022d2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022de:	00 
801022df:	90                   	nop
801022e0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022e1:	89 c1                	mov    %eax,%ecx
801022e3:	83 e1 c0             	and    $0xffffffc0,%ecx
801022e6:	80 f9 40             	cmp    $0x40,%cl
801022e9:	75 f5                	jne    801022e0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801022eb:	a8 21                	test   $0x21,%al
801022ed:	75 12                	jne    80102301 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801022ef:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801022f2:	b9 80 00 00 00       	mov    $0x80,%ecx
801022f7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022fc:	fc                   	cld
801022fd:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801022ff:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102301:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102304:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102307:	83 ce 02             	or     $0x2,%esi
8010230a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010230c:	53                   	push   %ebx
8010230d:	e8 fe 22 00 00       	call   80104610 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102312:	a1 84 27 11 80       	mov    0x80112784,%eax
80102317:	83 c4 10             	add    $0x10,%esp
8010231a:	85 c0                	test   %eax,%eax
8010231c:	74 05                	je     80102323 <ideintr+0x83>
    idestart(idequeue);
8010231e:	e8 1d fe ff ff       	call   80102140 <idestart>
    release(&idelock);
80102323:	83 ec 0c             	sub    $0xc,%esp
80102326:	68 a0 27 11 80       	push   $0x801127a0
8010232b:	e8 f0 29 00 00       	call   80104d20 <release>

  release(&idelock);
}
80102330:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102333:	5b                   	pop    %ebx
80102334:	5e                   	pop    %esi
80102335:	5f                   	pop    %edi
80102336:	5d                   	pop    %ebp
80102337:	c3                   	ret
80102338:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010233f:	00 

80102340 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102340:	55                   	push   %ebp
80102341:	89 e5                	mov    %esp,%ebp
80102343:	53                   	push   %ebx
80102344:	83 ec 10             	sub    $0x10,%esp
80102347:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010234a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010234d:	50                   	push   %eax
8010234e:	e8 ad 26 00 00       	call   80104a00 <holdingsleep>
80102353:	83 c4 10             	add    $0x10,%esp
80102356:	85 c0                	test   %eax,%eax
80102358:	0f 84 c3 00 00 00    	je     80102421 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010235e:	8b 03                	mov    (%ebx),%eax
80102360:	83 e0 06             	and    $0x6,%eax
80102363:	83 f8 02             	cmp    $0x2,%eax
80102366:	0f 84 a8 00 00 00    	je     80102414 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010236c:	8b 53 04             	mov    0x4(%ebx),%edx
8010236f:	85 d2                	test   %edx,%edx
80102371:	74 0d                	je     80102380 <iderw+0x40>
80102373:	a1 80 27 11 80       	mov    0x80112780,%eax
80102378:	85 c0                	test   %eax,%eax
8010237a:	0f 84 87 00 00 00    	je     80102407 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102380:	83 ec 0c             	sub    $0xc,%esp
80102383:	68 a0 27 11 80       	push   $0x801127a0
80102388:	e8 13 28 00 00       	call   80104ba0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010238d:	a1 84 27 11 80       	mov    0x80112784,%eax
  b->qnext = 0;
80102392:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102399:	83 c4 10             	add    $0x10,%esp
8010239c:	85 c0                	test   %eax,%eax
8010239e:	74 60                	je     80102400 <iderw+0xc0>
801023a0:	89 c2                	mov    %eax,%edx
801023a2:	8b 40 58             	mov    0x58(%eax),%eax
801023a5:	85 c0                	test   %eax,%eax
801023a7:	75 f7                	jne    801023a0 <iderw+0x60>
801023a9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801023ac:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801023ae:	39 1d 84 27 11 80    	cmp    %ebx,0x80112784
801023b4:	74 3a                	je     801023f0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801023b6:	8b 03                	mov    (%ebx),%eax
801023b8:	83 e0 06             	and    $0x6,%eax
801023bb:	83 f8 02             	cmp    $0x2,%eax
801023be:	74 1b                	je     801023db <iderw+0x9b>
    sleep(b, &idelock);
801023c0:	83 ec 08             	sub    $0x8,%esp
801023c3:	68 a0 27 11 80       	push   $0x801127a0
801023c8:	53                   	push   %ebx
801023c9:	e8 82 21 00 00       	call   80104550 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801023ce:	8b 03                	mov    (%ebx),%eax
801023d0:	83 c4 10             	add    $0x10,%esp
801023d3:	83 e0 06             	and    $0x6,%eax
801023d6:	83 f8 02             	cmp    $0x2,%eax
801023d9:	75 e5                	jne    801023c0 <iderw+0x80>
  }


  release(&idelock);
801023db:	c7 45 08 a0 27 11 80 	movl   $0x801127a0,0x8(%ebp)
}
801023e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023e5:	c9                   	leave
  release(&idelock);
801023e6:	e9 35 29 00 00       	jmp    80104d20 <release>
801023eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
801023f0:	89 d8                	mov    %ebx,%eax
801023f2:	e8 49 fd ff ff       	call   80102140 <idestart>
801023f7:	eb bd                	jmp    801023b6 <iderw+0x76>
801023f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102400:	ba 84 27 11 80       	mov    $0x80112784,%edx
80102405:	eb a5                	jmp    801023ac <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102407:	83 ec 0c             	sub    $0xc,%esp
8010240a:	68 0e 7c 10 80       	push   $0x80107c0e
8010240f:	e8 8c df ff ff       	call   801003a0 <panic>
    panic("iderw: nothing to do");
80102414:	83 ec 0c             	sub    $0xc,%esp
80102417:	68 f9 7b 10 80       	push   $0x80107bf9
8010241c:	e8 7f df ff ff       	call   801003a0 <panic>
    panic("iderw: buf not locked");
80102421:	83 ec 0c             	sub    $0xc,%esp
80102424:	68 e3 7b 10 80       	push   $0x80107be3
80102429:	e8 72 df ff ff       	call   801003a0 <panic>
8010242e:	66 90                	xchg   %ax,%ax
80102430:	66 90                	xchg   %ax,%ax
80102432:	66 90                	xchg   %ax,%ax
80102434:	66 90                	xchg   %ax,%ax
80102436:	66 90                	xchg   %ax,%ax
80102438:	66 90                	xchg   %ax,%ax
8010243a:	66 90                	xchg   %ax,%ax
8010243c:	66 90                	xchg   %ax,%ax
8010243e:	66 90                	xchg   %ax,%ax

80102440 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102440:	55                   	push   %ebp
80102441:	89 e5                	mov    %esp,%ebp
80102443:	56                   	push   %esi
80102444:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102445:	c7 05 d8 27 11 80 00 	movl   $0xfec00000,0x801127d8
8010244c:	00 c0 fe 
  ioapic->reg = reg;
8010244f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102456:	00 00 00 
  return ioapic->data;
80102459:	8b 15 d8 27 11 80    	mov    0x801127d8,%edx
8010245f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102462:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102468:	8b 1d d8 27 11 80    	mov    0x801127d8,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010246e:	0f b6 15 d4 27 11 80 	movzbl 0x801127d4,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102475:	c1 ee 10             	shr    $0x10,%esi
80102478:	89 f0                	mov    %esi,%eax
8010247a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010247d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102480:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102483:	39 c2                	cmp    %eax,%edx
80102485:	74 16                	je     8010249d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102487:	83 ec 0c             	sub    $0xc,%esp
8010248a:	68 c0 7f 10 80       	push   $0x80107fc0
8010248f:	e8 3c e2 ff ff       	call   801006d0 <cprintf>
  ioapic->reg = reg;
80102494:	8b 1d d8 27 11 80    	mov    0x801127d8,%ebx
8010249a:	83 c4 10             	add    $0x10,%esp
{
8010249d:	ba 10 00 00 00       	mov    $0x10,%edx
801024a2:	31 c0                	xor    %eax,%eax
801024a4:	eb 1a                	jmp    801024c0 <ioapicinit+0x80>
801024a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801024ad:	00 
801024ae:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801024b5:	00 
801024b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801024bd:	00 
801024be:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
801024c0:	89 13                	mov    %edx,(%ebx)
801024c2:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
801024c5:	8b 1d d8 27 11 80    	mov    0x801127d8,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801024cb:	83 c0 01             	add    $0x1,%eax
801024ce:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
801024d4:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
801024d7:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
801024da:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801024dd:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801024df:	8b 1d d8 27 11 80    	mov    0x801127d8,%ebx
801024e5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
801024ec:	39 c6                	cmp    %eax,%esi
801024ee:	7d d0                	jge    801024c0 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801024f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024f3:	5b                   	pop    %ebx
801024f4:	5e                   	pop    %esi
801024f5:	5d                   	pop    %ebp
801024f6:	c3                   	ret
801024f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801024fe:	00 
801024ff:	90                   	nop

80102500 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102500:	55                   	push   %ebp
  ioapic->reg = reg;
80102501:	8b 0d d8 27 11 80    	mov    0x801127d8,%ecx
{
80102507:	89 e5                	mov    %esp,%ebp
80102509:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010250c:	8d 50 20             	lea    0x20(%eax),%edx
8010250f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102513:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102515:	8b 0d d8 27 11 80    	mov    0x801127d8,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010251b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010251e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102521:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102524:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102526:	a1 d8 27 11 80       	mov    0x801127d8,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010252b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010252e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102531:	5d                   	pop    %ebp
80102532:	c3                   	ret
80102533:	66 90                	xchg   %ax,%ax
80102535:	66 90                	xchg   %ax,%ax
80102537:	66 90                	xchg   %ax,%ax
80102539:	66 90                	xchg   %ax,%ax
8010253b:	66 90                	xchg   %ax,%ax
8010253d:	66 90                	xchg   %ax,%ax
8010253f:	90                   	nop

80102540 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	53                   	push   %ebx
80102544:	83 ec 04             	sub    $0x4,%esp
80102547:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010254a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102550:	75 76                	jne    801025c8 <kfree+0x88>
80102552:	81 fb 90 6d 11 80    	cmp    $0x80116d90,%ebx
80102558:	72 6e                	jb     801025c8 <kfree+0x88>
8010255a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102560:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102565:	77 61                	ja     801025c8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102567:	83 ec 04             	sub    $0x4,%esp
8010256a:	68 00 10 00 00       	push   $0x1000
8010256f:	6a 01                	push   $0x1
80102571:	53                   	push   %ebx
80102572:	e8 c9 28 00 00       	call   80104e40 <memset>

  if(kmem.use_lock)
80102577:	8b 15 14 28 11 80    	mov    0x80112814,%edx
8010257d:	83 c4 10             	add    $0x10,%esp
80102580:	85 d2                	test   %edx,%edx
80102582:	75 1c                	jne    801025a0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102584:	a1 18 28 11 80       	mov    0x80112818,%eax
80102589:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010258b:	a1 14 28 11 80       	mov    0x80112814,%eax
  kmem.freelist = r;
80102590:	89 1d 18 28 11 80    	mov    %ebx,0x80112818
  if(kmem.use_lock)
80102596:	85 c0                	test   %eax,%eax
80102598:	75 1e                	jne    801025b8 <kfree+0x78>
    release(&kmem.lock);
}
8010259a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010259d:	c9                   	leave
8010259e:	c3                   	ret
8010259f:	90                   	nop
    acquire(&kmem.lock);
801025a0:	83 ec 0c             	sub    $0xc,%esp
801025a3:	68 e0 27 11 80       	push   $0x801127e0
801025a8:	e8 f3 25 00 00       	call   80104ba0 <acquire>
801025ad:	83 c4 10             	add    $0x10,%esp
801025b0:	eb d2                	jmp    80102584 <kfree+0x44>
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801025b8:	c7 45 08 e0 27 11 80 	movl   $0x801127e0,0x8(%ebp)
}
801025bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025c2:	c9                   	leave
    release(&kmem.lock);
801025c3:	e9 58 27 00 00       	jmp    80104d20 <release>
    panic("kfree");
801025c8:	83 ec 0c             	sub    $0xc,%esp
801025cb:	68 2c 7c 10 80       	push   $0x80107c2c
801025d0:	e8 cb dd ff ff       	call   801003a0 <panic>
801025d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025dc:	00 
801025dd:	8d 76 00             	lea    0x0(%esi),%esi

801025e0 <freerange>:
{
801025e0:	55                   	push   %ebp
801025e1:	89 e5                	mov    %esp,%ebp
801025e3:	56                   	push   %esi
801025e4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025e5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801025eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025fd:	39 de                	cmp    %ebx,%esi
801025ff:	72 2b                	jb     8010262c <freerange+0x4c>
80102601:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102608:	00 
80102609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102610:	83 ec 0c             	sub    $0xc,%esp
80102613:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102619:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010261f:	50                   	push   %eax
80102620:	e8 1b ff ff ff       	call   80102540 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102625:	83 c4 10             	add    $0x10,%esp
80102628:	39 de                	cmp    %ebx,%esi
8010262a:	73 e4                	jae    80102610 <freerange+0x30>
}
8010262c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010262f:	5b                   	pop    %ebx
80102630:	5e                   	pop    %esi
80102631:	5d                   	pop    %ebp
80102632:	c3                   	ret
80102633:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010263a:	00 
8010263b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102640 <kinit2>:
{
80102640:	55                   	push   %ebp
80102641:	89 e5                	mov    %esp,%ebp
80102643:	56                   	push   %esi
80102644:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102645:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102648:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010264b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102651:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102657:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010265d:	39 de                	cmp    %ebx,%esi
8010265f:	72 2b                	jb     8010268c <kinit2+0x4c>
80102661:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102668:	00 
80102669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102670:	83 ec 0c             	sub    $0xc,%esp
80102673:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102679:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010267f:	50                   	push   %eax
80102680:	e8 bb fe ff ff       	call   80102540 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102685:	83 c4 10             	add    $0x10,%esp
80102688:	39 de                	cmp    %ebx,%esi
8010268a:	73 e4                	jae    80102670 <kinit2+0x30>
  kmem.use_lock = 1;
8010268c:	c7 05 14 28 11 80 01 	movl   $0x1,0x80112814
80102693:	00 00 00 
}
80102696:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102699:	5b                   	pop    %ebx
8010269a:	5e                   	pop    %esi
8010269b:	5d                   	pop    %ebp
8010269c:	c3                   	ret
8010269d:	8d 76 00             	lea    0x0(%esi),%esi

801026a0 <kinit1>:
{
801026a0:	55                   	push   %ebp
801026a1:	89 e5                	mov    %esp,%ebp
801026a3:	56                   	push   %esi
801026a4:	53                   	push   %ebx
801026a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801026a8:	83 ec 08             	sub    $0x8,%esp
801026ab:	68 32 7c 10 80       	push   $0x80107c32
801026b0:	68 e0 27 11 80       	push   $0x801127e0
801026b5:	e8 a6 23 00 00       	call   80104a60 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801026ba:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026bd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801026c0:	c7 05 14 28 11 80 00 	movl   $0x0,0x80112814
801026c7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801026ca:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026d0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026d6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026dc:	39 de                	cmp    %ebx,%esi
801026de:	72 1c                	jb     801026fc <kinit1+0x5c>
    kfree(p);
801026e0:	83 ec 0c             	sub    $0xc,%esp
801026e3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026e9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026ef:	50                   	push   %eax
801026f0:	e8 4b fe ff ff       	call   80102540 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026f5:	83 c4 10             	add    $0x10,%esp
801026f8:	39 de                	cmp    %ebx,%esi
801026fa:	73 e4                	jae    801026e0 <kinit1+0x40>
}
801026fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026ff:	5b                   	pop    %ebx
80102700:	5e                   	pop    %esi
80102701:	5d                   	pop    %ebp
80102702:	c3                   	ret
80102703:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010270a:	00 
8010270b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102710 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102710:	55                   	push   %ebp
80102711:	89 e5                	mov    %esp,%ebp
80102713:	53                   	push   %ebx
80102714:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102717:	a1 14 28 11 80       	mov    0x80112814,%eax
8010271c:	85 c0                	test   %eax,%eax
8010271e:	75 20                	jne    80102740 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102720:	8b 1d 18 28 11 80    	mov    0x80112818,%ebx
  if(r)
80102726:	85 db                	test   %ebx,%ebx
80102728:	74 07                	je     80102731 <kalloc+0x21>
    kmem.freelist = r->next;
8010272a:	8b 03                	mov    (%ebx),%eax
8010272c:	a3 18 28 11 80       	mov    %eax,0x80112818
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102731:	89 d8                	mov    %ebx,%eax
80102733:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102736:	c9                   	leave
80102737:	c3                   	ret
80102738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010273f:	00 
    acquire(&kmem.lock);
80102740:	83 ec 0c             	sub    $0xc,%esp
80102743:	68 e0 27 11 80       	push   $0x801127e0
80102748:	e8 53 24 00 00       	call   80104ba0 <acquire>
  r = kmem.freelist;
8010274d:	8b 1d 18 28 11 80    	mov    0x80112818,%ebx
  if(kmem.use_lock)
80102753:	a1 14 28 11 80       	mov    0x80112814,%eax
  if(r)
80102758:	83 c4 10             	add    $0x10,%esp
8010275b:	85 db                	test   %ebx,%ebx
8010275d:	74 08                	je     80102767 <kalloc+0x57>
    kmem.freelist = r->next;
8010275f:	8b 13                	mov    (%ebx),%edx
80102761:	89 15 18 28 11 80    	mov    %edx,0x80112818
  if(kmem.use_lock)
80102767:	85 c0                	test   %eax,%eax
80102769:	74 c6                	je     80102731 <kalloc+0x21>
    release(&kmem.lock);
8010276b:	83 ec 0c             	sub    $0xc,%esp
8010276e:	68 e0 27 11 80       	push   $0x801127e0
80102773:	e8 a8 25 00 00       	call   80104d20 <release>
}
80102778:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010277a:	83 c4 10             	add    $0x10,%esp
}
8010277d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102780:	c9                   	leave
80102781:	c3                   	ret
80102782:	66 90                	xchg   %ax,%ax
80102784:	66 90                	xchg   %ax,%ax
80102786:	66 90                	xchg   %ax,%ax
80102788:	66 90                	xchg   %ax,%ax
8010278a:	66 90                	xchg   %ax,%ax
8010278c:	66 90                	xchg   %ax,%ax
8010278e:	66 90                	xchg   %ax,%ax

80102790 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102790:	ba 64 00 00 00       	mov    $0x64,%edx
80102795:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102796:	a8 01                	test   $0x1,%al
80102798:	0f 84 c2 00 00 00    	je     80102860 <kbdgetc+0xd0>
{
8010279e:	55                   	push   %ebp
8010279f:	ba 60 00 00 00       	mov    $0x60,%edx
801027a4:	89 e5                	mov    %esp,%ebp
801027a6:	53                   	push   %ebx
801027a7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801027a8:	8b 1d 1c 28 11 80    	mov    0x8011281c,%ebx
  data = inb(KBDATAP);
801027ae:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
801027b1:	3c e0                	cmp    $0xe0,%al
801027b3:	74 5b                	je     80102810 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801027b5:	89 da                	mov    %ebx,%edx
801027b7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801027ba:	84 c0                	test   %al,%al
801027bc:	78 62                	js     80102820 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801027be:	85 d2                	test   %edx,%edx
801027c0:	74 09                	je     801027cb <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801027c2:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801027c5:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801027c8:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
801027cb:	0f b6 91 40 82 10 80 	movzbl -0x7fef7dc0(%ecx),%edx
  shift ^= togglecode[data];
801027d2:	0f b6 81 40 81 10 80 	movzbl -0x7fef7ec0(%ecx),%eax
  shift |= shiftcode[data];
801027d9:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
801027db:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801027dd:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
801027df:	89 15 1c 28 11 80    	mov    %edx,0x8011281c
  c = charcode[shift & (CTL | SHIFT)][data];
801027e5:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801027e8:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801027eb:	8b 04 85 20 81 10 80 	mov    -0x7fef7ee0(,%eax,4),%eax
801027f2:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
801027f6:	74 0b                	je     80102803 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
801027f8:	8d 50 9f             	lea    -0x61(%eax),%edx
801027fb:	83 fa 19             	cmp    $0x19,%edx
801027fe:	77 48                	ja     80102848 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102800:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102803:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102806:	c9                   	leave
80102807:	c3                   	ret
80102808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010280f:	00 
    shift |= E0ESC;
80102810:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102813:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102815:	89 1d 1c 28 11 80    	mov    %ebx,0x8011281c
}
8010281b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010281e:	c9                   	leave
8010281f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80102820:	83 e0 7f             	and    $0x7f,%eax
80102823:	85 d2                	test   %edx,%edx
80102825:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102828:	0f b6 81 40 82 10 80 	movzbl -0x7fef7dc0(%ecx),%eax
8010282f:	83 c8 40             	or     $0x40,%eax
80102832:	0f b6 c0             	movzbl %al,%eax
80102835:	f7 d0                	not    %eax
80102837:	21 d8                	and    %ebx,%eax
80102839:	a3 1c 28 11 80       	mov    %eax,0x8011281c
    return 0;
8010283e:	31 c0                	xor    %eax,%eax
80102840:	eb d9                	jmp    8010281b <kbdgetc+0x8b>
80102842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102848:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010284b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010284e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102851:	c9                   	leave
      c += 'a' - 'A';
80102852:	83 f9 1a             	cmp    $0x1a,%ecx
80102855:	0f 42 c2             	cmovb  %edx,%eax
}
80102858:	c3                   	ret
80102859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102860:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102865:	c3                   	ret
80102866:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010286d:	00 
8010286e:	66 90                	xchg   %ax,%ax

80102870 <kbdintr>:

void
kbdintr(void)
{
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
80102873:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102876:	68 90 27 10 80       	push   $0x80102790
8010287b:	e8 40 e0 ff ff       	call   801008c0 <consoleintr>
}
80102880:	83 c4 10             	add    $0x10,%esp
80102883:	c9                   	leave
80102884:	c3                   	ret
80102885:	66 90                	xchg   %ax,%ax
80102887:	66 90                	xchg   %ax,%ax
80102889:	66 90                	xchg   %ax,%ax
8010288b:	66 90                	xchg   %ax,%ax
8010288d:	66 90                	xchg   %ax,%ax
8010288f:	90                   	nop

80102890 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102890:	a1 20 28 11 80       	mov    0x80112820,%eax
80102895:	85 c0                	test   %eax,%eax
80102897:	0f 84 cb 00 00 00    	je     80102968 <lapicinit+0xd8>
  lapic[index] = value;
8010289d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801028a4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028a7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028aa:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801028b1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028b7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801028be:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801028c1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028c4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801028cb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801028ce:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028d1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801028d8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028db:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028de:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801028e5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028e8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801028eb:	8b 50 30             	mov    0x30(%eax),%edx
801028ee:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
801028f4:	75 7a                	jne    80102970 <lapicinit+0xe0>
  lapic[index] = value;
801028f6:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801028fd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102900:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102903:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010290a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010290d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102910:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102917:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010291a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010291d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102924:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102927:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010292a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102931:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102934:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102937:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010293e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102941:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102944:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010294b:	00 
8010294c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102950:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102956:	80 e6 10             	and    $0x10,%dh
80102959:	75 f5                	jne    80102950 <lapicinit+0xc0>
  lapic[index] = value;
8010295b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102962:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102965:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102968:	c3                   	ret
80102969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102970:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102977:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010297a:	8b 50 20             	mov    0x20(%eax),%edx
}
8010297d:	e9 74 ff ff ff       	jmp    801028f6 <lapicinit+0x66>
80102982:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102989:	00 
8010298a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102990 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102990:	a1 20 28 11 80       	mov    0x80112820,%eax
80102995:	85 c0                	test   %eax,%eax
80102997:	74 07                	je     801029a0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102999:	8b 40 20             	mov    0x20(%eax),%eax
8010299c:	c1 e8 18             	shr    $0x18,%eax
8010299f:	c3                   	ret
801029a0:	31 c0                	xor    %eax,%eax
}
801029a2:	c3                   	ret
801029a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029aa:	00 
801029ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801029b0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801029b0:	a1 20 28 11 80       	mov    0x80112820,%eax
801029b5:	85 c0                	test   %eax,%eax
801029b7:	74 0d                	je     801029c6 <lapiceoi+0x16>
  lapic[index] = value;
801029b9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801029c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029c3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801029c6:	c3                   	ret
801029c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029ce:	00 
801029cf:	90                   	nop

801029d0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
801029d0:	c3                   	ret
801029d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029d8:	00 
801029d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801029e0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801029e0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e1:	b8 0f 00 00 00       	mov    $0xf,%eax
801029e6:	ba 70 00 00 00       	mov    $0x70,%edx
801029eb:	89 e5                	mov    %esp,%ebp
801029ed:	53                   	push   %ebx
801029ee:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801029f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801029f4:	ee                   	out    %al,(%dx)
801029f5:	b8 0a 00 00 00       	mov    $0xa,%eax
801029fa:	ba 71 00 00 00       	mov    $0x71,%edx
801029ff:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102a00:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102a02:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102a05:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102a0b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a0d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102a10:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102a12:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a15:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102a18:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102a1e:	a1 20 28 11 80       	mov    0x80112820,%eax
80102a23:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a29:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a2c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102a33:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a36:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a39:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102a40:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a43:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a46:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a4c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a4f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a55:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a58:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a5e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a61:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a67:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102a6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a6d:	c9                   	leave
80102a6e:	c3                   	ret
80102a6f:	90                   	nop

80102a70 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102a70:	55                   	push   %ebp
80102a71:	b8 0b 00 00 00       	mov    $0xb,%eax
80102a76:	ba 70 00 00 00       	mov    $0x70,%edx
80102a7b:	89 e5                	mov    %esp,%ebp
80102a7d:	57                   	push   %edi
80102a7e:	56                   	push   %esi
80102a7f:	53                   	push   %ebx
80102a80:	83 ec 4c             	sub    $0x4c,%esp
80102a83:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a84:	ba 71 00 00 00       	mov    $0x71,%edx
80102a89:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102a8a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a8d:	88 45 b4             	mov    %al,-0x4c(%ebp)
80102a90:	31 c0                	xor    %eax,%eax
80102a92:	ba 70 00 00 00       	mov    $0x70,%edx
80102a97:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a98:	b9 71 00 00 00       	mov    $0x71,%ecx
80102a9d:	89 ca                	mov    %ecx,%edx
80102a9f:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa0:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aa5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa8:	b8 02 00 00 00       	mov    $0x2,%eax
80102aad:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aae:	89 ca                	mov    %ecx,%edx
80102ab0:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab1:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ab6:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab9:	b8 04 00 00 00       	mov    $0x4,%eax
80102abe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102abf:	89 ca                	mov    %ecx,%edx
80102ac1:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac2:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ac7:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aca:	b8 07 00 00 00       	mov    $0x7,%eax
80102acf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ad0:	89 ca                	mov    %ecx,%edx
80102ad2:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ad3:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ad8:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ada:	b8 08 00 00 00       	mov    $0x8,%eax
80102adf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae0:	89 ca                	mov    %ecx,%edx
80102ae2:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ae3:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae8:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aea:	b8 09 00 00 00       	mov    $0x9,%eax
80102aef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102af0:	89 ca                	mov    %ecx,%edx
80102af2:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102af3:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102af8:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102afb:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b00:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b01:	89 ca                	mov    %ecx,%edx
80102b03:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102b04:	84 c0                	test   %al,%al
80102b06:	78 88                	js     80102a90 <cmostime+0x20>
  r->second = cmos_read(SECS);
80102b08:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
  r->day    = cmos_read(DAY);
80102b0c:	89 fa                	mov    %edi,%edx
  r->year   = cmos_read(YEAR);
80102b0e:	89 5d cc             	mov    %ebx,-0x34(%ebp)
  r->day    = cmos_read(DAY);
80102b11:	0f b6 fa             	movzbl %dl,%edi
  r->month  = cmos_read(MONTH);
80102b14:	89 f2                	mov    %esi,%edx
  r->second = cmos_read(SECS);
80102b16:	89 45 b8             	mov    %eax,-0x48(%ebp)
  r->minute = cmos_read(MINS);
80102b19:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
  r->month  = cmos_read(MONTH);
80102b1d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b20:	ba 70 00 00 00       	mov    $0x70,%edx
  r->day    = cmos_read(DAY);
80102b25:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  r->minute = cmos_read(MINS);
80102b28:	89 45 bc             	mov    %eax,-0x44(%ebp)
  r->hour   = cmos_read(HOURS);
80102b2b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
  r->month  = cmos_read(MONTH);
80102b2f:	89 75 c8             	mov    %esi,-0x38(%ebp)
  r->hour   = cmos_read(HOURS);
80102b32:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102b35:	31 c0                	xor    %eax,%eax
80102b37:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b38:	89 ca                	mov    %ecx,%edx
80102b3a:	ec                   	in     (%dx),%al
  r->second = cmos_read(SECS);
80102b3b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b3e:	ba 70 00 00 00       	mov    $0x70,%edx
80102b43:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102b46:	b8 02 00 00 00       	mov    $0x2,%eax
80102b4b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b4c:	89 ca                	mov    %ecx,%edx
80102b4e:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102b4f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b52:	ba 70 00 00 00       	mov    $0x70,%edx
80102b57:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102b5a:	b8 04 00 00 00       	mov    $0x4,%eax
80102b5f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b60:	89 ca                	mov    %ecx,%edx
80102b62:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102b63:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b66:	ba 70 00 00 00       	mov    $0x70,%edx
80102b6b:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102b6e:	b8 07 00 00 00       	mov    $0x7,%eax
80102b73:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b74:	89 ca                	mov    %ecx,%edx
80102b76:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102b77:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b7a:	ba 70 00 00 00       	mov    $0x70,%edx
80102b7f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102b82:	b8 08 00 00 00       	mov    $0x8,%eax
80102b87:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b88:	89 ca                	mov    %ecx,%edx
80102b8a:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102b8b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b8e:	ba 70 00 00 00       	mov    $0x70,%edx
80102b93:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102b96:	b8 09 00 00 00       	mov    $0x9,%eax
80102b9b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b9c:	89 ca                	mov    %ecx,%edx
80102b9e:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102b9f:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ba2:	83 ec 04             	sub    $0x4,%esp
  r->year   = cmos_read(YEAR);
80102ba5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ba8:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102bab:	6a 18                	push   $0x18
80102bad:	50                   	push   %eax
80102bae:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102bb1:	50                   	push   %eax
80102bb2:	e8 c9 22 00 00       	call   80104e80 <memcmp>
80102bb7:	83 c4 10             	add    $0x10,%esp
80102bba:	85 c0                	test   %eax,%eax
80102bbc:	0f 85 ce fe ff ff    	jne    80102a90 <cmostime+0x20>
      break;
  }

  // convert
  if(bcd) {
80102bc2:	0f b6 75 b4          	movzbl -0x4c(%ebp),%esi
80102bc6:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102bc9:	89 f0                	mov    %esi,%eax
80102bcb:	84 c0                	test   %al,%al
80102bcd:	75 78                	jne    80102c47 <cmostime+0x1d7>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102bcf:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102bd2:	89 c2                	mov    %eax,%edx
80102bd4:	83 e0 0f             	and    $0xf,%eax
80102bd7:	c1 fa 04             	sar    $0x4,%edx
80102bda:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bdd:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102be0:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102be3:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102be6:	89 c2                	mov    %eax,%edx
80102be8:	83 e0 0f             	and    $0xf,%eax
80102beb:	c1 fa 04             	sar    $0x4,%edx
80102bee:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bf1:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bf4:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102bf7:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102bfa:	89 c2                	mov    %eax,%edx
80102bfc:	83 e0 0f             	and    $0xf,%eax
80102bff:	c1 fa 04             	sar    $0x4,%edx
80102c02:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c05:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c08:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102c0b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c0e:	89 c2                	mov    %eax,%edx
80102c10:	83 e0 0f             	and    $0xf,%eax
80102c13:	c1 fa 04             	sar    $0x4,%edx
80102c16:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c19:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c1c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102c1f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c22:	89 c2                	mov    %eax,%edx
80102c24:	83 e0 0f             	and    $0xf,%eax
80102c27:	c1 fa 04             	sar    $0x4,%edx
80102c2a:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c2d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c30:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102c33:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c36:	89 c2                	mov    %eax,%edx
80102c38:	83 e0 0f             	and    $0xf,%eax
80102c3b:	c1 fa 04             	sar    $0x4,%edx
80102c3e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c41:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c44:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102c47:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102c4a:	89 03                	mov    %eax,(%ebx)
80102c4c:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102c4f:	89 43 04             	mov    %eax,0x4(%ebx)
80102c52:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102c55:	89 43 08             	mov    %eax,0x8(%ebx)
80102c58:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c5b:	89 43 0c             	mov    %eax,0xc(%ebx)
80102c5e:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c61:	89 43 10             	mov    %eax,0x10(%ebx)
80102c64:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c67:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102c6a:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102c71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c74:	5b                   	pop    %ebx
80102c75:	5e                   	pop    %esi
80102c76:	5f                   	pop    %edi
80102c77:	5d                   	pop    %ebp
80102c78:	c3                   	ret
80102c79:	66 90                	xchg   %ax,%ax
80102c7b:	66 90                	xchg   %ax,%ax
80102c7d:	66 90                	xchg   %ax,%ax
80102c7f:	90                   	nop

80102c80 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c80:	8b 0d 88 28 11 80    	mov    0x80112888,%ecx
80102c86:	85 c9                	test   %ecx,%ecx
80102c88:	0f 8e 8a 00 00 00    	jle    80102d18 <install_trans+0x98>
{
80102c8e:	55                   	push   %ebp
80102c8f:	89 e5                	mov    %esp,%ebp
80102c91:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102c92:	31 ff                	xor    %edi,%edi
{
80102c94:	56                   	push   %esi
80102c95:	53                   	push   %ebx
80102c96:	83 ec 0c             	sub    $0xc,%esp
80102c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ca0:	a1 74 28 11 80       	mov    0x80112874,%eax
80102ca5:	83 ec 08             	sub    $0x8,%esp
80102ca8:	01 f8                	add    %edi,%eax
80102caa:	83 c0 01             	add    $0x1,%eax
80102cad:	50                   	push   %eax
80102cae:	ff 35 84 28 11 80    	push   0x80112884
80102cb4:	e8 17 d4 ff ff       	call   801000d0 <bread>
80102cb9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cbb:	58                   	pop    %eax
80102cbc:	5a                   	pop    %edx
80102cbd:	ff 34 bd 8c 28 11 80 	push   -0x7feed774(,%edi,4)
80102cc4:	ff 35 84 28 11 80    	push   0x80112884
  for (tail = 0; tail < log.lh.n; tail++) {
80102cca:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102ccd:	e8 fe d3 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102cd2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cd5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102cd7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cda:	68 00 02 00 00       	push   $0x200
80102cdf:	50                   	push   %eax
80102ce0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102ce3:	50                   	push   %eax
80102ce4:	e8 e7 21 00 00       	call   80104ed0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102ce9:	89 1c 24             	mov    %ebx,(%esp)
80102cec:	e8 cf d4 ff ff       	call   801001c0 <bwrite>
    brelse(lbuf);
80102cf1:	89 34 24             	mov    %esi,(%esp)
80102cf4:	e8 07 d5 ff ff       	call   80100200 <brelse>
    brelse(dbuf);
80102cf9:	89 1c 24             	mov    %ebx,(%esp)
80102cfc:	e8 ff d4 ff ff       	call   80100200 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d01:	83 c4 10             	add    $0x10,%esp
80102d04:	39 3d 88 28 11 80    	cmp    %edi,0x80112888
80102d0a:	7f 94                	jg     80102ca0 <install_trans+0x20>
  }
}
80102d0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d0f:	5b                   	pop    %ebx
80102d10:	5e                   	pop    %esi
80102d11:	5f                   	pop    %edi
80102d12:	5d                   	pop    %ebp
80102d13:	c3                   	ret
80102d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d18:	c3                   	ret
80102d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d20 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	53                   	push   %ebx
80102d24:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d27:	ff 35 74 28 11 80    	push   0x80112874
80102d2d:	ff 35 84 28 11 80    	push   0x80112884
80102d33:	e8 98 d3 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102d38:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d3b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102d3d:	a1 88 28 11 80       	mov    0x80112888,%eax
80102d42:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102d45:	85 c0                	test   %eax,%eax
80102d47:	7e 29                	jle    80102d72 <write_head+0x52>
80102d49:	31 d2                	xor    %edx,%edx
80102d4b:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d52:	00 
80102d53:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d5a:	00 
80102d5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102d60:	8b 0c 95 8c 28 11 80 	mov    -0x7feed774(,%edx,4),%ecx
80102d67:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d6b:	83 c2 01             	add    $0x1,%edx
80102d6e:	39 d0                	cmp    %edx,%eax
80102d70:	75 ee                	jne    80102d60 <write_head+0x40>
  }
  bwrite(buf);
80102d72:	83 ec 0c             	sub    $0xc,%esp
80102d75:	53                   	push   %ebx
80102d76:	e8 45 d4 ff ff       	call   801001c0 <bwrite>
  brelse(buf);
80102d7b:	89 1c 24             	mov    %ebx,(%esp)
80102d7e:	e8 7d d4 ff ff       	call   80100200 <brelse>
}
80102d83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d86:	83 c4 10             	add    $0x10,%esp
80102d89:	c9                   	leave
80102d8a:	c3                   	ret
80102d8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102d90 <initlog>:
{
80102d90:	55                   	push   %ebp
80102d91:	89 e5                	mov    %esp,%ebp
80102d93:	53                   	push   %ebx
80102d94:	83 ec 2c             	sub    $0x2c,%esp
80102d97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102d9a:	68 37 7c 10 80       	push   $0x80107c37
80102d9f:	68 40 28 11 80       	push   $0x80112840
80102da4:	e8 b7 1c 00 00       	call   80104a60 <initlock>
  readsb(dev, &sb);
80102da9:	58                   	pop    %eax
80102daa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102dad:	5a                   	pop    %edx
80102dae:	50                   	push   %eax
80102daf:	53                   	push   %ebx
80102db0:	e8 db e7 ff ff       	call   80101590 <readsb>
  log.start = sb.logstart;
80102db5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102db8:	59                   	pop    %ecx
  log.dev = dev;
80102db9:	89 1d 84 28 11 80    	mov    %ebx,0x80112884
  log.size = sb.nlog;
80102dbf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102dc2:	a3 74 28 11 80       	mov    %eax,0x80112874
  log.size = sb.nlog;
80102dc7:	89 15 78 28 11 80    	mov    %edx,0x80112878
  struct buf *buf = bread(log.dev, log.start);
80102dcd:	5a                   	pop    %edx
80102dce:	50                   	push   %eax
80102dcf:	53                   	push   %ebx
80102dd0:	e8 fb d2 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102dd5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102dd8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102ddb:	89 1d 88 28 11 80    	mov    %ebx,0x80112888
  for (i = 0; i < log.lh.n; i++) {
80102de1:	85 db                	test   %ebx,%ebx
80102de3:	7e 2d                	jle    80102e12 <initlog+0x82>
80102de5:	31 d2                	xor    %edx,%edx
80102de7:	eb 17                	jmp    80102e00 <initlog+0x70>
80102de9:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102df0:	00 
80102df1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102df8:	00 
80102df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102e00:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102e04:	89 0c 95 8c 28 11 80 	mov    %ecx,-0x7feed774(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102e0b:	83 c2 01             	add    $0x1,%edx
80102e0e:	39 d3                	cmp    %edx,%ebx
80102e10:	75 ee                	jne    80102e00 <initlog+0x70>
  brelse(buf);
80102e12:	83 ec 0c             	sub    $0xc,%esp
80102e15:	50                   	push   %eax
80102e16:	e8 e5 d3 ff ff       	call   80100200 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102e1b:	e8 60 fe ff ff       	call   80102c80 <install_trans>
  log.lh.n = 0;
80102e20:	c7 05 88 28 11 80 00 	movl   $0x0,0x80112888
80102e27:	00 00 00 
  write_head(); // clear the log
80102e2a:	e8 f1 fe ff ff       	call   80102d20 <write_head>
}
80102e2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e32:	83 c4 10             	add    $0x10,%esp
80102e35:	c9                   	leave
80102e36:	c3                   	ret
80102e37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e3e:	00 
80102e3f:	90                   	nop

80102e40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102e40:	55                   	push   %ebp
80102e41:	89 e5                	mov    %esp,%ebp
80102e43:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102e46:	68 40 28 11 80       	push   $0x80112840
80102e4b:	e8 50 1d 00 00       	call   80104ba0 <acquire>
80102e50:	83 c4 10             	add    $0x10,%esp
80102e53:	eb 18                	jmp    80102e6d <begin_op+0x2d>
80102e55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102e58:	83 ec 08             	sub    $0x8,%esp
80102e5b:	68 40 28 11 80       	push   $0x80112840
80102e60:	68 40 28 11 80       	push   $0x80112840
80102e65:	e8 e6 16 00 00       	call   80104550 <sleep>
80102e6a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102e6d:	a1 80 28 11 80       	mov    0x80112880,%eax
80102e72:	85 c0                	test   %eax,%eax
80102e74:	75 e2                	jne    80102e58 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102e76:	a1 7c 28 11 80       	mov    0x8011287c,%eax
80102e7b:	8b 15 88 28 11 80    	mov    0x80112888,%edx
80102e81:	83 c0 01             	add    $0x1,%eax
80102e84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102e87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102e8a:	83 fa 1e             	cmp    $0x1e,%edx
80102e8d:	7f c9                	jg     80102e58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102e8f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102e92:	a3 7c 28 11 80       	mov    %eax,0x8011287c
      release(&log.lock);
80102e97:	68 40 28 11 80       	push   $0x80112840
80102e9c:	e8 7f 1e 00 00       	call   80104d20 <release>
      break;
    }
  }
}
80102ea1:	83 c4 10             	add    $0x10,%esp
80102ea4:	c9                   	leave
80102ea5:	c3                   	ret
80102ea6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ead:	00 
80102eae:	66 90                	xchg   %ax,%ax

80102eb0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	57                   	push   %edi
80102eb4:	56                   	push   %esi
80102eb5:	53                   	push   %ebx
80102eb6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102eb9:	68 40 28 11 80       	push   $0x80112840
80102ebe:	e8 dd 1c 00 00       	call   80104ba0 <acquire>
  log.outstanding -= 1;
80102ec3:	a1 7c 28 11 80       	mov    0x8011287c,%eax
  if(log.committing)
80102ec8:	8b 35 80 28 11 80    	mov    0x80112880,%esi
80102ece:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102ed1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102ed4:	89 1d 7c 28 11 80    	mov    %ebx,0x8011287c
  if(log.committing)
80102eda:	85 f6                	test   %esi,%esi
80102edc:	0f 85 22 01 00 00    	jne    80103004 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102ee2:	85 db                	test   %ebx,%ebx
80102ee4:	0f 85 f6 00 00 00    	jne    80102fe0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102eea:	c7 05 80 28 11 80 01 	movl   $0x1,0x80112880
80102ef1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102ef4:	83 ec 0c             	sub    $0xc,%esp
80102ef7:	68 40 28 11 80       	push   $0x80112840
80102efc:	e8 1f 1e 00 00       	call   80104d20 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102f01:	8b 0d 88 28 11 80    	mov    0x80112888,%ecx
80102f07:	83 c4 10             	add    $0x10,%esp
80102f0a:	85 c9                	test   %ecx,%ecx
80102f0c:	7f 42                	jg     80102f50 <end_op+0xa0>
    acquire(&log.lock);
80102f0e:	83 ec 0c             	sub    $0xc,%esp
80102f11:	68 40 28 11 80       	push   $0x80112840
80102f16:	e8 85 1c 00 00       	call   80104ba0 <acquire>
    log.committing = 0;
80102f1b:	c7 05 80 28 11 80 00 	movl   $0x0,0x80112880
80102f22:	00 00 00 
    wakeup(&log);
80102f25:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
80102f2c:	e8 df 16 00 00       	call   80104610 <wakeup>
    release(&log.lock);
80102f31:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
80102f38:	e8 e3 1d 00 00       	call   80104d20 <release>
80102f3d:	83 c4 10             	add    $0x10,%esp
}
80102f40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f43:	5b                   	pop    %ebx
80102f44:	5e                   	pop    %esi
80102f45:	5f                   	pop    %edi
80102f46:	5d                   	pop    %ebp
80102f47:	c3                   	ret
80102f48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f4f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102f50:	a1 74 28 11 80       	mov    0x80112874,%eax
80102f55:	83 ec 08             	sub    $0x8,%esp
80102f58:	01 d8                	add    %ebx,%eax
80102f5a:	83 c0 01             	add    $0x1,%eax
80102f5d:	50                   	push   %eax
80102f5e:	ff 35 84 28 11 80    	push   0x80112884
80102f64:	e8 67 d1 ff ff       	call   801000d0 <bread>
80102f69:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f6b:	58                   	pop    %eax
80102f6c:	5a                   	pop    %edx
80102f6d:	ff 34 9d 8c 28 11 80 	push   -0x7feed774(,%ebx,4)
80102f74:	ff 35 84 28 11 80    	push   0x80112884
  for (tail = 0; tail < log.lh.n; tail++) {
80102f7a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f7d:	e8 4e d1 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102f82:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f85:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102f87:	8d 40 5c             	lea    0x5c(%eax),%eax
80102f8a:	68 00 02 00 00       	push   $0x200
80102f8f:	50                   	push   %eax
80102f90:	8d 46 5c             	lea    0x5c(%esi),%eax
80102f93:	50                   	push   %eax
80102f94:	e8 37 1f 00 00       	call   80104ed0 <memmove>
    bwrite(to);  // write the log
80102f99:	89 34 24             	mov    %esi,(%esp)
80102f9c:	e8 1f d2 ff ff       	call   801001c0 <bwrite>
    brelse(from);
80102fa1:	89 3c 24             	mov    %edi,(%esp)
80102fa4:	e8 57 d2 ff ff       	call   80100200 <brelse>
    brelse(to);
80102fa9:	89 34 24             	mov    %esi,(%esp)
80102fac:	e8 4f d2 ff ff       	call   80100200 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102fb1:	83 c4 10             	add    $0x10,%esp
80102fb4:	3b 1d 88 28 11 80    	cmp    0x80112888,%ebx
80102fba:	7c 94                	jl     80102f50 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102fbc:	e8 5f fd ff ff       	call   80102d20 <write_head>
    install_trans(); // Now install writes to home locations
80102fc1:	e8 ba fc ff ff       	call   80102c80 <install_trans>
    log.lh.n = 0;
80102fc6:	c7 05 88 28 11 80 00 	movl   $0x0,0x80112888
80102fcd:	00 00 00 
    write_head();    // Erase the transaction from the log
80102fd0:	e8 4b fd ff ff       	call   80102d20 <write_head>
80102fd5:	e9 34 ff ff ff       	jmp    80102f0e <end_op+0x5e>
80102fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102fe0:	83 ec 0c             	sub    $0xc,%esp
80102fe3:	68 40 28 11 80       	push   $0x80112840
80102fe8:	e8 23 16 00 00       	call   80104610 <wakeup>
  release(&log.lock);
80102fed:	c7 04 24 40 28 11 80 	movl   $0x80112840,(%esp)
80102ff4:	e8 27 1d 00 00       	call   80104d20 <release>
80102ff9:	83 c4 10             	add    $0x10,%esp
}
80102ffc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fff:	5b                   	pop    %ebx
80103000:	5e                   	pop    %esi
80103001:	5f                   	pop    %edi
80103002:	5d                   	pop    %ebp
80103003:	c3                   	ret
    panic("log.committing");
80103004:	83 ec 0c             	sub    $0xc,%esp
80103007:	68 3b 7c 10 80       	push   $0x80107c3b
8010300c:	e8 8f d3 ff ff       	call   801003a0 <panic>
80103011:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103018:	00 
80103019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103020 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103020:	55                   	push   %ebp
80103021:	89 e5                	mov    %esp,%ebp
80103023:	53                   	push   %ebx
80103024:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103027:	8b 15 88 28 11 80    	mov    0x80112888,%edx
{
8010302d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103030:	83 fa 1d             	cmp    $0x1d,%edx
80103033:	7f 7d                	jg     801030b2 <log_write+0x92>
80103035:	a1 78 28 11 80       	mov    0x80112878,%eax
8010303a:	83 e8 01             	sub    $0x1,%eax
8010303d:	39 c2                	cmp    %eax,%edx
8010303f:	7d 71                	jge    801030b2 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103041:	a1 7c 28 11 80       	mov    0x8011287c,%eax
80103046:	85 c0                	test   %eax,%eax
80103048:	7e 75                	jle    801030bf <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010304a:	83 ec 0c             	sub    $0xc,%esp
8010304d:	68 40 28 11 80       	push   $0x80112840
80103052:	e8 49 1b 00 00       	call   80104ba0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80103057:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010305a:	83 c4 10             	add    $0x10,%esp
8010305d:	31 c0                	xor    %eax,%eax
8010305f:	8b 15 88 28 11 80    	mov    0x80112888,%edx
80103065:	85 d2                	test   %edx,%edx
80103067:	7f 0e                	jg     80103077 <log_write+0x57>
80103069:	eb 15                	jmp    80103080 <log_write+0x60>
8010306b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103070:	83 c0 01             	add    $0x1,%eax
80103073:	39 d0                	cmp    %edx,%eax
80103075:	74 29                	je     801030a0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103077:	39 0c 85 8c 28 11 80 	cmp    %ecx,-0x7feed774(,%eax,4)
8010307e:	75 f0                	jne    80103070 <log_write+0x50>
  log.lh.block[i] = b->blockno;
80103080:	89 0c 85 8c 28 11 80 	mov    %ecx,-0x7feed774(,%eax,4)
  if (i == log.lh.n)
80103087:	39 c2                	cmp    %eax,%edx
80103089:	74 1c                	je     801030a7 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
8010308b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010308e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103091:	c7 45 08 40 28 11 80 	movl   $0x80112840,0x8(%ebp)
}
80103098:	c9                   	leave
  release(&log.lock);
80103099:	e9 82 1c 00 00       	jmp    80104d20 <release>
8010309e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
801030a0:	89 0c 95 8c 28 11 80 	mov    %ecx,-0x7feed774(,%edx,4)
    log.lh.n++;
801030a7:	83 c2 01             	add    $0x1,%edx
801030aa:	89 15 88 28 11 80    	mov    %edx,0x80112888
801030b0:	eb d9                	jmp    8010308b <log_write+0x6b>
    panic("too big a transaction");
801030b2:	83 ec 0c             	sub    $0xc,%esp
801030b5:	68 4a 7c 10 80       	push   $0x80107c4a
801030ba:	e8 e1 d2 ff ff       	call   801003a0 <panic>
    panic("log_write outside of trans");
801030bf:	83 ec 0c             	sub    $0xc,%esp
801030c2:	68 60 7c 10 80       	push   $0x80107c60
801030c7:	e8 d4 d2 ff ff       	call   801003a0 <panic>
801030cc:	66 90                	xchg   %ax,%ax
801030ce:	66 90                	xchg   %ax,%ax

801030d0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801030d0:	55                   	push   %ebp
801030d1:	89 e5                	mov    %esp,%ebp
801030d3:	53                   	push   %ebx
801030d4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801030d7:	e8 c4 08 00 00       	call   801039a0 <cpuid>
801030dc:	89 c3                	mov    %eax,%ebx
801030de:	e8 bd 08 00 00       	call   801039a0 <cpuid>
801030e3:	83 ec 04             	sub    $0x4,%esp
801030e6:	53                   	push   %ebx
801030e7:	50                   	push   %eax
801030e8:	68 7b 7c 10 80       	push   $0x80107c7b
801030ed:	e8 de d5 ff ff       	call   801006d0 <cprintf>
  idtinit();                       // load idt register
801030f2:	e8 f9 30 00 00       	call   801061f0 <idtinit>
  xchg(&(mycpu()->started), 1);    // tell startothers() we're up
801030f7:	e8 44 08 00 00       	call   80103940 <mycpu>
801030fc:	89 c2                	mov    %eax,%edx

static inline uint
xchg(volatile uint *addr, uint newval)
{
  uint result;
  asm volatile("lock; xchgl %0, %1" :
801030fe:	b8 01 00 00 00       	mov    $0x1,%eax
80103103:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();                     // start running processes
8010310a:	e8 b1 0c 00 00       	call   80103dc0 <scheduler>
8010310f:	90                   	nop

80103110 <mpenter>:
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103116:	e8 c5 41 00 00       	call   801072e0 <switchkvm>
  seginit();
8010311b:	e8 30 41 00 00       	call   80107250 <seginit>
  lapicinit();
80103120:	e8 6b f7 ff ff       	call   80102890 <lapicinit>
  mpmain();
80103125:	e8 a6 ff ff ff       	call   801030d0 <mpmain>
8010312a:	66 90                	xchg   %ax,%ax
8010312c:	66 90                	xchg   %ax,%ax
8010312e:	66 90                	xchg   %ax,%ax

80103130 <main>:
{
80103130:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103134:	83 e4 f0             	and    $0xfffffff0,%esp
80103137:	ff 71 fc             	push   -0x4(%ecx)
8010313a:	55                   	push   %ebp
8010313b:	89 e5                	mov    %esp,%ebp
8010313d:	53                   	push   %ebx
8010313e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024));          // phys page allocator
8010313f:	83 ec 08             	sub    $0x8,%esp
80103142:	68 00 00 40 80       	push   $0x80400000
80103147:	68 90 6d 11 80       	push   $0x80116d90
8010314c:	e8 4f f5 ff ff       	call   801026a0 <kinit1>
  kvmalloc();                             // kernel page table
80103151:	e8 4a 46 00 00       	call   801077a0 <kvmalloc>
  mpinit();                               // detect other processors
80103156:	e8 85 01 00 00       	call   801032e0 <mpinit>
  lapicinit();                            // interrupt controller
8010315b:	e8 30 f7 ff ff       	call   80102890 <lapicinit>
  seginit();                              // segment descriptors
80103160:	e8 eb 40 00 00       	call   80107250 <seginit>
  picinit();                              // disable pic
80103165:	e8 56 03 00 00       	call   801034c0 <picinit>
  ioapicinit();                           // another interrupt controller
8010316a:	e8 d1 f2 ff ff       	call   80102440 <ioapicinit>
  consoleinit();                          // console hardware
8010316f:	e8 2c d9 ff ff       	call   80100aa0 <consoleinit>
  uartinit();                             // serial port
80103174:	e8 37 33 00 00       	call   801064b0 <uartinit>
  pinit();                                // process table
80103179:	e8 a2 07 00 00       	call   80103920 <pinit>
  tvinit();                               // trap vectors
8010317e:	e8 bd 2f 00 00       	call   80106140 <tvinit>
  binit();                                // buffer cache
80103183:	e8 b8 ce ff ff       	call   80100040 <binit>
  fileinit();                             // file table
80103188:	e8 f3 dc ff ff       	call   80100e80 <fileinit>
  ideinit();                              // disk 
8010318d:	e8 8e f0 ff ff       	call   80102220 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103192:	83 c4 0c             	add    $0xc,%esp
80103195:	68 8a 00 00 00       	push   $0x8a
8010319a:	68 8c b4 10 80       	push   $0x8010b48c
8010319f:	68 00 70 00 80       	push   $0x80007000
801031a4:	e8 27 1d 00 00       	call   80104ed0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801031a9:	83 c4 10             	add    $0x10,%esp
801031ac:	69 05 20 29 11 80 b0 	imul   $0xb0,0x80112920,%eax
801031b3:	00 00 00 
801031b6:	05 40 29 11 80       	add    $0x80112940,%eax
801031bb:	3d 40 29 11 80       	cmp    $0x80112940,%eax
801031c0:	76 7e                	jbe    80103240 <main+0x110>
801031c2:	bb 40 29 11 80       	mov    $0x80112940,%ebx
801031c7:	eb 20                	jmp    801031e9 <main+0xb9>
801031c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031d0:	69 05 20 29 11 80 b0 	imul   $0xb0,0x80112920,%eax
801031d7:	00 00 00 
801031da:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801031e0:	05 40 29 11 80       	add    $0x80112940,%eax
801031e5:	39 c3                	cmp    %eax,%ebx
801031e7:	73 57                	jae    80103240 <main+0x110>
    if(c == mycpu())  // We've started already.
801031e9:	e8 52 07 00 00       	call   80103940 <mycpu>
801031ee:	39 c3                	cmp    %eax,%ebx
801031f0:	74 de                	je     801031d0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801031f2:	e8 19 f5 ff ff       	call   80102710 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801031f7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801031fa:	c7 05 f8 6f 00 80 10 	movl   $0x80103110,0x80006ff8
80103201:	31 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103204:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010320b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010320e:	05 00 10 00 00       	add    $0x1000,%eax
80103213:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103218:	0f b6 03             	movzbl (%ebx),%eax
8010321b:	68 00 70 00 00       	push   $0x7000
80103220:	50                   	push   %eax
80103221:	e8 ba f7 ff ff       	call   801029e0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103226:	83 c4 10             	add    $0x10,%esp
80103229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103230:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103236:	85 c0                	test   %eax,%eax
80103238:	74 f6                	je     80103230 <main+0x100>
8010323a:	eb 94                	jmp    801031d0 <main+0xa0>
8010323c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103240:	83 ec 08             	sub    $0x8,%esp
80103243:	68 00 00 00 8e       	push   $0x8e000000
80103248:	68 00 00 40 80       	push   $0x80400000
8010324d:	e8 ee f3 ff ff       	call   80102640 <kinit2>
  userinit();                             // first user process
80103252:	e8 c9 08 00 00       	call   80103b20 <userinit>
  mpmain();                               // finish this processor's setup
80103257:	e8 74 fe ff ff       	call   801030d0 <mpmain>
8010325c:	66 90                	xchg   %ax,%ax
8010325e:	66 90                	xchg   %ax,%ax

80103260 <mpsearch1>:
}

// Look for an MP structure in the len bytes at physical address a.
static struct mp*
mpsearch1(uint a, int len)
{
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	57                   	push   %edi
80103264:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = (uchar*)P2V(a);
80103265:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010326b:	53                   	push   %ebx
  e = addr + len;
8010326c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010326f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp)){
80103272:	39 de                	cmp    %ebx,%esi
80103274:	72 10                	jb     80103286 <mpsearch1+0x26>
80103276:	eb 58                	jmp    801032d0 <mpsearch1+0x70>
80103278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010327f:	00 
80103280:	89 fe                	mov    %edi,%esi
80103282:	39 df                	cmp    %ebx,%edi
80103284:	73 4a                	jae    801032d0 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum((uchar*)p, sizeof(struct mp)) == 0)
80103286:	83 ec 04             	sub    $0x4,%esp
80103289:	8d 7e 10             	lea    0x10(%esi),%edi
8010328c:	6a 04                	push   $0x4
8010328e:	68 8f 7c 10 80       	push   $0x80107c8f
80103293:	56                   	push   %esi
80103294:	e8 e7 1b 00 00       	call   80104e80 <memcmp>
80103299:	83 c4 10             	add    $0x10,%esp
8010329c:	85 c0                	test   %eax,%eax
8010329e:	75 e0                	jne    80103280 <mpsearch1+0x20>
801032a0:	89 f2                	mov    %esi,%edx
801032a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801032a9:	00 
801032aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s += addr[i];
801032b0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i = 0; i < len; i++)
801032b3:	83 c2 01             	add    $0x1,%edx
    s += addr[i];
801032b6:	01 c8                	add    %ecx,%eax
  for(i = 0; i < len; i++)
801032b8:	39 fa                	cmp    %edi,%edx
801032ba:	75 f4                	jne    801032b0 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum((uchar*)p, sizeof(struct mp)) == 0)
801032bc:	84 c0                	test   %al,%al
801032be:	75 c0                	jne    80103280 <mpsearch1+0x20>
      return (struct mp*)p;
  }
  return 0;
}
801032c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032c3:	89 f0                	mov    %esi,%eax
801032c5:	5b                   	pop    %ebx
801032c6:	5e                   	pop    %esi
801032c7:	5f                   	pop    %edi
801032c8:	5d                   	pop    %ebp
801032c9:	c3                   	ret
801032ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801032d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801032d3:	31 f6                	xor    %esi,%esi
}
801032d5:	5b                   	pop    %ebx
801032d6:	89 f0                	mov    %esi,%eax
801032d8:	5e                   	pop    %esi
801032d9:	5f                   	pop    %edi
801032da:	5d                   	pop    %ebp
801032db:	c3                   	ret
801032dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032e0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801032e0:	55                   	push   %ebp
801032e1:	89 e5                	mov    %esp,%ebp
801032e3:	57                   	push   %edi
801032e4:	56                   	push   %esi
801032e5:	53                   	push   %ebx
801032e6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8) | bda[0x0E]) << 4)){
801032e9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801032f0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801032f7:	c1 e0 08             	shl    $0x8,%eax
801032fa:	09 d0                	or     %edx,%eax
801032fc:	c1 e0 04             	shl    $0x4,%eax
801032ff:	75 1b                	jne    8010331c <mpinit+0x3c>
    p = ((bda[0x14]<<8) | bda[0x13]) * 1024;
80103301:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103308:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010330f:	c1 e0 08             	shl    $0x8,%eax
80103312:	09 d0                	or     %edx,%eax
80103314:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p - 1024, 1024)))
80103317:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010331c:	ba 00 04 00 00       	mov    $0x400,%edx
80103321:	e8 3a ff ff ff       	call   80103260 <mpsearch1>
80103326:	89 c3                	mov    %eax,%ebx
80103328:	85 c0                	test   %eax,%eax
8010332a:	0f 84 35 01 00 00    	je     80103465 <mpinit+0x185>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103330:	8b 73 04             	mov    0x4(%ebx),%esi
80103333:	85 f6                	test   %esi,%esi
80103335:	0f 84 1d 01 00 00    	je     80103458 <mpinit+0x178>
  if(memcmp((char*)conf, "PCMP", 4) != 0)
8010333b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010333e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103344:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp((char*)conf, "PCMP", 4) != 0)
80103347:	6a 04                	push   $0x4
80103349:	68 94 7c 10 80       	push   $0x80107c94
8010334e:	50                   	push   %eax
8010334f:	e8 2c 1b 00 00       	call   80104e80 <memcmp>
80103354:	83 c4 10             	add    $0x10,%esp
80103357:	89 c2                	mov    %eax,%edx
80103359:	85 c0                	test   %eax,%eax
8010335b:	0f 85 f7 00 00 00    	jne    80103458 <mpinit+0x178>
  if(conf->version != 1 && conf->version != 4)
80103361:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103368:	3c 01                	cmp    $0x1,%al
8010336a:	74 08                	je     80103374 <mpinit+0x94>
8010336c:	3c 04                	cmp    $0x4,%al
8010336e:	0f 85 e4 00 00 00    	jne    80103458 <mpinit+0x178>
  if(sum((uchar*)conf, conf->length) != 0)
80103374:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
  for(i = 0; i < len; i++)
8010337b:	66 85 c9             	test   %cx,%cx
8010337e:	74 28                	je     801033a8 <mpinit+0xc8>
80103380:	89 f0                	mov    %esi,%eax
80103382:	8d 3c 31             	lea    (%ecx,%esi,1),%edi
80103385:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010338c:	00 
8010338d:	8d 76 00             	lea    0x0(%esi),%esi
    s += addr[i];
80103390:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i = 0; i < len; i++)
80103397:	83 c0 01             	add    $0x1,%eax
    s += addr[i];
8010339a:	01 ca                	add    %ecx,%edx
  for(i = 0; i < len; i++)
8010339c:	39 c7                	cmp    %eax,%edi
8010339e:	75 f0                	jne    80103390 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
801033a0:	84 d2                	test   %dl,%dl
801033a2:	0f 85 b0 00 00 00    	jne    80103458 <mpinit+0x178>
  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;

  // lapic physical address is in the MP config table
  lapic = (volatile uint*)conf->lapicaddr;
801033a8:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax

  // Walk entries in MP config table
  for(p = (uchar*)(conf + 1), e = (uchar*)conf + conf->length; p < e; ){
801033ae:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  lapic = (volatile uint*)conf->lapicaddr;
801033b1:	a3 20 28 11 80       	mov    %eax,0x80112820
  for(p = (uchar*)(conf + 1), e = (uchar*)conf + conf->length; p < e; ){
801033b6:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
801033bd:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801033c3:	01 cf                	add    %ecx,%edi
801033c5:	89 f9                	mov    %edi,%ecx
801033c7:	39 f8                	cmp    %edi,%eax
801033c9:	72 10                	jb     801033db <mpinit+0xfb>
801033cb:	eb 34                	jmp    80103401 <mpinit+0x121>
801033cd:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*p){
801033d0:	84 d2                	test   %dl,%dl
801033d2:	74 54                	je     80103428 <mpinit+0x148>
      p += 8;
      continue;

    case MPIOINTR:
    case MPLINTR:
      p += 8;
801033d4:	83 c0 08             	add    $0x8,%eax
  for(p = (uchar*)(conf + 1), e = (uchar*)conf + conf->length; p < e; ){
801033d7:	39 c8                	cmp    %ecx,%eax
801033d9:	73 26                	jae    80103401 <mpinit+0x121>
    switch(*p){
801033db:	0f b6 10             	movzbl (%eax),%edx
801033de:	80 fa 02             	cmp    $0x2,%dl
801033e1:	74 0d                	je     801033f0 <mpinit+0x110>
801033e3:	76 eb                	jbe    801033d0 <mpinit+0xf0>
801033e5:	83 ea 03             	sub    $0x3,%edx
801033e8:	80 fa 01             	cmp    $0x1,%dl
801033eb:	76 e7                	jbe    801033d4 <mpinit+0xf4>
801033ed:	eb fe                	jmp    801033ed <mpinit+0x10d>
801033ef:	90                   	nop
      ioapicid = mioapic->apicno;   // record IO APIC id
801033f0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801033f4:	83 c0 08             	add    $0x8,%eax
      ioapicid = mioapic->apicno;   // record IO APIC id
801033f7:	88 15 d4 27 11 80    	mov    %dl,0x801127d4
  for(p = (uchar*)(conf + 1), e = (uchar*)conf + conf->length; p < e; ){
801033fd:	39 c8                	cmp    %ecx,%eax
801033ff:	72 da                	jb     801033db <mpinit+0xfb>
  }

  if(!ismp)
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103401:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103405:	74 15                	je     8010341c <mpinit+0x13c>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103407:	b8 70 00 00 00       	mov    $0x70,%eax
8010340c:	ba 22 00 00 00       	mov    $0x22,%edx
80103411:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103412:	ba 23 00 00 00       	mov    $0x23,%edx
80103417:	ec                   	in     (%dx),%al
    // If an interrupt mode change register is present, program it.
    // (Bochs does not support IMCR; this code is for real hardware.)
    outb(0x22, 0x70);                 // Select IMCR
    outb(0x23, inb(0x23) | 1);        // Mask external interrupts.
80103418:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010341b:	ee                   	out    %al,(%dx)
  }
}
8010341c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010341f:	5b                   	pop    %ebx
80103420:	5e                   	pop    %esi
80103421:	5f                   	pop    %edi
80103422:	5d                   	pop    %ebp
80103423:	c3                   	ret
80103424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU){
80103428:	8b 35 20 29 11 80    	mov    0x80112920,%esi
8010342e:	83 fe 07             	cmp    $0x7,%esi
80103431:	7f 19                	jg     8010344c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // APIC id may differ from logical cpu number
80103433:	69 fe b0 00 00 00    	imul   $0xb0,%esi,%edi
80103439:	0f b6 50 01          	movzbl 0x1(%eax),%edx
        ncpu++;
8010343d:	83 c6 01             	add    $0x1,%esi
80103440:	89 35 20 29 11 80    	mov    %esi,0x80112920
        cpus[ncpu].apicid = proc->apicid;  // APIC id may differ from logical cpu number
80103446:	88 97 40 29 11 80    	mov    %dl,-0x7feed6c0(%edi)
      p += sizeof(struct mpproc);
8010344c:	83 c0 14             	add    $0x14,%eax
      continue;
8010344f:	eb 86                	jmp    801033d7 <mpinit+0xf7>
80103451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103458:	83 ec 0c             	sub    $0xc,%esp
8010345b:	68 99 7c 10 80       	push   $0x80107c99
80103460:	e8 3b cf ff ff       	call   801003a0 <panic>
{
80103465:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010346a:	eb 0e                	jmp    8010347a <mpinit+0x19a>
8010346c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = addr; p < e; p += sizeof(struct mp)){
80103470:	89 f3                	mov    %esi,%ebx
80103472:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103478:	74 de                	je     80103458 <mpinit+0x178>
    if(memcmp(p, "_MP_", 4) == 0 && sum((uchar*)p, sizeof(struct mp)) == 0)
8010347a:	83 ec 04             	sub    $0x4,%esp
8010347d:	8d 73 10             	lea    0x10(%ebx),%esi
80103480:	6a 04                	push   $0x4
80103482:	68 8f 7c 10 80       	push   $0x80107c8f
80103487:	53                   	push   %ebx
80103488:	e8 f3 19 00 00       	call   80104e80 <memcmp>
8010348d:	83 c4 10             	add    $0x10,%esp
80103490:	85 c0                	test   %eax,%eax
80103492:	75 dc                	jne    80103470 <mpinit+0x190>
80103494:	89 da                	mov    %ebx,%edx
80103496:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010349d:	00 
8010349e:	66 90                	xchg   %ax,%ax
    s += addr[i];
801034a0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i = 0; i < len; i++)
801034a3:	83 c2 01             	add    $0x1,%edx
    s += addr[i];
801034a6:	01 c8                	add    %ecx,%eax
  for(i = 0; i < len; i++)
801034a8:	39 d6                	cmp    %edx,%esi
801034aa:	75 f4                	jne    801034a0 <mpinit+0x1c0>
    if(memcmp(p, "_MP_", 4) == 0 && sum((uchar*)p, sizeof(struct mp)) == 0)
801034ac:	84 c0                	test   %al,%al
801034ae:	75 c0                	jne    80103470 <mpinit+0x190>
801034b0:	e9 7b fe ff ff       	jmp    80103330 <mpinit+0x50>
801034b5:	66 90                	xchg   %ax,%ax
801034b7:	66 90                	xchg   %ax,%ax
801034b9:	66 90                	xchg   %ax,%ax
801034bb:	66 90                	xchg   %ax,%ax
801034bd:	66 90                	xchg   %ax,%ax
801034bf:	90                   	nop

801034c0 <picinit>:
801034c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801034c5:	ba 21 00 00 00       	mov    $0x21,%edx
801034ca:	ee                   	out    %al,(%dx)
801034cb:	ba a1 00 00 00       	mov    $0xa1,%edx
801034d0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801034d1:	c3                   	ret
801034d2:	66 90                	xchg   %ax,%ax
801034d4:	66 90                	xchg   %ax,%ax
801034d6:	66 90                	xchg   %ax,%ax
801034d8:	66 90                	xchg   %ax,%ax
801034da:	66 90                	xchg   %ax,%ax
801034dc:	66 90                	xchg   %ax,%ax
801034de:	66 90                	xchg   %ax,%ax
801034e0:	66 90                	xchg   %ax,%ax
801034e2:	66 90                	xchg   %ax,%ax
801034e4:	66 90                	xchg   %ax,%ax
801034e6:	66 90                	xchg   %ax,%ax
801034e8:	66 90                	xchg   %ax,%ax
801034ea:	66 90                	xchg   %ax,%ax
801034ec:	66 90                	xchg   %ax,%ax
801034ee:	66 90                	xchg   %ax,%ax
801034f0:	66 90                	xchg   %ax,%ax
801034f2:	66 90                	xchg   %ax,%ax
801034f4:	66 90                	xchg   %ax,%ax
801034f6:	66 90                	xchg   %ax,%ax
801034f8:	66 90                	xchg   %ax,%ax
801034fa:	66 90                	xchg   %ax,%ax
801034fc:	66 90                	xchg   %ax,%ax
801034fe:	66 90                	xchg   %ax,%ax

80103500 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103500:	55                   	push   %ebp
80103501:	89 e5                	mov    %esp,%ebp
80103503:	57                   	push   %edi
80103504:	56                   	push   %esi
80103505:	53                   	push   %ebx
80103506:	83 ec 0c             	sub    $0xc,%esp
80103509:	8b 75 08             	mov    0x8(%ebp),%esi
8010350c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010350f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103515:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010351b:	e8 80 d9 ff ff       	call   80100ea0 <filealloc>
80103520:	89 06                	mov    %eax,(%esi)
80103522:	85 c0                	test   %eax,%eax
80103524:	0f 84 a5 00 00 00    	je     801035cf <pipealloc+0xcf>
8010352a:	e8 71 d9 ff ff       	call   80100ea0 <filealloc>
8010352f:	89 07                	mov    %eax,(%edi)
80103531:	85 c0                	test   %eax,%eax
80103533:	0f 84 84 00 00 00    	je     801035bd <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103539:	e8 d2 f1 ff ff       	call   80102710 <kalloc>
8010353e:	89 c3                	mov    %eax,%ebx
80103540:	85 c0                	test   %eax,%eax
80103542:	0f 84 a0 00 00 00    	je     801035e8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103548:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010354f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103552:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103555:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010355c:	00 00 00 
  p->nwrite = 0;
8010355f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103566:	00 00 00 
  p->nread = 0;
80103569:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103570:	00 00 00 
  initlock(&p->lock, "pipe");
80103573:	68 b1 7c 10 80       	push   $0x80107cb1
80103578:	50                   	push   %eax
80103579:	e8 e2 14 00 00       	call   80104a60 <initlock>
  (*f0)->type = FD_PIPE;
8010357e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103580:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103583:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103589:	8b 06                	mov    (%esi),%eax
8010358b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010358f:	8b 06                	mov    (%esi),%eax
80103591:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103595:	8b 06                	mov    (%esi),%eax
80103597:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010359a:	8b 07                	mov    (%edi),%eax
8010359c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801035a2:	8b 07                	mov    (%edi),%eax
801035a4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801035a8:	8b 07                	mov    (%edi),%eax
801035aa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801035ae:	8b 07                	mov    (%edi),%eax
801035b0:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
801035b3:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801035b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035b8:	5b                   	pop    %ebx
801035b9:	5e                   	pop    %esi
801035ba:	5f                   	pop    %edi
801035bb:	5d                   	pop    %ebp
801035bc:	c3                   	ret
  if(*f0)
801035bd:	8b 06                	mov    (%esi),%eax
801035bf:	85 c0                	test   %eax,%eax
801035c1:	74 1e                	je     801035e1 <pipealloc+0xe1>
    fileclose(*f0);
801035c3:	83 ec 0c             	sub    $0xc,%esp
801035c6:	50                   	push   %eax
801035c7:	e8 94 d9 ff ff       	call   80100f60 <fileclose>
801035cc:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801035cf:	8b 07                	mov    (%edi),%eax
801035d1:	85 c0                	test   %eax,%eax
801035d3:	74 0c                	je     801035e1 <pipealloc+0xe1>
    fileclose(*f1);
801035d5:	83 ec 0c             	sub    $0xc,%esp
801035d8:	50                   	push   %eax
801035d9:	e8 82 d9 ff ff       	call   80100f60 <fileclose>
801035de:	83 c4 10             	add    $0x10,%esp
  return -1;
801035e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035e6:	eb cd                	jmp    801035b5 <pipealloc+0xb5>
  if(*f0)
801035e8:	8b 06                	mov    (%esi),%eax
801035ea:	85 c0                	test   %eax,%eax
801035ec:	75 d5                	jne    801035c3 <pipealloc+0xc3>
801035ee:	eb df                	jmp    801035cf <pipealloc+0xcf>

801035f0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801035f0:	55                   	push   %ebp
801035f1:	89 e5                	mov    %esp,%ebp
801035f3:	56                   	push   %esi
801035f4:	53                   	push   %ebx
801035f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801035fb:	83 ec 0c             	sub    $0xc,%esp
801035fe:	53                   	push   %ebx
801035ff:	e8 9c 15 00 00       	call   80104ba0 <acquire>
  if(writable){
80103604:	83 c4 10             	add    $0x10,%esp
80103607:	85 f6                	test   %esi,%esi
80103609:	74 45                	je     80103650 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010360b:	83 ec 0c             	sub    $0xc,%esp
8010360e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103614:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010361b:	00 00 00 
    wakeup(&p->nread);
8010361e:	50                   	push   %eax
8010361f:	e8 ec 0f 00 00       	call   80104610 <wakeup>
80103624:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103627:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010362d:	85 d2                	test   %edx,%edx
8010362f:	75 0a                	jne    8010363b <pipeclose+0x4b>
80103631:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103637:	85 c0                	test   %eax,%eax
80103639:	74 35                	je     80103670 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010363b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010363e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103641:	5b                   	pop    %ebx
80103642:	5e                   	pop    %esi
80103643:	5d                   	pop    %ebp
    release(&p->lock);
80103644:	e9 d7 16 00 00       	jmp    80104d20 <release>
80103649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103650:	83 ec 0c             	sub    $0xc,%esp
80103653:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103659:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103660:	00 00 00 
    wakeup(&p->nwrite);
80103663:	50                   	push   %eax
80103664:	e8 a7 0f 00 00       	call   80104610 <wakeup>
80103669:	83 c4 10             	add    $0x10,%esp
8010366c:	eb b9                	jmp    80103627 <pipeclose+0x37>
8010366e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103670:	83 ec 0c             	sub    $0xc,%esp
80103673:	53                   	push   %ebx
80103674:	e8 a7 16 00 00       	call   80104d20 <release>
    kfree((char*)p);
80103679:	83 c4 10             	add    $0x10,%esp
8010367c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010367f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103682:	5b                   	pop    %ebx
80103683:	5e                   	pop    %esi
80103684:	5d                   	pop    %ebp
    kfree((char*)p);
80103685:	e9 b6 ee ff ff       	jmp    80102540 <kfree>
8010368a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103690 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103690:	55                   	push   %ebp
80103691:	89 e5                	mov    %esp,%ebp
80103693:	57                   	push   %edi
80103694:	56                   	push   %esi
80103695:	53                   	push   %ebx
80103696:	83 ec 28             	sub    $0x28,%esp
80103699:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010369c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010369f:	53                   	push   %ebx
801036a0:	e8 fb 14 00 00       	call   80104ba0 <acquire>
  for(i = 0; i < n; i++){
801036a5:	83 c4 10             	add    $0x10,%esp
801036a8:	85 ff                	test   %edi,%edi
801036aa:	0f 8e ce 00 00 00    	jle    8010377e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036b0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801036b6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801036b9:	89 7d 10             	mov    %edi,0x10(%ebp)
801036bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801036bf:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801036c2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801036c5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036cb:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801036d1:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036d7:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801036dd:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801036e0:	0f 85 b6 00 00 00    	jne    8010379c <pipewrite+0x10c>
801036e6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801036e9:	eb 3b                	jmp    80103726 <pipewrite+0x96>
801036eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
801036f0:	e8 cb 02 00 00       	call   801039c0 <myproc>
801036f5:	8b 48 24             	mov    0x24(%eax),%ecx
801036f8:	85 c9                	test   %ecx,%ecx
801036fa:	75 34                	jne    80103730 <pipewrite+0xa0>
      wakeup(&p->nread);
801036fc:	83 ec 0c             	sub    $0xc,%esp
801036ff:	56                   	push   %esi
80103700:	e8 0b 0f 00 00       	call   80104610 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103705:	58                   	pop    %eax
80103706:	5a                   	pop    %edx
80103707:	53                   	push   %ebx
80103708:	57                   	push   %edi
80103709:	e8 42 0e 00 00       	call   80104550 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010370e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103714:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010371a:	83 c4 10             	add    $0x10,%esp
8010371d:	05 00 02 00 00       	add    $0x200,%eax
80103722:	39 c2                	cmp    %eax,%edx
80103724:	75 2a                	jne    80103750 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103726:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010372c:	85 c0                	test   %eax,%eax
8010372e:	75 c0                	jne    801036f0 <pipewrite+0x60>
        release(&p->lock);
80103730:	83 ec 0c             	sub    $0xc,%esp
80103733:	53                   	push   %ebx
80103734:	e8 e7 15 00 00       	call   80104d20 <release>
        return -1;
80103739:	83 c4 10             	add    $0x10,%esp
8010373c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103741:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103744:	5b                   	pop    %ebx
80103745:	5e                   	pop    %esi
80103746:	5f                   	pop    %edi
80103747:	5d                   	pop    %ebp
80103748:	c3                   	ret
80103749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103750:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103753:	8d 42 01             	lea    0x1(%edx),%eax
80103756:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010375c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010375f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103765:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103768:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010376c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103770:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103773:	39 c1                	cmp    %eax,%ecx
80103775:	0f 85 50 ff ff ff    	jne    801036cb <pipewrite+0x3b>
8010377b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010377e:	83 ec 0c             	sub    $0xc,%esp
80103781:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103787:	50                   	push   %eax
80103788:	e8 83 0e 00 00       	call   80104610 <wakeup>
  release(&p->lock);
8010378d:	89 1c 24             	mov    %ebx,(%esp)
80103790:	e8 8b 15 00 00       	call   80104d20 <release>
  return n;
80103795:	83 c4 10             	add    $0x10,%esp
80103798:	89 f8                	mov    %edi,%eax
8010379a:	eb a5                	jmp    80103741 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010379c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010379f:	eb b2                	jmp    80103753 <pipewrite+0xc3>
801037a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801037a8:	00 
801037a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801037b0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	57                   	push   %edi
801037b4:	56                   	push   %esi
801037b5:	53                   	push   %ebx
801037b6:	83 ec 18             	sub    $0x18,%esp
801037b9:	8b 75 08             	mov    0x8(%ebp),%esi
801037bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801037bf:	56                   	push   %esi
801037c0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801037c6:	e8 d5 13 00 00       	call   80104ba0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801037cb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801037d1:	83 c4 10             	add    $0x10,%esp
801037d4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801037da:	74 2f                	je     8010380b <piperead+0x5b>
801037dc:	eb 37                	jmp    80103815 <piperead+0x65>
801037de:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801037e0:	e8 db 01 00 00       	call   801039c0 <myproc>
801037e5:	8b 40 24             	mov    0x24(%eax),%eax
801037e8:	85 c0                	test   %eax,%eax
801037ea:	0f 85 a0 00 00 00    	jne    80103890 <piperead+0xe0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801037f0:	83 ec 08             	sub    $0x8,%esp
801037f3:	56                   	push   %esi
801037f4:	53                   	push   %ebx
801037f5:	e8 56 0d 00 00       	call   80104550 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801037fa:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103800:	83 c4 10             	add    $0x10,%esp
80103803:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103809:	75 0a                	jne    80103815 <piperead+0x65>
8010380b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103811:	85 d2                	test   %edx,%edx
80103813:	75 cb                	jne    801037e0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103815:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103818:	31 db                	xor    %ebx,%ebx
8010381a:	85 c9                	test   %ecx,%ecx
8010381c:	7f 46                	jg     80103864 <piperead+0xb4>
8010381e:	eb 4c                	jmp    8010386c <piperead+0xbc>
80103820:	eb 1e                	jmp    80103840 <piperead+0x90>
80103822:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103829:	00 
8010382a:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103831:	00 
80103832:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103839:	00 
8010383a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103840:	8d 48 01             	lea    0x1(%eax),%ecx
80103843:	25 ff 01 00 00       	and    $0x1ff,%eax
80103848:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010384e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103853:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103856:	83 c3 01             	add    $0x1,%ebx
80103859:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010385c:	74 0e                	je     8010386c <piperead+0xbc>
8010385e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103864:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010386a:	75 d4                	jne    80103840 <piperead+0x90>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010386c:	83 ec 0c             	sub    $0xc,%esp
8010386f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103875:	50                   	push   %eax
80103876:	e8 95 0d 00 00       	call   80104610 <wakeup>
  release(&p->lock);
8010387b:	89 34 24             	mov    %esi,(%esp)
8010387e:	e8 9d 14 00 00       	call   80104d20 <release>
  return i;
80103883:	83 c4 10             	add    $0x10,%esp
}
80103886:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103889:	89 d8                	mov    %ebx,%eax
8010388b:	5b                   	pop    %ebx
8010388c:	5e                   	pop    %esi
8010388d:	5f                   	pop    %edi
8010388e:	5d                   	pop    %ebp
8010388f:	c3                   	ret
      release(&p->lock);
80103890:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103893:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103898:	56                   	push   %esi
80103899:	e8 82 14 00 00       	call   80104d20 <release>
      return -1;
8010389e:	83 c4 10             	add    $0x10,%esp
}
801038a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038a4:	89 d8                	mov    %ebx,%eax
801038a6:	5b                   	pop    %ebx
801038a7:	5e                   	pop    %esi
801038a8:	5f                   	pop    %edi
801038a9:	5d                   	pop    %ebp
801038aa:	c3                   	ret
801038ab:	66 90                	xchg   %ax,%ax
801038ad:	66 90                	xchg   %ax,%ax
801038af:	66 90                	xchg   %ax,%ax
801038b1:	66 90                	xchg   %ax,%ax
801038b3:	66 90                	xchg   %ax,%ax
801038b5:	66 90                	xchg   %ax,%ax
801038b7:	66 90                	xchg   %ax,%ax
801038b9:	66 90                	xchg   %ax,%ax
801038bb:	66 90                	xchg   %ax,%ax
801038bd:	66 90                	xchg   %ax,%ax
801038bf:	90                   	nop

801038c0 <forkret>:
}

// A fork child's very first scheduling by scheduler() will swtch here.
void
forkret(void)
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038c6:	68 e0 2e 11 80       	push   $0x80112ee0
801038cb:	e8 50 14 00 00       	call   80104d20 <release>

  if (first) {
801038d0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801038d5:	83 c4 10             	add    $0x10,%esp
801038d8:	85 c0                	test   %eax,%eax
801038da:	75 04                	jne    801038e0 <forkret+0x20>
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }
  // Return to trapret (set up in allocproc)
}
801038dc:	c9                   	leave
801038dd:	c3                   	ret
801038de:	66 90                	xchg   %ax,%ax
    first = 0;
801038e0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801038e7:	00 00 00 
    iinit(ROOTDEV);
801038ea:	83 ec 0c             	sub    $0xc,%esp
801038ed:	6a 01                	push   $0x1
801038ef:	e8 dc dc ff ff       	call   801015d0 <iinit>
    initlog(ROOTDEV);
801038f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038fb:	e8 90 f4 ff ff       	call   80102d90 <initlog>
}
80103900:	83 c4 10             	add    $0x10,%esp
80103903:	c9                   	leave
80103904:	c3                   	ret
80103905:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010390c:	00 
8010390d:	8d 76 00             	lea    0x0(%esi),%esi

80103910 <curpolicy>:
int curpolicy(void){ return scheduling_policy; }
80103910:	a1 c0 2e 11 80       	mov    0x80112ec0,%eax
80103915:	c3                   	ret
80103916:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010391d:	00 
8010391e:	66 90                	xchg   %ax,%ax

80103920 <pinit>:
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103926:	68 b6 7c 10 80       	push   $0x80107cb6
8010392b:	68 e0 2e 11 80       	push   $0x80112ee0
80103930:	e8 2b 11 00 00       	call   80104a60 <initlock>
}
80103935:	83 c4 10             	add    $0x10,%esp
80103938:	c9                   	leave
80103939:	c3                   	ret
8010393a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103940 <mycpu>:
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	56                   	push   %esi
80103944:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103945:	9c                   	pushf
80103946:	58                   	pop    %eax
  if(readeflags() & FL_IF)
80103947:	f6 c4 02             	test   $0x2,%ah
8010394a:	75 46                	jne    80103992 <mycpu+0x52>
  apicid = lapicid();
8010394c:	e8 3f f0 ff ff       	call   80102990 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103951:	8b 35 20 29 11 80    	mov    0x80112920,%esi
80103957:	85 f6                	test   %esi,%esi
80103959:	7e 2a                	jle    80103985 <mycpu+0x45>
8010395b:	31 d2                	xor    %edx,%edx
8010395d:	eb 08                	jmp    80103967 <mycpu+0x27>
8010395f:	90                   	nop
80103960:	83 c2 01             	add    $0x1,%edx
80103963:	39 f2                	cmp    %esi,%edx
80103965:	74 1e                	je     80103985 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103967:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010396d:	0f b6 99 40 29 11 80 	movzbl -0x7feed6c0(%ecx),%ebx
80103974:	39 c3                	cmp    %eax,%ebx
80103976:	75 e8                	jne    80103960 <mycpu+0x20>
}
80103978:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010397b:	8d 81 40 29 11 80    	lea    -0x7feed6c0(%ecx),%eax
}
80103981:	5b                   	pop    %ebx
80103982:	5e                   	pop    %esi
80103983:	5d                   	pop    %ebp
80103984:	c3                   	ret
  panic("unknown apicid\n");
80103985:	83 ec 0c             	sub    $0xc,%esp
80103988:	68 bd 7c 10 80       	push   $0x80107cbd
8010398d:	e8 0e ca ff ff       	call   801003a0 <panic>
    panic("mycpu called with interrupts enabled\n");
80103992:	83 ec 0c             	sub    $0xc,%esp
80103995:	68 f4 7f 10 80       	push   $0x80107ff4
8010399a:	e8 01 ca ff ff       	call   801003a0 <panic>
8010399f:	90                   	nop

801039a0 <cpuid>:
cpuid(void) {
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	83 ec 08             	sub    $0x8,%esp
  return mycpu() - cpus;
801039a6:	e8 95 ff ff ff       	call   80103940 <mycpu>
}
801039ab:	c9                   	leave
  return mycpu() - cpus;
801039ac:	2d 40 29 11 80       	sub    $0x80112940,%eax
801039b1:	c1 f8 04             	sar    $0x4,%eax
801039b4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801039ba:	c3                   	ret
801039bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801039c0 <myproc>:
myproc(void) {
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	53                   	push   %ebx
801039c4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801039c7:	e8 b4 10 00 00       	call   80104a80 <pushcli>
  c = mycpu();
801039cc:	e8 6f ff ff ff       	call   80103940 <mycpu>
  p = c->proc;
801039d1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039d7:	e8 f4 10 00 00       	call   80104ad0 <popcli>
}
801039dc:	89 d8                	mov    %ebx,%eax
801039de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039e1:	c9                   	leave
801039e2:	c3                   	ret
801039e3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039ea:	00 
801039eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801039f0 <allocproc>:
{
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039f4:	bb 14 2f 11 80       	mov    $0x80112f14,%ebx
{
801039f9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801039fc:	68 e0 2e 11 80       	push   $0x80112ee0
80103a01:	e8 9a 11 00 00       	call   80104ba0 <acquire>
80103a06:	83 c4 10             	add    $0x10,%esp
80103a09:	eb 27                	jmp    80103a32 <allocproc+0x42>
80103a0b:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a12:	00 
80103a13:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a1a:	00 
80103a1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a20:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103a26:	81 fb 14 55 11 80    	cmp    $0x80115514,%ebx
80103a2c:	0f 84 be 00 00 00    	je     80103af0 <allocproc+0x100>
    if(p->state == UNUSED)
80103a32:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a35:	85 c0                	test   %eax,%eax
80103a37:	75 e7                	jne    80103a20 <allocproc+0x30>
  p->pid = nextpid++;
80103a39:	a1 08 b0 10 80       	mov    0x8010b008,%eax
  release(&ptable.lock);
80103a3e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103a41:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103a48:	89 43 10             	mov    %eax,0x10(%ebx)
80103a4b:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103a4e:	68 e0 2e 11 80       	push   $0x80112ee0
  p->pid = nextpid++;
80103a53:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  release(&ptable.lock);
80103a59:	e8 c2 12 00 00       	call   80104d20 <release>
  if((p->kstack = kalloc()) == 0){
80103a5e:	e8 ad ec ff ff       	call   80102710 <kalloc>
80103a63:	83 c4 10             	add    $0x10,%esp
80103a66:	89 43 08             	mov    %eax,0x8(%ebx)
80103a69:	85 c0                	test   %eax,%eax
80103a6b:	0f 84 98 00 00 00    	je     80103b09 <allocproc+0x119>
  sp -= sizeof *p->tf;
80103a71:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(p->context, 0, sizeof *p->context);
80103a77:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103a7a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103a7f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103a82:	c7 40 14 17 61 10 80 	movl   $0x80106117,0x14(%eax)
  p->context = (struct context*)sp;
80103a89:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103a8c:	6a 14                	push   $0x14
80103a8e:	6a 00                	push   $0x0
80103a90:	50                   	push   %eax
80103a91:	e8 aa 13 00 00       	call   80104e40 <memset>
  p->context->eip = (uint)forkret;
80103a96:	8b 43 1c             	mov    0x1c(%ebx),%eax
  return p;
80103a99:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103a9c:	c7 40 10 c0 38 10 80 	movl   $0x801038c0,0x10(%eax)
  p->ctime = ticks;
80103aa3:	a1 20 55 11 80       	mov    0x80115520,%eax
  p->etime = 0;
80103aa8:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103aaf:	00 00 00 
  p->ctime = ticks;
80103ab2:	89 43 7c             	mov    %eax,0x7c(%ebx)
}
80103ab5:	89 d8                	mov    %ebx,%eax
  p->rtime = 0;
80103ab7:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103abe:	00 00 00 
  p->retime = 0;
80103ac1:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103ac8:	00 00 00 
  p->stime = 0;
80103acb:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103ad2:	00 00 00 
  p->tickets = 10;
80103ad5:	c7 83 90 00 00 00 0a 	movl   $0xa,0x90(%ebx)
80103adc:	00 00 00 
  p->original_tickets = 10;
80103adf:	c7 83 94 00 00 00 0a 	movl   $0xa,0x94(%ebx)
80103ae6:	00 00 00 
}
80103ae9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103aec:	c9                   	leave
80103aed:	c3                   	ret
80103aee:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
80103af0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103af3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103af5:	68 e0 2e 11 80       	push   $0x80112ee0
80103afa:	e8 21 12 00 00       	call   80104d20 <release>
  return 0;
80103aff:	83 c4 10             	add    $0x10,%esp
}
80103b02:	89 d8                	mov    %ebx,%eax
80103b04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b07:	c9                   	leave
80103b08:	c3                   	ret
    p->state = UNUSED;
80103b09:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103b10:	31 db                	xor    %ebx,%ebx
80103b12:	eb ee                	jmp    80103b02 <allocproc+0x112>
80103b14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b1b:	00 
80103b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b20 <userinit>:
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	53                   	push   %ebx
80103b24:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103b27:	e8 c4 fe ff ff       	call   801039f0 <allocproc>
80103b2c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103b2e:	a3 14 55 11 80       	mov    %eax,0x80115514
  if((p->pgdir = setupkvm()) == 0)
80103b33:	e8 e8 3b 00 00       	call   80107720 <setupkvm>
80103b38:	89 43 04             	mov    %eax,0x4(%ebx)
80103b3b:	85 c0                	test   %eax,%eax
80103b3d:	0f 84 bd 00 00 00    	je     80103c00 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b43:	83 ec 04             	sub    $0x4,%esp
80103b46:	68 2c 00 00 00       	push   $0x2c
80103b4b:	68 60 b4 10 80       	push   $0x8010b460
80103b50:	50                   	push   %eax
80103b51:	e8 aa 38 00 00       	call   80107400 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103b56:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103b59:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103b5f:	6a 4c                	push   $0x4c
80103b61:	6a 00                	push   $0x0
80103b63:	ff 73 18             	push   0x18(%ebx)
80103b66:	e8 d5 12 00 00       	call   80104e40 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b6b:	8b 43 18             	mov    0x18(%ebx),%eax
80103b6e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b73:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b76:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b7b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b7f:	8b 43 18             	mov    0x18(%ebx),%eax
80103b82:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b86:	8b 43 18             	mov    0x18(%ebx),%eax
80103b89:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b8d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103b91:	8b 43 18             	mov    0x18(%ebx),%eax
80103b94:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b98:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103b9c:	8b 43 18             	mov    0x18(%ebx),%eax
80103b9f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103ba6:	8b 43 18             	mov    0x18(%ebx),%eax
80103ba9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;
80103bb0:	8b 43 18             	mov    0x18(%ebx),%eax
80103bb3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103bba:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103bbd:	6a 10                	push   $0x10
80103bbf:	68 e6 7c 10 80       	push   $0x80107ce6
80103bc4:	50                   	push   %eax
80103bc5:	e8 36 14 00 00       	call   80105000 <safestrcpy>
  p->cwd = namei("/");
80103bca:	c7 04 24 ef 7c 10 80 	movl   $0x80107cef,(%esp)
80103bd1:	e8 2a e5 ff ff       	call   80102100 <namei>
80103bd6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103bd9:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
80103be0:	e8 bb 0f 00 00       	call   80104ba0 <acquire>
  p->state = RUNNABLE;
80103be5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103bec:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
80103bf3:	e8 28 11 00 00       	call   80104d20 <release>
}
80103bf8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bfb:	83 c4 10             	add    $0x10,%esp
80103bfe:	c9                   	leave
80103bff:	c3                   	ret
    panic("userinit: out of memory?");
80103c00:	83 ec 0c             	sub    $0xc,%esp
80103c03:	68 cd 7c 10 80       	push   $0x80107ccd
80103c08:	e8 93 c7 ff ff       	call   801003a0 <panic>
80103c0d:	8d 76 00             	lea    0x0(%esi),%esi

80103c10 <growproc>:
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	56                   	push   %esi
80103c14:	53                   	push   %ebx
80103c15:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103c18:	e8 63 0e 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80103c1d:	e8 1e fd ff ff       	call   80103940 <mycpu>
  p = c->proc;
80103c22:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c28:	e8 a3 0e 00 00       	call   80104ad0 <popcli>
  sz = curproc->sz;
80103c2d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103c2f:	85 f6                	test   %esi,%esi
80103c31:	7f 1d                	jg     80103c50 <growproc+0x40>
  } else if(n < 0){
80103c33:	75 3b                	jne    80103c70 <growproc+0x60>
  switchuvm(curproc);
80103c35:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103c38:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103c3a:	53                   	push   %ebx
80103c3b:	e8 b0 36 00 00       	call   801072f0 <switchuvm>
  return 0;
80103c40:	83 c4 10             	add    $0x10,%esp
80103c43:	31 c0                	xor    %eax,%eax
}
80103c45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c48:	5b                   	pop    %ebx
80103c49:	5e                   	pop    %esi
80103c4a:	5d                   	pop    %ebp
80103c4b:	c3                   	ret
80103c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c50:	83 ec 04             	sub    $0x4,%esp
80103c53:	01 c6                	add    %eax,%esi
80103c55:	56                   	push   %esi
80103c56:	50                   	push   %eax
80103c57:	ff 73 04             	push   0x4(%ebx)
80103c5a:	e8 f1 38 00 00       	call   80107550 <allocuvm>
80103c5f:	83 c4 10             	add    $0x10,%esp
80103c62:	85 c0                	test   %eax,%eax
80103c64:	75 cf                	jne    80103c35 <growproc+0x25>
      return -1;
80103c66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c6b:	eb d8                	jmp    80103c45 <growproc+0x35>
80103c6d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c70:	83 ec 04             	sub    $0x4,%esp
80103c73:	01 c6                	add    %eax,%esi
80103c75:	56                   	push   %esi
80103c76:	50                   	push   %eax
80103c77:	ff 73 04             	push   0x4(%ebx)
80103c7a:	e8 f1 39 00 00       	call   80107670 <deallocuvm>
80103c7f:	83 c4 10             	add    $0x10,%esp
80103c82:	85 c0                	test   %eax,%eax
80103c84:	75 af                	jne    80103c35 <growproc+0x25>
80103c86:	eb de                	jmp    80103c66 <growproc+0x56>
80103c88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c8f:	00 

80103c90 <fork>:
{
80103c90:	55                   	push   %ebp
80103c91:	89 e5                	mov    %esp,%ebp
80103c93:	57                   	push   %edi
80103c94:	56                   	push   %esi
80103c95:	53                   	push   %ebx
80103c96:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103c99:	e8 e2 0d 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80103c9e:	e8 9d fc ff ff       	call   80103940 <mycpu>
  p = c->proc;
80103ca3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ca9:	e8 22 0e 00 00       	call   80104ad0 <popcli>
  if((np = allocproc()) == 0){
80103cae:	e8 3d fd ff ff       	call   801039f0 <allocproc>
80103cb3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103cb6:	85 c0                	test   %eax,%eax
80103cb8:	0f 84 f2 00 00 00    	je     80103db0 <fork+0x120>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103cbe:	83 ec 08             	sub    $0x8,%esp
80103cc1:	ff 33                	push   (%ebx)
80103cc3:	89 c7                	mov    %eax,%edi
80103cc5:	ff 73 04             	push   0x4(%ebx)
80103cc8:	e8 43 3b 00 00       	call   80107810 <copyuvm>
80103ccd:	83 c4 10             	add    $0x10,%esp
80103cd0:	89 47 04             	mov    %eax,0x4(%edi)
80103cd3:	85 c0                	test   %eax,%eax
80103cd5:	0f 84 b6 00 00 00    	je     80103d91 <fork+0x101>
  np->sz = curproc->sz;
80103cdb:	8b 03                	mov    (%ebx),%eax
80103cdd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ce0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103ce2:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103ce5:	89 c8                	mov    %ecx,%eax
80103ce7:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103cea:	b9 13 00 00 00       	mov    $0x13,%ecx
80103cef:	8b 73 18             	mov    0x18(%ebx),%esi
80103cf2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103cf4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103cf6:	8b 40 18             	mov    0x18(%eax),%eax
80103cf9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103d00:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103d04:	85 c0                	test   %eax,%eax
80103d06:	74 13                	je     80103d1b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d08:	83 ec 0c             	sub    $0xc,%esp
80103d0b:	50                   	push   %eax
80103d0c:	e8 ff d1 ff ff       	call   80100f10 <filedup>
80103d11:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103d14:	83 c4 10             	add    $0x10,%esp
80103d17:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103d1b:	83 c6 01             	add    $0x1,%esi
80103d1e:	83 fe 10             	cmp    $0x10,%esi
80103d21:	75 dd                	jne    80103d00 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103d23:	83 ec 0c             	sub    $0xc,%esp
80103d26:	ff 73 68             	push   0x68(%ebx)
80103d29:	e8 92 da ff ff       	call   801017c0 <idup>
80103d2e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d31:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103d34:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d37:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103d3a:	6a 10                	push   $0x10
80103d3c:	50                   	push   %eax
80103d3d:	8d 47 6c             	lea    0x6c(%edi),%eax
80103d40:	50                   	push   %eax
80103d41:	e8 ba 12 00 00       	call   80105000 <safestrcpy>
  np->tickets = (curproc->tickets > 0 ? curproc->tickets : 1);
80103d46:	8b 83 90 00 00 00    	mov    0x90(%ebx),%eax
80103d4c:	ba 01 00 00 00       	mov    $0x1,%edx
  pid = np->pid;
80103d51:	8b 5f 10             	mov    0x10(%edi),%ebx
  np->tickets = (curproc->tickets > 0 ? curproc->tickets : 1);
80103d54:	85 c0                	test   %eax,%eax
80103d56:	0f 4e c2             	cmovle %edx,%eax
80103d59:	89 87 90 00 00 00    	mov    %eax,0x90(%edi)
  np->original_tickets = np->tickets;
80103d5f:	89 87 94 00 00 00    	mov    %eax,0x94(%edi)
  acquire(&ptable.lock);
80103d65:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
80103d6c:	e8 2f 0e 00 00       	call   80104ba0 <acquire>
  np->state = RUNNABLE;
80103d71:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103d78:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
80103d7f:	e8 9c 0f 00 00       	call   80104d20 <release>
  return pid;
80103d84:	83 c4 10             	add    $0x10,%esp
}
80103d87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d8a:	89 d8                	mov    %ebx,%eax
80103d8c:	5b                   	pop    %ebx
80103d8d:	5e                   	pop    %esi
80103d8e:	5f                   	pop    %edi
80103d8f:	5d                   	pop    %ebp
80103d90:	c3                   	ret
    kfree(np->kstack);
80103d91:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103d94:	83 ec 0c             	sub    $0xc,%esp
80103d97:	ff 73 08             	push   0x8(%ebx)
80103d9a:	e8 a1 e7 ff ff       	call   80102540 <kfree>
    np->kstack = 0;
80103d9f:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103da6:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103da9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103db0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103db5:	eb d0                	jmp    80103d87 <fork+0xf7>
80103db7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103dbe:	00 
80103dbf:	90                   	nop

80103dc0 <scheduler>:
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
80103dc5:	53                   	push   %ebx
80103dc6:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103dc9:	e8 72 fb ff ff       	call   80103940 <mycpu>
  c->proc = 0;
80103dce:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103dd5:	00 00 00 
  struct cpu *c = mycpu();
80103dd8:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103dda:	8d 78 04             	lea    0x4(%eax),%edi
80103ddd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103de0:	fb                   	sti
    acquire(&ptable.lock);
80103de1:	83 ec 0c             	sub    $0xc,%esp
80103de4:	68 e0 2e 11 80       	push   $0x80112ee0
80103de9:	e8 b2 0d 00 00       	call   80104ba0 <acquire>
    if(scheduling_policy == 1){
80103dee:	a1 c0 2e 11 80       	mov    0x80112ec0,%eax
80103df3:	83 c4 10             	add    $0x10,%esp
80103df6:	83 f8 01             	cmp    $0x1,%eax
80103df9:	74 75                	je     80103e70 <scheduler+0xb0>
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dfb:	be 14 2f 11 80       	mov    $0x80112f14,%esi
    } else if(scheduling_policy == 2){
80103e00:	83 f8 02             	cmp    $0x2,%eax
80103e03:	0f 84 1e 01 00 00    	je     80103f27 <scheduler+0x167>
80103e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if(p->state != RUNNABLE) continue;
80103e10:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
80103e14:	75 33                	jne    80103e49 <scheduler+0x89>
        switchuvm(p);
80103e16:	83 ec 0c             	sub    $0xc,%esp
        c->proc = p;
80103e19:	89 b3 ac 00 00 00    	mov    %esi,0xac(%ebx)
        switchuvm(p);
80103e1f:	56                   	push   %esi
80103e20:	e8 cb 34 00 00       	call   801072f0 <switchuvm>
        p->state = RUNNING;
80103e25:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
        swtch(&(c->scheduler), p->context);
80103e2c:	58                   	pop    %eax
80103e2d:	5a                   	pop    %edx
80103e2e:	ff 76 1c             	push   0x1c(%esi)
80103e31:	57                   	push   %edi
80103e32:	e8 24 12 00 00       	call   8010505b <swtch>
        switchkvm();
80103e37:	e8 a4 34 00 00       	call   801072e0 <switchkvm>
        c->proc = 0;
80103e3c:	83 c4 10             	add    $0x10,%esp
80103e3f:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103e46:	00 00 00 
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e49:	81 c6 98 00 00 00    	add    $0x98,%esi
80103e4f:	81 fe 14 55 11 80    	cmp    $0x80115514,%esi
80103e55:	75 b9                	jne    80103e10 <scheduler+0x50>
    release(&ptable.lock);
80103e57:	83 ec 0c             	sub    $0xc,%esp
80103e5a:	68 e0 2e 11 80       	push   $0x80112ee0
80103e5f:	e8 bc 0e 00 00       	call   80104d20 <release>
    sti();
80103e64:	83 c4 10             	add    $0x10,%esp
80103e67:	e9 74 ff ff ff       	jmp    80103de0 <scheduler+0x20>
80103e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      struct proc *best = 0;
80103e70:	31 f6                	xor    %esi,%esi
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e72:	b8 14 2f 11 80       	mov    $0x80112f14,%eax
80103e77:	eb 15                	jmp    80103e8e <scheduler+0xce>
80103e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e80:	89 d0                	mov    %edx,%eax
80103e82:	05 98 00 00 00       	add    $0x98,%eax
80103e87:	3d 14 55 11 80       	cmp    $0x80115514,%eax
80103e8c:	74 42                	je     80103ed0 <scheduler+0x110>
        if(p->state != RUNNABLE) continue;
80103e8e:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103e92:	75 ee                	jne    80103e82 <scheduler+0xc2>
        if(best == 0 || p->ctime < best->ctime)
80103e94:	85 f6                	test   %esi,%esi
80103e96:	0f 84 84 00 00 00    	je     80103f20 <scheduler+0x160>
80103e9c:	8b 56 7c             	mov    0x7c(%esi),%edx
80103e9f:	39 50 7c             	cmp    %edx,0x7c(%eax)
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ea2:	8d 90 98 00 00 00    	lea    0x98(%eax),%edx
        if(best == 0 || p->ctime < best->ctime)
80103ea8:	73 1f                	jae    80103ec9 <scheduler+0x109>
          best = p;
80103eaa:	89 c6                	mov    %eax,%esi
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eac:	3d 7c 54 11 80       	cmp    $0x8011547c,%eax
80103eb1:	74 21                	je     80103ed4 <scheduler+0x114>
        if(p->state != RUNNABLE) continue;
80103eb3:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80103eb7:	75 c7                	jne    80103e80 <scheduler+0xc0>
          best = p;
80103eb9:	89 d0                	mov    %edx,%eax
        if(best == 0 || p->ctime < best->ctime)
80103ebb:	8b 56 7c             	mov    0x7c(%esi),%edx
80103ebe:	39 50 7c             	cmp    %edx,0x7c(%eax)
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ec1:	8d 90 98 00 00 00    	lea    0x98(%eax),%edx
        if(best == 0 || p->ctime < best->ctime)
80103ec7:	72 e1                	jb     80103eaa <scheduler+0xea>
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ec9:	3d 7c 54 11 80       	cmp    $0x8011547c,%eax
80103ece:	75 e3                	jne    80103eb3 <scheduler+0xf3>
      if(best){
80103ed0:	85 f6                	test   %esi,%esi
80103ed2:	74 83                	je     80103e57 <scheduler+0x97>
            switchuvm(p);
80103ed4:	83 ec 0c             	sub    $0xc,%esp
            c->proc = p;
80103ed7:	89 b3 ac 00 00 00    	mov    %esi,0xac(%ebx)
            switchuvm(p);
80103edd:	56                   	push   %esi
80103ede:	e8 0d 34 00 00       	call   801072f0 <switchuvm>
            p->state = RUNNING;
80103ee3:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
            swtch(&(c->scheduler), p->context);
80103eea:	59                   	pop    %ecx
80103eeb:	58                   	pop    %eax
80103eec:	ff 76 1c             	push   0x1c(%esi)
80103eef:	57                   	push   %edi
80103ef0:	e8 66 11 00 00       	call   8010505b <swtch>
            switchkvm();
80103ef5:	e8 e6 33 00 00       	call   801072e0 <switchkvm>
            break;
80103efa:	83 c4 10             	add    $0x10,%esp
            c->proc = 0;
80103efd:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103f04:	00 00 00 
    release(&ptable.lock);
80103f07:	83 ec 0c             	sub    $0xc,%esp
80103f0a:	68 e0 2e 11 80       	push   $0x80112ee0
80103f0f:	e8 0c 0e 00 00       	call   80104d20 <release>
    sti();
80103f14:	83 c4 10             	add    $0x10,%esp
80103f17:	e9 c4 fe ff ff       	jmp    80103de0 <scheduler+0x20>
80103f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          best = p;
80103f20:	89 c6                	mov    %eax,%esi
80103f22:	e9 5b ff ff ff       	jmp    80103e82 <scheduler+0xc2>
      int totaltix = 0;
80103f27:	31 c9                	xor    %ecx,%ecx
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f29:	89 f0                	mov    %esi,%eax
80103f2b:	89 ca                	mov    %ecx,%edx
80103f2d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f34:	00 
80103f35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f3c:	00 
80103f3d:	8d 76 00             	lea    0x0(%esi),%esi
        if(p->state == RUNNABLE){
80103f40:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103f44:	75 23                	jne    80103f69 <scheduler+0x1a9>
          int t = (p->tickets > 0 ? p->tickets : 1);
80103f46:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
80103f4c:	be 01 00 00 00       	mov    $0x1,%esi
80103f51:	85 c9                	test   %ecx,%ecx
80103f53:	0f 4e ce             	cmovle %esi,%ecx
          if(totaltix <= 0x7fffffff - t)
80103f56:	be ff ff ff 7f       	mov    $0x7fffffff,%esi
80103f5b:	29 ce                	sub    %ecx,%esi
            totaltix += t;
80103f5d:	01 d1                	add    %edx,%ecx
80103f5f:	39 f2                	cmp    %esi,%edx
80103f61:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
80103f66:	0f 4e d1             	cmovle %ecx,%edx
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f69:	05 98 00 00 00       	add    $0x98,%eax
80103f6e:	3d 14 55 11 80       	cmp    $0x80115514,%eax
80103f73:	75 cb                	jne    80103f40 <scheduler+0x180>
      if(totaltix > 0){
80103f75:	89 d1                	mov    %edx,%ecx
80103f77:	85 d2                	test   %edx,%edx
80103f79:	0f 8e d8 fe ff ff    	jle    80103e57 <scheduler+0x97>
  rand_seed = rand_seed * 1664525UL + 1013904223UL;
80103f7f:	69 05 04 b0 10 80 0d 	imul   $0x19660d,0x8010b004,%eax
80103f86:	66 19 00 
        unsigned int r = krand() % (unsigned int)totaltix;
80103f89:	31 d2                	xor    %edx,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f8b:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80103f8e:	be 14 2f 11 80       	mov    $0x80112f14,%esi
  rand_seed = rand_seed * 1664525UL + 1013904223UL;
80103f93:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
80103f98:	a3 04 b0 10 80       	mov    %eax,0x8010b004
        unsigned int r = krand() % (unsigned int)totaltix;
80103f9d:	f7 f1                	div    %ecx
80103f9f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        int acc = 0;
80103fa2:	31 d2                	xor    %edx,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fa4:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103fa7:	eb 25                	jmp    80103fce <scheduler+0x20e>
80103fa9:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fb0:	00 
80103fb1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fb8:	00 
80103fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fc0:	81 c6 98 00 00 00    	add    $0x98,%esi
80103fc6:	81 fe 14 55 11 80    	cmp    $0x80115514,%esi
80103fcc:	74 24                	je     80103ff2 <scheduler+0x232>
          if(p->state != RUNNABLE) continue;
80103fce:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
80103fd2:	75 ec                	jne    80103fc0 <scheduler+0x200>
          int t = (p->tickets > 0 ? p->tickets : 1);
80103fd4:	8b 86 90 00 00 00    	mov    0x90(%esi),%eax
80103fda:	b9 01 00 00 00       	mov    $0x1,%ecx
80103fdf:	85 c0                	test   %eax,%eax
80103fe1:	0f 4e c1             	cmovle %ecx,%eax
          acc += t;
80103fe4:	01 c2                	add    %eax,%edx
          if(acc > (int)r){
80103fe6:	39 d3                	cmp    %edx,%ebx
80103fe8:	7d d6                	jge    80103fc0 <scheduler+0x200>
            c->proc = p;
80103fea:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80103fed:	e9 e2 fe ff ff       	jmp    80103ed4 <scheduler+0x114>
    release(&ptable.lock);
80103ff2:	83 ec 0c             	sub    $0xc,%esp
80103ff5:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80103ff8:	68 e0 2e 11 80       	push   $0x80112ee0
80103ffd:	e8 1e 0d 00 00       	call   80104d20 <release>
    sti();
80104002:	83 c4 10             	add    $0x10,%esp
80104005:	e9 d6 fd ff ff       	jmp    80103de0 <scheduler+0x20>
8010400a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104010 <sched>:
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	56                   	push   %esi
80104014:	53                   	push   %ebx
  pushcli();
80104015:	e8 66 0a 00 00       	call   80104a80 <pushcli>
  c = mycpu();
8010401a:	e8 21 f9 ff ff       	call   80103940 <mycpu>
  p = c->proc;
8010401f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104025:	e8 a6 0a 00 00       	call   80104ad0 <popcli>
  if(!holding(&ptable.lock))
8010402a:	83 ec 0c             	sub    $0xc,%esp
8010402d:	68 e0 2e 11 80       	push   $0x80112ee0
80104032:	e8 e9 0a 00 00       	call   80104b20 <holding>
80104037:	83 c4 10             	add    $0x10,%esp
8010403a:	85 c0                	test   %eax,%eax
8010403c:	74 4f                	je     8010408d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010403e:	e8 fd f8 ff ff       	call   80103940 <mycpu>
80104043:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010404a:	75 68                	jne    801040b4 <sched+0xa4>
  if(p->state == RUNNING)
8010404c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104050:	74 55                	je     801040a7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104052:	9c                   	pushf
80104053:	58                   	pop    %eax
  if(readeflags() & FL_IF)
80104054:	f6 c4 02             	test   $0x2,%ah
80104057:	75 41                	jne    8010409a <sched+0x8a>
  intena = mycpu()->intena;
80104059:	e8 e2 f8 ff ff       	call   80103940 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010405e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104061:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104067:	e8 d4 f8 ff ff       	call   80103940 <mycpu>
8010406c:	83 ec 08             	sub    $0x8,%esp
8010406f:	ff 70 04             	push   0x4(%eax)
80104072:	53                   	push   %ebx
80104073:	e8 e3 0f 00 00       	call   8010505b <swtch>
  mycpu()->intena = intena;
80104078:	e8 c3 f8 ff ff       	call   80103940 <mycpu>
}
8010407d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104080:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104086:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104089:	5b                   	pop    %ebx
8010408a:	5e                   	pop    %esi
8010408b:	5d                   	pop    %ebp
8010408c:	c3                   	ret
    panic("sched ptable.lock");
8010408d:	83 ec 0c             	sub    $0xc,%esp
80104090:	68 f1 7c 10 80       	push   $0x80107cf1
80104095:	e8 06 c3 ff ff       	call   801003a0 <panic>
    panic("sched interruptible");
8010409a:	83 ec 0c             	sub    $0xc,%esp
8010409d:	68 1d 7d 10 80       	push   $0x80107d1d
801040a2:	e8 f9 c2 ff ff       	call   801003a0 <panic>
    panic("sched running");
801040a7:	83 ec 0c             	sub    $0xc,%esp
801040aa:	68 0f 7d 10 80       	push   $0x80107d0f
801040af:	e8 ec c2 ff ff       	call   801003a0 <panic>
    panic("sched locks");
801040b4:	83 ec 0c             	sub    $0xc,%esp
801040b7:	68 03 7d 10 80       	push   $0x80107d03
801040bc:	e8 df c2 ff ff       	call   801003a0 <panic>
801040c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040c8:	00 
801040c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801040d0 <exit>:
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	57                   	push   %edi
801040d4:	56                   	push   %esi
801040d5:	53                   	push   %ebx
801040d6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
801040d9:	e8 e2 f8 ff ff       	call   801039c0 <myproc>
  if(curproc == initproc)
801040de:	39 05 14 55 11 80    	cmp    %eax,0x80115514
801040e4:	0f 84 3a 01 00 00    	je     80104224 <exit+0x154>
801040ea:	89 c3                	mov    %eax,%ebx
801040ec:	8d 70 28             	lea    0x28(%eax),%esi
801040ef:	8d 78 68             	lea    0x68(%eax),%edi
801040f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040f9:	00 
801040fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104100:	8b 06                	mov    (%esi),%eax
80104102:	85 c0                	test   %eax,%eax
80104104:	74 12                	je     80104118 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104106:	83 ec 0c             	sub    $0xc,%esp
80104109:	50                   	push   %eax
8010410a:	e8 51 ce ff ff       	call   80100f60 <fileclose>
      curproc->ofile[fd] = 0;
8010410f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104115:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104118:	83 c6 04             	add    $0x4,%esi
8010411b:	39 f7                	cmp    %esi,%edi
8010411d:	75 e1                	jne    80104100 <exit+0x30>
  begin_op();
8010411f:	e8 1c ed ff ff       	call   80102e40 <begin_op>
  iput(curproc->cwd);
80104124:	83 ec 0c             	sub    $0xc,%esp
80104127:	ff 73 68             	push   0x68(%ebx)
8010412a:	e8 f1 d7 ff ff       	call   80101920 <iput>
  end_op();
8010412f:	e8 7c ed ff ff       	call   80102eb0 <end_op>
  curproc->cwd = 0;
80104134:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
8010413b:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
80104142:	e8 59 0a 00 00       	call   80104ba0 <acquire>
  wakeup1(curproc->parent);
80104147:	8b 53 14             	mov    0x14(%ebx),%edx
8010414a:	83 c4 10             	add    $0x10,%esp
// Wake up all processes sleeping on chan. The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010414d:	b8 14 2f 11 80       	mov    $0x80112f14,%eax
80104152:	eb 18                	jmp    8010416c <exit+0x9c>
80104154:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010415b:	00 
8010415c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104160:	05 98 00 00 00       	add    $0x98,%eax
80104165:	3d 14 55 11 80       	cmp    $0x80115514,%eax
8010416a:	74 1e                	je     8010418a <exit+0xba>
    if(p->state == SLEEPING && p->chan == chan)
8010416c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104170:	75 ee                	jne    80104160 <exit+0x90>
80104172:	3b 50 20             	cmp    0x20(%eax),%edx
80104175:	75 e9                	jne    80104160 <exit+0x90>
      p->state = RUNNABLE;
80104177:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010417e:	05 98 00 00 00       	add    $0x98,%eax
80104183:	3d 14 55 11 80       	cmp    $0x80115514,%eax
80104188:	75 e2                	jne    8010416c <exit+0x9c>
      p->parent = initproc;
8010418a:	8b 0d 14 55 11 80    	mov    0x80115514,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104190:	ba 14 2f 11 80       	mov    $0x80112f14,%edx
80104195:	eb 17                	jmp    801041ae <exit+0xde>
80104197:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010419e:	00 
8010419f:	90                   	nop
801041a0:	81 c2 98 00 00 00    	add    $0x98,%edx
801041a6:	81 fa 14 55 11 80    	cmp    $0x80115514,%edx
801041ac:	74 52                	je     80104200 <exit+0x130>
    if(p->parent == curproc){
801041ae:	39 5a 14             	cmp    %ebx,0x14(%edx)
801041b1:	75 ed                	jne    801041a0 <exit+0xd0>
      if(p->state == ZOMBIE)
801041b3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801041b7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801041ba:	75 e4                	jne    801041a0 <exit+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041bc:	b8 14 2f 11 80       	mov    $0x80112f14,%eax
801041c1:	eb 29                	jmp    801041ec <exit+0x11c>
801041c3:	eb 1b                	jmp    801041e0 <exit+0x110>
801041c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041cc:	00 
801041cd:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041d4:	00 
801041d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041dc:	00 
801041dd:	8d 76 00             	lea    0x0(%esi),%esi
801041e0:	05 98 00 00 00       	add    $0x98,%eax
801041e5:	3d 14 55 11 80       	cmp    $0x80115514,%eax
801041ea:	74 b4                	je     801041a0 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
801041ec:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041f0:	75 ee                	jne    801041e0 <exit+0x110>
801041f2:	3b 48 20             	cmp    0x20(%eax),%ecx
801041f5:	75 e9                	jne    801041e0 <exit+0x110>
      p->state = RUNNABLE;
801041f7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801041fe:	eb e0                	jmp    801041e0 <exit+0x110>
  curproc->etime = ticks;
80104200:	a1 20 55 11 80       	mov    0x80115520,%eax
  curproc->state = ZOMBIE;
80104205:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  curproc->etime = ticks;
8010420c:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  sched();
80104212:	e8 f9 fd ff ff       	call   80104010 <sched>
  panic("zombie exit");
80104217:	83 ec 0c             	sub    $0xc,%esp
8010421a:	68 3e 7d 10 80       	push   $0x80107d3e
8010421f:	e8 7c c1 ff ff       	call   801003a0 <panic>
    panic("init exiting");
80104224:	83 ec 0c             	sub    $0xc,%esp
80104227:	68 31 7d 10 80       	push   $0x80107d31
8010422c:	e8 6f c1 ff ff       	call   801003a0 <panic>
80104231:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104238:	00 
80104239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104240 <wait>:
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	56                   	push   %esi
80104244:	53                   	push   %ebx
  pushcli();
80104245:	e8 36 08 00 00       	call   80104a80 <pushcli>
  c = mycpu();
8010424a:	e8 f1 f6 ff ff       	call   80103940 <mycpu>
  p = c->proc;
8010424f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104255:	e8 76 08 00 00       	call   80104ad0 <popcli>
  acquire(&ptable.lock);
8010425a:	83 ec 0c             	sub    $0xc,%esp
8010425d:	68 e0 2e 11 80       	push   $0x80112ee0
80104262:	e8 39 09 00 00       	call   80104ba0 <acquire>
80104267:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010426a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010426c:	bb 14 2f 11 80       	mov    $0x80112f14,%ebx
80104271:	eb 1b                	jmp    8010428e <wait+0x4e>
80104273:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010427a:	00 
8010427b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104280:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104286:	81 fb 14 55 11 80    	cmp    $0x80115514,%ebx
8010428c:	74 1e                	je     801042ac <wait+0x6c>
      if(p->parent != curproc)
8010428e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104291:	75 ed                	jne    80104280 <wait+0x40>
      if(p->state == ZOMBIE){
80104293:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104297:	74 67                	je     80104300 <wait+0xc0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104299:	81 c3 98 00 00 00    	add    $0x98,%ebx
      havekids = 1;
8010429f:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042a4:	81 fb 14 55 11 80    	cmp    $0x80115514,%ebx
801042aa:	75 e2                	jne    8010428e <wait+0x4e>
    if(!havekids || curproc->killed){
801042ac:	85 c0                	test   %eax,%eax
801042ae:	0f 84 a2 00 00 00    	je     80104356 <wait+0x116>
801042b4:	8b 46 24             	mov    0x24(%esi),%eax
801042b7:	85 c0                	test   %eax,%eax
801042b9:	0f 85 97 00 00 00    	jne    80104356 <wait+0x116>
  pushcli();
801042bf:	e8 bc 07 00 00       	call   80104a80 <pushcli>
  c = mycpu();
801042c4:	e8 77 f6 ff ff       	call   80103940 <mycpu>
  p = c->proc;
801042c9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042cf:	e8 fc 07 00 00       	call   80104ad0 <popcli>
  if(p == 0)
801042d4:	85 db                	test   %ebx,%ebx
801042d6:	0f 84 91 00 00 00    	je     8010436d <wait+0x12d>
  p->chan = chan;
801042dc:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
801042df:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801042e6:	e8 25 fd ff ff       	call   80104010 <sched>
  p->chan = 0;
801042eb:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801042f2:	e9 73 ff ff ff       	jmp    8010426a <wait+0x2a>
801042f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801042fe:	00 
801042ff:	90                   	nop
        kfree(p->kstack);
80104300:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104303:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104306:	ff 73 08             	push   0x8(%ebx)
80104309:	e8 32 e2 ff ff       	call   80102540 <kfree>
        p->kstack = 0;
8010430e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104315:	5a                   	pop    %edx
80104316:	ff 73 04             	push   0x4(%ebx)
80104319:	e8 82 33 00 00       	call   801076a0 <freevm>
        p->pid = 0;
8010431e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104325:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010432c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104330:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104337:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010433e:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
80104345:	e8 d6 09 00 00       	call   80104d20 <release>
        return pid;
8010434a:	83 c4 10             	add    $0x10,%esp
}
8010434d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104350:	89 f0                	mov    %esi,%eax
80104352:	5b                   	pop    %ebx
80104353:	5e                   	pop    %esi
80104354:	5d                   	pop    %ebp
80104355:	c3                   	ret
      release(&ptable.lock);
80104356:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104359:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010435e:	68 e0 2e 11 80       	push   $0x80112ee0
80104363:	e8 b8 09 00 00       	call   80104d20 <release>
      return -1;
80104368:	83 c4 10             	add    $0x10,%esp
8010436b:	eb e0                	jmp    8010434d <wait+0x10d>
    panic("sleep");
8010436d:	83 ec 0c             	sub    $0xc,%esp
80104370:	68 4a 7d 10 80       	push   $0x80107d4a
80104375:	e8 26 c0 ff ff       	call   801003a0 <panic>
8010437a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104380 <waitx>:
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	57                   	push   %edi
80104384:	56                   	push   %esi
80104385:	53                   	push   %ebx
80104386:	83 ec 0c             	sub    $0xc,%esp
80104389:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010438c:	e8 ef 06 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80104391:	e8 aa f5 ff ff       	call   80103940 <mycpu>
  p = c->proc;
80104396:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
8010439c:	e8 2f 07 00 00       	call   80104ad0 <popcli>
  if(wtime == 0 || rtime == 0)
801043a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
801043a4:	85 c9                	test   %ecx,%ecx
801043a6:	0f 84 3b 01 00 00    	je     801044e7 <waitx+0x167>
801043ac:	85 f6                	test   %esi,%esi
801043ae:	0f 84 33 01 00 00    	je     801044e7 <waitx+0x167>
  acquire(&ptable.lock);
801043b4:	83 ec 0c             	sub    $0xc,%esp
801043b7:	68 e0 2e 11 80       	push   $0x80112ee0
801043bc:	e8 df 07 00 00       	call   80104ba0 <acquire>
801043c1:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801043c4:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043c6:	bb 14 2f 11 80       	mov    $0x80112f14,%ebx
801043cb:	eb 21                	jmp    801043ee <waitx+0x6e>
801043cd:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043d4:	00 
801043d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043dc:	00 
801043dd:	8d 76 00             	lea    0x0(%esi),%esi
801043e0:	81 c3 98 00 00 00    	add    $0x98,%ebx
801043e6:	81 fb 14 55 11 80    	cmp    $0x80115514,%ebx
801043ec:	74 1e                	je     8010440c <waitx+0x8c>
      if(p->parent != curproc)
801043ee:	39 7b 14             	cmp    %edi,0x14(%ebx)
801043f1:	75 ed                	jne    801043e0 <waitx+0x60>
      if(p->state == ZOMBIE){
801043f3:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801043f7:	74 67                	je     80104460 <waitx+0xe0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043f9:	81 c3 98 00 00 00    	add    $0x98,%ebx
      havekids = 1;
801043ff:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104404:	81 fb 14 55 11 80    	cmp    $0x80115514,%ebx
8010440a:	75 e2                	jne    801043ee <waitx+0x6e>
    if(!havekids || curproc->killed){
8010440c:	85 c0                	test   %eax,%eax
8010440e:	0f 84 c3 00 00 00    	je     801044d7 <waitx+0x157>
80104414:	8b 47 24             	mov    0x24(%edi),%eax
80104417:	85 c0                	test   %eax,%eax
80104419:	0f 85 b8 00 00 00    	jne    801044d7 <waitx+0x157>
  pushcli();
8010441f:	e8 5c 06 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80104424:	e8 17 f5 ff ff       	call   80103940 <mycpu>
  p = c->proc;
80104429:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010442f:	e8 9c 06 00 00       	call   80104ad0 <popcli>
  if(p == 0)
80104434:	85 db                	test   %ebx,%ebx
80104436:	0f 84 b2 00 00 00    	je     801044ee <waitx+0x16e>
  p->chan = chan;
8010443c:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010443f:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104446:	e8 c5 fb ff ff       	call   80104010 <sched>
  p->chan = 0;
8010444b:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104452:	e9 6d ff ff ff       	jmp    801043c4 <waitx+0x44>
80104457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010445e:	00 
8010445f:	90                   	nop
        int rt = (int)p->rtime;
80104460:	8b 93 84 00 00 00    	mov    0x84(%ebx),%edx
        int wt = (int)p->etime - (int)p->ctime - rt;
80104466:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
        if(wt < 0) wt = 0; // گارد
8010446c:	b9 00 00 00 00       	mov    $0x0,%ecx
        int wt = (int)p->etime - (int)p->ctime - rt;
80104471:	2b 43 7c             	sub    0x7c(%ebx),%eax
        pid = p->pid;
80104474:	8b 7b 10             	mov    0x10(%ebx),%edi
        int wt = (int)p->etime - (int)p->ctime - rt;
80104477:	29 d0                	sub    %edx,%eax
        *rtime = rt;
80104479:	89 16                	mov    %edx,(%esi)
        if(wt < 0) wt = 0; // گارد
8010447b:	0f 48 c1             	cmovs  %ecx,%eax
        *wtime = wt;
8010447e:	8b 4d 08             	mov    0x8(%ebp),%ecx
        kfree(p->kstack);
80104481:	83 ec 0c             	sub    $0xc,%esp
        *wtime = wt;
80104484:	89 01                	mov    %eax,(%ecx)
        kfree(p->kstack);
80104486:	ff 73 08             	push   0x8(%ebx)
80104489:	e8 b2 e0 ff ff       	call   80102540 <kfree>
        p->kstack = 0;
8010448e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104495:	5a                   	pop    %edx
80104496:	ff 73 04             	push   0x4(%ebx)
80104499:	e8 02 32 00 00       	call   801076a0 <freevm>
        p->pid = 0;
8010449e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801044a5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801044ac:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801044b0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801044b7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801044be:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
801044c5:	e8 56 08 00 00       	call   80104d20 <release>
        return pid;
801044ca:	83 c4 10             	add    $0x10,%esp
}
801044cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044d0:	89 f8                	mov    %edi,%eax
801044d2:	5b                   	pop    %ebx
801044d3:	5e                   	pop    %esi
801044d4:	5f                   	pop    %edi
801044d5:	5d                   	pop    %ebp
801044d6:	c3                   	ret
      release(&ptable.lock);
801044d7:	83 ec 0c             	sub    $0xc,%esp
801044da:	68 e0 2e 11 80       	push   $0x80112ee0
801044df:	e8 3c 08 00 00       	call   80104d20 <release>
      return -1;
801044e4:	83 c4 10             	add    $0x10,%esp
    return -1;
801044e7:	bf ff ff ff ff       	mov    $0xffffffff,%edi
801044ec:	eb df                	jmp    801044cd <waitx+0x14d>
    panic("sleep");
801044ee:	83 ec 0c             	sub    $0xc,%esp
801044f1:	68 4a 7d 10 80       	push   $0x80107d4a
801044f6:	e8 a5 be ff ff       	call   801003a0 <panic>
801044fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104500 <yield>:
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	53                   	push   %ebx
80104504:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  // نگه داشتن قفل طبق قرارداد
80104507:	68 e0 2e 11 80       	push   $0x80112ee0
8010450c:	e8 8f 06 00 00       	call   80104ba0 <acquire>
  pushcli();
80104511:	e8 6a 05 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80104516:	e8 25 f4 ff ff       	call   80103940 <mycpu>
  p = c->proc;
8010451b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104521:	e8 aa 05 00 00       	call   80104ad0 <popcli>
  myproc()->state = RUNNABLE;
80104526:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010452d:	e8 de fa ff ff       	call   80104010 <sched>
  release(&ptable.lock);
80104532:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
80104539:	e8 e2 07 00 00       	call   80104d20 <release>
}
8010453e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104541:	83 c4 10             	add    $0x10,%esp
80104544:	c9                   	leave
80104545:	c3                   	ret
80104546:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010454d:	00 
8010454e:	66 90                	xchg   %ax,%ax

80104550 <sleep>:
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	57                   	push   %edi
80104554:	56                   	push   %esi
80104555:	53                   	push   %ebx
80104556:	83 ec 0c             	sub    $0xc,%esp
80104559:	8b 7d 08             	mov    0x8(%ebp),%edi
8010455c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010455f:	e8 1c 05 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80104564:	e8 d7 f3 ff ff       	call   80103940 <mycpu>
  p = c->proc;
80104569:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010456f:	e8 5c 05 00 00       	call   80104ad0 <popcli>
  if(p == 0)
80104574:	85 db                	test   %ebx,%ebx
80104576:	0f 84 87 00 00 00    	je     80104603 <sleep+0xb3>
  if(lk == 0)
8010457c:	85 f6                	test   %esi,%esi
8010457e:	74 76                	je     801045f6 <sleep+0xa6>
  if(lk != &ptable.lock){
80104580:	81 fe e0 2e 11 80    	cmp    $0x80112ee0,%esi
80104586:	74 50                	je     801045d8 <sleep+0x88>
    acquire(&ptable.lock);
80104588:	83 ec 0c             	sub    $0xc,%esp
8010458b:	68 e0 2e 11 80       	push   $0x80112ee0
80104590:	e8 0b 06 00 00       	call   80104ba0 <acquire>
    release(lk);
80104595:	89 34 24             	mov    %esi,(%esp)
80104598:	e8 83 07 00 00       	call   80104d20 <release>
  p->chan = chan;
8010459d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801045a0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801045a7:	e8 64 fa ff ff       	call   80104010 <sched>
  p->chan = 0;
801045ac:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801045b3:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
801045ba:	e8 61 07 00 00       	call   80104d20 <release>
    acquire(lk);
801045bf:	83 c4 10             	add    $0x10,%esp
801045c2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801045c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045c8:	5b                   	pop    %ebx
801045c9:	5e                   	pop    %esi
801045ca:	5f                   	pop    %edi
801045cb:	5d                   	pop    %ebp
    acquire(lk);
801045cc:	e9 cf 05 00 00       	jmp    80104ba0 <acquire>
801045d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801045d8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801045db:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801045e2:	e8 29 fa ff ff       	call   80104010 <sched>
  p->chan = 0;
801045e7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801045ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045f1:	5b                   	pop    %ebx
801045f2:	5e                   	pop    %esi
801045f3:	5f                   	pop    %edi
801045f4:	5d                   	pop    %ebp
801045f5:	c3                   	ret
    panic("sleep without lk");
801045f6:	83 ec 0c             	sub    $0xc,%esp
801045f9:	68 50 7d 10 80       	push   $0x80107d50
801045fe:	e8 9d bd ff ff       	call   801003a0 <panic>
    panic("sleep");
80104603:	83 ec 0c             	sub    $0xc,%esp
80104606:	68 4a 7d 10 80       	push   $0x80107d4a
8010460b:	e8 90 bd ff ff       	call   801003a0 <panic>

80104610 <wakeup>:
}

void
wakeup(void *chan)
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	53                   	push   %ebx
80104614:	83 ec 10             	sub    $0x10,%esp
80104617:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010461a:	68 e0 2e 11 80       	push   $0x80112ee0
8010461f:	e8 7c 05 00 00       	call   80104ba0 <acquire>
80104624:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104627:	b8 14 2f 11 80       	mov    $0x80112f14,%eax
8010462c:	eb 1e                	jmp    8010464c <wakeup+0x3c>
8010462e:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104635:	00 
80104636:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010463d:	00 
8010463e:	66 90                	xchg   %ax,%ax
80104640:	05 98 00 00 00       	add    $0x98,%eax
80104645:	3d 14 55 11 80       	cmp    $0x80115514,%eax
8010464a:	74 1e                	je     8010466a <wakeup+0x5a>
    if(p->state == SLEEPING && p->chan == chan)
8010464c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104650:	75 ee                	jne    80104640 <wakeup+0x30>
80104652:	3b 58 20             	cmp    0x20(%eax),%ebx
80104655:	75 e9                	jne    80104640 <wakeup+0x30>
      p->state = RUNNABLE;
80104657:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010465e:	05 98 00 00 00       	add    $0x98,%eax
80104663:	3d 14 55 11 80       	cmp    $0x80115514,%eax
80104668:	75 e2                	jne    8010464c <wakeup+0x3c>
  wakeup1(chan);
  release(&ptable.lock);
8010466a:	c7 45 08 e0 2e 11 80 	movl   $0x80112ee0,0x8(%ebp)
}
80104671:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104674:	c9                   	leave
  release(&ptable.lock);
80104675:	e9 a6 06 00 00       	jmp    80104d20 <release>
8010467a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104680 <kill>:

// Kill the process with the given pid.
int
kill(int pid)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	53                   	push   %ebx
80104684:	83 ec 10             	sub    $0x10,%esp
80104687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010468a:	68 e0 2e 11 80       	push   $0x80112ee0
8010468f:	e8 0c 05 00 00       	call   80104ba0 <acquire>
80104694:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104697:	b8 14 2f 11 80       	mov    $0x80112f14,%eax
8010469c:	eb 0e                	jmp    801046ac <kill+0x2c>
8010469e:	66 90                	xchg   %ax,%ax
801046a0:	05 98 00 00 00       	add    $0x98,%eax
801046a5:	3d 14 55 11 80       	cmp    $0x80115514,%eax
801046aa:	74 34                	je     801046e0 <kill+0x60>
    if(p->pid == pid){
801046ac:	39 58 10             	cmp    %ebx,0x10(%eax)
801046af:	75 ef                	jne    801046a0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801046b1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801046b5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801046bc:	75 07                	jne    801046c5 <kill+0x45>
        p->state = RUNNABLE;
801046be:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801046c5:	83 ec 0c             	sub    $0xc,%esp
801046c8:	68 e0 2e 11 80       	push   $0x80112ee0
801046cd:	e8 4e 06 00 00       	call   80104d20 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801046d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801046d5:	83 c4 10             	add    $0x10,%esp
801046d8:	31 c0                	xor    %eax,%eax
}
801046da:	c9                   	leave
801046db:	c3                   	ret
801046dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801046e0:	83 ec 0c             	sub    $0xc,%esp
801046e3:	68 e0 2e 11 80       	push   $0x80112ee0
801046e8:	e8 33 06 00 00       	call   80104d20 <release>
}
801046ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801046f0:	83 c4 10             	add    $0x10,%esp
801046f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801046f8:	c9                   	leave
801046f9:	c3                   	ret
801046fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104700 <procdump>:

// Debug dump
void
procdump(void)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	57                   	push   %edi
80104704:	56                   	push   %esi
    else
      state = "???";
    cprintf("%d %s %s (tix=%d run=%u sleep=%u ready=%u)\n",
            p->pid, state, p->name, p->tickets, p->rtime, p->stime, p->retime);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104705:	8d 75 c0             	lea    -0x40(%ebp),%esi
{
80104708:	53                   	push   %ebx
80104709:	bb 80 2f 11 80       	mov    $0x80112f80,%ebx
8010470e:	83 ec 3c             	sub    $0x3c,%esp
80104711:	eb 1f                	jmp    80104732 <procdump+0x32>
80104713:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010471a:	00 
8010471b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104720:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104726:	81 fb 80 55 11 80    	cmp    $0x80115580,%ebx
8010472c:	0f 84 a1 00 00 00    	je     801047d3 <procdump+0xd3>
    if(p->state == UNUSED)
80104732:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104735:	85 c0                	test   %eax,%eax
80104737:	74 e7                	je     80104720 <procdump+0x20>
      state = "???";
80104739:	ba 61 7d 10 80       	mov    $0x80107d61,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010473e:	83 f8 05             	cmp    $0x5,%eax
80104741:	77 11                	ja     80104754 <procdump+0x54>
80104743:	8b 14 85 40 83 10 80 	mov    -0x7fef7cc0(,%eax,4),%edx
      state = "???";
8010474a:	b8 61 7d 10 80       	mov    $0x80107d61,%eax
8010474f:	85 d2                	test   %edx,%edx
80104751:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s (tix=%d run=%u sleep=%u ready=%u)\n",
80104754:	ff 73 20             	push   0x20(%ebx)
80104757:	ff 73 1c             	push   0x1c(%ebx)
8010475a:	ff 73 18             	push   0x18(%ebx)
8010475d:	ff 73 24             	push   0x24(%ebx)
80104760:	53                   	push   %ebx
80104761:	52                   	push   %edx
80104762:	ff 73 a4             	push   -0x5c(%ebx)
80104765:	68 1c 80 10 80       	push   $0x8010801c
8010476a:	e8 61 bf ff ff       	call   801006d0 <cprintf>
    if(p->state == SLEEPING){
8010476f:	83 c4 20             	add    $0x20,%esp
80104772:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104776:	75 a8                	jne    80104720 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104778:	83 ec 08             	sub    $0x8,%esp
8010477b:	89 f7                	mov    %esi,%edi
8010477d:	56                   	push   %esi
8010477e:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104781:	8b 40 0c             	mov    0xc(%eax),%eax
80104784:	83 c0 08             	add    $0x8,%eax
80104787:	50                   	push   %eax
80104788:	e8 23 06 00 00       	call   80104db0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010478d:	83 c4 10             	add    $0x10,%esp
80104790:	8b 07                	mov    (%edi),%eax
80104792:	85 c0                	test   %eax,%eax
80104794:	74 1b                	je     801047b1 <procdump+0xb1>
        cprintf(" %p", pc[i]);
80104796:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104799:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010479c:	50                   	push   %eax
8010479d:	68 a1 7a 10 80       	push   $0x80107aa1
801047a2:	e8 29 bf ff ff       	call   801006d0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801047a7:	8d 45 e8             	lea    -0x18(%ebp),%eax
801047aa:	83 c4 10             	add    $0x10,%esp
801047ad:	39 c7                	cmp    %eax,%edi
801047af:	75 df                	jne    80104790 <procdump+0x90>
      cprintf("\n");
801047b1:	83 ec 0c             	sub    $0xc,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047b4:	81 c3 98 00 00 00    	add    $0x98,%ebx
      cprintf("\n");
801047ba:	68 06 7f 10 80       	push   $0x80107f06
801047bf:	e8 0c bf ff ff       	call   801006d0 <cprintf>
801047c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047c7:	81 fb 80 55 11 80    	cmp    $0x80115580,%ebx
801047cd:	0f 85 5f ff ff ff    	jne    80104732 <procdump+0x32>
    }
  }
}
801047d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047d6:	5b                   	pop    %ebx
801047d7:	5e                   	pop    %esi
801047d8:	5f                   	pop    %edi
801047d9:	5d                   	pop    %ebp
801047da:	c3                   	ret
801047db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801047e0 <setpolicy>:

/* ---- Project syscalls ---- */

int
setpolicy(int policy)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	8b 45 08             	mov    0x8(%ebp),%eax
  if(policy < 0 || policy > 2)
801047e6:	83 f8 02             	cmp    $0x2,%eax
801047e9:	77 0d                	ja     801047f8 <setpolicy+0x18>
    return -1;
  scheduling_policy = policy;
801047eb:	a3 c0 2e 11 80       	mov    %eax,0x80112ec0
  return 0;
}
801047f0:	5d                   	pop    %ebp
  return 0;
801047f1:	31 c0                	xor    %eax,%eax
}
801047f3:	c3                   	ret
801047f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801047f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047fd:	5d                   	pop    %ebp
801047fe:	c3                   	ret
801047ff:	90                   	nop

80104800 <settickets>:

int
settickets(int n)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	56                   	push   %esi
80104804:	53                   	push   %ebx
80104805:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(n < 1)
80104808:	85 db                	test   %ebx,%ebx
8010480a:	7e 44                	jle    80104850 <settickets+0x50>
    return -1;
  acquire(&ptable.lock);
8010480c:	83 ec 0c             	sub    $0xc,%esp
8010480f:	68 e0 2e 11 80       	push   $0x80112ee0
80104814:	e8 87 03 00 00       	call   80104ba0 <acquire>
  pushcli();
80104819:	e8 62 02 00 00       	call   80104a80 <pushcli>
  c = mycpu();
8010481e:	e8 1d f1 ff ff       	call   80103940 <mycpu>
  p = c->proc;
80104823:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104829:	e8 a2 02 00 00       	call   80104ad0 <popcli>
  struct proc *p = myproc();
  p->tickets = n;
8010482e:	89 9e 90 00 00 00    	mov    %ebx,0x90(%esi)
  // original_tickets را ثابت نگه می‌داریم تا «مقدار اولیه» باقی بماند
  release(&ptable.lock);
80104834:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
8010483b:	e8 e0 04 00 00       	call   80104d20 <release>
  return 0;
80104840:	83 c4 10             	add    $0x10,%esp
80104843:	31 c0                	xor    %eax,%eax
}
80104845:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104848:	5b                   	pop    %ebx
80104849:	5e                   	pop    %esi
8010484a:	5d                   	pop    %ebp
8010484b:	c3                   	ret
8010484c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104850:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104855:	eb ee                	jmp    80104845 <settickets+0x45>
80104857:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010485e:	00 
8010485f:	90                   	nop

80104860 <getpinfo>:

int
getpinfo(struct pstat *ps)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	53                   	push   %ebx
80104864:	83 ec 04             	sub    $0x4,%esp
80104867:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ps == 0)
8010486a:	85 db                	test   %ebx,%ebx
8010486c:	0f 84 9b 00 00 00    	je     8010490d <getpinfo+0xad>
    return -1;

  acquire(&ptable.lock);
80104872:	83 ec 0c             	sub    $0xc,%esp
80104875:	68 e0 2e 11 80       	push   $0x80112ee0
8010487a:	e8 21 03 00 00       	call   80104ba0 <acquire>
  for(int i = 0; i < NPROC; i++){
8010487f:	b8 20 2f 11 80       	mov    $0x80112f20,%eax
80104884:	89 da                	mov    %ebx,%edx
80104886:	83 c4 10             	add    $0x10,%esp
80104889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct proc *p = &ptable.proc[i];
    ps->inuse[i]            = (p->state != UNUSED);
80104890:	8b 18                	mov    (%eax),%ebx
80104892:	31 c9                	xor    %ecx,%ecx
80104894:	85 db                	test   %ebx,%ebx
80104896:	0f 95 c1             	setne  %cl
  for(int i = 0; i < NPROC; i++){
80104899:	05 98 00 00 00       	add    $0x98,%eax
8010489e:	83 c2 04             	add    $0x4,%edx
    ps->inuse[i]            = (p->state != UNUSED);
801048a1:	89 4a fc             	mov    %ecx,-0x4(%edx)
    ps->pid[i]              = p->pid;
801048a4:	8b 88 6c ff ff ff    	mov    -0x94(%eax),%ecx
801048aa:	89 8a fc 00 00 00    	mov    %ecx,0xfc(%edx)
    ps->tickets[i]          = p->tickets;
801048b0:	8b 48 ec             	mov    -0x14(%eax),%ecx
801048b3:	89 8a fc 02 00 00    	mov    %ecx,0x2fc(%edx)
    ps->original_tickets[i] = p->original_tickets;
801048b9:	8b 48 f0             	mov    -0x10(%eax),%ecx
801048bc:	89 8a fc 03 00 00    	mov    %ecx,0x3fc(%edx)
    ps->rtime[i]            = (int)p->rtime;
801048c2:	8b 48 e0             	mov    -0x20(%eax),%ecx
801048c5:	89 8a fc 04 00 00    	mov    %ecx,0x4fc(%edx)
    ps->stime[i]            = (int)p->stime;
801048cb:	8b 48 e4             	mov    -0x1c(%eax),%ecx
801048ce:	89 8a fc 05 00 00    	mov    %ecx,0x5fc(%edx)
    ps->retime[i]           = (int)p->retime;
801048d4:	8b 48 e8             	mov    -0x18(%eax),%ecx
801048d7:	89 8a fc 06 00 00    	mov    %ecx,0x6fc(%edx)
    ps->ctime[i]            = (int)p->ctime;
801048dd:	8b 48 d8             	mov    -0x28(%eax),%ecx
801048e0:	89 8a fc 07 00 00    	mov    %ecx,0x7fc(%edx)
    ps->etime[i]            = (int)p->etime;
801048e6:	8b 48 dc             	mov    -0x24(%eax),%ecx
801048e9:	89 8a fc 08 00 00    	mov    %ecx,0x8fc(%edx)
  for(int i = 0; i < NPROC; i++){
801048ef:	3d 20 55 11 80       	cmp    $0x80115520,%eax
801048f4:	75 9a                	jne    80104890 <getpinfo+0x30>
  }
  release(&ptable.lock);
801048f6:	83 ec 0c             	sub    $0xc,%esp
801048f9:	68 e0 2e 11 80       	push   $0x80112ee0
801048fe:	e8 1d 04 00 00       	call   80104d20 <release>
  return 0;
80104903:	83 c4 10             	add    $0x10,%esp
80104906:	31 c0                	xor    %eax,%eax
}
80104908:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010490b:	c9                   	leave
8010490c:	c3                   	ret
    return -1;
8010490d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104912:	eb f4                	jmp    80104908 <getpinfo+0xa8>
80104914:	66 90                	xchg   %ax,%ax
80104916:	66 90                	xchg   %ax,%ax
80104918:	66 90                	xchg   %ax,%ax
8010491a:	66 90                	xchg   %ax,%ax
8010491c:	66 90                	xchg   %ax,%ax
8010491e:	66 90                	xchg   %ax,%ax

80104920 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	53                   	push   %ebx
80104924:	83 ec 0c             	sub    $0xc,%esp
80104927:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010492a:	68 8f 7d 10 80       	push   $0x80107d8f
8010492f:	8d 43 04             	lea    0x4(%ebx),%eax
80104932:	50                   	push   %eax
80104933:	e8 28 01 00 00       	call   80104a60 <initlock>
  lk->name = name;
80104938:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010493b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104941:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104944:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010494b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010494e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104951:	c9                   	leave
80104952:	c3                   	ret
80104953:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010495a:	00 
8010495b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104960 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	56                   	push   %esi
80104964:	53                   	push   %ebx
80104965:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104968:	8d 73 04             	lea    0x4(%ebx),%esi
8010496b:	83 ec 0c             	sub    $0xc,%esp
8010496e:	56                   	push   %esi
8010496f:	e8 2c 02 00 00       	call   80104ba0 <acquire>
  while (lk->locked) {
80104974:	8b 13                	mov    (%ebx),%edx
80104976:	83 c4 10             	add    $0x10,%esp
80104979:	85 d2                	test   %edx,%edx
8010497b:	74 16                	je     80104993 <acquiresleep+0x33>
8010497d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104980:	83 ec 08             	sub    $0x8,%esp
80104983:	56                   	push   %esi
80104984:	53                   	push   %ebx
80104985:	e8 c6 fb ff ff       	call   80104550 <sleep>
  while (lk->locked) {
8010498a:	8b 03                	mov    (%ebx),%eax
8010498c:	83 c4 10             	add    $0x10,%esp
8010498f:	85 c0                	test   %eax,%eax
80104991:	75 ed                	jne    80104980 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104993:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104999:	e8 22 f0 ff ff       	call   801039c0 <myproc>
8010499e:	8b 40 10             	mov    0x10(%eax),%eax
801049a1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801049a4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801049a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049aa:	5b                   	pop    %ebx
801049ab:	5e                   	pop    %esi
801049ac:	5d                   	pop    %ebp
  release(&lk->lk);
801049ad:	e9 6e 03 00 00       	jmp    80104d20 <release>
801049b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049b9:	00 
801049ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049c0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	56                   	push   %esi
801049c4:	53                   	push   %ebx
801049c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801049c8:	8d 73 04             	lea    0x4(%ebx),%esi
801049cb:	83 ec 0c             	sub    $0xc,%esp
801049ce:	56                   	push   %esi
801049cf:	e8 cc 01 00 00       	call   80104ba0 <acquire>
  lk->locked = 0;
801049d4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801049da:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801049e1:	89 1c 24             	mov    %ebx,(%esp)
801049e4:	e8 27 fc ff ff       	call   80104610 <wakeup>
  release(&lk->lk);
801049e9:	83 c4 10             	add    $0x10,%esp
801049ec:	89 75 08             	mov    %esi,0x8(%ebp)
}
801049ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049f2:	5b                   	pop    %ebx
801049f3:	5e                   	pop    %esi
801049f4:	5d                   	pop    %ebp
  release(&lk->lk);
801049f5:	e9 26 03 00 00       	jmp    80104d20 <release>
801049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a00 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	57                   	push   %edi
80104a04:	31 ff                	xor    %edi,%edi
80104a06:	56                   	push   %esi
80104a07:	53                   	push   %ebx
80104a08:	83 ec 18             	sub    $0x18,%esp
80104a0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;

  acquire(&lk->lk);
80104a0e:	8d 73 04             	lea    0x4(%ebx),%esi
80104a11:	56                   	push   %esi
80104a12:	e8 89 01 00 00       	call   80104ba0 <acquire>
  r = (lk->locked && (lk->pid == myproc()->pid));
80104a17:	8b 03                	mov    (%ebx),%eax
80104a19:	83 c4 10             	add    $0x10,%esp
80104a1c:	85 c0                	test   %eax,%eax
80104a1e:	75 18                	jne    80104a38 <holdingsleep+0x38>
  release(&lk->lk);
80104a20:	83 ec 0c             	sub    $0xc,%esp
80104a23:	56                   	push   %esi
80104a24:	e8 f7 02 00 00       	call   80104d20 <release>
  return r;
}
80104a29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a2c:	89 f8                	mov    %edi,%eax
80104a2e:	5b                   	pop    %ebx
80104a2f:	5e                   	pop    %esi
80104a30:	5f                   	pop    %edi
80104a31:	5d                   	pop    %ebp
80104a32:	c3                   	ret
80104a33:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = (lk->locked && (lk->pid == myproc()->pid));
80104a38:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104a3b:	e8 80 ef ff ff       	call   801039c0 <myproc>
80104a40:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a43:	0f 94 c0             	sete   %al
80104a46:	0f b6 c0             	movzbl %al,%eax
80104a49:	89 c7                	mov    %eax,%edi
80104a4b:	eb d3                	jmp    80104a20 <holdingsleep+0x20>
80104a4d:	66 90                	xchg   %ax,%ax
80104a4f:	66 90                	xchg   %ax,%ax
80104a51:	66 90                	xchg   %ax,%ax
80104a53:	66 90                	xchg   %ax,%ax
80104a55:	66 90                	xchg   %ax,%ax
80104a57:	66 90                	xchg   %ax,%ax
80104a59:	66 90                	xchg   %ax,%ax
80104a5b:	66 90                	xchg   %ax,%ax
80104a5d:	66 90                	xchg   %ax,%ax
80104a5f:	90                   	nop

80104a60 <initlock>:
#define mb() __sync_synchronize()

// Initialize a spinlock.
void
initlock(struct spinlock *lk, char *name)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name   = name;
80104a66:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104a69:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name   = name;
80104a6f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu    = 0;
80104a72:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
#ifdef DEBUG
  for(int i = 0; i < 10; i++) lk->pcs[i] = 0;
#endif
}
80104a79:	5d                   	pop    %ebp
80104a7a:	c3                   	ret
80104a7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104a80 <pushcli>:

// Disable interrupts and remember the nesting depth.
void
pushcli(void)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	53                   	push   %ebx
80104a84:	83 ec 04             	sub    $0x4,%esp
80104a87:	9c                   	pushf
80104a88:	5b                   	pop    %ebx
  asm volatile("cli");
80104a89:	fa                   	cli
  int eflags = readeflags();
  cli();
  if(mycpu()->ncli++ == 0)
80104a8a:	e8 b1 ee ff ff       	call   80103940 <mycpu>
80104a8f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104a95:	8d 4a 01             	lea    0x1(%edx),%ecx
80104a98:	89 88 a4 00 00 00    	mov    %ecx,0xa4(%eax)
80104a9e:	85 d2                	test   %edx,%edx
80104aa0:	74 0e                	je     80104ab0 <pushcli+0x30>
    mycpu()->intena = (eflags & FL_IF) != 0;
}
80104aa2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104aa5:	c9                   	leave
80104aa6:	c3                   	ret
80104aa7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104aae:	00 
80104aaf:	90                   	nop
    mycpu()->intena = (eflags & FL_IF) != 0;
80104ab0:	e8 8b ee ff ff       	call   80103940 <mycpu>
80104ab5:	c1 eb 09             	shr    $0x9,%ebx
80104ab8:	83 e3 01             	and    $0x1,%ebx
80104abb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
}
80104ac1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ac4:	c9                   	leave
80104ac5:	c3                   	ret
80104ac6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104acd:	00 
80104ace:	66 90                	xchg   %ax,%ax

80104ad0 <popcli>:

// Pop one level; re-enable interrupts if this is the outermost level.
void
popcli(void)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104ad6:	9c                   	pushf
80104ad7:	58                   	pop    %eax
  if(readeflags() & FL_IF)
80104ad8:	f6 c4 02             	test   $0x2,%ah
80104adb:	75 2a                	jne    80104b07 <popcli+0x37>
    panic("popcli - interruptible");

  struct cpu *c = mycpu();
80104add:	e8 5e ee ff ff       	call   80103940 <mycpu>
  if(--c->ncli < 0)
80104ae2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104ae9:	78 0f                	js     80104afa <popcli+0x2a>
    panic("popcli");

  if(c->ncli == 0 && c->intena)
80104aeb:	75 0b                	jne    80104af8 <popcli+0x28>
80104aed:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104af3:	85 c0                	test   %eax,%eax
80104af5:	74 01                	je     80104af8 <popcli+0x28>
  asm volatile("sti");
80104af7:	fb                   	sti
    sti();
}
80104af8:	c9                   	leave
80104af9:	c3                   	ret
    panic("popcli");
80104afa:	83 ec 0c             	sub    $0xc,%esp
80104afd:	68 b1 7d 10 80       	push   $0x80107db1
80104b02:	e8 99 b8 ff ff       	call   801003a0 <panic>
    panic("popcli - interruptible");
80104b07:	83 ec 0c             	sub    $0xc,%esp
80104b0a:	68 9a 7d 10 80       	push   $0x80107d9a
80104b0f:	e8 8c b8 ff ff       	call   801003a0 <panic>
80104b14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b1b:	00 
80104b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b20 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lk)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	56                   	push   %esi
80104b24:	8b 75 08             	mov    0x8(%ebp),%esi
80104b27:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b28:	9c                   	pushf
80104b29:	5b                   	pop    %ebx
  asm volatile("cli");
80104b2a:	fa                   	cli
  if(mycpu()->ncli++ == 0)
80104b2b:	e8 10 ee ff ff       	call   80103940 <mycpu>
80104b30:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104b36:	8d 4a 01             	lea    0x1(%edx),%ecx
80104b39:	89 88 a4 00 00 00    	mov    %ecx,0xa4(%eax)
80104b3f:	85 d2                	test   %edx,%edx
80104b41:	74 1d                	je     80104b60 <holding+0x40>
  int r;
  pushcli();
  r = (lk->locked && lk->cpu == mycpu());
80104b43:	8b 06                	mov    (%esi),%eax
80104b45:	31 db                	xor    %ebx,%ebx
80104b47:	85 c0                	test   %eax,%eax
80104b49:	75 2e                	jne    80104b79 <holding+0x59>
  popcli();
80104b4b:	e8 80 ff ff ff       	call   80104ad0 <popcli>
  return r;
}
80104b50:	89 d8                	mov    %ebx,%eax
80104b52:	5b                   	pop    %ebx
80104b53:	5e                   	pop    %esi
80104b54:	5d                   	pop    %ebp
80104b55:	c3                   	ret
80104b56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b5d:	00 
80104b5e:	66 90                	xchg   %ax,%ax
    mycpu()->intena = (eflags & FL_IF) != 0;
80104b60:	e8 db ed ff ff       	call   80103940 <mycpu>
80104b65:	c1 eb 09             	shr    $0x9,%ebx
80104b68:	83 e3 01             	and    $0x1,%ebx
80104b6b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  r = (lk->locked && lk->cpu == mycpu());
80104b71:	8b 06                	mov    (%esi),%eax
80104b73:	31 db                	xor    %ebx,%ebx
80104b75:	85 c0                	test   %eax,%eax
80104b77:	74 d2                	je     80104b4b <holding+0x2b>
80104b79:	8b 5e 08             	mov    0x8(%esi),%ebx
80104b7c:	e8 bf ed ff ff       	call   80103940 <mycpu>
80104b81:	39 c3                	cmp    %eax,%ebx
80104b83:	0f 94 c3             	sete   %bl
  popcli();
80104b86:	e8 45 ff ff ff       	call   80104ad0 <popcli>
  r = (lk->locked && lk->cpu == mycpu());
80104b8b:	0f b6 db             	movzbl %bl,%ebx
}
80104b8e:	89 d8                	mov    %ebx,%eax
80104b90:	5b                   	pop    %ebx
80104b91:	5e                   	pop    %esi
80104b92:	5d                   	pop    %ebp
80104b93:	c3                   	ret
80104b94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b9b:	00 
80104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ba0 <acquire>:

// Acquire the lock.
void
acquire(struct spinlock *lk)
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	56                   	push   %esi
80104ba4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104ba5:	9c                   	pushf
80104ba6:	5b                   	pop    %ebx
  asm volatile("cli");
80104ba7:	fa                   	cli
  if(mycpu()->ncli++ == 0)
80104ba8:	e8 93 ed ff ff       	call   80103940 <mycpu>
80104bad:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104bb3:	8d 4a 01             	lea    0x1(%edx),%ecx
80104bb6:	89 88 a4 00 00 00    	mov    %ecx,0xa4(%eax)
80104bbc:	85 d2                	test   %edx,%edx
80104bbe:	0f 84 3c 01 00 00    	je     80104d00 <acquire+0x160>
  pushcli(); // disable interrupts to avoid deadlock
  if(holding(lk))
80104bc4:	8b 75 08             	mov    0x8(%ebp),%esi
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104bc7:	9c                   	pushf
80104bc8:	5b                   	pop    %ebx
  asm volatile("cli");
80104bc9:	fa                   	cli
  if(mycpu()->ncli++ == 0)
80104bca:	e8 71 ed ff ff       	call   80103940 <mycpu>
80104bcf:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104bd5:	8d 4a 01             	lea    0x1(%edx),%ecx
80104bd8:	89 88 a4 00 00 00    	mov    %ecx,0xa4(%eax)
80104bde:	85 d2                	test   %edx,%edx
80104be0:	0f 84 02 01 00 00    	je     80104ce8 <acquire+0x148>
  r = (lk->locked && lk->cpu == mycpu());
80104be6:	8b 06                	mov    (%esi),%eax
80104be8:	85 c0                	test   %eax,%eax
80104bea:	0f 85 d0 00 00 00    	jne    80104cc0 <acquire+0x120>
  popcli();
80104bf0:	e8 db fe ff ff       	call   80104ad0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104bf5:	b9 01 00 00 00       	mov    $0x1,%ecx
80104bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104c00:	8b 55 08             	mov    0x8(%ebp),%edx
80104c03:	89 c8                	mov    %ecx,%eax
80104c05:	f0 87 02             	lock xchg %eax,(%edx)
80104c08:	85 c0                	test   %eax,%eax
80104c0a:	75 f4                	jne    80104c00 <acquire+0x60>
    ;

  // Memory barrier so later loads/stores don't move before lock.
  mb();
80104c0c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104c11:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c14:	e8 27 ed ff ff       	call   80103940 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104c19:	8b 4d 08             	mov    0x8(%ebp),%ecx
{
  uint *ebp;
  int i;

  // با فرض نگه‌داری فریم‌پوینتر (gcc با -fno-omit-frame-pointer)
  ebp = (uint*)v - 2;
80104c1c:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104c1e:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104c21:	31 c0                	xor    %eax,%eax
80104c23:	eb 1b                	jmp    80104c40 <acquire+0xa0>
80104c25:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c2c:	00 
80104c2d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c34:	00 
80104c35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c3c:	00 
80104c3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104c40:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104c46:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104c4c:	77 22                	ja     80104c70 <acquire+0xd0>
      break;
    pcs[i] = ebp[1];       // saved %eip
80104c4e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104c51:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104c55:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0];   // saved %ebp
80104c58:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104c5a:	83 f8 0a             	cmp    $0xa,%eax
80104c5d:	75 e1                	jne    80104c40 <acquire+0xa0>
}
80104c5f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c62:	5b                   	pop    %ebx
80104c63:	5e                   	pop    %esi
80104c64:	5d                   	pop    %ebp
80104c65:	c3                   	ret
80104c66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c6d:	00 
80104c6e:	66 90                	xchg   %ax,%ax
  }
  for(; i < 10; i++)
80104c70:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80104c74:	83 c1 34             	add    $0x34,%ecx
80104c77:	89 ca                	mov    %ecx,%edx
80104c79:	29 c2                	sub    %eax,%edx
80104c7b:	83 e2 04             	and    $0x4,%edx
80104c7e:	74 20                	je     80104ca0 <acquire+0x100>
    pcs[i] = 0;
80104c80:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104c86:	83 c0 04             	add    $0x4,%eax
80104c89:	39 c8                	cmp    %ecx,%eax
80104c8b:	74 d2                	je     80104c5f <acquire+0xbf>
80104c8d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c94:	00 
80104c95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c9c:	00 
80104c9d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104ca0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ca6:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104ca9:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104cb0:	39 c8                	cmp    %ecx,%eax
80104cb2:	75 ec                	jne    80104ca0 <acquire+0x100>
80104cb4:	eb a9                	jmp    80104c5f <acquire+0xbf>
80104cb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cbd:	00 
80104cbe:	66 90                	xchg   %ax,%ax
  r = (lk->locked && lk->cpu == mycpu());
80104cc0:	8b 5e 08             	mov    0x8(%esi),%ebx
80104cc3:	e8 78 ec ff ff       	call   80103940 <mycpu>
80104cc8:	39 c3                	cmp    %eax,%ebx
80104cca:	0f 85 20 ff ff ff    	jne    80104bf0 <acquire+0x50>
  popcli();
80104cd0:	e8 fb fd ff ff       	call   80104ad0 <popcli>
    panic("acquire");
80104cd5:	83 ec 0c             	sub    $0xc,%esp
80104cd8:	68 b8 7d 10 80       	push   $0x80107db8
80104cdd:	e8 be b6 ff ff       	call   801003a0 <panic>
80104ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = (eflags & FL_IF) != 0;
80104ce8:	e8 53 ec ff ff       	call   80103940 <mycpu>
80104ced:	c1 eb 09             	shr    $0x9,%ebx
80104cf0:	83 e3 01             	and    $0x1,%ebx
80104cf3:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104cf9:	e9 e8 fe ff ff       	jmp    80104be6 <acquire+0x46>
80104cfe:	66 90                	xchg   %ax,%ax
80104d00:	e8 3b ec ff ff       	call   80103940 <mycpu>
80104d05:	c1 eb 09             	shr    $0x9,%ebx
80104d08:	83 e3 01             	and    $0x1,%ebx
80104d0b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104d11:	e9 ae fe ff ff       	jmp    80104bc4 <acquire+0x24>
80104d16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d1d:	00 
80104d1e:	66 90                	xchg   %ax,%ax

80104d20 <release>:
{
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	56                   	push   %esi
80104d24:	53                   	push   %ebx
80104d25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104d28:	9c                   	pushf
80104d29:	5e                   	pop    %esi
  asm volatile("cli");
80104d2a:	fa                   	cli
  if(mycpu()->ncli++ == 0)
80104d2b:	e8 10 ec ff ff       	call   80103940 <mycpu>
80104d30:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104d36:	8d 4a 01             	lea    0x1(%edx),%ecx
80104d39:	89 88 a4 00 00 00    	mov    %ecx,0xa4(%eax)
80104d3f:	85 d2                	test   %edx,%edx
80104d41:	74 1d                	je     80104d60 <release+0x40>
  r = (lk->locked && lk->cpu == mycpu());
80104d43:	8b 03                	mov    (%ebx),%eax
80104d45:	85 c0                	test   %eax,%eax
80104d47:	75 2e                	jne    80104d77 <release+0x57>
  popcli();
80104d49:	e8 82 fd ff ff       	call   80104ad0 <popcli>
    panic("release");
80104d4e:	83 ec 0c             	sub    $0xc,%esp
80104d51:	68 c0 7d 10 80       	push   $0x80107dc0
80104d56:	e8 45 b6 ff ff       	call   801003a0 <panic>
80104d5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    mycpu()->intena = (eflags & FL_IF) != 0;
80104d60:	e8 db eb ff ff       	call   80103940 <mycpu>
80104d65:	c1 ee 09             	shr    $0x9,%esi
80104d68:	83 e6 01             	and    $0x1,%esi
80104d6b:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
  r = (lk->locked && lk->cpu == mycpu());
80104d71:	8b 03                	mov    (%ebx),%eax
80104d73:	85 c0                	test   %eax,%eax
80104d75:	74 d2                	je     80104d49 <release+0x29>
80104d77:	8b 73 08             	mov    0x8(%ebx),%esi
80104d7a:	e8 c1 eb ff ff       	call   80103940 <mycpu>
80104d7f:	39 c6                	cmp    %eax,%esi
80104d81:	75 c6                	jne    80104d49 <release+0x29>
  popcli();
80104d83:	e8 48 fd ff ff       	call   80104ad0 <popcli>
  lk->pcs[0] = 0;
80104d88:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  asm volatile("lock; xchgl %0, %1" :
80104d8f:	31 c0                	xor    %eax,%eax
  lk->cpu = 0;
80104d91:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  mb();
80104d98:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104d9d:	f0 87 03             	lock xchg %eax,(%ebx)
}
80104da0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104da3:	5b                   	pop    %ebx
80104da4:	5e                   	pop    %esi
80104da5:	5d                   	pop    %ebp
  popcli();
80104da6:	e9 25 fd ff ff       	jmp    80104ad0 <popcli>
80104dab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104db0 <getcallerpcs>:
{
80104db0:	55                   	push   %ebp
  for(i = 0; i < 10; i++){
80104db1:	31 d2                	xor    %edx,%edx
{
80104db3:	89 e5                	mov    %esp,%ebp
80104db5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104db6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104db9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104dbc:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104dbf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104dc0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104dc6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104dcc:	77 1a                	ja     80104de8 <getcallerpcs+0x38>
    pcs[i] = ebp[1];       // saved %eip
80104dce:	8b 58 04             	mov    0x4(%eax),%ebx
80104dd1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104dd4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0];   // saved %ebp
80104dd7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104dd9:	83 fa 0a             	cmp    $0xa,%edx
80104ddc:	75 e2                	jne    80104dc0 <getcallerpcs+0x10>
}
80104dde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104de1:	c9                   	leave
80104de2:	c3                   	ret
80104de3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104de8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104deb:	83 c1 28             	add    $0x28,%ecx
80104dee:	89 ca                	mov    %ecx,%edx
80104df0:	29 c2                	sub    %eax,%edx
80104df2:	83 e2 04             	and    $0x4,%edx
80104df5:	74 29                	je     80104e20 <getcallerpcs+0x70>
    pcs[i] = 0;
80104df7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104dfd:	83 c0 04             	add    $0x4,%eax
80104e00:	39 c8                	cmp    %ecx,%eax
80104e02:	74 da                	je     80104dde <getcallerpcs+0x2e>
80104e04:	eb 1a                	jmp    80104e20 <getcallerpcs+0x70>
80104e06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e0d:	00 
80104e0e:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e15:	00 
80104e16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e1d:	00 
80104e1e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104e20:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104e26:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104e29:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104e30:	39 c8                	cmp    %ecx,%eax
80104e32:	75 ec                	jne    80104e20 <getcallerpcs+0x70>
80104e34:	eb a8                	jmp    80104dde <getcallerpcs+0x2e>
80104e36:	66 90                	xchg   %ax,%ax
80104e38:	66 90                	xchg   %ax,%ax
80104e3a:	66 90                	xchg   %ax,%ax
80104e3c:	66 90                	xchg   %ax,%ax
80104e3e:	66 90                	xchg   %ax,%ax

80104e40 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	57                   	push   %edi
80104e44:	8b 55 08             	mov    0x8(%ebp),%edx
80104e47:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104e4a:	89 d0                	mov    %edx,%eax
80104e4c:	09 c8                	or     %ecx,%eax
80104e4e:	a8 03                	test   $0x3,%al
80104e50:	75 1e                	jne    80104e70 <memset+0x30>
    c &= 0xFF;
80104e52:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104e56:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104e59:	89 d7                	mov    %edx,%edi
80104e5b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104e61:	fc                   	cld
80104e62:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104e64:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104e67:	89 d0                	mov    %edx,%eax
80104e69:	c9                   	leave
80104e6a:	c3                   	ret
80104e6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104e70:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e73:	89 d7                	mov    %edx,%edi
80104e75:	fc                   	cld
80104e76:	f3 aa                	rep stos %al,%es:(%edi)
80104e78:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104e7b:	89 d0                	mov    %edx,%eax
80104e7d:	c9                   	leave
80104e7e:	c3                   	ret
80104e7f:	90                   	nop

80104e80 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	56                   	push   %esi
80104e84:	8b 75 10             	mov    0x10(%ebp),%esi
80104e87:	8b 45 08             	mov    0x8(%ebp),%eax
80104e8a:	53                   	push   %ebx
80104e8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104e8e:	85 f6                	test   %esi,%esi
80104e90:	74 2e                	je     80104ec0 <memcmp+0x40>
80104e92:	01 c6                	add    %eax,%esi
80104e94:	eb 14                	jmp    80104eaa <memcmp+0x2a>
80104e96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e9d:	00 
80104e9e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104ea0:	83 c0 01             	add    $0x1,%eax
80104ea3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104ea6:	39 f0                	cmp    %esi,%eax
80104ea8:	74 16                	je     80104ec0 <memcmp+0x40>
    if(*s1 != *s2)
80104eaa:	0f b6 08             	movzbl (%eax),%ecx
80104ead:	0f b6 1a             	movzbl (%edx),%ebx
80104eb0:	38 d9                	cmp    %bl,%cl
80104eb2:	74 ec                	je     80104ea0 <memcmp+0x20>
      return *s1 - *s2;
80104eb4:	0f b6 c1             	movzbl %cl,%eax
80104eb7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104eb9:	5b                   	pop    %ebx
80104eba:	5e                   	pop    %esi
80104ebb:	5d                   	pop    %ebp
80104ebc:	c3                   	ret
80104ebd:	8d 76 00             	lea    0x0(%esi),%esi
80104ec0:	5b                   	pop    %ebx
  return 0;
80104ec1:	31 c0                	xor    %eax,%eax
}
80104ec3:	5e                   	pop    %esi
80104ec4:	5d                   	pop    %ebp
80104ec5:	c3                   	ret
80104ec6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ecd:	00 
80104ece:	66 90                	xchg   %ax,%ax

80104ed0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	57                   	push   %edi
80104ed4:	8b 55 08             	mov    0x8(%ebp),%edx
80104ed7:	8b 45 10             	mov    0x10(%ebp),%eax
80104eda:	56                   	push   %esi
80104edb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104ede:	39 d6                	cmp    %edx,%esi
80104ee0:	73 26                	jae    80104f08 <memmove+0x38>
80104ee2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104ee5:	39 ca                	cmp    %ecx,%edx
80104ee7:	73 1f                	jae    80104f08 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104ee9:	85 c0                	test   %eax,%eax
80104eeb:	74 0f                	je     80104efc <memmove+0x2c>
80104eed:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104ef0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104ef4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104ef7:	83 e8 01             	sub    $0x1,%eax
80104efa:	73 f4                	jae    80104ef0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104efc:	5e                   	pop    %esi
80104efd:	89 d0                	mov    %edx,%eax
80104eff:	5f                   	pop    %edi
80104f00:	5d                   	pop    %ebp
80104f01:	c3                   	ret
80104f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104f08:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104f0b:	89 d7                	mov    %edx,%edi
80104f0d:	85 c0                	test   %eax,%eax
80104f0f:	74 eb                	je     80104efc <memmove+0x2c>
80104f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f1f:	00 
      *d++ = *s++;
80104f20:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104f21:	39 f1                	cmp    %esi,%ecx
80104f23:	75 fb                	jne    80104f20 <memmove+0x50>
}
80104f25:	5e                   	pop    %esi
80104f26:	89 d0                	mov    %edx,%eax
80104f28:	5f                   	pop    %edi
80104f29:	5d                   	pop    %ebp
80104f2a:	c3                   	ret
80104f2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104f30 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104f30:	eb 9e                	jmp    80104ed0 <memmove>
80104f32:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f39:	00 
80104f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f40 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	53                   	push   %ebx
80104f44:	8b 55 10             	mov    0x10(%ebp),%edx
80104f47:	8b 45 08             	mov    0x8(%ebp),%eax
80104f4a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
80104f4d:	85 d2                	test   %edx,%edx
80104f4f:	75 16                	jne    80104f67 <strncmp+0x27>
80104f51:	eb 2d                	jmp    80104f80 <strncmp+0x40>
80104f53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f58:	3a 19                	cmp    (%ecx),%bl
80104f5a:	75 12                	jne    80104f6e <strncmp+0x2e>
    n--, p++, q++;
80104f5c:	83 c0 01             	add    $0x1,%eax
80104f5f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104f62:	83 ea 01             	sub    $0x1,%edx
80104f65:	74 19                	je     80104f80 <strncmp+0x40>
80104f67:	0f b6 18             	movzbl (%eax),%ebx
80104f6a:	84 db                	test   %bl,%bl
80104f6c:	75 ea                	jne    80104f58 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104f6e:	0f b6 00             	movzbl (%eax),%eax
80104f71:	0f b6 11             	movzbl (%ecx),%edx
}
80104f74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f77:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80104f78:	29 d0                	sub    %edx,%eax
}
80104f7a:	c3                   	ret
80104f7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104f83:	31 c0                	xor    %eax,%eax
}
80104f85:	c9                   	leave
80104f86:	c3                   	ret
80104f87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f8e:	00 
80104f8f:	90                   	nop

80104f90 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	57                   	push   %edi
80104f94:	56                   	push   %esi
80104f95:	8b 75 08             	mov    0x8(%ebp),%esi
80104f98:	53                   	push   %ebx
80104f99:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104f9c:	89 f0                	mov    %esi,%eax
80104f9e:	eb 15                	jmp    80104fb5 <strncpy+0x25>
80104fa0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104fa4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104fa7:	83 c0 01             	add    $0x1,%eax
80104faa:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
80104fae:	88 48 ff             	mov    %cl,-0x1(%eax)
80104fb1:	84 c9                	test   %cl,%cl
80104fb3:	74 13                	je     80104fc8 <strncpy+0x38>
80104fb5:	89 d3                	mov    %edx,%ebx
80104fb7:	83 ea 01             	sub    $0x1,%edx
80104fba:	85 db                	test   %ebx,%ebx
80104fbc:	7f e2                	jg     80104fa0 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
80104fbe:	5b                   	pop    %ebx
80104fbf:	89 f0                	mov    %esi,%eax
80104fc1:	5e                   	pop    %esi
80104fc2:	5f                   	pop    %edi
80104fc3:	5d                   	pop    %ebp
80104fc4:	c3                   	ret
80104fc5:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80104fc8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104fcb:	83 e9 01             	sub    $0x1,%ecx
80104fce:	85 d2                	test   %edx,%edx
80104fd0:	74 ec                	je     80104fbe <strncpy+0x2e>
80104fd2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fd9:	00 
80104fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104fe0:	83 c0 01             	add    $0x1,%eax
80104fe3:	89 ca                	mov    %ecx,%edx
80104fe5:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104fe9:	29 c2                	sub    %eax,%edx
80104feb:	85 d2                	test   %edx,%edx
80104fed:	7f f1                	jg     80104fe0 <strncpy+0x50>
}
80104fef:	5b                   	pop    %ebx
80104ff0:	89 f0                	mov    %esi,%eax
80104ff2:	5e                   	pop    %esi
80104ff3:	5f                   	pop    %edi
80104ff4:	5d                   	pop    %ebp
80104ff5:	c3                   	ret
80104ff6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ffd:	00 
80104ffe:	66 90                	xchg   %ax,%ax

80105000 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	56                   	push   %esi
80105004:	8b 55 10             	mov    0x10(%ebp),%edx
80105007:	8b 75 08             	mov    0x8(%ebp),%esi
8010500a:	53                   	push   %ebx
8010500b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010500e:	85 d2                	test   %edx,%edx
80105010:	7e 25                	jle    80105037 <safestrcpy+0x37>
80105012:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105016:	89 f2                	mov    %esi,%edx
80105018:	eb 16                	jmp    80105030 <safestrcpy+0x30>
8010501a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105020:	0f b6 08             	movzbl (%eax),%ecx
80105023:	83 c0 01             	add    $0x1,%eax
80105026:	83 c2 01             	add    $0x1,%edx
80105029:	88 4a ff             	mov    %cl,-0x1(%edx)
8010502c:	84 c9                	test   %cl,%cl
8010502e:	74 04                	je     80105034 <safestrcpy+0x34>
80105030:	39 d8                	cmp    %ebx,%eax
80105032:	75 ec                	jne    80105020 <safestrcpy+0x20>
    ;
  *s = 0;
80105034:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105037:	89 f0                	mov    %esi,%eax
80105039:	5b                   	pop    %ebx
8010503a:	5e                   	pop    %esi
8010503b:	5d                   	pop    %ebp
8010503c:	c3                   	ret
8010503d:	8d 76 00             	lea    0x0(%esi),%esi

80105040 <strlen>:

int
strlen(const char *s)
{
80105040:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105041:	31 c0                	xor    %eax,%eax
{
80105043:	89 e5                	mov    %esp,%ebp
80105045:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105048:	80 3a 00             	cmpb   $0x0,(%edx)
8010504b:	74 0c                	je     80105059 <strlen+0x19>
8010504d:	8d 76 00             	lea    0x0(%esi),%esi
80105050:	83 c0 01             	add    $0x1,%eax
80105053:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105057:	75 f7                	jne    80105050 <strlen+0x10>
    ;
  return n;
}
80105059:	5d                   	pop    %ebp
8010505a:	c3                   	ret

8010505b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010505b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010505f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105063:	55                   	push   %ebp
  pushl %ebx
80105064:	53                   	push   %ebx
  pushl %esi
80105065:	56                   	push   %esi
  pushl %edi
80105066:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105067:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105069:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010506b:	5f                   	pop    %edi
  popl %esi
8010506c:	5e                   	pop    %esi
  popl %ebx
8010506d:	5b                   	pop    %ebx
  popl %ebp
8010506e:	5d                   	pop    %ebp
  ret
8010506f:	c3                   	ret

80105070 <fetchint>:
#endif

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	53                   	push   %ebx
80105074:	83 ec 04             	sub    $0x4,%esp
80105077:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010507a:	e8 41 e9 ff ff       	call   801039c0 <myproc>
  if(curproc == 0)
8010507f:	85 c0                	test   %eax,%eax
80105081:	74 1d                	je     801050a0 <fetchint+0x30>
    return -1;

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105083:	8b 00                	mov    (%eax),%eax
80105085:	39 c3                	cmp    %eax,%ebx
80105087:	73 17                	jae    801050a0 <fetchint+0x30>
80105089:	8d 53 04             	lea    0x4(%ebx),%edx
8010508c:	39 d0                	cmp    %edx,%eax
8010508e:	72 10                	jb     801050a0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105090:	8b 45 0c             	mov    0xc(%ebp),%eax
80105093:	8b 13                	mov    (%ebx),%edx
80105095:	89 10                	mov    %edx,(%eax)
  return 0;
80105097:	31 c0                	xor    %eax,%eax
}
80105099:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010509c:	c9                   	leave
8010509d:	c3                   	ret
8010509e:	66 90                	xchg   %ax,%ax
    return -1;
801050a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050a5:	eb f2                	jmp    80105099 <fetchint+0x29>
801050a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801050ae:	00 
801050af:	90                   	nop

801050b0 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
int
fetchstr(uint addr, char **pp)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	53                   	push   %ebx
801050b4:	83 ec 04             	sub    $0x4,%esp
801050b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801050ba:	e8 01 e9 ff ff       	call   801039c0 <myproc>
  if(curproc == 0)
801050bf:	85 c0                	test   %eax,%eax
801050c1:	74 35                	je     801050f8 <fetchstr+0x48>
    return -1;

  if(addr >= curproc->sz)
801050c3:	3b 18                	cmp    (%eax),%ebx
801050c5:	73 31                	jae    801050f8 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
801050c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801050ca:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801050cc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801050ce:	39 d3                	cmp    %edx,%ebx
801050d0:	73 26                	jae    801050f8 <fetchstr+0x48>
801050d2:	89 d8                	mov    %ebx,%eax
801050d4:	eb 11                	jmp    801050e7 <fetchstr+0x37>
801050d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801050dd:	00 
801050de:	66 90                	xchg   %ax,%ax
801050e0:	83 c0 01             	add    $0x1,%eax
801050e3:	39 d0                	cmp    %edx,%eax
801050e5:	73 11                	jae    801050f8 <fetchstr+0x48>
    if(*s == 0)
801050e7:	80 38 00             	cmpb   $0x0,(%eax)
801050ea:	75 f4                	jne    801050e0 <fetchstr+0x30>
      return s - *pp;
801050ec:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801050ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050f1:	c9                   	leave
801050f2:	c3                   	ret
801050f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801050f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801050fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105100:	c9                   	leave
80105101:	c3                   	ret
80105102:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105109:	00 
8010510a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105110 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	56                   	push   %esi
80105114:	53                   	push   %ebx
  struct proc *p = myproc();
80105115:	e8 a6 e8 ff ff       	call   801039c0 <myproc>
  if(p == 0 || p->tf == 0)
8010511a:	85 c0                	test   %eax,%eax
8010511c:	74 3a                	je     80105158 <argint+0x48>
8010511e:	8b 40 18             	mov    0x18(%eax),%eax
80105121:	85 c0                	test   %eax,%eax
80105123:	74 33                	je     80105158 <argint+0x48>
    return -1;
  return fetchint((p->tf->esp) + 4 + 4*n, ip);
80105125:	8b 40 44             	mov    0x44(%eax),%eax
80105128:	8b 55 08             	mov    0x8(%ebp),%edx
8010512b:	8d 34 90             	lea    (%eax,%edx,4),%esi
8010512e:	8d 5e 04             	lea    0x4(%esi),%ebx
  struct proc *curproc = myproc();
80105131:	e8 8a e8 ff ff       	call   801039c0 <myproc>
  if(curproc == 0)
80105136:	85 c0                	test   %eax,%eax
80105138:	74 1e                	je     80105158 <argint+0x48>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010513a:	8b 00                	mov    (%eax),%eax
8010513c:	39 c3                	cmp    %eax,%ebx
8010513e:	73 18                	jae    80105158 <argint+0x48>
80105140:	8d 56 08             	lea    0x8(%esi),%edx
80105143:	39 d0                	cmp    %edx,%eax
80105145:	72 11                	jb     80105158 <argint+0x48>
  *ip = *(int*)(addr);
80105147:	8b 45 0c             	mov    0xc(%ebp),%eax
8010514a:	8b 56 04             	mov    0x4(%esi),%edx
8010514d:	89 10                	mov    %edx,(%eax)
  return 0;
8010514f:	31 c0                	xor    %eax,%eax
}
80105151:	5b                   	pop    %ebx
80105152:	5e                   	pop    %esi
80105153:	5d                   	pop    %ebp
80105154:	c3                   	ret
80105155:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010515d:	eb f2                	jmp    80105151 <argint+0x41>
8010515f:	90                   	nop

80105160 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// Ensures [ptr, ptr+size) lies in user space of current process.
int
argptr(int n, char **pp, int size)
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	56                   	push   %esi
80105164:	53                   	push   %ebx
80105165:	83 ec 10             	sub    $0x10,%esp
80105168:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;
  struct proc *curproc = myproc();
8010516b:	e8 50 e8 ff ff       	call   801039c0 <myproc>
  if(curproc == 0)
80105170:	85 c0                	test   %eax,%eax
80105172:	74 3c                	je     801051b0 <argptr+0x50>
    return -1;

  if(argint(n, &i) < 0)
80105174:	83 ec 08             	sub    $0x8,%esp
80105177:	89 c3                	mov    %eax,%ebx
80105179:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010517c:	50                   	push   %eax
8010517d:	ff 75 08             	push   0x8(%ebp)
80105180:	e8 8b ff ff ff       	call   80105110 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105185:	83 c4 10             	add    $0x10,%esp
80105188:	85 f6                	test   %esi,%esi
8010518a:	78 24                	js     801051b0 <argptr+0x50>
8010518c:	83 f8 ff             	cmp    $0xffffffff,%eax
8010518f:	74 1f                	je     801051b0 <argptr+0x50>
80105191:	8b 13                	mov    (%ebx),%edx
80105193:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105196:	39 d0                	cmp    %edx,%eax
80105198:	73 16                	jae    801051b0 <argptr+0x50>
8010519a:	01 c6                	add    %eax,%esi
8010519c:	39 f2                	cmp    %esi,%edx
8010519e:	72 10                	jb     801051b0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801051a0:	8b 55 0c             	mov    0xc(%ebp),%edx
801051a3:	89 02                	mov    %eax,(%edx)
  return 0;
801051a5:	31 c0                	xor    %eax,%eax
}
801051a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051aa:	5b                   	pop    %ebx
801051ab:	5e                   	pop    %esi
801051ac:	5d                   	pop    %ebp
801051ad:	c3                   	ret
801051ae:	66 90                	xchg   %ax,%ax
    return -1;
801051b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051b5:	eb f0                	jmp    801051a7 <argptr+0x47>
801051b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801051be:	00 
801051bf:	90                   	nop

801051c0 <argstr>:

// Fetch the nth word-sized system call argument as a string pointer.
int
argstr(int n, char **pp)
{
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	53                   	push   %ebx
  int addr;
  if(argint(n, &addr) < 0)
801051c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801051c7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(n, &addr) < 0)
801051ca:	50                   	push   %eax
801051cb:	ff 75 08             	push   0x8(%ebp)
801051ce:	e8 3d ff ff ff       	call   80105110 <argint>
801051d3:	83 c4 10             	add    $0x10,%esp
801051d6:	83 f8 ff             	cmp    $0xffffffff,%eax
801051d9:	74 3d                	je     80105218 <argstr+0x58>
    return -1;
  return fetchstr((uint)addr, pp);
801051db:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  struct proc *curproc = myproc();
801051de:	e8 dd e7 ff ff       	call   801039c0 <myproc>
  if(curproc == 0)
801051e3:	85 c0                	test   %eax,%eax
801051e5:	74 31                	je     80105218 <argstr+0x58>
  if(addr >= curproc->sz)
801051e7:	3b 18                	cmp    (%eax),%ebx
801051e9:	73 2d                	jae    80105218 <argstr+0x58>
  *pp = (char*)addr;
801051eb:	8b 55 0c             	mov    0xc(%ebp),%edx
801051ee:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801051f0:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801051f2:	39 d3                	cmp    %edx,%ebx
801051f4:	73 22                	jae    80105218 <argstr+0x58>
801051f6:	89 d8                	mov    %ebx,%eax
801051f8:	eb 0d                	jmp    80105207 <argstr+0x47>
801051fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105200:	83 c0 01             	add    $0x1,%eax
80105203:	39 d0                	cmp    %edx,%eax
80105205:	73 11                	jae    80105218 <argstr+0x58>
    if(*s == 0)
80105207:	80 38 00             	cmpb   $0x0,(%eax)
8010520a:	75 f4                	jne    80105200 <argstr+0x40>
      return s - *pp;
8010520c:	29 d8                	sub    %ebx,%eax
}
8010520e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105211:	c9                   	leave
80105212:	c3                   	ret
80105213:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105218:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
8010521b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105220:	c9                   	leave
80105221:	c3                   	ret
80105222:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105229:	00 
8010522a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105230 <syscall>:

};

void
syscall(void)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	53                   	push   %ebx
80105234:	83 ec 04             	sub    $0x4,%esp
  struct proc *curproc = myproc();
80105237:	e8 84 e7 ff ff       	call   801039c0 <myproc>
  if(curproc == 0 || curproc->tf == 0){
8010523c:	85 c0                	test   %eax,%eax
8010523e:	74 29                	je     80105269 <syscall+0x39>
80105240:	89 c3                	mov    %eax,%ebx
80105242:	8b 40 18             	mov    0x18(%eax),%eax
80105245:	85 c0                	test   %eax,%eax
80105247:	74 20                	je     80105269 <syscall+0x39>
    // حالت غیرمنتظره؛ گارد اضافه برای ایمنی
    return;
  }

  int num = curproc->tf->eax;
80105249:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < (int)NELEM(syscalls) && syscalls[num]) {
8010524c:	8d 50 ff             	lea    -0x1(%eax),%edx
8010524f:	83 fa 19             	cmp    $0x19,%edx
80105252:	77 1c                	ja     80105270 <syscall+0x40>
80105254:	8b 14 85 60 83 10 80 	mov    -0x7fef7ca0(,%eax,4),%edx
8010525b:	85 d2                	test   %edx,%edx
8010525d:	74 11                	je     80105270 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
8010525f:	ff d2                	call   *%edx
80105261:	89 c2                	mov    %eax,%edx
80105263:	8b 43 18             	mov    0x18(%ebx),%eax
80105266:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105269:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010526c:	c9                   	leave
8010526d:	c3                   	ret
8010526e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80105270:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105271:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105274:	50                   	push   %eax
80105275:	ff 73 10             	push   0x10(%ebx)
80105278:	68 c8 7d 10 80       	push   $0x80107dc8
8010527d:	e8 4e b4 ff ff       	call   801006d0 <cprintf>
    curproc->tf->eax = -1;
80105282:	8b 43 18             	mov    0x18(%ebx),%eax
80105285:	83 c4 10             	add    $0x10,%esp
80105288:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010528f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105292:	c9                   	leave
80105293:	c3                   	ret
80105294:	66 90                	xchg   %ax,%ax
80105296:	66 90                	xchg   %ax,%ax
80105298:	66 90                	xchg   %ax,%ax
8010529a:	66 90                	xchg   %ax,%ax
8010529c:	66 90                	xchg   %ax,%ax
8010529e:	66 90                	xchg   %ax,%ax

801052a0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	57                   	push   %edi
801052a4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801052a5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801052a8:	53                   	push   %ebx
801052a9:	83 ec 34             	sub    $0x34,%esp
801052ac:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801052af:	8b 4d 08             	mov    0x8(%ebp),%ecx
801052b2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801052b5:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801052b8:	57                   	push   %edi
801052b9:	50                   	push   %eax
801052ba:	e8 61 ce ff ff       	call   80102120 <nameiparent>
801052bf:	83 c4 10             	add    $0x10,%esp
801052c2:	85 c0                	test   %eax,%eax
801052c4:	74 5e                	je     80105324 <create+0x84>
    return 0;
  ilock(dp);
801052c6:	83 ec 0c             	sub    $0xc,%esp
801052c9:	89 c3                	mov    %eax,%ebx
801052cb:	50                   	push   %eax
801052cc:	e8 1f c5 ff ff       	call   801017f0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801052d1:	83 c4 0c             	add    $0xc,%esp
801052d4:	6a 00                	push   $0x0
801052d6:	57                   	push   %edi
801052d7:	53                   	push   %ebx
801052d8:	e8 63 ca ff ff       	call   80101d40 <dirlookup>
801052dd:	83 c4 10             	add    $0x10,%esp
801052e0:	89 c6                	mov    %eax,%esi
801052e2:	85 c0                	test   %eax,%eax
801052e4:	74 4a                	je     80105330 <create+0x90>
    iunlockput(dp);
801052e6:	83 ec 0c             	sub    $0xc,%esp
801052e9:	53                   	push   %ebx
801052ea:	e8 91 c7 ff ff       	call   80101a80 <iunlockput>
    ilock(ip);
801052ef:	89 34 24             	mov    %esi,(%esp)
801052f2:	e8 f9 c4 ff ff       	call   801017f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801052f7:	83 c4 10             	add    $0x10,%esp
801052fa:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801052ff:	75 17                	jne    80105318 <create+0x78>
80105301:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105306:	75 10                	jne    80105318 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105308:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010530b:	89 f0                	mov    %esi,%eax
8010530d:	5b                   	pop    %ebx
8010530e:	5e                   	pop    %esi
8010530f:	5f                   	pop    %edi
80105310:	5d                   	pop    %ebp
80105311:	c3                   	ret
80105312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105318:	83 ec 0c             	sub    $0xc,%esp
8010531b:	56                   	push   %esi
8010531c:	e8 5f c7 ff ff       	call   80101a80 <iunlockput>
    return 0;
80105321:	83 c4 10             	add    $0x10,%esp
}
80105324:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105327:	31 f6                	xor    %esi,%esi
}
80105329:	5b                   	pop    %ebx
8010532a:	89 f0                	mov    %esi,%eax
8010532c:	5e                   	pop    %esi
8010532d:	5f                   	pop    %edi
8010532e:	5d                   	pop    %ebp
8010532f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80105330:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105334:	83 ec 08             	sub    $0x8,%esp
80105337:	50                   	push   %eax
80105338:	ff 33                	push   (%ebx)
8010533a:	e8 41 c3 ff ff       	call   80101680 <ialloc>
8010533f:	83 c4 10             	add    $0x10,%esp
80105342:	89 c6                	mov    %eax,%esi
80105344:	85 c0                	test   %eax,%eax
80105346:	0f 84 af 00 00 00    	je     801053fb <create+0x15b>
  ilock(ip);
8010534c:	83 ec 0c             	sub    $0xc,%esp
8010534f:	50                   	push   %eax
80105350:	e8 9b c4 ff ff       	call   801017f0 <ilock>
  ip->major = major;
80105355:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105359:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010535d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105361:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105365:	b8 01 00 00 00       	mov    $0x1,%eax
8010536a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010536e:	89 34 24             	mov    %esi,(%esp)
80105371:	e8 ca c3 ff ff       	call   80101740 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105376:	83 c4 10             	add    $0x10,%esp
80105379:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010537e:	74 30                	je     801053b0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80105380:	83 ec 04             	sub    $0x4,%esp
80105383:	ff 76 04             	push   0x4(%esi)
80105386:	57                   	push   %edi
80105387:	53                   	push   %ebx
80105388:	e8 b3 cc ff ff       	call   80102040 <dirlink>
8010538d:	83 c4 10             	add    $0x10,%esp
80105390:	85 c0                	test   %eax,%eax
80105392:	78 74                	js     80105408 <create+0x168>
  iunlockput(dp);
80105394:	83 ec 0c             	sub    $0xc,%esp
80105397:	53                   	push   %ebx
80105398:	e8 e3 c6 ff ff       	call   80101a80 <iunlockput>
  return ip;
8010539d:	83 c4 10             	add    $0x10,%esp
}
801053a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053a3:	89 f0                	mov    %esi,%eax
801053a5:	5b                   	pop    %ebx
801053a6:	5e                   	pop    %esi
801053a7:	5f                   	pop    %edi
801053a8:	5d                   	pop    %ebp
801053a9:	c3                   	ret
801053aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801053b0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801053b3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801053b8:	53                   	push   %ebx
801053b9:	e8 82 c3 ff ff       	call   80101740 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801053be:	83 c4 0c             	add    $0xc,%esp
801053c1:	ff 76 04             	push   0x4(%esi)
801053c4:	68 00 7e 10 80       	push   $0x80107e00
801053c9:	56                   	push   %esi
801053ca:	e8 71 cc ff ff       	call   80102040 <dirlink>
801053cf:	83 c4 10             	add    $0x10,%esp
801053d2:	85 c0                	test   %eax,%eax
801053d4:	78 18                	js     801053ee <create+0x14e>
801053d6:	83 ec 04             	sub    $0x4,%esp
801053d9:	ff 73 04             	push   0x4(%ebx)
801053dc:	68 ff 7d 10 80       	push   $0x80107dff
801053e1:	56                   	push   %esi
801053e2:	e8 59 cc ff ff       	call   80102040 <dirlink>
801053e7:	83 c4 10             	add    $0x10,%esp
801053ea:	85 c0                	test   %eax,%eax
801053ec:	79 92                	jns    80105380 <create+0xe0>
      panic("create dots");
801053ee:	83 ec 0c             	sub    $0xc,%esp
801053f1:	68 f3 7d 10 80       	push   $0x80107df3
801053f6:	e8 a5 af ff ff       	call   801003a0 <panic>
    panic("create: ialloc");
801053fb:	83 ec 0c             	sub    $0xc,%esp
801053fe:	68 e4 7d 10 80       	push   $0x80107de4
80105403:	e8 98 af ff ff       	call   801003a0 <panic>
    panic("create: dirlink");
80105408:	83 ec 0c             	sub    $0xc,%esp
8010540b:	68 02 7e 10 80       	push   $0x80107e02
80105410:	e8 8b af ff ff       	call   801003a0 <panic>
80105415:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010541c:	00 
8010541d:	8d 76 00             	lea    0x0(%esi),%esi

80105420 <sys_dup>:
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	56                   	push   %esi
80105424:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105425:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105428:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010542b:	50                   	push   %eax
8010542c:	6a 00                	push   $0x0
8010542e:	e8 dd fc ff ff       	call   80105110 <argint>
80105433:	83 c4 10             	add    $0x10,%esp
80105436:	85 c0                	test   %eax,%eax
80105438:	78 36                	js     80105470 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010543a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010543e:	77 30                	ja     80105470 <sys_dup+0x50>
80105440:	e8 7b e5 ff ff       	call   801039c0 <myproc>
80105445:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105448:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010544c:	85 f6                	test   %esi,%esi
8010544e:	74 20                	je     80105470 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105450:	e8 6b e5 ff ff       	call   801039c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105455:	31 db                	xor    %ebx,%ebx
80105457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010545e:	00 
8010545f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80105460:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105464:	85 d2                	test   %edx,%edx
80105466:	74 18                	je     80105480 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105468:	83 c3 01             	add    $0x1,%ebx
8010546b:	83 fb 10             	cmp    $0x10,%ebx
8010546e:	75 f0                	jne    80105460 <sys_dup+0x40>
    return -1;
80105470:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105475:	eb 19                	jmp    80105490 <sys_dup+0x70>
80105477:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010547e:	00 
8010547f:	90                   	nop
  filedup(f);
80105480:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105483:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105487:	56                   	push   %esi
80105488:	e8 83 ba ff ff       	call   80100f10 <filedup>
  return fd;
8010548d:	83 c4 10             	add    $0x10,%esp
}
80105490:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105493:	89 d8                	mov    %ebx,%eax
80105495:	5b                   	pop    %ebx
80105496:	5e                   	pop    %esi
80105497:	5d                   	pop    %ebp
80105498:	c3                   	ret
80105499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054a0 <sys_read>:
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	56                   	push   %esi
801054a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801054a5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801054a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801054ab:	53                   	push   %ebx
801054ac:	6a 00                	push   $0x0
801054ae:	e8 5d fc ff ff       	call   80105110 <argint>
801054b3:	83 c4 10             	add    $0x10,%esp
801054b6:	85 c0                	test   %eax,%eax
801054b8:	78 5e                	js     80105518 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801054ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801054be:	77 58                	ja     80105518 <sys_read+0x78>
801054c0:	e8 fb e4 ff ff       	call   801039c0 <myproc>
801054c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054c8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801054cc:	85 f6                	test   %esi,%esi
801054ce:	74 48                	je     80105518 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054d0:	83 ec 08             	sub    $0x8,%esp
801054d3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054d6:	50                   	push   %eax
801054d7:	6a 02                	push   $0x2
801054d9:	e8 32 fc ff ff       	call   80105110 <argint>
801054de:	83 c4 10             	add    $0x10,%esp
801054e1:	85 c0                	test   %eax,%eax
801054e3:	78 33                	js     80105518 <sys_read+0x78>
801054e5:	83 ec 04             	sub    $0x4,%esp
801054e8:	ff 75 f0             	push   -0x10(%ebp)
801054eb:	53                   	push   %ebx
801054ec:	6a 01                	push   $0x1
801054ee:	e8 6d fc ff ff       	call   80105160 <argptr>
801054f3:	83 c4 10             	add    $0x10,%esp
801054f6:	85 c0                	test   %eax,%eax
801054f8:	78 1e                	js     80105518 <sys_read+0x78>
  return fileread(f, p, n);
801054fa:	83 ec 04             	sub    $0x4,%esp
801054fd:	ff 75 f0             	push   -0x10(%ebp)
80105500:	ff 75 f4             	push   -0xc(%ebp)
80105503:	56                   	push   %esi
80105504:	e8 87 bb ff ff       	call   80101090 <fileread>
80105509:	83 c4 10             	add    $0x10,%esp
}
8010550c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010550f:	5b                   	pop    %ebx
80105510:	5e                   	pop    %esi
80105511:	5d                   	pop    %ebp
80105512:	c3                   	ret
80105513:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105518:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010551d:	eb ed                	jmp    8010550c <sys_read+0x6c>
8010551f:	90                   	nop

80105520 <sys_write>:
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	56                   	push   %esi
80105524:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105525:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105528:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010552b:	53                   	push   %ebx
8010552c:	6a 00                	push   $0x0
8010552e:	e8 dd fb ff ff       	call   80105110 <argint>
80105533:	83 c4 10             	add    $0x10,%esp
80105536:	85 c0                	test   %eax,%eax
80105538:	78 5e                	js     80105598 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010553a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010553e:	77 58                	ja     80105598 <sys_write+0x78>
80105540:	e8 7b e4 ff ff       	call   801039c0 <myproc>
80105545:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105548:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010554c:	85 f6                	test   %esi,%esi
8010554e:	74 48                	je     80105598 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105550:	83 ec 08             	sub    $0x8,%esp
80105553:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105556:	50                   	push   %eax
80105557:	6a 02                	push   $0x2
80105559:	e8 b2 fb ff ff       	call   80105110 <argint>
8010555e:	83 c4 10             	add    $0x10,%esp
80105561:	85 c0                	test   %eax,%eax
80105563:	78 33                	js     80105598 <sys_write+0x78>
80105565:	83 ec 04             	sub    $0x4,%esp
80105568:	ff 75 f0             	push   -0x10(%ebp)
8010556b:	53                   	push   %ebx
8010556c:	6a 01                	push   $0x1
8010556e:	e8 ed fb ff ff       	call   80105160 <argptr>
80105573:	83 c4 10             	add    $0x10,%esp
80105576:	85 c0                	test   %eax,%eax
80105578:	78 1e                	js     80105598 <sys_write+0x78>
  return filewrite(f, p, n);
8010557a:	83 ec 04             	sub    $0x4,%esp
8010557d:	ff 75 f0             	push   -0x10(%ebp)
80105580:	ff 75 f4             	push   -0xc(%ebp)
80105583:	56                   	push   %esi
80105584:	e8 97 bb ff ff       	call   80101120 <filewrite>
80105589:	83 c4 10             	add    $0x10,%esp
}
8010558c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010558f:	5b                   	pop    %ebx
80105590:	5e                   	pop    %esi
80105591:	5d                   	pop    %ebp
80105592:	c3                   	ret
80105593:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105598:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010559d:	eb ed                	jmp    8010558c <sys_write+0x6c>
8010559f:	90                   	nop

801055a0 <sys_close>:
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	56                   	push   %esi
801055a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801055a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801055a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801055ab:	50                   	push   %eax
801055ac:	6a 00                	push   $0x0
801055ae:	e8 5d fb ff ff       	call   80105110 <argint>
801055b3:	83 c4 10             	add    $0x10,%esp
801055b6:	85 c0                	test   %eax,%eax
801055b8:	78 3e                	js     801055f8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801055ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801055be:	77 38                	ja     801055f8 <sys_close+0x58>
801055c0:	e8 fb e3 ff ff       	call   801039c0 <myproc>
801055c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055c8:	8d 5a 08             	lea    0x8(%edx),%ebx
801055cb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801055cf:	85 f6                	test   %esi,%esi
801055d1:	74 25                	je     801055f8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801055d3:	e8 e8 e3 ff ff       	call   801039c0 <myproc>
  fileclose(f);
801055d8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801055db:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801055e2:	00 
  fileclose(f);
801055e3:	56                   	push   %esi
801055e4:	e8 77 b9 ff ff       	call   80100f60 <fileclose>
  return 0;
801055e9:	83 c4 10             	add    $0x10,%esp
801055ec:	31 c0                	xor    %eax,%eax
}
801055ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055f1:	5b                   	pop    %ebx
801055f2:	5e                   	pop    %esi
801055f3:	5d                   	pop    %ebp
801055f4:	c3                   	ret
801055f5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801055f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055fd:	eb ef                	jmp    801055ee <sys_close+0x4e>
801055ff:	90                   	nop

80105600 <sys_fstat>:
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	56                   	push   %esi
80105604:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105605:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105608:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010560b:	53                   	push   %ebx
8010560c:	6a 00                	push   $0x0
8010560e:	e8 fd fa ff ff       	call   80105110 <argint>
80105613:	83 c4 10             	add    $0x10,%esp
80105616:	85 c0                	test   %eax,%eax
80105618:	78 46                	js     80105660 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010561a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010561e:	77 40                	ja     80105660 <sys_fstat+0x60>
80105620:	e8 9b e3 ff ff       	call   801039c0 <myproc>
80105625:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105628:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010562c:	85 f6                	test   %esi,%esi
8010562e:	74 30                	je     80105660 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105630:	83 ec 04             	sub    $0x4,%esp
80105633:	6a 10                	push   $0x10
80105635:	53                   	push   %ebx
80105636:	6a 01                	push   $0x1
80105638:	e8 23 fb ff ff       	call   80105160 <argptr>
8010563d:	83 c4 10             	add    $0x10,%esp
80105640:	85 c0                	test   %eax,%eax
80105642:	78 1c                	js     80105660 <sys_fstat+0x60>
  return filestat(f, st);
80105644:	83 ec 08             	sub    $0x8,%esp
80105647:	ff 75 f4             	push   -0xc(%ebp)
8010564a:	56                   	push   %esi
8010564b:	e8 f0 b9 ff ff       	call   80101040 <filestat>
80105650:	83 c4 10             	add    $0x10,%esp
}
80105653:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105656:	5b                   	pop    %ebx
80105657:	5e                   	pop    %esi
80105658:	5d                   	pop    %ebp
80105659:	c3                   	ret
8010565a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105660:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105665:	eb ec                	jmp    80105653 <sys_fstat+0x53>
80105667:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010566e:	00 
8010566f:	90                   	nop

80105670 <sys_link>:
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	57                   	push   %edi
80105674:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105675:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105678:	53                   	push   %ebx
80105679:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010567c:	50                   	push   %eax
8010567d:	6a 00                	push   $0x0
8010567f:	e8 3c fb ff ff       	call   801051c0 <argstr>
80105684:	83 c4 10             	add    $0x10,%esp
80105687:	85 c0                	test   %eax,%eax
80105689:	0f 88 fb 00 00 00    	js     8010578a <sys_link+0x11a>
8010568f:	83 ec 08             	sub    $0x8,%esp
80105692:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105695:	50                   	push   %eax
80105696:	6a 01                	push   $0x1
80105698:	e8 23 fb ff ff       	call   801051c0 <argstr>
8010569d:	83 c4 10             	add    $0x10,%esp
801056a0:	85 c0                	test   %eax,%eax
801056a2:	0f 88 e2 00 00 00    	js     8010578a <sys_link+0x11a>
  begin_op();
801056a8:	e8 93 d7 ff ff       	call   80102e40 <begin_op>
  if((ip = namei(old)) == 0){
801056ad:	83 ec 0c             	sub    $0xc,%esp
801056b0:	ff 75 d4             	push   -0x2c(%ebp)
801056b3:	e8 48 ca ff ff       	call   80102100 <namei>
801056b8:	83 c4 10             	add    $0x10,%esp
801056bb:	89 c3                	mov    %eax,%ebx
801056bd:	85 c0                	test   %eax,%eax
801056bf:	0f 84 df 00 00 00    	je     801057a4 <sys_link+0x134>
  ilock(ip);
801056c5:	83 ec 0c             	sub    $0xc,%esp
801056c8:	50                   	push   %eax
801056c9:	e8 22 c1 ff ff       	call   801017f0 <ilock>
  if(ip->type == T_DIR){
801056ce:	83 c4 10             	add    $0x10,%esp
801056d1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801056d6:	0f 84 b5 00 00 00    	je     80105791 <sys_link+0x121>
  iupdate(ip);
801056dc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801056df:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801056e4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801056e7:	53                   	push   %ebx
801056e8:	e8 53 c0 ff ff       	call   80101740 <iupdate>
  iunlock(ip);
801056ed:	89 1c 24             	mov    %ebx,(%esp)
801056f0:	e8 db c1 ff ff       	call   801018d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801056f5:	58                   	pop    %eax
801056f6:	5a                   	pop    %edx
801056f7:	57                   	push   %edi
801056f8:	ff 75 d0             	push   -0x30(%ebp)
801056fb:	e8 20 ca ff ff       	call   80102120 <nameiparent>
80105700:	83 c4 10             	add    $0x10,%esp
80105703:	89 c6                	mov    %eax,%esi
80105705:	85 c0                	test   %eax,%eax
80105707:	74 5b                	je     80105764 <sys_link+0xf4>
  ilock(dp);
80105709:	83 ec 0c             	sub    $0xc,%esp
8010570c:	50                   	push   %eax
8010570d:	e8 de c0 ff ff       	call   801017f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105712:	8b 03                	mov    (%ebx),%eax
80105714:	83 c4 10             	add    $0x10,%esp
80105717:	39 06                	cmp    %eax,(%esi)
80105719:	75 3d                	jne    80105758 <sys_link+0xe8>
8010571b:	83 ec 04             	sub    $0x4,%esp
8010571e:	ff 73 04             	push   0x4(%ebx)
80105721:	57                   	push   %edi
80105722:	56                   	push   %esi
80105723:	e8 18 c9 ff ff       	call   80102040 <dirlink>
80105728:	83 c4 10             	add    $0x10,%esp
8010572b:	85 c0                	test   %eax,%eax
8010572d:	78 29                	js     80105758 <sys_link+0xe8>
  iunlockput(dp);
8010572f:	83 ec 0c             	sub    $0xc,%esp
80105732:	56                   	push   %esi
80105733:	e8 48 c3 ff ff       	call   80101a80 <iunlockput>
  iput(ip);
80105738:	89 1c 24             	mov    %ebx,(%esp)
8010573b:	e8 e0 c1 ff ff       	call   80101920 <iput>
  end_op();
80105740:	e8 6b d7 ff ff       	call   80102eb0 <end_op>
  return 0;
80105745:	83 c4 10             	add    $0x10,%esp
80105748:	31 c0                	xor    %eax,%eax
}
8010574a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010574d:	5b                   	pop    %ebx
8010574e:	5e                   	pop    %esi
8010574f:	5f                   	pop    %edi
80105750:	5d                   	pop    %ebp
80105751:	c3                   	ret
80105752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105758:	83 ec 0c             	sub    $0xc,%esp
8010575b:	56                   	push   %esi
8010575c:	e8 1f c3 ff ff       	call   80101a80 <iunlockput>
    goto bad;
80105761:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105764:	83 ec 0c             	sub    $0xc,%esp
80105767:	53                   	push   %ebx
80105768:	e8 83 c0 ff ff       	call   801017f0 <ilock>
  ip->nlink--;
8010576d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105772:	89 1c 24             	mov    %ebx,(%esp)
80105775:	e8 c6 bf ff ff       	call   80101740 <iupdate>
  iunlockput(ip);
8010577a:	89 1c 24             	mov    %ebx,(%esp)
8010577d:	e8 fe c2 ff ff       	call   80101a80 <iunlockput>
  end_op();
80105782:	e8 29 d7 ff ff       	call   80102eb0 <end_op>
  return -1;
80105787:	83 c4 10             	add    $0x10,%esp
    return -1;
8010578a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010578f:	eb b9                	jmp    8010574a <sys_link+0xda>
    iunlockput(ip);
80105791:	83 ec 0c             	sub    $0xc,%esp
80105794:	53                   	push   %ebx
80105795:	e8 e6 c2 ff ff       	call   80101a80 <iunlockput>
    end_op();
8010579a:	e8 11 d7 ff ff       	call   80102eb0 <end_op>
    return -1;
8010579f:	83 c4 10             	add    $0x10,%esp
801057a2:	eb e6                	jmp    8010578a <sys_link+0x11a>
    end_op();
801057a4:	e8 07 d7 ff ff       	call   80102eb0 <end_op>
    return -1;
801057a9:	eb df                	jmp    8010578a <sys_link+0x11a>
801057ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801057b0 <sys_unlink>:
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	57                   	push   %edi
801057b4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801057b5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801057b8:	53                   	push   %ebx
801057b9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801057bc:	50                   	push   %eax
801057bd:	6a 00                	push   $0x0
801057bf:	e8 fc f9 ff ff       	call   801051c0 <argstr>
801057c4:	83 c4 10             	add    $0x10,%esp
801057c7:	85 c0                	test   %eax,%eax
801057c9:	0f 88 54 01 00 00    	js     80105923 <sys_unlink+0x173>
  begin_op();
801057cf:	e8 6c d6 ff ff       	call   80102e40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801057d4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801057d7:	83 ec 08             	sub    $0x8,%esp
801057da:	53                   	push   %ebx
801057db:	ff 75 c0             	push   -0x40(%ebp)
801057de:	e8 3d c9 ff ff       	call   80102120 <nameiparent>
801057e3:	83 c4 10             	add    $0x10,%esp
801057e6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801057e9:	85 c0                	test   %eax,%eax
801057eb:	0f 84 58 01 00 00    	je     80105949 <sys_unlink+0x199>
  ilock(dp);
801057f1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801057f4:	83 ec 0c             	sub    $0xc,%esp
801057f7:	57                   	push   %edi
801057f8:	e8 f3 bf ff ff       	call   801017f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801057fd:	58                   	pop    %eax
801057fe:	5a                   	pop    %edx
801057ff:	68 00 7e 10 80       	push   $0x80107e00
80105804:	53                   	push   %ebx
80105805:	e8 16 c5 ff ff       	call   80101d20 <namecmp>
8010580a:	83 c4 10             	add    $0x10,%esp
8010580d:	85 c0                	test   %eax,%eax
8010580f:	0f 84 fb 00 00 00    	je     80105910 <sys_unlink+0x160>
80105815:	83 ec 08             	sub    $0x8,%esp
80105818:	68 ff 7d 10 80       	push   $0x80107dff
8010581d:	53                   	push   %ebx
8010581e:	e8 fd c4 ff ff       	call   80101d20 <namecmp>
80105823:	83 c4 10             	add    $0x10,%esp
80105826:	85 c0                	test   %eax,%eax
80105828:	0f 84 e2 00 00 00    	je     80105910 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010582e:	83 ec 04             	sub    $0x4,%esp
80105831:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105834:	50                   	push   %eax
80105835:	53                   	push   %ebx
80105836:	57                   	push   %edi
80105837:	e8 04 c5 ff ff       	call   80101d40 <dirlookup>
8010583c:	83 c4 10             	add    $0x10,%esp
8010583f:	89 c3                	mov    %eax,%ebx
80105841:	85 c0                	test   %eax,%eax
80105843:	0f 84 c7 00 00 00    	je     80105910 <sys_unlink+0x160>
  ilock(ip);
80105849:	83 ec 0c             	sub    $0xc,%esp
8010584c:	50                   	push   %eax
8010584d:	e8 9e bf ff ff       	call   801017f0 <ilock>
  if(ip->nlink < 1)
80105852:	83 c4 10             	add    $0x10,%esp
80105855:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010585a:	0f 8e fd 00 00 00    	jle    8010595d <sys_unlink+0x1ad>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105860:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105865:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105868:	74 66                	je     801058d0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010586a:	83 ec 04             	sub    $0x4,%esp
8010586d:	6a 10                	push   $0x10
8010586f:	6a 00                	push   $0x0
80105871:	57                   	push   %edi
80105872:	e8 c9 f5 ff ff       	call   80104e40 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105877:	6a 10                	push   $0x10
80105879:	ff 75 c4             	push   -0x3c(%ebp)
8010587c:	57                   	push   %edi
8010587d:	ff 75 b4             	push   -0x4c(%ebp)
80105880:	e8 7b c3 ff ff       	call   80101c00 <writei>
80105885:	83 c4 20             	add    $0x20,%esp
80105888:	83 f8 10             	cmp    $0x10,%eax
8010588b:	0f 85 d9 00 00 00    	jne    8010596a <sys_unlink+0x1ba>
  if(ip->type == T_DIR){
80105891:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105896:	0f 84 94 00 00 00    	je     80105930 <sys_unlink+0x180>
  iunlockput(dp);
8010589c:	83 ec 0c             	sub    $0xc,%esp
8010589f:	ff 75 b4             	push   -0x4c(%ebp)
801058a2:	e8 d9 c1 ff ff       	call   80101a80 <iunlockput>
  ip->nlink--;
801058a7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801058ac:	89 1c 24             	mov    %ebx,(%esp)
801058af:	e8 8c be ff ff       	call   80101740 <iupdate>
  iunlockput(ip);
801058b4:	89 1c 24             	mov    %ebx,(%esp)
801058b7:	e8 c4 c1 ff ff       	call   80101a80 <iunlockput>
  end_op();
801058bc:	e8 ef d5 ff ff       	call   80102eb0 <end_op>
  return 0;
801058c1:	83 c4 10             	add    $0x10,%esp
801058c4:	31 c0                	xor    %eax,%eax
}
801058c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058c9:	5b                   	pop    %ebx
801058ca:	5e                   	pop    %esi
801058cb:	5f                   	pop    %edi
801058cc:	5d                   	pop    %ebp
801058cd:	c3                   	ret
801058ce:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801058d0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801058d4:	76 94                	jbe    8010586a <sys_unlink+0xba>
801058d6:	be 20 00 00 00       	mov    $0x20,%esi
801058db:	eb 0b                	jmp    801058e8 <sys_unlink+0x138>
801058dd:	8d 76 00             	lea    0x0(%esi),%esi
801058e0:	83 c6 10             	add    $0x10,%esi
801058e3:	3b 73 58             	cmp    0x58(%ebx),%esi
801058e6:	73 82                	jae    8010586a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801058e8:	6a 10                	push   $0x10
801058ea:	56                   	push   %esi
801058eb:	57                   	push   %edi
801058ec:	53                   	push   %ebx
801058ed:	e8 0e c2 ff ff       	call   80101b00 <readi>
801058f2:	83 c4 10             	add    $0x10,%esp
801058f5:	83 f8 10             	cmp    $0x10,%eax
801058f8:	75 56                	jne    80105950 <sys_unlink+0x1a0>
    if(de.inum != 0)
801058fa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801058ff:	74 df                	je     801058e0 <sys_unlink+0x130>
    iunlockput(ip);
80105901:	83 ec 0c             	sub    $0xc,%esp
80105904:	53                   	push   %ebx
80105905:	e8 76 c1 ff ff       	call   80101a80 <iunlockput>
    goto bad;
8010590a:	83 c4 10             	add    $0x10,%esp
8010590d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105910:	83 ec 0c             	sub    $0xc,%esp
80105913:	ff 75 b4             	push   -0x4c(%ebp)
80105916:	e8 65 c1 ff ff       	call   80101a80 <iunlockput>
  end_op();
8010591b:	e8 90 d5 ff ff       	call   80102eb0 <end_op>
  return -1;
80105920:	83 c4 10             	add    $0x10,%esp
    return -1;
80105923:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105928:	eb 9c                	jmp    801058c6 <sys_unlink+0x116>
8010592a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105930:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105933:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105936:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010593b:	50                   	push   %eax
8010593c:	e8 ff bd ff ff       	call   80101740 <iupdate>
80105941:	83 c4 10             	add    $0x10,%esp
80105944:	e9 53 ff ff ff       	jmp    8010589c <sys_unlink+0xec>
    end_op();
80105949:	e8 62 d5 ff ff       	call   80102eb0 <end_op>
    return -1;
8010594e:	eb d3                	jmp    80105923 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105950:	83 ec 0c             	sub    $0xc,%esp
80105953:	68 24 7e 10 80       	push   $0x80107e24
80105958:	e8 43 aa ff ff       	call   801003a0 <panic>
    panic("unlink: nlink < 1");
8010595d:	83 ec 0c             	sub    $0xc,%esp
80105960:	68 12 7e 10 80       	push   $0x80107e12
80105965:	e8 36 aa ff ff       	call   801003a0 <panic>
    panic("unlink: writei");
8010596a:	83 ec 0c             	sub    $0xc,%esp
8010596d:	68 36 7e 10 80       	push   $0x80107e36
80105972:	e8 29 aa ff ff       	call   801003a0 <panic>
80105977:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010597e:	00 
8010597f:	90                   	nop

80105980 <sys_open>:

int
sys_open(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	57                   	push   %edi
80105984:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105985:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105988:	53                   	push   %ebx
80105989:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010598c:	50                   	push   %eax
8010598d:	6a 00                	push   $0x0
8010598f:	e8 2c f8 ff ff       	call   801051c0 <argstr>
80105994:	83 c4 10             	add    $0x10,%esp
80105997:	85 c0                	test   %eax,%eax
80105999:	0f 88 8e 00 00 00    	js     80105a2d <sys_open+0xad>
8010599f:	83 ec 08             	sub    $0x8,%esp
801059a2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801059a5:	50                   	push   %eax
801059a6:	6a 01                	push   $0x1
801059a8:	e8 63 f7 ff ff       	call   80105110 <argint>
801059ad:	83 c4 10             	add    $0x10,%esp
801059b0:	85 c0                	test   %eax,%eax
801059b2:	78 79                	js     80105a2d <sys_open+0xad>
    return -1;

  begin_op();
801059b4:	e8 87 d4 ff ff       	call   80102e40 <begin_op>

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801059b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(omode & O_CREATE){
801059bc:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801059c0:	75 76                	jne    80105a38 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801059c2:	83 ec 0c             	sub    $0xc,%esp
801059c5:	50                   	push   %eax
801059c6:	e8 35 c7 ff ff       	call   80102100 <namei>
801059cb:	83 c4 10             	add    $0x10,%esp
801059ce:	89 c6                	mov    %eax,%esi
801059d0:	85 c0                	test   %eax,%eax
801059d2:	74 7e                	je     80105a52 <sys_open+0xd2>
      end_op();
      return -1;
    }
    ilock(ip);
801059d4:	83 ec 0c             	sub    $0xc,%esp
801059d7:	50                   	push   %eax
801059d8:	e8 13 be ff ff       	call   801017f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801059dd:	83 c4 10             	add    $0x10,%esp
801059e0:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801059e5:	0f 84 bd 00 00 00    	je     80105aa8 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801059eb:	e8 b0 b4 ff ff       	call   80100ea0 <filealloc>
801059f0:	89 c7                	mov    %eax,%edi
801059f2:	85 c0                	test   %eax,%eax
801059f4:	74 26                	je     80105a1c <sys_open+0x9c>
  struct proc *curproc = myproc();
801059f6:	e8 c5 df ff ff       	call   801039c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801059fb:	31 db                	xor    %ebx,%ebx
801059fd:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80105a00:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105a04:	85 d2                	test   %edx,%edx
80105a06:	74 58                	je     80105a60 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105a08:	83 c3 01             	add    $0x1,%ebx
80105a0b:	83 fb 10             	cmp    $0x10,%ebx
80105a0e:	75 f0                	jne    80105a00 <sys_open+0x80>
    if(f)
      fileclose(f);
80105a10:	83 ec 0c             	sub    $0xc,%esp
80105a13:	57                   	push   %edi
80105a14:	e8 47 b5 ff ff       	call   80100f60 <fileclose>
80105a19:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105a1c:	83 ec 0c             	sub    $0xc,%esp
80105a1f:	56                   	push   %esi
80105a20:	e8 5b c0 ff ff       	call   80101a80 <iunlockput>
    end_op();
80105a25:	e8 86 d4 ff ff       	call   80102eb0 <end_op>
    return -1;
80105a2a:	83 c4 10             	add    $0x10,%esp
    return -1;
80105a2d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a32:	eb 65                	jmp    80105a99 <sys_open+0x119>
80105a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105a38:	83 ec 0c             	sub    $0xc,%esp
80105a3b:	31 c9                	xor    %ecx,%ecx
80105a3d:	ba 02 00 00 00       	mov    $0x2,%edx
80105a42:	6a 00                	push   $0x0
80105a44:	e8 57 f8 ff ff       	call   801052a0 <create>
    if(ip == 0){
80105a49:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105a4c:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105a4e:	85 c0                	test   %eax,%eax
80105a50:	75 99                	jne    801059eb <sys_open+0x6b>
      end_op();
80105a52:	e8 59 d4 ff ff       	call   80102eb0 <end_op>
      return -1;
80105a57:	eb d4                	jmp    80105a2d <sys_open+0xad>
80105a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105a60:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105a63:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105a67:	56                   	push   %esi
80105a68:	e8 63 be ff ff       	call   801018d0 <iunlock>
  end_op();
80105a6d:	e8 3e d4 ff ff       	call   80102eb0 <end_op>

  f->type = FD_INODE;
80105a72:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105a78:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a7b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105a7e:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105a81:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105a83:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105a8a:	f7 d0                	not    %eax
80105a8c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a8f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105a92:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a95:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105a99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a9c:	89 d8                	mov    %ebx,%eax
80105a9e:	5b                   	pop    %ebx
80105a9f:	5e                   	pop    %esi
80105aa0:	5f                   	pop    %edi
80105aa1:	5d                   	pop    %ebp
80105aa2:	c3                   	ret
80105aa3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105aa8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105aab:	85 c9                	test   %ecx,%ecx
80105aad:	0f 84 38 ff ff ff    	je     801059eb <sys_open+0x6b>
80105ab3:	e9 64 ff ff ff       	jmp    80105a1c <sys_open+0x9c>
80105ab8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105abf:	00 

80105ac0 <sys_mkdir>:

int
sys_mkdir(void)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105ac6:	e8 75 d3 ff ff       	call   80102e40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105acb:	83 ec 08             	sub    $0x8,%esp
80105ace:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ad1:	50                   	push   %eax
80105ad2:	6a 00                	push   $0x0
80105ad4:	e8 e7 f6 ff ff       	call   801051c0 <argstr>
80105ad9:	83 c4 10             	add    $0x10,%esp
80105adc:	85 c0                	test   %eax,%eax
80105ade:	78 30                	js     80105b10 <sys_mkdir+0x50>
80105ae0:	83 ec 0c             	sub    $0xc,%esp
80105ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae6:	31 c9                	xor    %ecx,%ecx
80105ae8:	ba 01 00 00 00       	mov    $0x1,%edx
80105aed:	6a 00                	push   $0x0
80105aef:	e8 ac f7 ff ff       	call   801052a0 <create>
80105af4:	83 c4 10             	add    $0x10,%esp
80105af7:	85 c0                	test   %eax,%eax
80105af9:	74 15                	je     80105b10 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105afb:	83 ec 0c             	sub    $0xc,%esp
80105afe:	50                   	push   %eax
80105aff:	e8 7c bf ff ff       	call   80101a80 <iunlockput>
  end_op();
80105b04:	e8 a7 d3 ff ff       	call   80102eb0 <end_op>
  return 0;
80105b09:	83 c4 10             	add    $0x10,%esp
80105b0c:	31 c0                	xor    %eax,%eax
}
80105b0e:	c9                   	leave
80105b0f:	c3                   	ret
    end_op();
80105b10:	e8 9b d3 ff ff       	call   80102eb0 <end_op>
    return -1;
80105b15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b1a:	c9                   	leave
80105b1b:	c3                   	ret
80105b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b20 <sys_mknod>:

int
sys_mknod(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105b26:	e8 15 d3 ff ff       	call   80102e40 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105b2b:	83 ec 08             	sub    $0x8,%esp
80105b2e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105b31:	50                   	push   %eax
80105b32:	6a 00                	push   $0x0
80105b34:	e8 87 f6 ff ff       	call   801051c0 <argstr>
80105b39:	83 c4 10             	add    $0x10,%esp
80105b3c:	85 c0                	test   %eax,%eax
80105b3e:	78 60                	js     80105ba0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105b40:	83 ec 08             	sub    $0x8,%esp
80105b43:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b46:	50                   	push   %eax
80105b47:	6a 01                	push   $0x1
80105b49:	e8 c2 f5 ff ff       	call   80105110 <argint>
  if((argstr(0, &path)) < 0 ||
80105b4e:	83 c4 10             	add    $0x10,%esp
80105b51:	85 c0                	test   %eax,%eax
80105b53:	78 4b                	js     80105ba0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105b55:	83 ec 08             	sub    $0x8,%esp
80105b58:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b5b:	50                   	push   %eax
80105b5c:	6a 02                	push   $0x2
80105b5e:	e8 ad f5 ff ff       	call   80105110 <argint>
     argint(1, &major) < 0 ||
80105b63:	83 c4 10             	add    $0x10,%esp
80105b66:	85 c0                	test   %eax,%eax
80105b68:	78 36                	js     80105ba0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105b6a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105b6e:	83 ec 0c             	sub    $0xc,%esp
80105b71:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105b75:	ba 03 00 00 00       	mov    $0x3,%edx
80105b7a:	50                   	push   %eax
80105b7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105b7e:	e8 1d f7 ff ff       	call   801052a0 <create>
     argint(2, &minor) < 0 ||
80105b83:	83 c4 10             	add    $0x10,%esp
80105b86:	85 c0                	test   %eax,%eax
80105b88:	74 16                	je     80105ba0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105b8a:	83 ec 0c             	sub    $0xc,%esp
80105b8d:	50                   	push   %eax
80105b8e:	e8 ed be ff ff       	call   80101a80 <iunlockput>
  end_op();
80105b93:	e8 18 d3 ff ff       	call   80102eb0 <end_op>
  return 0;
80105b98:	83 c4 10             	add    $0x10,%esp
80105b9b:	31 c0                	xor    %eax,%eax
}
80105b9d:	c9                   	leave
80105b9e:	c3                   	ret
80105b9f:	90                   	nop
    end_op();
80105ba0:	e8 0b d3 ff ff       	call   80102eb0 <end_op>
    return -1;
80105ba5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105baa:	c9                   	leave
80105bab:	c3                   	ret
80105bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105bb0 <sys_chdir>:

int
sys_chdir(void)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	56                   	push   %esi
80105bb4:	53                   	push   %ebx
80105bb5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105bb8:	e8 03 de ff ff       	call   801039c0 <myproc>
80105bbd:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105bbf:	e8 7c d2 ff ff       	call   80102e40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105bc4:	83 ec 08             	sub    $0x8,%esp
80105bc7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105bca:	50                   	push   %eax
80105bcb:	6a 00                	push   $0x0
80105bcd:	e8 ee f5 ff ff       	call   801051c0 <argstr>
80105bd2:	83 c4 10             	add    $0x10,%esp
80105bd5:	85 c0                	test   %eax,%eax
80105bd7:	78 77                	js     80105c50 <sys_chdir+0xa0>
80105bd9:	83 ec 0c             	sub    $0xc,%esp
80105bdc:	ff 75 f4             	push   -0xc(%ebp)
80105bdf:	e8 1c c5 ff ff       	call   80102100 <namei>
80105be4:	83 c4 10             	add    $0x10,%esp
80105be7:	89 c3                	mov    %eax,%ebx
80105be9:	85 c0                	test   %eax,%eax
80105beb:	74 63                	je     80105c50 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105bed:	83 ec 0c             	sub    $0xc,%esp
80105bf0:	50                   	push   %eax
80105bf1:	e8 fa bb ff ff       	call   801017f0 <ilock>
  if(ip->type != T_DIR){
80105bf6:	83 c4 10             	add    $0x10,%esp
80105bf9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bfe:	75 30                	jne    80105c30 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105c00:	83 ec 0c             	sub    $0xc,%esp
80105c03:	53                   	push   %ebx
80105c04:	e8 c7 bc ff ff       	call   801018d0 <iunlock>
  iput(curproc->cwd);
80105c09:	58                   	pop    %eax
80105c0a:	ff 76 68             	push   0x68(%esi)
80105c0d:	e8 0e bd ff ff       	call   80101920 <iput>
  end_op();
80105c12:	e8 99 d2 ff ff       	call   80102eb0 <end_op>
  curproc->cwd = ip;
80105c17:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105c1a:	83 c4 10             	add    $0x10,%esp
80105c1d:	31 c0                	xor    %eax,%eax
}
80105c1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105c22:	5b                   	pop    %ebx
80105c23:	5e                   	pop    %esi
80105c24:	5d                   	pop    %ebp
80105c25:	c3                   	ret
80105c26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c2d:	00 
80105c2e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105c30:	83 ec 0c             	sub    $0xc,%esp
80105c33:	53                   	push   %ebx
80105c34:	e8 47 be ff ff       	call   80101a80 <iunlockput>
    end_op();
80105c39:	e8 72 d2 ff ff       	call   80102eb0 <end_op>
    return -1;
80105c3e:	83 c4 10             	add    $0x10,%esp
    return -1;
80105c41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c46:	eb d7                	jmp    80105c1f <sys_chdir+0x6f>
80105c48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c4f:	00 
    end_op();
80105c50:	e8 5b d2 ff ff       	call   80102eb0 <end_op>
    return -1;
80105c55:	eb ea                	jmp    80105c41 <sys_chdir+0x91>
80105c57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c5e:	00 
80105c5f:	90                   	nop

80105c60 <sys_exec>:

int
sys_exec(void)
{
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	57                   	push   %edi
80105c64:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105c65:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105c6b:	53                   	push   %ebx
80105c6c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105c72:	50                   	push   %eax
80105c73:	6a 00                	push   $0x0
80105c75:	e8 46 f5 ff ff       	call   801051c0 <argstr>
80105c7a:	83 c4 10             	add    $0x10,%esp
80105c7d:	85 c0                	test   %eax,%eax
80105c7f:	0f 88 87 00 00 00    	js     80105d0c <sys_exec+0xac>
80105c85:	83 ec 08             	sub    $0x8,%esp
80105c88:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105c8e:	50                   	push   %eax
80105c8f:	6a 01                	push   $0x1
80105c91:	e8 7a f4 ff ff       	call   80105110 <argint>
80105c96:	83 c4 10             	add    $0x10,%esp
80105c99:	85 c0                	test   %eax,%eax
80105c9b:	78 6f                	js     80105d0c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105c9d:	83 ec 04             	sub    $0x4,%esp
80105ca0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105ca6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105ca8:	68 80 00 00 00       	push   $0x80
80105cad:	6a 00                	push   $0x0
80105caf:	56                   	push   %esi
80105cb0:	e8 8b f1 ff ff       	call   80104e40 <memset>
80105cb5:	83 c4 10             	add    $0x10,%esp
80105cb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cbf:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105cc0:	83 ec 08             	sub    $0x8,%esp
80105cc3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105cc9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105cd0:	50                   	push   %eax
80105cd1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105cd7:	01 f8                	add    %edi,%eax
80105cd9:	50                   	push   %eax
80105cda:	e8 91 f3 ff ff       	call   80105070 <fetchint>
80105cdf:	83 c4 10             	add    $0x10,%esp
80105ce2:	85 c0                	test   %eax,%eax
80105ce4:	78 26                	js     80105d0c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105ce6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105cec:	85 c0                	test   %eax,%eax
80105cee:	74 30                	je     80105d20 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105cf0:	83 ec 08             	sub    $0x8,%esp
80105cf3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105cf6:	52                   	push   %edx
80105cf7:	50                   	push   %eax
80105cf8:	e8 b3 f3 ff ff       	call   801050b0 <fetchstr>
80105cfd:	83 c4 10             	add    $0x10,%esp
80105d00:	85 c0                	test   %eax,%eax
80105d02:	78 08                	js     80105d0c <sys_exec+0xac>
  for(i=0;; i++){
80105d04:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105d07:	83 fb 20             	cmp    $0x20,%ebx
80105d0a:	75 b4                	jne    80105cc0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105d0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105d0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d14:	5b                   	pop    %ebx
80105d15:	5e                   	pop    %esi
80105d16:	5f                   	pop    %edi
80105d17:	5d                   	pop    %ebp
80105d18:	c3                   	ret
80105d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105d20:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105d27:	00 00 00 00 
  return exec(path, argv);
80105d2b:	83 ec 08             	sub    $0x8,%esp
80105d2e:	56                   	push   %esi
80105d2f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105d35:	e8 b6 ad ff ff       	call   80100af0 <exec>
80105d3a:	83 c4 10             	add    $0x10,%esp
}
80105d3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d40:	5b                   	pop    %ebx
80105d41:	5e                   	pop    %esi
80105d42:	5f                   	pop    %edi
80105d43:	5d                   	pop    %ebp
80105d44:	c3                   	ret
80105d45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d4c:	00 
80105d4d:	8d 76 00             	lea    0x0(%esi),%esi

80105d50 <sys_pipe>:

int
sys_pipe(void)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	57                   	push   %edi
80105d54:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105d55:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105d58:	53                   	push   %ebx
80105d59:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105d5c:	6a 08                	push   $0x8
80105d5e:	50                   	push   %eax
80105d5f:	6a 00                	push   $0x0
80105d61:	e8 fa f3 ff ff       	call   80105160 <argptr>
80105d66:	83 c4 10             	add    $0x10,%esp
80105d69:	85 c0                	test   %eax,%eax
80105d6b:	0f 88 93 00 00 00    	js     80105e04 <sys_pipe+0xb4>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105d71:	83 ec 08             	sub    $0x8,%esp
80105d74:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d77:	50                   	push   %eax
80105d78:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d7b:	50                   	push   %eax
80105d7c:	e8 7f d7 ff ff       	call   80103500 <pipealloc>
80105d81:	83 c4 10             	add    $0x10,%esp
80105d84:	85 c0                	test   %eax,%eax
80105d86:	78 7c                	js     80105e04 <sys_pipe+0xb4>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105d88:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105d8b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105d8d:	e8 2e dc ff ff       	call   801039c0 <myproc>
    if(curproc->ofile[fd] == 0){
80105d92:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105d96:	85 f6                	test   %esi,%esi
80105d98:	74 16                	je     80105db0 <sys_pipe+0x60>
80105d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105da0:	83 c3 01             	add    $0x1,%ebx
80105da3:	83 fb 10             	cmp    $0x10,%ebx
80105da6:	74 45                	je     80105ded <sys_pipe+0x9d>
    if(curproc->ofile[fd] == 0){
80105da8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105dac:	85 f6                	test   %esi,%esi
80105dae:	75 f0                	jne    80105da0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105db0:	8d 73 08             	lea    0x8(%ebx),%esi
80105db3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105db7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105dba:	e8 01 dc ff ff       	call   801039c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105dbf:	31 d2                	xor    %edx,%edx
80105dc1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105dc8:	00 
80105dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105dd0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105dd4:	85 c9                	test   %ecx,%ecx
80105dd6:	74 38                	je     80105e10 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80105dd8:	83 c2 01             	add    $0x1,%edx
80105ddb:	83 fa 10             	cmp    $0x10,%edx
80105dde:	75 f0                	jne    80105dd0 <sys_pipe+0x80>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105de0:	e8 db db ff ff       	call   801039c0 <myproc>
80105de5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105dec:	00 
    fileclose(rf);
80105ded:	83 ec 0c             	sub    $0xc,%esp
80105df0:	ff 75 e0             	push   -0x20(%ebp)
80105df3:	e8 68 b1 ff ff       	call   80100f60 <fileclose>
    fileclose(wf);
80105df8:	58                   	pop    %eax
80105df9:	ff 75 e4             	push   -0x1c(%ebp)
80105dfc:	e8 5f b1 ff ff       	call   80100f60 <fileclose>
    return -1;
80105e01:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e09:	eb 16                	jmp    80105e21 <sys_pipe+0xd1>
80105e0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105e10:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105e14:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105e17:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105e19:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105e1c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105e1f:	31 c0                	xor    %eax,%eax
}
80105e21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e24:	5b                   	pop    %ebx
80105e25:	5e                   	pop    %esi
80105e26:	5f                   	pop    %edi
80105e27:	5d                   	pop    %ebp
80105e28:	c3                   	ret
80105e29:	66 90                	xchg   %ax,%ax
80105e2b:	66 90                	xchg   %ax,%ax
80105e2d:	66 90                	xchg   %ax,%ax
80105e2f:	90                   	nop

80105e30 <sys_fork>:
int waitx(int *wtime, int *rtime);

int
sys_fork(void)
{
  return fork();
80105e30:	e9 5b de ff ff       	jmp    80103c90 <fork>
80105e35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e3c:	00 
80105e3d:	8d 76 00             	lea    0x0(%esi),%esi

80105e40 <sys_exit>:
}

int
sys_exit(void)
{
80105e40:	55                   	push   %ebp
80105e41:	89 e5                	mov    %esp,%ebp
80105e43:	83 ec 08             	sub    $0x8,%esp
  exit();
80105e46:	e8 85 e2 ff ff       	call   801040d0 <exit>
80105e4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105e50 <sys_wait>:
}

int
sys_wait(void)
{
  return wait();
80105e50:	e9 eb e3 ff ff       	jmp    80104240 <wait>
80105e55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e5c:	00 
80105e5d:	8d 76 00             	lea    0x0(%esi),%esi

80105e60 <sys_kill>:
}

int
sys_kill(void)
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	83 ec 20             	sub    $0x20,%esp
  int pid;
  if(argint(0, &pid) < 0)
80105e66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e69:	50                   	push   %eax
80105e6a:	6a 00                	push   $0x0
80105e6c:	e8 9f f2 ff ff       	call   80105110 <argint>
80105e71:	83 c4 10             	add    $0x10,%esp
80105e74:	85 c0                	test   %eax,%eax
80105e76:	78 18                	js     80105e90 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105e78:	83 ec 0c             	sub    $0xc,%esp
80105e7b:	ff 75 f4             	push   -0xc(%ebp)
80105e7e:	e8 fd e7 ff ff       	call   80104680 <kill>
80105e83:	83 c4 10             	add    $0x10,%esp
}
80105e86:	c9                   	leave
80105e87:	c3                   	ret
80105e88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e8f:	00 
80105e90:	c9                   	leave
    return -1;
80105e91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e96:	c3                   	ret
80105e97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e9e:	00 
80105e9f:	90                   	nop

80105ea0 <sys_getpid>:

int
sys_getpid(void)
{
80105ea0:	55                   	push   %ebp
80105ea1:	89 e5                	mov    %esp,%ebp
80105ea3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105ea6:	e8 15 db ff ff       	call   801039c0 <myproc>
80105eab:	8b 40 10             	mov    0x10(%eax),%eax
}
80105eae:	c9                   	leave
80105eaf:	c3                   	ret

80105eb0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	53                   	push   %ebx
  int addr, n;
  if(argint(0, &n) < 0)
80105eb4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105eb7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105eba:	50                   	push   %eax
80105ebb:	6a 00                	push   $0x0
80105ebd:	e8 4e f2 ff ff       	call   80105110 <argint>
80105ec2:	83 c4 10             	add    $0x10,%esp
80105ec5:	85 c0                	test   %eax,%eax
80105ec7:	78 27                	js     80105ef0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105ec9:	e8 f2 da ff ff       	call   801039c0 <myproc>
  if(growproc(n) < 0)
80105ece:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105ed1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105ed3:	ff 75 f4             	push   -0xc(%ebp)
80105ed6:	e8 35 dd ff ff       	call   80103c10 <growproc>
80105edb:	83 c4 10             	add    $0x10,%esp
80105ede:	85 c0                	test   %eax,%eax
80105ee0:	78 0e                	js     80105ef0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105ee2:	89 d8                	mov    %ebx,%eax
80105ee4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ee7:	c9                   	leave
80105ee8:	c3                   	ret
80105ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ef0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ef5:	eb eb                	jmp    80105ee2 <sys_sbrk+0x32>
80105ef7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105efe:	00 
80105eff:	90                   	nop

80105f00 <sys_sleep>:

int
sys_sleep(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)  // n را بگیر
80105f04:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105f07:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)  // n را بگیر
80105f0a:	50                   	push   %eax
80105f0b:	6a 00                	push   $0x0
80105f0d:	e8 fe f1 ff ff       	call   80105110 <argint>
    return -1;
  if(n < 0)              // گارد منفی‌بودن
80105f12:	83 c4 10             	add    $0x10,%esp
80105f15:	0b 45 f4             	or     -0xc(%ebp),%eax
80105f18:	78 63                	js     80105f7d <sys_sleep+0x7d>
    return -1;

  acquire(&tickslock);
80105f1a:	83 ec 0c             	sub    $0xc,%esp
80105f1d:	68 40 55 11 80       	push   $0x80115540
80105f22:	e8 79 ec ff ff       	call   80104ba0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < (uint)n){
80105f27:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105f2a:	8b 1d 20 55 11 80    	mov    0x80115520,%ebx
  while(ticks - ticks0 < (uint)n){
80105f30:	83 c4 10             	add    $0x10,%esp
80105f33:	85 d2                	test   %edx,%edx
80105f35:	75 2a                	jne    80105f61 <sys_sleep+0x61>
80105f37:	eb 4f                	jmp    80105f88 <sys_sleep+0x88>
80105f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105f40:	83 ec 08             	sub    $0x8,%esp
80105f43:	68 40 55 11 80       	push   $0x80115540
80105f48:	68 20 55 11 80       	push   $0x80115520
80105f4d:	e8 fe e5 ff ff       	call   80104550 <sleep>
  while(ticks - ticks0 < (uint)n){
80105f52:	a1 20 55 11 80       	mov    0x80115520,%eax
80105f57:	83 c4 10             	add    $0x10,%esp
80105f5a:	29 d8                	sub    %ebx,%eax
80105f5c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105f5f:	73 27                	jae    80105f88 <sys_sleep+0x88>
    if(myproc()->killed){
80105f61:	e8 5a da ff ff       	call   801039c0 <myproc>
80105f66:	8b 40 24             	mov    0x24(%eax),%eax
80105f69:	85 c0                	test   %eax,%eax
80105f6b:	74 d3                	je     80105f40 <sys_sleep+0x40>
      release(&tickslock);
80105f6d:	83 ec 0c             	sub    $0xc,%esp
80105f70:	68 40 55 11 80       	push   $0x80115540
80105f75:	e8 a6 ed ff ff       	call   80104d20 <release>
      return -1;
80105f7a:	83 c4 10             	add    $0x10,%esp
    return -1;
80105f7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f82:	eb 16                	jmp    80105f9a <sys_sleep+0x9a>
80105f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  release(&tickslock);
80105f88:	83 ec 0c             	sub    $0xc,%esp
80105f8b:	68 40 55 11 80       	push   $0x80115540
80105f90:	e8 8b ed ff ff       	call   80104d20 <release>
  return 0;
80105f95:	83 c4 10             	add    $0x10,%esp
80105f98:	31 c0                	xor    %eax,%eax
}
80105f9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f9d:	c9                   	leave
80105f9e:	c3                   	ret
80105f9f:	90                   	nop

80105fa0 <sys_uptime>:

// tickets from start
int
sys_uptime(void)
{
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
80105fa3:	53                   	push   %ebx
80105fa4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;
  acquire(&tickslock);
80105fa7:	68 40 55 11 80       	push   $0x80115540
80105fac:	e8 ef eb ff ff       	call   80104ba0 <acquire>
  xticks = ticks;
80105fb1:	8b 1d 20 55 11 80    	mov    0x80115520,%ebx
  release(&tickslock);
80105fb7:	c7 04 24 40 55 11 80 	movl   $0x80115540,(%esp)
80105fbe:	e8 5d ed ff ff       	call   80104d20 <release>
  return xticks;
}
80105fc3:	89 d8                	mov    %ebx,%eax
80105fc5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105fc8:	c9                   	leave
80105fc9:	c3                   	ret
80105fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105fd0 <sys_settickets>:

/* ===== syscalls افزوده‌شده به زمان‌بند ===== */

int
sys_settickets(void)
{
80105fd0:	55                   	push   %ebp
80105fd1:	89 e5                	mov    %esp,%ebp
80105fd3:	83 ec 20             	sub    $0x20,%esp
  int n;
  if(argint(0, &n) < 0)
80105fd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fd9:	50                   	push   %eax
80105fda:	6a 00                	push   $0x0
80105fdc:	e8 2f f1 ff ff       	call   80105110 <argint>
80105fe1:	83 c4 10             	add    $0x10,%esp
80105fe4:	85 c0                	test   %eax,%eax
80105fe6:	78 18                	js     80106000 <sys_settickets+0x30>
    return -1;
  if(n <= 0)            // گارد مقدار نامعتبر
80105fe8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105feb:	85 c0                	test   %eax,%eax
80105fed:	7e 11                	jle    80106000 <sys_settickets+0x30>
    return -1;
  return settickets(n);
80105fef:	83 ec 0c             	sub    $0xc,%esp
80105ff2:	50                   	push   %eax
80105ff3:	e8 08 e8 ff ff       	call   80104800 <settickets>
80105ff8:	83 c4 10             	add    $0x10,%esp
}
80105ffb:	c9                   	leave
80105ffc:	c3                   	ret
80105ffd:	8d 76 00             	lea    0x0(%esi),%esi
80106000:	c9                   	leave
    return -1;
80106001:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106006:	c3                   	ret
80106007:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010600e:	00 
8010600f:	90                   	nop

80106010 <sys_setpolicy>:

int
sys_setpolicy(void)
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	83 ec 20             	sub    $0x20,%esp
  int p;
  if(argint(0, &p) < 0)
80106016:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106019:	50                   	push   %eax
8010601a:	6a 00                	push   $0x0
8010601c:	e8 ef f0 ff ff       	call   80105110 <argint>
80106021:	83 c4 10             	add    $0x10,%esp
80106024:	85 c0                	test   %eax,%eax
80106026:	78 18                	js     80106040 <sys_setpolicy+0x30>
    return -1;
  // گارد: فقط سیاست‌های شناخته‌شده  (مثلاً 0=RR, 1=LBS, 2=PBS)
  if(p < 0 || p > 2)
80106028:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010602b:	83 f8 02             	cmp    $0x2,%eax
8010602e:	77 10                	ja     80106040 <sys_setpolicy+0x30>
    return -1;
  return setpolicy(p);
80106030:	83 ec 0c             	sub    $0xc,%esp
80106033:	50                   	push   %eax
80106034:	e8 a7 e7 ff ff       	call   801047e0 <setpolicy>
80106039:	83 c4 10             	add    $0x10,%esp
}
8010603c:	c9                   	leave
8010603d:	c3                   	ret
8010603e:	66 90                	xchg   %ax,%ax
80106040:	c9                   	leave
    return -1;
80106041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106046:	c3                   	ret
80106047:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010604e:	00 
8010604f:	90                   	nop

80106050 <sys_getpinfo>:

int
sys_getpinfo(void)
{
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	83 ec 1c             	sub    $0x1c,%esp
  struct pstat *ps;
  if(argptr(0, (void*)&ps, sizeof(*ps)) < 0) // اعتبارسنجی و طول صحیح
80106056:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106059:	68 00 0e 00 00       	push   $0xe00
8010605e:	50                   	push   %eax
8010605f:	6a 00                	push   $0x0
80106061:	e8 fa f0 ff ff       	call   80105160 <argptr>
80106066:	83 c4 10             	add    $0x10,%esp
80106069:	85 c0                	test   %eax,%eax
8010606b:	78 1b                	js     80106088 <sys_getpinfo+0x38>
    return -1;
  if(ps == 0)  // گارد Null
8010606d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106070:	85 c0                	test   %eax,%eax
80106072:	74 14                	je     80106088 <sys_getpinfo+0x38>
    return -1;
  return getpinfo(ps);
80106074:	83 ec 0c             	sub    $0xc,%esp
80106077:	50                   	push   %eax
80106078:	e8 e3 e7 ff ff       	call   80104860 <getpinfo>
8010607d:	83 c4 10             	add    $0x10,%esp
}
80106080:	c9                   	leave
80106081:	c3                   	ret
80106082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106088:	c9                   	leave
    return -1;
80106089:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010608e:	c3                   	ret
8010608f:	90                   	nop

80106090 <sys_waitx>:

int
sys_waitx(void)
{
80106090:	55                   	push   %ebp
80106091:	89 e5                	mov    %esp,%ebp
80106093:	83 ec 1c             	sub    $0x1c,%esp
  int *w, *r;
  if(argptr(0, (void*)&w, sizeof(*w)) < 0 || w == 0)
80106096:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106099:	6a 04                	push   $0x4
8010609b:	50                   	push   %eax
8010609c:	6a 00                	push   $0x0
8010609e:	e8 bd f0 ff ff       	call   80105160 <argptr>
801060a3:	83 c4 10             	add    $0x10,%esp
801060a6:	85 c0                	test   %eax,%eax
801060a8:	78 36                	js     801060e0 <sys_waitx+0x50>
801060aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060ad:	85 c0                	test   %eax,%eax
801060af:	74 2f                	je     801060e0 <sys_waitx+0x50>
    return -1;
  if(argptr(1, (void*)&r, sizeof(*r)) < 0 || r == 0)
801060b1:	83 ec 04             	sub    $0x4,%esp
801060b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060b7:	6a 04                	push   $0x4
801060b9:	50                   	push   %eax
801060ba:	6a 01                	push   $0x1
801060bc:	e8 9f f0 ff ff       	call   80105160 <argptr>
801060c1:	83 c4 10             	add    $0x10,%esp
801060c4:	85 c0                	test   %eax,%eax
801060c6:	78 18                	js     801060e0 <sys_waitx+0x50>
801060c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060cb:	85 c0                	test   %eax,%eax
801060cd:	74 11                	je     801060e0 <sys_waitx+0x50>
    return -1;
  return waitx(w, r);
801060cf:	83 ec 08             	sub    $0x8,%esp
801060d2:	50                   	push   %eax
801060d3:	ff 75 f0             	push   -0x10(%ebp)
801060d6:	e8 a5 e2 ff ff       	call   80104380 <waitx>
801060db:	83 c4 10             	add    $0x10,%esp
}
801060de:	c9                   	leave
801060df:	c3                   	ret
801060e0:	c9                   	leave
    return -1;
801060e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060e6:	c3                   	ret
801060e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060ee:	00 
801060ef:	90                   	nop

801060f0 <sys_yield>:


int
sys_yield(void)
{
801060f0:	55                   	push   %ebp
801060f1:	89 e5                	mov    %esp,%ebp
801060f3:	83 ec 08             	sub    $0x8,%esp
  yield();
801060f6:	e8 05 e4 ff ff       	call   80104500 <yield>
  return 0;
}
801060fb:	31 c0                	xor    %eax,%eax
801060fd:	c9                   	leave
801060fe:	c3                   	ret

801060ff <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801060ff:	1e                   	push   %ds
  pushl %es
80106100:	06                   	push   %es
  pushl %fs
80106101:	0f a0                	push   %fs
  pushl %gs
80106103:	0f a8                	push   %gs
  pushal
80106105:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106106:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010610a:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010610c:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010610e:	54                   	push   %esp
  call trap
8010610f:	e8 0c 01 00 00       	call   80106220 <trap>
  addl $4, %esp
80106114:	83 c4 04             	add    $0x4,%esp

80106117 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106117:	61                   	popa
  popl %gs
80106118:	0f a9                	pop    %gs
  popl %fs
8010611a:	0f a1                	pop    %fs
  popl %es
8010611c:	07                   	pop    %es
  popl %ds
8010611d:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010611e:	83 c4 08             	add    $0x8,%esp
  iret
80106121:	cf                   	iret
80106122:	66 90                	xchg   %ax,%ax
80106124:	66 90                	xchg   %ax,%ax
80106126:	66 90                	xchg   %ax,%ax
80106128:	66 90                	xchg   %ax,%ax
8010612a:	66 90                	xchg   %ax,%ax
8010612c:	66 90                	xchg   %ax,%ax
8010612e:	66 90                	xchg   %ax,%ax
80106130:	66 90                	xchg   %ax,%ax
80106132:	66 90                	xchg   %ax,%ax
80106134:	66 90                	xchg   %ax,%ax
80106136:	66 90                	xchg   %ax,%ax
80106138:	66 90                	xchg   %ax,%ax
8010613a:	66 90                	xchg   %ax,%ax
8010613c:	66 90                	xchg   %ax,%ax
8010613e:	66 90                	xchg   %ax,%ax

80106140 <tvinit>:
  struct proc proc[NPROC];
} ptable;

void
tvinit(void)
{
80106140:	55                   	push   %ebp
  int i;
  for(i = 0; i < 256; i++)
80106141:	31 c0                	xor    %eax,%eax
{
80106143:	89 e5                	mov    %esp,%ebp
80106145:	83 ec 08             	sub    $0x8,%esp
80106148:	eb 36                	jmp    80106180 <tvinit+0x40>
8010614a:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106151:	00 
80106152:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106159:	00 
8010615a:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106161:	00 
80106162:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106169:	00 
8010616a:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106171:	00 
80106172:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106179:	00 
8010617a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106180:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80106187:	c7 04 c5 82 55 11 80 	movl   $0x8e000008,-0x7feeaa7e(,%eax,8)
8010618e:	08 00 00 8e 
80106192:	66 89 14 c5 80 55 11 	mov    %dx,-0x7feeaa80(,%eax,8)
80106199:	80 
8010619a:	c1 ea 10             	shr    $0x10,%edx
8010619d:	66 89 14 c5 86 55 11 	mov    %dx,-0x7feeaa7a(,%eax,8)
801061a4:	80 
  for(i = 0; i < 256; i++)
801061a5:	83 c0 01             	add    $0x1,%eax
801061a8:	3d 00 01 00 00       	cmp    $0x100,%eax
801061ad:	75 d1                	jne    80106180 <tvinit+0x40>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801061af:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801061b2:	a1 0c b1 10 80       	mov    0x8010b10c,%eax
801061b7:	c7 05 82 57 11 80 08 	movl   $0xef000008,0x80115782
801061be:	00 00 ef 
  initlock(&tickslock, "time");
801061c1:	68 45 7e 10 80       	push   $0x80107e45
801061c6:	68 40 55 11 80       	push   $0x80115540
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801061cb:	66 a3 80 57 11 80    	mov    %ax,0x80115780
801061d1:	c1 e8 10             	shr    $0x10,%eax
801061d4:	66 a3 86 57 11 80    	mov    %ax,0x80115786
  initlock(&tickslock, "time");
801061da:	e8 81 e8 ff ff       	call   80104a60 <initlock>
}
801061df:	83 c4 10             	add    $0x10,%esp
801061e2:	c9                   	leave
801061e3:	c3                   	ret
801061e4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061eb:	00 
801061ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801061f0 <idtinit>:

void
idtinit(void)
{
801061f0:	55                   	push   %ebp
  pd[0] = size-1;
801061f1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801061f6:	89 e5                	mov    %esp,%ebp
801061f8:	83 ec 10             	sub    $0x10,%esp
801061fb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801061ff:	b8 80 55 11 80       	mov    $0x80115580,%eax
80106204:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106208:	c1 e8 10             	shr    $0x10,%eax
8010620b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010620f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106212:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106215:	c9                   	leave
80106216:	c3                   	ret
80106217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010621e:	00 
8010621f:	90                   	nop

80106220 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106220:	55                   	push   %ebp
80106221:	89 e5                	mov    %esp,%ebp
80106223:	57                   	push   %edi
80106224:	56                   	push   %esi
80106225:	53                   	push   %ebx
80106226:	83 ec 1c             	sub    $0x1c,%esp
80106229:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();  // ممکن است NULL باشد
8010622c:	e8 8f d7 ff ff       	call   801039c0 <myproc>
80106231:	89 c6                	mov    %eax,%esi

  if(tf->trapno == T_SYSCALL){
80106233:	8b 43 30             	mov    0x30(%ebx),%eax
80106236:	83 f8 40             	cmp    $0x40,%eax
80106239:	74 45                	je     80106280 <trap+0x60>
    if(p && p->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010623b:	83 e8 20             	sub    $0x20,%eax
8010623e:	83 f8 1f             	cmp    $0x1f,%eax
80106241:	77 65                	ja     801062a8 <trap+0x88>
80106243:	ff 24 85 cc 83 10 80 	jmp    *-0x7fef7c34(,%eax,4)
8010624a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kbdintr();
    lapiceoi();
    break;

  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106250:	e8 9b 03 00 00       	call   801065f0 <uartintr>
    lapiceoi();
80106255:	e8 56 c7 ff ff       	call   801029b0 <lapiceoi>
            tf->err, cpuid(), tf->eip, rcr2());
    p->killed = 1;
  }

  // Force process exit if it has been killed and is in user space.
  if(p && p->killed && (tf->cs&3) == DPL_USER)
8010625a:	85 f6                	test   %esi,%esi
8010625c:	74 15                	je     80106273 <trap+0x53>
8010625e:	8b 56 24             	mov    0x24(%esi),%edx
80106261:	85 d2                	test   %edx,%edx
80106263:	0f 85 86 00 00 00    	jne    801062ef <trap+0xcf>
   *  - تله از نوع timer است
   *  - curpolicy() != 1  (1 = FCFS => غیرقابل‌پیش‌دستی)
   *
   * توجه: yield() خودش ptable.lock را می‌گیرد. در اینجا ما قفل‌ها را آزاد کرده‌ایم.
   */
  if(p && p->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER){
80106269:	83 7e 0c 04          	cmpl   $0x4,0xc(%esi)
8010626d:	0f 84 90 00 00 00    	je     80106303 <trap+0xe3>
  }

  // ممکن است بعد از yield یا syscall پردازه کشته شده باشد.
  if(p && p->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106273:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106276:	5b                   	pop    %ebx
80106277:	5e                   	pop    %esi
80106278:	5f                   	pop    %edi
80106279:	5d                   	pop    %ebp
8010627a:	c3                   	ret
8010627b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p && p->killed)
80106280:	85 f6                	test   %esi,%esi
80106282:	0f 84 a8 01 00 00    	je     80106430 <trap+0x210>
80106288:	8b 7e 24             	mov    0x24(%esi),%edi
8010628b:	85 ff                	test   %edi,%edi
8010628d:	75 0f                	jne    8010629e <trap+0x7e>
      p->tf = tf;
8010628f:	89 5e 18             	mov    %ebx,0x18(%esi)
    syscall();
80106292:	e8 99 ef ff ff       	call   80105230 <syscall>
    if(p && p->killed)
80106297:	8b 4e 24             	mov    0x24(%esi),%ecx
8010629a:	85 c9                	test   %ecx,%ecx
8010629c:	74 d5                	je     80106273 <trap+0x53>
      exit();
8010629e:	e8 2d de ff ff       	call   801040d0 <exit>
801062a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801062a8:	8b 7b 38             	mov    0x38(%ebx),%edi
    if(p == 0 || (tf->cs&3) == 0){
801062ab:	85 f6                	test   %esi,%esi
801062ad:	0f 84 a2 01 00 00    	je     80106455 <trap+0x235>
801062b3:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801062b7:	0f 84 98 01 00 00    	je     80106455 <trap+0x235>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801062bd:	0f 20 d2             	mov    %cr2,%edx
801062c0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801062c3:	e8 d8 d6 ff ff       	call   801039a0 <cpuid>
801062c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801062cb:	52                   	push   %edx
801062cc:	57                   	push   %edi
801062cd:	50                   	push   %eax
            p->pid, p->name, tf->trapno,
801062ce:	8d 46 6c             	lea    0x6c(%esi),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801062d1:	ff 73 34             	push   0x34(%ebx)
801062d4:	ff 73 30             	push   0x30(%ebx)
801062d7:	50                   	push   %eax
801062d8:	ff 76 10             	push   0x10(%esi)
801062db:	68 a0 80 10 80       	push   $0x801080a0
801062e0:	e8 eb a3 ff ff       	call   801006d0 <cprintf>
    p->killed = 1;
801062e5:	c7 46 24 01 00 00 00 	movl   $0x1,0x24(%esi)
801062ec:	83 c4 20             	add    $0x20,%esp
  if(p && p->killed && (tf->cs&3) == DPL_USER)
801062ef:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801062f3:	f7 d0                	not    %eax
801062f5:	a8 03                	test   $0x3,%al
801062f7:	74 a5                	je     8010629e <trap+0x7e>
  if(p && p->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER){
801062f9:	83 7e 0c 04          	cmpl   $0x4,0xc(%esi)
801062fd:	0f 85 70 ff ff ff    	jne    80106273 <trap+0x53>
80106303:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106307:	0f 84 03 01 00 00    	je     80106410 <trap+0x1f0>
  if(p && p->killed && (tf->cs&3) == DPL_USER)
8010630d:	8b 46 24             	mov    0x24(%esi),%eax
80106310:	85 c0                	test   %eax,%eax
80106312:	0f 84 5b ff ff ff    	je     80106273 <trap+0x53>
80106318:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010631c:	f7 d0                	not    %eax
8010631e:	a8 03                	test   $0x3,%al
80106320:	0f 85 4d ff ff ff    	jne    80106273 <trap+0x53>
80106326:	e9 73 ff ff ff       	jmp    8010629e <trap+0x7e>
8010632b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106330:	8b 53 38             	mov    0x38(%ebx),%edx
80106333:	0f b7 7b 3c          	movzwl 0x3c(%ebx),%edi
80106337:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010633a:	e8 61 d6 ff ff       	call   801039a0 <cpuid>
8010633f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106342:	52                   	push   %edx
80106343:	57                   	push   %edi
80106344:	50                   	push   %eax
80106345:	68 48 80 10 80       	push   $0x80108048
8010634a:	e8 81 a3 ff ff       	call   801006d0 <cprintf>
    lapiceoi();
8010634f:	e8 5c c6 ff ff       	call   801029b0 <lapiceoi>
    break;
80106354:	83 c4 10             	add    $0x10,%esp
80106357:	e9 fe fe ff ff       	jmp    8010625a <trap+0x3a>
8010635c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106360:	e8 3b bf ff ff       	call   801022a0 <ideintr>
    lapiceoi();
80106365:	e8 46 c6 ff ff       	call   801029b0 <lapiceoi>
    break;
8010636a:	e9 eb fe ff ff       	jmp    8010625a <trap+0x3a>
8010636f:	90                   	nop
    kbdintr();
80106370:	e8 fb c4 ff ff       	call   80102870 <kbdintr>
    lapiceoi();
80106375:	e8 36 c6 ff ff       	call   801029b0 <lapiceoi>
    break;
8010637a:	e9 db fe ff ff       	jmp    8010625a <trap+0x3a>
8010637f:	90                   	nop
    if(cpuid() == 0){
80106380:	e8 1b d6 ff ff       	call   801039a0 <cpuid>
80106385:	85 c0                	test   %eax,%eax
80106387:	0f 85 c8 fe ff ff    	jne    80106255 <trap+0x35>
      acquire(&tickslock);
8010638d:	83 ec 0c             	sub    $0xc,%esp
80106390:	68 40 55 11 80       	push   $0x80115540
80106395:	e8 06 e8 ff ff       	call   80104ba0 <acquire>
      ticks++;
8010639a:	83 05 20 55 11 80 01 	addl   $0x1,0x80115520
      wakeup(&ticks);
801063a1:	c7 04 24 20 55 11 80 	movl   $0x80115520,(%esp)
801063a8:	e8 63 e2 ff ff       	call   80104610 <wakeup>
      release(&tickslock);
801063ad:	c7 04 24 40 55 11 80 	movl   $0x80115540,(%esp)
801063b4:	e8 67 e9 ff ff       	call   80104d20 <release>
      acquire(&ptable.lock);
801063b9:	c7 04 24 e0 2e 11 80 	movl   $0x80112ee0,(%esp)
801063c0:	e8 db e7 ff ff       	call   80104ba0 <acquire>
801063c5:	83 c4 10             	add    $0x10,%esp
      for(struct proc *q = ptable.proc; q < &ptable.proc[NPROC]; q++){
801063c8:	b8 14 2f 11 80       	mov    $0x80112f14,%eax
801063cd:	eb 19                	jmp    801063e8 <trap+0x1c8>
801063cf:	90                   	nop
        switch(q->state){
801063d0:	83 fa 02             	cmp    $0x2,%edx
801063d3:	75 07                	jne    801063dc <trap+0x1bc>
          q->stime++;
801063d5:	83 80 88 00 00 00 01 	addl   $0x1,0x88(%eax)
      for(struct proc *q = ptable.proc; q < &ptable.proc[NPROC]; q++){
801063dc:	05 98 00 00 00       	add    $0x98,%eax
801063e1:	3d 14 55 11 80       	cmp    $0x80115514,%eax
801063e6:	74 58                	je     80106440 <trap+0x220>
        switch(q->state){
801063e8:	8b 50 0c             	mov    0xc(%eax),%edx
801063eb:	83 fa 03             	cmp    $0x3,%edx
801063ee:	74 10                	je     80106400 <trap+0x1e0>
801063f0:	83 fa 04             	cmp    $0x4,%edx
801063f3:	75 db                	jne    801063d0 <trap+0x1b0>
          q->rtime++;
801063f5:	83 80 84 00 00 00 01 	addl   $0x1,0x84(%eax)
          break;
801063fc:	eb de                	jmp    801063dc <trap+0x1bc>
801063fe:	66 90                	xchg   %ax,%ax
          q->retime++;
80106400:	83 80 8c 00 00 00 01 	addl   $0x1,0x8c(%eax)
          break;
80106407:	eb d3                	jmp    801063dc <trap+0x1bc>
80106409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curpolicy() != 1) {
80106410:	e8 fb d4 ff ff       	call   80103910 <curpolicy>
80106415:	83 f8 01             	cmp    $0x1,%eax
80106418:	0f 84 ef fe ff ff    	je     8010630d <trap+0xed>
      yield();
8010641e:	e8 dd e0 ff ff       	call   80104500 <yield>
80106423:	e9 e5 fe ff ff       	jmp    8010630d <trap+0xed>
80106428:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010642f:	00 
}
80106430:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106433:	5b                   	pop    %ebx
80106434:	5e                   	pop    %esi
80106435:	5f                   	pop    %edi
80106436:	5d                   	pop    %ebp
    syscall();
80106437:	e9 f4 ed ff ff       	jmp    80105230 <syscall>
8010643c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
80106440:	83 ec 0c             	sub    $0xc,%esp
80106443:	68 e0 2e 11 80       	push   $0x80112ee0
80106448:	e8 d3 e8 ff ff       	call   80104d20 <release>
8010644d:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106450:	e9 00 fe ff ff       	jmp    80106255 <trap+0x35>
80106455:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106458:	e8 43 d5 ff ff       	call   801039a0 <cpuid>
8010645d:	83 ec 0c             	sub    $0xc,%esp
80106460:	56                   	push   %esi
80106461:	57                   	push   %edi
80106462:	50                   	push   %eax
80106463:	ff 73 30             	push   0x30(%ebx)
80106466:	68 6c 80 10 80       	push   $0x8010806c
8010646b:	e8 60 a2 ff ff       	call   801006d0 <cprintf>
      panic("trap");
80106470:	83 c4 14             	add    $0x14,%esp
80106473:	68 4a 7e 10 80       	push   $0x80107e4a
80106478:	e8 23 9f ff ff       	call   801003a0 <panic>
8010647d:	66 90                	xchg   %ax,%ax
8010647f:	90                   	nop

80106480 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106480:	a1 80 5d 11 80       	mov    0x80115d80,%eax
80106485:	85 c0                	test   %eax,%eax
80106487:	74 17                	je     801064a0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106489:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010648e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010648f:	a8 01                	test   $0x1,%al
80106491:	74 0d                	je     801064a0 <uartgetc+0x20>
80106493:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106498:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106499:	0f b6 c0             	movzbl %al,%eax
8010649c:	c3                   	ret
8010649d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801064a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064a5:	c3                   	ret
801064a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801064ad:	00 
801064ae:	66 90                	xchg   %ax,%ax

801064b0 <uartinit>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801064b0:	31 c9                	xor    %ecx,%ecx
801064b2:	ba fa 03 00 00       	mov    $0x3fa,%edx
801064b7:	89 c8                	mov    %ecx,%eax
801064b9:	ee                   	out    %al,(%dx)
801064ba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801064bf:	ba fb 03 00 00       	mov    $0x3fb,%edx
801064c4:	ee                   	out    %al,(%dx)
801064c5:	b8 0c 00 00 00       	mov    $0xc,%eax
801064ca:	ba f8 03 00 00       	mov    $0x3f8,%edx
801064cf:	ee                   	out    %al,(%dx)
801064d0:	ba f9 03 00 00       	mov    $0x3f9,%edx
801064d5:	89 c8                	mov    %ecx,%eax
801064d7:	ee                   	out    %al,(%dx)
801064d8:	b8 03 00 00 00       	mov    $0x3,%eax
801064dd:	ba fb 03 00 00       	mov    $0x3fb,%edx
801064e2:	ee                   	out    %al,(%dx)
801064e3:	ba fc 03 00 00       	mov    $0x3fc,%edx
801064e8:	89 c8                	mov    %ecx,%eax
801064ea:	ee                   	out    %al,(%dx)
801064eb:	b8 01 00 00 00       	mov    $0x1,%eax
801064f0:	ba f9 03 00 00       	mov    $0x3f9,%edx
801064f5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801064f6:	ba fd 03 00 00       	mov    $0x3fd,%edx
801064fb:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801064fc:	3c ff                	cmp    $0xff,%al
801064fe:	0f 84 85 00 00 00    	je     80106589 <uartinit+0xd9>
{
80106504:	55                   	push   %ebp
80106505:	ba fa 03 00 00       	mov    $0x3fa,%edx
8010650a:	89 e5                	mov    %esp,%ebp
8010650c:	57                   	push   %edi
8010650d:	56                   	push   %esi
8010650e:	53                   	push   %ebx
8010650f:	83 ec 24             	sub    $0x24,%esp
  uart = 1;
80106512:	c7 05 80 5d 11 80 01 	movl   $0x1,0x80115d80
80106519:	00 00 00 
8010651c:	ec                   	in     (%dx),%al
8010651d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106522:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106523:	6a 00                	push   $0x0
  for(p="xv6...\n"; *p; p++)
80106525:	bf 4f 7e 10 80       	mov    $0x80107e4f,%edi
8010652a:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
8010652f:	6a 04                	push   $0x4
80106531:	e8 ca bf ff ff       	call   80102500 <ioapicenable>
80106536:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106539:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
8010653d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80106540:	a1 80 5d 11 80       	mov    0x80115d80,%eax
80106545:	bb 80 00 00 00       	mov    $0x80,%ebx
8010654a:	85 c0                	test   %eax,%eax
8010654c:	75 14                	jne    80106562 <uartinit+0xb2>
8010654e:	eb 23                	jmp    80106573 <uartinit+0xc3>
    microdelay(10);
80106550:	83 ec 0c             	sub    $0xc,%esp
80106553:	6a 0a                	push   $0xa
80106555:	e8 76 c4 ff ff       	call   801029d0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010655a:	83 c4 10             	add    $0x10,%esp
8010655d:	83 eb 01             	sub    $0x1,%ebx
80106560:	74 07                	je     80106569 <uartinit+0xb9>
80106562:	89 f2                	mov    %esi,%edx
80106564:	ec                   	in     (%dx),%al
80106565:	a8 20                	test   $0x20,%al
80106567:	74 e7                	je     80106550 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106569:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010656d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106572:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106573:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106577:	83 c7 01             	add    $0x1,%edi
8010657a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010657d:	84 c0                	test   %al,%al
8010657f:	75 bf                	jne    80106540 <uartinit+0x90>
}
80106581:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106584:	5b                   	pop    %ebx
80106585:	5e                   	pop    %esi
80106586:	5f                   	pop    %edi
80106587:	5d                   	pop    %ebp
80106588:	c3                   	ret
80106589:	c3                   	ret
8010658a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106590 <uartputc>:
  if(!uart)
80106590:	a1 80 5d 11 80       	mov    0x80115d80,%eax
80106595:	85 c0                	test   %eax,%eax
80106597:	74 47                	je     801065e0 <uartputc+0x50>
{
80106599:	55                   	push   %ebp
8010659a:	89 e5                	mov    %esp,%ebp
8010659c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010659d:	be fd 03 00 00       	mov    $0x3fd,%esi
801065a2:	53                   	push   %ebx
801065a3:	bb 80 00 00 00       	mov    $0x80,%ebx
801065a8:	eb 18                	jmp    801065c2 <uartputc+0x32>
801065aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801065b0:	83 ec 0c             	sub    $0xc,%esp
801065b3:	6a 0a                	push   $0xa
801065b5:	e8 16 c4 ff ff       	call   801029d0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801065ba:	83 c4 10             	add    $0x10,%esp
801065bd:	83 eb 01             	sub    $0x1,%ebx
801065c0:	74 07                	je     801065c9 <uartputc+0x39>
801065c2:	89 f2                	mov    %esi,%edx
801065c4:	ec                   	in     (%dx),%al
801065c5:	a8 20                	test   $0x20,%al
801065c7:	74 e7                	je     801065b0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801065c9:	8b 45 08             	mov    0x8(%ebp),%eax
801065cc:	ba f8 03 00 00       	mov    $0x3f8,%edx
801065d1:	ee                   	out    %al,(%dx)
}
801065d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801065d5:	5b                   	pop    %ebx
801065d6:	5e                   	pop    %esi
801065d7:	5d                   	pop    %ebp
801065d8:	c3                   	ret
801065d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065e0:	c3                   	ret
801065e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801065e8:	00 
801065e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801065f0 <uartintr>:

void
uartintr(void)
{
801065f0:	55                   	push   %ebp
801065f1:	89 e5                	mov    %esp,%ebp
801065f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801065f6:	68 80 64 10 80       	push   $0x80106480
801065fb:	e8 c0 a2 ff ff       	call   801008c0 <consoleintr>
}
80106600:	83 c4 10             	add    $0x10,%esp
80106603:	c9                   	leave
80106604:	c3                   	ret

80106605 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106605:	6a 00                	push   $0x0
  pushl $0
80106607:	6a 00                	push   $0x0
  jmp alltraps
80106609:	e9 f1 fa ff ff       	jmp    801060ff <alltraps>

8010660e <vector1>:
.globl vector1
vector1:
  pushl $0
8010660e:	6a 00                	push   $0x0
  pushl $1
80106610:	6a 01                	push   $0x1
  jmp alltraps
80106612:	e9 e8 fa ff ff       	jmp    801060ff <alltraps>

80106617 <vector2>:
.globl vector2
vector2:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $2
80106619:	6a 02                	push   $0x2
  jmp alltraps
8010661b:	e9 df fa ff ff       	jmp    801060ff <alltraps>

80106620 <vector3>:
.globl vector3
vector3:
  pushl $0
80106620:	6a 00                	push   $0x0
  pushl $3
80106622:	6a 03                	push   $0x3
  jmp alltraps
80106624:	e9 d6 fa ff ff       	jmp    801060ff <alltraps>

80106629 <vector4>:
.globl vector4
vector4:
  pushl $0
80106629:	6a 00                	push   $0x0
  pushl $4
8010662b:	6a 04                	push   $0x4
  jmp alltraps
8010662d:	e9 cd fa ff ff       	jmp    801060ff <alltraps>

80106632 <vector5>:
.globl vector5
vector5:
  pushl $0
80106632:	6a 00                	push   $0x0
  pushl $5
80106634:	6a 05                	push   $0x5
  jmp alltraps
80106636:	e9 c4 fa ff ff       	jmp    801060ff <alltraps>

8010663b <vector6>:
.globl vector6
vector6:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $6
8010663d:	6a 06                	push   $0x6
  jmp alltraps
8010663f:	e9 bb fa ff ff       	jmp    801060ff <alltraps>

80106644 <vector7>:
.globl vector7
vector7:
  pushl $0
80106644:	6a 00                	push   $0x0
  pushl $7
80106646:	6a 07                	push   $0x7
  jmp alltraps
80106648:	e9 b2 fa ff ff       	jmp    801060ff <alltraps>

8010664d <vector8>:
.globl vector8
vector8:
  pushl $8
8010664d:	6a 08                	push   $0x8
  jmp alltraps
8010664f:	e9 ab fa ff ff       	jmp    801060ff <alltraps>

80106654 <vector9>:
.globl vector9
vector9:
  pushl $0
80106654:	6a 00                	push   $0x0
  pushl $9
80106656:	6a 09                	push   $0x9
  jmp alltraps
80106658:	e9 a2 fa ff ff       	jmp    801060ff <alltraps>

8010665d <vector10>:
.globl vector10
vector10:
  pushl $10
8010665d:	6a 0a                	push   $0xa
  jmp alltraps
8010665f:	e9 9b fa ff ff       	jmp    801060ff <alltraps>

80106664 <vector11>:
.globl vector11
vector11:
  pushl $11
80106664:	6a 0b                	push   $0xb
  jmp alltraps
80106666:	e9 94 fa ff ff       	jmp    801060ff <alltraps>

8010666b <vector12>:
.globl vector12
vector12:
  pushl $12
8010666b:	6a 0c                	push   $0xc
  jmp alltraps
8010666d:	e9 8d fa ff ff       	jmp    801060ff <alltraps>

80106672 <vector13>:
.globl vector13
vector13:
  pushl $13
80106672:	6a 0d                	push   $0xd
  jmp alltraps
80106674:	e9 86 fa ff ff       	jmp    801060ff <alltraps>

80106679 <vector14>:
.globl vector14
vector14:
  pushl $14
80106679:	6a 0e                	push   $0xe
  jmp alltraps
8010667b:	e9 7f fa ff ff       	jmp    801060ff <alltraps>

80106680 <vector15>:
.globl vector15
vector15:
  pushl $0
80106680:	6a 00                	push   $0x0
  pushl $15
80106682:	6a 0f                	push   $0xf
  jmp alltraps
80106684:	e9 76 fa ff ff       	jmp    801060ff <alltraps>

80106689 <vector16>:
.globl vector16
vector16:
  pushl $0
80106689:	6a 00                	push   $0x0
  pushl $16
8010668b:	6a 10                	push   $0x10
  jmp alltraps
8010668d:	e9 6d fa ff ff       	jmp    801060ff <alltraps>

80106692 <vector17>:
.globl vector17
vector17:
  pushl $17
80106692:	6a 11                	push   $0x11
  jmp alltraps
80106694:	e9 66 fa ff ff       	jmp    801060ff <alltraps>

80106699 <vector18>:
.globl vector18
vector18:
  pushl $0
80106699:	6a 00                	push   $0x0
  pushl $18
8010669b:	6a 12                	push   $0x12
  jmp alltraps
8010669d:	e9 5d fa ff ff       	jmp    801060ff <alltraps>

801066a2 <vector19>:
.globl vector19
vector19:
  pushl $0
801066a2:	6a 00                	push   $0x0
  pushl $19
801066a4:	6a 13                	push   $0x13
  jmp alltraps
801066a6:	e9 54 fa ff ff       	jmp    801060ff <alltraps>

801066ab <vector20>:
.globl vector20
vector20:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $20
801066ad:	6a 14                	push   $0x14
  jmp alltraps
801066af:	e9 4b fa ff ff       	jmp    801060ff <alltraps>

801066b4 <vector21>:
.globl vector21
vector21:
  pushl $0
801066b4:	6a 00                	push   $0x0
  pushl $21
801066b6:	6a 15                	push   $0x15
  jmp alltraps
801066b8:	e9 42 fa ff ff       	jmp    801060ff <alltraps>

801066bd <vector22>:
.globl vector22
vector22:
  pushl $0
801066bd:	6a 00                	push   $0x0
  pushl $22
801066bf:	6a 16                	push   $0x16
  jmp alltraps
801066c1:	e9 39 fa ff ff       	jmp    801060ff <alltraps>

801066c6 <vector23>:
.globl vector23
vector23:
  pushl $0
801066c6:	6a 00                	push   $0x0
  pushl $23
801066c8:	6a 17                	push   $0x17
  jmp alltraps
801066ca:	e9 30 fa ff ff       	jmp    801060ff <alltraps>

801066cf <vector24>:
.globl vector24
vector24:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $24
801066d1:	6a 18                	push   $0x18
  jmp alltraps
801066d3:	e9 27 fa ff ff       	jmp    801060ff <alltraps>

801066d8 <vector25>:
.globl vector25
vector25:
  pushl $0
801066d8:	6a 00                	push   $0x0
  pushl $25
801066da:	6a 19                	push   $0x19
  jmp alltraps
801066dc:	e9 1e fa ff ff       	jmp    801060ff <alltraps>

801066e1 <vector26>:
.globl vector26
vector26:
  pushl $0
801066e1:	6a 00                	push   $0x0
  pushl $26
801066e3:	6a 1a                	push   $0x1a
  jmp alltraps
801066e5:	e9 15 fa ff ff       	jmp    801060ff <alltraps>

801066ea <vector27>:
.globl vector27
vector27:
  pushl $0
801066ea:	6a 00                	push   $0x0
  pushl $27
801066ec:	6a 1b                	push   $0x1b
  jmp alltraps
801066ee:	e9 0c fa ff ff       	jmp    801060ff <alltraps>

801066f3 <vector28>:
.globl vector28
vector28:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $28
801066f5:	6a 1c                	push   $0x1c
  jmp alltraps
801066f7:	e9 03 fa ff ff       	jmp    801060ff <alltraps>

801066fc <vector29>:
.globl vector29
vector29:
  pushl $0
801066fc:	6a 00                	push   $0x0
  pushl $29
801066fe:	6a 1d                	push   $0x1d
  jmp alltraps
80106700:	e9 fa f9 ff ff       	jmp    801060ff <alltraps>

80106705 <vector30>:
.globl vector30
vector30:
  pushl $0
80106705:	6a 00                	push   $0x0
  pushl $30
80106707:	6a 1e                	push   $0x1e
  jmp alltraps
80106709:	e9 f1 f9 ff ff       	jmp    801060ff <alltraps>

8010670e <vector31>:
.globl vector31
vector31:
  pushl $0
8010670e:	6a 00                	push   $0x0
  pushl $31
80106710:	6a 1f                	push   $0x1f
  jmp alltraps
80106712:	e9 e8 f9 ff ff       	jmp    801060ff <alltraps>

80106717 <vector32>:
.globl vector32
vector32:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $32
80106719:	6a 20                	push   $0x20
  jmp alltraps
8010671b:	e9 df f9 ff ff       	jmp    801060ff <alltraps>

80106720 <vector33>:
.globl vector33
vector33:
  pushl $0
80106720:	6a 00                	push   $0x0
  pushl $33
80106722:	6a 21                	push   $0x21
  jmp alltraps
80106724:	e9 d6 f9 ff ff       	jmp    801060ff <alltraps>

80106729 <vector34>:
.globl vector34
vector34:
  pushl $0
80106729:	6a 00                	push   $0x0
  pushl $34
8010672b:	6a 22                	push   $0x22
  jmp alltraps
8010672d:	e9 cd f9 ff ff       	jmp    801060ff <alltraps>

80106732 <vector35>:
.globl vector35
vector35:
  pushl $0
80106732:	6a 00                	push   $0x0
  pushl $35
80106734:	6a 23                	push   $0x23
  jmp alltraps
80106736:	e9 c4 f9 ff ff       	jmp    801060ff <alltraps>

8010673b <vector36>:
.globl vector36
vector36:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $36
8010673d:	6a 24                	push   $0x24
  jmp alltraps
8010673f:	e9 bb f9 ff ff       	jmp    801060ff <alltraps>

80106744 <vector37>:
.globl vector37
vector37:
  pushl $0
80106744:	6a 00                	push   $0x0
  pushl $37
80106746:	6a 25                	push   $0x25
  jmp alltraps
80106748:	e9 b2 f9 ff ff       	jmp    801060ff <alltraps>

8010674d <vector38>:
.globl vector38
vector38:
  pushl $0
8010674d:	6a 00                	push   $0x0
  pushl $38
8010674f:	6a 26                	push   $0x26
  jmp alltraps
80106751:	e9 a9 f9 ff ff       	jmp    801060ff <alltraps>

80106756 <vector39>:
.globl vector39
vector39:
  pushl $0
80106756:	6a 00                	push   $0x0
  pushl $39
80106758:	6a 27                	push   $0x27
  jmp alltraps
8010675a:	e9 a0 f9 ff ff       	jmp    801060ff <alltraps>

8010675f <vector40>:
.globl vector40
vector40:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $40
80106761:	6a 28                	push   $0x28
  jmp alltraps
80106763:	e9 97 f9 ff ff       	jmp    801060ff <alltraps>

80106768 <vector41>:
.globl vector41
vector41:
  pushl $0
80106768:	6a 00                	push   $0x0
  pushl $41
8010676a:	6a 29                	push   $0x29
  jmp alltraps
8010676c:	e9 8e f9 ff ff       	jmp    801060ff <alltraps>

80106771 <vector42>:
.globl vector42
vector42:
  pushl $0
80106771:	6a 00                	push   $0x0
  pushl $42
80106773:	6a 2a                	push   $0x2a
  jmp alltraps
80106775:	e9 85 f9 ff ff       	jmp    801060ff <alltraps>

8010677a <vector43>:
.globl vector43
vector43:
  pushl $0
8010677a:	6a 00                	push   $0x0
  pushl $43
8010677c:	6a 2b                	push   $0x2b
  jmp alltraps
8010677e:	e9 7c f9 ff ff       	jmp    801060ff <alltraps>

80106783 <vector44>:
.globl vector44
vector44:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $44
80106785:	6a 2c                	push   $0x2c
  jmp alltraps
80106787:	e9 73 f9 ff ff       	jmp    801060ff <alltraps>

8010678c <vector45>:
.globl vector45
vector45:
  pushl $0
8010678c:	6a 00                	push   $0x0
  pushl $45
8010678e:	6a 2d                	push   $0x2d
  jmp alltraps
80106790:	e9 6a f9 ff ff       	jmp    801060ff <alltraps>

80106795 <vector46>:
.globl vector46
vector46:
  pushl $0
80106795:	6a 00                	push   $0x0
  pushl $46
80106797:	6a 2e                	push   $0x2e
  jmp alltraps
80106799:	e9 61 f9 ff ff       	jmp    801060ff <alltraps>

8010679e <vector47>:
.globl vector47
vector47:
  pushl $0
8010679e:	6a 00                	push   $0x0
  pushl $47
801067a0:	6a 2f                	push   $0x2f
  jmp alltraps
801067a2:	e9 58 f9 ff ff       	jmp    801060ff <alltraps>

801067a7 <vector48>:
.globl vector48
vector48:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $48
801067a9:	6a 30                	push   $0x30
  jmp alltraps
801067ab:	e9 4f f9 ff ff       	jmp    801060ff <alltraps>

801067b0 <vector49>:
.globl vector49
vector49:
  pushl $0
801067b0:	6a 00                	push   $0x0
  pushl $49
801067b2:	6a 31                	push   $0x31
  jmp alltraps
801067b4:	e9 46 f9 ff ff       	jmp    801060ff <alltraps>

801067b9 <vector50>:
.globl vector50
vector50:
  pushl $0
801067b9:	6a 00                	push   $0x0
  pushl $50
801067bb:	6a 32                	push   $0x32
  jmp alltraps
801067bd:	e9 3d f9 ff ff       	jmp    801060ff <alltraps>

801067c2 <vector51>:
.globl vector51
vector51:
  pushl $0
801067c2:	6a 00                	push   $0x0
  pushl $51
801067c4:	6a 33                	push   $0x33
  jmp alltraps
801067c6:	e9 34 f9 ff ff       	jmp    801060ff <alltraps>

801067cb <vector52>:
.globl vector52
vector52:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $52
801067cd:	6a 34                	push   $0x34
  jmp alltraps
801067cf:	e9 2b f9 ff ff       	jmp    801060ff <alltraps>

801067d4 <vector53>:
.globl vector53
vector53:
  pushl $0
801067d4:	6a 00                	push   $0x0
  pushl $53
801067d6:	6a 35                	push   $0x35
  jmp alltraps
801067d8:	e9 22 f9 ff ff       	jmp    801060ff <alltraps>

801067dd <vector54>:
.globl vector54
vector54:
  pushl $0
801067dd:	6a 00                	push   $0x0
  pushl $54
801067df:	6a 36                	push   $0x36
  jmp alltraps
801067e1:	e9 19 f9 ff ff       	jmp    801060ff <alltraps>

801067e6 <vector55>:
.globl vector55
vector55:
  pushl $0
801067e6:	6a 00                	push   $0x0
  pushl $55
801067e8:	6a 37                	push   $0x37
  jmp alltraps
801067ea:	e9 10 f9 ff ff       	jmp    801060ff <alltraps>

801067ef <vector56>:
.globl vector56
vector56:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $56
801067f1:	6a 38                	push   $0x38
  jmp alltraps
801067f3:	e9 07 f9 ff ff       	jmp    801060ff <alltraps>

801067f8 <vector57>:
.globl vector57
vector57:
  pushl $0
801067f8:	6a 00                	push   $0x0
  pushl $57
801067fa:	6a 39                	push   $0x39
  jmp alltraps
801067fc:	e9 fe f8 ff ff       	jmp    801060ff <alltraps>

80106801 <vector58>:
.globl vector58
vector58:
  pushl $0
80106801:	6a 00                	push   $0x0
  pushl $58
80106803:	6a 3a                	push   $0x3a
  jmp alltraps
80106805:	e9 f5 f8 ff ff       	jmp    801060ff <alltraps>

8010680a <vector59>:
.globl vector59
vector59:
  pushl $0
8010680a:	6a 00                	push   $0x0
  pushl $59
8010680c:	6a 3b                	push   $0x3b
  jmp alltraps
8010680e:	e9 ec f8 ff ff       	jmp    801060ff <alltraps>

80106813 <vector60>:
.globl vector60
vector60:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $60
80106815:	6a 3c                	push   $0x3c
  jmp alltraps
80106817:	e9 e3 f8 ff ff       	jmp    801060ff <alltraps>

8010681c <vector61>:
.globl vector61
vector61:
  pushl $0
8010681c:	6a 00                	push   $0x0
  pushl $61
8010681e:	6a 3d                	push   $0x3d
  jmp alltraps
80106820:	e9 da f8 ff ff       	jmp    801060ff <alltraps>

80106825 <vector62>:
.globl vector62
vector62:
  pushl $0
80106825:	6a 00                	push   $0x0
  pushl $62
80106827:	6a 3e                	push   $0x3e
  jmp alltraps
80106829:	e9 d1 f8 ff ff       	jmp    801060ff <alltraps>

8010682e <vector63>:
.globl vector63
vector63:
  pushl $0
8010682e:	6a 00                	push   $0x0
  pushl $63
80106830:	6a 3f                	push   $0x3f
  jmp alltraps
80106832:	e9 c8 f8 ff ff       	jmp    801060ff <alltraps>

80106837 <vector64>:
.globl vector64
vector64:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $64
80106839:	6a 40                	push   $0x40
  jmp alltraps
8010683b:	e9 bf f8 ff ff       	jmp    801060ff <alltraps>

80106840 <vector65>:
.globl vector65
vector65:
  pushl $0
80106840:	6a 00                	push   $0x0
  pushl $65
80106842:	6a 41                	push   $0x41
  jmp alltraps
80106844:	e9 b6 f8 ff ff       	jmp    801060ff <alltraps>

80106849 <vector66>:
.globl vector66
vector66:
  pushl $0
80106849:	6a 00                	push   $0x0
  pushl $66
8010684b:	6a 42                	push   $0x42
  jmp alltraps
8010684d:	e9 ad f8 ff ff       	jmp    801060ff <alltraps>

80106852 <vector67>:
.globl vector67
vector67:
  pushl $0
80106852:	6a 00                	push   $0x0
  pushl $67
80106854:	6a 43                	push   $0x43
  jmp alltraps
80106856:	e9 a4 f8 ff ff       	jmp    801060ff <alltraps>

8010685b <vector68>:
.globl vector68
vector68:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $68
8010685d:	6a 44                	push   $0x44
  jmp alltraps
8010685f:	e9 9b f8 ff ff       	jmp    801060ff <alltraps>

80106864 <vector69>:
.globl vector69
vector69:
  pushl $0
80106864:	6a 00                	push   $0x0
  pushl $69
80106866:	6a 45                	push   $0x45
  jmp alltraps
80106868:	e9 92 f8 ff ff       	jmp    801060ff <alltraps>

8010686d <vector70>:
.globl vector70
vector70:
  pushl $0
8010686d:	6a 00                	push   $0x0
  pushl $70
8010686f:	6a 46                	push   $0x46
  jmp alltraps
80106871:	e9 89 f8 ff ff       	jmp    801060ff <alltraps>

80106876 <vector71>:
.globl vector71
vector71:
  pushl $0
80106876:	6a 00                	push   $0x0
  pushl $71
80106878:	6a 47                	push   $0x47
  jmp alltraps
8010687a:	e9 80 f8 ff ff       	jmp    801060ff <alltraps>

8010687f <vector72>:
.globl vector72
vector72:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $72
80106881:	6a 48                	push   $0x48
  jmp alltraps
80106883:	e9 77 f8 ff ff       	jmp    801060ff <alltraps>

80106888 <vector73>:
.globl vector73
vector73:
  pushl $0
80106888:	6a 00                	push   $0x0
  pushl $73
8010688a:	6a 49                	push   $0x49
  jmp alltraps
8010688c:	e9 6e f8 ff ff       	jmp    801060ff <alltraps>

80106891 <vector74>:
.globl vector74
vector74:
  pushl $0
80106891:	6a 00                	push   $0x0
  pushl $74
80106893:	6a 4a                	push   $0x4a
  jmp alltraps
80106895:	e9 65 f8 ff ff       	jmp    801060ff <alltraps>

8010689a <vector75>:
.globl vector75
vector75:
  pushl $0
8010689a:	6a 00                	push   $0x0
  pushl $75
8010689c:	6a 4b                	push   $0x4b
  jmp alltraps
8010689e:	e9 5c f8 ff ff       	jmp    801060ff <alltraps>

801068a3 <vector76>:
.globl vector76
vector76:
  pushl $0
801068a3:	6a 00                	push   $0x0
  pushl $76
801068a5:	6a 4c                	push   $0x4c
  jmp alltraps
801068a7:	e9 53 f8 ff ff       	jmp    801060ff <alltraps>

801068ac <vector77>:
.globl vector77
vector77:
  pushl $0
801068ac:	6a 00                	push   $0x0
  pushl $77
801068ae:	6a 4d                	push   $0x4d
  jmp alltraps
801068b0:	e9 4a f8 ff ff       	jmp    801060ff <alltraps>

801068b5 <vector78>:
.globl vector78
vector78:
  pushl $0
801068b5:	6a 00                	push   $0x0
  pushl $78
801068b7:	6a 4e                	push   $0x4e
  jmp alltraps
801068b9:	e9 41 f8 ff ff       	jmp    801060ff <alltraps>

801068be <vector79>:
.globl vector79
vector79:
  pushl $0
801068be:	6a 00                	push   $0x0
  pushl $79
801068c0:	6a 4f                	push   $0x4f
  jmp alltraps
801068c2:	e9 38 f8 ff ff       	jmp    801060ff <alltraps>

801068c7 <vector80>:
.globl vector80
vector80:
  pushl $0
801068c7:	6a 00                	push   $0x0
  pushl $80
801068c9:	6a 50                	push   $0x50
  jmp alltraps
801068cb:	e9 2f f8 ff ff       	jmp    801060ff <alltraps>

801068d0 <vector81>:
.globl vector81
vector81:
  pushl $0
801068d0:	6a 00                	push   $0x0
  pushl $81
801068d2:	6a 51                	push   $0x51
  jmp alltraps
801068d4:	e9 26 f8 ff ff       	jmp    801060ff <alltraps>

801068d9 <vector82>:
.globl vector82
vector82:
  pushl $0
801068d9:	6a 00                	push   $0x0
  pushl $82
801068db:	6a 52                	push   $0x52
  jmp alltraps
801068dd:	e9 1d f8 ff ff       	jmp    801060ff <alltraps>

801068e2 <vector83>:
.globl vector83
vector83:
  pushl $0
801068e2:	6a 00                	push   $0x0
  pushl $83
801068e4:	6a 53                	push   $0x53
  jmp alltraps
801068e6:	e9 14 f8 ff ff       	jmp    801060ff <alltraps>

801068eb <vector84>:
.globl vector84
vector84:
  pushl $0
801068eb:	6a 00                	push   $0x0
  pushl $84
801068ed:	6a 54                	push   $0x54
  jmp alltraps
801068ef:	e9 0b f8 ff ff       	jmp    801060ff <alltraps>

801068f4 <vector85>:
.globl vector85
vector85:
  pushl $0
801068f4:	6a 00                	push   $0x0
  pushl $85
801068f6:	6a 55                	push   $0x55
  jmp alltraps
801068f8:	e9 02 f8 ff ff       	jmp    801060ff <alltraps>

801068fd <vector86>:
.globl vector86
vector86:
  pushl $0
801068fd:	6a 00                	push   $0x0
  pushl $86
801068ff:	6a 56                	push   $0x56
  jmp alltraps
80106901:	e9 f9 f7 ff ff       	jmp    801060ff <alltraps>

80106906 <vector87>:
.globl vector87
vector87:
  pushl $0
80106906:	6a 00                	push   $0x0
  pushl $87
80106908:	6a 57                	push   $0x57
  jmp alltraps
8010690a:	e9 f0 f7 ff ff       	jmp    801060ff <alltraps>

8010690f <vector88>:
.globl vector88
vector88:
  pushl $0
8010690f:	6a 00                	push   $0x0
  pushl $88
80106911:	6a 58                	push   $0x58
  jmp alltraps
80106913:	e9 e7 f7 ff ff       	jmp    801060ff <alltraps>

80106918 <vector89>:
.globl vector89
vector89:
  pushl $0
80106918:	6a 00                	push   $0x0
  pushl $89
8010691a:	6a 59                	push   $0x59
  jmp alltraps
8010691c:	e9 de f7 ff ff       	jmp    801060ff <alltraps>

80106921 <vector90>:
.globl vector90
vector90:
  pushl $0
80106921:	6a 00                	push   $0x0
  pushl $90
80106923:	6a 5a                	push   $0x5a
  jmp alltraps
80106925:	e9 d5 f7 ff ff       	jmp    801060ff <alltraps>

8010692a <vector91>:
.globl vector91
vector91:
  pushl $0
8010692a:	6a 00                	push   $0x0
  pushl $91
8010692c:	6a 5b                	push   $0x5b
  jmp alltraps
8010692e:	e9 cc f7 ff ff       	jmp    801060ff <alltraps>

80106933 <vector92>:
.globl vector92
vector92:
  pushl $0
80106933:	6a 00                	push   $0x0
  pushl $92
80106935:	6a 5c                	push   $0x5c
  jmp alltraps
80106937:	e9 c3 f7 ff ff       	jmp    801060ff <alltraps>

8010693c <vector93>:
.globl vector93
vector93:
  pushl $0
8010693c:	6a 00                	push   $0x0
  pushl $93
8010693e:	6a 5d                	push   $0x5d
  jmp alltraps
80106940:	e9 ba f7 ff ff       	jmp    801060ff <alltraps>

80106945 <vector94>:
.globl vector94
vector94:
  pushl $0
80106945:	6a 00                	push   $0x0
  pushl $94
80106947:	6a 5e                	push   $0x5e
  jmp alltraps
80106949:	e9 b1 f7 ff ff       	jmp    801060ff <alltraps>

8010694e <vector95>:
.globl vector95
vector95:
  pushl $0
8010694e:	6a 00                	push   $0x0
  pushl $95
80106950:	6a 5f                	push   $0x5f
  jmp alltraps
80106952:	e9 a8 f7 ff ff       	jmp    801060ff <alltraps>

80106957 <vector96>:
.globl vector96
vector96:
  pushl $0
80106957:	6a 00                	push   $0x0
  pushl $96
80106959:	6a 60                	push   $0x60
  jmp alltraps
8010695b:	e9 9f f7 ff ff       	jmp    801060ff <alltraps>

80106960 <vector97>:
.globl vector97
vector97:
  pushl $0
80106960:	6a 00                	push   $0x0
  pushl $97
80106962:	6a 61                	push   $0x61
  jmp alltraps
80106964:	e9 96 f7 ff ff       	jmp    801060ff <alltraps>

80106969 <vector98>:
.globl vector98
vector98:
  pushl $0
80106969:	6a 00                	push   $0x0
  pushl $98
8010696b:	6a 62                	push   $0x62
  jmp alltraps
8010696d:	e9 8d f7 ff ff       	jmp    801060ff <alltraps>

80106972 <vector99>:
.globl vector99
vector99:
  pushl $0
80106972:	6a 00                	push   $0x0
  pushl $99
80106974:	6a 63                	push   $0x63
  jmp alltraps
80106976:	e9 84 f7 ff ff       	jmp    801060ff <alltraps>

8010697b <vector100>:
.globl vector100
vector100:
  pushl $0
8010697b:	6a 00                	push   $0x0
  pushl $100
8010697d:	6a 64                	push   $0x64
  jmp alltraps
8010697f:	e9 7b f7 ff ff       	jmp    801060ff <alltraps>

80106984 <vector101>:
.globl vector101
vector101:
  pushl $0
80106984:	6a 00                	push   $0x0
  pushl $101
80106986:	6a 65                	push   $0x65
  jmp alltraps
80106988:	e9 72 f7 ff ff       	jmp    801060ff <alltraps>

8010698d <vector102>:
.globl vector102
vector102:
  pushl $0
8010698d:	6a 00                	push   $0x0
  pushl $102
8010698f:	6a 66                	push   $0x66
  jmp alltraps
80106991:	e9 69 f7 ff ff       	jmp    801060ff <alltraps>

80106996 <vector103>:
.globl vector103
vector103:
  pushl $0
80106996:	6a 00                	push   $0x0
  pushl $103
80106998:	6a 67                	push   $0x67
  jmp alltraps
8010699a:	e9 60 f7 ff ff       	jmp    801060ff <alltraps>

8010699f <vector104>:
.globl vector104
vector104:
  pushl $0
8010699f:	6a 00                	push   $0x0
  pushl $104
801069a1:	6a 68                	push   $0x68
  jmp alltraps
801069a3:	e9 57 f7 ff ff       	jmp    801060ff <alltraps>

801069a8 <vector105>:
.globl vector105
vector105:
  pushl $0
801069a8:	6a 00                	push   $0x0
  pushl $105
801069aa:	6a 69                	push   $0x69
  jmp alltraps
801069ac:	e9 4e f7 ff ff       	jmp    801060ff <alltraps>

801069b1 <vector106>:
.globl vector106
vector106:
  pushl $0
801069b1:	6a 00                	push   $0x0
  pushl $106
801069b3:	6a 6a                	push   $0x6a
  jmp alltraps
801069b5:	e9 45 f7 ff ff       	jmp    801060ff <alltraps>

801069ba <vector107>:
.globl vector107
vector107:
  pushl $0
801069ba:	6a 00                	push   $0x0
  pushl $107
801069bc:	6a 6b                	push   $0x6b
  jmp alltraps
801069be:	e9 3c f7 ff ff       	jmp    801060ff <alltraps>

801069c3 <vector108>:
.globl vector108
vector108:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $108
801069c5:	6a 6c                	push   $0x6c
  jmp alltraps
801069c7:	e9 33 f7 ff ff       	jmp    801060ff <alltraps>

801069cc <vector109>:
.globl vector109
vector109:
  pushl $0
801069cc:	6a 00                	push   $0x0
  pushl $109
801069ce:	6a 6d                	push   $0x6d
  jmp alltraps
801069d0:	e9 2a f7 ff ff       	jmp    801060ff <alltraps>

801069d5 <vector110>:
.globl vector110
vector110:
  pushl $0
801069d5:	6a 00                	push   $0x0
  pushl $110
801069d7:	6a 6e                	push   $0x6e
  jmp alltraps
801069d9:	e9 21 f7 ff ff       	jmp    801060ff <alltraps>

801069de <vector111>:
.globl vector111
vector111:
  pushl $0
801069de:	6a 00                	push   $0x0
  pushl $111
801069e0:	6a 6f                	push   $0x6f
  jmp alltraps
801069e2:	e9 18 f7 ff ff       	jmp    801060ff <alltraps>

801069e7 <vector112>:
.globl vector112
vector112:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $112
801069e9:	6a 70                	push   $0x70
  jmp alltraps
801069eb:	e9 0f f7 ff ff       	jmp    801060ff <alltraps>

801069f0 <vector113>:
.globl vector113
vector113:
  pushl $0
801069f0:	6a 00                	push   $0x0
  pushl $113
801069f2:	6a 71                	push   $0x71
  jmp alltraps
801069f4:	e9 06 f7 ff ff       	jmp    801060ff <alltraps>

801069f9 <vector114>:
.globl vector114
vector114:
  pushl $0
801069f9:	6a 00                	push   $0x0
  pushl $114
801069fb:	6a 72                	push   $0x72
  jmp alltraps
801069fd:	e9 fd f6 ff ff       	jmp    801060ff <alltraps>

80106a02 <vector115>:
.globl vector115
vector115:
  pushl $0
80106a02:	6a 00                	push   $0x0
  pushl $115
80106a04:	6a 73                	push   $0x73
  jmp alltraps
80106a06:	e9 f4 f6 ff ff       	jmp    801060ff <alltraps>

80106a0b <vector116>:
.globl vector116
vector116:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $116
80106a0d:	6a 74                	push   $0x74
  jmp alltraps
80106a0f:	e9 eb f6 ff ff       	jmp    801060ff <alltraps>

80106a14 <vector117>:
.globl vector117
vector117:
  pushl $0
80106a14:	6a 00                	push   $0x0
  pushl $117
80106a16:	6a 75                	push   $0x75
  jmp alltraps
80106a18:	e9 e2 f6 ff ff       	jmp    801060ff <alltraps>

80106a1d <vector118>:
.globl vector118
vector118:
  pushl $0
80106a1d:	6a 00                	push   $0x0
  pushl $118
80106a1f:	6a 76                	push   $0x76
  jmp alltraps
80106a21:	e9 d9 f6 ff ff       	jmp    801060ff <alltraps>

80106a26 <vector119>:
.globl vector119
vector119:
  pushl $0
80106a26:	6a 00                	push   $0x0
  pushl $119
80106a28:	6a 77                	push   $0x77
  jmp alltraps
80106a2a:	e9 d0 f6 ff ff       	jmp    801060ff <alltraps>

80106a2f <vector120>:
.globl vector120
vector120:
  pushl $0
80106a2f:	6a 00                	push   $0x0
  pushl $120
80106a31:	6a 78                	push   $0x78
  jmp alltraps
80106a33:	e9 c7 f6 ff ff       	jmp    801060ff <alltraps>

80106a38 <vector121>:
.globl vector121
vector121:
  pushl $0
80106a38:	6a 00                	push   $0x0
  pushl $121
80106a3a:	6a 79                	push   $0x79
  jmp alltraps
80106a3c:	e9 be f6 ff ff       	jmp    801060ff <alltraps>

80106a41 <vector122>:
.globl vector122
vector122:
  pushl $0
80106a41:	6a 00                	push   $0x0
  pushl $122
80106a43:	6a 7a                	push   $0x7a
  jmp alltraps
80106a45:	e9 b5 f6 ff ff       	jmp    801060ff <alltraps>

80106a4a <vector123>:
.globl vector123
vector123:
  pushl $0
80106a4a:	6a 00                	push   $0x0
  pushl $123
80106a4c:	6a 7b                	push   $0x7b
  jmp alltraps
80106a4e:	e9 ac f6 ff ff       	jmp    801060ff <alltraps>

80106a53 <vector124>:
.globl vector124
vector124:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $124
80106a55:	6a 7c                	push   $0x7c
  jmp alltraps
80106a57:	e9 a3 f6 ff ff       	jmp    801060ff <alltraps>

80106a5c <vector125>:
.globl vector125
vector125:
  pushl $0
80106a5c:	6a 00                	push   $0x0
  pushl $125
80106a5e:	6a 7d                	push   $0x7d
  jmp alltraps
80106a60:	e9 9a f6 ff ff       	jmp    801060ff <alltraps>

80106a65 <vector126>:
.globl vector126
vector126:
  pushl $0
80106a65:	6a 00                	push   $0x0
  pushl $126
80106a67:	6a 7e                	push   $0x7e
  jmp alltraps
80106a69:	e9 91 f6 ff ff       	jmp    801060ff <alltraps>

80106a6e <vector127>:
.globl vector127
vector127:
  pushl $0
80106a6e:	6a 00                	push   $0x0
  pushl $127
80106a70:	6a 7f                	push   $0x7f
  jmp alltraps
80106a72:	e9 88 f6 ff ff       	jmp    801060ff <alltraps>

80106a77 <vector128>:
.globl vector128
vector128:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $128
80106a79:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106a7e:	e9 7c f6 ff ff       	jmp    801060ff <alltraps>

80106a83 <vector129>:
.globl vector129
vector129:
  pushl $0
80106a83:	6a 00                	push   $0x0
  pushl $129
80106a85:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106a8a:	e9 70 f6 ff ff       	jmp    801060ff <alltraps>

80106a8f <vector130>:
.globl vector130
vector130:
  pushl $0
80106a8f:	6a 00                	push   $0x0
  pushl $130
80106a91:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106a96:	e9 64 f6 ff ff       	jmp    801060ff <alltraps>

80106a9b <vector131>:
.globl vector131
vector131:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $131
80106a9d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106aa2:	e9 58 f6 ff ff       	jmp    801060ff <alltraps>

80106aa7 <vector132>:
.globl vector132
vector132:
  pushl $0
80106aa7:	6a 00                	push   $0x0
  pushl $132
80106aa9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106aae:	e9 4c f6 ff ff       	jmp    801060ff <alltraps>

80106ab3 <vector133>:
.globl vector133
vector133:
  pushl $0
80106ab3:	6a 00                	push   $0x0
  pushl $133
80106ab5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106aba:	e9 40 f6 ff ff       	jmp    801060ff <alltraps>

80106abf <vector134>:
.globl vector134
vector134:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $134
80106ac1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106ac6:	e9 34 f6 ff ff       	jmp    801060ff <alltraps>

80106acb <vector135>:
.globl vector135
vector135:
  pushl $0
80106acb:	6a 00                	push   $0x0
  pushl $135
80106acd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106ad2:	e9 28 f6 ff ff       	jmp    801060ff <alltraps>

80106ad7 <vector136>:
.globl vector136
vector136:
  pushl $0
80106ad7:	6a 00                	push   $0x0
  pushl $136
80106ad9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106ade:	e9 1c f6 ff ff       	jmp    801060ff <alltraps>

80106ae3 <vector137>:
.globl vector137
vector137:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $137
80106ae5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106aea:	e9 10 f6 ff ff       	jmp    801060ff <alltraps>

80106aef <vector138>:
.globl vector138
vector138:
  pushl $0
80106aef:	6a 00                	push   $0x0
  pushl $138
80106af1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106af6:	e9 04 f6 ff ff       	jmp    801060ff <alltraps>

80106afb <vector139>:
.globl vector139
vector139:
  pushl $0
80106afb:	6a 00                	push   $0x0
  pushl $139
80106afd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106b02:	e9 f8 f5 ff ff       	jmp    801060ff <alltraps>

80106b07 <vector140>:
.globl vector140
vector140:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $140
80106b09:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106b0e:	e9 ec f5 ff ff       	jmp    801060ff <alltraps>

80106b13 <vector141>:
.globl vector141
vector141:
  pushl $0
80106b13:	6a 00                	push   $0x0
  pushl $141
80106b15:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106b1a:	e9 e0 f5 ff ff       	jmp    801060ff <alltraps>

80106b1f <vector142>:
.globl vector142
vector142:
  pushl $0
80106b1f:	6a 00                	push   $0x0
  pushl $142
80106b21:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106b26:	e9 d4 f5 ff ff       	jmp    801060ff <alltraps>

80106b2b <vector143>:
.globl vector143
vector143:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $143
80106b2d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106b32:	e9 c8 f5 ff ff       	jmp    801060ff <alltraps>

80106b37 <vector144>:
.globl vector144
vector144:
  pushl $0
80106b37:	6a 00                	push   $0x0
  pushl $144
80106b39:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106b3e:	e9 bc f5 ff ff       	jmp    801060ff <alltraps>

80106b43 <vector145>:
.globl vector145
vector145:
  pushl $0
80106b43:	6a 00                	push   $0x0
  pushl $145
80106b45:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106b4a:	e9 b0 f5 ff ff       	jmp    801060ff <alltraps>

80106b4f <vector146>:
.globl vector146
vector146:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $146
80106b51:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106b56:	e9 a4 f5 ff ff       	jmp    801060ff <alltraps>

80106b5b <vector147>:
.globl vector147
vector147:
  pushl $0
80106b5b:	6a 00                	push   $0x0
  pushl $147
80106b5d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106b62:	e9 98 f5 ff ff       	jmp    801060ff <alltraps>

80106b67 <vector148>:
.globl vector148
vector148:
  pushl $0
80106b67:	6a 00                	push   $0x0
  pushl $148
80106b69:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106b6e:	e9 8c f5 ff ff       	jmp    801060ff <alltraps>

80106b73 <vector149>:
.globl vector149
vector149:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $149
80106b75:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106b7a:	e9 80 f5 ff ff       	jmp    801060ff <alltraps>

80106b7f <vector150>:
.globl vector150
vector150:
  pushl $0
80106b7f:	6a 00                	push   $0x0
  pushl $150
80106b81:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106b86:	e9 74 f5 ff ff       	jmp    801060ff <alltraps>

80106b8b <vector151>:
.globl vector151
vector151:
  pushl $0
80106b8b:	6a 00                	push   $0x0
  pushl $151
80106b8d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106b92:	e9 68 f5 ff ff       	jmp    801060ff <alltraps>

80106b97 <vector152>:
.globl vector152
vector152:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $152
80106b99:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106b9e:	e9 5c f5 ff ff       	jmp    801060ff <alltraps>

80106ba3 <vector153>:
.globl vector153
vector153:
  pushl $0
80106ba3:	6a 00                	push   $0x0
  pushl $153
80106ba5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106baa:	e9 50 f5 ff ff       	jmp    801060ff <alltraps>

80106baf <vector154>:
.globl vector154
vector154:
  pushl $0
80106baf:	6a 00                	push   $0x0
  pushl $154
80106bb1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106bb6:	e9 44 f5 ff ff       	jmp    801060ff <alltraps>

80106bbb <vector155>:
.globl vector155
vector155:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $155
80106bbd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106bc2:	e9 38 f5 ff ff       	jmp    801060ff <alltraps>

80106bc7 <vector156>:
.globl vector156
vector156:
  pushl $0
80106bc7:	6a 00                	push   $0x0
  pushl $156
80106bc9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106bce:	e9 2c f5 ff ff       	jmp    801060ff <alltraps>

80106bd3 <vector157>:
.globl vector157
vector157:
  pushl $0
80106bd3:	6a 00                	push   $0x0
  pushl $157
80106bd5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106bda:	e9 20 f5 ff ff       	jmp    801060ff <alltraps>

80106bdf <vector158>:
.globl vector158
vector158:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $158
80106be1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106be6:	e9 14 f5 ff ff       	jmp    801060ff <alltraps>

80106beb <vector159>:
.globl vector159
vector159:
  pushl $0
80106beb:	6a 00                	push   $0x0
  pushl $159
80106bed:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106bf2:	e9 08 f5 ff ff       	jmp    801060ff <alltraps>

80106bf7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106bf7:	6a 00                	push   $0x0
  pushl $160
80106bf9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106bfe:	e9 fc f4 ff ff       	jmp    801060ff <alltraps>

80106c03 <vector161>:
.globl vector161
vector161:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $161
80106c05:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106c0a:	e9 f0 f4 ff ff       	jmp    801060ff <alltraps>

80106c0f <vector162>:
.globl vector162
vector162:
  pushl $0
80106c0f:	6a 00                	push   $0x0
  pushl $162
80106c11:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106c16:	e9 e4 f4 ff ff       	jmp    801060ff <alltraps>

80106c1b <vector163>:
.globl vector163
vector163:
  pushl $0
80106c1b:	6a 00                	push   $0x0
  pushl $163
80106c1d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106c22:	e9 d8 f4 ff ff       	jmp    801060ff <alltraps>

80106c27 <vector164>:
.globl vector164
vector164:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $164
80106c29:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106c2e:	e9 cc f4 ff ff       	jmp    801060ff <alltraps>

80106c33 <vector165>:
.globl vector165
vector165:
  pushl $0
80106c33:	6a 00                	push   $0x0
  pushl $165
80106c35:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106c3a:	e9 c0 f4 ff ff       	jmp    801060ff <alltraps>

80106c3f <vector166>:
.globl vector166
vector166:
  pushl $0
80106c3f:	6a 00                	push   $0x0
  pushl $166
80106c41:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106c46:	e9 b4 f4 ff ff       	jmp    801060ff <alltraps>

80106c4b <vector167>:
.globl vector167
vector167:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $167
80106c4d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106c52:	e9 a8 f4 ff ff       	jmp    801060ff <alltraps>

80106c57 <vector168>:
.globl vector168
vector168:
  pushl $0
80106c57:	6a 00                	push   $0x0
  pushl $168
80106c59:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106c5e:	e9 9c f4 ff ff       	jmp    801060ff <alltraps>

80106c63 <vector169>:
.globl vector169
vector169:
  pushl $0
80106c63:	6a 00                	push   $0x0
  pushl $169
80106c65:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106c6a:	e9 90 f4 ff ff       	jmp    801060ff <alltraps>

80106c6f <vector170>:
.globl vector170
vector170:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $170
80106c71:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106c76:	e9 84 f4 ff ff       	jmp    801060ff <alltraps>

80106c7b <vector171>:
.globl vector171
vector171:
  pushl $0
80106c7b:	6a 00                	push   $0x0
  pushl $171
80106c7d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106c82:	e9 78 f4 ff ff       	jmp    801060ff <alltraps>

80106c87 <vector172>:
.globl vector172
vector172:
  pushl $0
80106c87:	6a 00                	push   $0x0
  pushl $172
80106c89:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106c8e:	e9 6c f4 ff ff       	jmp    801060ff <alltraps>

80106c93 <vector173>:
.globl vector173
vector173:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $173
80106c95:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106c9a:	e9 60 f4 ff ff       	jmp    801060ff <alltraps>

80106c9f <vector174>:
.globl vector174
vector174:
  pushl $0
80106c9f:	6a 00                	push   $0x0
  pushl $174
80106ca1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106ca6:	e9 54 f4 ff ff       	jmp    801060ff <alltraps>

80106cab <vector175>:
.globl vector175
vector175:
  pushl $0
80106cab:	6a 00                	push   $0x0
  pushl $175
80106cad:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106cb2:	e9 48 f4 ff ff       	jmp    801060ff <alltraps>

80106cb7 <vector176>:
.globl vector176
vector176:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $176
80106cb9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106cbe:	e9 3c f4 ff ff       	jmp    801060ff <alltraps>

80106cc3 <vector177>:
.globl vector177
vector177:
  pushl $0
80106cc3:	6a 00                	push   $0x0
  pushl $177
80106cc5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106cca:	e9 30 f4 ff ff       	jmp    801060ff <alltraps>

80106ccf <vector178>:
.globl vector178
vector178:
  pushl $0
80106ccf:	6a 00                	push   $0x0
  pushl $178
80106cd1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106cd6:	e9 24 f4 ff ff       	jmp    801060ff <alltraps>

80106cdb <vector179>:
.globl vector179
vector179:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $179
80106cdd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106ce2:	e9 18 f4 ff ff       	jmp    801060ff <alltraps>

80106ce7 <vector180>:
.globl vector180
vector180:
  pushl $0
80106ce7:	6a 00                	push   $0x0
  pushl $180
80106ce9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106cee:	e9 0c f4 ff ff       	jmp    801060ff <alltraps>

80106cf3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106cf3:	6a 00                	push   $0x0
  pushl $181
80106cf5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106cfa:	e9 00 f4 ff ff       	jmp    801060ff <alltraps>

80106cff <vector182>:
.globl vector182
vector182:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $182
80106d01:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106d06:	e9 f4 f3 ff ff       	jmp    801060ff <alltraps>

80106d0b <vector183>:
.globl vector183
vector183:
  pushl $0
80106d0b:	6a 00                	push   $0x0
  pushl $183
80106d0d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106d12:	e9 e8 f3 ff ff       	jmp    801060ff <alltraps>

80106d17 <vector184>:
.globl vector184
vector184:
  pushl $0
80106d17:	6a 00                	push   $0x0
  pushl $184
80106d19:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106d1e:	e9 dc f3 ff ff       	jmp    801060ff <alltraps>

80106d23 <vector185>:
.globl vector185
vector185:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $185
80106d25:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106d2a:	e9 d0 f3 ff ff       	jmp    801060ff <alltraps>

80106d2f <vector186>:
.globl vector186
vector186:
  pushl $0
80106d2f:	6a 00                	push   $0x0
  pushl $186
80106d31:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106d36:	e9 c4 f3 ff ff       	jmp    801060ff <alltraps>

80106d3b <vector187>:
.globl vector187
vector187:
  pushl $0
80106d3b:	6a 00                	push   $0x0
  pushl $187
80106d3d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106d42:	e9 b8 f3 ff ff       	jmp    801060ff <alltraps>

80106d47 <vector188>:
.globl vector188
vector188:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $188
80106d49:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106d4e:	e9 ac f3 ff ff       	jmp    801060ff <alltraps>

80106d53 <vector189>:
.globl vector189
vector189:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $189
80106d55:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106d5a:	e9 a0 f3 ff ff       	jmp    801060ff <alltraps>

80106d5f <vector190>:
.globl vector190
vector190:
  pushl $0
80106d5f:	6a 00                	push   $0x0
  pushl $190
80106d61:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106d66:	e9 94 f3 ff ff       	jmp    801060ff <alltraps>

80106d6b <vector191>:
.globl vector191
vector191:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $191
80106d6d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106d72:	e9 88 f3 ff ff       	jmp    801060ff <alltraps>

80106d77 <vector192>:
.globl vector192
vector192:
  pushl $0
80106d77:	6a 00                	push   $0x0
  pushl $192
80106d79:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106d7e:	e9 7c f3 ff ff       	jmp    801060ff <alltraps>

80106d83 <vector193>:
.globl vector193
vector193:
  pushl $0
80106d83:	6a 00                	push   $0x0
  pushl $193
80106d85:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106d8a:	e9 70 f3 ff ff       	jmp    801060ff <alltraps>

80106d8f <vector194>:
.globl vector194
vector194:
  pushl $0
80106d8f:	6a 00                	push   $0x0
  pushl $194
80106d91:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106d96:	e9 64 f3 ff ff       	jmp    801060ff <alltraps>

80106d9b <vector195>:
.globl vector195
vector195:
  pushl $0
80106d9b:	6a 00                	push   $0x0
  pushl $195
80106d9d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106da2:	e9 58 f3 ff ff       	jmp    801060ff <alltraps>

80106da7 <vector196>:
.globl vector196
vector196:
  pushl $0
80106da7:	6a 00                	push   $0x0
  pushl $196
80106da9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106dae:	e9 4c f3 ff ff       	jmp    801060ff <alltraps>

80106db3 <vector197>:
.globl vector197
vector197:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $197
80106db5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106dba:	e9 40 f3 ff ff       	jmp    801060ff <alltraps>

80106dbf <vector198>:
.globl vector198
vector198:
  pushl $0
80106dbf:	6a 00                	push   $0x0
  pushl $198
80106dc1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106dc6:	e9 34 f3 ff ff       	jmp    801060ff <alltraps>

80106dcb <vector199>:
.globl vector199
vector199:
  pushl $0
80106dcb:	6a 00                	push   $0x0
  pushl $199
80106dcd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106dd2:	e9 28 f3 ff ff       	jmp    801060ff <alltraps>

80106dd7 <vector200>:
.globl vector200
vector200:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $200
80106dd9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106dde:	e9 1c f3 ff ff       	jmp    801060ff <alltraps>

80106de3 <vector201>:
.globl vector201
vector201:
  pushl $0
80106de3:	6a 00                	push   $0x0
  pushl $201
80106de5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106dea:	e9 10 f3 ff ff       	jmp    801060ff <alltraps>

80106def <vector202>:
.globl vector202
vector202:
  pushl $0
80106def:	6a 00                	push   $0x0
  pushl $202
80106df1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106df6:	e9 04 f3 ff ff       	jmp    801060ff <alltraps>

80106dfb <vector203>:
.globl vector203
vector203:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $203
80106dfd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106e02:	e9 f8 f2 ff ff       	jmp    801060ff <alltraps>

80106e07 <vector204>:
.globl vector204
vector204:
  pushl $0
80106e07:	6a 00                	push   $0x0
  pushl $204
80106e09:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106e0e:	e9 ec f2 ff ff       	jmp    801060ff <alltraps>

80106e13 <vector205>:
.globl vector205
vector205:
  pushl $0
80106e13:	6a 00                	push   $0x0
  pushl $205
80106e15:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106e1a:	e9 e0 f2 ff ff       	jmp    801060ff <alltraps>

80106e1f <vector206>:
.globl vector206
vector206:
  pushl $0
80106e1f:	6a 00                	push   $0x0
  pushl $206
80106e21:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106e26:	e9 d4 f2 ff ff       	jmp    801060ff <alltraps>

80106e2b <vector207>:
.globl vector207
vector207:
  pushl $0
80106e2b:	6a 00                	push   $0x0
  pushl $207
80106e2d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106e32:	e9 c8 f2 ff ff       	jmp    801060ff <alltraps>

80106e37 <vector208>:
.globl vector208
vector208:
  pushl $0
80106e37:	6a 00                	push   $0x0
  pushl $208
80106e39:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106e3e:	e9 bc f2 ff ff       	jmp    801060ff <alltraps>

80106e43 <vector209>:
.globl vector209
vector209:
  pushl $0
80106e43:	6a 00                	push   $0x0
  pushl $209
80106e45:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106e4a:	e9 b0 f2 ff ff       	jmp    801060ff <alltraps>

80106e4f <vector210>:
.globl vector210
vector210:
  pushl $0
80106e4f:	6a 00                	push   $0x0
  pushl $210
80106e51:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106e56:	e9 a4 f2 ff ff       	jmp    801060ff <alltraps>

80106e5b <vector211>:
.globl vector211
vector211:
  pushl $0
80106e5b:	6a 00                	push   $0x0
  pushl $211
80106e5d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106e62:	e9 98 f2 ff ff       	jmp    801060ff <alltraps>

80106e67 <vector212>:
.globl vector212
vector212:
  pushl $0
80106e67:	6a 00                	push   $0x0
  pushl $212
80106e69:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106e6e:	e9 8c f2 ff ff       	jmp    801060ff <alltraps>

80106e73 <vector213>:
.globl vector213
vector213:
  pushl $0
80106e73:	6a 00                	push   $0x0
  pushl $213
80106e75:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106e7a:	e9 80 f2 ff ff       	jmp    801060ff <alltraps>

80106e7f <vector214>:
.globl vector214
vector214:
  pushl $0
80106e7f:	6a 00                	push   $0x0
  pushl $214
80106e81:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106e86:	e9 74 f2 ff ff       	jmp    801060ff <alltraps>

80106e8b <vector215>:
.globl vector215
vector215:
  pushl $0
80106e8b:	6a 00                	push   $0x0
  pushl $215
80106e8d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106e92:	e9 68 f2 ff ff       	jmp    801060ff <alltraps>

80106e97 <vector216>:
.globl vector216
vector216:
  pushl $0
80106e97:	6a 00                	push   $0x0
  pushl $216
80106e99:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106e9e:	e9 5c f2 ff ff       	jmp    801060ff <alltraps>

80106ea3 <vector217>:
.globl vector217
vector217:
  pushl $0
80106ea3:	6a 00                	push   $0x0
  pushl $217
80106ea5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106eaa:	e9 50 f2 ff ff       	jmp    801060ff <alltraps>

80106eaf <vector218>:
.globl vector218
vector218:
  pushl $0
80106eaf:	6a 00                	push   $0x0
  pushl $218
80106eb1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106eb6:	e9 44 f2 ff ff       	jmp    801060ff <alltraps>

80106ebb <vector219>:
.globl vector219
vector219:
  pushl $0
80106ebb:	6a 00                	push   $0x0
  pushl $219
80106ebd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106ec2:	e9 38 f2 ff ff       	jmp    801060ff <alltraps>

80106ec7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106ec7:	6a 00                	push   $0x0
  pushl $220
80106ec9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106ece:	e9 2c f2 ff ff       	jmp    801060ff <alltraps>

80106ed3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106ed3:	6a 00                	push   $0x0
  pushl $221
80106ed5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106eda:	e9 20 f2 ff ff       	jmp    801060ff <alltraps>

80106edf <vector222>:
.globl vector222
vector222:
  pushl $0
80106edf:	6a 00                	push   $0x0
  pushl $222
80106ee1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106ee6:	e9 14 f2 ff ff       	jmp    801060ff <alltraps>

80106eeb <vector223>:
.globl vector223
vector223:
  pushl $0
80106eeb:	6a 00                	push   $0x0
  pushl $223
80106eed:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106ef2:	e9 08 f2 ff ff       	jmp    801060ff <alltraps>

80106ef7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106ef7:	6a 00                	push   $0x0
  pushl $224
80106ef9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106efe:	e9 fc f1 ff ff       	jmp    801060ff <alltraps>

80106f03 <vector225>:
.globl vector225
vector225:
  pushl $0
80106f03:	6a 00                	push   $0x0
  pushl $225
80106f05:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106f0a:	e9 f0 f1 ff ff       	jmp    801060ff <alltraps>

80106f0f <vector226>:
.globl vector226
vector226:
  pushl $0
80106f0f:	6a 00                	push   $0x0
  pushl $226
80106f11:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106f16:	e9 e4 f1 ff ff       	jmp    801060ff <alltraps>

80106f1b <vector227>:
.globl vector227
vector227:
  pushl $0
80106f1b:	6a 00                	push   $0x0
  pushl $227
80106f1d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106f22:	e9 d8 f1 ff ff       	jmp    801060ff <alltraps>

80106f27 <vector228>:
.globl vector228
vector228:
  pushl $0
80106f27:	6a 00                	push   $0x0
  pushl $228
80106f29:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106f2e:	e9 cc f1 ff ff       	jmp    801060ff <alltraps>

80106f33 <vector229>:
.globl vector229
vector229:
  pushl $0
80106f33:	6a 00                	push   $0x0
  pushl $229
80106f35:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106f3a:	e9 c0 f1 ff ff       	jmp    801060ff <alltraps>

80106f3f <vector230>:
.globl vector230
vector230:
  pushl $0
80106f3f:	6a 00                	push   $0x0
  pushl $230
80106f41:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106f46:	e9 b4 f1 ff ff       	jmp    801060ff <alltraps>

80106f4b <vector231>:
.globl vector231
vector231:
  pushl $0
80106f4b:	6a 00                	push   $0x0
  pushl $231
80106f4d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106f52:	e9 a8 f1 ff ff       	jmp    801060ff <alltraps>

80106f57 <vector232>:
.globl vector232
vector232:
  pushl $0
80106f57:	6a 00                	push   $0x0
  pushl $232
80106f59:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106f5e:	e9 9c f1 ff ff       	jmp    801060ff <alltraps>

80106f63 <vector233>:
.globl vector233
vector233:
  pushl $0
80106f63:	6a 00                	push   $0x0
  pushl $233
80106f65:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106f6a:	e9 90 f1 ff ff       	jmp    801060ff <alltraps>

80106f6f <vector234>:
.globl vector234
vector234:
  pushl $0
80106f6f:	6a 00                	push   $0x0
  pushl $234
80106f71:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106f76:	e9 84 f1 ff ff       	jmp    801060ff <alltraps>

80106f7b <vector235>:
.globl vector235
vector235:
  pushl $0
80106f7b:	6a 00                	push   $0x0
  pushl $235
80106f7d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106f82:	e9 78 f1 ff ff       	jmp    801060ff <alltraps>

80106f87 <vector236>:
.globl vector236
vector236:
  pushl $0
80106f87:	6a 00                	push   $0x0
  pushl $236
80106f89:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106f8e:	e9 6c f1 ff ff       	jmp    801060ff <alltraps>

80106f93 <vector237>:
.globl vector237
vector237:
  pushl $0
80106f93:	6a 00                	push   $0x0
  pushl $237
80106f95:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106f9a:	e9 60 f1 ff ff       	jmp    801060ff <alltraps>

80106f9f <vector238>:
.globl vector238
vector238:
  pushl $0
80106f9f:	6a 00                	push   $0x0
  pushl $238
80106fa1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106fa6:	e9 54 f1 ff ff       	jmp    801060ff <alltraps>

80106fab <vector239>:
.globl vector239
vector239:
  pushl $0
80106fab:	6a 00                	push   $0x0
  pushl $239
80106fad:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106fb2:	e9 48 f1 ff ff       	jmp    801060ff <alltraps>

80106fb7 <vector240>:
.globl vector240
vector240:
  pushl $0
80106fb7:	6a 00                	push   $0x0
  pushl $240
80106fb9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106fbe:	e9 3c f1 ff ff       	jmp    801060ff <alltraps>

80106fc3 <vector241>:
.globl vector241
vector241:
  pushl $0
80106fc3:	6a 00                	push   $0x0
  pushl $241
80106fc5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106fca:	e9 30 f1 ff ff       	jmp    801060ff <alltraps>

80106fcf <vector242>:
.globl vector242
vector242:
  pushl $0
80106fcf:	6a 00                	push   $0x0
  pushl $242
80106fd1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106fd6:	e9 24 f1 ff ff       	jmp    801060ff <alltraps>

80106fdb <vector243>:
.globl vector243
vector243:
  pushl $0
80106fdb:	6a 00                	push   $0x0
  pushl $243
80106fdd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106fe2:	e9 18 f1 ff ff       	jmp    801060ff <alltraps>

80106fe7 <vector244>:
.globl vector244
vector244:
  pushl $0
80106fe7:	6a 00                	push   $0x0
  pushl $244
80106fe9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106fee:	e9 0c f1 ff ff       	jmp    801060ff <alltraps>

80106ff3 <vector245>:
.globl vector245
vector245:
  pushl $0
80106ff3:	6a 00                	push   $0x0
  pushl $245
80106ff5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106ffa:	e9 00 f1 ff ff       	jmp    801060ff <alltraps>

80106fff <vector246>:
.globl vector246
vector246:
  pushl $0
80106fff:	6a 00                	push   $0x0
  pushl $246
80107001:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107006:	e9 f4 f0 ff ff       	jmp    801060ff <alltraps>

8010700b <vector247>:
.globl vector247
vector247:
  pushl $0
8010700b:	6a 00                	push   $0x0
  pushl $247
8010700d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107012:	e9 e8 f0 ff ff       	jmp    801060ff <alltraps>

80107017 <vector248>:
.globl vector248
vector248:
  pushl $0
80107017:	6a 00                	push   $0x0
  pushl $248
80107019:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010701e:	e9 dc f0 ff ff       	jmp    801060ff <alltraps>

80107023 <vector249>:
.globl vector249
vector249:
  pushl $0
80107023:	6a 00                	push   $0x0
  pushl $249
80107025:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010702a:	e9 d0 f0 ff ff       	jmp    801060ff <alltraps>

8010702f <vector250>:
.globl vector250
vector250:
  pushl $0
8010702f:	6a 00                	push   $0x0
  pushl $250
80107031:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107036:	e9 c4 f0 ff ff       	jmp    801060ff <alltraps>

8010703b <vector251>:
.globl vector251
vector251:
  pushl $0
8010703b:	6a 00                	push   $0x0
  pushl $251
8010703d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107042:	e9 b8 f0 ff ff       	jmp    801060ff <alltraps>

80107047 <vector252>:
.globl vector252
vector252:
  pushl $0
80107047:	6a 00                	push   $0x0
  pushl $252
80107049:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010704e:	e9 ac f0 ff ff       	jmp    801060ff <alltraps>

80107053 <vector253>:
.globl vector253
vector253:
  pushl $0
80107053:	6a 00                	push   $0x0
  pushl $253
80107055:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010705a:	e9 a0 f0 ff ff       	jmp    801060ff <alltraps>

8010705f <vector254>:
.globl vector254
vector254:
  pushl $0
8010705f:	6a 00                	push   $0x0
  pushl $254
80107061:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107066:	e9 94 f0 ff ff       	jmp    801060ff <alltraps>

8010706b <vector255>:
.globl vector255
vector255:
  pushl $0
8010706b:	6a 00                	push   $0x0
  pushl $255
8010706d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107072:	e9 88 f0 ff ff       	jmp    801060ff <alltraps>
80107077:	66 90                	xchg   %ax,%ax
80107079:	66 90                	xchg   %ax,%ax
8010707b:	66 90                	xchg   %ax,%ax
8010707d:	66 90                	xchg   %ax,%ax
8010707f:	90                   	nop

80107080 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107080:	55                   	push   %ebp
80107081:	89 e5                	mov    %esp,%ebp
80107083:	57                   	push   %edi
80107084:	56                   	push   %esi
80107085:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107086:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010708c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107092:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80107095:	39 d3                	cmp    %edx,%ebx
80107097:	73 6e                	jae    80107107 <deallocuvm.part.0+0x87>
80107099:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010709c:	89 c6                	mov    %eax,%esi
8010709e:	89 d7                	mov    %edx,%edi
801070a0:	eb 2a                	jmp    801070cc <deallocuvm.part.0+0x4c>
801070a2:	eb 1c                	jmp    801070c0 <deallocuvm.part.0+0x40>
801070a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070ab:	00 
801070ac:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070b3:	00 
801070b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070bb:	00 
801070bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801070c0:	83 c2 01             	add    $0x1,%edx
801070c3:	89 d3                	mov    %edx,%ebx
801070c5:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
801070c8:	39 fb                	cmp    %edi,%ebx
801070ca:	73 38                	jae    80107104 <deallocuvm.part.0+0x84>
  pde = &pgdir[PDX(va)];
801070cc:	89 da                	mov    %ebx,%edx
801070ce:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801070d1:	8b 04 96             	mov    (%esi,%edx,4),%eax
801070d4:	a8 01                	test   $0x1,%al
801070d6:	74 e8                	je     801070c0 <deallocuvm.part.0+0x40>
  return &pgtab[PTX(va)];
801070d8:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801070da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801070df:	c1 e9 0a             	shr    $0xa,%ecx
801070e2:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
801070e8:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
801070ef:	85 c0                	test   %eax,%eax
801070f1:	74 cd                	je     801070c0 <deallocuvm.part.0+0x40>
    else if((*pte & PTE_P) != 0){
801070f3:	8b 10                	mov    (%eax),%edx
801070f5:	f6 c2 01             	test   $0x1,%dl
801070f8:	75 1e                	jne    80107118 <deallocuvm.part.0+0x98>
  for(; a  < oldsz; a += PGSIZE){
801070fa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107100:	39 fb                	cmp    %edi,%ebx
80107102:	72 c8                	jb     801070cc <deallocuvm.part.0+0x4c>
80107104:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107107:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010710a:	89 c8                	mov    %ecx,%eax
8010710c:	5b                   	pop    %ebx
8010710d:	5e                   	pop    %esi
8010710e:	5f                   	pop    %edi
8010710f:	5d                   	pop    %ebp
80107110:	c3                   	ret
80107111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80107118:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
8010711e:	74 26                	je     80107146 <deallocuvm.part.0+0xc6>
      kfree(v);
80107120:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107123:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107129:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010712c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80107132:	52                   	push   %edx
80107133:	e8 08 b4 ff ff       	call   80102540 <kfree>
      *pte = 0;
80107138:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
8010713b:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
8010713e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80107144:	eb 82                	jmp    801070c8 <deallocuvm.part.0+0x48>
        panic("kfree");
80107146:	83 ec 0c             	sub    $0xc,%esp
80107149:	68 2c 7c 10 80       	push   $0x80107c2c
8010714e:	e8 4d 92 ff ff       	call   801003a0 <panic>
80107153:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010715a:	00 
8010715b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107160 <mappages>:
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	57                   	push   %edi
80107164:	56                   	push   %esi
80107165:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107166:	89 d3                	mov    %edx,%ebx
80107168:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010716e:	83 ec 1c             	sub    $0x1c,%esp
80107171:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107174:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107178:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010717d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107180:	8b 45 08             	mov    0x8(%ebp),%eax
80107183:	29 d8                	sub    %ebx,%eax
80107185:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107188:	eb 3f                	jmp    801071c9 <mappages+0x69>
8010718a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107190:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107192:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107197:	c1 ea 0a             	shr    $0xa,%edx
8010719a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801071a0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801071a7:	85 c0                	test   %eax,%eax
801071a9:	74 75                	je     80107220 <mappages+0xc0>
    if(*pte & PTE_P)
801071ab:	f6 00 01             	testb  $0x1,(%eax)
801071ae:	0f 85 86 00 00 00    	jne    8010723a <mappages+0xda>
    *pte = pa | perm | PTE_P;
801071b4:	0b 75 0c             	or     0xc(%ebp),%esi
801071b7:	83 ce 01             	or     $0x1,%esi
801071ba:	89 30                	mov    %esi,(%eax)
    if(a == last)
801071bc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801071bf:	39 c3                	cmp    %eax,%ebx
801071c1:	74 6d                	je     80107230 <mappages+0xd0>
    a += PGSIZE;
801071c3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801071c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
801071cc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801071cf:	8d 34 03             	lea    (%ebx,%eax,1),%esi
801071d2:	89 d8                	mov    %ebx,%eax
801071d4:	c1 e8 16             	shr    $0x16,%eax
801071d7:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801071da:	8b 07                	mov    (%edi),%eax
801071dc:	a8 01                	test   $0x1,%al
801071de:	75 b0                	jne    80107190 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801071e0:	e8 2b b5 ff ff       	call   80102710 <kalloc>
801071e5:	85 c0                	test   %eax,%eax
801071e7:	74 37                	je     80107220 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
801071e9:	83 ec 04             	sub    $0x4,%esp
801071ec:	68 00 10 00 00       	push   $0x1000
801071f1:	6a 00                	push   $0x0
801071f3:	50                   	push   %eax
801071f4:	89 45 d8             	mov    %eax,-0x28(%ebp)
801071f7:	e8 44 dc ff ff       	call   80104e40 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801071fc:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
801071ff:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107202:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107208:	83 c8 07             	or     $0x7,%eax
8010720b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
8010720d:	89 d8                	mov    %ebx,%eax
8010720f:	c1 e8 0a             	shr    $0xa,%eax
80107212:	25 fc 0f 00 00       	and    $0xffc,%eax
80107217:	01 d0                	add    %edx,%eax
80107219:	eb 90                	jmp    801071ab <mappages+0x4b>
8010721b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80107220:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107223:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107228:	5b                   	pop    %ebx
80107229:	5e                   	pop    %esi
8010722a:	5f                   	pop    %edi
8010722b:	5d                   	pop    %ebp
8010722c:	c3                   	ret
8010722d:	8d 76 00             	lea    0x0(%esi),%esi
80107230:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107233:	31 c0                	xor    %eax,%eax
}
80107235:	5b                   	pop    %ebx
80107236:	5e                   	pop    %esi
80107237:	5f                   	pop    %edi
80107238:	5d                   	pop    %ebp
80107239:	c3                   	ret
      panic("remap");
8010723a:	83 ec 0c             	sub    $0xc,%esp
8010723d:	68 57 7e 10 80       	push   $0x80107e57
80107242:	e8 59 91 ff ff       	call   801003a0 <panic>
80107247:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010724e:	00 
8010724f:	90                   	nop

80107250 <seginit>:
{
80107250:	55                   	push   %ebp
80107251:	89 e5                	mov    %esp,%ebp
80107253:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107256:	e8 45 c7 ff ff       	call   801039a0 <cpuid>
  pd[0] = size-1;
8010725b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107260:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107266:	c7 80 b8 29 11 80 ff 	movl   $0xffff,-0x7feed648(%eax)
8010726d:	ff 00 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107270:	c7 80 c0 29 11 80 ff 	movl   $0xffff,-0x7feed640(%eax)
80107277:	ff 00 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010727a:	c7 80 c8 29 11 80 ff 	movl   $0xffff,-0x7feed638(%eax)
80107281:	ff 00 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107284:	c7 80 d0 29 11 80 ff 	movl   $0xffff,-0x7feed630(%eax)
8010728b:	ff 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010728e:	c7 80 bc 29 11 80 00 	movl   $0xcf9a00,-0x7feed644(%eax)
80107295:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107298:	c7 80 c4 29 11 80 00 	movl   $0xcf9200,-0x7feed63c(%eax)
8010729f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801072a2:	c7 80 cc 29 11 80 00 	movl   $0xcffa00,-0x7feed634(%eax)
801072a9:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801072ac:	c7 80 d4 29 11 80 00 	movl   $0xcff200,-0x7feed62c(%eax)
801072b3:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801072b6:	05 b0 29 11 80       	add    $0x801129b0,%eax
801072bb:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
801072bf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801072c3:	c1 e8 10             	shr    $0x10,%eax
801072c6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801072ca:	8d 45 f2             	lea    -0xe(%ebp),%eax
801072cd:	0f 01 10             	lgdtl  (%eax)
}
801072d0:	c9                   	leave
801072d1:	c3                   	ret
801072d2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801072d9:	00 
801072da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801072e0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801072e0:	a1 84 5d 11 80       	mov    0x80115d84,%eax
801072e5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801072ea:	0f 22 d8             	mov    %eax,%cr3
}
801072ed:	c3                   	ret
801072ee:	66 90                	xchg   %ax,%ax

801072f0 <switchuvm>:
{
801072f0:	55                   	push   %ebp
801072f1:	89 e5                	mov    %esp,%ebp
801072f3:	57                   	push   %edi
801072f4:	56                   	push   %esi
801072f5:	53                   	push   %ebx
801072f6:	83 ec 1c             	sub    $0x1c,%esp
801072f9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801072fc:	85 f6                	test   %esi,%esi
801072fe:	0f 84 cb 00 00 00    	je     801073cf <switchuvm+0xdf>
  if(p->kstack == 0)
80107304:	8b 46 08             	mov    0x8(%esi),%eax
80107307:	85 c0                	test   %eax,%eax
80107309:	0f 84 da 00 00 00    	je     801073e9 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010730f:	8b 46 04             	mov    0x4(%esi),%eax
80107312:	85 c0                	test   %eax,%eax
80107314:	0f 84 c2 00 00 00    	je     801073dc <switchuvm+0xec>
  pushcli();
8010731a:	e8 61 d7 ff ff       	call   80104a80 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010731f:	e8 1c c6 ff ff       	call   80103940 <mycpu>
80107324:	89 c3                	mov    %eax,%ebx
80107326:	e8 15 c6 ff ff       	call   80103940 <mycpu>
8010732b:	89 c7                	mov    %eax,%edi
8010732d:	e8 0e c6 ff ff       	call   80103940 <mycpu>
80107332:	83 c7 08             	add    $0x8,%edi
80107335:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107338:	e8 03 c6 ff ff       	call   80103940 <mycpu>
8010733d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107340:	ba 67 00 00 00       	mov    $0x67,%edx
80107345:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010734c:	83 c0 08             	add    $0x8,%eax
8010734f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107356:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010735b:	83 c1 08             	add    $0x8,%ecx
8010735e:	c1 e8 18             	shr    $0x18,%eax
80107361:	c1 e9 10             	shr    $0x10,%ecx
80107364:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010736a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107370:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107375:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010737c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107381:	e8 ba c5 ff ff       	call   80103940 <mycpu>
80107386:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010738d:	e8 ae c5 ff ff       	call   80103940 <mycpu>
80107392:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107396:	8b 5e 08             	mov    0x8(%esi),%ebx
80107399:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010739f:	e8 9c c5 ff ff       	call   80103940 <mycpu>
801073a4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801073a7:	e8 94 c5 ff ff       	call   80103940 <mycpu>
801073ac:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801073b0:	b8 28 00 00 00       	mov    $0x28,%eax
801073b5:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801073b8:	8b 46 04             	mov    0x4(%esi),%eax
801073bb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801073c0:	0f 22 d8             	mov    %eax,%cr3
}
801073c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073c6:	5b                   	pop    %ebx
801073c7:	5e                   	pop    %esi
801073c8:	5f                   	pop    %edi
801073c9:	5d                   	pop    %ebp
  popcli();
801073ca:	e9 01 d7 ff ff       	jmp    80104ad0 <popcli>
    panic("switchuvm: no process");
801073cf:	83 ec 0c             	sub    $0xc,%esp
801073d2:	68 5d 7e 10 80       	push   $0x80107e5d
801073d7:	e8 c4 8f ff ff       	call   801003a0 <panic>
    panic("switchuvm: no pgdir");
801073dc:	83 ec 0c             	sub    $0xc,%esp
801073df:	68 88 7e 10 80       	push   $0x80107e88
801073e4:	e8 b7 8f ff ff       	call   801003a0 <panic>
    panic("switchuvm: no kstack");
801073e9:	83 ec 0c             	sub    $0xc,%esp
801073ec:	68 73 7e 10 80       	push   $0x80107e73
801073f1:	e8 aa 8f ff ff       	call   801003a0 <panic>
801073f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801073fd:	00 
801073fe:	66 90                	xchg   %ax,%ax

80107400 <inituvm>:
{
80107400:	55                   	push   %ebp
80107401:	89 e5                	mov    %esp,%ebp
80107403:	57                   	push   %edi
80107404:	56                   	push   %esi
80107405:	53                   	push   %ebx
80107406:	83 ec 1c             	sub    $0x1c,%esp
80107409:	8b 45 08             	mov    0x8(%ebp),%eax
8010740c:	8b 75 10             	mov    0x10(%ebp),%esi
8010740f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107412:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107415:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010741b:	77 49                	ja     80107466 <inituvm+0x66>
  mem = kalloc();
8010741d:	e8 ee b2 ff ff       	call   80102710 <kalloc>
  memset(mem, 0, PGSIZE);
80107422:	83 ec 04             	sub    $0x4,%esp
80107425:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010742a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010742c:	6a 00                	push   $0x0
8010742e:	50                   	push   %eax
8010742f:	e8 0c da ff ff       	call   80104e40 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107434:	58                   	pop    %eax
80107435:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010743b:	5a                   	pop    %edx
8010743c:	6a 06                	push   $0x6
8010743e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107443:	31 d2                	xor    %edx,%edx
80107445:	50                   	push   %eax
80107446:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107449:	e8 12 fd ff ff       	call   80107160 <mappages>
  memmove(mem, init, sz);
8010744e:	83 c4 10             	add    $0x10,%esp
80107451:	89 75 10             	mov    %esi,0x10(%ebp)
80107454:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107457:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010745a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010745d:	5b                   	pop    %ebx
8010745e:	5e                   	pop    %esi
8010745f:	5f                   	pop    %edi
80107460:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107461:	e9 6a da ff ff       	jmp    80104ed0 <memmove>
    panic("inituvm: more than a page");
80107466:	83 ec 0c             	sub    $0xc,%esp
80107469:	68 9c 7e 10 80       	push   $0x80107e9c
8010746e:	e8 2d 8f ff ff       	call   801003a0 <panic>
80107473:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010747a:	00 
8010747b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107480 <loaduvm>:
{
80107480:	55                   	push   %ebp
80107481:	89 e5                	mov    %esp,%ebp
80107483:	57                   	push   %edi
80107484:	56                   	push   %esi
80107485:	53                   	push   %ebx
80107486:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107489:	8b 75 0c             	mov    0xc(%ebp),%esi
{
8010748c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
8010748f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80107495:	0f 85 a2 00 00 00    	jne    8010753d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
8010749b:	85 ff                	test   %edi,%edi
8010749d:	74 7d                	je     8010751c <loaduvm+0x9c>
8010749f:	90                   	nop
  pde = &pgdir[PDX(va)];
801074a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801074a3:	8b 55 08             	mov    0x8(%ebp),%edx
801074a6:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
801074a8:	89 c1                	mov    %eax,%ecx
801074aa:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801074ad:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
801074b0:	f6 c1 01             	test   $0x1,%cl
801074b3:	75 13                	jne    801074c8 <loaduvm+0x48>
      panic("loaduvm: address should exist");
801074b5:	83 ec 0c             	sub    $0xc,%esp
801074b8:	68 b6 7e 10 80       	push   $0x80107eb6
801074bd:	e8 de 8e ff ff       	call   801003a0 <panic>
801074c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801074c8:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801074cb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801074d1:	25 fc 0f 00 00       	and    $0xffc,%eax
801074d6:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801074dd:	85 c9                	test   %ecx,%ecx
801074df:	74 d4                	je     801074b5 <loaduvm+0x35>
    if(sz - i < PGSIZE)
801074e1:	89 fb                	mov    %edi,%ebx
801074e3:	b8 00 10 00 00       	mov    $0x1000,%eax
801074e8:	29 f3                	sub    %esi,%ebx
801074ea:	39 c3                	cmp    %eax,%ebx
801074ec:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
801074ef:	53                   	push   %ebx
801074f0:	8b 45 14             	mov    0x14(%ebp),%eax
801074f3:	01 f0                	add    %esi,%eax
801074f5:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
801074f6:	8b 01                	mov    (%ecx),%eax
801074f8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801074fd:	05 00 00 00 80       	add    $0x80000000,%eax
80107502:	50                   	push   %eax
80107503:	ff 75 10             	push   0x10(%ebp)
80107506:	e8 f5 a5 ff ff       	call   80101b00 <readi>
8010750b:	83 c4 10             	add    $0x10,%esp
8010750e:	39 d8                	cmp    %ebx,%eax
80107510:	75 1e                	jne    80107530 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80107512:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107518:	39 fe                	cmp    %edi,%esi
8010751a:	72 84                	jb     801074a0 <loaduvm+0x20>
}
8010751c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010751f:	31 c0                	xor    %eax,%eax
}
80107521:	5b                   	pop    %ebx
80107522:	5e                   	pop    %esi
80107523:	5f                   	pop    %edi
80107524:	5d                   	pop    %ebp
80107525:	c3                   	ret
80107526:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010752d:	00 
8010752e:	66 90                	xchg   %ax,%ax
80107530:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107533:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107538:	5b                   	pop    %ebx
80107539:	5e                   	pop    %esi
8010753a:	5f                   	pop    %edi
8010753b:	5d                   	pop    %ebp
8010753c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
8010753d:	83 ec 0c             	sub    $0xc,%esp
80107540:	68 e4 80 10 80       	push   $0x801080e4
80107545:	e8 56 8e ff ff       	call   801003a0 <panic>
8010754a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107550 <allocuvm>:
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	57                   	push   %edi
80107554:	56                   	push   %esi
80107555:	53                   	push   %ebx
80107556:	83 ec 1c             	sub    $0x1c,%esp
80107559:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
8010755c:	85 f6                	test   %esi,%esi
8010755e:	0f 88 99 00 00 00    	js     801075fd <allocuvm+0xad>
80107564:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80107566:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107569:	0f 82 a1 00 00 00    	jb     80107610 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010756f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107572:	05 ff 0f 00 00       	add    $0xfff,%eax
80107577:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010757c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
8010757e:	39 f0                	cmp    %esi,%eax
80107580:	0f 83 8d 00 00 00    	jae    80107613 <allocuvm+0xc3>
80107586:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80107589:	eb 45                	jmp    801075d0 <allocuvm+0x80>
8010758b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107590:	83 ec 04             	sub    $0x4,%esp
80107593:	68 00 10 00 00       	push   $0x1000
80107598:	6a 00                	push   $0x0
8010759a:	50                   	push   %eax
8010759b:	e8 a0 d8 ff ff       	call   80104e40 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801075a0:	58                   	pop    %eax
801075a1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801075a7:	5a                   	pop    %edx
801075a8:	6a 06                	push   $0x6
801075aa:	b9 00 10 00 00       	mov    $0x1000,%ecx
801075af:	89 fa                	mov    %edi,%edx
801075b1:	50                   	push   %eax
801075b2:	8b 45 08             	mov    0x8(%ebp),%eax
801075b5:	e8 a6 fb ff ff       	call   80107160 <mappages>
801075ba:	83 c4 10             	add    $0x10,%esp
801075bd:	83 f8 ff             	cmp    $0xffffffff,%eax
801075c0:	74 5e                	je     80107620 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
801075c2:	81 c7 00 10 00 00    	add    $0x1000,%edi
801075c8:	39 f7                	cmp    %esi,%edi
801075ca:	0f 83 88 00 00 00    	jae    80107658 <allocuvm+0x108>
    mem = kalloc();
801075d0:	e8 3b b1 ff ff       	call   80102710 <kalloc>
801075d5:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801075d7:	85 c0                	test   %eax,%eax
801075d9:	75 b5                	jne    80107590 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801075db:	83 ec 0c             	sub    $0xc,%esp
801075de:	68 d4 7e 10 80       	push   $0x80107ed4
801075e3:	e8 e8 90 ff ff       	call   801006d0 <cprintf>
  if(newsz >= oldsz)
801075e8:	83 c4 10             	add    $0x10,%esp
801075eb:	3b 75 0c             	cmp    0xc(%ebp),%esi
801075ee:	74 0d                	je     801075fd <allocuvm+0xad>
801075f0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801075f3:	8b 45 08             	mov    0x8(%ebp),%eax
801075f6:	89 f2                	mov    %esi,%edx
801075f8:	e8 83 fa ff ff       	call   80107080 <deallocuvm.part.0>
    return 0;
801075fd:	31 d2                	xor    %edx,%edx
}
801075ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107602:	89 d0                	mov    %edx,%eax
80107604:	5b                   	pop    %ebx
80107605:	5e                   	pop    %esi
80107606:	5f                   	pop    %edi
80107607:	5d                   	pop    %ebp
80107608:	c3                   	ret
80107609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107610:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80107613:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107616:	89 d0                	mov    %edx,%eax
80107618:	5b                   	pop    %ebx
80107619:	5e                   	pop    %esi
8010761a:	5f                   	pop    %edi
8010761b:	5d                   	pop    %ebp
8010761c:	c3                   	ret
8010761d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107620:	83 ec 0c             	sub    $0xc,%esp
80107623:	68 ec 7e 10 80       	push   $0x80107eec
80107628:	e8 a3 90 ff ff       	call   801006d0 <cprintf>
  if(newsz >= oldsz)
8010762d:	83 c4 10             	add    $0x10,%esp
80107630:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107633:	74 0d                	je     80107642 <allocuvm+0xf2>
80107635:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107638:	8b 45 08             	mov    0x8(%ebp),%eax
8010763b:	89 f2                	mov    %esi,%edx
8010763d:	e8 3e fa ff ff       	call   80107080 <deallocuvm.part.0>
      kfree(mem);
80107642:	83 ec 0c             	sub    $0xc,%esp
80107645:	53                   	push   %ebx
80107646:	e8 f5 ae ff ff       	call   80102540 <kfree>
      return 0;
8010764b:	83 c4 10             	add    $0x10,%esp
    return 0;
8010764e:	31 d2                	xor    %edx,%edx
80107650:	eb ad                	jmp    801075ff <allocuvm+0xaf>
80107652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107658:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
8010765b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010765e:	5b                   	pop    %ebx
8010765f:	5e                   	pop    %esi
80107660:	89 d0                	mov    %edx,%eax
80107662:	5f                   	pop    %edi
80107663:	5d                   	pop    %ebp
80107664:	c3                   	ret
80107665:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010766c:	00 
8010766d:	8d 76 00             	lea    0x0(%esi),%esi

80107670 <deallocuvm>:
{
80107670:	55                   	push   %ebp
80107671:	89 e5                	mov    %esp,%ebp
80107673:	8b 55 0c             	mov    0xc(%ebp),%edx
80107676:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107679:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010767c:	39 d1                	cmp    %edx,%ecx
8010767e:	73 10                	jae    80107690 <deallocuvm+0x20>
}
80107680:	5d                   	pop    %ebp
80107681:	e9 fa f9 ff ff       	jmp    80107080 <deallocuvm.part.0>
80107686:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010768d:	00 
8010768e:	66 90                	xchg   %ax,%ax
80107690:	89 d0                	mov    %edx,%eax
80107692:	5d                   	pop    %ebp
80107693:	c3                   	ret
80107694:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010769b:	00 
8010769c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801076a0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801076a0:	55                   	push   %ebp
801076a1:	89 e5                	mov    %esp,%ebp
801076a3:	57                   	push   %edi
801076a4:	56                   	push   %esi
801076a5:	53                   	push   %ebx
801076a6:	83 ec 0c             	sub    $0xc,%esp
801076a9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801076ac:	85 f6                	test   %esi,%esi
801076ae:	74 59                	je     80107709 <freevm+0x69>
  if(newsz >= oldsz)
801076b0:	31 c9                	xor    %ecx,%ecx
801076b2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801076b7:	89 f0                	mov    %esi,%eax
801076b9:	89 f3                	mov    %esi,%ebx
801076bb:	e8 c0 f9 ff ff       	call   80107080 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801076c0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801076c6:	eb 0f                	jmp    801076d7 <freevm+0x37>
801076c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801076cf:	00 
801076d0:	83 c3 04             	add    $0x4,%ebx
801076d3:	39 fb                	cmp    %edi,%ebx
801076d5:	74 23                	je     801076fa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801076d7:	8b 03                	mov    (%ebx),%eax
801076d9:	a8 01                	test   $0x1,%al
801076db:	74 f3                	je     801076d0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801076dd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801076e2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
801076e5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801076e8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801076ed:	50                   	push   %eax
801076ee:	e8 4d ae ff ff       	call   80102540 <kfree>
801076f3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801076f6:	39 fb                	cmp    %edi,%ebx
801076f8:	75 dd                	jne    801076d7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801076fa:	89 75 08             	mov    %esi,0x8(%ebp)
}
801076fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107700:	5b                   	pop    %ebx
80107701:	5e                   	pop    %esi
80107702:	5f                   	pop    %edi
80107703:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107704:	e9 37 ae ff ff       	jmp    80102540 <kfree>
    panic("freevm: no pgdir");
80107709:	83 ec 0c             	sub    $0xc,%esp
8010770c:	68 08 7f 10 80       	push   $0x80107f08
80107711:	e8 8a 8c ff ff       	call   801003a0 <panic>
80107716:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010771d:	00 
8010771e:	66 90                	xchg   %ax,%ax

80107720 <setupkvm>:
{
80107720:	55                   	push   %ebp
80107721:	89 e5                	mov    %esp,%ebp
80107723:	56                   	push   %esi
80107724:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107725:	e8 e6 af ff ff       	call   80102710 <kalloc>
8010772a:	85 c0                	test   %eax,%eax
8010772c:	74 5e                	je     8010778c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
8010772e:	83 ec 04             	sub    $0x4,%esp
80107731:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107733:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107738:	68 00 10 00 00       	push   $0x1000
8010773d:	6a 00                	push   $0x0
8010773f:	50                   	push   %eax
80107740:	e8 fb d6 ff ff       	call   80104e40 <memset>
80107745:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107748:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010774b:	83 ec 08             	sub    $0x8,%esp
8010774e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107751:	8b 13                	mov    (%ebx),%edx
80107753:	ff 73 0c             	push   0xc(%ebx)
80107756:	50                   	push   %eax
80107757:	29 c1                	sub    %eax,%ecx
80107759:	89 f0                	mov    %esi,%eax
8010775b:	e8 00 fa ff ff       	call   80107160 <mappages>
80107760:	83 c4 10             	add    $0x10,%esp
80107763:	83 f8 ff             	cmp    $0xffffffff,%eax
80107766:	74 18                	je     80107780 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107768:	83 c3 10             	add    $0x10,%ebx
8010776b:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107771:	75 d5                	jne    80107748 <setupkvm+0x28>
}
80107773:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107776:	89 f0                	mov    %esi,%eax
80107778:	5b                   	pop    %ebx
80107779:	5e                   	pop    %esi
8010777a:	5d                   	pop    %ebp
8010777b:	c3                   	ret
8010777c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107780:	83 ec 0c             	sub    $0xc,%esp
80107783:	56                   	push   %esi
80107784:	e8 17 ff ff ff       	call   801076a0 <freevm>
      return 0;
80107789:	83 c4 10             	add    $0x10,%esp
}
8010778c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010778f:	31 f6                	xor    %esi,%esi
}
80107791:	89 f0                	mov    %esi,%eax
80107793:	5b                   	pop    %ebx
80107794:	5e                   	pop    %esi
80107795:	5d                   	pop    %ebp
80107796:	c3                   	ret
80107797:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010779e:	00 
8010779f:	90                   	nop

801077a0 <kvmalloc>:
{
801077a0:	55                   	push   %ebp
801077a1:	89 e5                	mov    %esp,%ebp
801077a3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801077a6:	e8 75 ff ff ff       	call   80107720 <setupkvm>
801077ab:	a3 84 5d 11 80       	mov    %eax,0x80115d84
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801077b0:	05 00 00 00 80       	add    $0x80000000,%eax
801077b5:	0f 22 d8             	mov    %eax,%cr3
}
801077b8:	c9                   	leave
801077b9:	c3                   	ret
801077ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801077c0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801077c0:	55                   	push   %ebp
801077c1:	89 e5                	mov    %esp,%ebp
801077c3:	83 ec 08             	sub    $0x8,%esp
801077c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801077c9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801077cc:	89 c1                	mov    %eax,%ecx
801077ce:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801077d1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801077d4:	f6 c2 01             	test   $0x1,%dl
801077d7:	75 17                	jne    801077f0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801077d9:	83 ec 0c             	sub    $0xc,%esp
801077dc:	68 19 7f 10 80       	push   $0x80107f19
801077e1:	e8 ba 8b ff ff       	call   801003a0 <panic>
801077e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801077ed:	00 
801077ee:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
801077f0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801077f3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801077f9:	25 fc 0f 00 00       	and    $0xffc,%eax
801077fe:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107805:	85 c0                	test   %eax,%eax
80107807:	74 d0                	je     801077d9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107809:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010780c:	c9                   	leave
8010780d:	c3                   	ret
8010780e:	66 90                	xchg   %ax,%ax

80107810 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107810:	55                   	push   %ebp
80107811:	89 e5                	mov    %esp,%ebp
80107813:	57                   	push   %edi
80107814:	56                   	push   %esi
80107815:	53                   	push   %ebx
80107816:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107819:	e8 02 ff ff ff       	call   80107720 <setupkvm>
8010781e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107821:	85 c0                	test   %eax,%eax
80107823:	0f 84 e9 00 00 00    	je     80107912 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107829:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010782c:	85 c9                	test   %ecx,%ecx
8010782e:	0f 84 b3 00 00 00    	je     801078e7 <copyuvm+0xd7>
80107834:	31 f6                	xor    %esi,%esi
80107836:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010783d:	00 
8010783e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80107840:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107843:	89 f0                	mov    %esi,%eax
80107845:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107848:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010784b:	a8 01                	test   $0x1,%al
8010784d:	75 11                	jne    80107860 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010784f:	83 ec 0c             	sub    $0xc,%esp
80107852:	68 23 7f 10 80       	push   $0x80107f23
80107857:	e8 44 8b ff ff       	call   801003a0 <panic>
8010785c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107860:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107862:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107867:	c1 ea 0a             	shr    $0xa,%edx
8010786a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107870:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107877:	85 c0                	test   %eax,%eax
80107879:	74 d4                	je     8010784f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010787b:	8b 00                	mov    (%eax),%eax
8010787d:	a8 01                	test   $0x1,%al
8010787f:	0f 84 96 00 00 00    	je     8010791b <copyuvm+0x10b>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107885:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107887:	25 ff 0f 00 00       	and    $0xfff,%eax
8010788c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010788f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107895:	e8 76 ae ff ff       	call   80102710 <kalloc>
8010789a:	89 c3                	mov    %eax,%ebx
8010789c:	85 c0                	test   %eax,%eax
8010789e:	74 64                	je     80107904 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801078a0:	83 ec 04             	sub    $0x4,%esp
801078a3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801078a9:	68 00 10 00 00       	push   $0x1000
801078ae:	57                   	push   %edi
801078af:	50                   	push   %eax
801078b0:	e8 1b d6 ff ff       	call   80104ed0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801078b5:	58                   	pop    %eax
801078b6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801078bc:	5a                   	pop    %edx
801078bd:	ff 75 e4             	push   -0x1c(%ebp)
801078c0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801078c5:	89 f2                	mov    %esi,%edx
801078c7:	50                   	push   %eax
801078c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801078cb:	e8 90 f8 ff ff       	call   80107160 <mappages>
801078d0:	83 c4 10             	add    $0x10,%esp
801078d3:	83 f8 ff             	cmp    $0xffffffff,%eax
801078d6:	74 20                	je     801078f8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801078d8:	81 c6 00 10 00 00    	add    $0x1000,%esi
801078de:	3b 75 0c             	cmp    0xc(%ebp),%esi
801078e1:	0f 82 59 ff ff ff    	jb     80107840 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801078e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801078ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078ed:	5b                   	pop    %ebx
801078ee:	5e                   	pop    %esi
801078ef:	5f                   	pop    %edi
801078f0:	5d                   	pop    %ebp
801078f1:	c3                   	ret
801078f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      kfree(mem);
801078f8:	83 ec 0c             	sub    $0xc,%esp
801078fb:	53                   	push   %ebx
801078fc:	e8 3f ac ff ff       	call   80102540 <kfree>
      goto bad;
80107901:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107904:	83 ec 0c             	sub    $0xc,%esp
80107907:	ff 75 e0             	push   -0x20(%ebp)
8010790a:	e8 91 fd ff ff       	call   801076a0 <freevm>
  return 0;
8010790f:	83 c4 10             	add    $0x10,%esp
    return 0;
80107912:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107919:	eb cc                	jmp    801078e7 <copyuvm+0xd7>
      panic("copyuvm: page not present");
8010791b:	83 ec 0c             	sub    $0xc,%esp
8010791e:	68 3d 7f 10 80       	push   $0x80107f3d
80107923:	e8 78 8a ff ff       	call   801003a0 <panic>
80107928:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010792f:	00 

80107930 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107930:	55                   	push   %ebp
80107931:	89 e5                	mov    %esp,%ebp
80107933:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107936:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107939:	89 c1                	mov    %eax,%ecx
8010793b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010793e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107941:	f6 c2 01             	test   $0x1,%dl
80107944:	0f 84 f0 00 00 00    	je     80107a3a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010794a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010794d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107953:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107954:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107959:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107960:	89 d0                	mov    %edx,%eax
80107962:	f7 d2                	not    %edx
80107964:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107969:	05 00 00 00 80       	add    $0x80000000,%eax
8010796e:	83 e2 05             	and    $0x5,%edx
80107971:	ba 00 00 00 00       	mov    $0x0,%edx
80107976:	0f 45 c2             	cmovne %edx,%eax
}
80107979:	c3                   	ret
8010797a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107980 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107980:	55                   	push   %ebp
80107981:	89 e5                	mov    %esp,%ebp
80107983:	57                   	push   %edi
80107984:	56                   	push   %esi
80107985:	53                   	push   %ebx
80107986:	83 ec 0c             	sub    $0xc,%esp
80107989:	8b 75 14             	mov    0x14(%ebp),%esi
8010798c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010798f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107992:	85 f6                	test   %esi,%esi
80107994:	75 49                	jne    801079df <copyout+0x5f>
80107996:	e9 95 00 00 00       	jmp    80107a30 <copyout+0xb0>
8010799b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
801079a0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801079a5:	05 00 00 00 80       	add    $0x80000000,%eax
801079aa:	74 6e                	je     80107a1a <copyout+0x9a>
      return -1;
    n = PGSIZE - (va - va0);
801079ac:	89 fb                	mov    %edi,%ebx
801079ae:	29 cb                	sub    %ecx,%ebx
801079b0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801079b6:	39 f3                	cmp    %esi,%ebx
801079b8:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801079bb:	29 f9                	sub    %edi,%ecx
801079bd:	83 ec 04             	sub    $0x4,%esp
801079c0:	01 c8                	add    %ecx,%eax
801079c2:	53                   	push   %ebx
801079c3:	52                   	push   %edx
801079c4:	89 55 10             	mov    %edx,0x10(%ebp)
801079c7:	50                   	push   %eax
801079c8:	e8 03 d5 ff ff       	call   80104ed0 <memmove>
    len -= n;
    buf += n;
801079cd:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801079d0:	8d 8f 00 10 00 00    	lea    0x1000(%edi),%ecx
  while(len > 0){
801079d6:	83 c4 10             	add    $0x10,%esp
    buf += n;
801079d9:	01 da                	add    %ebx,%edx
  while(len > 0){
801079db:	29 de                	sub    %ebx,%esi
801079dd:	74 51                	je     80107a30 <copyout+0xb0>
  if(*pde & PTE_P){
801079df:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801079e2:	89 c8                	mov    %ecx,%eax
    va0 = (uint)PGROUNDDOWN(va);
801079e4:	89 cf                	mov    %ecx,%edi
  pde = &pgdir[PDX(va)];
801079e6:	c1 e8 16             	shr    $0x16,%eax
    va0 = (uint)PGROUNDDOWN(va);
801079e9:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801079ef:	8b 04 83             	mov    (%ebx,%eax,4),%eax
801079f2:	a8 01                	test   $0x1,%al
801079f4:	0f 84 47 00 00 00    	je     80107a41 <copyout.cold>
  return &pgtab[PTX(va)];
801079fa:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801079fc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107a01:	c1 eb 0c             	shr    $0xc,%ebx
80107a04:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107a0a:	8b 84 98 00 00 00 80 	mov    -0x80000000(%eax,%ebx,4),%eax
  if((*pte & PTE_U) == 0)
80107a11:	89 c3                	mov    %eax,%ebx
80107a13:	f7 d3                	not    %ebx
80107a15:	83 e3 05             	and    $0x5,%ebx
80107a18:	74 86                	je     801079a0 <copyout+0x20>
  }
  return 0;
}
80107a1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107a1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107a22:	5b                   	pop    %ebx
80107a23:	5e                   	pop    %esi
80107a24:	5f                   	pop    %edi
80107a25:	5d                   	pop    %ebp
80107a26:	c3                   	ret
80107a27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a2e:	00 
80107a2f:	90                   	nop
80107a30:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107a33:	31 c0                	xor    %eax,%eax
}
80107a35:	5b                   	pop    %ebx
80107a36:	5e                   	pop    %esi
80107a37:	5f                   	pop    %edi
80107a38:	5d                   	pop    %ebp
80107a39:	c3                   	ret

80107a3a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107a3a:	a1 00 00 00 00       	mov    0x0,%eax
80107a3f:	0f 0b                	ud2

80107a41 <copyout.cold>:
80107a41:	a1 00 00 00 00       	mov    0x0,%eax
80107a46:	0f 0b                	ud2
