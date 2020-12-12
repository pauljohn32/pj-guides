### R code from vignette source 'Logit-when_does_it_matter-uniquebackupstring201905011621.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Logit-when_does_it_matter-uniquebackupstring201905011621.Rnw:24-25
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: tmpout
###################################################
if(!dir.exists("tmpout")) dir.create("tmpout", showWarnings=FALSE)


###################################################
### code chunk number 3: Roptions
###################################################
opts.orig <- options()
options(width=100, prompt="> ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly = TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)
if(!file.exists("tmpout")) dir.create("tmpout", showWarnings=F)


###################################################
### code chunk number 4: texcopy
###################################################
library(stationery)
## If theme directory does not have required logo files, retrieve them.
logos <- c(logo = "logo.pdf",
            logomini = "logomini.pdf")
getFiles(logos, pkg = "crmda")


###################################################
### code chunk number 5: Logit-when_does_it_matter-uniquebackupstring201905011621.Rnw:259-260
###################################################
set.seed(12323)


###################################################
### code chunk number 6: s6_1
###################################################
library(rockchalk)
x <- sample(1:7, size = 1000, replace = TRUE)
xseq <- 1:7
beta0 <- -1
beta1 <- .2
pry <- function(x, k0, k1){
   exp(k0 + k1 * x)/(1 + exp(k0 + k1 * x))
}
trueprob <- pry(xseq, beta0, beta1)
plot(1:7, trueprob, type="l",xlab='x',ylab='Probability(y=1)', col = "gray70",
     main = paste("The True Model, beta0 =", beta0, ", beta1 = ", beta1),
     ylim = c(0,1))
rug(x)
points(xseq, trueprob)


###################################################
### code chunk number 7: s1
###################################################
ypr <- pry(x, beta0, beta1)
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m1 <- glm(yobs ~ x, family = "binomial")
plotCurves(m1, plotx = "x", ylab = "Logistic Probability(y = 1)", plotLegend = FALSE)
lines(xseq, trueprob, lty = 2)
legend("topleft", legend = c("Logistic Estimate", "True Logistic"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 8: s2
###################################################
m2 <- glm(yobs ~ x, family = gaussian)
plotCurves(m2, plotx = "x", ylab = "Linear Probability(y = 1)", plotLegend = FALSE)
lines(xseq, trueprob, lty = 2)
legend("topleft", legend = c("Linear Prediction", "True Logistic"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 9: s3
###################################################
## The logistic model
predictOMatic(m1, predVals = list(x=1:7), type = "response")
## The linear model
predictOMatic(m2, predVals = list(x=1:7), type = "response")


###################################################
### code chunk number 10: s4
###################################################
plotCurves(m1, plotx = "x", ylab = "Logistic Probability(y = 1)", plotLegend = FALSE, plotxRange = c(-10, 15))


###################################################
### code chunk number 11: s5
###################################################
plotCurves(m2, plotx = "x", ylab = "Linear Probability(y = 1)", plotLegend = FALSE, plotxRange = c(-10, 15))


###################################################
### code chunk number 12: s5
###################################################
plotCurves(m2, plotx = "x", ylab = "Linear Probability(y = 1)", plotLegend = FALSE, plotxRange = c(-10, 15))
m1.pom <- predictOMatic(m1, predVals = list(x = seq(-10, 15)))
lines(fit ~ x, m1.pom, col = "red", lty = 2, lwd = 3)
legend("topleft", legend = c("Linear Prediction", "Logistic Prediction"), lty = c(1, 2),col=c("black", "red"), lwd = c(1,3))


###################################################
### code chunk number 13: Logit-when_does_it_matter-uniquebackupstring201905011621.Rnw:363-364
###################################################
set.seed(12323)


###################################################
### code chunk number 14: t0
###################################################
xseq <- 1:7
beta0 <- -1
beta1 <- .5
pry <- function(x, k0, k1){
   exp(k0 + k1 * x)/(1 + exp(k0 + k1 * x))
}
trueprob <- pry(xseq, beta0, beta1)
plot(1:7, trueprob, type="l",xlab='x',ylab='Probability(y=1)', col = "gray70",
     main = paste("The True Model, beta0 =", beta0, ", beta1 = ", beta1),
     ylim = c(0,1))
rug(x)
points(xseq, trueprob)


###################################################
### code chunk number 15: t1
###################################################
ypr <- pry(x, beta0, beta1)
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m1 <- glm(yobs ~ x, family = "binomial")
plotCurves(m1, plotx = "x", ylab = "Logistic Probability(y = 1)", plotLegend = FALSE)
lines(xseq, trueprob, lty = 2)
legend("topleft", legend = c("Logistic Estimate", "True Logistic"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 16: t2
###################################################
m2 <- glm(yobs ~ x, family = gaussian)
plotCurves(m2, plotx = "x", ylab = "Linear Probability(y = 1)", plotLegend = FALSE)
lines(xseq, trueprob, lty = 2)
legend("topleft", legend = c("Linear Prediction", "True Logistic"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 17: t3
###################################################
## The logistic model
predictOMatic(m1, predVals = list(x=1:7), type = "response")
## The linear model
predictOMatic(m2, predVals = list(x=1:7), type = "response")


###################################################
### code chunk number 18: Logit-when_does_it_matter-uniquebackupstring201905011621.Rnw:458-459
###################################################
set.seed(12323)


###################################################
### code chunk number 19: dummy0
###################################################
x <- sample(0:1, size = 1000, replace = TRUE)
xdummy <- 0:1
beta0 <- -2
beta1 <- 3.3
pry <- function(x, k0, k1){
   exp(k0 + k1 * x)/(1 + exp(k0 + k1 * x))
}
trueprob <- pry(xdummy, beta0, beta1)
plot(0:1, trueprob, type="n",xlab='x',ylab='Probability(y=1)', col = "gray70",
     main = paste("The True Model, beta0 =", beta0, ", beta1 = ", beta1),
     ylim = c(0,1))
xseq <- seq(0, 1, length.out=10000)
lines(xseq, pry(xseq, beta0, beta1))
rug(x)
points(xdummy, trueprob)


###################################################
### code chunk number 20: dum0
###################################################
ypr <- pry(x, beta0, beta1)
dat <- data.frame(yobs=rbinom(n = length(ypr), size = 1, prob = ypr),
                  ypr = ypr, x = x)


###################################################
### code chunk number 21: Logit-when_does_it_matter-uniquebackupstring201905011621.Rnw:498-499
###################################################
pctable(yobs ~ x, data = dat)


###################################################
### code chunk number 22: dum1
###################################################
m1 <- glm(yobs ~ x, family = "binomial", data=dat)
plotCurves(m1, plotx = "x", ylab = "Logistic Probability(y = 1)", legendArgs = "none")
lines(xseq, pry(xseq, beta0, beta1), lty=2)
legend("top", legend = c("Logistic Estimate", "True Logistic"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 23: Logit-when_does_it_matter-uniquebackupstring201905011621.Rnw:518-519
###################################################
summary(m1)


###################################################
### code chunk number 24: dum2
###################################################
m2 <- glm(yobs ~ x, family = gaussian, data = dat)
plotCurves(m2, plotx = "x", ylab = "Linear Probability(y = 1)", legendArgs = "none")
lines(xseq, pry(xseq, beta0, beta1), lty=2)
legend("top", legend = c("Linear Prediction", "True Logistic"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 25: Logit-when_does_it_matter-uniquebackupstring201905011621.Rnw:538-539
###################################################
summary(m2)


###################################################
### code chunk number 26: dum3
###################################################
## The logistic model
(m1p1 <- predictOMatic(m1, predVals = "margins", type = "response"))
## The linear model
(m2p1 <- predictOMatic(m2, predVals = "margins", type = "response"))


###################################################
### code chunk number 27: dum5
###################################################
plotCurves(m1, plotx = "x", ylab = "Probability(y = 1)", legendArgs = "none", plotPoints=FALSE)
abline(m2, lty = 2, lwd = 2)
legend("top", legend = c("Logistic", "Linear"), lty = c(1, 2), lwd = c(2,1))
points(x = m1p1$x$x, y=m1p1$x$fit)


###################################################
### code chunk number 28: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 29: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


