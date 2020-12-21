### R code from vignette source 'summeR-5-1-montecarlo-uniquebackupstring.Rnw'
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
### code chunk number 3: summeR-5-1-montecarlo-uniquebackupstring.Rnw:378-379 (eval = FALSE)
###################################################
## ?rnorm


###################################################
### code chunk number 4: eval
###################################################
m <- 7
s <- 3
N <- 2000
y <- rnorm(N, m = m, s = s)
hist(y, breaks = 50, prob = TRUE)
range(y)
str(y)


###################################################
### code chunk number 5: helptrt (eval = FALSE)
###################################################
## ?rt


###################################################
### code chunk number 6: helprchisq (eval = FALSE)
###################################################
## ?rchisq


###################################################
### code chunk number 7: helprpois (eval = FALSE)
###################################################
## ?rpois


###################################################
### code chunk number 8: helprunif (eval = FALSE)
###################################################
## ?runif


###################################################
### code chunk number 9: helprgamma (eval = FALSE)
###################################################
## ?rgamma


###################################################
### code chunk number 10: helprbeta (eval = FALSE)
###################################################
## ?rbeta


###################################################
### code chunk number 11: helprcauchy (eval = FALSE)
###################################################
## ?rcauchy


###################################################
### code chunk number 12: helprlogis (eval = FALSE)
###################################################
## ?rlogis


###################################################
### code chunk number 13: helprweibull (eval = FALSE)
###################################################
## ?rweibull


###################################################
### code chunk number 14: helpbinom (eval = FALSE)
###################################################
## ?rbinom


###################################################
### code chunk number 15: helprnbinom (eval = FALSE)
###################################################
## ?rnbinom


###################################################
### code chunk number 16: rbinom100
###################################################
size <- 10
prob <- 0.5
N <- 100
y <- rbinom(n = 100, size = size, prob = prob)
y


###################################################
### code chunk number 17: rbinom200
###################################################
table(y)


###################################################
### code chunk number 18: rbinom210
###################################################
set.seed(234234)
y1 <- rbinom(n = 100, size = size, prob = prob)
head(y1)


###################################################
### code chunk number 19: rbinom220
###################################################
set.seed(234234)
y2 <- rbinom(n = 100, size = size, prob = prob)
head(y2)


###################################################
### code chunk number 20: rbinom230
###################################################
N <- 1000
size <- 1
prob <- 0.4
y1 <- rbinom(N, size, prob)
head(y1)
## The total number of 1's is
sum(y1)


###################################################
### code chunk number 21: rbinom240
###################################################
N <- 1
size <- 1000
y2 <- rbinom(N, size, prob)
y2


###################################################
### code chunk number 22: rbinom270
###################################################
 rbinom(1, size = 10, prob = .01)


###################################################
### code chunk number 23: rbinom280
###################################################
rbinom(1, size = 100, prob = .01)


###################################################
### code chunk number 24: rbinom290
###################################################
rbinom(1, size = 1000, prob = .01)


###################################################
### code chunk number 25: rbinom300
###################################################
N <- 2000
size1 <- 10
size2 <- 100
size3 <- 1000
size4 <- 10000
ohone <- 0.01 ## a joke!
y1 <- rbinom(N, size1, prob = ohone)
y2 <- rbinom(N, size2, prob = ohone)
y3 <- rbinom(N, size3, prob = ohone)
y4 <- rbinom(N, size4, prob = ohone)


###################################################
### code chunk number 26: rbinom310
###################################################
## Convert to proportions
y1p <- y1/size1
head(y1p)
y2p <- y2/size2
head(y2p)
y3p <- y3/size3
head(y3p)
y4p <- y4/size4
head(y4p)


###################################################
### code chunk number 27: rbinom320
###################################################
y1p.range <- range(y1p)
par(mfcol = c(2,2))
hist(y1p, prob = TRUE, xlim = y1p.range, breaks=50, main = paste("Size =", size1))
hist(y2p, prob = TRUE, xlim = y1p.range, breaks=50, main = paste("Size =", size2))
hist(y3p, prob = TRUE, xlim = y1p.range, breaks=50, main = paste("Size =", size3))
hist(y4p, prob = TRUE, xlim = y1p.range, breaks=50, main = paste("Size =", size4))


