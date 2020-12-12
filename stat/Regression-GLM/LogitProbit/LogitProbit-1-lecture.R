### R code from vignette source 'LogitProbit-1-lecture-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: LogitProbit-1-lecture-uniquebackupstring.Rnw:33-34
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
### code chunk number 5: logplot
###################################################
x <- seq(0.001, 10, length=10000)
xlog <- log(x)
plot(x, xlog, type = "l", ylab="natural log of x", main = "logarithm")
abline(h=0, type = 4, col="gray70")
abline(v=1, type = 4, col="gray70")
mtext("1", 1, at = 1)


###################################################
### code chunk number 6: expplot
###################################################
x <- seq(-4, 4, length=10000)
xexp <- exp(x)
xmexp <- exp(-x)
plot(x, xexp, type = "l", ylab="y", main = "exponential of x and -x")
lines(x, xmexp, lty = 2, col = "gray60")
lines(x = c(0,0), y = c(0, 40), lty = 3, col="gray70")
legend("top", legend = c("exp(x)", "exp(-x)"), lty = c(1, 2), col = c(1, "gray40"))


###################################################
### code chunk number 7: logpdf10
###################################################
x <- seq (-7, 7, by=0.05)
logis10 <- dlogis(x, location = 0, scale = 1, log = FALSE)
plot(x, logis10, type="l", ylim=c(0,0.35), xlab=expression(epsilon), ylab="Probability Density", main="") 
##legend("topleft", c(expression(paste("Logistic(", location==0, " , ",
##                                     scale == 1, ")"))), lty=1:2, col=1:2, cex = 0.8) 
title("Single peaked, symmetric probability density")


###################################################
### code chunk number 8: logpdf20
###################################################
x <- seq (-7, 7, by=0.05)
logis10 <- dlogis(x, location = 0, scale = 1, log = FALSE)
plot(x, logis10, type="l", ylim=c(0,0.35), xlab=expression(epsilon[i]), ylab="Probability Density", main="") 
legend("topleft", c(expression(paste("Logistic(", location==0, " , ",
                                     scale == 1, ")"))), lty=1:2, col=1:2, cex = 0.8) 
title("Logistic variable")
xcut <- -1.5
xlt <- x < xcut
xmax <- max(x[xlt])
xseq <- c(x[xlt], rev(x[xlt])) 
yseq <- c(rep(0, sum(xlt)), rev(logis10[xlt])) 
polygon(xseq, yseq, col = "gray80")
text(-1.3, 0.025, pos = 4, "Above 'cut point' of -1.5")
text(-2.4, 0.075, pos = 2, "Below 'cut point'")


###################################################
### code chunk number 9: logpdf30
###################################################
x <- seq (-7, 7, by=0.05)
logis10 <- dlogis(x, location = 0, scale = 1, log = FALSE)
plot(x, logis10, type="l", ylim=c(0,0.35), xlab=expression(epsilon), ylab="Probability Density", main="") 
legend("topleft", c(expression(paste("Logistic(", location==0, " , ",
                                     scale == 1, ")"))), lty=1:2, col=1:2, cex = 0.8) 
title("Logistic variable")
xcut <- -1.5
xlt <- x < xcut
xmax <- max(x[xlt])
xseq <- c(x[xlt], rev(x[xlt])) 
yseq <- c(rep(0, sum(xlt)), rev(logis10[xlt])) 
polygon(xseq, yseq, col = "gray80")
text(-1, 0.025, pos = 4, "Pr(y = 1)")
text(-2.4, 0.075, pos = 2, "Pr(y = 0)")


###################################################
### code chunk number 10: logpdf40
###################################################
x <- seq (-7, 7, by=0.05)
logis10 <- dlogis(x, location = 0, scale = 1, log = FALSE)
plot(x, logis10, type="l", ylim=c(0,0.35), xlab=expression(epsilon[i]), ylab="Probability Density", main="") 
legend("topleft", c(expression(paste("Logistic(", location==0, " , ",
                                     scale == 1, ")"))), lty=1:2, col=1:2, cex = 0.8) 
