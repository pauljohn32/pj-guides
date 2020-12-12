/* Paul Johnson 2007-02- 15 This example shows about two dimensional
   arrays in C.

   It also demonstrates the way a function can return a
   matrix to a calling program.  In the C books, this is called
   "passing by reference" because the memory address-- a "pointer" to
   the memory block that holds the array--is returned.  Any C book
   will discuss the fact that C functions "return by value" and that
   only a single value can be returned. By returning a memory address
   (a reference), rather than a number, we return more information.
*/

/* C Headers */
#include <stdio.h>

/* stdio.h is needed for the "printf" function */

#include <stdlib.h>
#include <math.h> /* for sin and M_PI */


void returnNothing (void)
{
  int i = 0;
  int j = 0;
  double myDoubleArray[10][5];



  /* pain in the ass initialization */
  
  for (i = 0; i < 10; i++) 
    {
      for (j=0; j < 5; j++)
	{
	  myDoubleArray[i][j] = i + j*0.1;
	}
    }
 
  printf("Here's myDoubleArray \n");
  for (i = 0; i < 10; i++) 
    { 
      for (j=0; j < 5; j++)
	{
	  printf("%f " ,  myDoubleArray[i][j]);
	}
      printf("\n");
    }
  printf("That was the end of the printout of the static array \n \n ");

 /*
  for (i = 0; i < 10; i++) 
    {
      printf("myOtherDoubleArray[%d] = %f \n",i,   myOtherDoubleArray[i]);
    }
 */
   /* Note, there is no return here because the function type is void */
}


/* demonstrates malloc to dynamically allocate memory for a 2 dimensional array. This 
   allocates memory for an x by 5 array */

double ** returnDoubleArray ( int x )
{
  
  int i = 0;
  int j = 0;

  double ** myDynamArray;
  
  /* gets memory for x "placeholders" for the array rows. */
  myDynamArray = malloc( x * sizeof(double *));

  for (i = 0; i < x; i++)
    {
      myDynamArray[i] = malloc(5 * sizeof(double));
    }

  if (! myDynamArray ) exit(0);

  for (i = 0; i < x; i++) 
    {
      for (j=0; j<5; j++)
	{
	  myDynamArray[i][j] =  i + j*0.1;
	}
    }
  
  printf ( "This demonstrates the values stored in the dynamic array\n");
  printf ("The values of myDynamArray with dimensions %d x %d  are\n", i, j);
  for (i = 0; i < x; i++) 
    {
       for (j=0; j<5; j++)
	{
	  printf ("%f ", myDynamArray[i][j]);
	}
       printf("\n");
    }

  return myDynamArray;
}


int main( int argc, const char *argv[] )
{
  int i;
  int j; 
  double ** whateverArray; /* The ** means a "two dimensional" memory allocation.  */
  /* Let's see about some calculations */
  returnNothing();

  whateverArray = returnDoubleArray (10 );
 
  printf("\n \nInside main, we are testing the ability to use memory that is allocated by returnDoubleArray.\n");
  printf("Let's review the values of whateverArray, which should match the above \n");
  for (i = 0; i < 10; i++) 
    { 
      for (j=0; j < 5; j++)
	{
	  printf("%f " ,  whateverArray[i][j]);
	}
      printf("\n");
    }

  
  free(whateverArray);

  exit(0);
}



/*
Local Variables:
compile-command: "gcc -o whatever -Wall example-8_multiarray.c -lm "
End:
*/
