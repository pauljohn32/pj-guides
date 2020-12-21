## Paul E. Johnson
## 2014-09-18

## Here's a puzzle I presented to our group this week.

## Generate data like so

set.seed(234234)
dat <- data.frame(x1 = rnorm(100, m = 50, sd = 40), x2 = gl(4, 25,
labels = c("l", "m", "h", "s")), x3 = rgamma(100, 1, 2))
dat$y <- rpois(100, lambda = exp(0.005 + 0.014 * dat$x1 - 0.1 * dat$x3))
m1 <- glm(y ~ x1 + x2 + x3, data = dat, family = "poisson")
m2 <- glm(y ~ x1, data = dat, family = "poisson")


## Exercises

## 1. Make a plot demonstrating the relationship between x1 and y,
## including the predicted values from both m1 and m2.

## 2. Suppose you want to plot the predicted value of y, for each
## categorical value of x2.  What would you do?


## 2A. What is the difference between

predict(m1)

## and

predict(m1, type = "response")

## 2B. What is the difference between

predict(m1, type = "response")

## and

predict(m2, type = "response")


## 3. What's wrong with this approach?

pred1 <- predict(m1)
plot(pred1 ~ dat$x1, type = "l")

## 4. What's wrong with this approach?

dat <- dat[order(dat$x1), ]
m1 <- glm(y ~ x1 + x2 + x3, data = dat, family = "poisson")
pred2 <- predict(m1)
plot(y ~ x1, data = dat)
lines(pred2 ~ x1, data = dat)

## 5. What's wrong with this approach?

library(rockchalk)
nd <- newdata(m1, predVals = c("x1"), n = 20)
nd$pred <- predict(m1, nd)
plot(y ~ x1, data = dat)
lines(pred ~ x1, data = nd)

## 6. Can you make a pleasant looking regression table for m1 and m2?
## If not, try R packages that can like memisc, texreg, stargazer,
## apsrtable, rockchalk, or ...

## 7. More advanced: what's the problem with getting confidence
## intervals on that predicted value line?

## Can you explain why I feel like a cheater when I wrote this function?

plotSlopes(m1, plotx = x1, interval = "conf")

## If you did not ever try to work with predicted value plots, I
## eagerly suggest you try it.






## Now, my answers
## 1. Make a plot demonstrating the relationship between x1 and y,
## including the predicted values from both m1 and m2.

## m2 is easy. Do that first
m2nd <- newdata(m2, predVals = list(x1 = "quantile"), n = 30)
m2nd$fit <- predict(m2, newdata = m2nd, type = "response")

plot(y ~ x1, data = dat, col = "gray70")
lines(fit ~ x1, data = m2nd)


## Perhaps it is more clear to look at it like this
plot(y ~ x1, data = dat, col = "gray70")
lines(fit ~ x1, data = m2nd, type = "b")
title("30 quantile-spaced values of x1")


## Obvious problem: What values of x1 should be used? 30 quantiles?

m2nd2 <- newdata(m2, predVals = list(x1 = "seq"), n = 30)
m2nd2$fit <- predict(m2, newdata = m2nd2, type = "response")
plot(y ~ x1, data = dat, col = "gray70")
lines(fit ~ x1, data = m2nd2, type = "b")
title("Evenly spaced values of x1")





## Obvious problem. What values are to be supposed for x2 and x3?
m1nd <- newdata(m1, predVals = list(x1 = "quantile", x2 = levels(dat$x2)), n = 20)
m1nd

## See the problem?:
m1nd$fit <- predict(m1, newdata = m1nd, type = "response")
text(m1nd$x1, m1nd$fit, labels = as.character(m1nd$x2))


plot(y ~ x1, data = dat, col = "gray70")
mycol <- gray.colors(4, start = 0.3, end = 0.6)
x2levels <- levels(m1nd$x2)
for(i in seq_along(x2levels)){
    lines(fit ~ x1, data = m1nd[m1nd$x2 %in% x2levels[i], ], lty = i + 1, col = mycol[i], lwd = 2)
}
lines(fit ~ x1, data = m2nd)
legend("topleft", legend = c("Model 2", paste("Model 1: x2 =", x2levels)), col = c(1, mycol), lty = 1:5, lwd = 2) 

