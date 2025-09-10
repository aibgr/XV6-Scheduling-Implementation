#ifndef _STAT_H_
#define _STAT_H_

#define T_DIR  1   // Directory
#define T_FILE 2   // File
#define T_DEV  3   // Device

struct stat {
  int dev;     // File system’s disk device
  uint ino;    // Inode number
  short type;  // Type (T_DIR, T_FILE, etc.)
  short nlink; // Number of links
  uint size;   // Size of file in bytes
};

#endif // _STAT_H_

