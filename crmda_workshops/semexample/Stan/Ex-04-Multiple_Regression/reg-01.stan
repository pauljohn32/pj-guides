// Stan script for a linear regression model with seven predictors and one outcome variable
// Adapted from the Stan Reference Manual (Version 2.17.0, p. 126)

data {
    int<lower=0> N; // N: number of subjects
    int<lower=0> K; // K: number of predictors
    matrix[N,K] x;  // predictor matrix
    vector[N] y;    // outcome vector
}
transformed data {
    matrix[N, K] Q_ast;
    matrix[K, K] R_ast;
    matrix[K, K] R_ast_inverse;
    // thin and scale the QR decomposition
    Q_ast = qr_Q(x)[, 1:K] * sqrt(N - 1);
    R_ast = qr_R(x)[1:K, ] / sqrt(N - 1);
    R_ast_inverse = inverse(R_ast);
}
parameters {
    real intercept;
    vector[K] beta;        // coeficients on Q_ast
    real<lower=0> resi_var; // residual variance
}
model {
    for (n in 1:N)
        y[n] ~ normal(x[n] * beta, resi_var); // likelihood
}
