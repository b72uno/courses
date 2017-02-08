#include <cs50.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char vig_k(char c, char k);

int main(int argc, char *argv[]) {
         
    if (argc != 2)
     {
        printf("Invalid command line argument. Must be a string composed of alphabetical characters\n");
        return 1;
     } else {
         
     for (int i = 0, n = strlen(argv[1]); i < n; i++) {
         if (!isalpha(argv[1][i])) {
            printf("Invalid command line argument. Must be a string composed of alphabetical characters\n");
            return 1;
             }
         }
         
     string user_string = GetString();
     int k_len = strlen(argv[1]);
     
     for (int i = 0, j = 0, n = strlen(user_string); i < n; i++) {
         
         
         printf("%c", vig_k(user_string[i], argv[1][j]));
         
         if (isalpha(user_string[i]))
             j = (j + 1) % k_len;
             
             
         }
     }
     
     printf("\n");
}

char vig_k(char c, char k) {
    if (isupper(c)) {
        int offset = (c - 'A' + (tolower(k) - 'a')) % 26;
        return 'A' + offset;
    } else if (islower(c)) {
        int offset = (c - 'a' + (tolower(k) - 'a')) % 26;
        return 'a' + offset; 
    } else {
        return c;
    }
    
}
