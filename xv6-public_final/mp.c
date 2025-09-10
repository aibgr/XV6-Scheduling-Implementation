// mp.c
// Multiprocessor support
// Search memory for MP description structures.
// http://developer.intel.com/design/pentium/datashts/24201606.pdf

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mp.h"
#include "x86.h"
#include "mmu.h"
#include "proc.h"

// CPUs
struct cpu cpus[NCPU];
int ncpu;

// IO APIC id (set when parsing MP table)
extern uchar ioapicid;

// lapic pointer (defined in lapic.c)
extern volatile uint *lapic;

static uchar
sum(uchar *addr, int len)
{
  int i;
  int s = 0;
  for(i = 0; i < len; i++)
    s += addr[i];
  return (uchar)(s & 0xff);
}

// Look for an MP structure in the len bytes at physical address a.
static struct mp*
mpsearch1(uint a, int len)
{
  uchar *e, *p, *addr;

  addr = (uchar*)P2V(a);
  e = addr + len;
  for(p = addr; p < e; p += sizeof(struct mp)){
    if(memcmp(p, "_MP_", 4) == 0 && sum((uchar*)p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  }
  return 0;
}

// Search for the MP Floating Pointer Structure in standard locations.
static struct mp*
mpsearch(void)
{
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  // EBDA base from BIOS Data Area
  if((p = ((bda[0x0F]<<8) | bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    // Last kilobyte of base memory
    p = ((bda[0x14]<<8) | bda[0x13]) * 1024;
    if((mp = mpsearch1(p - 1024, 1024)))
      return mp;
  }
  // BIOS ROM area
  return mpsearch1(0xF0000, 0x10000);
}

// Search for an MP configuration table. Verify signature, checksum and version.
static struct mpconf*
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp((char*)conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
    return 0;
  *pmp = mp;
  return conf;
}

void
mpinit(void)
{
  uchar *p, *e;
  int ismp;
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *mioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;

  // lapic physical address is in the MP config table
  lapic = (volatile uint*)conf->lapicaddr;

  // Walk entries in MP config table
  for(p = (uchar*)(conf + 1), e = (uchar*)conf + conf->length; p < e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU){
        cpus[ncpu].apicid = proc->apicid;  // APIC id may differ from logical cpu number
        ncpu++;
      }
      p += sizeof(struct mpproc);
      continue;

    case MPIOAPIC:
      mioapic = (struct mpioapic*)p;
      ioapicid = mioapic->apicno;   // record IO APIC id
      p += sizeof(struct mpioapic);
      continue;

    case MPBUS:
      p += 8;
      continue;

    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;

    default:
      ismp = 0;
      break;
    }
  }

  if(!ismp)
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
    // If an interrupt mode change register is present, program it.
    // (Bochs does not support IMCR; this code is for real hardware.)
    outb(0x22, 0x70);                 // Select IMCR
    outb(0x23, inb(0x23) | 1);        // Mask external interrupts.
  }
}

