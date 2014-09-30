#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <linux/unistd.h>       /* for _syscallX macros/related stuff */
#include <linux/kernel.h>       /* for struct sysinfo */
#include <proc/sysinfo.h>
#include <limits.h>
/*_syscall1(int, sysinfo, struct sysinfo *, info);*/
/* Note: if you copy directly from the nroff source, remember to
REMOVE the extra backslashes in the printf statement. */

#define RATE 10

int main(void)
{
  char rrd[255]; 
  struct sysinfo s_info;
  int error;
  int i;
  unsigned short all = 0;
  unsigned short max = 0;
  unsigned short min = USHRT_MAX;
  unsigned short avg;
  unsigned long memt;
  unsigned long memf;
//  unsigned long memfc;
  unsigned long memu;
  unsigned short memp;
  while (1) {
    for (i=0;i<RATE;i++) {
      error = sysinfo(&s_info);
      meminfo();
      memt = s_info.totalram/1024;
//      memfc = (s_info.freeram) /1024;
      memf = (s_info.freeram)/1024 + (kb_main_cached);
      memu = memt-memf;
      memp = (1000*memu)/memt;
      if (memp > max) max = memp;
      if (memp < min) min = memp;
      all += memp;
//        printf("time: %02d ",i);
//	printf("used: %4d.%d%%\n",memp/10,memp%10);
//	printf("free %4d / %4d\n",memf,kb_main_cached/1024);
      usleep(1000000/RATE);
    }
    /*printf("---\nmin: %3d\nmax: %3d\navg: %3d\n",min/10,max/10,all/(10*10));*/
    avg = all/RATE;
    /*printf("--- --- ---\n");
    printf("min: %3d.%d ",min/10,min%10);
    printf("max: %3d.%d ",max/10,max%10);
    printf("avg: %3d.%d ",avg/10,avg%10);
    printf("\n");*/
    sprintf(rrd,
	    "/usr/bin/rrdupdate /root/.rrd/mem_fast.rrd N:%d.%d:%d.%d:%d.%d",
	    min/10,min%10,
	    max/10,max%10,
	    avg/10,avg%10);
    system(rrd);
    sprintf(rrd,
	    "/usr/bin/rrdupdate /root/.rrd/mem_fast2.rrd N:%d.%d:%d.%d:%d.%d",
	    min/10,min%10,
	    max/10,max%10,
	    avg/10,avg%10);
    system(rrd);
    all = 0;
    max = 0;
    min = USHRT_MAX;
  }
  _exit(0);
}

/*
struct sysinfo {
    long uptime;             * Seconds since boot *
    unsigned long loads[3];  * 1, 5, and 15 minute load averages *
    unsigned long totalram;  * Total usable main memory size *
    unsigned long freeram;   * Available memory size *
    unsigned long sharedram; * Amount of shared memory *
    unsigned long bufferram; * Memory used by buffers *
    unsigned long totalswap; * Total swap space size *
    unsigned long freeswap;  * swap space still available *
    unsigned short procs;    * Number of current processes *
    unsigned long totalhigh; * Total high memory size *
    unsigned long freehigh;  * Available high memory size *
    unsigned int mem_unit;   * Memory unit size in bytes *
    char _f[20-2*sizeof(long)-sizeof(int)]; * Padding for libc5 *
};*/
