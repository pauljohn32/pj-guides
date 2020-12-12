/* Paul Johnson 2007-02- 15
   This example shows about arrays in C
   20171006: This URL is helpful
   https://www.tutorialspoint.com/cprogramming/c_arrays.htm
*/

/* C Headers */
#include <stdio.h>

/* stdio.h is needed for the "printf" function */

#include <stdlib.h>
#include <math.h> /* for sin and M_PI */



/* myDoubleArray and myOtherDoubleArray are both "static arrays" because
   their sizes are known at "compile time", although one is apparently a bit
   more static than the other, if you notice j can vary. 
*/

void returnNothing (void)
{
  int i = 0;
  int j = 5;
  double myDoubleArray[j];
  double myOtherDoubleArray[10];

  /* pain in the ass initialization */
  
  for (i = 0; i < j; i++) 
    {
      myDoubleArray[i] = 0.0;
    }

  for (i = 0; i < 10 ; i++) 
    {
      myOtherDoubleArray[i] = 5 * i;
    }

  /* print those out */
 for (i = 0; i < j; i++) 
    {
      printf("myDoubleArray[%d] is %f \n" ,i,  myDoubleArray[i]);
    }

  for (i = 0; i < 10; i++) 
    {
      printf("myOtherDoubleArray[%d] = %f \n",i,   myOtherDoubleArray[i]);
    }

   /* Note, there is no return here because the function type is void */
}



double * returnDoubleArray ( int x )
{
  
  int i = 0;

  double * myDynamArray;

  myDynamArray = malloc( x * sizeof(double));

  if (! myDynamArray ) exit(0);

  for (i = 0; i < x; i++) 
    {
      myDynamArray[i] = 5 * i;
    }
  
  for (i = 0; i < x; i++) 
    {
      printf ("myDynamArray[%d]= %f\n",  i, myDynamArray[i]);
    }

  return myDynamArray;
}

/* M_PI is a "macro" defined inside the math library */
/* To access a macro value, simply type it in, and the C pre-processor handles it */
/* The pre-processor replaces the characters "M_PI" with a numerical value before the */
/* compiler does its work, so usage of macros makes for fast programs */
double returnPI ( void)
{
  return M_PI;
}



/* The sin is a function in the math library, and it is */
/* calculated each time the function is called */
/* See how that is different from a macro ? */
double returnSillyValue ( int x, double y )
{
  return 3.0 * x + sin ( y );
}


int main( int argc, const char *argv[] )
{
  int i;
  double * whateverArray;
  /* Let's see about some calculations */
  returnNothing();

  whateverArray = returnDoubleArray (9);

  for(i = 0; i < 9; i++)
    {
      printf("returnDoubleArray[%d] is %f\n", i , whateverArray[i]);
    }



  free(whateverArray);
  
  /* note, that value may still be there */
  printf("\n whateverArray = %f \n", whateverArray[5]);


  /* but it may not */

  {
    int j;
    double zArray[10];
    for(j=0; j < 10; j++)
      {
		zArray[j] = (double)j;
      }
	/* Note warning about unused variable, unless we actually use that.*/
   
  }
  /* note, that value may still be there */
  printf("\n whateverArray = %f \n", whateverArray[5]);


  {
    double * myDynamArray = malloc( 10000 * sizeof(double));
    int j;

    if (! myDynamArray ) exit(0);
  
    for (j=0; j < 1000; j++)
      {
	myDynamArray[j] = j*3.3;
      }

  }

  /* note: it may not still be there */
  printf("\n whateverArray = %f \n", whateverArray[5]);

  exit(0);
}

/*
  NOTE: Compiling this requires us to link in the math library, with -lm 
  option to gcc
*/


/*
Local Variables:
compile-command: "gcc -o whatever -Wall example-7_arrays.c -lm "
End:
*/
