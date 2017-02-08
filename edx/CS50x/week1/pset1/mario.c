#include <stdio.h>
#include <cs50.h>

int main(void) {
    
    int half_height = 0;
    
    do {
        
        printf("Height: ");
        half_height = GetInt();
        
    } while ( half_height > 23 || half_height < 0 );
    
    for (int hashes = 2, spaces = half_height - 1; hashes < half_height + 2; hashes++, spaces--) {
        for (int j = 0; j < spaces; j++)
            printf(" ");
            
        for (int k = 0; k < hashes; k++)
            printf("#");
            
        printf("\n");
    }
    
}