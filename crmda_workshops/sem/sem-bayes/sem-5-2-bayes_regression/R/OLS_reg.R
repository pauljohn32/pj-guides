## Paul Johnson <pauljohn@ku.edu>
## Zack Roman <Zroman@ku.edu> 
## 20180530

# Conduct elementary linear algebra with R's lm,
# MCMCpack, and Stan

library(rstan)

# Read data
ddir <- "../data"
fn <- "OLS_data.csv"
dat <- read.csv(file.path(ddir, fn))

# Make text variable as factor
dat$x3f <- factor(dat$x3, levels = c(0, 1, 2), labels = c("lo", "med", "hi"))


##Frequentist model for comparison
m0 <- lm(y ~ x1 * x2 + x3f, data = dat)
summary(m0)
confint(m0)

library(MCMCpack)
mcmcpack0 <- MCMCregress(y ~ x1 * x2 + x3, sigma.mu = 1, sigma.var = 10,  data = dat)
summary(mcmcpack0)

## Interactively, can run
if (interactive()) plot(mcmcpack)


## Review our Stan code in
##
sdir <- "../stan"
sfn <- "OLS_reg.stan"



# Create model matrix
# This also creates dummy codes for variables noted as "factors"
X <- model.matrix(~ x1 * x2 + x3f, dat)

y <- dat$y

#Stan Model

# N = sample size (number of rows in observed data)
# K = Number of columns in design matrix
# y = Dependent variable
# X = Design matrix (In regression: Intercept, plus Xs,
#     dummy coded if catagorical, includes interactions)




## Compile the stan code
set.seed(234234)
rt1 <- stanc(file = file.path(sdir, sfn))
sm1  <- stan_model(stanc_ret = rt1, verbose=FALSE)
stanm0 <- sampling(sm1, data = list(N = nrow(dat), K = ncol(X), y = y, X = X),
                 pars = c("beta","sigma"),
                 chains = 4, iter = 2000, warmup = 1000)

wdir <- "../workingdata"
if(!file.exists(wdir)) dir.create(wdir)
soutfn <- "stanm0.rds"
saveRDS(stanm0, file = file.path(wdir, soutfn))

summary(stanm0)
## Can re-label elements with the names from the model matrix

#Add names to parameters in the model
names(stanm0)[1:ncol(X)]  <- colnames(X)

## Shows more detail
summary(stanm0)

#Tabular Output
print(stanm0)

#Graphical Output

stan_plot(stanm0)

stan_trace(stanm0)

stan_hist(stanm0)

stan_dens(stanm0)

stan_scat(stanm0)

stan_diag(stanm0)

stan_rhat(stanm0)

stan_ess(stanm0)

stan_mcse(stanm0)

stan_ac(stanm0)

pairs(stanm0)
