//Based on Eubank & Kupresanin, p. 36

//PJ: This DOES NOT WORK. It compiles, but results in "segmentation fault"
//
#include <iostream>

#define MATHLIB_STANDALONE
#include <Rmath.h>
#include <R.h>

using namespace std;

int main(int argc, const char* argv[])
{

int x = 17;
double y = 3.5*1.12313;
 Rprintf("I'll ignore the cout stuff, and just use the Rprintf function instead, just as if I were writing C \n"); 
 Rprintf("Integer x = %d\n", x);
cout << "integer x" << x << endl;
Rprintf("Double y = %f\n", y);

return 0;
}


/*
Local Variables:
compile-command: "g++ example-1-hello-2.cc -Wall -DNDEBUG -o mycplusplus1 -fpic -pipe -g -I/usr/share/R/include  -L/usr/lib64/R/lib -lR -lRmath" 
End:
*/
