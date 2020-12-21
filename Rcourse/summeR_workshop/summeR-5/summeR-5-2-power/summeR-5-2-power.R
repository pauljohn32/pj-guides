### R code from vignette source 'summeR-5-2-power-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: tmpout
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)


###################################################
### code chunk number 2: Roptions
###################################################
opts.orig <- options()
options(width=100, prompt="> ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly = TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)
if(!file.exists("theme")) file.symlink("../../../../template/theme", "theme")


###################################################
### code chunk number 3: pow100
###################################################
x.null <- seq(-4, 4, .1)
dx.null <- dnorm(x.null, m = 0, s = 1)
plot(x.null, dx.null, type = "l", lwd = 2, xlim = c(-4, 8), yaxt = "n",
xlab = "Effect Size (e.g., Mean-Difference between Groups)", ylab = "")
## If abs(z) > 1.96, reject the null at alpha = .05
abline(v = qnorm(c(.025, .975)), lwd = 2, lty = "dashed")
## Type I errors occur for observations drawn outside the dashed lines


###################################################
### code chunk number 4: pow120
###################################################
x.null <- seq(-4, 4, .1)
dx.null <- dnorm(x.null, m = 0, s = 1)
plot(x.null, dx.null, type = "l", lwd = 2, xlim = c(-4, 8), yaxt = "n",
xlab = "Effect Size (e.g., Mean-Difference between Groups)", ylab = "")
## If abs(z) > 1.96, reject the null at alpha = .05
abline(v = qnorm(c(.025, .975)), lwd = 2, lty = "dashed")
## Type I errors occur for observations drawn outside the dashed lines
x.8 <- x.null + 0.80
dx.8 <- dnorm(x.8, m = 0.80)
lines(x.8, dx.8, lwd = 2, col = "red")


###################################################
### code chunk number 5: pow140
###################################################
x.null <- seq(-4, 4, .1)
dx.null <- dnorm(x.null, m = 0, s = 1)
plot(x.null, dx.null, type = "l", lwd = 2, xlim = c(-4, 8), yaxt = "n",
xlab = "Effect Size (e.g., Mean-Difference between Groups)", ylab = "")
## If abs(z) > 1.96, reject the null at alpha = .05
abline(v = qnorm(c(.025, .975)), lwd = 2, lty = "dashed")
## Type I errors occur for observations drawn outside the dashed lines
x.25 <- c(x.null + 2.5)
dx.25 <- dnorm(x.8, m = 2.5, s = 1)
lines(x.25, dx.25, lwd = 2, col = "red")


###################################################
### code chunk number 6: pow160
###################################################
x.null <- seq(-4, 4, .1)
dx.null <- dnorm(x.null, m = 0, s = 0.5)
plot(x.null, dx.null, type = "l", lwd = 2, xlim = c(-4, 8), yaxt = "n",
xlab = "Effect Size (e.g., Mean-Difference between Groups)", ylab = "")
## If abs(z) > 1.96, reject the null at alpha = .05
abline(v = qnorm(c(.025, .975), m = 0, s = 0.5), lwd = 2, lty = "dashed")
## Type I errors occur for observations drawn outside the dashed lin
x.1 <- c(x.null + 1)
dx.1 <- dnorm(x.8, m = 1, s = 0.5)
lines(x.1, dx.1, lwd = 2, col = "red")


###################################################
### code chunk number 7: pwr100
###################################################
library(pwr)


###################################################
### code chunk number 8: pwr200
###################################################
cohen.ES(test = "t", size = "large")    # Cohen's D
cohen.ES(test = "t", size = "medium")
cohen.ES(test = "t", size = "small")
cohen.ES(test = "r", size = "large")    # Pearson's r (correlation)
cohen.ES(test = "r", size = "medium")
cohen.ES(test = "r", size = "small")

cohen.ES(test = "anov", size = "small") # Cohen's f_squared
cohen.ES(test = "f2", size = "small")   # Cohen's f_squared


###################################################
### code chunk number 9: pwr300
###################################################
## Find power for a given sample size, effect size, and alpha level
pwr.r.test(n = 30, r = .1, sig.level = .05)

## A priori power analysis: Find sample size required for a given
## level of power, alpha, and effect size
pwr.r.test(power = .80, r = .1, sig.level = .05)

## Do the same with Cohen's D for a t test
pwr.t.test(n = 30, d = .2, sig.level = .05)
pwr.t.test(power = .80, d = .2, sig.level = .05)

## repeat without the requirement for equal group sizes
pwr.t2n.test(n1 = 20, n2 = 12, d = .2, sig.level = .05)
pwr.t2n.test(power = .8, n1 = 40, d = .5, sig.level = .05)


###################################################
### code chunk number 10: summeR-5-2-power-uniquebackupstring.Rnw:829-885
###################################################
##' Monte Carlo simulation for 2 group t test
##' @param conds = a conditions data frame
##' @param var.equal: should the t.test use the equal variance 
##' assumption or the Welch corrected calculation (if FALSE).
##' Note default TRUE is different from R base.
##' @return a matrix summarizing rejection rates
tPowerSim <- function(conds, var.equal = TRUE){
    ## Creates data by parsing N, M and SD strings
    getTdata <- function(rep, N, M, SD) {
        Nvec <- as.numeric(unlist(strsplit(N, ":")))
        Mvec <- as.numeric(unlist(strsplit(M, ":")))
        SDvec <- as.numeric(unlist(strsplit(SD, ":")))
        
        dat <- data.frame(first = c(rep(0, times = Nvec[1]),
                                    rep(1, times = Nvec[2])))
        dat$IQ <- rnorm(sum(Nvec), m = Mvec[(dat$first + 1)], 
                        sd = SDvec[(dat$first + 1)])
        dat$IQ <- round(dat$IQ)
        attr(dat, "rep") <- rep
        attr(dat, "parms") <- c(N = N, M = M, SD = SD)
        dat
    }
    ## conducts T test, keeps only p value
    conductTtest <- function (dframe, y = "IQ", x = "first", var.equal){
        t.test(formula(paste(y, "~", x)),
               data = dframe, var.equal = var.equal)$p.value
    }
    ## orchestrates the data pull, analysis, and summary
    runOneSim <- function(rep, N, M, SD, var.equal){
        dframe <- getTdata(rep, N = N, M = M, SD = SD)
        reslt <- conductTtest(dframe, var.equal = var.equal)
        parms <- attr(dframe, "parms")
        dframe2 <- data.frame(rep = attr(dframe, "rep"), 
                              pvalue = reslt,
                              reject.05 = if (reslt <= 0.05) 1 else 0,
                              reject.1 = if (reslt <= 0.10) 1 else 0,
                              N = parms["N"], M = parms["M"], SD = parms["SD"])
        dframe2
    }

    # Reads the condition matrix, runs one row from it
    runOneCondition <- function(i, conds, var.equal){
        x <- conds[i, ]
        result.list <- lapply(1:x$nReps, runOneSim, 
                              N = x$N, M = x$M, SD = x$SD, var.equal = var.equal)
        do.call("rbind", result.list)
    }
     # Run all of the rows in the condition matrix
    listofresults <- lapply(1:NROW(conds), runOneCondition, conds, var.equal = var.equal)
    stackedResults <- do.call(rbind, listofresults)
    output <- aggregate(stackedResults[, c("reject.05", "reject.1")],
                        by = list(N = stackedResults$N, SD = stackedResults$SD, M = stackedResults$M),
                        mean)
    names(output) <- c("N", "SD", "M", "reject.05.mean", "reject.1.mean")
    output
}


###################################################
### code chunk number 11: summeR-5-2-power-uniquebackupstring.Rnw:893-899
###################################################
cond.N <- c("30:30", "40:20")
cond.SD <- c("10:20", "15:15", "20:10")
cond.M <- c("100:100") # for now, mean-difference = 0
conds <- expand.grid(nReps = 1000, SD = cond.SD, N = cond.N, M = cond.M,
                     stringsAsFactors = FALSE)
head(conds)


###################################################
### code chunk number 12: tpow400
###################################################
tPowerSim(conds, var.equal = TRUE) 


###################################################
### code chunk number 13: tpow410
###################################################
tPowerSim(conds, var.equal = FALSE)


###################################################
### code chunk number 14: tpow500
###################################################
## Play with tPowerSim.  
## I just "noodled" around a while
## You can be systematic :)
##
## Power analysis is the study of data group sizes
 
cond.N <- c("30:30", "40:20", "100:100")
cond.SD <- c("10:20", "15:15", "20:10")
cond.M <- c("100:105")

conds <- expand.grid(nReps = 1000, SD = cond.SD, N = cond.N,
            M = cond.M, stringsAsFactors = FALSE)
tPowerSim(conds, var.equal = TRUE)
tPowerSim(conds, var.equal = FALSE)

cond.M <- c("100:106") 

conds <- expand.grid(nReps = 1000, SD = cond.SD, N = cond.N, 
                     M = cond.M, stringsAsFactors = FALSE)
tPowerSim(conds, var.equal = TRUE)
tPowerSim(conds, var.equal = FALSE)

cond.N <- c("100:100", "150:150", "150:100", "100:150")
conds <- expand.grid(nReps = 1000, SD = cond.SD, N = cond.N, 
                     M = cond.M, stringsAsFactors = FALSE)
tPowerSim(conds, var.equal = TRUE)
tPowerSim(conds, var.equal = FALSE)

cond.M <- c("100:110")
conds <- expand.grid(nReps = 1000, SD = cond.SD, N = cond.N,
                     M = cond.M, stringsAsFactors = FALSE)
tPowerSim(conds, var.equal = TRUE)


###################################################
### code chunk number 15: mvrnorm100
###################################################
library(rockchalk)
myR <- lazyCor(X = 0.3, d = 5)
myR
mySD <- c(0.5, 0.5, 0.5, 1.5, 1.5)
myCov <- lazyCov(Rho = myR, Sd = mySD)
myCov
myMu <- c(1.1, 2.0, 1.1, -0.2, 0)
## Draw one to see what that does
set.seed(123123)
mvrnorm(1, mu = myMu, myCov)


###################################################
### code chunk number 16: mvrnorm150
###################################################
N <- 1000
X <- mvrnorm(N, mu = myMu, myCov)


###################################################
### code chunk number 17: mvrnorm200
###################################################
## Check column means
colMeans(X)
## Check Pearson Correlations
cor(X)


###################################################
### code chunk number 18: iq100
###################################################
R <- 0.30 #"medium" in Cohen's opinion

## Start with a correlation matrix of predictors
## If you do this the standard R way
IQ.cor <- matrix(c(1, R, R, 1), nrow = 2, ncol = 2,
                 dimnames = list(c("dadIQ", "momIQ"), 
                              c("dadIQ", "momIQ")))
IQ.cor 

## My equivalent method in rockchalk
IQ.cor <- lazyCor(X = R, d = 2)
IQ.cor

## these are the assumed means of momIQ and dadIQ
IQ.M <- c(dadIQ = 100, momIQ = 100)
## mvrnorm will take these as column names in the 
## output. That's why those are named

## these are the standard devations of momIQ and dadIQ
IQ.SD <- c(15, 15)

## The diagonal matrix we need will be
diag(IQ.SD) 

## Create the covariance matrix
IQ.cov <- diag(IQ.SD) %*% IQ.cor %*% diag(IQ.SD)
IQ.cov
## Use R's builtin cov2cor to double-check thc
## correlations
cov2cor(IQ.cov)

N <- 100

set.seed(123)
dat <- mvrnorm(n = N, mu = IQ.M, Sigma = IQ.cov)
dat <- as.data.frame(round(dat))
head(dat)

## Do observed means and correlations reflect 
## the population parameters? Rounding is not too harmful
colMeans(dat)
cor(dat)

## Now we will once again draw random birth-orders
dat$first <- rbinom(n = N, size = 1, prob = .4)

## Now that we have our multiple predictors, we 
## specify a model to generate outcomes (child's IQ) 
## with random sampling error.

stde <- 9
b <- c(-3, 5, .5, .5)
## parameters designed so child IQ is average of parents
dat$IQnoe <- b[1] + b[2]*dat$first + b[3]*dat$dadIQ + b[4]*dat$momIQ 
dat$IQ <- dat$IQnoe + rnorm(N, m = 0, sd = stde)
dat$IQ <- round(dat$IQ)
head(dat)

## Do sample statistics match data generator parameters?
mod0 <- lm(IQ ~ first + momIQ + dadIQ, data = dat)
summary(mod0)


###################################################
### code chunk number 19: iq200
###################################################
## Inspect data output, figure out what we want.
## 
summary(mod0)$coef
## get p values
summary(mod0)$coef[2:4, 4]
## check whether they meet significance criterion
alpha <- .05
alpha
summary(mod0)$coef[2:4, 4] < alpha


###################################################
### code chunk number 20: iq300
###################################################
makeData <- function(rep, N, R, stde = 9, b = c(-3, 5, .5, .5)) {
    require(rockchalk) # will load the package if it's not already loaded
    IQ.cor <- lazyCor(R, 2)
    IQ.M <- c(dadIQ = 100, momIQ = 100)
    IQ.SD <- c(15, 15)
    IQ.cov <- diag(c(15, 15)) %*% IQ.cor %*% diag(c(15, 15))
    dat <- mvrnorm(n = N, mu = IQ.M, Sigma = IQ.cov)
    dat <- as.data.frame(round(dat))
    dat$first <- rbinom(n = N, size = 1, prob = .4)
    dat$IQnoe <- b[1] + b[2]*dat$first + b[3]*dat$dadIQ + b[4]*dat$momIQ 
    dat$IQ <- dat$IQnoe + rnorm(N, m = 0, sd = stde)
    dat$IQ <- round(dat$IQ)
    dat$rep <- rep
    dat
}

## Test it once
set.seed(123)
dat <- makeData(1, N = 20, R = .3)
head(dat)

## To analyze that data and return rejection decisions
getDecision <- function(data, alpha = .05) {
    ## run a regression on sample data
    mod <- lm(IQ ~ first + momIQ + dadIQ, data = data)
    ## return decisions about whether null was rejected for each slope
    summary(mod)$coef[2:4, 4] < alpha
}

## Test it once (on the data we just generated)
getDecision(data = dat)

## Test it on 5 replications to see the format of the output
dataList <- lapply(1:5, makeData, N = 100, R = 0.30)
lapply(dataList, head)
do.call(rbind, lapply(dataList, getDecision))

## Define a function that gets rejections for nReps replications per
## condition
runCond <- function(nReps, N, R) {
    ## generate nReps data sets
    dataList <- lapply(1:nReps, makeData, N = N, R = R)
    ## run regression and get rejection decisions for each data set
    out <- data.frame(do.call(rbind, lapply(dataList, getDecision)))
    ## record conditions
    out$N <- N
    out$R <- R
    ## return results
    out
}

## Test it on 10 replications
runCond(nReps = 10, N = 100, R = .3)


###################################################
### code chunk number 21: iq310
###################################################
## Using a Monte Carlo design, we can calculate power across sample
## sizes as the proportion of cases where the null was rejected in
## each condition.
cond.N <- seq(from = 20, to = 150, by = 10)
cond.N
cond.R <- c(0.30) # for now, don't vary the correlation between predictors
conds <- expand.grid(N = cond.N, R = cond.R)
conds$nReps <- 1000
conds


###################################################
### code chunk number 22: iq320
###################################################
## Run 1000 t tests in each condition to see how often the null is
## rejected
set.seed(123)
out <- apply(conds, MARGIN = 1,
             FUN = function(x) do.call(runCond, as.list(x)))
out <- do.call(rbind, out)
head(out)

## TRUE == 1 and FALSE == 0, so the mean of each outcome is the
## proportion of samples for which the null was rejected (in each
## condition).
rates <- aggregate(cbind(first, momIQ, dadIQ) ~ N, data = out, mean)
rates


###################################################
### code chunk number 23: iq340
###################################################
## plot power by sample size
plot(first ~ N, data = rates, type = "l", lwd = 2, ylim = 0:1)
abline(h = .8, col = "darkgreen", lty = "dashed")
lines(momIQ ~ N, data = rates, col = "red", lwd = 2, lty = 2)
lines(dadIQ ~ N, data = rates, col = "blue", lwd = 2, lty = 3)
legend("bottomright", legend = c("first", "momIQ", "dadIQ"),
       col = c("black" , "red", "blue"), lty = c(1,2,3))


###################################################
### code chunk number 24: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 25: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