###################################################
### code chunk number 28: rbinom340
###################################################
N <- 2000
size <- c(10, 100, 1000, 10000)
ohone <- 0.01 ## a joke!
for(j in seq_along(size)){
	y <- rbinom(N, size[j], prob = ohone)
    yname <- paste0("y", j)
    assign(yname, y)
}


###################################################
### code chunk number 29: norm50
###################################################
sigma <- 3
mu <- 0
error <- rnorm(100, m = mu, s = sigma)


###################################################
### code chunk number 30: norm60
###################################################
head(error)
mean(error)


###################################################
### code chunk number 31: norm80
###################################################
y <- rnorm(10)
head(y)


###################################################
### code chunk number 32: norm90
###################################################
y <- rnorm(10, m = 100, s = 15)
head(y)


###################################################
### code chunk number 33: norm100
###################################################
mu <- 100
sigma <- 15
N <- 150
x <- rnorm(N, mean = mu, sd = sigma)
hist(x, prob = TRUE, main = "IQ Scores", xlab = "IQ", col = "grey70", breaks = 30)


###################################################
### code chunk number 34: norm110
###################################################
## Using x again, sample of N
mu
mean(x)


###################################################
### code chunk number 35: norm120
###################################################
sigma
sd(x)


###################################################
### code chunk number 36: norm105
###################################################
x.1000 <- rnorm(1000, mean = mu, sd = sigma)
hist(x.1000, prob = TRUE, main = "IQ Scores", xlab = "IQ", col = "grey70", breaks = 30)


###################################################
### code chunk number 37: norm130
###################################################
sigma <- 15
N <- 150
stderr.theoretical <- sigma / sqrt(N)
stderr.theoretical


###################################################
### code chunk number 38: norm140
###################################################
getSampleMean <- function(rep, N, M, SD){ 
    ## rep is an unused parameter, a place-holder
    x <- rnorm(N, mean = M, sd = SD)
    mean(x)
}


###################################################
### code chunk number 39: norm150
###################################################
# Recall
N
mu
sigma
getSampleMean(1, N, mu, sigma)


###################################################
### code chunk number 40: summeR-5-1-montecarlo-uniquebackupstring.Rnw:942-944
###################################################
set.seed(123)
muhat <- vapply(1:10000, getSampleMean, N = 150, M = mu, SD = sigma, numeric(1))


###################################################
### code chunk number 41: summeR-5-1-montecarlo-uniquebackupstring.Rnw:949-950
###################################################
head(muhat)


###################################################
### code chunk number 42: summeR-5-1-montecarlo-uniquebackupstring.Rnw:954-958
###################################################
muhatmean <- mean(muhat)
muhatmean
mu
mu - muhatmean


###################################################
### code chunk number 43: summeR-5-1-montecarlo-uniquebackupstring.Rnw:964-967
###################################################
muhatsd <- sd(muhat)
stderr.theoretical
muhatsd - stderr.theoretical


###################################################
### code chunk number 44: summeR-5-1-montecarlo-uniquebackupstring.Rnw:988-994
###################################################
getEstimates <- function(rep, N, M, SD) {
    x <- rnorm(N, mean = M, sd = SD)
    x <- ifelse(x > 100, 100, x)
    c(rep = rep, mean = mean(x), sd = sd(x), sterr = sd(x)/sqrt(N))
}
set.seed(123)


###################################################
### code chunk number 45: summeR-5-1-montecarlo-uniquebackupstring.Rnw:1000-1005
###################################################
## Recall
mu
sigma
trunc.hat <- vapply(1L:10000L, getEstimates, N = 150, M = mu, SD = sigma, numeric(4))
trunc.hat[ , 1:3]


###################################################
### code chunk number 46: summeR-5-1-montecarlo-uniquebackupstring.Rnw:1011-1019
###################################################
(trunc.mean <- mean(trunc.hat[2, ]))
## Empirical standard error of the mean is:
(trunc.mean.sd <- sd(trunc.hat[2, ]))
## Mean of within sample estimates of stardard error:
(trunc.se.mean <- mean(trunc.hat[4, ]))
## Theory-based std.err based using parameters (ignoring trunctation)
stderr.theory <- sigma/sqrt(N)
stderr.theory


