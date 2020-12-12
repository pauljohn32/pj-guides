//Learn from: http://cplusplus.com/doc/tutorial/classes/

#include <iostream>


using namespace std;



class CRectangle {
    int x, y;
  public:
    void set_values (int a, int b);
    int area () {return (x*y);}
};

void CRectangle::set_values (int a, int b) {
  x = a;
  y = b;
}

int main (int argc, const char* argv[]) {
  CRectangle rect;
  rect.set_values (3,4);
  cout << "The area of a rectangle 3x4 is: " << rect.area() << endl;


  CRectangle * rect2 = new CRectangle;
  (*rect2).set_values (5, 2);
  cout << "The area of a rectangle 5x2 is: " << (*rect2).area() << endl;

  rect2->set_values (5, 2);
  cout << "Using -> notation, The area of a rectangle 5x2 is: " << rect2->area() << endl;

  return 0;
}


/*
Local Variables:
compile-command: "g++ example-3-class.cc -Wall -o mycplusplus" 
End:
*/

/* Note!
 instance variables: x, y
 public functions: set_values and area()
 private: nothing. 
 No Constructor or Destructor. In that case, C++ supplies an object with no variables set at values.
 Note Implementation two colon syntax:
void CRectangle::set_values
 This says a CRectangle object can implement this.
*/
