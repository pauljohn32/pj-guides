// http://www.math.ncu.edu.tw/~chenwc/R_note/index.php?item=standalone

#define MATHLIB_STANDALONE

#include <stdlib.h>
#include <stdio.h>
#include <Rmath.h>

int main(){
  int i;
  unsigned int SEED1, SEED2;
  double mu, sigma, PHI_X, *X;

  mu = 0;
  sigma = 1;
  SEED1 = 12345;
  SEED2 = 67890;
  set_seed(SEED1, SEED2);

  X = (double *) malloc(10 * sizeof(X));
  /* TODO: should check X actually exists */
  for(i = 0; i < 10; i++){
    X[i] = rnorm(mu, sigma);
    PHI_X = pnorm(X[i], mu, sigma, 1, 0);
    printf("X: %f, PHI(X): %f\n", X[i], PHI_X);
  }
}


/*
Local Variables:
compile-command: "gcc -o stand ex-1-stand.c -fpic -lRmath -lm" 
End:
*/
