/*
   Example taken from the GNU Scientific Library Reference Manual
    Edition 1.1, for GSL Version 1.1
    9 January 2002
   URL: gsl/ref/gsl-ref_23.html#SEC364
*/

/* 
  Compile and link with:
    gcc -c Monte_Carlo_test.c
    gcc -o Monte_Carlo_test Monte_Carlo_test.o -lgsl -lgslcblas -lm
*/    

/*
   The example program below uses the Monte Carlo routines to estimate
   the value of the following 3-dimensional integral from the theory of
   random walks,

   I = \int_{-pi}^{+pi} {dk_x/(2 pi)} 
       \int_{-pi}^{+pi} {dk_y/(2 pi)} 
       \int_{-pi}^{+pi} {dk_z/(2 pi)} 
        1 / (1 - cos(k_x)cos(k_y)cos(k_z))

   The analytic value of this integral can be shown to be I =
   \Gamma(1/4)^4/(4 \pi^3) = 1.393203929685676859.... The integral gives
   the mean time spent at the origin by a random walk on a body-centered
   cubic lattice in three dimensions.

   For simplicity we will compute the integral over the region (0,0,0)
   to (\pi,\pi,\pi) and multiply by 8 to obtain the full result. The
   integral is slowly varying in the middle of the region but has
   integrable singularities at the corners (0,0,0), (0,\pi,\pi),
   (\pi,0,\pi) and (\pi,\pi,0). The Monte Carlo routines only select
   points which are strictly within the integration region and so no
   special measures are needed to avoid these singularities.

*/


/*
   With 500,000 function calls the plain Monte Carlo algorithm achieves
   a fractional error of 0.6%. The estimated error sigma is consistent
   with the actual error, and the computed result differs from the true
   result by about one standard deviation,

   plain ==================
   result =  1.385867
   sigma  =  0.007938
   exact  =  1.393204
   error  = -0.007337 = 0.9 sigma

   The MISER algorithm reduces the error by a factor of two, and also
   correctly estimates the error,

   miser ==================
   result =  1.390656
   sigma  =  0.003743
   exact  =  1.393204
   error  = -0.002548 = 0.7 sigma

   In the case of the VEGAS algorithm the program uses an initial
   warm-up run of 10,000 function calls to prepare, or "warm up", the
   grid. This is followed by a main run with five iterations of 100,000
   function calls. The chi-squared per degree of freedom for the five
   iterations are checked for consistency with 1, and the run is
   repeated if the results have not converged. In this case the
   estimates are consistent on the first pass.

   vegas warm-up ==================
   result =  1.386925
   sigma  =  0.002651
   exact  =  1.393204
   error  = -0.006278 = 2 sigma
   converging...
   result =  1.392957 sigma =  0.000452 chisq/dof = 1.1
   vegas final ==================
   result =  1.392957
   sigma  =  0.000452
   exact  =  1.393204
   error  = -0.000247 = 0.5 sigma

   If the value of chisq had differed significantly from 1 it would
   indicate inconsistent results, with a correspondingly underestimated
   error. The final estimate from VEGAS (using a similar number of
   function calls) is significantly more accurate than the other two
   algorithms.
*/

#include <stdlib.h>
#include <gsl/gsl_math.h>
#include <gsl/gsl_monte.h>
#include <gsl/gsl_monte_plain.h>
#include <gsl/gsl_monte_miser.h>
#include <gsl/gsl_monte_vegas.h>

/* Computation of the integral,

      I = int (dx dy dz)/(2pi)^3  1/(1-cos(x)cos(y)cos(z))

   over (-pi,-pi,-pi) to (+pi, +pi, +pi).  The exact answer
   is Gamma(1/4)^4/(4 pi^3).  This example is taken from
   C.Itzykson, J.M.Drouffe, "Statistical Field Theory -
   Volume 1", Section 1.1, p21, which cites the original
   paper M.L.Glasser, I.J.Zucker, Proc.Natl.Acad.Sci.USA 74
   1800 (1977) */

/* For simplicity we compute the integral over the region 
   (0,0,0) -> (pi,pi,pi) and multiply by 8 */

double
g (double *k, size_t dim, void *params);

void
display_results (char *title, double result, double error);

double exact = 1.3932039296856768591842462603255;

double
g (double *k, size_t dim, void *params)
{
  double A = 1.0 / (M_PI * M_PI * M_PI);
  return A / (1.0 - cos (k[0]) * cos (k[1]) * cos (k[2]));
}

void
display_results (char *title, double result, double error)
{
  printf ("%s ==================\n", title);
  printf ("result = % .6f\n", result);
  printf ("sigma  = % .6f\n", error);
  printf ("exact  = % .6f\n", exact);
  printf ("error  = % .6f = %.1g sigma\n", result - exact,
          fabs (result - exact) / error);
}

int
main (void)
{
  double res, err;

  double xl[3] = { 0, 0, 0 };
  double xu[3] = { M_PI, M_PI, M_PI };

  const gsl_rng_type *T;
  gsl_rng *r;

  gsl_monte_function G = { &g, 3, 0 };

  size_t calls = 500000;

  gsl_rng_env_setup ();

  T = gsl_rng_default;
  r = gsl_rng_alloc (T);

  {
    gsl_monte_plain_state *s = gsl_monte_plain_alloc (3);
    gsl_monte_plain_integrate (&G, xl, xu, 3, calls, r, s, 
                               &res, &err);
    gsl_monte_plain_free (s);

    display_results ("plain", res, err);
  }

  {
    gsl_monte_miser_state *s = gsl_monte_miser_alloc (3);
    gsl_monte_miser_integrate (&G, xl, xu, 3, calls, r, s,
                               &res, &err);
    gsl_monte_miser_free (s);

    display_results ("miser", res, err);
  }

  {
    gsl_monte_vegas_state *s = gsl_monte_vegas_alloc (3);

    gsl_monte_vegas_integrate (&G, xl, xu, 3, 10000, r, s,
                               &res, &err);
    display_results ("vegas warm-up", res, err);

    printf ("converging...\n");

    do
      {
        gsl_monte_vegas_integrate (&G, xl, xu, 3, calls/5, r, s,
                                   &res, &err);
        printf ("result = % .6f sigma = % .6f "
                "chisq/dof = %.1f\n", res, err, s->chisq);
      }
    while (fabs (s->chisq - 1.0) > 0.5);

    display_results ("vegas final", res, err);

    gsl_monte_vegas_free (s);
  }
  return 0;
}

/* Note:
  This compiles the file and links against 3 shared libraries, gsl, glscblas, and the general math library
*/

/*
Local Variables:
compile-command: "gcc -o program -Wall Monte_Carlo_test.c -lgsl -lgslcblas -lm"
End:
*/
