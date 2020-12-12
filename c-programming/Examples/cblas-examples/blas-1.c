#include <stdlib.h>
#include <stdio.h>
#include <cblas.h>

int main( int argc, char** argv ){
  // you can define the arrays in one of two ways
  // on the heap
  double *a = malloc( 3L * sizeof(double) );
  if (!a) exit(0);
  a[0] = 1.0; a[1] = 2.0; a[2] = 3.0;
  // on the stack
  double b[3] = { 1.0, 5.0, 6.0 };
  
  double dot_product = cblas_ddot( 3, a, 1, b, 1 );
  printf(" The dot product is: %f \n",dot_product );

  return 0;
};


/*
Local Variables:
compile-command: "gcc -o blas1 -Wall blas-1.c -lm -lblas "
End:
*/
