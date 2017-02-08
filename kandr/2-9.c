/*
 * bitcount : count 1 bits in x
 * int bitcount(unsigned x)
 * {
 * int b;
 * 
 * for (b = 0; x != 0; x >> 1)
 *  if(x & 01)
 *      b++;
 * return b;
 * }
 *
 *
 * In a two's complement number system x &= (x - 1) deletes the rightmost 1 bit
 * in x. Explain why.  Use this observation to write a faster version of
 * bitcount.
 *
 * Because if x is odd, you will just & xxxxx0 with xxxxx1  and the rightmost
 * bit will get deleted, set to 0. If x is even, lets say xxxx000 then
 * subtracting one gives xxx0xxx and anding that with xxxx000 gives you xxx0000
 * effectively deleting the bit again. Either way the bit gets deleted.
 *
 * What I dont know is why this wouldnt work in ones complement? Would it?
 *
 * How can we use it? Hmm....
 * how about
 *
 * // do we even need that != 0?? 
 * while ((x &= (x - 1)) != 0) // need the parentheses, because != > &=
 *      b++;
 *
 * I like while loops, get off my lawn!
 *
 */


