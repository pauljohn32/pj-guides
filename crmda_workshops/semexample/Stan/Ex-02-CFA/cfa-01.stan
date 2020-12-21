// Stan script for confirmatory factor analysis
// Adapted from Mike Lawrence's cfa.stan code on github
// https://gist.github.com/mike-lawrence/dd2435f290a567bd1fd03370ee669688

data {
    int N;                                  // N: number of subjects
    int k;                                  // K: number of observed indicators
    matrix[N,k] y;                          // y: matrix of observed responses
    int n_xi;                               // n_factor: number of latent factor(s)
    int<lower=1,upper=n_xi> str_loading[k]; // str_loading: factor loading structure
}
transformed data {
    matrix[N, k] y_std;	                        // y_std: standardized observed responses
    for(i in 1:k) {
        y_std[ , i] = (y[ , i] - mean(y[ , i])) / sd(y[ , i]);
    }
}
parameters {
    matrix[n_xi, N] normal01;                     // normal01 a helper variable for more
                                                  // efficient non-centered multivariate
                                                  // sampling of subj_facs
    cholesky_factor_corr[n_xi] factor_cor_helper; // factor_cor_helper: correlations
                                                      // (on Cholesky factor scale) amongst
												      // latent factors
    vector[k] intercept_std;         // intercept_std: the mean for each observed indicator
    vector<lower=0>[k] residual_std; // residual_std: the unique factor (error) for each indicator
    vector<lower=0>[k] loading_std;  // loading_std: how each indicator loads on to each factor
                                     // Must be postive for identifiability
}
transformed parameters {
    matrix[N,n_xi] factor_score; // factor_score: matrix of values for each
                                 // factor associated with each subject
    factor_score = transpose(factor_cor_helper * normal01); // the following calculation implies
                                                            // that rows of subj_facs are sampled
															// from a multivariate normal
														 	// distribution with mean of 0 and
														 	// sd of 1 in all dimensions and a
														 	// correlation matrix of fac_cor
}
model {
    to_vector(normal01) ~ normal(0, 1);       // normal01 must have normal(0,1) prior for
                                              // "non-centered" parameterization on the
										      // multivariate
    									      // distribution of latent factors
    factor_cor_helper ~ lkj_corr_cholesky(1); // flat prior on correlations
    intercept_std ~ normal(0, 1);             // normal prior on y intercept
    residual_std ~ cauchy(0, 2.5);            // normal prior on the unique factor for each indicator
    loading_std ~ normal(0, 1);               // normal(0, 1) priors on factor loadings
    for(i in 1:k) {
        y_std[ , i] ~ normal(
            intercept_std[i] + factor_score[ , str_loading[i]] * loading_std[i] // each indicator as normal,
            , residual_std[i]);                                                 // influenced by its associated
			                                                                    // latent factor
    }
}
generated quantities {
    corr_matrix[n_xi] factor_cor;        // factor_cor: factor correlations
    vector[k] intercept_unstd;           // intercept on the original scale of an indicator
    vector[k] residual_unstd;            // residual on the original scale of an indicator
    factor_cor = multiply_lower_tri_self_transpose(factor_cor_helper);
    for(i in 1:k) {
        intercept_unstd[i] = intercept_std[i] * sd(y[ , i]) + mean(y[ , i]);
        residual_unstd[i] = residual_std[i] * sd(y[ , i]);
    }
}

