
## Ben Kite
## 2017-05-15

### Terrence D. Jorgensen
### 22 August 2014

### Monte Carlo Simulation: R syntax for instruction and examples

#####################################
## Pseudo-random number generation ##
#####################################

## R has utilities for several commonly used distributions:

## - "d*" returns the probability mass/density at a certain quantile

## - "p*" returns the cumulative probability up to (or above) a
## - certain quantile

## - "q*" returns the quantile associated with a certain cumulative
## - probability

## - "r*" returns pseudorandom numbers from that distribution

## Random normal values
?rnorm
## Random t values
?rt
## Random F values
?rf
## Random chi-square values
?rchisq
## Random Poisson values
?rpois
## Random binomial values
?rbinom
## Random uniform values
?runif

## Today we will focus on random binomial and normal values

# Binomial distribution

## To get a sense of the idea of generating random numbers, let's try
## flipping a fair coin once.  We will define "Heads" == 1 and "Tails"
## == 0
rbinom(n = 1, size = 1, prob = .5)
## Did you get heads or tails?  Flip the coin again by highlighting
## the above code and running it again.

## This could get tedious if we want many coin flips.  Let's just ask
## R's random number generator (RNG) for 10 random coin flips all at
## once.
rbinom(n = 10, size = 1, prob = .5)

## You probably have a different sequence of heads/tails from your
## neighbor.  To get the same answer, let's set a "seed" for the RNG.
set.seed(123)

## If everyone sets the same seed, then we should all get the same
## sequence.
rbinom(10, size = 1, prob = .5)
## If we close R and start it again, set the seed to 123, then we will
## get the same answer.  Same also if we use a different computer.
## Replication is the key to a good design, so RNG seeds are vital to
## a Monte Carlo study.
set.seed(123)
## These 3 flips should match the first 3 in the vector of 10 flips
## above.
rbinom(1, size = 1, prob = .5)
rbinom(1, size = 1, prob = .5)
rbinom(1, size = 1, prob = .5)

## Suppose we are not interested in the exact sequence, but only in
## how many flips result in Heads.  We can ask the RNG for a single
## number (n) that is the sum of 10 trials (size = 10).
rbinom(1, size = 10, prob = .5)

## Suppose now that we are not modeling the flipping coins, but rather
## the probability of a rare event.  Celiac disease affects 1% of the
## population.  How many would we expect in a random sample of 10
## people?
rbinom(1, size = 10, prob = .01)
## How many would we expect in a random sample of 100 people?
rbinom(1, size = 100, prob = .01)
## How many would we expect in a random sample of 1000 people?
rbinom(1, size = 1000, prob = .01)

# Normal distribution

## Most of us are familiar with at least a few special cases of the
## general linear model: regression, correlation, t tests, ANOVA.
## These assume a normally distributed outcome (at least, a normal
## residual term).
rnorm(10)
## These are z scores, because the default in rnorm() is mean = 0 and
## sd = 1.  But we can easily change these to reflect another scale of
## measurement, such as random IQ scores
rnorm(10, mean = 100, sd = 15)

## A large enough sample should look approximately normal
pop.M <- 100
pop.SD <- 15
x <- rnorm(150, mean = pop.M, sd = pop.SD)
hist(x, main = "IQ Scores", xlab = "IQ", col = "grey70")

## Do the sample statistics match the population parameters?
pop.M
mean(x)

pop.SD
sd(x)
## Why don't they match exactly?  What would make them match more
## closely?

## Can we quantify how much we expect the sample mean to differ from
## the population parameter in random samples?  Remember the standard
## error?  SE = SD / sqrt(N)
SE <- 15 / sqrt(150)
SE
## What exactly is the SE?  Let's use a Monte Carlo investigation to
## find out!

## To illustrate using Monte Carlo methods, we can draw several random
## samples of N = 150 from the same population, saving the mean from
## each one.  First, write a function that will do this for one
## replication:
getSampleMean <- function(rep, N, M, SD) mean(rnorm(N, mean = M,
                                                    sd = SD))

## now apply it once to check that it works
getSampleMean(1, N = 150, M = pop.M, SD = pop.SD)

## OK, now apply it 100,000 times
set.seed(123)
myMeans <- sapply(1:100000, getSampleMean, N = 150, M = pop.M,
                  SD = pop.SD)
## print the first few means to see if it looks like the output you
## expected
head(myMeans)

## What is the mean of the sample means?
mean(myMeans)
pop.M
## pretty close!  Mean of means approaches true pop.M as N approaches
## infinity

## What is the SD of the sample means?
sd(myMeans)
SE
## pretty close!  SD of means approaches SE as N approaches infinity

## What's the point of this?  Just to test whether the formula for SE
## works?  Well, we drew random NORMAL numbers, so we would expect the
## normal-theory formula for SE to work.  What if that assumption were
## violated?

## Suppose we were studying exam scores, with a ceiling effect at 100.

