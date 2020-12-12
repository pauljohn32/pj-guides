CXX = icpc
MKLCMD = mkl-config
MKLFLAGS = $(shell $(MKLCMD) --cxxflags)
MKLLIBS = $(shell $(MKLCMD) --libs)
OPTFLAGS = -O3 -openmp

CXXFLAGS = \
$(MKLFLAGS) \
-I$(HOME)/usr/include

LIBS = \
$(MKLLIBS) \
-L$(HOME)/usr/lib -lRmath

example-1: example-1.o 
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) -o example-1 example-1.o  $(LIBS)

example-1.o: example-1.cpp
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) example-1.cpp -c

clean:
	rm -rf *o example-1
