#include <stdio.h>
#include <time.h>

#define ARRAYLENGTH 100000

/* binsearch: find x in v[0] <= v[1] <= ... <= v[n-1] */ 
// Heh, there is a bug in this code.
// It should be -1 not +1 when chopping off the upper half
int binsearchold(int x, int v[], int n) 
{ 
    int low, high, mid;
    low = 0; high = n - 1; 

    while (low <= high) 
    { 
        mid = (low+high)/2; 
        
        if (x < v[mid]) 
            high = mid - 1; 
        else if (x > v[mid]) 
            low = mid + 1; 
        else 
            /* found match */ 
            return mid; 
    } 
    return -1; /* no match */ 
}

/* 
 * Our binary search makes two tests inside the loop, when one would suffice
 * (at the price of more tests outside). Write a version with only one test
 * inside the loop and measure the difference in run-time.
 *
 */

int binsearch(int x, int v[], int n)
{
    int low, high, mid;
    low = 0;
    high = n - 1;

    // while low bound is lower than high bound
    while(low < high)
    {
        mid = (low + high) / 2;
        // if our sample is larger than x
        if (x < v[mid])
            // chop the larger half off
            // and set high to 1 less than mid, cause we just checked it
            high = mid - 1;
        else // chop the lower half off
            // and set low to mid + one, cause we just checked it
            low = mid + 1;
    }

    if (mid == x) // if match found
        return mid; 

    return -1; // no match
}


int main(int argc, const char *argv[])
{

    int binsearchold(int x, int v[], int n);
    int binsearc(int x, int v[], int n);
    int result, i;

    int bigarray[ARRAYLENGTH]; 
    for (i = 0; i < ARRAYLENGTH; i++) {
        bigarray[i] = i;
    }

    // Precision depends on the architecture, keeping that in mind.
    // Should be under 10 ms on new systems, around 60 ms on older win machines
    // UPDATE: Hmm this doesnt seem to work for me, will try sth else
    // UPDATE2: Will just use time in MinGW
    // UPDATE3: Nope.

    clock_t begin, end;
    double time_spent;

    /* begin = clock(); */
    /* result = binsearchold(42, bigarray, ARRAYLENGTH); */
    /* end = clock(); */
    /* time_spent = (double) (end - begin) / CLOCKS_PER_SEC; */
    /* printf("Old binsearch took %e seconds\n", time_spent); */
    /* printf((result != -1) ? "Found our result at: %i\n" : "No result found. \n", result); */

    /* begin = clock(); */
    /* result = binsearch(42, bigarray, ARRAYLENGTH); */
    /* end = clock(); */
    /* time_spent = (double) (end - begin) / CLOCKS_PER_SEC; */
    /* printf("New binsearch took %e seconds\n", time_spent); */
    /* printf((result != -1) ? "Found our result at: %i\n" : "No result found. \n", result); */
    
    // Trying something else I found on stack overflow
    // UPDATE2: Found out this is not going to work on Windows
    
    /* struct timeval tv1, tv2; */

    /* gettimeofday(&tv1, NULL); */
    /* binsearchold(42, bigarray, ARRAYLENGTH); */
    /* gettimeofday(&tv2, NULL); */
    /* printf("%Total time for old = %f seconds\n", */
    /*         (double) (tv2.tv_usec - tv1.tv_usec) / 1000000 + */
    /*         (double) (tv2.tv_sec - tv1.tv_sec)); */

    /* gettimeofday(&tv1, NULL); */
    /* binsearch(42, bigarray, ARRAYLENGTH); */
    /* gettimeofday(&tv2, NULL); */
    /* printf("%Total time for new = %f seconds\n", */
    /*         (double) (tv2.tv_usec - tv1.tv_usec) / 1000000 + */
    /*         (double) (tv2.tv_sec - tv1.tv_sec)); */

    // Something else again
    // lets see if define statements can be in the middle of the code :D
    
// Getrusage is on unix, so this one wont work either
/* #define CPU_TIME (getrusage(RUSAGE_SELF,&ruse), ruse.ru_utime.tv_sec + \ */
/*   ruse.ru_stime.tv_sec + 1e-6 * \ */
/*   (ruse.ru_utime.tv_usec + ruse.ru_stime.tv_usec)) */

/* int main(void) { */
/*     time_t start, end; */
/*     double first, second; */
/*  */
/*     // Save user and CPU start time */
/*     time(&start); */
/*     first = CPU_TIME; */
/*  */
/*     // Perform operations */
/*     binsearchold(42, bigarray, ARRAYLENGTH); */
/*  */
/*     // Save end time */
/*     time(&end); */
/*     second = CPU_TIME; */
/*  */
/*        printf("For old one:\n"); */
/*     printf("cpu  : %.2f secs\n", second - first);  */
/*     printf("user : %d secs\n", (int)(end - start)); */
/* } */
/*  */

    return 0;
}

