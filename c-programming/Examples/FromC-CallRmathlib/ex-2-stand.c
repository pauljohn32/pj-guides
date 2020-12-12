// http://www.stat.berkeley.edu/classes/s243/rmath.html

/* PJ 2011-03-01
   This asks the user for 3 values and then feeds them to R's qbeta
   function, which calculates the quantiles of the beta distribution
*/

#define MATHLIB_STANDALONE

#include <stdlib.h>
#include <stdio.h>
#include <Rmath.h>

main(){
   double shape1,shape2,prob;
   
   printf("Enter first shape parameter: ");
   scanf("%lf",&shape1);

   printf("Enter second shape parameter: ");
   scanf("%lf",&shape2);

   printf("Enter probability level: ");
   scanf("%lf",&prob);

   printf("Critical value is %lf\n",qbeta(prob,shape1,shape2,1,0));
}


/*
Local Variables:
compile-command: "gcc -o stand2 ex-2-stand.c -fpic -lRmath -lm" 
End:
*/
