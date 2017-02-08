#include <stdio.h>

int main(int argc, char* argv[])
{
    // argv stands for argument vector
    // argc I bet is argument count
    for (int i = 0; i < argc; i++)
        printf("argv[%d] is: %s\n", i , argv[i]);
        
    
    return 0;
}