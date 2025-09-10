#ifndef _TRAPS_H_
#define _TRAPS_H_

// x86 trap and interrupt vectors.
// We reserve vectors 0-31 for processor exceptions.
// Interrupts start at 32.

#define T_DIVIDE         0    // divide error
#define T_DEBUG          1    // debug exception
#define T_NMI            2    // non-maskable interrupt
#define T_BRKPT          3    // breakpoint
#define T_OFLOW          4    // overflow
#define T_BOUND          5    // bounds check
#define T_ILLOP          6    // illegal opcode
#define T_DEVICE         7    // device not available
#define T_DBLFLT         8    // double fault
// 9 is reserved
#define T_TSS           10    // invalid task switch segment
#define T_SEGNP         11    // segment not present
#define T_STACK         12    // stack exception
#define T_GPFLT         13    // general protection fault
#define T_PGFLT         14    // page fault
// 15 is reserved
#define T_FPERR         16    // floating point error
#define T_ALIGN         17    // alignment check
#define T_MCHK          18    // machine check
#define T_SIMDERR       19    // SIMD floating point error

// system call trap
#define T_SYSCALL       64
#define T_DEFAULT      500      // catchall

#define T_IRQ0         32       // IRQ 0 corresponds to int T_IRQ0

// IRQ numbers
#define IRQ_TIMER        0
#define IRQ_KBD          1
#define IRQ_COM1         4
#define IRQ_IDE         14
#define IRQ_ERROR       19
#define IRQ_SPURIOUS    31

#endif // _TRAPS_H_