title("Logistic variable")
xcut <- 0.5
xlt <- x < xcut
xmax <- max(x[xlt])
xseq <- c(x[xlt], rev(x[xlt])) 
yseq <- c(rep(0, sum(xlt)), rev(logis10[xlt])) 
polygon(xseq, yseq, col = "gray80")
text(1, 0.025, pos = 4, "Pr(y = 1)")
text(-1.25, 0.025, pos = 2, "Pr(y = 0)")


###################################################
### code chunk number 11: logpdf50
###################################################
x <- seq (-7, 7, by=0.05)
logis10 <- dlogis(x, location = 0, scale = 1, log = FALSE)
plot(x, logis10, type="l", ylim=c(0,0.35), xlab=expression(epsilon[i]), ylab="Probability Density", main="") 
legend("topleft", c(expression(paste("Logistic(", location==0, " , ",
                                     scale == 1, ")"))), lty=1:2, col=1:2, cex = 0.8) 
title("Logistic variable")
xcut <- 2
xlt <- x < xcut
xmax <- max(x[xlt])
xseq <- c(x[xlt], rev(x[xlt])) 
yseq <- c(rep(0, sum(xlt)), rev(logis10[xlt])) 
polygon(xseq, yseq, col = "gray80")
text(2.05, 0.015, pos = 4, "Pr(y = 1)")
text(-1.5, 0.015, pos = 2, "Pr(y = 0)")


###################################################
### code chunk number 12: logpdf55
###################################################
x <- seq (-7, 7, by=0.05)
logis10 <- dlogis(x, location = 0, scale = 1, log = FALSE)
plot(x, logis10, type="l", ylim=c(0,0.35), xlab=expression(epsilon[i]), ylab="Probability Density", main="") 
legend("topleft", c(expression(paste("Logistic(", location==0, " , ",
                                     scale == 1, ")"))), lty=1:2, col=1:2, cex = 0.8) 
title("Logistic variable")
xcut <- -2
xlt <- x < xcut
xmax <- max(x[xlt])
xseq <- c(x[xlt], rev(x[xlt])) 
yseq <- c(rep(0, sum(xlt)), rev(logis10[xlt])) 
polygon(xseq, yseq, col = "gray80")
text(xcut + 0.5, 0.015, pos = 4, "Pr(y = 0)")
text(xcut-1, 0.05, pos = 2, "Pr(y = 1)")


###################################################
### code chunk number 13: logpdf60
###################################################
x <- seq (-7, 7, by=0.05)
logis10 <- dlogis(x, location = 0, scale = 1, log = FALSE)
plot(x, logis10, type="l", ylim=c(0,0.35), xlab=expression(epsilon[i]),
      ylab="Probability Density", main="") 
xcut <- 2
xlt <- x < xcut
xmax <- max(x[xlt])
xseq <- c(x[xlt], rev(x[xlt])) 
yseq <- c(rep(0, sum(xlt)), rev(logis10[xlt])) 
polygon(xseq, yseq, col = "gray80")
text(2.05, 0.015, pos = 4, "Pr(y = 1)")
plogisatxcut <- plogis(xcut, 0, 1, log=FALSE)
text(2, 0.015, pos = 2, paste("Pr(y = 0) = ", formatC(plogisatxcut)))
mtext(expression(tau), 1, at = xcut)


###################################################
### code chunk number 14: logpdf70
###################################################
par.orig <- par(no.readonly=TRUE)
par(mar = c(4.1, 4.1, 2.1, 2.1))
cumlogis <- plogis(x, location = 0, scale = 1, log = FALSE)
plot(x, cumlogis, type="l", ylim=c(0,1), xlab=expression(tau),
      ylab="Cumulative Probability", main="") 
