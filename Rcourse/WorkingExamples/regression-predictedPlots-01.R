## Paul Johnson
## some miscellaneous regression plots  poking and soaking
## 2013-04-21

## I see now that student users are confused about R's predict.

## Synopsis. With R functions, here is what you do.

## Step 1. Fit a regression model.
## Step 2. Create a "newdata" data frame
## Step 3. Run predict using the newdata data frame.

## I'll demonstrate that a few times below.

## There are a number of helper functions that try to make this more
## automatic.  The most famous helper is abline. When users run

## m1 <- lm(y ~ x, data = dat)
## plot(y ~ x, data = dat)
## abline(m1)

## "Under the hood," abline is doing Step 2 and Step 3 for
## you. That is a wonderful convenience, but bad for the
## learning process. It does not work with nonlinear
## models, it does not work when there are more predictors.

## My rockchalk package has functions to help with this--
## examples below.

## Along with the R package, the function termplot is the most useful
## regression plotter.  If you did not try it before, some examples
## are offered below.  termplot does not work with models that have
## interactions and it also fails for some nonlinear formulae. That
## started me working on plotSlopes 2 years ago. rockchalk!

## I'll start by fabricating some data.
## As always, N is sample size. To see what's going on,
## leave N small, say 100. But you'll want to come back and
## make it bigger when you see how badly some of these regressions
## fit when there are only 100 cases. I don't mean small R-square
## I men bad slope estimates.
N <- 100
set.seed(234234)
x1 <- runif(N, min = 50, max = 150)
x2 <- rnorm(N, m = 100, sd = 30)
x3 <- rpois(N, lambda = 18)

## We want a categorical variable as well.  In the olden days of SAS,
## I'd create a numeric variable, and then turn it into 0 and 1
##
x4numeric <- rnorm(N)

## x4dummy is numeric, but only 0 and 1
x4dummy <- ifelse( x4numeric < 0, 0, 1)

## The R team wishes we would not treat the qualitative
## variable a numeric 0 or 1. We instead need a factor.

## If we need that to be a factor, there are several ways
## we could do it. I think the most direct is to just
## create a factor in the first place with cut()

x4f1 <- cut(x4numeric, breaks = c(-100, 0, 100), labels =
            c("low","high"))

## I think many people would just use the factor command to
## convert x4dummy, however

x4f2 <- factor(x4dummy, labels = c("low", "high"))

## Look at those side by side, they are the same
table(x4f1, x4f2)

table(x4f1, x4dummy)


## now an error term
stde <- 500
err1 <- rnorm(N, mean = 0, sd = stde )
## That would be same as
# err1 <- stde * rnorm(N)

dat <- data.frame(x1, x2, x3, x4dummy, x4f1, x4f2)

## Manufacture an output variable, using the numeric
dat$y <- with(dat, 10 + 4 * x1 + 11 * x2 - 11.1 * x3  - 5 * x4dummy +   err1)
## clean up the workspace
rm(x1, x2, x3,  x4dummy, x4f1, x4f2)

mytitle <- paste("Phony data for", expression(10 + 4 * x1 + 11 * x2 - 11.1 * x3 - 5 * x4dummy + err))
plot(y ~ x1, data = dat, main = mytitle , type="n")
points(y ~ x1, data = dat, col = as.numeric(dat$x4f1), pch=16, cex=.8)
legend( 1*min(dat$x1), max(dat$y), levels(dat$x4f1), title = "x4",  col = c(1,2), pch = 16, pt.cex = 0.6)

mymod1 <- lm(y ~ x1 + x2 + x3 +  x4f1, data = dat)

summary(mymod1)



plot(y ~ x1, data = dat, main = "Bad abline soon to appear here")

## this creates silly output now:
abline(mymod1)
## Warning message:
## In abline(mymod1) : only using the first two of 5 regression coefficients


## Look what R's predict function does:
## one row for each row in input data

mymod1fit <- predict(mymod1)
cbind(mymod1fit, dat)

## But I don't want all of those predictions. I just want predictions
## for some cases, some interesting ones. Maybe for the average case.


## The termplot function is built into R, it can help
op <- par(no.readonly = TRUE)
par(mfcol=c(2,2))
termplot(mymod1, partial.resid = TRUE, ask = FALSE)
par(op)

## or ask for one termplot
termplot(mymod1, partial.resid = TRUE, ask = FALSE, terms = c("x2"))


## As I mentioned, termplot does not work in some cases,
## and so we need to do a little inspecting to see how steps 1-2-3
## would be conducted.

## I need a new data frame with values for all predictors is
## required. How to get?

## nd1 = newdata example 1

## Manually assemble example values for x1.  set all the other
## predictors at particular values
nd1 <- data.frame( x1 = quantile(dat$x1))
nd1$x2 <- mean(dat$x2, na.rm =TRUE)
nd1$x3 <- mean(dat$x3, na.rm = TRUE)
nd1$x4f1 <- factor(c("high"))
nd1

## In rockchalk 1.8, there's a function to do that automatically
## for any regression. Look for newdata().

## Can put prediction into data frame now
nd1$fit <- predict(mymod1, newdata = nd1)

## If we ask for interval, the output is a matrix with 3 columns
predict(mymod1, newdata = nd1, interval = "confidence")

## I prefer to rename columns and insert to data frame
m1p1 <- predict(mymod1, newdata = nd1, interval = "confidence")
colnames(m1p1) <- paste("m1p1", colnames(m1p1), sep = "")
## Can add that do nd1
nd1 <- cbind(nd1, m1p1)


