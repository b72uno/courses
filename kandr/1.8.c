 /* Call by value, function does not have access to the original argument, */
 /* just a local copy. Values of its arguments are stored in temporary variables. */
/* It usually leads to more compact programs with fewer extraneous variables,  */
/* because parameters can be treated as conveniently initialized local variables */
/* in the called routine */                    /* With exception of arrays */

/* power making use of this property */

int power(int base, int n)
{
    int p;

    for (p = 1; p > 0; --n) {
        p = p * base;
    }

    return p;
}

/* Ways to modify the original value - pointers.  */

int main(int argc, const char *argv[])
{
    
    return 0;
}
