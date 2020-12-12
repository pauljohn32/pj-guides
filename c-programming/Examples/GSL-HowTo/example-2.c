/* PJ Adapted from
http://lcgapp.cern.ch/project/cls/workbook/gsl-howto.html
*/

/* Objective: Fundamental demonstration of random generator usage,
   how to draw random variates from normal and uniform  
*/
/* New Feature: Same random numbers as example-1.c, but
   this puts them to use. It calculates cumulative scores
*/

/* Uses MT19937 */
#include <stdio.h>
#include <stdlib.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>

int main (void)
{
  const gsl_rng_type * T;
  gsl_rng * r;
  int i;  
  double sigma = 10; 
  double u[100], v[100];
  double sumu=0.0, sumv=0.0;

  // create random number generator 
  r = gsl_rng_alloc (gsl_rng_mt19937);

  
  for (i = 0; i < 100; i++) 
    {
      u[i] = gsl_rng_uniform (r);
      v[i] = gsl_ran_gaussian(r, sigma); 
      fprintf(stderr, "i=%d: u=%f1.2 v=%f1.2 \n", i, u[i], v[i]);
    }

  gsl_rng_free (r);

  /* Ways to make a program crash. Try this:
     gsl_rng_uniform (r);
  */

  for (i = 0; i < 100; i++) 
    {
      sumu += u[i];
      fprintf(stderr, "i=%d: u=%f sumu=%f \n", i, u[i], sumu);
    }


 for (i = 0; i < 100; i++) 
    {
      short int bool1=0;
      sumu += u[i];
      sumv += v[i];
      bool1 = ( sumu > sumv ) ? 1 : 0; /* Ternary Operator= brief if then else */
      fprintf(stderr, "i=%d: sumu=%f sumv=%f sumugreater? %d \n", i, sumu, sumv, bool1);
    }


  return 0;
}

/*
Local Variables:
compile-command: "gcc -o program -Wall example-2.c -lgsl -lgslcblas -lm"
End:
*/