## That's a bit of a hassle, the expand.grid function can
## facilitate if you want to mix and match more easily.
## It allows us to mix in more values. Try this.

nd2 <- expand.grid( x1 = quantile(dat$x1), x2 = quantile(dat$x2),
                   x3 = mean(dat$x3, na.rm =TRUE), x4f1 = levels (dat$x4f1))

## appends fitted value to the nd2 data frame.
nd2$fit <- predict(mymod1, newdata = nd2)

## Can you explain why this plot is useless?
plot(y ~ x1, data = dat, main = "Why is lines so awful?")
lines(fit ~ x1, data = nd2)

## Look at nd2, I mean really study it.


## But not so bad if  you use nd1
plot(y ~ x1, data = dat)
lines(fit ~ x1, data = nd1)
## look at nd1, see how it is less troublesome?


## The newdata() and predictOMatic() functions in rockchalk are
## supposed to help with this
library(rockchalk)
mymod2 <- lm (y ~ x1 * x4f1 + x2 + x3, data=dat)
summary(mymod2)

## Those rockchalk functions use my newdata and predictOMatic
## functions in the background,
## making plots like this that work

## If running interactively, try this to get a fresh device
## dev.new()
plotSlopes(mymod1, plotx = "x1",  modx = "x4f1")
plotSlopes(mymod2, plotx = "x1",  modx = "x4f1")

## Catch the output, you'll see what I mean
m2ps <- plotSlopes(mymod2, plotx = "x1",  modx = "x4f1")
m2ps

## plotSlopes is only for linear equations, but
## plotCurves works just as well for linear and nonlinear
## equations.

plotCurves(mymod2, plotx = "x1",  modx = "x4f1")

## The only reason to  prefer plotSlopes is that it has
## the associated testSlopes method, which is interesting.
testSlopes(m2ps)

## With a numeric interaction, that can be fun.
dat$y2 <- dat$y + 0.4 * dat$x1 * dat$x2

mymod3 <- lm (y2 ~ x1 * x2 + x4f1 + x3, data=dat)
summary(mymod3)

m3ps <- plotSlopes(mymod3, plotx = "x1",  modx = "x2")
m3ps
m3psts <- testSlopes(m3ps)
plot(m3psts)

## Now try termplot

termplot(mymod2)
## Unless something has changed, you will see the same error I do:

## Warning in termplot(mymod2) :
##  'model' appears to involve interactions: see the help page
## Error in `[.data.frame`(mf, , i) : undefined columns selected


## This used to cause an error, now does not
myproblem1 <- lm (y ~ x1 * x4dummy, data = dat)
plotSlopes(myproblem1, modx="x4dummy", plotx="x1")

## Create a more interesting factor variable
## This new one has 4 levels.
dat$x5fac <- cut(rnorm(N), c(-10,-1.5, 0, .6, 10),
                 labels = c("frozen", "cold", "luke", "hot"))
table(dat$x5fac)

## You'll see there is some
## gyration I go through to put that into the model. While
## the factor variable is perfectly good for fitting the regression,
## we have to do some fancy footwork to turn that into numeric
## dummy variables which can be added and multiplied and whatnot.

## Look, 3 columns of 0's and 1's
(x5dummies <- contrasts(dat$x5fac)[dat$x5fac, ])

stde <- 400
## No interaction, yet. Just categorical x5, with coefficients
dat$ynew <- 220 + 15.3* dat$x1 +
    10 * dat$x2 + x5dummies %*% c(11, -12, 23) + stde * rnorm(N)


m3.1 <- lm (ynew ~ x1 + x5fac + x2, data = dat)
summary(m3.1)

## Fit the wrong model? See what happens
m3.2 <- lm (ynew ~ x1 * x5fac + x2, data = dat)
summary(m3.2)

## Now incorporate multiplicative interactions
dat$ynew2 <- dat$ynew +  dat$x1 * x5dummies %*% c(-5.2, 7.4, 1.1)

m3.3 <- lm (ynew2 ~ x1 * x5fac + x2, data = dat)
summary(m3.3)

## WOW. Weird how hard to relate the estimates
## to the "true" coefficients. You have to concentrate :)

## Let's manufacture an outcome variable with less
## noise in it. 
stde <- 100
## We'll throw in the dummy variable effects and the
## interaction effects in one command.
dat$ynew3 <- 220 + 15.3* dat$x1 +
    10 * dat$x2 + x5dummies %*% c(11, -12, 23) +
     dat$x1 * x5dummies %*% c(-5.2, 7.4, 1.1) +
    stde * rnorm(N)

## fit the whole thing in one model, again
m4 <- lm (ynew3 ~ x1 * x5fac + x2, data = dat)
summary(m4)

ps2 <- plotSlopes(m4, plotx = "x1",  modx = "x5fac")

## In rockchalk 1.7, there's a function to get all the
## mix and match values of the predictors. 
(nd <- newdata(m4, predVals = "auto"))
nd$fit <- predict(m4, nd)
nd


## Functions in the car package that some people
## like. They are very well documented in the books
## by John Fox, Applied Regression and the Companion
## to Applied Regression
library(car)

avPlots(mymod1)

crPlots(mymod1)
termplot(mymod1, partial.resid=TRUE, terms="x1")

avPlots(mymod2)
## following causes an error
crPlots(mymod2)



