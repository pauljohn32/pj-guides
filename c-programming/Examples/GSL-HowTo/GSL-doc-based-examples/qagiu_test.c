/*
   Example adapted from the GNU Scientific Library Reference Manual
    Edition 1.1, for GSL Version 1.1
    9 January 2002
   URL: gsl/ref/gsl-ref_23.html#SEC364
    Revised: 19-Nov-2002 by Dick Furnstahl  furnstahl.1@osu.edu
*/

/* 
  Compile and link with:
    gcc -c qagiu_test.c
    gcc -o qagiu_test qagiu_test.o -lgsl -lgslcblas -lm
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
   QAGIU adaptive integration on infinite intervals

   Function: 
   int gsl_integration_qagiu (gsl_function * f, double a,
      double epsabs, double epsrel, size_t limit, 
      gsl_integration_workspace * workspace, 
      double *result, double *abserr)

   This function computes the integral of the function f over the
   semi-infinite interval (a,+\infty). The integral is mapped onto the
   interval (0,1] using the transformation x = a + (1-t)/t,

   \int_{a}^{+\infty} dx f(x) = 
        \int_0^1 dt f(a + (1-t)/t)/t^2

   and then integrated using the QAGS algorithm.
*/


/*
   The integrator QAGIU will handle a large class of infinite-range integrals.
   For example, consider the following integral, 
   
   \int_1^\infty cos[2x] e^{-x} dx = -0.16442310483055015762

   The program below computes this integral to a relative accuracy bound
   of 1e-8.
*/

/*
   The results below show that the desired accuracy is achieved after
   10 subdivisions.

   result          = -0.164423104830549505
   exact result    = -0.164423104830550171
   estimated error =  0.000000005882847412
   actual error    =  0.000000000000000666
   intervals =  10
*/

#include <stdio.h>
#include <math.h>
#include <gsl/gsl_integration.h>

double
my_integrand (double x, void *params_ptr)
{
  double alpha;

  alpha = *(double *) params_ptr;

  return (cos (alpha * x) * exp (-x));
}

int
main (void)
{
  gsl_integration_workspace *work_ptr =
    gsl_integration_workspace_alloc (1000);

  double lower_limit = 1.;	/* start integral from 1 (to infinity) */
  double abs_error = 1.0e-8;	/* to avoid round-off problems */
  double rel_error = 1.0e-8;	/* the result will usually be much better */
  double result;		/* the result from the integration */
  double error;			/* the estimated error from the integration */

  double alpha = 2.0;
  double expected = -0.16442310483055015762;	/* known answer */

  gsl_function My_function;
  void *params_ptr = &alpha;

  My_function.function = &my_integrand;
  My_function.params = params_ptr;

  gsl_integration_qagiu (&My_function, lower_limit,
			 abs_error, rel_error, 1000, work_ptr, &result,
			 &error);

  printf ("result          = % .18f\n", result);
  printf ("exact result    = % .18f\n", expected);
  printf ("estimated error = % .18f\n", error);
  printf ("actual error    = % .18f\n", result - expected);
  printf ("intervals =  %d\n", work_ptr->size);

  return 0;
}

/*
Local Variables:
compile-command: "gcc -o program -Wall qagiu_test.c -lgsl -lgslcblas -lm"
End:
*/