###################################################
### code chunk number 47: reg100
###################################################
## Generate 100 cases
N <- 100
## X is normally distributed with a mean of 0 and a sd of 10
## Y = b0 + b1*X + e
b0 <- 30
b1 <- 2
e.sigma <- 5
x.mu <- 0
x.sigma <- 5
## e = N(0, e.sigma^2)
error <- rnorm(N, 0, e.sigma)
x <- rnorm(N, x.mu, x.sigma)
dtest <- data.frame(x = x,
                    y = b0 + b1 * x + error,
                    ynoe = b0 + b1 * x)
head(dtest)


###################################################
### code chunk number 48: reg110
###################################################
m1 <- lm(y ~ x, data = dtest)
m1.summary <- summary(m1) ## Save summary in object for later
m1.summary


###################################################
### code chunk number 49: reg120
###################################################
rockchalk::plotSlopes(m1, plotx = "x")


###################################################
### code chunk number 50: reg130
###################################################
names(m1)
coef(m1) ## just the betas
names(m1.summary)
coef(m1.summary) ## Parameter table


###################################################
### code chunk number 51: reg300
###################################################
ehuge <- rnorm(NROW(dtest), 0, 50)
dtest$yhuge <- b0 + b1 * dtest$x + ehuge
m3 <- lm(yhuge ~ x, dtest)
summary(m3)


###################################################
### code chunk number 52: reg310
###################################################
rockchalk::plotSlopes(m3, plotx = "x")


###################################################
### code chunk number 53: reg200
###################################################
m2 <- lm(ynoe ~ x, data = dtest)
summary(m2)
## Generates a warning
## Warning message: In summary.lm(m2) : essentially perfect fit: summary may be ## unreliable


###################################################
### code chunk number 54: first100
###################################################
## Two groups, first = 0 or 1
set.seed(123)
firstprop <- 0.4
dat <- data.frame(first = rbinom(n = 100, size = 1, prob = firstprop))
## We have just assigned rows of data into groups labeled 1 and 0
head(dat)
## Now we sample IQ scores, taking group membership into account.
## Here we use vectorized inputs to the data generator
dat$IQ <- rnorm(NROW(dat), m = 98 + 5 * dat$first, sd = 15)

## round to nearest whole number, since that is how IQ scores are
## reported
dat$IQ <- round(dat$IQ)
head(dat, 10)


###################################################
### code chunk number 55: first110
###################################################
## Do the sample statistics match the data generator (population) parameters?
## Several convenient ways to retrieve the answers
m1 <- lm(IQ ~ first, data = dat)
summary(m1)

## Or

t.test(IQ ~ first, data = dat)

## Or
aggregate(IQ ~ first, data = dat,
          FUN = function(x) c(M = mean(x), SD = sd(x)))
## I'm sure we could find a more tedious way to get group differences, but this is near the maximum
diff(aggregate(IQ ~ first, data = dat, mean)$IQ)


###################################################
### code chunk number 56: first120
###################################################
##' Create one data set for the first born question
##'
##' This uses a vectorized call to rnorm
##' @param rep Integer to name repetition
##' @param N Sample Size
##' @param M1 Mean of first born group
##' @param M0 Mean of non-first born group
##' @param SD1 Standard Deviation of first born
##' @param SD0 Standard Deviation of non-first born
##' @return A data frame
##' @author Paul Johnson
## define a data-generator function for one replication
getData <- function(rep, N, M1, M0, SD1, SD0) {
    dat <- data.frame(first = rbinom(n = N, size = 1, prob = .4))
    dat$rep <- rep
    dat$IQ <- rnorm(N, m = M0 + dat$first * (M1 - M0), 
                       s = SD0 + dat$first * (SD1 - SD0))
    dat$IQ <- round(dat$IQ)
    dat
}


###################################################
### code chunk number 57: first130
###################################################
##' Calculate difference between groups
##'
##' This setup is lazy because it assumes the names
##' of the variables are simply "first" and "IQ". 
##' I'd never do this in a real project.
##' @param dframe a data frame with input data
##' @return A floating point number for the difference
getDiff <- function(dframe){
    diff(aggregate(IQ ~ first, data = dframe, mean)$IQ)
}


###################################################
### code chunk number 58: first140
###################################################
## try it on one replication first
dat1 <- getData(1, N = 100, M1 = 103, M0 = 98, SD1 = 15, SD0 = 15)
getDiff(dat1)
##
## Combine into 1 step if we don't want to save the data
getDiff(getData(1, N = 100, M1 = 103, M0 = 98, SD1 = 15, SD0 = 15))



