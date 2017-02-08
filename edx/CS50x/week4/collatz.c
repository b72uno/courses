#include <stdio.h>

int collatz(int n);

int main(int argc, char *argv[]) {
    int n = 27; 
    int steps = collatz(n);
    printf("To get from %d to 1, you need %d steps\n", n, steps);
}

int collatz(int n) {
    if (n == 1) 
        return 0;
    else if (n % 2 == 0) 
        return 1 + collatz(n / 2);
    else 
        return 1 + collatz(3 * n + 1);
}

