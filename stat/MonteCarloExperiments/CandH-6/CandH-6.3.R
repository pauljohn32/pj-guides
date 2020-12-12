## Paul Johnson
## 20151022

## notes on  Carsey and Harden Chapter 5


## Methodology in C and H in chapter 6 follows chapter 5.
## The basic idea is

## 1. create a matrix to hold "reps" rows of data

## 2. use a for loop to fill in the matrix row by row

## This is extremely clear and I expect very easy for new
## R programmers to understand.

## I would ordinarily suggest users should change the style in order
## to improve 1) clarity and 2) replicability. A tertiary
## consideration is speed, and that's mainly what I'm working on
## below, since there are separate notes on clarity and replication.

## I noticed some usages that I suspected were causing this simulation
## to run slowly, but found out my intuitions were not correct.  We
## can make it run in about one-half of the time they originally used,
## but none of the elements that I thought were "obvious" actually
## made it go faster.

## For example, here's something that might matter, but does not have
## a noticeable effect.  Their code uses return() at the end of
## functions, but that is not necessary. It is an unnecessary function
## call.  Students notice that I don't use return() at the end of
## functions. Theoretically, at lease, calling return() over and over
## will cause a slight slowdown. However, we can't detect that
## slowdown in this exercise.



## C and H, p. 130

##' Receive probabilities, return inverse logit values
##'
##' From C and H p. 132.  Note, I don't use return() here
##' @param p Probability value
##' @return real valued vector 
##' @author Paul Johnson <pauljohn@@ku.edu>
inv.logit <- function(p) exp(p)/(1 + exp(p))


## C and H, p. 132
##' Calculate coverage information, from C and H p. 132
##'
##' Uses a Wald approximation to create a 95% CI
##' @param b Vector of estimated parameters
##' @param se Vector of standard errors of parameters
##' @param true Single true value
##' @param level Default 0.95: confidence level
##' @param df Degrees of freedom used in creating t value
##' @return A list with 4 objects
##' @author Paul Johnson 
coverage <- function(b, se, true, level = 0.95,
                     df = Inf)
{
    qtile <- level + (1 - level)/2
    lower.bound <- b - qt(qtile, df = df)*se
    upper.bound <- b + qt(qtile, df = df)*se
    true.in.ci <- ifelse(true >= lower.bound & true <= upper.bound, 1, 0)
    cp <- mean(true.in.ci)
    ## Monte Carlo error:
    mc.lower.bound <- cp - 1.96*sqrt((cp*(1 - cp))/length(b))
    mc.upper.bound <- cp + 1.96*sqrt((cp*(1 -cp))/length(b))
    list(coverage.probability = cp,
         true.in.ci = true.in.ci,
         ci = cbind(lower.bound, upper.bound),
         mc.eb = c(mc.lower.bound, mc.upper.bound))
}



## parameters
reps <- 1000
n <- 1000
b0 <- 0.2; b1 <- 0.5

## the predictor variable
X <- runif(n, -1, 1)

## NOTE, X is not re-generated with each simulation. It is
## "fixed" in the statistical sense.

par.est.logit <- matrix(NA, nrow = reps, ncol = 4)
set.seed(32945)


## Code from p. 133. Wrap inside system.time to assess
system.time(
for(i in 1:reps){
    Y <- rbinom(n, 1, inv.logit(b0 + b1 * X))
    model <- glm(Y ~ X, family = "binomial" (link = "logit"))
    vcv <- vcov(model)
    par.est.logit[i, 1] <- model$coef[1]
    par.est.logit[i, 2] <- model$coef[2]
    par.est.logit[i, 3] <- sqrt(diag(vcv)[1])
    par.est.logit[i, 4] <- sqrt(diag(vcv)[2])
}
)

## That's good enough for most purposes.  Then
## the researcher's mission is to summarize and display that
## for readers.

## Get the means of the estimates
par.est.logit.mean <- round(colMeans(par.est.logit), 3)
par.est.logit.mean

par.est.logit.sd <- round(apply(par.est.logit, 2, sd), 4)


b1mse <- (par.est.logit.mean[2] - b1)^1 + par.est.logit.sd[2]^2

mean(par.est.logit[ , 1]) 


hist(par.est.logit[ , 1], breaks = 20,
     xlab = paste("Estimates of b0 = ", b0),
     prob = TRUE, main = "Intercept Estimates")

hist(par.est.logit[ , 2], breaks = 20,
     xlab = bquote(Estimates~~of~~b[1]),
     prob = TRUE, main = bquote(Estimates~~of~~b[1]))
