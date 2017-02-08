#include <cs50.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char rot_k(char c, int k);

int main(int argc, char *argv[]) {
    if (argc != 2)
     {
        printf("Invalid command line argument. Must be a valid integer.");
        return 1;
     } else {
         
     int k = atoi(argv[1]);
     
     string user_string = GetString();
     
     for (int i = 0, n = strlen(user_string); i < n; i++) {
         
         printf("%c", rot_k(user_string[i], k));
         
         }
     }
     
     printf("\n");
}

char rot_k(char c, int k) {
    if (isupper(c)) {
        int offset = (c - 'A' + k) % 26;
        return 'A' + offset;
    } else if (islower(c)) {
        int offset = (c - 'a' + k) % 26;
        return 'a' + offset; 
    } else {
        return c;
    }
    
}
