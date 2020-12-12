/* C Headers */
#include <stdio.h>

/* stdio.h is needed for the "printf" function */

#include <stdlib.h>
#include <math.h> /* for sin and M_PI */

void returnNothing (void)
{

  int i = 0;
  /*  i is the only variable we declare in the function*/

  printf( "Hello, I'm inside the function returnNothing \n \n");

    for ( i = 0; i < 10; i++ )
    {
      printf("%d Hello World !\n",i);
    }

   printf("I'm finished in the the function returnNothing \n \n");

   /* Note, there is no return here because the function type is void */
}

double returnDouble ( int x )
{
  /* x is available anywhere inside the function */
  double y = 0; /* y is a 'local variable' */

  printf("I'm inside return Double \n"); 
  y = 2 * x; 
  printf("I just finished calculating y inside returnDouble: %f \n", y);
  return (double)y;
}


double returnPI ( void)
{
  return M_PI;
}

double returnSillyValue ( int x, double y )
{
  return 3.0 * x + sin ( y );
}


int main( int argc, const char *argv[] )
{

  returnNothing();

  /* note use of brackets to create a scope */
  {
    int j = 14; 
    int unknownValue;
    unknownValue = returnDouble( j ); 
    printf ( "The unknown doubled value is %d \n" , unknownValue);

  }


  printf("The (first few decimal poing) value of PI is in values.h as %f\n", returnPI() );
  printf("The (32 point) value of PI is in values.h as %.32f\n", returnPI() );
  {
    double something = 0.0;
    something = returnSillyValue(7 , 3.222);
    printf("The something something from returnSillyValue is %f\n", something);

  }

 
  exit(0);
}

/*
  NOTE: Compiling this requires us to link in the math library, with -lm 
  option to gcc
*/


/*
Local Variables:
compile-command: "gcc -o whatever -Wall example-4_function.c -lm "
End:
*/
