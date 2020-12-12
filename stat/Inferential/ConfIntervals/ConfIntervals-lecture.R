### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.hX3161/lyx_tmpbuf2/ConfIntervals-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: ConfIntervals-lecture.Rnw:28-29
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: ConfIntervals-lecture.Rnw:103-105
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par(no.readonly=T) 
#pjmar <- c(5.1, 5.1, 2.5, 2.1) 
#options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: stdnorm10
###################################################
mu <- 0
sd <- 1
x <- seq(mu-4*sd,mu+4*sd, by=0.05)
xden <- dnorm(x, m=mu, sd=sd)
plot(x, xden, type="l", main="", xlab=expression(hat(mu)), ylab="")
h <- 0.5*dnorm(-1.96*sd, m=mu, sd=sd)
arrows(-1.96, h, 1.96, h , angle=90, length=0.05, code=3)
text(0,0.5*h,"Confidence Interval",cex=0.5)


###################################################
### code chunk number 5: stdnorm20
###################################################
mu <- 0
sd <- 4
x <- seq(mu-4*sd,mu+4*sd, by=0.05)
xden <- dnorm(x, m=mu, sd=sd)
plot(x,xden, type="l", main="", xlab=expression(hat(mu)), ylab="")
h <- 0.5*dnorm(-1.96*sd, m=mu, sd=sd)
text(0,0.5*h,"Confidence Interval",cex=0.5)
arrows(-1.96*sd, h, 1.96*sd, h , angle=90, length=0.05,code=3)


###################################################
### code chunk number 6: stdnorm40
###################################################
mu <- 0
sd <- 1
x <- seq(mu-4*sd,mu+4*sd, by=0.05)
xden <- dnorm(x, m=mu, sd=sd)
xcum <- pnorm(x, m=mu, sd=sd)
plot(x, xcum, type="l", main="", xlab=expression(hat(mu)), ylab=expression(F(mu)))
text(1, 0.20*max(xcum), "CDF")


###################################################
### code chunk number 7: stdnorm50
###################################################
plot(x,xden, type="l", main="",xlab=expression(hat(mu)),ylab=expression(f(mu)))
text(0, 0.20*max(xden), "PDF")


###################################################
### code chunk number 8: T10
###################################################
x <- seq(-5,5,by=0.015)
denx <- dt(x, df=10)
plot(x, denx, main="", type="l",ylab="density", xlab="t distribution")
lines(x, dnorm(x), lty=2, col="red")
legend("topright",legend=c("T","Normal"),lty=c(1,2), col=c("black","red"))


###################################################
### code chunk number 9: T20
###################################################
qnorm(0.025, m=0, s=1)
qt(0.025, df=10)
qnorm(0.975, m=0, s=1)
qt(0.975, df=10)


###################################################
### code chunk number 10: ConfIntervals-lecture.Rnw:748-749
###################################################
(c(qt(0.025, 20), qt(0.975, 20)))


###################################################
### code chunk number 11: ConfIntervals-lecture.Rnw:754-755
###################################################
(c(qt(0.025, 50), qt(0.975, 50)))


###################################################
### code chunk number 12: ConfIntervals-lecture.Rnw:760-761
###################################################
(c(qt(0.025, 100), qt(0.975, 100)))


###################################################
### code chunk number 13: ConfIntervals-lecture.Rnw:766-767
###################################################
(c(qt(0.025, 250), qt(0.975, 250)))


###################################################
### code chunk number 14: cor10
###################################################
set.seed(234234)
N <- 25; stde <- 2; b <- 0.14
x <- rnorm(N, m=50, sd=10)
x <- x[order(x)]
y <- 0.3 + b*x + rnorm(N, m=0, sd=stde)
mx <- mean(x)
my <- mean(y)
rx <- range(x)
ry <- range(y)
cov(x,y)
plot(x,y, main="")


###################################################
### code chunk number 15: cor20
###################################################
options(digits=2)
plot(x,y, main="")
abline(h=my, lty=4, col="black")
abline(v=mx, lty=4, col="black")
mtext(bquote(widehat(E*group("[",list(x),"]")) ==.(mx)), side=1, line=2, at=mx)
mtext(bquote(widehat(E*group("[",list(y),"]")) ==.(my)), side=2, line=2, at=my)


###################################################
### code chunk number 16: cor30
###################################################
mycols <- ifelse((x-mx)*(y-my) > 0, "blue","red")
plot(x,y, main="", col=mycols)
abline(h=my, lty=4, col="black")
abline(v
=mx, lty=4, col="black")
mtext(bquote(widehat(E*group("[",list(x),"]")) ==.(mx)), side=1, line=2, at=mx)
mtext(bquote(widehat(E*group("[",list(y),"]")) ==.(my)), side=2, line=2, at=my)


