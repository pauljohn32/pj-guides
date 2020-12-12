PJ 2011-03-01

Same approach here as any C-calling R. 

Step 1. compile the C code in a way that R can understand

Step 2. Load that shared object in R

Step 3. Run the R function that calls the C code.


Example 1. 

Create ex-1-callRobj.o

$ R CMD SHLIB ex-1-callRobj.c 
gcc -I/usr/share/R/include      -fpic  -std=gnu99 -O3 -pipe  -g -c ex-1-callRobj.c -o ex-1-callRobj.o
gcc -shared -o ex-1-callRobj.so ex-1-callRobj.o -L/usr/lib64/R/lib -lR


Inside R, following uses that. See ex-1-call.R

Note this example creates an R object in the C code.

