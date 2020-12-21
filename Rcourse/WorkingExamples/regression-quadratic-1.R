## Paul Johnson
## 2013-04-11
## regression-quadratic-1.R
##
## Explore quadratic regression. Explain ways to fit that in R.
## Demonstrates use of predict, newdata, and R's poly() function.
##
## From now on, anybody who wants help with quadratic regressions,
## well, has to run this through R. And read a lot of pithy comments.


## Manufacture some data.

set.seed(444532)
x3sd <- 0.5
dat <- data.frame(x1 = rnorm(200),
                  x2 = rnorm(200, s = 1),
                  x3 = rnorm(200, m = 1, s = x3sd))
b0 <- 0.4
b1 <- 0.7
b2 <- 1.5
b3 <- -0.9
b4 <- 1.4
d <- 2
stde <- 1.5
dat$y <- with(dat,
              b0 + b1 * x1 + b2 * x2 + b3 * x3 + b4 * x3^2 + rnorm(200, s = stde))

## That has a very minor curvature in it. The key coefficient
## here is b4 = 1.4, meaning we have a U-shaped curve in x3.

## Plot just the quadratic part, to get the feeling. Note the plotmath.
## Only try that on a closed course with a trained driver :)
quad <- function(x) b0 + b3 *x + b4 * x^2
curve(quad, from = -2, to = 2, xlab = "x3", ylab = substitute(y == A + B * x3 + C * x3^2, list(A = b0, B = b3, C = b4) ))


## Suppose you estimate a linear model
m0 <- lm(y ~ x1 + x2 + x3, data = dat)
summary(m0)

## Please note: just because your "p value" is "really great", it does
## not mean you have "the right" model.

## There's a little bit of nonlinearity, as in the residual plot
plot(m0, which = 1)

## Its tough to see, though.
termplot(m0, partial.resid = TRUE, terms = "x3")

## The "truth" is quadratic. We'd like to estimate
## b4, and there are many ways that this can be done.
##
## I'm going to show 4 ways, one of which is more strongly
## recommended, but, as we see, they are all really
## interchangeable.

## Method 1. The old fashioned way.
## Create a new variable x3square and insert that.
dat$x3square <- dat$x3 * dat$x3
m1 <- lm(y ~ x1 + x2 + x3 + x3square, data = dat)
summary(m1)
## I'll ask for variables one at a time so you see the problem.
## Interactively, I'd run this 
## termplot(m1, partial.resid = TRUE)
## Now, I'm in a script, and I have to do:
termplot(m1, partial.resid = TRUE, terms = "x1")
termplot(m1, partial.resid = TRUE, terms = "x2")
termplot(m1, partial.resid = TRUE, terms = "x3")
termplot(m1, partial.resid = TRUE, terms = "x3square")
## You don't see much curve because the parts of
## x3 are separated into 2 columns, each of which
## is seen as a linear element in the regression.

## While we are here, look at the predictor "design matrix":
head(model.matrix(m1, 10))


## Method 2. Technically equivalent to Method 1. We can introduce
## the squared term and R will construct the equivalent of
## x3square for us, automatically.

## Method 2a. This is the most elementary way, it is the way new
## users always want to do it.

m2a <- lm(y ~ x1 + x2 + x3 + I(x3*x3), data = dat)
## same as
## m2a <- lm(y ~ x1 + x2 + x3 + I(x3^2), data = dat)
summary(m2a)

## Look at the predictor matrix:
head(model.matrix(m2a, 10))


## Method 2b. Introduced only to
## show the poly() function.  The poly function can be "forced" to
## create same x3 and x3squared vectors by the raw = TRUE argument.
m2b <- lm(y ~  x1 + x2 + poly(x3, degree = d, raw = TRUE), data=dat)
summary(m2b)

## See? Same!
cbind(coef(summary(m2a))[, 1:2], coef(summary(m2b))[, 1:2])

## Look at the predictor matrix:
head(model.matrix(m2b, 10))



## Method 3. The R recommended method poly().
## We are recommended to use "orthogonal polynomials" instead.
## This is more numerically stable.
m3 <- lm(y ~  x1 + x2 +  poly(x3, degree = d), data=dat)
summary(m3)
termplot(m3, partial.resid = TRUE, terms = "x1")
termplot(m3, partial.resid = TRUE, terms = "x2")
termplot(m3, partial.resid = TRUE, terms = "poly(x3, degree = d)")


