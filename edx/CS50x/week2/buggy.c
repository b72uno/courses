/****************************************************************************
 * buggy-1.c
 *
 * David J. Malan
 * malan@harvard.edu
 *
 * Should print 10 asterisks, one per line, but doesn't!
 * Can you find the bug?

#include <stdio.h>

int main(void)
{
    for (int i = 0; i <= 10; i++)
        printf("*");
        printf("\n");
}
 ***************************************************************************/
 
#include <stdio.h>

int main(void)
{
    for (int i = 0; i < 10; i++)
    {
        printf("*%d",i+1);
        printf("\n");
    }
}