### R code from vignette source 'sem-5-3-bayes_cfa-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: tmpout
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)
wdir <- "workingdata"
if(!dir.exists(wdir)) dir.create(wdir, showWarnings=FALSE)


###################################################
### code chunk number 3: dat10
###################################################
## Reading in the demonstration data
ddir <- "../../data"
dat <- readRDS(file.path(ddir, "cils-subset_integer.rds"))
## Listing the variable names
names(dat)


###################################################
### code chunk number 4: dat20
###################################################
## Requesting summary statistics
## For the English Proficiency measures
varName.Eng91 <- c("speakEng_91", "underEng_91",
                   "readEng_91", "writeEng_91")
summary(dat[ , varName.Eng91])


###################################################
### code chunk number 5: dat30
###################################################
## Loading the rstan package
library(rstan)

## To install the package
## Uncomment and run the following line
## install.packages("rstan")


###################################################
### code chunk number 6: dat40
###################################################
## Creating the data set for rstan
dat.Eng91.complete <- na.omit(dat[ , varName.Eng91])


###################################################
### code chunk number 7: dat50
###################################################
## Including the model information
## To the data object for rstan
data_for_stan <- 
list(N = nrow(dat.Eng91.complete), ## sample size
k = ncol(dat.Eng91.complete),      ## number of indicator                     
y = as.matrix(dat.Eng91.complete), ## observed responses
n_xi = 1,                          ## number of factor(s)
str_loading = c(1, 1, 1, 1))       ## loading structure                                    


###################################################
### code chunk number 8: dat60
###################################################
## Step 1 - Using the `stanc()` function 
## To translate Stan code to C++
## The tr_01 object contains C++ translation for cfa-01.stan 
## The "cfa-01.stan" is included in the current directory 
tr_01 <- stanc("cfa-01.stan")


###################################################
### code chunk number 9: dat70 (eval = FALSE)
###################################################
## ## Step 2 - Using the `stan_model()` function 
## ## To create an S4 class model object 
## ## The so_01 is an S4 class model object created for tr_01
## ## Warnings will show up - move to the next step
## ## If the warnings are nonfatal
## so_01  <- stan_model(stanc_ret = tr_01, verbose=FALSE)


###################################################
### code chunk number 10: dat80 (eval = FALSE)
###################################################
## ## Step 3 - Using the `sampling()` function
## ## For MCMC sampling/estimation
## post_01 <- 
## sampling(object = so_01, ## the S4 model object                  
## data = data_for_stan,    ## the data input (an list object)                     
## chains = 2,              ## number of MCMC chains
## iter = 2000,             ## number of MCMC draws per chain
## warmup = 1000)           ## number of warmup draws per chain
## ## Saving the posterior draws to an .rds file
## saveRDS(post_01, file.path(wdir, "post_01.rds"))


###################################################
### code chunk number 11: dat90
###################################################
## Reading the posterior draws back to R
post_01 <- readRDS(file.path(wdir, "post_01.rds"))


###################################################
### code chunk number 12: dat100
###################################################
## Trace plot for visualizing MCMC convergence (loadings)
plot(post_01, plotfun = "trace", pars = c("loading_std"), inc_warmup = TRUE)


###################################################
### code chunk number 13: dat110
###################################################
## Density plot for factor loadings
plot(post_01, pars = "loading_std", show_density = TRUE, ci_level = 0.5)


###################################################
### code chunk number 14: dat120
###################################################
## Descriptive table for summarizing
## The posterior distributions of the loadings
print(post_01, pars = "loading_std", probs = c(.025, .975),
      digits = 2, mode = TRUE, use_cache = FALSE)


###################################################
### code chunk number 15: dat130
###################################################
## Trace plot for visualizing MCMC convergence
## Of the indicator intercepts
plot(post_01, plotfun = "trace", pars = c("intercept_unstd"), 
     inc_warmup = TRUE)


###################################################
### code chunk number 16: dat140
###################################################
## Density plot for indicator intercepts
plot(post_01, pars = "intercept_unstd", show_density = TRUE, 
     ci_level = 0.5)


###################################################
### code chunk number 17: dat150
###################################################
## Descriptive table for summarizing
## The posterior distributions of the intercepts
print(post_01, pars = "intercept_unstd", probs = c(.025, .975),
      digits = 2, mode = TRUE, use_cache = FALSE)


###################################################
### code chunk number 18: dat170
###################################################
## Trace plot for visualizing MCMC convergence
## Of the indicator residuals (unique variances) 
plot(post_01, plotfun = "trace", pars = c("residual_unstd"), 
     inc_warmup = TRUE)


###################################################
### code chunk number 19: dat180
###################################################
## Density plot for indicator residuals
plot(post_01, pars = "residual_unstd", show_density = TRUE, 
     ci_level = 0.5)


###################################################
### code chunk number 20: dat190
###################################################
## Descriptive table for summarizing
## The posterior distributions of the intercepts
print(post_01, pars = "residual_unstd", probs = c(.025, .975),
      digits = 2, mode = TRUE, use_cache = FALSE)


###################################################
### code chunk number 21: dat200
###################################################
## Requesting summary statistics
## For the second language proficiency measures 
varName.Sec91 <- 
c("speakSec_91", "underSec_91", "readSec_91", "writeSec_91")
summary(dat[ , varName.Sec91])


###################################################
### code chunk number 22: dat210
###################################################
## Creating the data set for rstan
dat.02 <- na.omit(dat[ , c(varName.Eng91, varName.Sec91)])


