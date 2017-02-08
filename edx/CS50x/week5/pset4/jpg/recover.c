/****************************************************************************
 * recover.c
 *
 * Computer Science 50
 * Problem Set 4
 *
 * Recovers JPEGs from a forensic image.
 ***************************************************************************/

#include <stdio.h>
#include <stdint.h>

#define FILENAME "card.raw"
#define BLOCKSIZE 512
#define EXTENSION ".jpg"
#define SIGSIZE 4  // signature size in bytes

// big endian
/* #define SIGNATURE1 0xffd8ffe0 */
/* #define SIGNATURE2 0xffd8ffe1 */

// small endian
#define SIGNATURE1 0xe0ffd8ff
#define SIGNATURE2 0xe1ffd8ff

// or vice versa??? :D

// thanks to FAT, we know that JPEG's signatures will be "block-aligned", i.e.
// the signature will be in a blocks first four bytes, so we can read blocksize
// bytes at a time to speed things up.

int main(int argc, const char *argv[])
{

    // open the file

    FILE* inptr;

    inptr = fopen(FILENAME, "r");

    if (!inptr)
    {
        fprintf(stderr, "Could not open %s\n", FILENAME);
        return -1;
    }

    int counter = 0;

    uint32_t pattern;

    while (!feof(inptr))
    {

        // read first four bytes
        fread(&pattern, SIGSIZE, 1, inptr);

        // skip 0s
        if (pattern)
        {

            // while we're at the beginning of a picture
            while ((pattern == SIGNATURE1 || pattern == SIGNATURE2))
            {

                // open a file for writing
                char fname[8];
                snprintf(fname, 8, "%.3d.jpg", counter);

                FILE* outptr = fopen(fname, "w");

                if (fopen == NULL)
                {
                    printf("Couldn't open file %s for writing\n", fname);
                }

                // while we dont run into another pic, write everything to file
                do
                {
                    // check for EOF
                    if (feof(inptr))
                    {
                        return 0;
                    }

                    fwrite(&pattern, SIGSIZE, 1, outptr);
                    fread(&pattern, SIGSIZE, 1, inptr);

                } while (!(pattern == SIGNATURE1 || pattern == SIGNATURE2));

                fclose(outptr);

                counter++;
            }

        }

    // skip to the next block
    fseek(inptr, (BLOCKSIZE - SIGSIZE), SEEK_CUR);

    }

    return 0;
}