getSampleMean <- function(rep, N, M, SD) {
    x <- rnorm(N, mean = M, sd = SD)
    x <- ifelse(x > 100, 100, x)
    mean(x)
}

set.seed(123)
myMeans <- sapply(1:100000, getSampleMean, N = 150, M = 90, SD = 8)
mean(myMeans)
sd(myMeans) ## Observed SE based on monte carlo simulation.
8 / sqrt(150) ## new SE assuming normality.  This SE is inflated.


##########################################################
## Generating random samples from population parameters ##
##########################################################

                                        # Example 1
## Basic regression model

## Supose that we want to ensure that our regression model is
## estimating a slope properly.

## We can generate data from a population space where the regression
## slope for X predicting Y is known.

## Generate 100 cases
N <- 100

## X is normally distributed with a mean of 0 and a sd of 10
## Y = intercept + b1*X + e
## intercept = 30
## b1 = 2
## e = N(0,5)
X <- rnorm(N, 0, 10)
Y <- 30 + 2*X + rnorm(N, 0, 5)
plot(Y ~ X)
summary(lm(Y ~ X))

## What if we forget the error term?
Y <- 30 + 2*X
plot(Y ~ X)
summary(lm(Y ~ X))

## What if the error term has high variance?
Y <- 30 + 2*X + rnorm(100, 0, 50)
plot(Y ~ X)
summary(lm(Y ~ X))


                                        # Example 2
## Group mean differences

## There is evidence that birth order (social more than biological)
## affects IQ (doi:10.1126/science.1141493).  Suppose that we only
## record whether a child is raised as first-born (1 = first-born, 0 =
## not), and that the true mean difference between those two
## populations is 5 IQ points.
103 - 98
## Specifically, let's suppose that first-borns represent 40% of
## children and have a mean IQ = 103, whereas children raised with
## older siblings are 60% and have a mean IQ = 98, so the overall
## average IQ is 100.
.4*103 + .6*98

## We can sample separately from two populations with these
## characteristics.
set.seed(123)
dat <- data.frame(first = rbinom(n = 100, size = 1, prob = .4))
## We have just sampled which groups 100 people belong to.
head(dat)
## Now we sample IQ scores, taking group membership into account.
dat$IQ <- NA
for (i in seq_along(dat$first)) {
    if (dat$first[i] == 1) {
        dat$IQ[i] <- rnorm(1, m = 103, sd = 15)
    } else {
        dat$IQ[i] <- rnorm(1, m = 98, sd = 15)
    }
}
## round to nearest whole number, since that is how IQ scores are
## measured
dat$IQ <- round(dat$IQ)
head(dat, 20)

## Do the sample statistics match the population parameters?
aggregate(IQ ~ first, data = dat,
          FUN = function(x) c(M = mean(x), SD = sd(x)))
## We expect sampling variability for mean differences, just like for
## the mean.
diff(aggregate(IQ ~ first, data = dat, mean)$IQ)

## Let's use Monte Carlo methods to find out how much the
## mean-difference varies

## define a function for one replication
getMeanDiff <- function(rep, N, M1, M2, SD1, SD2) {
    dat <- data.frame(first = rbinom(n = N, size = 1, prob = .4))
    dat$IQ <- NA
    for (i in seq_along(dat$first)) {
        if (dat$first[i] == 1) {
            dat$IQ[i] <- rnorm(1, m = M1, sd = SD1)
        } else {
            dat$IQ[i] <- rnorm(1, m = M2, sd = SD2)
        }
    }
    dat$IQ <- round(dat$IQ)
    diff(aggregate(IQ ~ first, data = dat, mean)$IQ)
}
## try it on one replication first
getMeanDiff(1, N = 100, M1 = 103, M2 = 98, SD1 = 15, SD2 = 15)
## now do it 2000 times
set.seed(123)
myMeanDiffs <- sapply(1:2000, getMeanDiff, N = 100,
                      M1 = 103, M2 = 98, SD1 = 15, SD2 = 15)
## check results
mean(myMeanDiffs)
sd(myMeanDiffs)

## Informative, but did you notice how long it took?  Drawing one
## random IQ score at a time for each person in each sample is very
## slow.  Working with a population is faster because you draw all
## your random numbers at once.  How do you specify a mean-difference
## as a regression model?

## IQ = b_0 + b_1*first + error

## In this model, b_0 represents the mean IQ when the predictor
## "first" == 0 (i.e., IQ = 98).  b_1 is the slope for "first", which
## represents the mean-difference between the groups defined by first
## == 0 and first == 1 (i.e., 5).  The error term is the random part
## of the model, which has a mean of zero and some variance.

N <- 100
set.seed(123)
dat <- data.frame(first = rbinom(n = N, size = 1, prob = .4))
dat$IQ <- 98 + 5*dat$first + rnorm(N, sd = 15)
dat$IQ <- round(dat$IQ)
head(dat)

