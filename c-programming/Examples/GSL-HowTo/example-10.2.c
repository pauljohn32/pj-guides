/* PJ 2011-01-13
  example-10.2.c. Lets pass nu = df from command line.
  This just uses simple argv grabbing, not sophisticated, no error checks

  Run like this

  $ ./program -n 555

to ask for 555 degrees of freedom.

  I get a segmentation fault if I do this:

  $ ./program -n555

  That's one sign that this primitive form of argument management is no good.
  
*/
/*
http://www.gnu.org/software/gsl/manual/html_node/The-Chi_002dsquared-Distribution.html
*/

/* Uses MT19937 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include <gsl/gsl_cdf.h> /* for the cdf calculator */


int main (int argc, const char **argv)
{
  gsl_rng * r;
  int i;  
  int N = 150; // N of points for which to calculate P(x)
  double nu = 10; //degrees of freedom 
  double * x; // values for which ChiSq is to be calculated
  double xMax = 0; // highest value of x
  double * probChiLT = 0;


  for (i = 1; i < argc; i++)  /* Skip argv[0] (program name). */
    {
      if ( argv[i][0] == '-' ) {
	
	switch (argv[i][1]) {
	  
	case 'n':   
	  nu = atof(argv[++i]);
	  break;
        default:
	  {
	    fprintf(stderr, "Did you forget to add -n on the command line? \n");
	  }
	  
	}
      }
    }
  


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
compile-command: "gcc -g -pg -o program -Wall example-10.2.c -lgsl -lgslcblas -lm"
End:
*/