## The rockchalk package has a short-cut function for most of this work, but it won't integrate
## m1 and m2 for us.


## ## 4. What's wrong with this approach?

## dat <- dat[order(dat$x1), ]
## m1 <- glm(y ~ x1 + x2 + x3, data = dat, family = "poisson")
## pred2 <- predict(m1)
## plot(y ~ x1, data = dat)
## lines(pred2 ~ x1, data = dat)

## Answer: 
## Predicted values are calculated for each row in the data. The
## plot looks/is wrong because we have not controlled for x2 and x3
## in the calculation of the predicted values for plotting.




## ## 5. What's wrong with this approach?

## library(rockchalk)
## nd <- newdata(m1, predVals = c("x1"), n = 20)
## nd$pred <- predict(m1, nd)
## plot(y ~ x1, data = dat)
## lines(pred ~ x1, data = nd)

## Answer:
## That's almost right. Inspect nd, see it has adjusted x2 and x3.
## However, the predict statement needs type = "response"


library(rockchalk)
nd <- newdata(m1, predVals = c("x1"), n = 20)
nd$fit <- predict(m1, nd, type = "response")
plot(y ~ x1, data = dat)
lines(fit ~ x1, data = nd)

## do you want various predictive lines?

plotCurves(m1, plotx = "x1", modx = "x2")

##
##
## Now, I want to take you on 2 detours.

## Detour 1. Plot predictions by quantile.

## Lets just ask for 5 values 

nd2 <- newdata(m1, predVals = list(x1 = "quantile", x2 = "l"), n = 5)
nd2$fit <- predict(m1, nd2, type = "response")

par.orig <- par(no.readonly = TRUE)
par(mfcol = c(2,1))

plot(y ~ x1, data = dat, col = "gray70")
lines(fit ~ x1, data = nd2, type = "b")

nd2$q1 <- c("min", "25%", "median", "75%", "max")
nd2$q2 <- 1:5


plot(fit ~ q2, data = nd2, type = "b", xlab = "x1 quantiles", axes = FALSE)
axis(2)
axis(1, at = nd2$q2, labels = nd2$q1)
box(bty = "L")

par(par.orig)


## If x1's distribution is less symmetric,the problem is exaggerated

set.seed(234234)
dat2 <- data.frame(x1 = 1.5 *  rgamma(100, shape = 2, scale = 18.3),
                  x2 = gl(4, 25, labels = c("l", "m", "h", "s")),
                  x3 = rgamma(100, 1, 2))
dat2$y <- rpois(100, lambda = exp(0.005 + 0.014 * dat2$x1 - 0.1 * dat2$x3))

summary(dat)
summary(dat2)

hist(dat2$x1)

m1.2 <- glm(y ~ x1 + x2 + x3, data = dat2, family = "poisson")



nd3 <- newdata(m1.2, predVals = list(x1 = "quantile", x2 = "l"), n = 5)
nd3$fit <- predict(m1.2, nd3, type = "response")


par(mfcol = c(2,1))

plot(y ~ x1, data = dat2, col = "gray70")
lines(fit ~ x1, data = nd3, type = "b")

nd3$q1 <- c("min", "25%", "median", "75%", "max")
nd3$q2 <- seq(min(nd3$x1), max(nd3$x1), length.out = 5)

plot(fit ~ q2, data = nd3, type = "b", xlab = "x1 quantiles", axes = FALSE, col = "gray70")
axis(2)
axis(1, at = nd3$q2, labels = nd3$q1)
box(bty = "L")
lines(fit ~ q2, data = nd3, type = "b")
par(par.orig)


## What are the dangers here?

## Why might one want to do this?  



## Detour 2. What if the data has only 2 or 3 unique values of a predictor?


set.seed(234234)
dat <- data.frame(x1 = rnorm(100, m = 50, sd = 40),
                  x2 = gl(4, 25, labels = c("l", "m", "h", "s")),
                  x3 = rgamma(100, 1, 2))
dat$x1f <- cut(dat$x1, c(-100, 50, 80, 200), labels = c("low", "med", "high"))
dat$x1n <- as.numeric(dat$x1f)
dat$y <- rpois(100, lambda = exp(0.005 + 0.014 * dat$x1 - 0.1 * dat$x3))

