#include <stdio.h>
#include <stdlib.h>
#include "bigmonster.h"

int
main ()
{
  int     i; //note the variable i exists in both godzilla and main
 

  i = godzilla(3); //the function godzilla is called
  
  printf("\n I'm in the main. I find that the output from godzilla(3) is %d \n", i);
  return 0; 
  
}


/* Here's how to compile this program. Type "make". Watch 
   what happens 

$ make
gcc -c -g main.c
gcc -c -g bigmonster.c
gcc -o myMonsterProgram main.o bigmonster.o

*/