## Look at the predictor matrix, you see the poly() created
## 2 columns:
head(model.matrix(m3, 10))


## Hypo test rejects m0, incidentally:
anova(m3, m0, test = "F")



## Coefficients look different, but that's an illusion.
## From a given combination of (x1, x2, x3), the predictions
## are exactly the same. See?
## Predicted values are identical.
cbind(m1$fitted, m2b$fitted, m3$fitted)

## That's not all. If you check the 95% CI's on the predicted values,
## or R^2, or anything logically comparable, they'll be same.

## Some people say it is very important to "mean center"
## the quadratic term. Lets do that, show it makes no
## difference whatsoever. x3c is mean centered:
dat$x3c <- scale(dat$x3, scale = FALSE) ## mean centered
m4 <- lm(y ~  x1 + x2 +  x3c + I(x3c*x3c), data=dat)
summary(m4)
## Superficially better...

## Coefficients look different, but that's an illusion
## Predicted values are identical
head(cbind(m1$fitted, m2b$fitted, m3$fitted, m4$fitted))
## Can you explain?


## It is a known fact that the estimate of the squared term
## is the same with centered data, but the estimate of the
## linear term changes. This helps to overview that

library(memisc)
mtable(m1, m2b, m3, m4)

## Once you understand why that change happens, you will begin to see
## why poly() is so helpful.

## And, in case you wonder, this is one of the cases where x3 and x3^2
## are strongly correlated with one another.

cor(model.matrix(m1)[ ,-1])

## Note that termplot will cooperate if we type in the full
## name of the predictor from the model. Just using "x3" fails
termplot(m3, partial.resid = TRUE, terms = "poly(x3, degree = d)")

## Whereas the thing that seems "obvious" to me fails
termplot(m3, partial.resid = TRUE, terms = "x3")
## You should see the same error I do:
## Error in predict.lm(model, type = "terms", se.fit = se, terms = terms) :

## That's one of the things I've tried to fix in rockchalk's plotCurves
library(rockchalk)
plotCurves(m3, plotx = "x3")
plotCurves(m3, plotx = "x3", interval = "conf")


## It is important to get used to the R predict() family of functions.
## A regression tool is not complete unless it has one.
## And using the newdata argument in predict is really important!
## Look what goes wrong if you accidentally omit a predictor
## from a newdata object
ndf1 <- data.frame(x2 = c(1), x3 = c(2))
predict(m1, newdata = ndf1)
## fails
## Error in eval(expr, envir, enclos) : object 'x1' not found

## Now get it right
ndf2 <- data.frame(x1 = c(1), x2 = c(1), x3 = c(2))
predict(m2a, newdata = ndf2)
## succeeded

## Now, we'd like to calculate predicted values for, say, 20 values of x3, evenly
## spaced across its range. We'll leave x1 and x2 at their averages.
## That's not a difficult calcuation, but why not use the handy functions I've
## prepared for it.

predictOMatic(m3, interval = "confidence")

m1pr1 <- predictOMatic(m3, predVals = list(x3 = quantile(dat$x3, probs = seq(0,1, length.out = 20))), interval = "confidence")
m1pr1

## Wonder why that works? Here's a middle step that gives you the hint
newdata(m3, fl = list(x3 = quantile(dat$x3, probs = seq(0,1, length.out = 20))))

plot(fit ~ x3, data = m1pr1, type = "l")
lines(upr ~ x3, data = m1pr1, col = "purple", lty = 4)
lines(lwr ~ x3, data = m1pr1, col = "purple", lty = 4)
legend("topleft", legend = c("predicted","95% CI","95% CI"), lty = 4, col = "purple")

## Notice that the curves look bad, a little jagged. Can you figure
## out why?  For a hint, run this:


## I suggest users go to the beginning and fiddle the parameters. Make
## the x3sd bigger, or change b3 and b4. See what happens.

