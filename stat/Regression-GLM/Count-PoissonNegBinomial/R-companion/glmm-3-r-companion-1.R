### R code from vignette source 'glmm-3-r-companion-1-tanglebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: glmm-3-r-companion-1-tanglebackupstring.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: glmm-3-r-companion-1-tanglebackupstring.Rnw:59-61
###################################################
cplots <- "../cplots"
if(!file.exists(cplots)) dir.create(cplots, showWarnings=FALSE)


###################################################
### code chunk number 3: Roptions
###################################################
##options(device = pdf)
options(width=80, prompt="> ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par(no.readonly = TRUE) 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=FALSE, family="Times", pointsize=10)
library(rockchalk)


###################################################
### code chunk number 4: pois01
###################################################
getOption("SweaveHooks")[["fig"]]()
xval <- 0:10
par(mfrow=c(2,2))
y <- dpois(xval, lambda=0.5)
names(y) <- xval
barplot(y, main="lambda=0.5", col = "white")
y <- dpois(xval, lambda = 1.0)
names(y) <- xval
barplot(y, main="lambda=1.0", col = "white")
y <- dpois(xval, lambda=1.5)
names(y) <- xval
barplot(y, main="lambda=1.5", col = "white")
y <- dpois(xval, lambda=2.0)
names(y) <- xval
barplot(y, main="lambda=2.0", col = "white")
par(mfrow=c(1,1))


###################################################
### code chunk number 5: pois02
###################################################
getOption("SweaveHooks")[["fig"]]()
y <- rpois(500, lambda=5)
par(mfrow=c(2,2))
hist(y, prob=T, main="lambda=5")
y <- rpois(500, lambda=10)
hist(y, prob=T, main="lambda=10")
y <- rpois(500, lambda=50)
hist(y, prob=T, main="lambda=50")
y <- rpois(500, lambda=200)
hist(y, prob=T, main="lambda=200")
par(mfrow=c(1,1))


###################################################
### code chunk number 6: exp10
###################################################
getOption("SweaveHooks")[["fig"]]()
x <- seq(-2, 12, by = 0.1)
y <- exp(x) 
plot(y ~ x, xlab = expression(paste(X*beta)), ylab = expression(exp(X*beta)), type = "l")


###################################################
### code chunk number 7: exp10
###################################################
getOption("SweaveHooks")[["fig"]]()
curve(exp(x), from = -5, to = 10, type = "l")


###################################################
### code chunk number 8: pois19_dgp
###################################################
set.seed(132)
b0 <- .1; b1 <- 0.75; b2 <- -0.15
N <- 100
x1 <- rnorm(N, m=20, s=5)
x2 <- rnorm(N, m=10, s=3)
eta <- b0 + b1 * x1 + b2 * x2
input <- exp(eta)
y <- rpois(N, lambda = input)
dat <- data.frame(x1,x2,y)


###################################################
### code chunk number 9: pois20
###################################################
getOption("SweaveHooks")[["fig"]]()

plot(x1, y, main="Did this surprise you?")


###################################################
### code chunk number 10: pois21
###################################################
getOption("SweaveHooks")[["fig"]]()
hist(y, prob = TRUE, main = "Histogram")


###################################################
### code chunk number 11: pois30
###################################################
glm1 <- glm(y ~ x1 + x2, data=dat, family=poisson(link=log))
summary(glm1)


###################################################
### code chunk number 12: pois31
###################################################
lm1 <- lm(y ~ x1 + x2, data=dat)
summary(lm1)


###################################################
### code chunk number 13: pois35
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(x1, y, main="Ugly Poisson Data")
library(rockchalk)
newdat <- expand.grid(x1=plotSeq(dat$x1, length.out=50), x2=mean(dat$x2))
newdat$p1 <- predict(glm1, newdata=newdat, type="response")
lines(newdat$x1, newdat$p1, lwd=3, col="red")
newdat$lmp1 <- predict(lm1, newdata=newdat)
lines(newdat$x1, newdat$lmp1, lwd=3, col="green")
legend("topleft", legend=c("Exp. Poisson", "OLS"), lwd=c(3,3), col=c("red","green"))



###################################################
### code chunk number 14: pois35_1
###################################################
getOption("SweaveHooks")[["fig"]]()
library(rockchalk)
## harvest lm information, ignore drawing
lm1ps <- plotSlopes(lm1, plotx = "x1")
plotCurves(glm1, plotx = "x1", plotLegend = FALSE) 
lines(fit ~ x1, data = lm1ps$newdata, col = "green")
legend("topright", legend = c("GLM log link", "OLS"), col = c("black", "green"), lty = c(1,1))


###################################################
### code chunk number 15: pois36
###################################################
getOption("SweaveHooks")[["fig"]]()
newdat <- expand.grid(x1=mean(dat$x1), x2=plotSeq(dat$x2, length.out=50))
newdat$p1 <- predict(glm1, newdata=newdat, type="response")

plot(y ~ x2, dat= dat)
lines(newdat$x2, newdat$p1, lwd=3, col="red")

lm1 <- lm(y ~ x1 + x2, data=dat)
newdat$lmp1 <- predict(lm1, newdata=newdat)
lines(newdat$x2, newdat$lmp1, lwd=3, col="green")
legend("topright", legend=c("Exp. Poisson", "OLS"), lwd=c(3,3), col=c("red","green"))


###################################################
### code chunk number 16: pois50
###################################################
library(rockchalk)
library(faraway) 
gavote$undercount <- gavote$ballots - gavote$votes
options.orig <- options()
options(width=65)
summarize(gavote)
options(options.orig)


###################################################
### code chunk number 17: pois50hist
###################################################
getOption("SweaveHooks")[["fig"]]()
hist(gavote$undercount, breaks = 30, xlab= "Undercount", prob = TRUE)


###################################################
### code chunk number 18: pois51
###################################################
myPois1<- glm(undercount ~ rural + perAA + equip, family = poisson, data = gavote)
summary(myPois1) 
predictOMatic(myPois1)


###################################################
### code chunk number 19: pois52
###################################################
getOption("SweaveHooks")[["fig"]]()
library(rockchalk) 
plotCurves(myPois1, plotx = "perAA")


###################################################
### code chunk number 20: pois53
###################################################
getOption("SweaveHooks")[["fig"]]()
library(rockchalk) 
plotCurves(myPois1, plotx = "perAA", modx = "equip")


###################################################
### code chunk number 21: pois55
###################################################
library(faraway)
library(MASS)
gavote$undercount <- gavote$ballots - gavote$votes
myNB1<- glm.nb(undercount ~ rural + perAA + equip, data = gavote)
summary(myNB1)
predictOMatic(myNB1)


###################################################
### code chunk number 22: gavotesave
###################################################
## ddir <- "../data"
## if(!file.exists(ddir)) dir.create(ddir)
## library(foreign)
## write.dta(gavote, file = file.path(ddir, "gavote.dta"))
## write.csv(gavote, file = file.path(ddir, "gavote.csv"), row.names = FALSE)
## saveRDS(gavote, file = file.path(ddir, "gavote.rds"))


###################################################
### code chunk number 23: pois56
###################################################
getOption("SweaveHooks")[["fig"]]()
library(rockchalk) 
plotCurves(myNB1, plotx = "perAA")


###################################################
### code chunk number 24: pois57plot
###################################################
getOption("SweaveHooks")[["fig"]]()
library(rockchalk) 
plotCurves(myNB1, plotx = "perAA", modx = "equip")


###################################################
### code chunk number 25: pois57
###################################################
outreg(list("Poisson" = myPois1, "Neg. Binom" = myNB1), tight=FALSE)


###################################################
### code chunk number 26: pois59
###################################################
anova(myPois1, myNB1, test = "LR")
library(lmtest)
lrtest(myPois1, myNB1)


###################################################
### code chunk number 27: zip10
###################################################
library(pscl)
myNB1<- glm.nb(undercount ~ rural + perAA + equip, data = gavote)

##These fail
##myZip1 <- zeroinfl(undercount ~ rural + perAA + equip | ., data = gavote, dist = "negbin", EM = TRUE)
## Succeeds
myZip1 <- zeroinfl(undercount ~ rural + perAA + equip | 1, data = gavote, dist = "negbin", EM = TRUE)

library(foreign)
stdir <- "../Stata/"
if(!file.exists(stdir)) dir.create(stdir)
write.dta(gavote, file = paste0(stdir, "gavote.dta7"))


###################################################
### code chunk number 28: gamma10
###################################################
getOption("SweaveHooks")[["fig"]]()
par(mfrow=c(2,2))
x <- seq(0.00001, 6, length=1500)
y1 <- dgamma(x, shape = 1/3, scale = 3)
plot(x, y1, main = "shape = 1/3", type = "l", ylim = c(0,2), 
     xlab = expression(delta[i]),
     ylab = expression(density(delta[i])))
y2 <- dgamma(x, shape = 2/3, scale = 3/2)
plot(x, y2, main = "shape = 2/3", type = "l", ylim = c(0,2), 
     xlab = expression(delta[i]),
     ylab = expression(density(delta[i])))
y3 <- dgamma(x, shape = 1/1, scale = 1)
plot(x, y3, main="shape = 1", type = "l", ylim = c(0,2), 
     xlab = expression(delta[i]),
     ylab = expression(density(delta[i])))
y4 <- dgamma(x, shape = 3/2, scale = 2/3)
plot(x, y4, main="shape = 1.5", type = "l", ylim = c(0,2), 
     xlab = expression(delta[i]),
     ylab = expression(density(delta[i])))
par(mfrow=c(1,1))


###################################################
### code chunk number 29: gamma20
###################################################
getOption("SweaveHooks")[["fig"]]()
par(mfrow=c(2,2))
x <- seq(0.001, 6, by = 0.01)
y1 <- dgamma(x, shape = 2, scale = 1/2)
plot(x, y1, main="shape=2", type = "l", ylim = c(0,2), 
     xlab = expression(delta[i]),
     ylab = expression(density(delta[i])))
y2 <- dgamma(x, shape = 2.5, scale = 1/2.5)
plot(x, y2, main="shape = 2.5", type = "l", ylim = c(0,2), 
     xlab = expression(delta[i]),
     ylab = expression(density(delta[i])))
y3 <- dgamma(x, shape = 5, scale = 1/5)
plot(x, y3, main="shape=5", type = "l", ylim = c(0,2), 
     xlab = expression(delta[i]),
     ylab = expression(density(delta[i])))
y4 <- dgamma(x, shape = 10, scale = 1/10)
plot(x, y4, main="shape = 10", type = "l", ylim = c(0,2), 
     xlab = expression(delta[i]),
     ylab = expression(density(delta[i])))
par(mfrow=c(1,1))


###################################################
### code chunk number 30: gamma30
###################################################
getOption("SweaveHooks")[["fig"]]()
par(mfrow=c(2,2))
N <- 2000
x <- seq(0.0000001, 2, length.out = 4000)
y1 <- rgamma(N, shape = 1/3, scale = 3)
h1 <- hist(log(y1), main = "shape = 1/3", breaks = 50,  prob = TRUE,
      #     xlim = rockchalk::magRange(log(y1), c(1.25,1.25)),
           xlab = expression(log(delta[i])))

y2 <- rgamma(N, shape = 2/3, scale = 3/2)
hist(log(y2), main = "shape = 2/3", breaks = 50, prob = TRUE,
     # xlim = rockchalk::magRange(log(y1), c(1.25,1.25)),
           xlab = expression(log(delta[i])))


y3 <- rgamma(N, shape = 1/1, scale = 1)
hist(log(y3), main="shape = 1", breaks = 50, prob = TRUE,
      xlab = expression(log(delta[i])))
     
y4 <- rgamma(x, shape = 3/2, scale = 2/3)
hist(log(y4), main="shape = 1.5", breaks = 50, prob = TRUE,
xlab = expression(log(delta[i])))
par(mfrow=c(1,1))


###################################################
### code chunk number 31: gamma40
###################################################
getOption("SweaveHooks")[["fig"]]()
par(mfrow=c(2,2))
N <- 2000
x <- seq(0.0000001, 2, length.out = 4000)
y1 <- rgamma(N, shape = 2, scale = 1/2)
h1 <- hist(log(y1), main = "shape = 2", breaks = 50, prob = TRUE,
      #     xlim = rockchalk::magRange(log(y1), c(1.25,1.25)),
           xlim = c(-4, 2), 
           xlab = expression(log(delta[i])))

y2 <- rgamma(N, shape = 2.5, scale = 1/2.5)
hist(log(y2), main = "shape = 2.5", breaks = 50, prob = TRUE,
     # xlim = rockchalk::magRange(log(y1), c(1.25,1.25)),
     xlim = c(-4, 2), 
     xlab = expression(log(delta[i])))

y3 <- rgamma(N, shape = 5, scale = 1/5)
hist(log(y3), main="shape = 5", breaks = 50, prob = TRUE,
     xlim = c(-4, 2), 
     xlab = expression(log(delta[i])))
     
y4 <- rgamma(x, shape = 10, scale = 1/10)
hist(log(y4), main="shape = 10", breaks = 50, prob = TRUE,
     xlim = c(-4, 2), 
     xlab = expression(log(delta[i])))
par(mfrow=c(1,1))


###################################################
### code chunk number 32: warns
###################################################
warnings()


###################################################
### code chunk number 33: session
###################################################
sessionInfo()


