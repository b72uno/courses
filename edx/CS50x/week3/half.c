#include <stdio.h>
#include <cs50.h>

int main(void) {
    printf("Please enter a number: ");
    int num = GetInt();
    
    num = num / 2;
    
    printf("Your halved number is: %i\n", num);
    
    return 0;
}