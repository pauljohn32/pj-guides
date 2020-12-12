PJ 2012-11-13

Perhaps you are writing a C program, but you want to call 
a function from R's collection.  The R team has made that
possible with libRmath.so and some example calling conventions.

The program should include the header Rmath.h, which SHOULD
be installed in one of the usual locations for header files,
for example, /usr/include.

Using R mathlib is not conceptually different from accessing any C
library, such as the GNU Scientific library. We add the include
statement in the C code, and then the compiler command may include
some additional information for linking the program. It is definitely
necessary to add the compiler option "-lRmath".  If Rmath.h
is not in a "usual" place, one can tell the compiler where it
might be with -I/usr/share/R/include. If libRmath.so is not in
one of the usual places, one can tell the compiler where it is with
an argument like "-L/usr/lib/R/lib" or such.

This folder includes some examples that do work for me. I notice it is
necessary to change these things from semester-to-semester to be sure
the includes and shared libraries are found.

Please note. These functions do not interact with an R 
session, they are just including the Rmath.h header file
and using the functions provided there. 

Finding out if you can compile C programs using R mathlib.

On a Linux OS, there is usually a separate package one must install in
order to access R math functions from C. On Debian linux, the package
is called "r-mathlib". Here is a list of the files that are provided.

/usr/lib/libRmath.a
/usr/lib/libRmath.so.1.0.0
/usr/lib/pkgconfig
/usr/lib/pkgconfig/libRmath.pc
/usr/share/doc/r-mathlib/README
/usr/share/doc/r-mathlib/changelog.gz
/usr/share/doc/r-mathlib/examples
/usr/share/doc/r-mathlib/examples/test.c
/usr/share/doc/r-mathlib/README.mathlib
/usr/share/doc/r-mathlib/copyright
/usr/share/doc/r-mathlib/OONEWS.gz
/usr/share/doc/r-mathlib/ONEWS.gz
/usr/share/doc/r-mathlib/changelog.Debian.gz
/usr/include/Rmath.h
/usr/lib/libRmath.so.1
/usr/lib/libRmath.so
/usr/share/doc/r-mathlib/NEWS.gz

On RedHat based systems, they have (frustratingly) divided this
material into two RPM packages, 
libRmath
libRmath-devel

Their contents are, respectively,

libRmath
Description :
A standalone library of mathematical and statistical functions derived
from the R project.  This package provides the shared libRmath library.
/usr/lib64/libRmath.so
/usr/share/doc/libRmath-2.15.2
/usr/share/doc/libRmath-2.15.2/COPYING

libRmath-devel
A standalone library of mathematical and statistical functions derived
from the R project.  This package provides the libRmath header files.
/usr/include/Rmath.h
/usr/lib64/pkgconfig/libRmath.pc



pj
