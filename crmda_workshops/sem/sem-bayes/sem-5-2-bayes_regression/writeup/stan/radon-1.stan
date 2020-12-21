// Charlie Redmon
// 2018-04-17

data {
    int<lower=0> N;
    int<lower=0> J;
    vector[N] y;
    int<lower=1, upper=J> county[N];
}

parameters {
    real b0;  // fixed intercept
    vector[J] u;  // random intercepts
    real<lower=0> sigmaE;  // level 1 error
    real<lower=0> sigmaU;  // level 2 error
}

model {
    // Priors
    u ~ normal(0, sigmaU);
	// Likelihood
	for (i in 1:N) {
        y[i] ~ normal(b0 + u[county[i]], sigmaE);
    }
}