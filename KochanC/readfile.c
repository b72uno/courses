// Program to echo characters until an end of file

#include <stdio.h>

// works with piping the file contents with < 

/* int main(int argc, const char *argv[]) */
/* { */
/*     int c; */
/*  */
/*     while ( (c = getchar()) !=EOF ) */
/*         putchar(c); */
/*  */
/*     return 0; */
/* } */
/*  */


// need to define a pointer to file
FILE *inputFile;

// inputFile = fopen("data", "r"); // also w-write and a-append flags, which 
// unlike read 'r' will create the file if there isnt one. Trying to read
// non-existing fopen will return NULL
 
if ( (inputFile = fopen("data", "r")) == NULL)
    printf("*** data could not be opened. \n");

    // also there are update modes r+, w+ and a+
    // r+ supports both reading and writing
    // w+ like write mode, can do both read and write
    // a+ can read from anywhere, can write only to the end
    //
    // to open binary files on win, b must be added at the end of the mode
    // rb, wb, ab
    

    // getc and putc
    // only diff between getchar and putchar is that
    // the former ones takes FILE pointer as an argument
    // putc function takes 2 arguments - char and file pointer
    //
    // fclose does the opposite of fopen
    // does some housecleaning and closes the file
    // its a good practice to close the file as soon as you are done with it
