#include <stdio.h>

// this function is not to be implemented with arrays
// wait... where i'm supposed to store my ints then??

void sort3(int *i1, int *i2, int *i3);

int main(int argc, const char *argv[])
{
    int biggest = -65;
    int inbetween = -75;
    int smallest = 0;

    sort3(&biggest, &inbetween, &smallest);
    
    printf("Biggest: %i\n", biggest);
    printf("Inbetween: %i\n", inbetween);
    printf("Smallest: %i\n", smallest);

    return 0;
}

void sort3(int *i1, int *i2, int *i3)
{
    int temp;

    if (*i1 > *i2)
    {
        if (*i1 > *i3)
        {
            if (*i2 > *i3) 
            {
                printf("All ok.\n");
            } else {
                temp = *i2;
                *i2 = *i3;
                *i3 = temp;
            }
        } else {
            temp = *i1;
            *i1 = *i3;
            *i3 = *i2;
            *i2 = temp;
        }
    } else {
        if (*i1 > *i3)
        {
                temp = *i2;
                *i2 = *i1;
                *i1 = temp;
        } else {

            temp = *i1;

            if (*i2 > *i3)
            {
                *i1 = *i2;
                *i2 = *i3;
                *i3 = temp;
            } else {
                *i1 = *i3;
                *i3 = temp;
            }
        }
    }
}

// screw this, better use sorting algorithms then to 
// account for every combination .. erm permutation?
// have to look up the difference between those two once again....

