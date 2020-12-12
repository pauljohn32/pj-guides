/* Paul Johnson 2007-02- 15
   This example shows some warnings about basic math, especially division of integers 
   It also shows how the C math library can be used to do some calculations.
*/

/* C Headers */
#include <stdio.h>

/* stdio.h is needed for the "printf" function */

#include <stdlib.h>
#include <math.h> /* for sin and M_PI */

void returnNothing (void)
{
  int j = 0;
  double i = 0;
  /*  i is the only variable we declare in the function*/
  printf ( "Did you know Euler's Constant, the base of natural logs, is %f\n", M_E);
  printf( "Hello, I'm inside the function returnNothing \n \n");
  printf( "Read /usr/include/math.h and /usr/include/tgmath/h to find more functions \n");

  /* Here I throw you a wrinkle because the "index" variable i is not an integer, as usual */
  /* One should understand the significance of the change in the third component of the if statement */

  for ( i = 0.00000001; i < 10; i=i+0.1*j*j, j++ )
    {
      printf("The natural log of %1.30f is %f \n",i, log(i) );
      printf("The base-10 log of %1.15f is %f \n",i, log10(i) );
      printf("The value of exp(%1.15f) is %1.15f \n", i, exp(i) );
      printf("The value of j is %d \n", j);
    }

   printf("I'm finished in the the function returnNothing \n \n");

   /* Note, there is no return here because the function type is void */
}

int returnDouble ( int x )
{
  /* x is available anywhere inside the function */
  int y = 0; /* y is a 'local variable' */

  printf("I'm inside return Double \n"); 
  y = 2 * x; 
  printf("I just finished calculating y inside returnDouble \n");
  return y;
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

 

  int i = 15;
  int j = 7;
  

  printf("\n Assume i=%d and j = %d \n", i, j);
  printf( "Do you think you've got a float when you do %d/%d? The value is %d \n", i,j, i/j);
  printf( "Similarly, %d/%d is %d \n",j, i,  j/i);


  /* 
     The "cast" operator () tells the compiler to treat a variable as if it were of another type.
     New versions of gcc are good at promoting integers
  */
  printf( "(double)i/j is %f \n", (double)i/j);
  printf( "(double)j/i is %f \n", (double)j/i);

  printf( "53.2*22 is %f \n", 53.2*22);
  printf( "53.2/22 is %f \n", 53.2/22);
  //importance: if one number being divided is a float, the output is float.
  //if both are integers, it assumes the output is an integer.

  //what if you want to find out the remainder?  That's what the modulus operator (%) is for

  printf( "53 modulus 22 is %d \n", 53 % 22);

  printf(" what type is 2L * ((double)2/3). I guess it is %f \n",  2L * ((double)2/3));


  {
    int unknown1 = 2;
    int unknown2 = 3;
    double unknown3 = unknown1/unknown2;

    printf( " what type is 2 * unknown3? You may be disappointed to know it is %f \n",  2 * unknown3);
  }

  {
    int unknown1 = 2;
    int unknown2 = 3;
    double unknown3 = (double)unknown1/unknown2;

    printf( " You still need a cast to make it right: %f \n",  2 * unknown3);
  }

  /* Let's see about some calculations */
  returnNothing();


  exit(0);
}

/*
  NOTE: Compiling this requires us to link in the math library, with -lm 
  option to gcc
*/


/*
Local Variables:
compile-command: "gcc -o whatever -Wall example-6_math.c -lm "
End:
*/
