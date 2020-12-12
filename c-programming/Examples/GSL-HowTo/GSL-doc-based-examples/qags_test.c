/*
   Example taken from the GNU Scientific Library Reference Manual
    Edition 1.1, for GSL Version 1.1
    9 January 2002
   URL: gsl/ref/gsl-ref_23.html#SEC364

*/

/* 
  Compile and link with:
    gcc -c qags_test.c
    gcc -o qags_test qags_test.o -lgsl -lgslcblas -lm
*/ 

/* 
   Each algorithm computes an approximation to a definite integral of
   the form,

   I = \int_a^b f(x) w(x) dx

   where w(x) is a weight function (for general integrands w(x)=1). The
   user provides absolute and relative error bounds (epsabs, epsrel)
   which specify the following accuracy requirement,

   |RESULT - I|  <= max(epsabs, epsrel |I|)

   where RESULT is the numerical approximation obtained by the
   algorithm. The algorithms attempt to estimate the absolute error
   ABSERR = |RESULT - I| in such a way that the following inequality
   holds,

   |RESULT - I| <= ABSERR <= max(epsabs, epsrel |I|)

   The routines will fail to converge if the error bounds are too
   stringent, but always return the best approximation obtained up to
   that stage.
*/

/*
   QAGS adaptive integration with singularities

   Function: int gsl_integration_qags (const gsl_function * f, 
      double a, double b, 
      double epsabs, double epsrel, 
      size_t limit,
      gsl_integration_workspace * workspace, 
      double *result, 
      double *abserr)
      
       This function applies the Gauss-Kronrod 21-point integration rule
   adaptively until an estimate of the integral of f over (a,b) is
   achieved within the desired absolute and relative error limits,
   epsabs and epsrel. The results are extrapolated using the
   epsilon-algorithm, which accelerates the convergence of the integral
   in the presence of discontinuities and integrable singularities. The
   function returns the final approximation from the extrapolation,
   result, and an estimate of the absolute error, abserr. The
   subintervals and their results are stored in the memory provided by
   workspace. The maximum number of subintervals is given by limit,
   which may not exceed the allocated size of the workspace.
*/


/*
   The integrator QAGS will handle a large class of definite integrals.
   For example, consider the following integral, which has a
   algebraic-logarithmic singularity at the origin,

   \int_0^1 x^{-1/2} log(x) dx = -4

   The program below computes this integral to a relative accuracy bound
   of 1e-8.
*/ 

/*
   The results below show that the desired accuracy is achieved after 8
   subdivisions.

   result          = -3.999999999999973799
   exact result    = -4.000000000000000000
   estimated error =  0.000000000000499600
   actual error    =  0.000000000000026201
   intervals =  8

   In fact, the extrapolation procedure used by QAGS produces an
   accuracy of many more digits. The error estimate returned
   by the extrapolation procedure is larger than the actual error,
   giving a margin of safety of one order of magnitude.
*/  

#include <stdio.h>
#include <math.h>
#include <gsl/gsl_integration.h>

double my_integrand (double x, void * params) {
  double alpha;
  
  alpha = *(double *) params;
  
  return ( log(alpha*x) / sqrt(x) );
}

int
main (void)
{
  gsl_integration_workspace * work_ptr 
    = gsl_integration_workspace_alloc(1000);
  
  double lower_limit = 0;	/* lower limit a */
  double upper_limit = 1;	/* upper limit b */
  double abs_error = 1.0e-8;	/* to avoid round-off problems */
  double rel_error = 1.0e-8;	/* the result will usually be much better */
  double result;		/* the result from the integration */
  double error;			/* the estimated error from the integration */

  double alpha = 1.0;
  double expected = -4.0;

  gsl_function My_function;
  void *params_ptr = &alpha;

  My_function.function = &my_integrand;
  My_function.params = params_ptr;

  gsl_integration_qags (&My_function, lower_limit, upper_limit,
			 abs_error, rel_error, 1000, work_ptr, &result,
			 &error);

  printf("result          = % .18f\n", result);
  printf("exact result    = % .18f\n", expected);
  printf("estimated error = % .18f\n", error);
  printf("actual error    = % .18f\n", result - expected);
  printf("intervals =  %d\n", work_ptr->size);

  return 0;
}


/*
Local Variables:
compile-command: "gcc -o program -Wall qags_test.c -lgsl -lgslcblas -lm"
End:
*/
