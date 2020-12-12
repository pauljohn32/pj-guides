//pj See http://users.stat.umn.edu/~geyer/rc

void foo(int *nin, double *xx)
{
  int n = nin[0];
  
  int i;
  
  for (i=0; i<n; i++)
    xx[i] = xx[i] * xx[i];
}

//pj: Note: In here, we can name the variables
//pj: "nin" and "xx" anything we want!
