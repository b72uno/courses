#include <stdio.h>

int main(int argc, const char *argv[])
{
    int numPrimes;

    // ask for number of primes
    printf("Up to what number you want primes displayed? ");
    scanf("%i", &numPrimes);

    int primeArray[numPrimes]; 

    int i, j;

    /* initialize array */
    for (i = 0; i < numPrimes; i++) {
        primeArray[i] = 0;
    }

    for (i = 2; i <= numPrimes; i++) {
        if (primeArray[i] == 0) {
            // then it is prime
            printf("%i\n", i);
        }

        // for all positive ints of j such that
        // i * j <= n, set P i*j to 1
        // read: eliminate multiples of that number up to numPrimes
        for (j = 0; j * i <= numPrimes; j++) {
            primeArray[i*j] = 1;
        }
    }

    return 0;
}
