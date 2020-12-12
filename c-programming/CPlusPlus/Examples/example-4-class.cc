//Learn from: http://cplusplus.com/doc/tutorial/classes/

//Adds constructors (overloaded)

#include <iostream>
#include <string>

using namespace std;

class CRectangle {
    void setWidth(int w);
    void setHeight(int h);
    int width, height;
    string name;
public:
    CRectangle ();
    CRectangle (int a,int b);
    void set_values (int a, int b);
    void setName(string x);
    int area (void) 
	{
	    return (width*height);
	}
    void showInfo();
};

//here are the private ones
void CRectangle::setWidth(int w)
{
    width = w;
}

void CRectangle::setHeight(int h)
{
    height = h;
}

void CRectangle::setName(string x)
{
    name.assign(x);
}

//here are the public ones
CRectangle::CRectangle () 
{
    width = 5;
    height = 5;
    name = ""; 
}

CRectangle::CRectangle (int a, int b) 
{
    width = a;
    height = b; 
    name = ""; 
}

void CRectangle::set_values (int a, int b) {
    // width = a;
    // height = b;
    setWidth(a);
    setHeight(b); 
}




void CRectangle::showInfo()
{
    cout << "Rectangle Name: " << name << endl; 
    cout << "Rectangle: width " << width << " height " << height << endl;
    cout << "Rectangle area: " << area() << endl << endl;
    
    //previous same as
    // cout << "Using this->area boring!" << endl;
    // cout << "Rectangle area: " << this->area() << endl;
}

int main () 
{
    CRectangle recta (3,4);
    recta.setName("a"); 
    CRectangle rectb;
    CRectangle rectc (19, 11);
    CRectangle rectd(1,2), recte(5,8), rectf(3,5);
    rectd.setName("d"); 
    recte.setName("e"); 
    rectf.setName("f"); 
    CRectangle* rectg = new CRectangle(1,4);
    rectb.set_values(7, 8);
    cout << "recta area: " << recta.area() << endl;
    cout << "rectb area: " << rectb.area() << endl;
    // Try this, get a compiler error:
    // rectc.setWidth(5);
    rectd.showInfo();
    recte.showInfo();
    rectf.showInfo();
    
    rectg->setName("Super Long G name");
    rectg->showInfo();
    return 0;
}


/*
Local Variables:
compile-command: "g++ example-4-class.cc -Wall -o mycplusplus" 
End:
*/

/*

instance variables width, height, name
private member functions setWidth, setHeight
public member functions

Note can only access setWidth, setHeight via the public interface function 
set_values()

Exercise: Make a new contstructor that takes 3 variables, w, h, and name.
Note special string handling in setName.

 */
