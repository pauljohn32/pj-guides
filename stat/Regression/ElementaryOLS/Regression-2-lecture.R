### R code from vignette source 'Regression-2-lecture.Rnw'

###################################################
### code chunk number 1: Regression-2-lecture.Rnw:31-32
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-2-lecture.Rnw:80-82
###################################################
unlink("plots2")
dir.create("plots2", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
#set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: line50
###################################################
library(rockchalk)
x <- c(0,8)
fest <- function(x){3.2 + 0.4*x}
y <- fest(x)
plot(y ~ x, type="l", xlab=expression(paste(x[i])), ylab=expression(paste(y[i])), ylim=c(0,10), xlim=c(-1,8), axes=F, lty=2, lwd=2)
axis(1, pos=0)
axis(2, pos=0) 
ftrue <- function(x){3 + 0.25*x}
lines(c(0,8), ftrue(c(0,8)), lty=1, lwd=2)
text(6, 1.15*fest(6), "estimated line")
text(2.5,0.85*ftrue(2.5), "true line")


###################################################
### code chunk number 5: sim5
###################################################
Nsampsize <- 100
set.seed(12345)
b0 <- 3; b1 <- 0.25; stde <- 10;
x <- rnorm(Nsampsize, m=0, sd=10);
simr <- function(i){
y <- b0 + b1 * x + stde*rnorm(Nsampsize)
myr <- lm(y ~ x)
}
nsims <- 1000
mregs <- lapply(1:nsims, simr)


###################################################
### code chunk number 6: sim6
###################################################
plot(x=seq(-2,10, length=20), y=seq(-1, 10, length=20), type="n", xlab="x", ylab="y")
for(i in 1:100){
abline(mregs[[i]], lty=i, col=i)
}


###################################################
### code chunk number 7: sim10
###################################################
res <- lapply(mregs, summary)
b1hat <- vector(nsims, mode="numeric")
for (i in 1:nsims){ b1hat[i] <- coefficients(res[[i]])[2,1]}

hist(b1hat, breaks=20, probability=T, main="", xlab="Estimates of b1")
lines(density(b1hat), lty=4)
rb1hat <- range(b1hat)
xseq <- seq(from=rb1hat[1],to=rb1hat[2],length.out=200)
nseq <- dnorm(xseq, m=b1, s=0.1)
lines(xseq, nseq, lty=1)

legend("topright",legend=c("Simulated kde","Theoretical"), lty=c(4,1))
legend("topleft", legend=c(paste("mean=",round(mean(b1hat),3)),paste("std.dev.=",round(sd(b1hat),3)) ))


###################################################
### code chunk number 8: t10
###################################################
x <- seq(-4,4, length.out=100)
probx <- dt(x, df=100)
plot(x, probx, type="l", xlab="t", ylab="probability density")
tcritl <- qt(0.025, df=100)
tcrith <- qt(0.025, df=100, lower.tail=FALSE)
lines( c(tcritl, tcritl), c(0, dt(tcritl, df=100)), lty=4)
lines( c(tcrith, tcrith), c(0, dt(tcrith, df=100)), lty=4)
mtext(bquote("critical value" == .(tcritl)), side=1, at=tcritl, line=2)
mtext(bquote("critical value" == .(tcrith)), side=1, at=tcrith, line=2)


###################################################
### code chunk number 9: sim30
###################################################
tb1hat <- vector(nsims, mode="numeric")
for (i in 1:nsims){ tb1hat[i] <- (coefficients(res[[i]])[2,1]-b1)/coefficients(res[[i]])[2,2]}
hist(tb1hat, breaks=20, probability=T, main="", xlab=expression( hat(t) == (hat(b)[1]-b[1])/s.e.(hat(b)[1])))
lines(density(tb1hat), lty=4)
rtb1hat <- range(tb1hat)
xseq <- seq(from=rtb1hat[1],to=rtb1hat[2],length.out=200)
lines(xseq, dt(xseq, df=98))
legend("topleft", legend=c("Theoretical", "Simulated kde"), lty=c(1,4))


###################################################
### code chunk number 10: sim50
###################################################
rmse <- vector(nsims, mode="numeric")
for (i in 1:nsims){ rmse[i] <- res[[i]]$sigma}
hist(rmse, breaks=20, probability=T, main="", xlab="RMSE (est. std. dev. of error term)")
lines(density(rmse), lty=4)
legend("topright",legend=c(paste("mean=",round(mean(rmse),3)),paste("std.dev.=",round(sd(rmse),3)) ))


###################################################
### code chunk number 11: inced60
###################################################
require(car)
incedmod1 <- lm(income~education, data=Prestige)
summary(incedmod1)


###################################################
### code chunk number 12: inced61
###################################################
incedvcov <- vcov(incedmod1)
incedvcov


###################################################
### code chunk number 13: inced61B
###################################################
sqrt(diag(incedvcov))


###################################################
### code chunk number 14: sim31
###################################################
tb1 <- vector(nsims, mode="numeric")
for (i in 1:nsims){ tb1[i] <- coefficients(res[[i]])[2,3]}
hist(tb1, breaks=20, probability=T, main="", xlab="1000 t ratios", xlim=c(-2,7))
nnotsig <- length(which(tb1< 1.983))  ##qt(0.025, df=100)))
lines(density(tb1), lty=4)
rtb1 <- range(tb1)
xseq <- seq(from=rtb1[1],to=rtb1[2],length.out=200)
legend("topright", legend=c("Simulated t stats", paste("mean=",round(mean(tb1),3)),paste("std.dev.=",round(sd(tb1),3)) ))
text(-1.4, 0.13, pos=4, labels=c(paste("    ",nnotsig,"\nsample estimates\n not significant \n at 0.05")))
rtb1 <- range(tb1)
xseq <- seq(from=-2,to=rtb1[2],length.out=200)
lines(xseq, dt(xseq, df=98))
text(-1.2, 0.3, "t dist")


###################################################
### code chunk number 15: t11
###################################################
x <- seq(-4,4, length.out=100)
probx <- dt(x, df=100)
plot(x, probx, type="l", xlab="t", ylab="probability density", main="")
tcritl <- qt(0.025, df=100)
tcrith <- qt(0.025, df=100, lower.tail=FALSE)
lines( c(tcritl, tcritl), c(0, dt(tcritl, df=100)), lty=4)
lines( c(tcrith, tcrith), c(0, dt(tcrith, df=100)), lty=4)
mtext(bquote("critical value" == .(tcritl)), side=1, at=tcritl, line=2)
mtext(bquote("critical value" == .(tcrith)), side=1, at=tcrith, line=2)


###################################################
### code chunk number 16: t12
###################################################
x <- seq(-4,4, length.out=100)
probx <- dt(x, df=100)
plot(x, probx, type="l", xlab="t", ylab="probability density", main="")
tcrith <- qt(0.05, df=100, lower.tail=FALSE)
lines( c(tcrith, tcrith), c(0, dt(tcrith, df=100)), lty=4)
mtext(bquote("critical value" == .(tcrith)), side=1, at=tcrith, line=2)


###################################################
### code chunk number 17: inced63
###################################################
confint(incedmod1)


###################################################
### code chunk number 18: sim40
###################################################
rsq <- vector(nsims, mode="numeric")
for (i in 1:nsims){ rsq[i] <- res[[i]]$r.square}
hist(rsq, breaks=20, probability=T, main="", xlab="R square")
lines(density(rsq), lty=4)
legend("topright",legend=c(paste("mean=",round(mean(rsq),3)),paste("std.dev.=",round(sd(rsq),3)) ))


###################################################
### code chunk number 19: wrong10
###################################################
b0 <- 2
b1 <- 3
plot(x=seq(0,10, length=10), y=seq(0,40, length=10), type="n", xlab="x", ylab="y")
abline(a=b0, b=b1, lwd=2)
abline(a=b0+8, b=b1, lty=3, col=gray(0.8), lwd=2)
abline(a=b0-8, b=b1, lty=3, col=gray(0.8), lwd=2)
text(1, 35, labels="Don't do this! \n it is wrong!")
arrows(4, b0+b1*4,	4, (b0+8)+b1*4 , angle=90, length=0.05, code=3)
text(4, (b0+8)+b1*4 , labels=expression(hat(y) + 2 %*% rmse), pos=2)
arrows(5, b0+b1*5,	5, (b0-8)+b1*5 , angle=90, length=0.05, code=3)
text(5.2, (b0-8)+b1*5 , labels=expression(hat(y) - 2 %*% rmse), pos=4)


###################################################
### code chunk number 20: RMSE10
###################################################
x <- rnorm(100, m=50,s=10)
y <- 2 + 3 * x + 80 * rnorm(100)
plot(x,y, type="n",xlab="Indep. Var.", ylab="Dep. Var",ylim=c(0,350))
for(i in 1:100){
  y <- 2 + 3 * x + rnorm(100, m=0, s=80)
  mod <- lm (y ~ x)
  abline(mod,col=gray(.80))
}
points(x,y)


###################################################
### code chunk number 21: pom1
###################################################
predictOMatic(incedmod1, predVals = list(education = "quantile"), n = 10, interval = "confidence")


###################################################
### code chunk number 22: pom2
###################################################
predictOMatic(incedmod1, predVals = list(education = "quantile"), n = 10, interval = "prediction")


###################################################
### code chunk number 23: inced660
###################################################
plotSlopes(incedmod1, plotx = "education", interval = "confidence")


###################################################
### code chunk number 24: inced670
###################################################
plotSlopes(incedmod1, plotx = "education", interval = "prediction", col = "red")


###################################################
### code chunk number 25: chile10
###################################################

require(car)
cmod10 <- lm(statusquo~income, data=Chile)
outreg(cmod10, showAIC=F, float=F)


###################################################
### code chunk number 26: chile10sum
###################################################
summary(cmod10)


###################################################
### code chunk number 27: chile20
###################################################
library(car)
Chile$income2 <- Chile$income/1000000
cmod20 <- lm(statusquo~income2, data=Chile)
outreg(cmod20, showAIC=F, float=F)


###################################################
### code chunk number 28: chile20sum
###################################################
summary(cmod20)


###################################################
### code chunk number 29: int10
###################################################
x <- rpois(100, lambda=7) + 7
y <- 1012 + 122*x + 250*rnorm(100)
plot(x,y, xlab="education",ylab="income",xlim=c(0, max(x)), ylim=c(0, max(y)))
abline(lm(y~x))


###################################################
### code chunk number 30: int20
###################################################
oldx <- x
x <- x- min(x)
plot(x,y, xlab="education - 7", ylab="income", ylim=c(0, max(y)))
abline(lm(y~x))


###################################################
### code chunk number 31: int30
###################################################
x <- oldx- mean(oldx)
plot(x, y, xlab="mean centered education",ylab="income")
dat <- data.frame(x,y)
newx <- seq( min(x), max(x), length=100)
mod <- lm(y ~ x, data=dat)
axis(2, pos=0, labels=F)
abline(v=0)
p1 <-  predict(mod, newdata=data.frame(x=newx), interval=c("prediction"))
p2 <-  predict(mod, newdata=data.frame(x=newx), interval=c("confidence"))
lines(newx, p1[,1], lty=1)
lines(newx, p1[,2], lty=2)
lines(newx, p1[,3], lty=3)
lines(newx, p2[,2], lty=4)
lines(newx, p2[,3], lty=5)


###################################################
### code chunk number 32: Regression-2-lecture.Rnw:1236-1237
###################################################
outreg(lm(y~oldx), showAIC=F)


###################################################
### code chunk number 33: Regression-2-lecture.Rnw:1242-1243
###################################################
outreg(lm(y~x), showAIC=F)


###################################################
### code chunk number 34: beta05
###################################################
x <- rnorm(100)
y <- 1 + 5*x + 10*rnorm(100)
dat <- data.frame(x =as.numeric(scale(x, scale=T, center=T)),
y = as.numeric(scale(y, scale=T, center=T)))
modbeta <- lm(y ~ x -1, data = dat)
outreg(modbeta, tight=F, showAIC=F)


###################################################
### code chunk number 35: beta10
###################################################
plot(x,y, xlab="Standardized x", ylab="Standardized y")
abline(v=c(-2,-1,0,1,2)*sd(x),lty=4)
abline(h=c(-2,-1,0,1,2)*sd(y), lty=2)
abline(modbeta)


