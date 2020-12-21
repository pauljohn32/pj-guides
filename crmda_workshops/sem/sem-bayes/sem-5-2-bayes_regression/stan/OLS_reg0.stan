data {
  int<lower=0> N;
  vector[N] y;
  vector[N] x1;
  vector[N] x2;
  vector[N] x3;
}
parameters {
  real alpha;
  real beta1;
  real beta2;
  real beta3;
  real<lower=0> sigma;
}
model {
  alpha ~ normal(0,10);    
  beta1 ~ normal(0,10);
  beta2 ~ normal(0,10);
  sigma ~ cauchy(0,5);
  for (n in 1:N)
    y[n] ~ normal(alpha + beta1 * x1[n] + beta2 * x2[n] + beta3 * x3[n], sigma);
}