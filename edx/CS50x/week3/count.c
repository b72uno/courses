#include <stdio.h>
#include <cs50.h>

int main(void) {
    printf("Please enter a number: ");
    int num = GetInt();
    
    num = num / 2;
    
    for (int i = 0; i < num; i++) {
        printf("%i!\n", i);
    }
    
    return 0;
}