abline(v = b1, col = "red")
mtext(text = bquote(True~~b[1] == .(b1)), side = 1, at = b1, line = 0.5, col = "red")
## I wasted time trying to write plotmath into the legend, quit
## because it was not coming out right.  
legend("topright",
       legend = c(paste0("Mean =", round(par.est.logit.mean[ 2], 3)),
                  paste0("S.D. =", round(par.est.logit.sd[2], 3)),
                  paste0("MSE =", round(b1mse,3 )))
                  )

b1.cov <- coverage(par.est.logit[ , 2], par.est.logit[ , 4], b1, df = 998) 
b1.cov$coverage.probability
table(b1.cov$true.in.ci)

## Plots C and H p.95 similar to plots that Gelman and Hill use.

## I wanted to experiment with row selections, here's
## a view of the first 100 rows
rdraw <- 1:100

plot(rdraw, rdraw,  type = "n",
     ylim = rockchalk::magRange(unlist(b1.cov$ci), c(1,1.1)),
     xlab = paste(length(rdraw), "Simulated Samples"),
     ylab = expression(hat(b[1])))
abline(h = b1)
mycol <- ifelse(b1.cov$true.in.ci,  "gray80", "red")
for(i in rdraw){
        lines(c(i,i), b1.cov$ci[i, ], col = mycol[i])
}
points(rdraw, par.est.logit[rdraw ,2], col = mycol[rdraw])
legend("topleft", legend = c("CI includes true b1",
                             "CI does not include true b1"),
       fill = c("gray80", "red"))

## Students: Change rdraw, then re-run code
## rdraw <- 100:400
rdraw <- 300:900

##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##' @title 
##' @param lb 
##' @param ub 
##' @param est 
##' @param true 
##' @param nlines 
##' @return 
##' @author Paul Johnson
plotCI <- function(lb, ub, est, true, nlines = 100){
    if (nlines < length(lb)) crisis <- TRUE
    if(crisis){
        mysamp <- sample(seq.int(1, nlines), nlines, replace = TRUE)
        lb <- lb[mysamp]
        ub <- ub[mysamp]
        est <- est[mysamp]
    }
    
    rdraw <- seq_along(lb)
    plot(rdraw, rdraw,  type = "n",
         ylim = rockchalk::magRange(c(lb, ub), c(1, 1.1)),
         xlab = paste(length(rdraw), "Simulated Samples"),
         ylab = expression(hat(b[1])))
    abline(h = true)
    true.in.ci <- ifelse(lb < est & est < ub, TRUE, FALSE)
    mycol <- ifelse(true.in.ci,  "gray80", "red")
    for (i in rdraw){
        lines(c(i,i), c(lb[i], ub[i]), col = mycol[i])
    }
    points(rdraw, est, col = mycol[rdraw])
    legend("topleft", legend = c("CI includes true b1",
                                 "CI does not include true b1"),
           fill = c("gray80", "red"))
    list(true.in.ci, mysamp)
}








## Mission 1. Better organized?

## This is a simple toy simulation, I'd usually be reluctant
## about "one giant for loop". 
## I'd usually say the students should
## 1. Create the data generator function
## 2. Create the estimator function
## 3. Write the orchestrator to run over and over
## 4. Create evaluation functions.  

genY <- function (run, n, X, b0, b1){
    Y <- rbinom(n, 1, inv.logit(b0 + b1 * X))
}


## Uses some tricks from the "faster" section below
fitModel <- function(run, x, y){
    mf <- glm.fit(cbind(1, x), y, family = "binomial" (link = "logit"))
    class(mf) <- c("glm", "lm")
    c(model$coef, unlist(sqrt(diag(vcov(mf)))))
}


runSim <- function(run, n = 100, X, b0, b1){
    if (n != length(X)) stop(paste("sorry, I did not consider you would not use the right n"))
    Y <- genY(run, n, X, b0, b1)
    mf <- fitModel(run, X, Y)
    list("mf" = mf, "y" =  Y)
}


system.time(
    res <- lapply(1:1000, runSim, n, X, b0, b1)
)

res <- list()
system.time(
for(i in 1:reps){
    res[[i]] <- runSim(i, 1000, X, b0, b1)
}
)

system.time(
res2 <- do.call("rbind", res)
)



## Problems to fix. Did not save "seedin" in genY
## considered both doing a return list
genY <- function (run, n, X, b0, b1){
    seedin <- .Random.seed
    Y <- rbinom(n, 1, inv.logit(b0 + b1 * X))
    list("y" = Y, "seedin" = seedin)
}

## or an attribute
genY <- function (run, n, X, b0, b1){
    seedin <- .Random.seed
    Y <- rbinom(n, 1, inv.logit(b0 + b1 * X))
    attr(Y, "seedin") <- seedin
    Y
}

