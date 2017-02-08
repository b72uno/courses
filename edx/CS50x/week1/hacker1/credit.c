#include <stdio.h>
#include <cs50.h>


int main(void) {
    
    long long number = 0;
    
    printf("Number: ");
    number = GetLongLong();
    
    if (number < (long long) 999999999999 || number > (long long) 9999999999999999) {
        printf("INVALID\n");
        return -1;
    }
    
}