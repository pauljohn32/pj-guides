## Ben Kite
## 2017-05-23

### Terrence D. Jorgensen
### 22 August 2014
### Power Analysis: R syntax for instruction and examples


################################################################
## Rejection rates: Type I error (alpha) and Power (1 - beta) ##
################################################################

## Power and Type I error rates both refer to the probability of
## rejecting a null hypothesis (usually that the parameter = 0).  When
## the null is TRUE, then rejecting it is a Type I error, but when the
## null is FALSE, then you want to reject it as often as possible
## (i.e., high power).

## Try varying N, SD, alpha, and ES (one at a time) to see how they
## affect power
## To illustrate graphically, print the null sampling distribution
x.null <- seq(-4, 4, .1)
dx.null <- dnorm(x.null)
plot(x.null, dx.null, type = "l", lwd = 2, xlim = c(-4, 8), yaxt = "n",
     xlab = "Effect Size (e.g., Mean-Difference between Groups)", ylab = "")

## If abs(z) > 1.96, reject the null at alpha = .05
abline(v = qnorm(c(.025, .975)), lwd = 2, lty = "dashed")
## Type I errors occur for observations drawn outside the dashed lines

## Type II errors (and power) occur when the null is false.  It can be
## false in an infinite number of ways, e.g., Cohen's D = 0.80
x.8 <- x.null + 0.80
dx.8 <- dnorm(x.8, m = 0.80)
lines(x.8, dx.8, lwd = 2, col = "red")

## Note that we fail to reject the null for any samples drawn from the
## red population that are within the same bounds set for the null
## distribution, and we reject the null for any samples drawn outside
## the bounds.

## We can also increase power by using a less strict alpha level of .10
abline(v = qnorm(c(.05, .95)), lwd = 2, lty = "dashed", col = "purple")

## A larger effect size leads to greater discrepancy between the null
## and true distributions, so power increases because more of the true
## distribution falls beyond the bounds for the null.
plot(x.null, dx.null, type = "l", lwd = 2, xlim = c(-4, 8), yaxt = "n",
     xlab = "Effect Size (e.g., Mean-Difference between Groups)", ylab = "")
abline(v = qnorm(c(.025, .975)), lwd = 2, lty = "dashed")
x.2 <- x.null + 2
dx.2 <- dnorm(x.2, m = 2)
lines(x.2, dx.2, lwd = 2, col = "red")

## an even bigger effect size...
plot(x.null, dx.null, type = "l", lwd = 2, xlim = c(-4, 8), yaxt = "n",
     xlab = "Effect Size (e.g., Mean-Difference between Groups)", ylab = "")
abline(v = qnorm(c(.025, .975)), lwd = 2, lty = "dashed")
x.3 <- x.null + 3
dx.3 <- dnorm(x.3, m = 3)
lines(x.3, dx.3, lwd = 2, col = "red")

                                        # Example 1

## Continuing with the example from this morning, we can see how
## different variables influence the power to detect a mean difference
## between two groups

## Define a function to accept the above criteria and return p values
get.p.values <- function(rep, N, M, SD) {
    ## tease apart two sample sizes
    N1 <- as.numeric(strsplit(N, ":")[[1]])[1]
    N2 <- as.numeric(strsplit(N, ":")[[1]])[2]

    ## tease apart two means
    M1 <- as.numeric(strsplit(M, ":")[[1]])[1]
    M2 <- as.numeric(strsplit(M, ":")[[1]])[2]

    ## tease apart two SDs
    SD1 <- as.numeric(strsplit(SD, ":")[[1]])[1]
    SD2 <- as.numeric(strsplit(SD, ":")[[1]])[2]

    ## assign dummy variables to each group's data set
    dat1 <- data.frame(first = rep(1, times = N1))
    dat2 <- data.frame(first = rep(0, times = N2))

    ## generate random IQ scores
    dat1$IQ <- rnorm(N1, m = M1, sd = SD1)
    dat2$IQ <- rnorm(N2, m = M2, sd = SD2)

    ## combine data and round IQ to whole numbers
    dat <- rbind(dat1, dat2)
    dat$IQ <- round(dat$IQ)

    ## Return p value from t test
    t.test(IQ ~ first, data = dat, var.equal = TRUE)$p.value
}

