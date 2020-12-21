## Paul Johnson
## 2013-09-21

## 1. Explore a regression with interation and nonlinearity

library(rockchalk)
set.seed(832345)
N <- 500

dat <- genCorrelatedData2(N = N, means = c(50, 50, 50), sds = rep(10, 3),
                          rho = 0.2, beta = c(300, 0.7, 3, 3, -0.15),
                          stde = 400)

dat$xcat1 <- factor(sample(c("left", "right"), N, replace = T, prob = c(0.4, 0.6)))
dat$xcat2 <- cut(rnorm(N), breaks = c(-Inf, 0, 0.4, 0.9, 1, Inf),
                  labels = c("R", "M", "D", "P", "G"))

dat$y <- dat$y + 2.2*  contrasts(dat$xcat1)[dat$xcat1] - .08 * dat$x1^2 * contrasts(dat$xcat1)[dat$xcat1]  + contrasts(dat$xcat2)[dat$xcat2, ] %*% c(-0.1, 1.1, 0, -0.4)


## The true model
## y ~ 300 + 0.9 x1 + 3 x2 + 3 x3 - 0.15 x1^2 + 2.2 xcat1 - 0.1 x1^2 * xcat1
##             - 0.1 x2catM +  1.1 x2catD +  0 x2catP - 0.4 x2catG
##             + rnorm(0, 200) 


##
m0 <- lm (y ~ x1 + x2 + x3, data = dat)
summary(m0)


m1a <- lm (y ~ x1*x2 + x3, data = dat)
summary(m1a)
m1apc <- plotCurves(m1a, plotx = "x1", modx = "x2", ylim = 1.2 * range(dat$y))

m1b <- meanCenter(m1a)
summary(m1b)
m1bpc <- plotCurves(m1b, plotx = "x1c", modx = "x2c", ylim = 1.2 * range(dat$y))


m1c <- residualCenter(m1a)
summary(m1c)
m1cpc <- plotCurves(m1c, plotx = "x1", modx = "x2", ylim = 1.2 * range(dat$y))


m1pr <- data.frame(m1a = predict(m1a), m1b = predict(m1b), m1c = predict(m1c))

plot(m1pr$m1a, m1pr$m1b, main = "m1a, m1b, m1c: Same predicted values", col = "red", cex = 1.5, xlab = "predicted by interaction (m1a)", ylab = "predicted by centered models")
points(m1pr$m1a, m1pr$m1c, cex = 0.75)
legend("topleft", legend = c("mean centered (m1b)", "residual centered (m1c)"), pch = c(1, 1),
       pt.cex = c(1, 0.75),    col = c("red","black"))

cor(m1predicted)


## Other wrong models I played with



## m2b <- meanCenter(m2a)
## summary(m2b)
## plotCurves(m2b, plotx = "x1c", modx = "xcat1", interval = "confidence")

## m2c <- residualCenter(m2a)
## summary(m2c)



## m2 <- lm (y  ~ log(x1) + x2 + x3 + xcat1, data = dat)
## summary(m2)
## plotCurves(m2, plotx = "x1", modx = "xcat1" , interval = "confidence")
## plotCurves(m2, plotx = "x1", modx = "xcat1",
##            col = c(rgb(.2, .2, .8), rgb(.9, .0, .0)), interval = "confidence")


m2 <- lm (y ~ x1 + xcat1 + x2 + x3, data = dat)
summary(m2)

plotCurves(m2a, plotx = "x1", modx = "xcat1", interval = "confidence")

## Should x1 be squared? Lets see

m2a <- lm (y ~ (x1 + I(x1*x1)) * xcat1 + x2 + x3, data = dat)
summary(m2a)
m2apc <- plotCurves(m2a, plotx = "x1", modx = "xcat1", interval = "confidence", main = "Ordinary polynomial")



m2b <- meanCenter(m2a, terms = "x1")
summary(m2b)
m2bpc <- plotCurves(m2b, plotx = "x1c", modx = "xcat1", interval = "confidence", main = "Mean-centered x1")


m2c <- lm (y  ~ poly(x1, 2) * xcat1 + x2 + x3, data = dat)
summary(m2c)
m2cpc <- plotCurves(m2c, plotx = "x1", modx = "xcat1", interval = "confidence", main = "Orthogonal Polynomial")


m2pr <- data.frame(m2a = predict(m2a), m2b = predict(m2b), m2c = predict(m2c))

plot(m2pr$m2a, m2pr$m2b, main = "m2a, m2b, m2c: Same predicted values", col = "red", cex = 1.5, xlab = "predicted by interaction (m2a)", ylab = "predicted by centered models")
points(m2pr$m2a, m2pr$m2c, cex = 0.75)
legend("topleft", legend = c("mean centered (m2b)", "residual centered (m2c)"), pch = c(1, 1),
       pt.cex = c(1, 0.75),    col = c("red","black"))

cor(m2pr)
head(m2pr)



m3a <- lm (y ~ (x1 + I(x1*x1)) * xcat1 + x2 + x3 + xcat2, data = dat)
summary(m3a)
m3apc <- plotCurves(m3a, plotx = "x1", modx = "xcat1", interval = "confidence", main = "Ordinary polynomial")

m3b <- meanCenter(m3a, terms = "x1")
summary(m3b)
m3bpc <- plotCurves(m3b, plotx = "x1c", modx = "xcat1", interval = "confidence", main = "Mean-centered x1")


m3pr <- data.frame(m3a = predict(m3a), m3b = predict(m3b))

plot(m3pr$m3a, m3pr$m3b, main = "m3a, m3b: Same predicted values", col = "red", cex = 1.5, xlab = "predicted by interaction (m2a)", ylab = "predicted by mean centered")


cor(m3pr)
head(m3pr)



## Bugs noted 2013-09-22
## no curve if no moderator
## genCorrelatedData2 calculated correctly, wrong output descriptive report






## Main point. First 5 observation rows same, rest are added.
## Works because of rockchalk::mvrnorm, which is a very slightly
## tweaked version of MASS::mvrnorm.

## Input to mvrnorm must be a MU vector and SIGMA covar matrix.
## How to make a Covar matrix?

## Try my lazyCor and lazyCov
mycor <- lazyCor(c(0.3, 0.1, 0.4, 0.2, 0.4, 0.5))
mycor

mycov <- lazyCov(tcor, Sd = c(100, 200, 300, 400))
mycov

set.seed(443244)
datM1 <- MASS::mvrnorm(5, mu = c(10, 20, 30, 10), Sigma = tcov)
datM1

set.seed(443244)
datM2 <- MASS::mvrnorm(10, mu = c(10, 20, 30, 10), Sigma = tcov)
datM2

set.seed(443244)
datM1 <- rockchalk::mvrnorm(5, mu = c(10, 20, 30, 10), Sigma = tcov)
datM1

set.seed(443244)
datM2 <- rockchalk::mvrnorm(10, mu = c(10, 20, 30, 10), Sigma = tcov)
datM2




set.seed(12345)
dat <- genCorrelatedData2(N = 10, means = c(50, 50, 50), sds = rep(10, 3),
                               rho = 0.2, beta = c(300, 1.5, 3, 3, -0.7), stde = 950)
dat

set.seed(12345)
dat2 <- genCorrelatedData2(N = 15, means = c(50, 50, 50), sds = rep(10, 3),
                               rho = 0.2, beta = c(300, 1.5, 3, 3, -0.7), stde = 950)

dat2




tWish <- rWishart(n = 100, df = 2000, Sigma = tcov)
 
