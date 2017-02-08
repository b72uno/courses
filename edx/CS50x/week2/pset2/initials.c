#include <stdio.h>
#include <cs50.h>
#include <ctype.h>
#include <string.h>

#define MAX_INITIALS 5 // Obi-Wan Ben Larry Kenobi vs just Steve?


int main(int argc, char *argv[]) {
    
    string name = GetString();
    
    char initials[MAX_INITIALS];

    for (int i = 0, j = 0, s = strlen(name), need_initial = 1; i < s; i++) {
        
        if (name[i] != ' ' && need_initial) {
            initials[j] = toupper(name[i]);
            need_initial = 0;
            j++;
        } 
        
        if (name[i] == ' ') {
            need_initial = 1;
        }
    }
    
    printf("%s\n", initials);
    
}