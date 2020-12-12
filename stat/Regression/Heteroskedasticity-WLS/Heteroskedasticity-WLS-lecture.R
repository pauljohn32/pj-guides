### R code from vignette source 'Heteroskedasticity-WLS-lecture.Rnw'

###################################################
### code chunk number 1: Heteroskedasticity-WLS-lecture.Rnw:24-25
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Heteroskedasticity-WLS-lecture.Rnw:90-91
###################################################
dir.create("plots", showWarnings=F)


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
### code chunk number 4: sim10
###################################################
Nsampsize <- 100
b0 <- 3; b1 <- 0.25; stde <- 10; mult <- 0.05
x <- rnorm(Nsampsize, m=50, sd=10)
meanx <- mean(x)
minx <- min(x)
e <- rnorm(Nsampsize)
y <- b0 + b1 * x + mult*(x-minx)*stde*e
mod <- lm(y~x)
plot(y~x, main="Heteroskedasticity")
abline(mod)


###################################################
### code chunk number 5: sim20
###################################################
Nsampsize <- 500
x <- rnorm(Nsampsize, m=50, sd=10)
meanx <- mean(x)
minx <- min(x)
simr <- function(i){
e <- rnorm(Nsampsize, m=0, s=1)
yhet <- b0 + b1 * x + mult*(x-minx)*stde*e
mod <- lm(yhet ~ x)
mod
}
nsims <- 1000
reshet <- lapply(1:nsims, simr)


###################################################
### code chunk number 6: sim21
###################################################
edemo <- rnorm(Nsampsize, m=0, s=1)
yhet <- b0 + b1 * x + mult*(x-minx)*stde*edemo
yhom <- b0 + b1 * x + stde*edemo
ylimhet <- c(0.9 * range(yhet)[1], 1.1*range(yhet)[2])
plot(yhet~x, main="Heteroskedastic Errors", ylim=ylimhet, ylab="Heteroskedastic y")
lapply(reshet, abline, col=gray(.7))
abline(b0,b1,col="red")


###################################################
### code chunk number 7: sim40
###################################################
b0 <- 3; b1 <- 0.25; stde <- 10;
simrhomo <- function(i){
e <- rnorm(Nsampsize, m=0, s=1)
yhom <- b0 + b1 * x + stde*e
mod <- lm(yhom ~ x)
mod
}
nsims <- 1000
reshomo <- lapply(1:nsims, simrhomo)


###################################################
### code chunk number 8: sim41
###################################################
edemo <- rnorm(Nsampsize, m=0, s=1)
plot(yhom~x, main="Homoskedastic Errors", ylim=ylimhet, ylab="Homoskedastic y")
lapply(reshomo, abline, col=gray(.70))
abline(b0,b1,col="red")


###################################################
### code chunk number 9: sim50
###################################################
cof <- sapply(reshet, coefficients)
cofhomo <- sapply(reshomo, coefficients)
par(mfrow=c(1,2))
hhet <- hist(cof[2,], prob=T, main="Heteroskedastic Data", xlab="Slope Est.")
lines(density(cof[2,]))
hist(cofhomo[2,], prob=T, xlim=range(hhet$breaks), main="Homoskedastic Data", xlab="Slope Est.")
lines(density(cofhomo[2,]))


###################################################
### code chunk number 10: sim60
###################################################
#b1hat <- vector(nsims, mode="numeric")
#res <- lapply(res, summary)
#for (i in 1:nsims){ b1hat[i] <- coefficients(res[[i]])[2,1]}
#
#hist(b1hat, breaks=20, probability=T, main="", xlab="Estimates of b1")
#lines(density(b1hat), lty=4)
#rb1hat <- range(b1hat)
#xseq <- seq(from=rb1hat[1],to=rb1hat[2],length.out=200)
#nseq <- dnorm(xseq, m=b1, s=0.1)
#lines(xseq, nseq, lty=1)
#
#legend("topright",legend=c("kernel density","True Sampling Dist"), lty=c(4,1))
#legend("topleft", #legend=c(paste("mean=",round(mean(b1hat),3)),paste("std.dev.=",round(sd(b1hat),3)) ))


###################################################
### code chunk number 11: gq09
###################################################
library(lmtest)
x <- rnorm(Nsampsize, m=50, sd=10)
e <- rnorm(Nsampsize)
y <- b0 + b1 * x + mult*(x-minx)*stde*e
dat <- data.frame(x,y)


###################################################
### code chunk number 12: gq10
###################################################
mymod <- lm(y~x)
gqtest(mymod, fraction=0.2, order.by= ~ x)


###################################################
### code chunk number 13: gq11
###################################################
plot(x,y, main="Scatter for Goldfield-Quandt Test")