abline(v=xcut, lty = 4, col = "gray80")
par(par.orig)


###################################################
### code chunk number 15: LogitProbit-1-lecture-uniquebackupstring.Rnw:804-810
###################################################
set.seed(44444)
x <- 25:75
p= 1/(1+exp(2-0.05*x))
y <- rbinom(length(x), size=1, prob=p)
dat1 <- data.frame(x = x, y = y)
dat1 <- dat1[order(dat1$x, y), ]


###################################################
### code chunk number 16: a
###################################################
plot(x, y, ylim=c(-.2,1.2), xlab="One Predictor X", ylab="dichotomous output", type="n")
points(x,y,pch=16,cex=0.85)


###################################################
### code chunk number 17: b
###################################################
m1 <- lm(y~x, data = dat1)
plot(y~x, dat1, xlab="One Predictor X", ylab="dichotomous output")
abline(m1)
text(60, 0.5, expression(hat(y[i])==hat(beta)[0] + hat(beta)[1]*X[i]))


###################################################
### code chunk number 18: LogitProbit-1-lecture-uniquebackupstring.Rnw:836-841
###################################################
x2 <- seq(0,150,length=200)
expbx2 <- exp((-1)*(-10+.145*x2))
ProbY1 <- 1/(1+expbx2)
y2 <- rbinom(n=200, size=1, prob=ProbY1)
dat2 <- data.frame(x2 = x2, y2 = y2)


###################################################
### code chunk number 19: LogitProbit-1-lecture-uniquebackupstring.Rnw:844-845
###################################################
modl2 <- lm(y2~x2, data = dat2)


###################################################
### code chunk number 20: c
###################################################
plot(y2 ~ x2, dat2, ylim=c(-0.3,1.5),type="n", xlab="One Predictor X",
       ylab="dichotomous output")
points(x2, y2,cex=1)
abline(modl2);
lines(c(0,150),c(0,0),lty=c(2)); lines(c(0,150),c(1,1),lty=c(2))
text(100, 0.5, expression(hat(y[i])==hat(beta)[0] + hat(beta)[1]*X[i]))


###################################################
### code chunk number 21: olskink
###################################################
plot(x2, y2, ylim=c(-0.3,1.5),type="n", xlab="One Predictor X", ylab="dichotomous output")
points(x2,y2,cex=0.8, col="gray70")
lines(c(0,150),c(0,0),lty=c(2), col="gray60") 
lines(c(0,150),c(1,1),lty=c(2), col="gray60")
eta <- coef(modl2)[1] + coef(modl2)[2] * x2
etakink <- ifelse(eta < 0, 0, ifelse(eta > 1, 1, eta)) 
lines(x2, etakink)


###################################################
### code chunk number 22: lpmpred
###################################################
m1 <- lm(y~x, data = dat1)
plot(x,y, xlab="One Predictor X", ylab="dichotomous output")
dat1$yhat <- predict(m1)
abline(m1)
text(70, 0.5, expression(hat(y)==hat(beta)[0] + hat(beta)[1]*X))
K <- 10 # the chosen case
arrows(dat1[K, "x"], 0.05 + dat1[K, "yhat"], dat1[K, "x"], .95, length = 0.1) 
arrows(dat1[K, "x"], -0.05 + dat1[K, "yhat"], dat1[K, "x"], 0.05, length = 0.1)
text( dat1[K, "x"], 0.1 + dat1[K, "yhat"], 
                  expression(e[up]==1-X[i]*hat(beta)), pos = 4)
text(dat1[K, "x"], -0.2 + dat1[K, "yhat"], 
                  expression(e[down]==-X[i]*hat(beta)), pos = 4)


###################################################
### code chunk number 23: s1_1
###################################################
xrange <- seq(50, 150, length = 200)
beta0 <- -10
beta1 <- .1
pry <- function(x, k0, k1){
   exp(k0 + k1 * x)/(1 + exp(k0 + k1 * x))
}
ProbY1 <- pry(xrange, beta0, beta1)
plot(xrange, ProbY1, type="l", xlab=expression(X*beta), ylab='Probability(y=1)')


