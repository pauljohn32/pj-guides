PJ 2012-11-13

I found this here:

http://www.math.ncu.edu.tw/~chenwc/R_note/index.php?item=R_gsl

He has code for a c file and and R file, shown below.

Credits to OP, I'm just "making it work".

gsltools.c is a simple file that uses the GSL to calculate a
permutation, all of the ways
to re-order a given number of options. For example, the output
for 3 options is:
> allpermu(3)
     [,1] [,2] [,3] [,4] [,5] [,6]
[1,]    1    1    2    2    3    3
[2,]    2    3    1    3    1    2
[3,]    3    2    3    1    2    1

That's 3*2 columns.

If you run this for 4 options, it returns 24 columns.
> allpermu(4)

That's 4*3*2 columns.


1. Get "callgsl.R" and "gsltools.c" in a folder.


2. Compile 

Note, as you see in his instructions below, you can compile that
program manually in two steps with gcc. I found it was necessary to
manually insert -fPIC on step one, or else the error is:

$ gcc  -c gsltools.c      pauljohn@pjlap-124:FromR-CallGSL-C$  gcc -shared -o gsltools.so gsltools.o -lgsl -lgslcblas
/usr/bin/ld: gsltools.o: relocation R_X86_64_PC32 against undefined symbol `gsl_permutation_alloc' can not be used when making a shared object; recompile with -fPIC
/usr/bin/ld: final link failed: Bad value
collect2: error: ld returned 1 exit status

But it will work if you follow the instructions in his
code, as I've amended them.

It is more problem-free to use R CMD SHLIB to do it. Note in the output
it inserts the fpic for me.

$ R CMD SHLIB gsltools.c
gcc -std=gnu99 -I/usr/share/R/include -DNDEBUG      -fpic  -O3 -pipe  -g  -c gsltools.c -o gsltools.o
gcc -std=gnu99 -shared -o gsltools.so gsltools.o -L/usr/lib64/R/lib
-lR


3. Save the following code, run it in R (or from the command
line with "R -f callgsl.R".


# File name: callgsl.R

dyn.load("/usr/lib/libgslcblas.so", local = FALSE, now = FALSE)
dyn.load("/usr/lib/libgsl.so", local = FALSE, now = FALSE)
dyn.load("gsltools.so")
### For MS Windows, they will be like these
# dyn.load("C:/PROGRA~1/RTOOLS/MINGW/BIN/LIBGSLCBLAS.DLL")
# dyn.load("C:/PROGRA~1/RTOOLS/MINGW/BIN/LIBGSL.DLL")
# dyn.load("gsltools.dll")

allpermu <- function(n){
#  if(n > 10) stop("allpermu: n <= 10")
  ncol <- as.integer(factorial(n))
  nrow <- as.integer(n)
  all <- vector(mode = "integer", length = nrow * ncol)
  ret <- .C("allpermu", nrow, all)[[2]]
  matrix(ret, nrow = nrow) + 1
}

allpermu(3)

dyn.unload("gsltools.so")
dyn.unload("/usr/lib/libgsl.so")
dyn.unload("/usr/lib/libgslcblas.so")
### For MS Windows, they will be like these
# dyn.unload("gsltools.dll")
# dyn.unload("C:/PROGRA~1/RTOOLS/MINGW/BIN/LIBGSL.DLL")
# dyn.unload("C:/PROGRA~1/RTOOLS/MINGW/BIN/LIBGSLCBLAS.DLL")



NOTE:

This uses the .C interface in R to call the C function.


I wish I has a re-write of the C code that uses the newer
.Call interface, but I'm not sure how or whether that's
beneficial. The R documents say .Call is much preferred, but
they also say that if .C works, we might as well use it.
There are lots of new features with .Call, though.



======================the original file, with insertion of -fPIC====

/*
  File name: gstools.c
  For Linux,
  SHELL> gcc -fPIC -c gsltools.c; gcc -shared -o gsltools.so gsltools.o -lgsl -lgslcblas
  For MS Windows, check if -fPIC is needed
  SHELL> gcc -fPIC -c gsltools.c
  SHELL> gcc -shared -o gsltools.dll gsltools.o -lgsl -lgslcblas
*/

#include <gsl/gsl_permutation.h>

int allpermu(int *nrow, int *all){
  gsl_permutation *p;
  int i, j;

  p = gsl_permutation_alloc(*nrow);
  gsl_permutation_init(p);

  i = 0;
  do{
    for(j = 0; j < *nrow; j++){
      *(all + i + j) = (int) gsl_permutation_get(p, (size_t) j);
    }
    i += *nrow;
  }
  while(gsl_permutation_next(p) == GSL_SUCCESS);

  gsl_permutation_free (p);

  return 0;
}



