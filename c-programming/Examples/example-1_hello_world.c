/* Note 1:  C Headers */
#include <stdio.h>

/* stdio.h is needed for the "printf" function */

#include <stdlib.h>

/* stdlib is needed for all C programs because it has basics like "exit" */


/* Note 2: The "main" function */
/* main is required in all C programs, with this syntax.  */
/* argc and argv are "built in" variable names, you can't */ 
/* change them.  argc indicates the number of command line options (parameters), while *argv[] */ 
/* contains those options (parameters).*/


int main( int argc, const char *argv[] )
{

  /* Note 3: The brackets are required. They define the "scope" of variables.*/

  /* Note 4: the printf function */
      printf("Hello World !\n");
  /* Note 5: the fprintf function */   
      fprintf(stderr, "Is Hello World different if we send it to standard error? \n");
      fprintf(stderr, "Not really, but it forces the print out immediately, so if the \n");
      printf("program crashes after this point, we will get to see this output. \n");
      printf("Otherwise, we might not \n");

      exit(0); 
      /* All has ended well.  This returns nothing-- meaning no error messages. */
      /* has same effect as "return 0;" I don't know why one is preferred over the other */
}



/* Note 6. How to compile this file and create a program called "pj" */
/* Open a terminal in the directory where you save this file.

Type 

   ls -la

Then compile the program; run this on the command line

   gcc -o pj -Wall example-1_hello_world.c

To make sure a new program was created, run

    ls -la

and then run the program by typing

   ./pj

Note you can change "pj" in both of these expressions.

In the bottom of this program, there is a bit of code
that tells emacs how to compile this for you. So if you type in 
this code, save the file, CLOSE emacs, and re-open the file in
Emacs, then Emacs will know what to do when you use the mouse
to choose "Tools" and then "compile".  After that, do Alt-x and 
type "eshell" and "do what comes natural" to you. 

*/


/*
Local Variables:
compile-command: "gcc -o pj -Wall example-1_hello_world.c "
End:
*/
