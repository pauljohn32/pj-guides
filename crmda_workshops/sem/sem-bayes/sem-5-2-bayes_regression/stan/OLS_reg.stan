//  Zack Roman <zroman@ku.edu>
//  Simple OLS regression for Rstan Workflow
data {
  int N; //the number of observations
  int K; //the number of columns in the model matrix
  real y[N]; //the response
  matrix[N,K] X; //the model matrix
}
parameters {
  vector[K] beta; //the regression parameters
  real sigma; //the standard deviation
}
transformed parameters {
  vector[N] linpred;
  linpred = X*beta;
}
model {  
  beta[1] ~ cauchy(0,10); //prior for the intercept 

  for(i in 2:K)
   beta[i] ~ cauchy(0,1);//prior for the slopes 
  y ~ normal(linpred,sigma);
}