m1pr2 <- predictOMatic(m3, predVals = list(x3 = quantile(dat$x3, probs = seq(0,1, length.out = 1000))), interval = "confidence")
plot(fit ~ x3, data = m1pr2, type = "l")
lines(upr ~ x3, data = m1pr2, col = "purple", lty = 4)
lines(lwr ~ x3, data = m1pr2, col = "purple", lty = 4)
legend("topleft", legend = c("predicted","95% CI","95% CI"), lty = 4, col = "purple")

## Ooh la la, as we say in France :)


## Major points.
## 1. If the true relationship is quadratic, we may not find it unless
## we know to look for it. I have fiddled with the parameters for this
## model quite a bit.  In many cases, the anova() test is unequivocal,
## rejecting m0. But quite often, it is not powerful.
## Still, a theory that hints us to look for curvature in the effect of x3
## would be most welcome.
##
## 2. In any nonlinear model, an emphasis in the interpretation is
## analysis of predicted values. These are "marginal effects."  If x
## changes, how do we predict y changes? That requires us to use
## predict() methods in R.
##
## termplot does pretty well with these, the rockchalk::plotCurves
## function handles interactions and some nonlinearities that termplot
## does not manage.

## 3. Does it matter how we estimate these models?

## Some experts are emphatic about the need to mean-center x to
## ameliorate multicollinearity due to the similarity of x and x^2,
## but I believe that is completely wrong. Centering results in exactly
## the same predicted values, it is, literally, identical.

## Other R experts I trust strongly urge poly(x,2), not x + I(x*x) or such.
## I think there are several different reasons that people have in mind
## to justify that. I think some of the general prevention of digital
## computation round-off error have been addressed by improvements in the
## algorithms that are used to fit regressions. That's why we don't
## see a difference in the predicted values of the 4 methods.

## So students and I want to know "why do the smart people like
## poly() so much. I have finally grasped the answer, thanks to
## advice in the r-help email list in 2013.

## Gabor Grothendieck listed advantages of poly.  I'm pasting in
## his explanations and putting in example code from examples above.

##GG 1. One benefit is if you fit a higher degree polynomial using
##GG poly(x, n) the lower degree coefficients will agree with the fit using
##GG a lower n.

##PJ I can verify that. It is strictly literally true if there
## are no other predictors than the poly terms. Example:

m3 <- lm(y ~ poly(x3, degree = 2), data=dat)
m5 <- lm(y ~ poly(x3, degree = 3), data=dat)
m6 <- lm(y ~ poly(x3, degree = 4), data=dat)

mtable(m3, m5, m6)

##PJ However, if the other predictors, they are not orthogonal to the
##PJ poly() terms, so the argument breaks down a little bit:

m3c <- lm(y ~  x1 + x2 +  poly(x3, degree = 2), data=dat)
m5c <- lm(y ~  x1 + x2 +  poly(x3, degree = 3), data=dat)
m6c <- lm(y ~  x1 + x2 +  poly(x3, degree = 4), data=dat)

mtable(m3c, m5c, m6c)

## Compare to raw.
m3d <- lm(y ~  x1 + x2 +  poly(x3, degree = 2, raw = TRUE), data=dat)
m5d <- lm(y ~  x1 + x2 +  poly(x3, degree = 3, raw = TRUE), data=dat)
m6d <- lm(y ~  x1 + x2 +  poly(x3, degree = 4, raw = TRUE), data=dat)
mtable(m3d, m5d, m6d)



##GG 2. A second advantage is that the t statistics are invariant under
##GG shift if you use orthogonal polynomials.
##GG compare these two:
m3a <- lm(y ~  x1 + x2 +  poly(x3, degree = 2), data=dat)
m3b <- lm(y ~  x1 + x2 +  poly(x3+1, degree = 2), data=dat)
summary(m3a)
summary(m3b)


##PJ Great argument. It underscores the fact that mean-centering
## is an illusion. Observe:

m3c <- lm(y ~  x1 + x2 +  poly((x3 - mean(x3)), degree = 2), data=dat)

mtable(m3a, m3b, m3c)

## Mean-centering has no effect, poly() makes that plain.

## That is not true if you don;t use orthogonal polynomials,
## Compare these two:
m3d <- lm(y ~  x1 + x2 +  poly(x3, degree = 2, raw = TRUE), data=dat)
m3e <- lm(y ~  x1 + x2 +  poly(x3+1, degree = 2, raw = TRUE), data=dat)

