## Paul Johnson
## 20181031

## Modeling rates and estimating rates and rate ratios;
## Replication
## http://support.sas.com/kb/24/188.html;

## SAS code is matched up with R. We can match the rate and CI
## values reported by SAS for the 6 subgroups formed by
## setting car and age at their "mix and match" combinations.
wdir <- "../workingdata"
fn <- "insure.csv"

insure <- read.csv(file.path(wdir, fn))
insure$car <- factor(insure$car, levels = c("small", "medium", "large"))
insure$agen <- insure$age
insure$age <- factor(insure$age)
colnames(insure) <- gsub("ln", "nlog", colnames(insure))
colnames(insure) <- gsub("c", "claims", colnames(insure)
                         
m1 <- glm(claims ~ offset(nlog) + car + age, family = "poisson", data = insure)
summary(m1)

## First, SAS claims the estimate rate for claims AGE=1 is 0.03156. This
## was the most difficult to reproduce, there is no canned routine to do it.
## There's no canned way to do this because
## nobody would ever want to, but SAS did, so we can:
## But this gets the "right number" for the estimate, matches column 9 of
## Table 1 (top of page 2 when I print this out)
library(rockchalk)
m1.nd <- newdata(m1, list(age = c("1", "2"),
                          car = c("small", "medium", "large"),
                          nlog = 0))
m1.lp <- predict(m1, newdata = m1.nd, type = "link",
                 interval="confidence", se.fit = TRUE)
m1.nd <- data.frame(m1.nd, m1.lp)
aggregate(m1.nd$fit, list(age = m1.nd$age), function(fit){exp(mean(fit))})
##  age          x
##1   1 0.03156487
##2   2 0.11815268
##
## SAS does not report how they calculated the CI on those values
## I don't want to guess.


## The rest is easier. Get predicted values for all combinations of
## age and car.

m1.pom <- predictOMatic(m1, predVals = list("car" = "table", "age" = "table", "nlog" = 0),
              interval = "confidence")

## Output matches exactly the SAS table immediately below the
## usage of proc plm
##   nlog    car age        fit        lwr        upr
## 1  0  small   1 0.07159780 0.05529808 0.09270205
## 2  0 medium   1 0.03581213 0.02796003 0.04586937
## 3  0  large   1 0.01226541 0.00699169 0.02151703
## 4  0  small   2 0.26800274 0.22453970 0.31987872
## 5  0 medium   2 0.13405089 0.10823732 0.16602074
## 6  0  large   2 0.04591153 0.02766553 0.07619114

library(xtable)

print(xtable(m1.pom), floating=F, include.rownames=F)


library(rockchalk)
outreg(m1, runFuns = c("AIC" = "Akaike IC"))


library(MASS)

m5 <- glm.nb(claims ~ offset(nlog) + car + age, data = insure, control = glm.control(maxit=1000))
summary(m5)
names(m5)

outreg(m5, runFuns = c("deviance"= "Deviance", "AIC" = "AIC"))


m2 <- glm(claims ~ offset(log(n)) + car + age, family = "poisson", data = insure)
summary(m2)

m2.pom <- predictOMatic(m2, predVals = list("car" = "table", "age" = "table",
                                            "n" = 1),
                        interval = "confidence")
m2.pom
