## Paul Johnson
## some miscellaneous regression plots  poking and soaking

x1 <- runif(100, min = 50, max = 150)

x2numeric <- rnorm(100)
x2dummy <- ifelse( x2numeric < 0, 0, 1)

x2f1 <-cut(x2numeric, breaks = c(-100, 0, 100), labels = c("low","high"))

## now an error term
err1 <- rnorm(100, mean = 0, sd = 5000 )

## Manufacture an output variable, using the numeric
y <- 10 + 100 * x1 - 0.1 * x2dummy +   err1

dat <- data.frame(x1, x2dummy, x2f1, y)
rm(x1, x2dummy, x2f1, y)

mytitle <- paste("Phony data for", expression(10 + 100 * x1))
plot(y ~ x1, data = dat, main = mytitle , type="n")
points(y ~ x1, data = dat, col = as.numeric(dat$x2f1), pch=16, cex=.6)
legend( 1*min(dat$x1), max(dat$y), levels(dat$x2f1), col = c(1,2), pch = 16, pt.cex = 0.6)

mymod1 <- lm(y ~ x1 + x2f1, data = dat)

summary(mymod1)


library(car)

## Here's the Var-Covar matrix of b-hat. It uses
## "vcov" which is now in the R  base distribution
VarCovMat <- vcov(mymod1)

#get square root of diagonals to compare against lm output
sqrt(diag(VarCovMat))



#check for multi-collinearity
vif(mymod1)
library(rockchalk)
mcDiagnose(mymod1)


#There are 5 variants of the "heteroskedasticity consistent
#covariance matrix
hccm(mymod1, type = "hc0")
hccm(mymod1, type = "hc1")
hccm(mymod1, type = "hc2")
hccm(mymod1, type = "hc3")
hccm(mymod1, type = "hc4")


#This will introduce heteroskedasticity
e <- rnorm(100, mean = 0, sd = (1+ 10*(dat$x1)^2))

dat$y2 <- 10 + 0.015 * dat$x1 - 4 * dat$x2dummy +   e


library(lmtest)

mymod3 <- lm( y2 ~ x1 + x2f1, data = dat)

termplot(mymod3, partial.resid = TRUE, terms = "x1")
termplot(mymod3, partial.resid = TRUE, terms = "x2f1")


##Breusch-Pagan test
bptest(mymod1)
bptest(mymod3)

plotSlopes(mymod3, plotx = "x1", modx = "x2f1")

## Functional Form test

## Ramsey's "reset test" is a general purpose specification test.
## Checks to see if including squares or cubes of predictors will help.
## If it does, then you likely don't have the correct model

resettest(mymod1 ) # default
resettest(mymod1, type = "fitted")
resettest(mymod1, type = "regressor")
resettest(mymod1, type = "princomp")

#TESTS for NON NESTED MODELS

mymod2 <- lm(y ~ x1 + x2f1, data = dat)

## tests for specification: fitted model tests
## Cox's test
coxtest(mymod1, mymod2)

## j-test ala Davidson & MacKinnon: tests model 1's adequacy
## by finding if predictor values from model 2 have explanatory
## power in model 1
jtest(mymod1, mymod2)

## Davidson & MacKinnon's "encompassing test". Puts both models
## into a bigger model, then uses a Wald test to see if either should
## be removed.
## encomptest(mymod1, mymod2)
