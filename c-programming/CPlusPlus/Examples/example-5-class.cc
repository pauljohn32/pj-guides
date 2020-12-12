//http://www.tutorialspoint.com/cplusplus/cpp_this_pointer.htm

#include <iostream>
 
using namespace std;

class Box
{
   public:
      // Constructor definition
      Box(double l=2.0, double b=2.0, double h=2.0)
      {
         cout <<"Constructor called." << endl;
         length = l;
         breadth = b;
         height = h;
      }
      double Volume()
      {
         return length * breadth * height;
      }
      int compare(Box box)
      {
         return Volume() > box.Volume();
      }
   private:
      double length;     // Length of a box
      double breadth;    // Breadth of a box
      double height;     // Height of a box
};

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
compile-command: "g++ example-5-class.cc -Wall -o mycplusplus" 
End:
*/


/*Notes

Creates 2 instances, and there is a method to compare them that
has an input variable of type Box. 

All contructors and class method funtions are defined 
inside the class declaration.  Could has well have declared in 2
parts, with this in the Class:

 Box(double l=2.0, double b=2.0, double h=2.0);

and then the constructor would be written out separately

void Box::Box(double l=2.0, double b=2.0, double h=2.0)
{
  cout <<"Constructor called." << endl;
  length = l;
  breadth = b;
  height = h;
}