m1 <- glm(y ~ x1n + x2 + x3, data = dat, family = "poisson")
summary(m1)

nd4 <- newdata(m1, predVals = list(x1n = "quantile", x2 = "l"), n = 5)
nd4$fit <- predict(m1, newdata = nd4, type = "response")
nd4

plot(fit ~ x1n, data = nd4, type = "b")

## Question: Should newdata refuse to give back more possible values of
## x1n than there actually are?


## I'll fake it by manufacturing data points at 1.5 and 2.5
x1quant <- quantile(dat$x1n)
nd5 <- expand.grid(x1n = seq(1, 3, length.out = 5), x2 = "l", x3 = mean(dat$x3))
nd5$fit <- predict(m1, newdata = nd5, type = "response")
nd5

plot(fit ~ x1n, data = nd5, type = "b", xlab = "phony (?) x1 quantiles", axes = FALSE)
axis(2)
axis(1, at = nd5$x1n, labels = nd5$q1)
box(bty = "L")



## ## 7. More advanced: what's the problem with getting confidence
## ## intervals on that predicted value line?

## ## Can you explain why I feel like a cheater when I wrote this function?

## plotSlopes(m1, plotx = x1, interval = "conf")

## ## If you did not ever try to work with predicted value plots, I
## ## eagerly suggest you try it.

## Answer:

## Those calculations rely on a very simplistic "Wald approximation"
## to calculate confidence intervals on predictions. These are also
## supported in SAS, but the literature is generally calling for more
## elaborate methods none of which are easily available.


## Withers, Christopher S. and Saralees Nadarah. 2012. Improved
## confidence regions based on Edgeworth expansions. Computational
## Statistics and Data Analysis 56: 4366-4380.

## "The number of papers proposing confidence regions is too many to
## cite. Confidence regions can be constructed using many different
## methods. Some of these involve: the exact distribution theory,
## asymptotic chi-square distributions, asymptotic normal distributions,
## record values, bootstrapping, empirical likelihood method, likelihood
## ratio statistics, Bayesian test statistics, sign based test
## statistics, rank based test statistics, differential geometric
## frameworks, jackknife, least square statistics, sequential methods,
## Monte Carlo likelihood methods, adaptive estimation methods, the M
## estimation theory, empirical Bayes, calibration methods, score
## statistics, quadratic approximations, subsampling methods, Gibbs
## sampling methods, smoothing methods (for example, polynomial splines,
## kernel type smoothing, local adaptive smoothing and Granulometric
## smoothing), Kolmogorov–Smirnov statistics, highest posterior density
## methods, R estimation methods, stochastic inequalities (for example,
## Hajek–Rényi type inequalities), multiple comparison methods, maximum
## modulus methods, minimum area confidence methods, U statistics, Rényi
## statistics and statistics based on other entropy measures, generalized
## p values, James–Stein type statistics, power divergence statistics,
## importance sampling methods, Uusipaikka’s method, genetic algorithms
## and uniform minimum variance unbiased statistics."

## See also:

## King, Gary, Michael Tomz, and Jason Wittenberg. 2000. Making the Most
## of Statistical Analyses: Improving Interpretation and
## Presentation. American Journal of Political Science 44: 341–355

## Sun, J., Loader, C., & William P., M. (2000). Confidence bands in
## generalized linear models. The Annals of Statistics, 28(2),
## 429–460. doi:10.1214/aos/1016218225

## Xu, Jun and J. Scott Long (2005) Confidence intervals for predicted outcomes in
## regression models for categorical outcomes. Stata Journal 5(4): 537-559.




## 6. Can you make a pleasant looking regression table for m1 and m2?
## If not, try R packages that can like memisc, texreg, stargazer,
## apsrtable, rockchalk, or ...


varLabs <- c(x1 = "Flowers", x2l = "x2: low", x2m = "x2: medium",
             x2h = "x2: high", x2s = "x2: super", x3 = "Nearly Forgot x3's super long label")
outreg(list("Model 1" = m1, "Model 2" = m2),  varLabels = varLabs, type = "html")
