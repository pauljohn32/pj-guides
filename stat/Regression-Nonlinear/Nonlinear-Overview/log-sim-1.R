## Paul Johnson
## 2015-04-01

## Lets generate some data that has the "true" model
## y = b0 + b1 log(x) + e
##
## And then see how well we can detect that.


set.seed(234234)
b0 <- 40; b1 <- -0.05; stde <- 50

enorm <- rnorm(1000, m = 0, sd = 1)

e <- stde * enorm ## same as rnorm(1000, m = 0, sd = stde)
x <- runif(1000, min = 20, max = 800)
y <- b0 + b1 * log(x) + e

dat <- data.frame(x, y, e)
rm(x, y, e)


plot(y ~ x, dat)



m1 <- lm(y ~ x, data = dat)
summary(m1)

m2 <- lm(y ~ log(x), data = dat)
summary(m2)

summary(m1)$r.square < summary(m2)$r.square
plot(m1)


m3 <- lm(y ~ poly(x, 2), data = dat)
summary(m3)

library(rockchalk)
m1pc <- plotCurves(m1, plotx = "x", interval = "confidence", main = "Linear Model")
m2pc <- plotCurves(m2, plotx = "x", interval = "confidence", main = "log Model")
m3pc <- plotCurves(m3, plotx = "x", interval = "confidence", main = "Quadratic Model")

plotCurves(m1, plotx = "x", interval = "confidence", main = "Linear Model")
lines(fit ~ x, m2pc$newdata, col = "red")
lines(fit ~ x, m3pc$newdata, col = "green")

plot(m2pc$newdata$fit ~ m3pc$newdata$fit)

plotCurves(m1, plotx = "x", interval = "confidence", main = "Linear Model", ylim = c(38, 44))
lines(fit ~ x, m2pc$newdata, col = "red")
lines(fit ~ x, m3pc$newdata, col = "green")



e2 <-  0.5*stde * enorm
dat$y2 <- b0 + b1 * log(dat$x) + e2


m11 <- lm(y2 ~ x, data = dat)
summary(m11)
m12 <- lm(y2 ~ log(x), data = dat)
summary(m12)
m13 <- lm(y2 ~ poly(x,2), data = dat)
summary(m13)




## Experiment tuning up b1
## b1 <- 0.05  
b1 <- -5.5;
b1 <- -50;

e2 <-  0.5*stde * enorm
dat$y3 <- b0 + b1 * log(dat$x) + e2


m21 <- lm(y3 ~ x, data = dat)
summary(m21)

m22 <- lm(y3 ~ log(x), data = dat)
summary(m22)

m23 <- lm(y3 ~ poly(x, 2), data = dat)
summary(m23)


m21pc <- plotCurves(m21, plotx = "x")
m22pc <- plotCurves(m22, plotx = "x")
m23pc <- plotCurves(m23, plotx = "x")


plot(m21)
plot(m22)
plot(m23)

m21pc <- plotCurves(m21, plotx = "x")
lines(fit ~ x, m22pc$newdata, col = "green", lwd = 3)
lines(fit ~ x, m23pc$newdata, col = "red", lwd = 4)






## What if range of x is shorter?

## Before I had this:
## x <- runif(1000, min = 20, max = 800)

## Now take
dat$x <- runif(1000, min = 1, max = 10)

b1 <- -50;

e2 <-  0.5*stde * enorm
dat$y3 <- b0 + b1 * log(dat$x) + e2


m31 <- lm(y3 ~ x, data = dat)
summary(m31)

m32 <- lm(y3 ~ log(x), data = dat)
summary(m32)

m33 <- lm(y3 ~ poly(x, 2), data = dat)
summary(m33)


m31pc <- plotCurves(m31, plotx = "x")
m32pc <- plotCurves(m32, plotx = "x")
m33pc <- plotCurves(m33, plotx = "x")


plot(m31)
plot(m32)
plot(m33)

m31pc <- plotCurves(m31, plotx = "x")
lines(fit ~ x, m32pc$newdata, col = "green", lwd = 3)
lines(fit ~ x, m33pc$newdata, col = "red", lwd = 4)



## Maybe less noise, smaller coefficient?
b1 <- -20;

e3 <-  0.25*stde * enorm
dat$y4 <- b0 + b1 * log(dat$x) + e3


m41 <- lm(y4 ~ x, data = dat)
summary(m41)

m42 <- lm(y4 ~ log(x), data = dat)
summary(m42)

m43 <- lm(y4 ~ poly(x, 2), data = dat)
summary(m43)


m41pc <- plotCurves(m41, plotx = "x")
m42pc <- plotCurves(m42, plotx = "x")
m43pc <- plotCurves(m43, plotx = "x")


plot(m41)
plot(m42)
plot(m43)

m41pc <- plotCurves(m41, plotx = "x")
lines(fit ~ x, m42pc$newdata, col = "green", lwd = 3)
lines(fit ~ x, m43pc$newdata, col = "red", lwd = 4)
