// http://users.stat.umn.edu/~geyer/rc/
// uses GetRNGstate() to initialize the seed object.

//Note the compile command must include /usr/share/R/include
#include <R.h>
#include <Rmath.h>

void baz(int *nin, double *sin, double *tin, double *x)
{
  int n = nin[0];
  double s = sin[0];
  double t = tin[0];
  
  int i;
  
  GetRNGstate();
  
  for (i = 0; i < n; i++)
    x[i] = rbeta(s, t);
  
  PutRNGstate();
}

/*
Local Variables:
compile-command: "R CMD SHLIB geyerex-1.c -I/usr/share/R/include" 
End:
*/
