// fcntl.h - File control options for open()

#ifndef _FCNTL_H_
#define _FCNTL_H_

// open() flags
#define O_RDONLY  0x000   // open for reading only
#define O_WRONLY  0x001   // open for writing only
#define O_RDWR    0x002   // open for reading and writing
#define O_CREATE  0x200   // create file if it does not exist
#define O_TRUNC   0x400   // truncate size to 0

#endif // _FCNTL_H_

