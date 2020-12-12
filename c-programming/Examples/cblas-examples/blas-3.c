//Paul E. Johnson
// 2012-11-17
//pj: Adapted from
//pj: http://www.umbc.edu/hpcf/resources-tara/how-to-BLAS.html
//pj: see usage of cblas_dgemm. Function init_matrix is COLUMN major,
//pj: unlike most C code, so have to be careful in formats.

//pj: Not here a "matrix" is just a one dimensional vector
//pj: we have to specify the number of rows and columns to take
//pj: out of there, and whether the number are understood as 
//pj: row-wise or column-wise.

//pj: did compile 2012-11-17


#include <stdio.h>
#include <cblas.h>

#define MATRIX_IDX(n, i, j) j*n + i
#define MATRIX_ELEMENT(A, m, n, i, j) A[ MATRIX_IDX(m, i, j) ]

void init_matrix(double* A, int m, int n)
{
   double element = 1.0;
   for (int j = 0; j < n; j++)
   {
      for (int i = 0; i < m; i++)
      {
         MATRIX_ELEMENT(A, m, n, i, j) = element;
         element *= 0.9;
      }
   }
}

void print_matrix(const double* A, int m, int n)
{
   for (int i = 0; i < m; i++)
   {
      for (int j = 0; j < n; j++)
      {
          printf("%8.4f", MATRIX_ELEMENT(A, m, n, i, j));
      }
      printf("\n");
   }
}

int main(int argc, char** argv)
{
   int m = 3;
   int n = 4;
   int k = 5;

   double A[m * k];
   double B[k * n];
   double C[m * n];

   init_matrix(A, m, k);
   init_matrix(B, k, n);

   printf("Matrix A (%d x %d) is:\n", m, k);
   print_matrix(A, m, k);

   printf("\nMatrix B (%d x %d) is:\n", k, n);
   print_matrix(B, k, n);

   cblas_dgemm(CblasColMajor, CblasNoTrans, CblasNoTrans,  m, n, k, 1.0, A, m, B, k, 0.0, C, m);

   //Arguments: From http://www.psatellite.com/matrixlib/api/lapack.html
/*    cblas_dgemm Parameters */
/* Parameter	Type	Meaning */
/* 1	(constant)	Storage order of matrix. Use the ML_BLAS_STORAGE macro to pass the correct value. */
/* 2-3	(constant)	Whether or not the A and B (respectively) matrices should be transposed before multiplication. Pass CblasNoTrans to avoid transpose. */
/* 4	integer	The number of rows in the A matrix. */
/* 5	integer	The number of columns in the B matrix. */
/* 6	integer	The number of columns in the A matrix. */
/* 7	double	A scalar to multiply by during computation. */
/* 8	double *	The data array for the A matrix. */
/* 9	integer	The major stride for the A matrix. */
/* 10	double *	The data array for the B matrix. */
/* 11	integer	The major stride for the B matrix. */
/* 12	double	A scalar to multiply C by during the computation. */
/* 13	double *	The data array for the C matrix (output). */
/* 14	integer	The major stride for the C matrix.  */


   //cblas_dgemm(CblasColMajor, CblasNoTrans, CblasNoTrans, dim1, dim3, dim2, alpha, &*A.begin(), dim1, &*B.begin(), dim2, beta, &*C.begin(), dim1);

   printf("\nMatrix C (%d x %d) = AB is:\n", m, n);
   print_matrix(C, m, n);

   return 0;
}

/*
Local Variables:
compile-command: "gcc -o blas3 -Wall blas-3.c -lm -lblas -std=gnu99 "
End:
*/
