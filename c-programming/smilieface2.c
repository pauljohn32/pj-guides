/* Paul Johnson 2007-02-20


   Found a circle-drawing algorithm that I could adapt to my purpose here.
   http://groups.csail.mit.edu/graphics/classes/6.837/F98/Lecture6/circle.html



   
*/

/* C Headers */
#include <stdio.h>

/* stdio.h is needed for the "printf" function */

#include <stdlib.h>
#include <math.h> /* for sin and M_PI */




/* demonstrates malloc to dynamically allocate memory for a 2
   dimensional array. This allocates memory for an x by x array */

int ** returnIntSquare ( int x )
{
  
  int i = 0;
  int j = 0;

  int ** myDynamArray;
  
  /* gets memory for x "placeholders" for the array rows. */
  myDynamArray = malloc( x * sizeof(int *));

  for (i = 0; i < x; i++)
    {
      myDynamArray[i] = malloc(x * sizeof(int));
    }

  if (! myDynamArray ) exit(0);

  for (i = 0; i < x; i++) 
    {
      for (j=0; j<x; j++)
	{
	  myDynamArray[i][j] =  0;
	}
    }
  
 /*  printf ( "This demonstrates the values stored in the dynamic array\n"); */
/*   printf ("The values of myDynamArray with dimensions %d x %d  are\n", i, j); */
/*   for (i = 0; i < x; i++)  */
/*     { */
/*        for (j=0; j<x; j++) */
/* 	{ */
/* 	  printf ("%d ", myDynamArray[i][j]); */
/* 	} */
/*        printf("\n"); */
/*     } */

  return myDynamArray;
}

void circlePoints(int cx, int cy, int x, int y, int **target)
{
  if (x == 0) 
    {
      target[cx][ cy + y] = 1;
      target[cx][ cy - y] = 1;
      target[cx + y][ cy] = 1;
      target[cx - y][ cy] = 1;
    } 
  else 
    if (x == y) 
      {
	target[ cx + x][ cy + y] = 1;
	target[ cx - x][ cy + y] = 1;
	target[ cx + x][ cy - y] = 1;
	target[ cx - x][ cy - y] = 1;
      } 
    else 
      if (x < y) 
	{
	  target[ cx + x][ cy + y] = 1;
	  target[ cx - x][ cy + y] = 1;
	  target[ cx + x][ cy - y] = 1;
	  target[ cx - x][ cy - y] = 1;
	  target[ cx + y][ cy + x] = 1;
	  target[ cx - y][ cy + x] = 1;
	  target[ cx + y][ cy - x] = 1;
	  target[ cx - y][ cy - x] = 1;
	}
}


void circleMidpoint(int xCenter, int yCenter, int radius, int **target)
{ 
  int x = 0;
  int y = radius;
  int p = (5 - radius*4)/4;
  
  circlePoints(xCenter, yCenter, x, y, target);

  while (x < y) 
    {
      x++;
      if (p < 0) 
	{
	  p += 2*x+1;
	} 
      else 
	{
	  y--;
	  p += 2*(x-y)+1;
	}
      circlePoints(xCenter, yCenter, x, y, target);
    }
}





int main( int argc, const char *argv[] )
{
  int i;
  int j; 
  int ** whateverArray;
  int diameter = 40;
  int halfWidthOfSmile;

  whateverArray = returnIntSquare(diameter);
 
  /* face outline */
  circleMidpoint(diameter/2, diameter/2, diameter/2-1, whateverArray);
  /* left eye */
  circleMidpoint(1+diameter/3, 1+diameter/4, 4, whateverArray);
  /* right eye */
  circleMidpoint(1+diameter/3, 3*diameter/4, 4, whateverArray);


  halfWidthOfSmile = diameter/6;
  for (i = 0; i < halfWidthOfSmile; i++)
    {
      whateverArray[1+2*diameter/3+i][1 + i + diameter/2 - halfWidthOfSmile] = 1;
      whateverArray[1+2*diameter/3+i][-i + diameter/2 + halfWidthOfSmile] = 1;
    }




  printf("Let's review the values of whateverArray \n");

  printf("%c[%d;%d;%dm",0x1B,2,32,40);

  for (i = 0; i < diameter; i++) 
    { 
      for (j=0; j < diameter; j++)
	{
	  if (whateverArray[i][j]== 1) 
	    {
	      printf("%d " ,  whateverArray[i][j]);
	      
	    }
	  else
	    {
	  
	      printf(". ");
	    }
	}
      printf("\n");
    }
  printf("%c[%d;%d;%dm",0x1B,0,38,40);
  free(whateverArray);

  exit(0);
}



/*
Local Variables:
compile-command: "gcc -o whatever -Wall smilieface2.c -lm "
End:
*/
