/* PJ 2011-01-13
  example-10.1.c. Lets make our own chi square table!
*/
/*
http://www.gnu.org/software/gsl/manual/html_node/The-Chi_002dsquared-Distribution.html
*/

/* Uses MT19937 */
#include <stdio.h>
#include <stdlib.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include <gsl/gsl_cdf.h> /* for the cdf calculator */


int main (void)
{
  gsl_rng * r;
  int i;  
  int N = 150; // N of points for which to calculate P(x)
  double nu = 10; //degrees of freedom 
  double * x; // values for which ChiSq is to be calculated
  double xMax = 0; // highest value of x
  double * probChiLT = 0;

  xMax = nu * 3; //3 * df seems high enough :)


  x = malloc( N * sizeof(double));

  if (x == NULL) 
    {
      // memory alloc failed, kill program.
      fprintf(stderr, "malloc failed\n");
      exit(1);
    }

  probChiLT =  malloc( N * sizeof(double) );

  if (probChiLT == NULL) 
    {
      // memory alloc failed, kill program.
      fprintf(stderr, "malloc failed\n");
      exit(1);
    }

  for (i = 0; i < N; i++)
    x[i] = i * (double)xMax/(double)(N-1);



  // create random number generator 
  r = gsl_rng_alloc (gsl_rng_mt19937);

  fprintf(stderr, "Chi Square Table with degrees of freedom = %f\n", nu);  
  for (i = 0; i < N; i++) 
    {
      probChiLT[i] = gsl_cdf_chisq_P(x[i], nu);
      
      fprintf(stderr, "i=%d, x=%f pr(chi < x)=%f \n", i, x[i], probChiLT[i]);
    }

  fprintf(stderr, "Note the following \n");
  fprintf(stderr, "   where x = df, the pr(chi < x) is about 1/2 \n");

  gsl_rng_free (r);

  free(x);
  free(probChiLT);

  return 0;
}

/*
Local Variables:
compile-command: "gcc -o program -Wall example-10.1.c -lgsl -lgslcblas -lm"
End:
*/