## Doesn't that syntax look so much simpler?!  This is the advantage
## of specifying a model for your data.  It gets more complex with
## more predictors, but not nearly as complex as the other way would
## be.

getMeanDiff2 <- function(rep, N, M1, M2, SD1, SD2) {
    dat <- data.frame(first = rbinom(n = N, size = 1, prob = .4))
    dat$IQ <- M1 + (M2 - M1)*dat$first +
        rnorm(N, sd = ifelse(dat$first == 0, SD1, SD2)) ## This allows the SD to vary by group.
    dat$IQ <- round(dat$IQ)
    diff(aggregate(IQ ~ first, data = dat, mean)$IQ)
}

getMeanDiff2(1, N = 100, M1 = 98, M2 = 103, SD1 = 15, SD2 = 15)

set.seed(123)
myMeanDiffs2 <- sapply(1:2000, getMeanDiff2, N = 100, M1 = 98, M2 = 103,
                      SD1 = 15, SD2 = 15)
## check results
mean(myMeanDiffs2)
sd(myMeanDiffs2)

## Try it yourself!
## Generate a dichotomous grouping variable using rbinom
## Use a linear equation to generate dependent variable scores
## Don't forget the error term!

                                        # Example 3

###################################
## Designing a Monte Carlo study ##
###################################

## Remember the assumptions of a t-test?  Using the simplest
## calculations:

## - equal variances (or SD) in each group (called homoscedasticity)
## - normally distributed data
## - independence of randomly sampled observations from population

## Perhaps you've also heard that a t-test is "robust" to a moderate
## violation of normality, meaning that you'll make about as many Type
## I errors with moderately non-normal data as you would with normal
## data.

## The t-test is also robust to heteroscedasticity (different
## variances), as long as the sample sizes are roughly equal.

## Let's design a small-scale simulation to see what the effects of
## these factors are on the result of a t-test.

## Our question is: Does violating these assumptions increase the
## probability of making a Type I error.

## First, we want an easy way to submit sample size, mean, and SD for
## each group.  If we specify it as a character string:
N <- "40:20"
N
## then we can build a function that recognizes the numbers in that
## string
strsplit(N, ":")
as.numeric(strsplit(N, ":")[[1]])


## Define a function for one replication
runTTest <- function(rep, N, M, SD) {
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

    t.test(IQ ~ first, data = dat, var.equal = TRUE)$p.value
}

## Test it once
runTTest(1, N = "30:30", M = "98:103", SD = "15:15")

## Now apply it 10 times to see the format of the output
sapply(1:10, runTTest, N = "30:30", M = "98:103", SD = "15:15")

## Let's add columns indicating conditions
x <- sapply(1:10, runTTest, N = "30:30", M = "98:103",
              SD = "15:15")
data.frame(x, N = "30:30", M = "98:103", SD = "15:15")
## That looks more like a data set we are used to, where each row is a
## case (in simulations, a "replication") and each column is a
## variable.

## Now create a function that applies "runTTest" a certain number
## of times (i.e., nReps = number of replications) in one condition
runCond <- function(nReps, N, M, SD) {
    x <- sapply(1:nReps, runTTest, N = N, M = M, SD = SD)
    data.frame("pvalue" = x, N = N, M = M, SD = SD)
}

## Run 1000 replications in the following condition:
set.seed(123)
out <- runCond(nReps = 1000, N = "30:30", M = "98:103", SD = "15:15")
head(out)

## What proportion of the time is the null of equal population means rejected?
out$reject <- ifelse(out$pvalue <= .05, 1, 0)
mean(out$reject)

## Now we can run this with a variety of factors and compare p-values

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
conds <- expand.grid(SD = cond.SD, N = cond.N, M = cond.M)
conds$nReps <- 3
conds

## We can apply our "getMeanDiff" function to each row (condition)
out <- apply(conds, MARGIN = 1,
             FUN = function(x) do.call(runCond, as.list(x)))
out
## Each sample drawn from a particular population is a "case" (like
## subjects).  We can easily combine our list of results as a single
## data set for analysis
out <- do.call(rbind, out)
out


## Finally, we are ready to run several replications in each condition.
conds$nReps <- 1000
conds
## Our Monte Carlo study will take a few moments to run
set.seed(123)
out <- apply(conds, MARGIN = 1,
             FUN = function(x) do.call(runCond, as.list(x)))
out <- do.call(rbind, out)

## Add a variable to indicate rejecting the null hypothesis
## We reject the null if the p-value is less than .05
## Therefore because the null is true in the parameter space,
## we expect the reject the null only 5% of the time
out$reject <- ifelse(out$pvalue <= .05, 1, 0)

## Now summarize the rejection rate for each condition
output <- aggregate(reject ~ N + SD, data = out, FUN = mean)
names(output) <- c("N", "SD", "Type I Error Rate")
output

## How does it perform when sample sizes are equal?
output[output$N == "30:30",]

## Unequal?
output[output$N == "40:20",]









