#include <stdio.h>

// I have no idea what kind of sort this is,
// some kind of exchange sort, gnome sort perhaps.
// all I know is that I have to rewrite it with pointers

// Program to sort an array of integers into ascending order

void sort (int *intPtr, int n)
{
    int *endPtr = intPtr + n;
    int temp;

    // cool, while we havent reached null char
    // so int 0 wont break the loop as I thought initially
    while (*intPtr)
    {
        int *int2Ptr;
        for (int2Ptr = intPtr + 1; int2Ptr < endPtr; ++int2Ptr) 
            if ( *intPtr > *int2Ptr ) {
                temp = *intPtr;
                *intPtr = *int2Ptr;
                *int2Ptr = temp;
            }

        ++intPtr;
    }
}

int main (void)
{
    int i;
    int array[16] = { 34, -5, 6, 0, 12, 100, 56, 22,
        44, -3, -9, 12, 17, 22, 6, 11 };

    // kek no difference int a[] or ptr to int
    void sort (int a[], int n);

    printf ("The array before the sort:\n");

    for ( i = 0; i < 16; ++i )
        printf ("%i ", array[i]);

    sort (array, 16);

    printf ("\n\nThe array after the sort:\n");

    for ( i = 0; i < 16; ++i )
        printf ("%i ", array[i]);

    printf ("\n");

    return 0;
}