###################################################
### code chunk number 17: cor40
###################################################
mycols <- ifelse((x-mx)*(y-my) > 0, "blue","red")
plot(x,y, main="", type="n", col=mycols)
abline(h=my, lty=4, col="black", lwd=0.7)
abline(v=mx, lty=4, col="black", lwd=0.7)
mtext(bquote(widehat(E*group("[",list(x),"]")) ==.(mx)), side=1, line=2, at=mx)
mtext(bquote(widehat(E*group("[",list(y),"]")) ==.(my)), side=2, line=2, at=my)
points(x[25],y[25])
arrows(x[25],my,x[25],.97*y[25], lty=2, lwd=1, code=3, length=0.1)
text(mx + 0.5*(x[25]-mx), y[25], label = expression(x-widehat(E*group("[",list(x),"]"))), pos=3)
arrows(mx,y[25],.97*x[25], y[25], lty=2, lwd=1, code=3, length=0.1)
text(x[25], my+0.5*(y[25]-my), label= expression(y-widehat(E*group("[",list(y),"]"))), pos=2)


###################################################
### code chunk number 18: cor110
###################################################
library(mvtnorm)
m1 <- c(0,0)
rho <- 0
sig0 <- matrix( c(1,rho, rho,1), nrow=2, ncol=2)

simCor <- function(N, mmean=NULL, msig=NULL) {
  xy <- rmvnorm(N, mean=mmean, sigma=msig)
  cor(xy[,1], xy[,2])
}

drawHist <- function(N=NULL, sig=NULL){
  cors <- sapply(rep(N,5000), simCor, mmean=m1 , msig=sig)
  cr <- range(cors)
 xlab <- bquote (paste("5000 Observed Correlations(", Sample== .(N),", ", rho== .(round(rho, 2)),')') )
  hist(cors, prob=T, xlim=cr, border=gray(.80), xlab=xlab, breaks=100, main="")
  lines(density(cors), col="red", lty=2, lwd=2)

  ind <- seq(cr[1], cr[2], length.out=100)
  cm1 <- round(mean(cors), 3)
  cs1 <- round(sd(cors), 3)
  nprob <- dnorm(ind, m=cm1, s=cs1)
  lines(ind, nprob, lty=1, col="black")
  nlab <-   bquote(paste("Normal(", .(round(cm1,3)),",", .(round(cs1,3))^2,")"))
  legend("topleft",legend=c("Kernel Density", as.expression(nlab)), lty=c(2,1), col=c("red","black"), lwd=c(1.5,1))
  legend("left", legend=c(paste("Obs. Mean=", cm1),paste("Obs. sd=",cs1)))
}


drawHist(N=30, sig=sig0 )


###################################################
### code chunk number 19: cor120
###################################################
rho=0.90
sig2 <- matrix( c(1, rho, rho, 1), nrow=2, ncol=2)
drawHist(N=30, sig=sig2)


###################################################
### code chunk number 20: cor130
###################################################
drawHist(N=2000, sig=sig2)


###################################################
### code chunk number 21: bin10
###################################################
SS <- 30
p <- 0.05
means <- replicate(2000, mean(rbinom(SS, size=1, p=p)))
hist(means, xlim=c(0,0.7), prob=T, breaks=20, main="", xlab="proportion successes observed")
mym <- round(mean(means),3)
obssd <- round(sd(means),3)
theomean <- pi
theosd <- round(sqrt(p*(1-p))/sqrt(SS), 3)
legend("topright", legend=c(paste("EV[x]=", p), paste("Obs.Mean=", mym), paste("Theo sd(mean)=", theosd), paste("Obs. sd(mean)=", obssd)))


###################################################
### code chunk number 22: bin15
###################################################
SS <- 500
p <- 0.05
means <- replicate(2000, mean(rbinom(SS, size=1, p=p)))
hist(means, xlim=c(0,0.7), prob=T, breaks=20, main="", xlab="proportion successes observed")
mym <- round(mean(means),3)
obssd <- round(sd(means),3)
theomean <- pi
theosd <- round(sqrt(p*(1-p))/sqrt(SS), 3)
legend("topright", legend=c(paste("EV[x]=", p), paste("Obs.Mean=", mym), paste("Theo sd(mean)=", theosd), paste("Obs. sd(mean)=", obssd)))


###################################################
### code chunk number 23: bin20
###################################################
SS <- 100
p <- 0.2
means <- replicate(2000, mean(rbinom(SS, size=1, p=p)))
hist(means, xlim=c(0,0.7), prob=T, breaks=20,main="", xlab="proportion successes observed")
lines(density(means))
mym <- round(mean(means),3)
obssd <- round(sd(means),3)
theomean <- 0.2
theosd <- round(sqrt(p*(1-p))/sqrt(SS), 3)
x <- seq(0,0.5, by =0.01)
lines(x, dnorm(x, m=theomean, sd=theosd), lty=2, col="red")
legend("topright", legend=c(paste("EV[x]=",p), paste("Obs. Mean=",mym),paste("Theo sd(mean)=", theosd), paste("Obs. sd(mean)=", obssd)))
legend("right", legend=c("Kernel Density",paste("Normal(", theomean, "," ,theosd, "^2)",sep="")), lty=c(1,2), col=c("black","red"))


