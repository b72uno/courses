/*
 * Write a program called whodunit in a file called whodunit.c that reveals Mr.
 * Boddy's drawing.
 */

/****************************************************************************
 * whodunit.c
 *
 * Computer Science 50
 * Problem Set 4
 *
 * Copies a BMP piece by piece, RED filter.
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bmp.h"

int main(int argc, char* argv[])
{
    // ensure proper usage
    if (argc != 4)
    {
        printf("Usage: resize n infile outfile \n");
        return 1;
    }

    // remember filenames
    char* infile = argv[2];
    char* outfile = argv[3];

    // open input file
    FILE* inptr = fopen(infile, "r");
    if (inptr == NULL)
    {
        printf("Could not open %s.\n", infile);
        return 2;
    }

    // open output file
    FILE* outptr = fopen(outfile, "w");
    if (outptr == NULL)
    {
        fclose(inptr);
        fprintf(stderr, "Could not create %s.\n", outfile);
        return 3;
    }

    // read infile's BITMAPFILEHEADER
    BITMAPFILEHEADER bf;
    fread(&bf, sizeof(BITMAPFILEHEADER), 1, inptr);

    // read infile's BITMAPINFOHEADER
    BITMAPINFOHEADER bi;
    fread(&bi, sizeof(BITMAPINFOHEADER), 1, inptr);

    // ensure infile is (likely) a 24-bit uncompressed BMP 4.0
    if (bf.bfType != 0x4d42 || bf.bfOffBits != 54 || bi.biSize != 40 ||
        bi.biBitCount != 24 || bi.biCompression != 0)
    {
        fclose(outptr);
        fclose(inptr);
        fprintf(stderr, "Unsupported file format.\n");
        return 4;
    }

    int n = atoi(argv[1]);

    if (n < 1 || n > 100)
    {
        fclose(outptr);
        fclose(inptr);
        fprintf(stderr, "Please scale in a range 1-100 only. \n");
        return 5;
    }

    // assuming that n times the size of infile
    // will not exceed 2^32 - 1

    BITMAPFILEHEADER bfout = bf;
    BITMAPINFOHEADER biout = bi;

    // scaling width and height by n
    biout.biWidth = bi.biWidth * n;
    biout.biHeight = bi.biHeight * n;

    // determine padding for scanlines for resized file
    int paddingout =  (4 - (biout.biWidth * sizeof(RGBTRIPLE)) % 4) % 4;

    biout.biSizeImage = abs(biout.biHeight) * (biout.biWidth * sizeof(RGBTRIPLE) + paddingout);

    bfout.bfSize = biout.biSizeImage + bfout.bfOffBits;

    // write outfile's BITMAPFILEHEADER
    fwrite(&bfout, sizeof(BITMAPFILEHEADER), 1, outptr);

    // write outfile's BITMAPINFOHEADER
    fwrite(&biout, sizeof(BITMAPINFOHEADER), 1, outptr);

    int padding =  (4 - (bi.biWidth * sizeof(RGBTRIPLE)) % 4) % 4;

    // iterate over infile's scanlines
    for (int i = 0, biHeight = abs(bi.biHeight); i < biHeight; i++)
    {

        // write the scanline n times to outfile
        for (int g = 0; g < n; g++)
        {
            // iterate over pixels in INFILES scanline
            for (int j = 0; j < bi.biWidth; j++)
            {
                // temporary storage
                RGBTRIPLE triple;

                // read RGB triple from infile
                fread(&triple, sizeof(RGBTRIPLE), 1, inptr);

                // write RGB triple to outfile n times
                for (int k = 0; k < n; k++)
                    fwrite(&triple, sizeof(RGBTRIPLE), 1, outptr);
            }

            // skip over padding, if any in infile
            fseek(inptr, padding, SEEK_CUR);

            // add padding to outfile
            for (int k = 0; k < paddingout; k++)
                fputc(0x00, outptr);

            // if next time we dont have to get to the next scanline, rewind to
            // the beginning of the scanline in inputfile
            if (g + 2 <= n)
                // so we CAN go backwards, nice!
                fseek(inptr, -((bi.biWidth * sizeof(RGBTRIPLE)) + padding), SEEK_CUR);
        }

    }

    // close infile
    fclose(inptr);

    // close outfile
    fclose(outptr);

    // that's all folks
    return 0;
}
