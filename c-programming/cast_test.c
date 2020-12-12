#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
   int relay = 0;
   int i;
   int * intptr;
   * intptr = 6;
   for ( i = 0; argv[1][i]; ++i )
   {
      int x = 1 << (argv[1][i] - '1 ');
      printf("x = %d\n", x);
      relay += x;
   }
   printf("relay = %d intptr=%x\n", relay, (unsigned long)intptr);
   return 0;
}

/* my output
C:\Test>test 46
x = 8
x = 32
relay = 40

C:\Test>test 137
x = 1
x = 4
x = 64
relay = 69
*/
