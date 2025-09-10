// buf.h
struct buf {
  int flags;
  uint dev;
  uint blockno;
  struct sleeplock lock;
  uint refcnt;

  // Linked list pointers
  struct buf *prev;   // LRU cache list
  struct buf *next;   // LRU cache list
  struct buf *qnext;  // disk queue

  uchar data[BSIZE];
};

// Buffer flags
#define B_VALID 0x2  // buffer has been read from disk
#define B_DIRTY 0x4  // buffer needs to be written to disk

