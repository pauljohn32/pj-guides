/************************************************************************************/
//More simple examples.
//Make with "make -f Makefile-example-2" 
/************************************************************************************/
#include <iostream>
#include <string>
#include <fstream>
#include <omp.h>
using namespace std;

#include <mkl.h>

#define MATHLIB_STANDALONE
#include <Rmath.h>


void fReadMtrx(string f, double *mtrx, int nrow, int ncol);
void showMtrx(double *mtrx, int nrow, int ncol);

int main(){

  int i,j;
  int info;
  char *lower = "L";
  char *upper = "U";
  char *ntran = "N";
  char *ytran = "T";
  char *rside = "R";
  char *lside = "L";
  const double one = 1.0;
  const double negOne = -1.0;
  const double zero = 0.0;
  const int incOne = 1;
  
  //set seed
  set_seed(123,456);

  //set threads, not that we really need (or will use) 4 CPUs for 
  //these matricies
  omp_set_num_threads(4); 

  int dim=3, length=dim*dim;//, dim1=3, dim2=3, dim4, dim5, dim6, dimvec, rows, cols, rowd,c old;
  double *a, *b, *c, *d, *I, *sum, *e, *q, *r,*qrf, *t, *perm;
  int *ipiv;
  //double *u, *s, *vt, *x, *inv, *chol, *qrmat;
  //double alpha, det, logdet;
    
  //allocate and read in a
  a = new double[dim*dim];

  fReadMtrx("a", a, dim, dim);

  cout << endl << "a:" << endl;
  showMtrx(a, dim, dim);

  //allocate and read in a
  b = new double[dim*dim];
  
  cout << endl << "b:" << endl;
  fReadMtrx("b", b, dim, dim);
  showMtrx(b, dim, dim);

  //allocate c
  c = new double[dim*dim];

  //operation 1
  dgemm(ntran, ntran, &dim, &dim, &dim, &one, a, &dim, b, &dim, &zero, c, &dim);

  cout << endl << "The product of the matrix A and B:" << endl;
  showMtrx(c, dim, dim);
 
  //operation 2
  dcopy(&length, b, &incOne, c, &incOne);
  daxpy(&length, &one, a, &incOne, c, &incOne);

  cout << endl << "The sum of the matrix A and B:" << endl;
  showMtrx(c, dim, dim);

  //operation 3
  dcopy(&length, b, &incOne, c, &incOne);
  dscal(&length, &negOne, c, &incOne);
  daxpy(&length, &one, a, &incOne, c, &incOne);

  cout << endl << "The difference between matrix A and B:" << endl;
  showMtrx(c, dim, dim);

  //operation 4
  I = new double[dim*dim];//make identity matrix
  for(i = 0; i < length; i++) I[i] = 0.0;
  for(i = 0; i < dim; i++) I[i*dim+i] = 1.0;

  dgemm(ytran, ntran, &dim, &dim, &dim, &one, a, &dim, I, &dim, &zero, c, &dim);

  cout << endl << "The transpose of matrix A is:" << endl;
  showMtrx(c, dim, dim);

  //operation 5
  ipiv = new int[dim];
  dcopy(&length, a, &incOne, c, &incOne);

  dgetrf(&dim, &dim, c, &dim, ipiv, &info);if(info != 0){cout << "c++ error: dgetrf failed" << endl;}
  
  cout << endl << "The LU decomposition A=PLU (L has unit diagnoal elements):" << endl;
  showMtrx(c, dim, dim);

  exit(0);
}

void fReadMtrx(string f, double *mtrx, int nrow, int ncol){

  ifstream data(f.c_str(), ios::in);
  if (!data) {
    cerr << "File " << f << " could not be opened." << endl;
    exit(1);
  }
  
  for(int i = 0; i < nrow; i++) 
    for(int j = 0; j < ncol; j++) 
      data >> mtrx[j*nrow+i]; 
}

void showMtrx(double *mtrx, int nrow, int ncol){
  
  for (int i = 0; i < nrow; i++) {
    for (int j = 0; j < ncol; j++) { 
      cout <<  mtrx[j*nrow+i] << "\t";
    }
    cout << endl;
  }
}
