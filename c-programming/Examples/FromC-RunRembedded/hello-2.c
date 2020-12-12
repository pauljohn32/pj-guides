//R extensions manual

// Paul Johnson
// Compiles now, but does not do much
// 2015-11-30
#include <Rinternals.h> 
#include <Rembedded.h>

 int main(int argc, char **argv)
 {
     /* do some setup */
     Rf_initEmbeddedR(argc, argv);
     /* do some more setup */

      /* submit some code to R, which is done interactively via */
      /*    run_Rmainloop(); */

      /*    A possible substitute for a pseudo-console is */

      /*    R_ReplDLLinit(); */
      /*    while(R_ReplDLLdo1() > 0) { */
      /*    /\* add user actions here if desired *\/ */
      /*   } */

	 Rf_endEmbeddedR(0);
     /* final tidying up after R is shutdown */
     return 0;
 }


/*
Local Variables:
compile-command: "gcc -o hello-2 hello-2.c -I/usr/share/R/include -L/usr/lib/R/lib -lR"
End:
*/