###################################################
### code chunk number 23: dat220
###################################################
## Including the model information 
## To the data object for rstan 
data_for_stan_02 <- 
list(N = nrow(dat.02), ## sample size
k = ncol(dat.02),      ## number of indicator 
y = as.matrix(dat.02), ## observed responses
n_xi = 2,              ## number of factor(s)
str_loading = c(1, 1, 1, 1,
                2, 2, 2, 2)) ## loading structure


###################################################
### code chunk number 24: dat230 (eval = FALSE)
###################################################
## ## Using the stan() function
## ## To estimate the model in 1 step 
## post_02 <- 
## stan(file = "cfa-01.stan", ## the Stan syntax file                 
## data = data_for_stan_02,   ## data input for rstan                 
## chains = 2,                ## number of MCMC chains                 
## iter = 4000,               ## total number of MCMC draws per chain                 
## warmup = 1500)             ## number of warmup draws per chain
## ## Saving the posterior draws to an .rds file
## saveRDS(post_02, file.path(wdir, "post_02.rds"))


###################################################
### code chunk number 25: dat240
###################################################
## Reading the posterior draws back to R
post_02 <- readRDS(file.path(wdir, "post_02.rds"))


###################################################
### code chunk number 26: dat250
###################################################
## Trace plot for visualizing MCMC convergence
## Factor loadings
plot(post_02, plotfun = "trace", pars = c("loading_std"), inc_warmup = TRUE)


###################################################
### code chunk number 27: dat260
###################################################
## Density plot for factor loadings
plot(post_02, pars = "loading_std", show_density = TRUE, ci_level = 0.5)


###################################################
### code chunk number 28: dat270
###################################################
## Descriptive table for summarizing the posterior distribution
print(post_02, pars = "loading_std", probs = c(.025, .975),
      digits = 2, mode = TRUE, use_cache = FALSE)


###################################################
### code chunk number 29: dat280
###################################################
## Trace plot for visualizing MCMC convergence
## Factor correlation
plot(post_02, plotfun = "trace", pars = c("factor_cor"), inc_warmup = TRUE)


###################################################
### code chunk number 30: dat290
###################################################
## Density plot for factor correlation
plot(post_02, pars = "factor_cor", show_density = TRUE, ci_level = 0.5)


###################################################
### code chunk number 31: dat300
###################################################
## Descriptive table for summarizing the posterior distribution 
print(post_02, pars = "factor_cor", probs = c(.025, .975),
      digits = 2, mode = TRUE, use_cache = FALSE)


###################################################
### code chunk number 32: dat310
###################################################
## Requesting summary statistics
## For the depression measures 
varName.Depre91 <- 
c("depre_1_91", "depre_2_91", "depre_3_91", "depre_4_91")
summary(dat[ , varName.Sec91])


###################################################
### code chunk number 33: dat320
###################################################
## Creating the data set for rstan
dat.03 <- na.omit(dat[ , c(varName.Eng91, varName.Sec91, varName.Depre91)])


###################################################
### code chunk number 34: dat330
###################################################
## Including the model information 
## To the data object for rstan 
data_for_stan_03 <- 
list(N = nrow(dat.03), ## sample size
k = ncol(dat.03),      ## number of indicator 
y = as.matrix(dat.03), ## observed responses
n_xi = 3,              ## number of factor(s)
str_loading = c(1, 1, 1, 1,
                2, 2, 2, 2,
                3, 3, 3, 3)) ## loading structure


###################################################
### code chunk number 35: dat340 (eval = FALSE)
###################################################
## ## Using the stan() function
## ## To estimate the model in 1 step 
## post_03 <- 
## stan(file = "cfa-01.stan", ## the Stan syntax file                 
## data = data_for_stan_03,   ## data input for rstan                 
## chains = 2,                ## number of MCMC chains                 
## iter = 2000,               ## total number of MCMC draws per chain                 
## warmup = 1000)             ## number of warmup draws per chain
## ## Saving the posterior draws to an .rds file
## saveRDS(post_03, file.path(wdir, "post_03.rds"))


###################################################
### code chunk number 36: dat350
###################################################
## Reading the posterior draws back to R
post_03 <- readRDS(file.path(wdir, "post_03.rds"))


###################################################
### code chunk number 37: dat360
###################################################
## Trace plot for visualizing MCMC convergence
## Factor loadings
plot(post_03, plotfun = "trace", pars = c("loading_std"), inc_warmup = TRUE)


###################################################
### code chunk number 38: dat370
###################################################
## Density plot for factor loadings
plot(post_03, pars = "loading_std", show_density = TRUE, ci_level = 0.5)


###################################################
### code chunk number 39: dat380
###################################################
## Descriptive table for summarizing the posterior distribution
print(post_03, pars = "loading_std", probs = c(.025, .975),
      digits = 2, mode = TRUE, use_cache = FALSE)


###################################################
### code chunk number 40: dat390
###################################################
## Trace plot for visualizing MCMC convergence
## Factor correlation
plot(post_03, plotfun = "trace", pars = c("factor_cor"), inc_warmup = TRUE)


###################################################
### code chunk number 41: dat400
###################################################
## Density plot for factor correlations
plot(post_03, pars = "factor_cor", show_density = TRUE, ci_level = 0.5)


###################################################
### code chunk number 42: dat410
###################################################
## Descriptive table for summarizing the posterior distribution 
print(post_03, pars = "factor_cor", probs = c(.025, .975),
      digits = 2, mode = TRUE, use_cache = FALSE)


###################################################
### code chunk number 43: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 44: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