###################################################
### code chunk number 24: s3_1
###################################################
x <- sort(rnorm(20, m = 100, s = 20))
plot(xrange, ProbY1, type="l", xlab=expression(X*beta), 
       ylab='Probability(y=1)',  col = "gray60")
rug(x, lwd = 1)
ypr <- pry(x, beta0, beta1) 
points(x, ypr, lwd = 2)
title("The \"true\" Probabilty that y = 1")


###################################################
### code chunk number 25: s4_1
###################################################
plot(xrange, ProbY1, type="l",xlab=expression(X*beta),
        ylab='Probability(y=1)',  col = "gray60")
rug(x, ticksize = 0.01, lwd = 1)
ypr <- pry(x, beta0, beta1) 
points(x, ypr)
arrows(x[10], 0.05 + ypr[10], x[10], 1, length = 0.05) 
arrows(x[10], -0.05 + ypr[10], x[10], 0, length = 0.05) 
text(x[10], ypr[10]+ 0.5*(1 - ypr[10]), pos = 2, labels = paste("Pr[y = 1] = ", round(ypr[10], 2)))
text(x[10], ypr[10] - 0.5*(ypr[10]), pos = 4, labels = paste("Pr[y = 0] = ", round(1 - ypr[10], 2)))


###################################################
### code chunk number 26: s4_2
###################################################
plot(xrange, ProbY1, type="l", xlab=expression(X*beta), 
       ylab='Probability(y=1)', col = "gray60")
rug(x, ticksize = 0.01, lwd = 1)
ypr <- pry(x, beta0, beta1) 
points(x, ypr)
j <- 4
arrows(x[j], 0.05 + ypr[j], x[j], 1, length = 0.05) 
arrows(x[j], -0.05 + ypr[j], x[j], 0, length = 0.05) 
text(x[j], ypr[j]+ 0.5*(1 - ypr[j]), pos = 2, labels = paste("Pr[y = 1] = ", round(ypr[j], 2)))
text(x[j], ypr[j] - 0.5*(ypr[j]), pos = 4, labels = paste("Pr[y = 0] = ", round(1 - ypr[j], 2)))


###################################################
### code chunk number 27: s4_3
###################################################
plot(xrange, ProbY1, type="l", xlab=expression(X*beta), 
ylab='Probability(y=1)', col = "gray60")
rug(x, ticksize = 0.01, lwd = 1)
ypr <- pry(x, beta0, beta1) 
points(x, ypr)
j <- 15
arrows(x[j], 0.05 + ypr[j], x[j], 1, length = 0.05) 
arrows(x[j], -0.05 + ypr[j], x[j], 0, length = 0.05) 
text(x[j], ypr[j]+ 0.5*(1 - ypr[j]), pos = 2, labels = paste("Pr[y = 1] = ", round(ypr[j], 2)))
text(x[j], ypr[j] - 0.5*(ypr[j]), pos = 4, labels = paste("Pr[y = 0] = ", round(1 - ypr[j], 2)))


###################################################
### code chunk number 28: s5_1
###################################################
plot(xrange, ProbY1, type="l",xlab='x',ylab='Probability(y=1)', col = "gray60")
rug(x, ticksize = 0.01, lwd = 1)
points(x, ypr, col = "gray60")
arrows(x, ifelse(ypr < 0.94, 0.05 + ypr, ypr + 0.1 * (1-ypr)),  x, 1, length = 0.05) 
arrows(x, ifelse(ypr > 0.05, ypr - 0.05, 0), x, 0, length = 0.05) 


