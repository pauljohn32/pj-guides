### R code from vignette source 'sem-5-2-bayes_regression-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: tmpout
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)


###################################################
### code chunk number 3: data100
###################################################
ddir <- "data"
fn <- "OLS_data.csv"
dat <- read.csv(file.path(ddir, fn))

# Make text variable into R factor
dat$x3f <- factor(dat$x3, levels = c(0, 1, 2), 
               labels = c("lo", "med", "hi"))


###################################################
### code chunk number 4: data200
###################################################
head(dat, 10)


###################################################
### code chunk number 5: lm10
###################################################
m0 <- lm(y ~ x1 * x2, data = dat) 
summary(m0)


###################################################
### code chunk number 6: lm20
###################################################
library(rockchalk)
ps20 <- plotSlopes(m0, plotx = "x2", modx = "x1", modxVals = "std.dev.", interval = "confidence")


###################################################
### code chunk number 7: lm30
###################################################
ps30 <- plotPlane(m0, plotx1 = "x1", plotx2 = "x2", lcol = gray(.7), theta = 270, phi = 25)
addLines(from = ps20, to = ps30, col = ps20$col)


###################################################
### code chunk number 8: lm40
###################################################
ps40 <- testSlopes(ps20)
plot(ps40)


###################################################
### code chunk number 9: lm200
###################################################
predictOMatic(m0, interval = "confidence")


###################################################
### code chunk number 10: lm300
###################################################
ps70 <- plotSlopes(m0, plotx = "x1", modx = "x2", modxVals = "std.dev.", interval = "confidence")


###################################################
### code chunk number 11: lm400
###################################################
ps80 <- testSlopes(ps70)
plot(ps80)


###################################################
### code chunk number 12: lm600
###################################################
m0 <- lm(y ~ x1 * x2 + x3f, data = dat) 
summary(m0)


###################################################
### code chunk number 13: lm610
###################################################
confint(m0)


###################################################
### code chunk number 14: mcmcpack200
###################################################
library(MCMCpack)
mcmcpack0 <- MCMCregress(y ~ x1 * x2 + x3f, b0 = 0, B0 = 0.1, sigma.mu = 1, sigma.var = 10, data = dat)


###################################################
### code chunk number 15: mcmcack300
###################################################
summary(mcmcpack0)


###################################################
### code chunk number 16: sem-5-2-bayes_regression-uniquebackupstring.Rnw:511-512
###################################################
if(interactive()) plot(mcmcpack0)


###################################################
### code chunk number 17: rstan200
###################################################
library(rstan)
set.seed(234234)
## Manufacture data structures
X <- model.matrix(~ x1 * x2 + x3f, dat)
y <- dat$y 
head(X)


###################################################
### code chunk number 18: rstan201 (eval = FALSE)
###################################################
## svn <- "OLS_reg.stan"
## rt1 <- stanc(file = file.path(sdir, sfn))
## sm1 <- stan_model(stanc_ret = rt1, verbose = FALSE)
## stanm0 <- sampling(sm1, data = list(N = nrow(dat), K = ncol(X), 
##     y = y, X = X), pars = c("beta", "sigma"),
##     chains = 4, iter = 2000, warmup = 1000)


###################################################
### code chunk number 19: rstan300
###################################################
wdir = "workingdata"
soutfn <- "stanm0.rds"
stanm0 <- readRDS(file.path(wdir, soutfn))


###################################################
### code chunk number 20: sem-5-2-bayes_regression-uniquebackupstring.Rnw:783-784
###################################################
summary(stanm0)


###################################################
### code chunk number 21: stan400
###################################################
names(stanm0)[1:ncol(X)]  <- colnames(X)
stanm0


###################################################
### code chunk number 22: stan690
###################################################
stan_plot(stanm0)


###################################################
### code chunk number 23: stan700a0
###################################################
stan_trace(stanm0, pars = names(stanm0)[1:4])


###################################################
### code chunk number 24: stan700a1
###################################################
stan_trace(stanm0, pars = names(stanm0)[5:7])


###################################################
### code chunk number 25: stan700b1
###################################################
stan_hist(stanm0)


###################################################
### code chunk number 26: stan700b2
###################################################
stan_hist(stanm0)


###################################################
### code chunk number 27: stan700b
###################################################
stan_dens(stanm0)


###################################################
### code chunk number 28: stan700e
###################################################
stan_diag(stanm0)


###################################################
### code chunk number 29: stan700f
###################################################
stan_rhat(stanm0)


###################################################
### code chunk number 30: stan700g
###################################################
stan_mcse(stanm0)


###################################################
### code chunk number 31: stan700h
###################################################
stan_ac(stanm0)


###################################################
### code chunk number 32: stan710
###################################################
pairs(stanm0)


###################################################
### code chunk number 33: stan800
###################################################
library(methods)
slotNames(stanm0)


###################################################
### code chunk number 34: stan810
###################################################
stanm0@inits


###################################################
### code chunk number 35: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 36: excludemeopts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