## Test it on one replication
get.p.values(1, N = "30:30", M = "100:100", SD = "15:15")
## Test it on 10 replications to see the format of the output
sapply(1:10, get.p.values, N = "30:30", M = "100:100", SD = "15:15")

## Define a function that gets p values for nReps replications in a
## condition.
runCond <- function(nReps, N, M, SD) {
    x <- sapply(1:nReps, get.p.values, N = N, M = M, SD = SD)
    data.frame(p.val = x, N = N, M = M, SD = SD)
}

## We can run the same Monte Carlo study as at the end of the morning
## session, but when the null is FALSE (mean difference > 0)
cond.N <- c("30:30", "60:60")
cond.SD <- c("10:10", "15:15", "20:20")
cond.M <- c("100:105", "100:110") # mean-difference = 5 or 10
conds <- expand.grid(SD = cond.SD, N = cond.N, M = cond.M)
conds$nReps <- 1000
conds

set.seed(123)
pValues <- apply(conds, MARGIN = 1,
                 FUN = function(x) do.call(runCond, as.list(x)))
pValues <- do.call(rbind, pValues)
pValues$reject.05 <- ifelse(pValues$p.val < .05, 1, 0)
pValues$reject.01 <- ifelse(pValues$p.val < .01, 1, 0)

aggregate(cbind(reject.05, reject.01) ~ SD + N + M, data = pValues, mean)

                                        # Built in tools for quick power analyses

#######################################################################
## Cohen's (1988) Statistical Power Methods and Criteria are Popular ##
#######################################################################

## We can calculate approximately how much power we have to reject the
## null when the true effect size is d = 3.  But there are tools to
## calculate power more precisely, and that take into account sample
## size, alpha level, etc.

#install.packages("pwr")
library(pwr)
help(package = pwr)

## suppose you need to know what effect size is small, medium, or large
cohen.ES(test = "t", size = "large")    # Cohen's D
cohen.ES(test = "t", size = "medium")
cohen.ES(test = "t", size = "small")
cohen.ES(test = "r", size = "large")    # Pearson's r (correlation)
cohen.ES(test = "r", size = "medium")
cohen.ES(test = "r", size = "small")

cohen.ES(test = "anov", size = "small") # Cohen's f_squared
cohen.ES(test = "f2", size = "small")   # Cohen's f_squared


## Post-hoc power analysis:
## Find power for a given sample size, effect size, and alpha level
pwr.r.test(n = 30, r = .1, sig.level = .05)

## A priori power analysis: Find sample size required for a given
## level of power, alpha, and effect size
pwr.r.test(power = .80, r = .1, sig.level = .05)


## Do the same with Cohen's D for a t test
pwr.t.test(n = 30, d = .2, sig.level = .05)
pwr.t.test(power = .80, d = .2, sig.level = .05)

## repeat, without the requirement for equal group sizes
pwr.t2n.test(n1 = 20, n2 = 12, d = .2, sig.level = .05)
pwr.t2n.test(power = .8, n1 = 40, d = .5, sig.level = .05)


## More comprehensive power analyses are available in the free
## software G*Power
browseURL("http://www.gpower.hhu.de/en.html")

## But even G*Power only covers fairly simple cases.  "Standardized"
## effect sizes aren't intuitive.  When you need to know the power
## simultaneously for several tests/parameters in a single model, then
## Monte Carlo methods become necessary where analytical methods break
## down.

                                        # Example 2

##############################
## Populations as processes ##
##############################

## Suppose you want to test the degree to which someone's IQ is
## influenced by each of their parents' IQs (which are positively
## correlated themselves).
R <- 0.30
R # a "medium" effect size, by Cohen's (1988) standards

## Start with a correlation matrix of predictors
IQ.cor <- matrix(c(1, R, R, 1), nrow = 2, ncol = 2,
                 dimnames = list(c("dadIQ", "momIQ"), c("dadIQ", "momIQ")))
IQ.cor

## We can scale a correlation matrix to covariance in IQ-units
diag(c(15, 15)) # these are the standard devations of momIQ and dadIQ

IQ.cov <- diag(c(15, 15)) %*% IQ.cor %*% diag(c(15, 15))
IQ.cov
## we can check that these covariances correspond to our specified
## correlations
cov2cor(IQ.cov)