###################################################
### code chunk number 29: s8_1
###################################################
plot(xrange, ProbY1, type="l", xlab=expression(X*beta), 
ylab='Probability(y=1)', col = "gray80")
xdic <- c(90, 110)
rug(xdic, ticksize = 0.01, lwd = 1)
ypr <- pry(xdic, beta0, beta1) 
points(xdic, ypr)
arrows(xdic[1], 0.05 + ypr[1], xdic[1], 1, length = 0.05) 
arrows(xdic[1], -0.05 + ypr[1], xdic[1], 0, length = 0.05) 
arrows(xdic[2], 0.05 + ypr[2], xdic[2], 1, length = 0.05) 
arrows(xdic[2], -0.05 + ypr[2], xdic[2], 0, length = 0.05) 
text(xdic[1], ypr[1]+ 0.5*(1 - ypr[1]), pos = 2, labels = paste("Pr[y = 1]"))
text(xdic[1], ypr[1] - 0.5*(ypr[1]), pos = 2, labels = paste("Pr[y = 0]"))
text(xdic[2], ypr[2]+ 0.5*(1 - ypr[2]), pos = 2, labels = paste("Pr[y = 1]"))
text(xdic[2], ypr[2] - 0.5*(ypr[2]), pos = 4, labels = paste("Pr[y = 0]"))


###################################################
### code chunk number 30: s8_2
###################################################
plot(xrange, ProbY1, type="n", xlab=expression(X*beta), 
ylab='Probability(y=1)', col = "gray80")
xdic <- c(rep(90, 50), rep(110, 50))
rug(xdic, ticksize = 0.01, lwd = 1)
ypr <- pry(xdic, beta0, beta1)
yobs <- rbinom(length(ypr), size = 1, pr = ypr)
points(xdic, yobs)


###################################################
### code chunk number 31: logitrans10
###################################################
prob <- seq(0.001, 0.999, length.out=1000)
odds <- prob/(1-prob)
plot(prob, odds, ylab = "P/(1-P)", xlab= "P", type = "l", ylim = c(0,200))


###################################################
### code chunk number 32: logitrans20
###################################################
lnodds <- log(prob/(1-prob))
plot(prob, lnodds, ylab = "logit=ln(P/(1-P))", xlab= "P", type = "l")


###################################################
### code chunk number 33: logit1
###################################################
glm1 <- glm(y2~x2, family=binomial(logit))
summary(glm1)


###################################################
### code chunk number 34: logit2
###################################################
plot(x2,y2)
abline(m1, lty=2)
library(rockchalk)
plotx <- plotSeq(x2)
glmpred <- predict(glm1, newdata=data.frame(x=plotx), type="response")
lines(plotx, glmpred, lty=1)
legend("topleft", title = "Predicted Values", 
    legend=c("Logistic", "OLS"), lty=c(1,2))


###################################################
### code chunk number 35: logit4
###################################################
outreg(list(OLS = modl2, Logit = glm1), showAIC=T, 
       request = c("fstatistic" = "F"))


###################################################
### code chunk number 36: LogitProbit-1-lecture-uniquebackupstring.Rnw:1508-1509
###################################################
predictOMatic(glm1, predVals = c(x2 = "seq"), n = 10)


###################################################
### code chunk number 37: LogitProbit-1-lecture-uniquebackupstring.Rnw:1520-1521
###################################################
predictOMatic(glm1, predVals = c(x2 = "std.dev."), n = 5, interval = "confidence")


###################################################
### code chunk number 38: LogitProbit-1-lecture-uniquebackupstring.Rnw:1529-1530
###################################################
plotCurves(glm1, plotx="x2", interval="confidence")


