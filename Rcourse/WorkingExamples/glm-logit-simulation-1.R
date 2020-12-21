## Title: logit-simulation-1
## Author: Paul Johnson <pauljohn at ku.edu>
## Date posted: 2006-03-08
## Description. Creates a dichotomous dependent variable.
## Estimates a logistic regression.

N <- 1000
A <- -1
B <- 0.3


x <- 1 + 10 * rnorm(N)
eta <- A + B * x

pi <- exp(eta)/(1+exp(eta))

## Here's one way
myunif <- runif(N)
y <- ifelse(myunif < pi, 1, 0)

## Here's another way that is more like R, less like
## a guy who doesn't know about R
y2 <- rbinom(N, size = 1, prob = pi)

## Here's the way my friends in Economics would do it.
y3 <- rlogis(N) < eta

plot(x, y, main=bquote( eta[i] == .(A) +   .(B) * x[i] ))

text ( 0.5*max(x), 0.5, expression( Prob( y[i] == 1) == frac( 1 , 1 + exp(-eta[i] ))))


myglm1 <- glm ( y ~ x, family=binomial(link="logit") )
summary(myglm1)

termplot(myglm1)

library(effects)
alleff<- all.effects(myglm1)

plot(alleff)


## Just for fun....

myglm2 <- glm(y~x, family=quasibinomial)
summary(myglm2)



### Mixed model: random intercept with large variance

eta <- A + B * x + 5 * rnorm(N)
pi <- exp(eta)/(1+exp(eta))
myunif <- runif(N)
y <- ifelse(myunif < pi, 1, 0)

plot(x,y, main=bquote( eta[i] == .(A) +   .(B) * x[i] + u[i]))

text ( 0.5*max(x), 0.5, expression( Prob( y[i] == 1) == frac( 1 , 1 + exp(-eta[i] ))))

### Parameter estimates go to hell, as expected
myglm3 <- glm ( y ~ x, family=binomial(link="logit") )
summary(myglm3)

### Why doesn't quasibinomial show more evidence of the random intercept?
myglm4 <- glm(y~x, family=quasibinomial)
summary(myglm4)

## Am on thin ice here.  The extra variance in the model isn't
## an identifiable effect, the estimation process itself forces
## the variance to 1.  Thus the slope coefficient is "squished"
## in an understandable way.

## TODO: I need to introduce "clustering" with the random effect
## so I can fit this with a generalized linear mixed model.