mtable(m3d, m3e)

## Now, the answer we've all been waiting for.
## What is an orthogonal polynomial and why does it have this special
## benefit?

## I finally understood on 2013-04-01.

## Consider the quadratic equation
## y = b0 + b1 x + b2 x^2

## The slope at point x is
##
## dy
## -- = b1 + b2 x
## dx

## And, if you re-arrange that, you see that the coefficient
## b1 is the slope plus something else:

## b1 = b2 x -  dy
##             ---
##              dx

## So, when you fit the quadritic regression and estimate
## b1, you don't just get "the slope" you want, you also get
## b2 x in there, and, as a result, your estimate of b1 changes
## when you re-position your point on the x axis.

## On the other hand, the second derivative is a constant:

## d^2y
## ----   =  b2
## dx^x

## We get the same estimate of b2 no matter if we center x or
## shift it, it is the same.

## How does the poly() function fix that?  Instead of giving
## the regression 2 columns, x and x-squared, the poly function
## effectively "takes x out of x-squared" in the second column.
## When poly(x, 2) creates 2 columns, the first one is always
## proportional to x--it is just the linear part. But the second
## column has x removed, and so the 2 columns from poly() are
## completely separate. They are "orthogonal". So You could run a
## regression with the first poly() column, and then add the second
## poly() column, and the estimate from the first column would not
## change.

x3poly <- poly(dat$x3, 2)

m4a <- lm(y ~ x3poly[ ,1], data = dat)
summary(m4a)
m4b <- lm(y ~ x3poly[ ,1] + x3poly[ ,2], data = dat)
summary(m4b)

## Note, the coefficient on the first term DOES not change.
## Are you starting to see?  If you are uncertain whether to
## add a quadratic term in a regression, this is a good way
## because the estimate of the linear part does not change
## while you are testing the additional terms.

## When there are more predictors in the equation, the
## previous is not EXACTLY true, but it is ALMOST true. It is
## not exactly true because there may be a slight correlation
## between x1 and x2 and the poly terms.



## Residual Centering: How to make your own orthogonal polynomial

## If you did not have the poly() function, how could you
## achieve the same benefit?  My colleagues call this
## "residual centering" of a squared term.

## Regress x-squared on x

m5 <- lm(x3square ~ x3, data = dat)

## Take the residuals from that model. Call them x3squarerc.

dat$x3squarerc <- resid(m5)

## x3squarerc is the part of x3squared that has x3 removed.

## Note that the correlation of x3squarerc and x3 is 0, with minor
## rounding error
cor(dat$x3squarerc, dat$x3)

## But if you plot x3squarerc on x3, you see it is still
## quadratic.
plot(x3squarerc ~ x3, data = dat)

## x3squarerc is just the quadratic part of x3square, no x left.

## Now run the regression with x3 and add x3squarerc

m6 <- lm(y ~  x1 + x2 + x3, data=dat)
m7 <- lm(y ~  x1 + x2 + x3 + x3squarerc, data=dat)
mtable(m6, m7)

## The linear part is just about the same. If you fit this
## again without x1 and x2, you'll see they are exactly the same.

## The do-it-yourself residual-centering leaves x3 unchanged, only
## fiddles with x3square.  Thus, in some sense, it is easier to
## understand than poly(). poly()
## re-scales x3 so it is roughly on the same range as the quadratic part.
## This is beneficial in numerical linear algebra (computer math).
## Observe for yourself, the first poly term is just
## x3, shrunken proportionally.

plot(x3poly[, 1] ~ x3, data = dat)

## You notice that x3poly[ ,1] is mean centered:

mean(x3poly[  ,1])

summary(lm(x3poly[ ,1] ~ x3, data = dat))
## Warning message is inconsequential


## Lets create another variable, just for comparison.
newX <- data.frame(z = rnorm(1000, m = 50, sd = 10))
newX$zsquare <- newX$z^2

## Here are the summary stats.
summarize(newX)

xpol <- poly(newX$z, 2)
head(xpol, 20)
summary(xpol)

summarize(as.data.frame(xpol))
## What do I see there?  The means of both columns are
## almost exactly 0.
##
## And the variances are identical (hence standard deviations are
## identical too).
