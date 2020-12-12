//Eubanks and Kupresanin, p. 190
#include <R.h>
#include <Rmath.h>

extern "C" {

  void rngFunc(int* n, double* mu, double* sig, double* x)
    {
      GetRNGstate();
      for(int i = 0; i < *n; i++)
	{
	  x[i]  = rnorm(*mu, *sig);
	}
      PutRNGstate();
    }
}

/*
Local Variables:
compile-command: "R CMD SHLIB rngEx.cc" 
End:
*/
