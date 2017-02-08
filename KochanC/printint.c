#include <stdio.h>

#define printx(n) printf("%i\n", x ## n)

int main(int argc, const char *argv[])
{

    int i;

    for (i = 0; i < 100; ++i) {
        printx(i);
    }

    return 0;
}
