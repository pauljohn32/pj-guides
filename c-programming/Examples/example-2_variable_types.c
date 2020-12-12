#include <stdio.h>
#include <stdlib.h>
#include <values.h>

int
main ()
{
  /*First, we define a few different kinds of variables */

  int     i = 425;
  short int j = 17;
  long int  I = -75000L;
  unsigned int u = 12;
  unsigned long int U = 444;  
  long long int k = -3453;

  float        f=19.4F;
  double       d= -95.3452;
  long double  D= -44345;

  printf ("\n \n \n Printf is the command you often use to write information to the console \n");
  printf ("while a program is running.  You can output results or diagnostic information. \n");
  printf ("A printf command can just print a character string, in quotes, but it is \n");
  printf ("most useful when you combine it with percent signs and variable \"place holders\" \n");
  printf ("that then output the values of variables \n");


  printf ("Integers: \n");
  printf ("Here are four of the output formats for integers \n");
  printf ("i  d (synonyms) x (Hex) u (unsigned) \n");

  printf ("%i    %d     %x      %u \n", i, i, i, i);
  printf ("%i    %d     %x      %u \n",  j, j, j, j);
  printf ("%i    %d     %x      %u \n",  u, u, u, u);

  printf("\n Long integers. I always forget the symbols for those \n");
  printf ("%ld  %lu \n",  I, I);

  
 
  printf ("\nFloats and Doubles \n");
  printf ("%f      %e      %g \n", f , f, f);
  printf ("%.2f    %.3e \n", f, f);
  printf ("%7.2f   %7.2e\n", f, f);
  printf ("%f  %e  %g \n", d, d, d);


  printf("\nLet's see how many bytes these things use on your system\n");
  // note the "sizeof" function returns a long unsigned int, and either %ld or %lu
  // works as a format specifier
  printf("size of int = %ld bytes\n", sizeof(i));
  printf("size of short int = %ld bytes\n", sizeof(j));
  printf("size of long int = %ld bytes\n", sizeof(I));
  printf("size of unsigned int = %ld bytes\n", sizeof(u));
  printf("size of unsigned long int = %ld bytes\n", sizeof(U));
  printf("size of unsigned long long int = %ld bytes\n", sizeof(k));

  printf("size of float = %lu bytes\n", sizeof(f));
  printf("size of double = %lu bytes\n", sizeof(d));
  printf("size of long double = %lu bytes\n", sizeof(D));
 

  printf("I just noticed the values.h header has some pre-defined values you can access;");
  printf("The maximum value of a short int is %d \n", MAXSHORT);
  printf("The maximum value of an int is %d \n", MAXINT);

  printf("The maximum value of a long int is %ld \n", MAXLONG);
  printf("The minimum value of a long int is %ld \n", MINLONG);
  
  printf("The maximum value of a float is %f \n", MAXFLOAT);
  printf("The minimum value of a float is %f \n", MINFLOAT);
 
  printf("The maximum value of a double  is %f \n", MAXDOUBLE);
  printf("The minimum value of a  double is %f \n", MINDOUBLE);

  return 0; 
  
}


/*
Local Variables:
compile-command: "gcc example-2_variable_types.c -Wall -o whatever "
End:
*/