## Now we can use this to generate multivariate normal IQ data for mom
## and dad.
library(rockchalk) # install and load this library for the mvrnorm()
                   # function

N <- 100

set.seed(123)
dat <- mvrnorm(n = N, mu = c(dadIQ = 100, momIQ = 100), Sigma = IQ.cov)
dat <- as.data.frame(round(dat))
head(dat)

## Do observed means and correlations match the population parameters?
colMeans(dat)
cor(dat)

## Now we will once again draw random birth-orders
dat$first <- rbinom(n = N, size = 1, prob = .4)

## Now that we have our multiple predictors, we can specify a model to
## generate outcomes (child's IQ) with random sampling error.
# (2*.5*225*.5 + 2*.5*67.5*.5) / 225
# sqrt(.35*225)
dat$IQ <- -3 + 5*dat$first + .5*dat$dadIQ + .5*dat$momIQ + rnorm(N, sd = 9)
dat$IQ <- round(dat$IQ)
head(dat)

## Do sample statistics match population parameters?
mod0 <- lm(IQ ~ first + momIQ + dadIQ, data = dat)
summary(mod0)



#########################################
## Design a Monte Carlo Power Analysis ##
#########################################

## Monte Carlo methods can be used to check the power simultaneously for
## all effects (i.e., each slope estimates).
summary(mod0)$coef
## get p values
summary(mod0)$coef[2:4, 4]
## check whether they meet significance criterion
alpha <- .05
alpha
summary(mod0)$coef[2:4, 4] < alpha


## In the simplest case, we only consider a single set of population
## parameters for the model, and we vary the sample size to assess power.

## Define a function to generate data for one replication, in which we can
## vary the correlation between momIQ and dadIQ, as well as sample size.
makeData <- function(rep, N, R) {
    require(rockchalk) # will load the package if it's not already loaded
    ## population covariance matrix among mom and dad's IQ scores
    IQ.cor <- matrix(c(1, R, R, 1), nrow = 2, ncol = 2,
                     dimnames = list(c("dadIQ", "momIQ"),
                                     c("dadIQ", "momIQ")))
    IQ.cov <- diag(c(15, 15)) %*% IQ.cor %*% diag(c(15, 15))
    ## generate sample from the above population
    dat <- mvrnorm(n = N, mu = c(dadIQ = 100, momIQ = 100), Sigma = IQ.cov)
    dat <- as.data.frame(round(dat))
    ## add independent predictor: first-born status
    dat$first <- rbinom(n = N, size = 1, prob = .4)
    ## generate outcomes from predictors, add random noise
    dat$IQ <- -3 + 5*dat$first + .5*dat$dadIQ + .5*dat$momIQ + rnorm(N, sd = 12)
    dat$IQ <- round(dat$IQ)
    ## return the random sample for analysis
    dat
}

## Test it once
set.seed(123)
dat <- makeData(1, N = 20, R = .3)
dat

## Define a function to analyze that data and return rejection decisions
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


## Using a Monte Carlo design, we can calculate power across sample
## sizes as the proportion of cases where the null was rejected in
## each condition.
cond.N <- seq(from = 20, to = 150, by = 10)
cond.N
cond.R <- c(0.30) # for now, don't vary the correlation between predictors
conds <- expand.grid(N = cond.N, R = cond.R)
conds$nReps <- 1000
conds

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

## plot power by sample size
plot(first ~ N, data = rates, type = "l", lwd = 2, ylim = 0:1)
abline(h = .8, col = "darkgreen", lty = "dashed")
lines(momIQ ~ N, data = rates, col = "red", lwd = 2)
lines(dadIQ ~ N, data = rates, col = "blue", lwd = 2)


## What sample size is required to detect the effect of mom's IQ at
## least 80% of the time?  Dad's IQ?  First-born status?  Do we need
## to add more sample size conditions?


## More complex power analyses might take into account varying
## population parameters as well, such as the correlation among
## predictors, or the effects (slopes) of each predictor, or the
## variance of the random errors, or whether interactions exist, etc.
## The function above already allows you to manipulate the correlation
## between predictors, but you can add arguments to manipulate other
## characteristics of importance.


