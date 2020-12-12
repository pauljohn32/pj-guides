/* PJ 2011-03-1
  example-10.3.c. More sophisticated argument management..
 
  This uses the argp framework, which we use in "real" programs (Swarm!)

  Ask for help

  $ ./program --help

  $ ./program --usage

Use it:

  $ ./program -n 555

  $ ./program -n555

  $ ./program --degfreedom=555
  
to ask for 555 degrees of freedom.
  
  I've added a variable "output_file" option here, but don't use it yet.
  
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

#include <argp.h>

const char *argp_program_version = "simple_argp 0.1";
const char *argp_program_bug_address =
           "<some_email_address@you_care_about.com>";

static char doc[] =
"Use argp if you are serious about command line";

static char args_doc[] = "ARG1 ARG2";

/* initialise an argp_option struct with the options we except */
static struct argp_option options[] =
{
  {"verbose", 'v', 0,      0, "Produce verbose output" },
  {"degfreedom", 'n', "ARG", 0, "Degrees of Freedom"},
  {"output",  'o', "FILE", 0, "Output to FILE" },
  { 0 }
};


/* This is a Global variable, we can set default values inside main,
 then read the command line to change those defaults.
 Used by `main' to communicate with `parse_opt'. */
struct arguments
{
  char *args[2];                /* ARG1 & ARG2 */
  int silent, verbose;
  double nu;
  char *output_file;
  
};


/* Function that inspects options option. */
static error_t
parse_opt (int key, char *arg, struct argp_state *state)
{
  /* Get the INPUT argument from `argp_parse', which we
     know is a pointer to our arguments structure. */
  struct arguments *arguments = state->input;

  switch (key)
    {
    case 'q': case 's':
      arguments->silent = 1;
      break;
    case 'v':
      arguments->verbose = 1;
      break;
    case 'n':
      arguments->nu = atof(arg);
    case 'o':
      arguments->output_file = arg;
      break;

    /* case ARGP_KEY_ARG: */
    /*   if (state->arg_num >= 3) */
    /*     /\* Too many arguments. *\/ */
    /*     argp_usage (state); */

    /*   arguments->args[state->arg_num] = arg; */

    /*   break; */

    /* case ARGP_KEY_END: */
    /*   if (state->arg_num < 2) */
    /*     /\* Not enough arguments. *\/ */
    /*     argp_usage (state); */
    /*   break; */

    default:
      return ARGP_ERR_UNKNOWN;
    }
  return 0;
}

/* Our argp parser. */
static struct argp argp = { options, parse_opt, args_doc, doc };






int main (int argc, const char **argv)
{

  struct arguments arguments; /* struct of type "arguments" called same */
  gsl_rng * r;
  int i;  
  int N = 150; // N of points for which to calculate P(x)
  double nu; //degrees of freedom 
  double * x; // values for which ChiSq is to be calculated
  double xMax = 0; // highest value of x
  double * probChiLT = 0;

  arguments.silent = 0;
  arguments.verbose = 0;
  arguments.nu = 33.44;
  arguments.output_file = "-";
    

  /* now tell argp_parse to actually do work. 
     Result goes into arguments struct */
  argp_parse (&argp, argc, argv, 0, 0, &arguments);

  nu = arguments.nu;

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
compile-command: "gcc -g -pg -o program -Wall example-10.3.c -lgsl -lgslcblas -lm"
End:
*/
