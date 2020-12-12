//see  http://stackoverflow.com/questions/2463437/r-from-c-simplest-possible-helloworld

#include <Rinternals.h> 
#include <Rembedded.h> 

SEXP hello() { 
  return mkString("Hello, world!\n"); 
} 

int main(int argc, char **argv) { 
  SEXP x; 
  Rf_initEmbeddedR(argc, argv); 
  x = hello(); 
  return x == NULL;             /* i.e. 0 on success */ 
} 




/*
Local Variables:
compile-command: "gcc -o hello-1 hello-1.c -I/usr/share/R/include -L/usr/lib/R/lib -lR"
End:
*/


//How did I know to do that? From R Extensions:
/* Suitable flags to compile and link against the R (shared or static) library can be found by */

/*      R CMD config --cppflags */
/*      R CMD config --ldflags */

/* If R is installed, pkg-config is available and sub-architectures have not been used, alternatives for a shared R library are */

/*      pkg-config --cflags libR */
/*      pkg-config --libs libR */

/* and for a static R library */

/*      pkg-config --cflags libR */
/*      pkg-config --libs --static libR */
