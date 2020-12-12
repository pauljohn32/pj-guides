### R code from vignette source 'Regression-MultipleInputs-lecture-1.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Regression-MultipleInputs-lecture-1.Rnw:32-33
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-MultipleInputs-lecture-1.Rnw:85-87
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=T)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: job10
###################################################
library(rockchalk)
dat <- read.table("~/GIT/pj-guides/stat/DataSets/JobPerformance/jobperformance.txt", header=T, sep="\t")
colnames(dat) <- tolower(colnames(dat)) 
mod1 <- lm(wbeing ~ satis, data=dat)
summary(mod1)


###################################################
### code chunk number 5: job20 (eval = FALSE)
###################################################
## mod2 <- lm(wbeing ~ satis + jobperf + tenure + age, data=dat)
## summary(mod2)


###################################################
### code chunk number 6: job21
###################################################
mod2 <- lm(wbeing ~ satis + jobperf + tenure + age, data=dat)
summary(mod2)


###################################################
### code chunk number 7: job30
###################################################
outreg(list(mod1,mod2), modelLabels=c("One Predictor","Multiple Predictors"), tight=F, showAIC=F)


###################################################
### code chunk number 8: Regression-MultipleInputs-lecture-1.Rnw:375-376
###################################################
confint(mod2)


###################################################
### code chunk number 9: vcov10
###################################################
round(vcov(mod2), 3)


###################################################
### code chunk number 10: vcov15
###################################################
round(sqrt(diag(vcov(mod2))), 3)


###################################################
### code chunk number 11: chile60a (eval = FALSE)
###################################################
## library(car)
## Chile$income <- Chile$income/1000000
## chmod3 <- lm(statusquo ~ income + sex, data = Chile)
## outreg(chmod3, tight = FALSE)


###################################################
### code chunk number 12: chile60b
###################################################
library(car)
Chile$income <- Chile$income/1000000
chmod3 <- lm(statusquo ~ income + sex, data = Chile)
outreg(chmod3, tight = FALSE)


###################################################
### code chunk number 13: chile60.1
###################################################
predictOMatic(chmod3, predVals = "margins")


###################################################
### code chunk number 14: chile60.2
###################################################
predictOMatic(chmod3, predVals = "margins", divider = "std.dev")


###################################################
### code chunk number 15: chile70
###################################################
termplot(chmod3, se = TRUE, partial.resid = TRUE, terms = "income", xlab = "Income (1,000,000s pesos)")


###################################################
### code chunk number 16: chile75
###################################################
plotSlopes(chmod3, plotx = "income")


###################################################
### code chunk number 17: chile80
###################################################
plotSlopes(chmod3, plotx = "income", modx = "sex")


###################################################
### code chunk number 18: chile61 (eval = FALSE)
###################################################
## mycols <- c("blue", "red")
## plot(statusquo ~ income, data = Chile, xlab = "Income (1,000,000s pesos)", ylab = "Status Quo Support", col = mycols[Chile$sex], cex = 0.7 )
## incomeSeq <- seq(min(Chile$income, na.rm = TRUE), 
##                  max(Chile$income, na.rm = TRUE), length.out = 5)
## newdat <- expand.grid(income = incomeSeq, sex = levels(Chile$sex))
## newdat$pred <- predict(chmod3, newdata = newdat)
## by(newdat, newdat$sex, function(datsub) lines(pred ~ income, dat =  datsub, col = mycols[datsub$sex]))
## legend("topleft", levels(newdat$sex), col = mycols, lty = 1, bg = "white")


###################################################
### code chunk number 19: chile61a
###################################################
mycols <- c("blue", "red")
plot(statusquo ~ income, data = Chile, xlab = "Income (1,000,000s pesos)", ylab = "Status Quo Support", col = mycols[Chile$sex], cex = 0.7 )
incomeSeq <- seq(min(Chile$income, na.rm = TRUE), 
                 max(Chile$income, na.rm = TRUE), length.out = 5)
newdat <- expand.grid(income = incomeSeq, sex = levels(Chile$sex))
newdat$pred <- predict(chmod3, newdata = newdat)
by(newdat, newdat$sex, function(datsub) lines(pred ~ income, dat =  datsub, col = mycols[datsub$sex]))
legend("topleft", levels(newdat$sex), col = mycols, lty = 1, bg = "white")


###################################################
### code chunk number 20: chile81
###################################################
plotSlopes(chmod3, plotx = "income", modx = "sex", interval = "confidence")


###################################################
### code chunk number 21: pp10
###################################################
plotPlane(mod2, plotx1 = "satis", plotx2 = "jobperf", drawArrows = TRUE, alwd = 0.45, alength = 0.08)


###################################################
### code chunk number 22: job33
###################################################
outreg(list(mod2), modelLabels=c("Satisfaction"), tight=F, showAIC=F)


###################################################
### code chunk number 23: job50
###################################################
round(vcov(mod2),5)


###################################################
### code chunk number 24: rdesmatrix
###################################################
set.seed(123123)
dat <- data.frame(xnum1 = rnorm(100), xcat2 = factor(sample(c("Female", "Male"), 100, replace = TRUE)),
z = factor(sample(c("A","B","C","D"), 100, replace = TRUE)), y = rnorm(100))
mod1mm <- model.matrix(y ~ xnum1 + xcat2 + z, data = dat)
dat$y <- mod1mm %*% c(0.1, 0.45, -0.1, 0.2, 0.35, -0.45) + 0.8 *rnorm(100)
mod1 <- lm(y ~ xnum1 + xcat2 + z, data = dat)
mod1df <- model.frame(mod1)


###################################################
### code chunk number 25: summarize10
###################################################
summarizeNumerics(dat)
summarizeFactors(dat)


###################################################
### code chunk number 26: modframe1
###################################################
head(dat, 15)


###################################################
### code chunk number 27: modmatr1
###################################################
mod1mm <- model.matrix(mod1)
head(mod1mm, 15)


###################################################
### code chunk number 28: WR20
###################################################
contrasts(dat$z)


###################################################
### code chunk number 29: WR40
###################################################
summary(mod1)


###################################################
### code chunk number 30: WR50
###################################################
require(rockchalk)
plotSlopes(mod1, plotx="xnum1", modx="z")


###################################################
### code chunk number 31: anova1
###################################################
mod2 <- lm(y ~ xnum1 + xcat2, data = dat)
anova(mod2, mod1, test = "F")


###################################################
### code chunk number 32: drop1
###################################################
drop1(mod1, test = "F")


