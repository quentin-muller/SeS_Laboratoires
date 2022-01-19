//gcc -Wall -Wextra -o write_skeleton write_skeleton.c


#define _GNU_SOURCE
#include <sched.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>
#include <time.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define SIZE 31

#define NB_SMALL_FILE 1000
#define NB_BIG_FILE 1

#define SIZE_SMALL 1024
#define SIZE_BIG 1048576

static double diff(struct timespec start, struct timespec end);
static int writeSmallFiles();
static int writeBigFile();


int main (int argc, char *argv[])
{
int      ret;
int      cpu;
cpu_set_t set;
struct sched_param sp = {.sched_priority = 50, };
struct timespec    tStart, tEnd;

    // cpu and task priority
    if (argc == 2)
    {
        cpu    = atoi(argv[1]);
    }
    else
    {
        cpu = 0;
    }

    
    CPU_ZERO (&set);
    CPU_SET (cpu, &set);
    ret=sched_setaffinity (0, sizeof(set), &set);
    printf ("setaffinity=%d\n", ret);

    ret=sched_setscheduler (0, SCHED_FIFO, &sp);
    printf ("setscheduler=%d\n", ret);
    

    
    clock_gettime(CLOCK_REALTIME, &tStart);	
    writeSmallFiles();
    clock_gettime(CLOCK_REALTIME, &tEnd);
    printf ("Write small files, time[s]: %f\n", diff(tStart, tEnd));

    clock_gettime(CLOCK_REALTIME, &tStart);	
    writeBigFile();
    clock_gettime(CLOCK_REALTIME, &tEnd);
    printf ("Write big files, time[s]: %f\n", diff(tStart, tEnd));

    return (0);
}


static int writeSmallFiles()
{
    char filename[SIZE];
    char tab[SIZE_SMALL];
    FILE * fp;

    for (int i = 0; i < NB_SMALL_FILE; i++)
    {
        sprintf(filename, "smallfile_%03d.ses",i);
        fp = fopen(filename,"w");
        if (fp == NULL)
        {
            printf( "Cannot open file %s\n", filename);
            return -1;
        }
        for (int i = 0; i < SIZE_SMALL; i++)
        {
            tab[i] = 'a';
        }
        fprintf(fp, tab);
        fclose(fp);
    }
    
    return 0;
}

static int writeBigFile()
{
    char tab[SIZE_BIG];
    FILE * fp;

    fp = fopen("bigfile.ses","w");
    if (fp == NULL)
    {
        printf( "Cannot open file file_big\n");
        return -1;
    }
    for (int i = 0; i < SIZE_BIG; i++)
    {
        tab[i] = 'a';
    }
    
    fprintf(fp, tab);
    fclose(fp);
    return 0;
}


static double diff(struct timespec start, struct timespec end)
{
double t1, t2;

    t1 = (double)start.tv_sec;
    t1 = t1 + ((double)start.tv_nsec)/1000000000.0;
    t2 = (double)end.tv_sec;
    t2 = t2 + ((double)end.tv_nsec)/1000000000.0;

    return (t2-t1);
}






