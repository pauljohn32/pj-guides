/* C Headers */
#include <stdio.h>

/* stdio.h is needed for the "printf" function */

#include <stdlib.h>



int main( int argc, const char *argv[] )
{
    int i = 0;
/*  i is the only variable we declare in the program */

/* note the for function has 3 parts.  
   Part I: give beginning point for an iterating variable
   Part II: state a condition that tells the loop if it should continue to the next step.
            This one continues as long as i is less than 10.
   Part III: A transformation performed automatically at the end of each step. 
   ++ means "add one"
*/
    for ( i = 0; i < 10; i++ )
    {
      printf("%d Hello World !\n",i);
    }

    exit(0);
}


/*
Local Variables:
compile-command: "gcc -o whatever -Wall example-3_for_loop.c "
End:
*/
