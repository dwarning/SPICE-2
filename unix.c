/*
 * SCCSID=unix.c 3/15/83
 */
#include <stdlib.h>

/* declarations to avoid warnings */
void mcopy(char*, char*, int);
void mclear(char*,int);


/*
 * Zero, copy and move for vax unix.
 */
void move_( char * array1, int *index1, char *array2, int *index2, int *length )
{
	array1 += *index1 - 1;
	array2 += *index2 - 1;
	mcopy( array2, array1, *length );
}

/*
  Super obnoxious: they are assuming that ints are 4 bytes, doubles 8,
  complex 16, even though there are supposedly pains taken to handle when
  they aren't.  Then they call "zero4" and friends on all ints.

  On a modern 64 bit system we have 8 byte pointers, and for a variety of
  reasons this makes us need to so 8 byte ints as well (because spice
  is hamfistedly accessing pointer and then storing them in integers).

  So let's fake this out and make "zero4" and the other "4" functions
  actually copy 8, because that's what integers will be

  These should really be named for the data types they zero instead of
  the sizes!
*/
void zero4_( char *array, unsigned *length )
{
	mclear( array, *length * 8 );
}


void zero8_( char *array, unsigned *length )
{
	mclear( array, *length * 8 );
}


void zero16_( char *array, unsigned *length )
{
	mclear( array, *length * 8 );
}


void copy4_( char *from, char *to, int *length )
{
	mcopy( from, to, *length * 8 );
}


void copy8_( char *from, char *to, int *length )
{
	mcopy( from, to, *length * 8 );
}


void copy16_( char *from, char *to, int *length )
{
	mcopy( from, to, *length * 8 );
}

/*
 * misc.c - miscellaneous utility routines.
 * sccsid @(#)unix.c	6.1	(Splice2/Berkeley) 3/15/83
 */

/*
 * mclear - clear memory.
 */
void mclear( char *data, int size )
{
	for ( ; size > 0; size--, data++ ) {
		*data = '\0';
	}
}

/*
 * mcopy - copy memory.
 */
void mcopy( char *from, char *to, int size )
{
	if ( from >= to ) {
		for ( ; size > 0; size-- ) {
			*to++ = *from++;
		}
	}
	else {
		to   += size;
		from += size;
		for ( ; size > 0; size-- ) {
			*--to = *--from;
		}
	}
}
