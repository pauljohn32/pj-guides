## Paul Johnson
## 2013-04-01
## regression-doublelog-1.R

## Question. What do you get when you "log both sides" of a
## regression model?

## In economics and biology, the double-log model is very
## common. It describes an interactive, multiplicative process.
##
## With just one predictor, the theory is
##      y = b0 * x^b1 * exp(e)
## where I wish I could add subscripts on y, x, and e.
## Using the rules of logs, that simplifies to the linear
## model. If there were predictors x1,x2, and so forth,
## they would be added as additional multiplicative terms
## with exponents.

## Recall the log laws
## 1. log(x^b1) = b1 * log(x)
## 2. log(c*d) = log(c) + log(d)

set.seed(123123)
dat <- data.frame( x = runif(1000))
## The 3 parameters are b0, b1, and stde
b0 <- 0.1
b1 <- 1.2
stde <- 2
dat$y <- b0 * dat$x^(b1) * exp(rnorm(1000, m = 0, s = stde))

plot(y ~ x, data = dat, main="No Apparent Relationship?")
## Interesting. Looks like nothing.

m0 <- lm(y ~ x, data = dat)
summary(m0)


## One of the usual transformations we try is the log, which
## is justified either by idea of changing a "skewed" variable to
## a more normal one, or by the desire to fit the interactive
## model above.

## Test out plot's built-in antilogger
plot(y ~ x, data = dat, log = "xy")
## Better fix the labels, urgently
plot(y ~ x, data = dat, log = "xy", xlab = "log(x)", ylab = "log(y)")

## Previous same as this, this is more usual to the way I would do this:
plot(log(y) ~ log(x), data = dat)


m1 <- lm(log(y) ~ log(x), data = dat)
summary(m1)


abline(m1, col = "red")

## The challenge of interpretation is to get predicted
## values in a scale that interests us.


## I notice termplot does the same thing that rockchalk::plotCurves
## will do
termplot(m1, partial = TRUE, se = TRUE)

library(rockchalk)


## needs version 1.7.2 or newer
m1pc <- plotCurves(m1, plotx = "x", interval = "conf")

## if your rockchalk is not on the development path, can still
## construct that manually. Here's how
nd <- data.frame(x = plotSeq(dat$x, 40))
pdat <- predict(m1, newdata = nd, interval = "conf")
head(pdat)

nd <- cbind(nd, pdat)
nd

plot(log(y) ~ x, data = dat, col = gray(.7))
lines(fit ~ x, data = nd, col = "red")
lines(lwr ~ x, data = nd, col = "red", lty = 2)
lines(upr ~ x, data = nd, col = "red", lty = 2)

## I really want to plot this in the (x,y) plane
## not the log(x) or log(y). Here's an easy way
## using the results from before.


nd$ypred <- exp(nd$fit)
head(nd)

titl <- "double-log regression in x,y space"
plot(y ~ x, data = dat, col = gray(.8), main = titl)
lines(ypred ~ x, data = nd, col = "red", lwd = 2)

## The student can go back to the beginning and
## change the coefficients to see how these plots
## might change.



