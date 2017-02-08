#include <stdio.h>
#include <cs50.h>


int main(void) {
    
    int minutes, bottles;
    
    printf("minutes: ");
    minutes = GetInt();
    
    bottles = 192 * minutes / 16;
    
    printf("bottles: %d\n", bottles);
    
}