###################################################
### code chunk number 59: first150
###################################################

## Make a wrapper function
oneSim <- function(rep, N = 100, M1 = 103, M0 = 98, SD1 = 15, SD0 = 15){
   getDiff(getData(1, N = N, M1 = M1, M0 = M0, SD1 = SD1, SD0 = SD0))
}

## now do it 2000 times
## vapply here not different from R's replicate, but we have
## more control
set.seed(123)
myMeanDiffs <- vapply(1:2000, oneSim, N = 100,
                      M1 = 103, M0 = 98, SD1 = 15, SD0 = 15,
                      numeric(1))
## check results
mean(myMeanDiffs)
sd(myMeanDiffs)


###################################################
### code chunk number 60: first200
###################################################
hist(myMeanDiffs, prob = TRUE, breaks = 30)


###################################################
### code chunk number 61: t100
###################################################
x <- "40:20"
strsplit(x, ":")
## It is wrapped in an R list
unlist(strsplit(x, ":"))
## It is still characters, need numbers
as.numeric(unlist(strsplit(x, ":")))


###################################################
### code chunk number 62: t110
###################################################
## Define a function for one replication
getTdata <- function(rep, N, M, SD) {
    ## tease apart two sample sizes
    Nvec <- as.numeric(unlist(strsplit(N, ":")))
    ## tease apart two means
    Mvec <- as.numeric(unlist(strsplit(M, ":")))
    ## tease apart two SDs
    SDvec <- as.numeric(unlist(strsplit(SD, ":")))

    ## assign dummy variables to each group's data set
    dat <- data.frame(first = c(rep(0, times = Nvec[1]),
                            rep(1, times = Nvec[2])))
    ## generate random IQ scores
    dat$IQ <- rnorm(sum(Nvec), m = Mvec[(dat$first + 1)], 
                     sd = SDvec[(dat$first + 1)])
    dat$IQ <- round(dat$IQ)
    attr(dat, "rep") <- rep
    attr(dat, "parms") <- c(N = N, M = M, SD = SD)
    dat
}


###################################################
### code chunk number 63: t120
###################################################
## Test
dframe1 <- getTdata(1, N = "30:30", M = "98:102", SD = "15:15")


###################################################
### code chunk number 64: t130
###################################################
## Note the attributes stored with the data frame:
attributes(dframe1)

## Individual attributes can be retrieved
attr(dframe1, "rep")
attr(dframe1, "parms")


###################################################
### code chunk number 65: t140
###################################################
##' A small wrapper to calculate a t-test
##' @param dframe A data frame
##' @param y character string for name of dependent variable. Default is "IQ"
##' @param x character string for name of independent variable. Default is "first"
##' @return We return only the p-value. 
conductTtest <- function (dframe, y = "IQ", x = "first"){
 	t.test(formula(paste(y, "~", x)), data = dframe, var.equal = TRUE)$p.value
}

## Test it once, wrapping 2 function calls together
conductTtest(getTdata(1, N = "30:30", M = "98:103", SD = "15:15"))

## Create a one-step wrapper to put those together
runOneSim <- function(nreps, N, M, SD){
    df <- getTdata(1, N = "30:30", M = "98:103", SD = "15:15")
    reslt <- conductTtest(df)
    reslt
}


###################################################
### code chunk number 66: t160
###################################################
## Now apply it 10 times to see the format of the output
sim10 <- sapply(1:10, runOneSim, N = "30:30", M = "98:103", SD = "15:15")
sim10

## Oops, I did not snatch the attributes for records. 
## Oops, I also forgot to store the rejection decision, so insert it

runOneSim <- function(rep, N, M, SD){
    dframe <- getTdata(rep, N = N, M = M, SD = SD)
    reslt <- conductTtest(dframe)
    parms <- attr(dframe, "parms")
    dframe2 <- data.frame(rep = attr(dframe, "rep"), 
               pvalue = reslt, reject = if (reslt <= 0.05) 1 else 0,
               N = parms["N"], M = parms["M"], SD = parms["SD"])
	dframe2
}

## test that
runOneSim(1, N = "30:30", M = "98:103", SD = "15:15")


