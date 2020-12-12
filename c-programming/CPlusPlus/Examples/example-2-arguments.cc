#include <iostream>
#include <cstdlib> //A C++ equivalent to C's stdlib.h


using namespace std;

int main(int argc, const char* argv[]){

  { // print out all command line arguments, unfiltered,
    // untransformed
    int i;
    for(i = 0; i < argc; i++ )
      {
	cout << "arg " << i << " is " << argv[i] << endl;
      }
  }

  //Notice argv[0] is the name of the program!
  //if there is argv[1], convert it to an integer.

 

  if (argv[1])
    { // will work if the first argument can be coerced to integer
      int m = atoi(argv[1]);
      cout << "The first argument after the function name was " << m << endl;
      cout << "Now it is an integer, though, not just a character string" << endl; 
    }
  else
    {
      cout << "Please run this again, and add an integer on the command line, after the name of the executable" << endl;
    }

  cout << "PJ says: This 'barefoot' method of handling of command line arguments \n would never be used in a serious C or C++ program. \n Instead, we would use a more rigorous system. \n I can point you at some more rigorous approaches.\n" << endl;
  cout << "PJ says: This way is bad mainly because it doesn't allow us to\n name the command line arguments" << endl;

  return 0;
}


/*
Local Variables:
compile-command: "g++ example-2-arguments.cc -Wall -o mycplusplus" 
End:
*/
