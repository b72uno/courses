#include <stdio.h>
#include <stdlib.h>

#define N 25

int main(int argc, char *argv[])
{
    // comment one version out
    
    // VERSION 1 (bracket-type array)
    // int x[N];
    
    // shortcut initialization (no such thing for pointer array)
    // int x[] = {0, 2, 3, 4, 6, 15, 12, 14, 13};
    
    // VERSION 2 (pointer-type array)
    int *x = malloc(sizeof(int) * N);
    
    for (int i = 0; i < N; i++) 
    {
        x[i] = i * 2;
    }
    

    
    for (int i = 0; i < N; i++) 
    {
        printf("Element %d: %d\n", i, x[i]);
    }
}