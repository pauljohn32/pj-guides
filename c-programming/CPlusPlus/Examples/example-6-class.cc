//http://www.tutorialspoint.com/cplusplus/cpp_this_pointer.htm

// This is same as previous example, except that I've removed the
// function definitions from inside the class and included them
// separately. In big classes with big functions, it is always done
// that way.

#include <iostream>
 
using namespace std;

class Box
{
public:
  // Constructor definition
  Box(double l, double b, double h);
  double Volume();
  int compare(Box box);
private:
  double length;     // Length of a box
  double breadth;    // Breadth of a box
  double height;     // Height of a box
};


Box::Box(double l=2.0, double b=2.0, double h=2.0)
{
  cout <<"Constructor called." << endl;
  length = l;
  breadth = b;
  height = h;
}

double Box::Volume()
{
  return length * breadth * height;
}

int Box::compare(Box box)
{
  return Volume() > box.Volume();
}


int main(void)
{
  Box Box1(3.3, 1.2, 1.5);    // Declare box1
  Box Box2(8.5, 6.0, 2.0);    // Declare box2
  
  if(Box1.compare(Box2))
    {
      cout << "Box2 is smaller than Box1" <<endl;
    }
  else
    {
      cout << "Box2 is equal to or larger than Box1" <<endl;
    }
  return 0;
}

/*
Local Variables:
compile-command: "g++ example-6-class.cc -Wall -o mycplusplus" 
End:
*/


/*Notes

In the Website where I found this example, they used the notation
"this->", which I omitted in the following

int Box::compare(Box box)
  {
    return this->Volume() > box.Volume();
  }

I think that's distracting, it is certainly unnecessary.
But some people like districting and unnecessary code.
Like people who like to put return() at the end of R
functions.

*/

