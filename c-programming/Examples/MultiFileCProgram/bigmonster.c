#include "bigmonster.h"

#include "stdio.h"

int 
godzilla(int x)
{
  int rand_seed;
  i = 10;
  printf("I am godzilla, prepare to suffer \n");

  rand_seed = i * 2345252 +98797;    
  j = (int)(rand_seed / 65536) % 32768;  
  printf("My random number is %d \n", j); 
  return j;  
}