## Either way, storage is more complicated, analysis more difficult,
## because the seeds are in the "way"





## Mission 2. Faster?
## The rest of this: Looking to see if I can make this run faster.

## Here is the starting point
## for(i in 1:reps){
##     Y <- rbinom(n, 1, inv.logit(b0 + b1 * X))
##     model <- glm(Y ~ X, family = "binomial" (link = "logit"))
##     vcv <- vcov(model)
##     par.est.logit[i, 1] <- model$coef[1]
##     par.est.logit[i, 2] <- model$coef[2]
##     par.est.logit[i, 3] <- sqrt(diag(vcv)[1])
##     par.est.logit[i, 4] <- sqrt(diag(vcv)[2])
## }
## Why think it can go faster?
## 1. It places elements into result matrix one cell at a time.
## 2. It calls the sqrt(diag(vcv)) repeatedly.
## 3. Its a for loop.

## Do not write into the matrix line by line. There should be some
## benefit to reducing number of function calls and number
## of access into the matrix
par.est.logit2 <- matrix(NA, nrow = reps, ncol = 4)
set.seed(32945)
system.time(
for(i in 1:reps){
    Y <- rbinom(n, 1, inv.logit(b0 + b1 * X))
    model <- glm(Y ~ X, family = "binomial" (link = "logit"))
    vcv <- sqrt(diag(vcov(model)))
    par.est.logit2[i, ] <- c(model$coef, vcv)
}
)



## sapply should be a bit faster because more of the
## work gets pushed over to the C side of R,
set.seed(32945)
system.time(
par.est.logit3 <- sapply(1:reps, function(jj){
    Y <- rbinom(n, 1, inv.logit(b0 + b1 * X))
    model <- glm(Y ~ X, family = "binomial" (link = "logit"))
    c(model$coef, sqrt(diag(vcov(model))))
})
)

## vapply is better, try thiat

set.seed(32945)
system.time(
par.est.logit3b <- vapply(1:reps, FUN.VALUE = vector("double", 4),  function(jj){
    Y <- rbinom(n, 1, inv.logit(b0 + b1 * X))
    model <- glm(Y ~ X, family = "binomial" (link = "logit"))
    c(model$coef, sqrt(diag(vcov(model))))
})
)


## A simulation trick I learned from some notes that Dirk Eddelbuettel
## made years ago.  The high level functions like lm and glm take
## time. They re-organize data and scan for features we don't use.
## They rely on lm.fit() and glm.fit() to do the calculations, so we
## can go faster by avoiding the high level functions.

set.seed(32945)
system.time(
par.est.logit4 <- sapply(1:reps, function(jj){
    Y <- rbinom(n, 1, inv.logit(b0 + b1 * X))
    mf <- glm.fit(cbind(1, X), Y, family = "binomial" (link = "logit"))
    class(mf) <- c("glm", "lm")
    c(model$coef, unlist(sqrt(diag(vcov(mf)))))
})
)


## Lets write a function and run it

logitFit <- function(jj){
    Y <- rbinom(n, 1, inv.logit(b0 + b1 * X))
    model <- glm(Y ~ X, family = "binomial" (link = "logit"))
    c(model$coef, sqrt(diag(vcov(model))))
}

set.seed(32945)
system.time(
    par.est.logit5 <- sapply(1:reps, logitFit)
)


## Then compile the function
library(compiler)
logitFitCmp <- cmpfun(logitFit)
set.seed(32945)
system.time(
    par.est.logit6 <- sapply(1:reps, logitFitCmp)
)

par.est.logit7 <- matrix(NA, nrow = 4, ncol = reps)

set.seed(32945)
t1 <- Sys.time()
par.est.logit7 <- matrix(NA, nrow = 4, ncol = reps)
for(i in 1:reps){
    par.est.logit7[ ,i] <- logitFitCmp(i)
}
t2 <- Sys.time()
t2-t1

set.seed(32945)
t1 <- Sys.time()
par.est.logit7 <- lapply(1:reps, logitFitCmp)
par.est.logit7 <- do.call("cbind", par.est.logit7)
t2 <- Sys.time()
t2-t1

## The stupid cbind each time way:

set.seed(32945)
t1 <- Sys.time()
par.est.logit8 <- logitFitCmp(1)
for(i in 2:reps){
    par.est.logit8 <- cbind(par.est.logit8, logitFitCmp(i))
}
t2 <- Sys.time()
t2-t1



## compare
par.est.logit7[, 1]
par.est.logit6[, 1]
par.est.logit5[, 1]
par.est.logit8[ ,1]


par.est.logit4[, 1]
## There's a puzzle
