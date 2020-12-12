## Paul Johnson
## 2018-10-24

## I was desperate for some count data and first one
## I found in CRAN was about goals scored in soccer.
## After that I found the COUNT package which has many more
## data sets.

## The goals data is from the R package "GWRM"

fn <- "goals.rds"
ddir <- "../data"
goals <- readRDS(file.path(ddir, fn))

kutils::peek(goals)

m1 <- glm(goals ~ position, data = goals, family = poisson)
summary(m1)

## Interesting way to see how model is fitting
library(COUNT)
poi.obs.pred(10, m1)


## overdispersion
## 1. Look at residual deviance compared to DF
## 2. sum of squared pearson residuals
m1.p.resids <- residuals(m1, type="pearson")
test.stat <- sum(m1.p.resids^2)
test.stat
pchisq(test.stat, m1$df.residual, lower.tail=FALSE)
## 3. dispersion test in AER package
library(AER)
dispersiontest(m1, trafo=2)


library(rockchalk)
(m1.plink <- predictOMatic(m1, type = "link"))

(m1.presp <- predictOMatic(m1, type = "response"))
## recover response from link
exp(m1.plink$position$fit)


library(MASS)
m2 <- glm.nb(goals ~ position, data = goals)
summary(m2)

m2.p.resids <- residuals(m2, type="pearson")
test.stat <- sum(m2.p.resids^2)
test.stat
pchisq(test.stat, m1$df.residual, lower.tail=FALSE)
nb2.obs.pred(10, m2)




## Offset model for rate of goals per game

m3 <- glm(goals ~ position + offset(log(played)),
          data = goals, family = poisson)
summary(m3)
dispersiontest(m3, trafo=2)

m4 <- glm.nb(goals ~ position + offset(log(played)),
          data = goals)
summary(m4)
