#include <stdio.h>
#include <cs50.h>

int sigma(int m);

int main(void) {
    int n;
    do {
        printf("Positive integer please: ");
        n = GetInt();
    } while (n < 1);
    
    int answer = sigma(n);
    
    printf("%i\n", answer);
}

int sigma(int m) {
    if (m < 1)
        return 0;
        
    return m + sigma(m - 1);
}