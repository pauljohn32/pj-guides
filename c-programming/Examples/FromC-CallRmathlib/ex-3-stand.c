// http://www.stat.berkeley.edu/classes/s243/rmath.html

#define MATHLIB_STANDALONE

#include <R.h>
#include <R_ext/Print.h>

#include <stdlib.h>
#include <stdio.h>
#include <Rmath.h>
#include <time.h>

main(){
   int i,n;
   double sum,x;
   time_t tt;
  
   tt = time(NULL);

/* the numbers passed to set_seed are arbitrary -- 
   use constants for a reproducible sequence       */

   set_seed(tt,77911);  

   printf("How many random normals to find the mean? ");
   scanf("%d",&n);

   sum = 0.;
   for(i=0;i<n;i++){
        sum += rnorm(0,1);      // mean, sd
        }
 
   printf("mean is %lf\n",sum/(double)n);
}



 /* PJ 2013-12-04 NOticed this does not compile in Ubuntu today. */
 /* Their packaging moved the R includes about, so am experimenting with */
 /* insertion of -I/usr/share/R/include */

/*
Local Variables:
compile-command: "gcc -o stand3 ex-3-stand.c -I/usr/share/R/include -fpic -lRmath -lm " 
End:
*/
