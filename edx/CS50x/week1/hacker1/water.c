#include <stdio.h>
#include <cs50.h>


int main(void) {
    
    int minutes, bottles;
    
    minutes = 0;
    
    do {
        
    printf("minutes: ");
    minutes = GetInt();
    
    } while ( minutes < 1 );
    
    bottles = 192 * minutes / 16;
    
    printf("bottles: %d\n", bottles);
    
}