###################################################
### code chunk number 39: cdf100
###################################################
x <- seq (-7, 7, by=0.05)
logis10 <- dlogis(x, location = 0, scale = 1, log = FALSE)
plot(x, logis10, type="l", ylim=c(0,0.35), xlab=expression(epsilon[i]), ylab="Probability Density", main="")
xcut <- 0.5
xlt <- x < xcut
xmax <- max(x[xlt])
xseq <- c(x[xlt], rev(x[xlt])) 
yseq <- c(rep(0, sum(xlt)), rev(logis10[xlt])) 
polygon(xseq, yseq, col = "gray80")
text(1, 0.025, pos = 4, "Pr(y = 1)")
text(-1.25, 0.025, pos = 2, "Pr(y = 0)")
mtext(expression(beta[0]+beta[1]*X[i]), 1, at = xcut)


###################################################
### code chunk number 40: landn
###################################################
x <- seq(-6,6, by=0.05)
mylogis111 <- dlogis(x, location = 0, scale = 1, log = FALSE) 
myNorm <- dnorm(x, mean = 0, sd = pi/sqrt(3)) 
matplot(x, cbind(mylogis111, myNorm),type="l",ylim=c(0,0.5), xlab="x", ylab="P(x)", main="") 
normlabel = expression(paste("Normal(",0,",",pi^{2}/3,")"))
legend("topleft", c("Logistic(0,1)",normlabel), lty=1:2, col=1:2) 


###################################################
### code chunk number 41: probit1
###################################################
glm2 <- glm(y2~x2, family=binomial(probit))
summary(glm2)


###################################################
### code chunk number 42: logitprobit10
###################################################
outreg(list(Logit = glm1, Probit = glm2), showAIC=T, 
       request = c("fstatistic" = "F"))


###################################################
### code chunk number 43: probit2
###################################################
options(scipen = 10)
p1 <- predictOMatic(glm1, predVals = c(x2 = "seq"), n = 10)
p2 <- predictOMatic(glm2, predVals=c(x2 = "seq"), n = 10)
cbind(p1, p2)


###################################################
### code chunk number 44: probit10
###################################################
plot(x2,y2)
p1 <- predictOMatic(glm1, predVals = c(x2 = "seq"), n = 50)
p2 <- predictOMatic(glm2, predVals=c(x2 = "seq"), n = 50)
lines(p1$x2, p1$fit, lty=1)
lines(p2$x2, p2$fit, lty=2)
legend("topleft", legend=c("Logit", "Probit"), 
           title = "Predicted Probabilities", lty=c(1,2))


###################################################
### code chunk number 45: sep10
###################################################
xrange <- seq(50, 150, length = 200)
x <- runif(20, 115, 150)
beta0 <- -10
beta1 <- .1
pry <- function(x, k0, k1){
   exp(k0 + k1 * x)/(1 + exp(k0 + k1 * x))
}
ProbY1 <- pry(xrange, beta0, beta1)
plot(xrange, ProbY1, type="l",xlab='x',ylab='Probability(y=1)', col = "gray70",
     main = "The True S is there, but...")
y <- rep(1, 20)
points(x, y)


###################################################
### code chunk number 46: LogitProbit-1-lecture-uniquebackupstring.Rnw:2035-2043
###################################################
seedfn <- "before-seed-6_1.rds"
if(!file.exists(seedfn)){
    seedbf6_1 <- .Random.seed
    saveRDS(seedbf6_1, file = seedfn)
} else {
	seedbf6_1 <- readRDS(seedfn) 
    assign(".Random.seed", seedbf6_1, envir = .GlobalEnv)
}


###################################################
### code chunk number 47: s6_1
###################################################
xrange <- seq(50, 150, length = 200)
x <- rnorm(20, m = 100, s = 20)
beta0 <- -10
beta1 <- .1
pry <- function(x, k0, k1){
   exp(k0 + k1 * x)/(1 + exp(k0 + k1 * x))
}
ProbY1 <- pry(xrange, beta0, beta1)
plot(xrange, ProbY1, type="l",xlab='x',ylab='Probability(y=1)', col = "gray70",
     main = paste("The True Model, beta0 =", beta0, ", beta1 = ", beta1))
ypr <- pry(x, beta0, beta1)
rug(x)
points(x, ypr)


