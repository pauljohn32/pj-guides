/* 
   Paul Johnson 2007-02- 15
   This example shows the use of "if" "if-else" "for" "while" and "do/while"
   The reader should study the "switch-case" conditional as well.
*/


/* C Headers */
#include <stdio.h>

/* stdio.h is needed for the "printf" function */

#include <stdlib.h>
#include <math.h> /* for sin and M_PI */

void returnNothing (void)
{

  int i = 0;
  /*  i is the only variable we declare in the function*/

  printf( "Hello, I'm inside the function returnNothing \n \n");

    for ( i = 0; i < 10; i++ )
    {
      printf("%d Hello World !\n",i);
    }

   printf("I'm finished in the the function returnNothing \n \n");

   /* Note, there is no return here because the function type is void */
}

int returnDouble ( int x )
{
  /* x is available anywhere inside the function */
  int y = 0; /* y is a 'local variable' */

  printf("I'm inside return Double \n"); 
  y = 2 * x; 
  printf("I just finished calculating y inside returnDouble \n");
  return y;
}


double returnPI ( void)
{
  return M_PI;
}

double returnSillyValue ( int x, double y )
{
  return 3.0 * x + sin ( y );
}


int main( int argc, const char *argv[] )
{

  int i= 0;
  int myDiff = 0;
  int myVal = -99;

  /*
    &&   logical AND
    ||    logical OR
    ==    compared equal to.  Different from =, which means "assignment" 
    >      greater than
    <     less than
    <=    less than or equal to
    >=    greater than or equal to
  */

  if ( 1 )
    {
      printf("The value of 1 is considered TRUE. The value 0 is considered False\n");
    }

  if ( i == 0 && myDiff == 0 ) printf("i and myDiff are both equal to 0 \n\n");

  /* if you forget the == here,  and use = instead, the compiler warning/error is 
     warning: suggest parentheses around assignment used as truth value.
  */
  if ( i == 0 || myDiff == 7 ) printf ("i is 0 or myDif is 7\n\n");

  /*Same as */

  if ( i == 0 || myDiff == 7 )
    {    
      printf ("i is 0 or myDiff is 7\n\n");
    }

  if ( i < 5 && myDiff == 0 ) 
    {
      printf("i is less than 5, and myDiff equals 0. See: i=%d myDiff=%d \n", i,  myDiff);
      printf("The squiggly braces are needed if more than one statement is needed as a part of the 'if'\n\n");
    }

  if ( (myVal = 88) > 0 )
    {
      printf(" myVal is %d inside the if's braces \n ", myVal);
    }
  printf("Outside the scope of the if statement, myval's value is now %d \n \n", myVal);



  /* if else is frequently easy to use*/

  if (i <0 ) printf("my i is less that 0 \n");

  else printf ("my i is not less than 0");
  
  /* nested if/else statements can bite you in the ass. So always put in an else, even if it does nothing. */


  if ( i == 0 )
    {
      if ( myDiff == 0 )
	{
	  printf("\n i= %d myDiff=%d\n", i, myDiff);
	}
      else
	{
	  ;  /* I did nothing here, it is just keeping the code clear */
	}
    }
  else
    {
      printf("\n i is not equal to 0 \n");
    }


  
  if ( i == 0 )
    {
      if ( myDiff == 0 )
	{
	  printf("\n i= %d myDiff=%d\n", i, myDiff);
	}
      else
	{
	  ;  /* I did nothing here, it is just keeping the code clear */
	}
    }
  else if ( i < 0 )
    {
      printf("\n i is less than 0 \n");
    }
  else
    {
      printf("\n i is not equal to 0 and it is not less than 0 \n");
    }
    

  /* instead of a sequence of if/elseif/else statements, many people
     would suggest a "switch" statement for clarity. Read a C manual 
  */




  printf("For loop\n");
  for (i=0; i < 10; i++)
    {
      printf("%d ", i);
    }
  printf(" \n For loop finished \n \n");


  printf("a while loop is like a for loop, sometimes, if you just count up from 0 to 9 \n");
  i = 0;
  while(i < 10 )
    {
      printf("The while loop's index variable i is %d \n", i);
      i=i+1; /* note: you have to manually increment i at the end of the loop*/;
      /* could as well have used the shortcut notation i++ */

      printf ("  The Silly Value is %f \n " , returnSillyValue (i, cos((i+myDiff)*M_PI) ) );

    }
  printf("That while loop was great, wasn't it? \n\n");

  {
    int j;

    printf("Like an if statement, a while statement it can assign a value to a variable.\n");
    printf("The change to the myDiff variable is permanent, and applies outside the while loop\n");
    j = 18;
    i = 0;
    while( (myDiff = -21 + j - i) < 10 )
      {
	printf("The while loop has i=%d j=%d, and myDiff=%d \n", i, j, myDiff);
	i=i+1; 
	j=j+2;
      }
  }
  printf("Outside the scope that encloses the while loop, the value of myDiff is %d \n \n", myDiff);
  printf("Note that myDiff is stepped ahead one extra time--one more time than the while loop executed.\n\n");

  printf("A while loop will quit without even one iteration if the condition is false.\n");
  i=0;
  do
    { 
      printf("startDo: The index variable i is %d ", i); 
      i+=1;  //note: same as i=i+1;
       printf("EndDo: it is  %d \n", i); 
    } while (i<10);
 
  printf("\n \n A do loop always goes through one step before it processes the while.\n");

  i = -1;
  do
    { 
      printf("start the second do loop: The index variable i is %d ", i); 
      i+=1;  //note: same as i=i+1;
       printf("EndDo: it is  %d \n", i); 
    } while (i<0);

  printf("\n Note that after the second do/while loop, the value of i is incremented. i=%d \n", i);

  //Try these loops, replacing previous test with i<0
  //when is a do/while setup better than for or while?






 
  exit(0);
}

/*
  NOTE: Compiling this requires us to link in the math library, with -lm 
  option to gcc
*/


/*
Local Variables:
compile-command: "gcc -o whatever -Wall example-5_conditional.c -lm "
End:
*/