###################################################
### code chunk number 67: t180
###################################################
## Returns a list of one row data frames
set.seed(123)
nReps <- 1000
result.list <- lapply(1:nReps, runOneSim, N = "30:30", M = "98:103", SD = "15:15")

## Smash those down into one data frame with 1 row
## per replication
result.df <- do.call("rbind", result.list)

mean(result.df$reject)


###################################################
### code chunk number 68: t190
###################################################
plot(result.df$pvalue, result.df$reject)


###################################################
### code chunk number 69: t200
###################################################
expand.grid(x = c("a", "b", "c"), y = c("j", "k"), z = c(1, 2, 3))


###################################################
### code chunk number 70: t220
###################################################
eg <- expand.grid(x = c("a", "b", "c"), y = c("j", "k"), z = c(1, 2, 3))
## In document production, this causes an error. Should be OK interactively
## str(eg)
lapply(eg, class)


###################################################
### code chunk number 71: t240
###################################################
eg <- expand.grid(x = c("a", "b", "c"), 
                  y = c("j", "k"), 
                  z = c(1, 2, 3),
                  stringsAsFactors = FALSE)
## str(eg)
lapply(eg, class)


###################################################
### code chunk number 72: t260
###################################################
## Set a variety of factors and compare p-values

## We need to choose levels of our predictors (sample size and SD)
## - equal v. unequal group sample sizes
## - equal v. unequal group variances
## - mean-difference: 0, 5, or 10
cond.N <- c("30:30", "40:20")
cond.SD <- c("10:20", "15:15", "20:10")
cond.M <- c("100:100") # for now, mean-difference = 0

## A fully crossed design runs all combinations of these levels.  This
## is a 2 (N) by 3 (SD) factorial design, so it has 2 * 3 = 6
## conditions
conds <- expand.grid(maxReps = 3, SD = cond.SD, N = cond.N, M = cond.M,
                     stringsAsFactors = FALSE)
head(conds)


###################################################
### code chunk number 73: t280
###################################################
##' Tell this function the condition row to use,
##' and it creates a batch of simulations
runOneCondition <- function(i, conds){
   x <- conds[i, ]
   result.list <- lapply(1:x$maxReps, runOneSim, 
                 N = x$N, M = x$M, SD = x$SD)
   do.call("rbind", result.list)
}

allResults <- lapply(1:NROW(conds), runOneCondition, conds)

## Each sample drawn from a particular population is a "case" (like
## subjects).  We can easily combine our list of results as a single
## data set for analysis
output <- do.call(rbind, allResults)
head(output, 30)

## Finally, we are ready to run several replications in each condition.
conds$maxReps <- 1000
conds
## Our Monte Carlo study will take a few moments to run
set.seed(123)
bigResults <- lapply(1:NROW(conds), runOneCondition, conds)

stackedResults <- do.call(rbind, bigResults)

## Now summarize the rejection rate for each condition
output <- aggregate(reject ~ N + SD, data = stackedResults, FUN = mean)
names(output) <- c("N", "SD", "Type.I.Rate")
output


###################################################
### code chunk number 74: t300
###################################################
## How does it perform when sample sizes are equal?
output[output$N == "30:30",]

## Unequal?
output[output$N != "30:30",]


###################################################
### code chunk number 75: t320
###################################################
## Since 15 years ago, R's default t-test uses Welch's
## correction for difference in variance.

## A replacement for the t-test function
conductTtest <- function (dframe, y = "IQ", x = "first"){
 	t.test(formula(paste(y, "~", x)), data = dframe)$p.value
}
set.seed(123)
bigResults <- lapply(1:NROW(conds), runOneCondition, conds)

stackedResults <- do.call(rbind, bigResults)

## Now summarize the rejection rate for each condition
output <- aggregate(reject ~ N + SD, data = stackedResults, FUN = mean)
names(output) <- c("N", "SD", "Type.I.Rate")
output


###################################################
### code chunk number 76: summeR-5-1-montecarlo-uniquebackupstring.Rnw:1877-1881 (eval = FALSE)
###################################################
## CRAN <- "http://rweb.crmda.ku.edu/cran" 
## KRAN <- "http://rweb.crmda.ku.edu/kran"
## options(repos = c(KRAN, CRAN))
## install.packages("portableParallelSeeds", type = "source")


###################################################
### code chunk number 77: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 78: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


