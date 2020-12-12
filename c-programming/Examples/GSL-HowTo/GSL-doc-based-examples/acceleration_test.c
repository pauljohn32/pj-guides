/*
   Example taken from the GNU Scientific Library Reference Manual
    Edition 1.1, for GSL Version 1.1
    9 January 2002
   URL: gsl/ref/gsl-ref_23.html#SEC364
*/

/* 
  Compile and link with:
    gcc -c acceleration_test.c
    gcc -o acceleration_test acceleration_test.o -lgsl -lgslcblas -lm
*/    

/*
   The following code calculates an estimate of \zeta(2) = \pi^2 / 6
   using the series,

   \zeta(2) = 1 + 1/2^2 + 1/3^2 + 1/4^2 + ...

   After N terms the error in the sum is O(1/N), making direct summation
   of the series converge slowly.
*/

/*
   The output below shows that the Levin u-transform is able to obtain
   an estimate of the sum to 1 part in 10^10 using the first eleven
   terms of the series. The error estimate returned by the function is
   also accurate, giving the correct number of significant digits.

   term-by-term sum =  1.5961632439130233 using 20 terms
   term-by-term sum =  1.5759958390005426 using 13 terms
   exact value      =  1.6449340668482264
   accelerated sum  =  1.6449340668166479 using 13 terms
   estimated error  =  0.0000000000508580
   actual error     = -0.0000000000315785

   Note that a direct summation of this series would require 10^10 terms
   to achieve the same precision as the accelerated sum does in 13
   terms.
*/


#include <stdio.h>
#include <gsl/gsl_math.h>
#include <gsl/gsl_sum.h>

#define N 20

int
main (void)
{
  double t[N];
  double sum_accel, err;
  double sum = 0;
  int n;
  
  gsl_sum_levin_u_workspace * w 
    = gsl_sum_levin_u_alloc (N);

  const double zeta_2 = M_PI * M_PI / 6.0;
  
  /* terms for zeta(2) = \sum_{n=0}^{\infty} 1/n^2 */

  for (n = 0; n < N; n++)
    {
      double np1 = n + 1.0;
      t[n] = 1.0 / (np1 * np1);
      sum += t[n];
    }
  
  gsl_sum_levin_u_accel (t, N, w, &sum_accel, &err);

  printf("term-by-term sum = % .16f using %d terms\n", 
         sum, N);

  printf("term-by-term sum = % .16f using %d terms\n", 
         w->sum_plain, w->terms_used);

  printf("exact value      = % .16f\n", zeta_2);
  printf("accelerated sum  = % .16f using %d terms\n", 
         sum_accel, w->terms_used);

  printf("estimated error  = % .16f\n", err);
  printf("actual error     = % .16f\n", 
         sum_accel - zeta_2);

  gsl_sum_levin_u_free (w);
  return 0;
}


/*
Local Variables:
compile-command: "gcc -o program -Wall acceleration_test.c -lgsl -lgslcblas -lm"
End:
*/