###################################################
### code chunk number 48: s7_1
###################################################
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m1 <- glm(yobs ~ x, family = "binomial")
plotCurves(m1, plotx = "x", ylab = "Probability(y = 1)", plotLegend = FALSE)
lines(xrange, ProbY1, lty = 2)
legend("topleft", legend = c("Estimate", "True"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 49: s7_2
###################################################
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m2 <- glm(yobs ~ x, family = "binomial")
plotCurves(m2, plotx = "x", ylab = "Probability(y = 1)", plotLegend = FALSE)
lines(xrange, ProbY1, lty = 2)
legend("topleft", legend = c("Estimate", "True"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 50: s7_3
###################################################
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m3 <- glm(yobs ~ x, family = "binomial")
plotCurves(m3, plotx = "x", ylab = "Probability(y = 1)", plotLegend = FALSE)
lines(xrange, ProbY1, lty = 2)
legend("topleft", legend = c("Estimate", "True"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 51: s7_4
###################################################
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m4 <- glm(yobs ~ x, family = "binomial")
plotCurves(m4, plotx = "x", ylab = "Probability(y = 1)", plotLegend = FALSE)
lines(xrange, ProbY1, lty = 2)
legend("topleft", legend = c("Estimate", "True"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 52: s7_5
###################################################
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m5 <- glm(yobs ~ x, family = "binomial")
plotCurves(m5, plotx = "x", ylab = "Probability(y = 1)", plotLegend = FALSE)
lines(xrange, ProbY1, lty = 2)
legend("topleft", legend = c("Estimate", "True"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 53: s7_6
###################################################
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m6 <- glm(yobs ~ x, family = "binomial")
plotCurves(m2, plotx = "x", ylab = "Probability(y = 1)", plotLegend = FALSE)
lines(xrange, ProbY1, lty = 2)
legend("topleft", legend = c("Estimate", "True"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 54: s7_7
###################################################
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m7 <- glm(yobs ~ x, family = "binomial")
plotCurves(m7, plotx = "x", ylab = "Probability(y = 1)", plotLegend = FALSE)
lines(xrange, ProbY1, lty = 2)
legend("topleft", legend = c("Estimate", "True"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 55: seedsnap
###################################################
seedbf8 <- .Random.seed
saveRDS(seedbf8, file = "before8-seed.rds")


###################################################
### code chunk number 56: s7_8
###################################################
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m8 <- glm(yobs ~ x, family = "binomial")
dat8 <- data.frame(yobs, x)
plotCurves(m8, plotx = "x", ylab = "Probability(y = 1)", plotLegend = FALSE)
lines(xrange, ProbY1, lty = 2)
legend("topleft", legend = c("Estimate", "True"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 57: seedsnap2
###################################################
saveRDS(dat8, file = "before8-dat.rds")


###################################################
### code chunk number 58: s7_9
###################################################
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m9 <- glm(yobs ~ x, family = "binomial")
plotCurves(m9, plotx = "x", ylab = "Probability(y = 1)", plotLegend = FALSE)
lines(xrange, ProbY1, lty = 2)
legend("topleft", legend = c("Estimate", "True"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 59: s7_10
###################################################
yobs <- rbinom(n = length(ypr), size = 1, prob = ypr)
m10 <- glm(yobs ~ x, family = "binomial")
plotCurves(m10, plotx = "x", ylab = "Probability(y = 1)", plotLegend = FALSE)
lines(xrange, ProbY1, lty = 2)
legend("topleft", legend = c("Estimate", "True"), lty = c(1, 2), lwd = c(2,1))


###################################################
### code chunk number 60: s7_fits1
###################################################
outreg(list(m1, m2, m3, m4, m5))


###################################################
### code chunk number 61: s7_fits2
###################################################
outreg(list("M6" = m6, "M7" = m7, "M8" = m8, "M9" = m9, "M10" = m10))


###################################################
### code chunk number 62: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 63: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


