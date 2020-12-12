//Based on Eubank & Kupresanin, p. 36
#include <iostream>
#include <string>


using namespace std;

int main(int argc, const char* argv[]){

  int x = 17;
  double y = 3.5*1.12313;
  string s;
  s = "Greetings, people of earth";
  cout << s << endl; 
  cout << "Notice how easy C++ string class is? " << endl;

  cout << "In C++, we have integers like x=" << x << "and doubles like y=" << y << endl;

  cout << "This C++ program has no classes, doesn't use any of the special features of C++. To the end user, the only difference is that instead of \"printf()\" we now have the cout and endl approach." << endl;

  cout << "They say cout is syntactic sugar? Heck, I'd gladly use printf" << endl;

  return 0;
}


/*
Local Variables:
compile-command: "g++ example-1-hello.cc -Wall -o mycplusplus" 
End:
*/
