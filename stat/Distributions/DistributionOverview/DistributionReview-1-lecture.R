### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.hX3997/lyx_tmpbuf2/DistributionReview-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: DistributionReview-1-lecture.Rnw:24-25
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: DistributionReview-1-lecture.Rnw:80-81
###################################################
dir.create("plots2", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
#set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: simple10
###################################################
x <- 1:6
y <- rep(1/6, 6)
barplot(y, names.arg=x, col=gray(0.85), ylim = c(0, 1), space = 0)
title("All 6 outcomes are equally likely")


###################################################
### code chunk number 5: d10
###################################################
x <- 0:10
y <- dpois(x, lambda=4.5)
barplot(y, names.arg=x, col=gray(0.85), space=0)


###################################################
### code chunk number 6: c00
###################################################
x <- seq(from=00.01, to=10, by=0.1)
y <- dgamma(x,shape=2,scale=1) 
plot(x, y, type="l",xlab="x",ylab="",main="")
polygon(x=c(0,x,10),y=c(0,y,0), col=gray(0.850))


###################################################
### code chunk number 7: d20
###################################################
x <- 0:10
y <- dpois(x, lambda=4.5)
barplot(y, names.arg=x, col=c(rep(gray(0.70),3),rep(gray(0.95),10)), space=0)


###################################################
### code chunk number 8: d25
###################################################
x <- 0:10
y <- dpois(x, lambda=4.5)
barplot(y, names.arg=x, col=c(rep(gray(0.95),3),rep(gray(0.70),1),rep(gray(0.95),10)), space=0)


###################################################
### code chunk number 9: d30
###################################################
x <- 0:10
y <- dpois(x, lambda=4.5)
barplot(y, names.arg=x, col=c(rep(gray(0.95),3), rep(gray(0.70),4),rep(gray(0.95),10)), space=0)


###################################################
### code chunk number 10: c20
###################################################
x <- seq(from=0,to=1,by=0.01)
y <- 2+exp(0.02*x)+1.2*sin(pi*(2*x))+1.8*cos(4*pi*x)
plot(x, y, type="l",xlab="x",ylab="",main="")
text( x[15], 0.95*y[15], expression(f(x)), pos=1 )
xss <- seq(0.3, 0.5, by=0.01)
yss <- 2+exp(0.02*xss)+ 1.2*sin(pi*(2*xss))+ 1.8*cos(4*pi*xss)
polygon(x=c(xss[1], xss, xss[length(xss)] ), y=c(0, yss, 0), col=gray(0.80))
mtext(c("0.3", "0.5"), 1, line=1, at=c(0.3, 0.5))


###################################################
### code chunk number 11: c30
###################################################
x <- seq(from=0,to=1,by=0.01)
y <- 2+exp(0.02*x)+1.2*sin(pi*(2*x))+1.8*cos(4*pi*x)
plot(x, y, type="l",xlab="x",ylab="",main="")
text( x[20], y[20], expression(f(x)), pos=1 )
xss <- seq(0.3, 0.5, by=0.01)
yss <- 2+exp(0.02*xss)+ 1.2*sin(pi*(2*xss))+ 1.8*cos(4*pi*xss)
polygon(x=c(xss[1], xss, xss[length(xss)] ), y=c(0, yss, 0), col=gray(0.80))
xss2 <- seq(0.5, 0.7, by=0.01)
yss2 <- 2+exp(0.02*xss2)+ 1.2*sin(pi*(2*xss2))+ 1.8*cos(4*pi*xss2)
polygon(x=c(xss2[1], xss2, xss2[length(xss2)] ), y=c(0, yss2, 0), col=gray(0.70))
mtext(c("0.3", "0.5","0.7"), 1, line=1, at=c(0.3, 0.5,0.7))


###################################################
### code chunk number 12: simple20
###################################################
x <- 1:6
y <- rep(1/6, 6)
barplot(y, names.arg=x, col=gray(0.85), ylim = c(0, 1), space = 0)
title("Expected Value: 3.5")


###################################################
### code chunk number 13: simple21
###################################################
x <- 0:7
xpois <- dpois(x, lambda = 1.5)
plot(x, xpois, type = "h", ylim = c(0,1))
points(x, xpois)
title("Expected Value: 1.5")


###################################################
### code chunk number 14: a10
###################################################
rate <- 1
upper <- 10 
xvals <- seq(0,upper,by=0.02)
yvals1 <- dexp(xvals, rate=rate)
plot (xvals, yvals1, type="l", main="", xlab="x",ylab="probability")
text(.7*max(xvals), .7*max(yvals1), label=bquote(f(x)==exp(-x)))


###################################################
### code chunk number 15: a11
###################################################

rate <- 2
upper <- 10
xvals <- seq(0,upper,by=0.02)
yvals1 <- dexp(xvals, rate=rate)
plot (xvals, yvals1, type="l", xlab="x",ylab="probability")

rate <- 1
upper <- 10
xvals <- seq(0,upper,by=0.02)
yvals1 <- dexp(xvals, rate=rate)
lines(xvals, yvals1, lty=2)

rate <- 0.2
upper <- 10
xvals <- seq(0,upper,by=0.02)
yvals1 <- dexp(xvals, rate=rate)
lines(xvals, yvals1, lty=3)

legend("topright", legend=as.expression(c(bquote(lambda == 2.0), bquote(lambda == 1.0),  bquote(lambda == 0.2))), lty=c(1,2,3))


###################################################
### code chunk number 16: a20
###################################################
x <- seq(from=-3,to=3,by=0.1)
y <- exp(-0.5*x^2)
plot(x, y, type="l",xlab="x",ylab="",main="")
text( 2, 0.75*max(y), label=expression(exp(-x^2)))
abline(v=0,lty=4)


###################################################
### code chunk number 17: n10
###################################################
mu <- c(3,-5, 6)
sigma <- 5
x <- seq(from=mu[1]-3*sigma,to=mu[1]+3*sigma,by=0.2)
y1 <- dnorm(x, mean=mu[1], sd=sigma, log=F)
plot(x, y1, type="l", main="", xlab="x",ylab="probability of x", xlim=c(-20,20), ylim=c(0,.12))
x2 <- seq(from=mu[2]-3*sigma,to=mu[2]+3*sigma,by=0.2)
y2 <- dnorm(x2, mean=mu[2], sd=sigma, log=F)
lines(x2,y2, lty=2)
x3 <- seq(from=mu[3]-3*sigma,to=mu[3]+3*sigma,by=0.2)
y3 <- dnorm(x3, mean=mu[3], sd=sigma, log=F)
lines(x3,y3, lty=3)
abline(v = c(mu[1], mu[2],mu[3]), lty = c(1,2,3), lwd = 0.3, col = "gray70")
legend("topright", legend = as.expression(c(bquote(mu == .(mu[1])), bquote(mu == .(mu[2])), bquote(mu == .(mu[3])))), lty=c(1,2,3) )


###################################################
### code chunk number 18: n20
###################################################
m1 = 10
sd1 = 20
x <- seq(m1 - 3 * sd1, m1 + 3 * sd1, length = 200)
prob1 <- dnorm(x, m = m1, sd = sd1)
plot(x, prob1, ylab = "Probability Density", main = "", 
      type = "l", ylim = c(0, max(prob1) * 1.3))
m2 = -4
sd2 = 15
prob2 <- dnorm(x, m = m2, sd = sd2)
lines(x, prob2, lty = 2)
legend("topright", legend = c(paste("mu=", m1, 
      "sigma=", sd1), paste("mu=", m2, "sigma=", 
      sd2)), lty = 1:2)
abline(h = seq(0, max(prob1), length.out = 5), 
      lty = 5, lwd = 0.3, col = "gray70")
abline(v = c(m1, m2), lty = 5, lwd = 0.3, col = "gray70")


###################################################
### code chunk number 19: Gamma1
###################################################
xvals <- seq(0,10,length.out=1000)
gam1 <- dgamma(xvals, shape=1, scale=1)
gam2 <- dgamma(xvals, shape=2, scale= 1)
plot(xvals, gam1, type="l", xlab="x",ylab="Gamma probability density",  ylim=c(0,1))
lines(xvals, gam2, lty=2)
text(.4, .7, "shape=1, scale=1", pos=4, col=1)
text(3, .2, "shape=2, scale=1", pos=4, col=1)


###################################################
### code chunk number 20: Gamma2
###################################################
x <- seq(0,10,length.out=1000)
alpha <- c(1,2.5, 5)
y1 <- x^(alpha[1]-1)*exp(-x)
y2 <- x^(alpha[2]-1)*exp(-x)
y3 <- x^(alpha[3]-1)*exp(-x)
plot(x, y1, type="l", xlab="x", ylab=expression(paste(x^{alpha-1}*e^{-x})),  ylim=c(0,6))
lines(x, y2, lty=2)
lines(x, y3, lty=3)
legend("topright",legend=c(expression(paste(alpha==1)),expression(paste(alpha==2.5)),expression(paste(alpha==5))), lty=c(1,2,3))


###################################################
### code chunk number 21: Gamma20
###################################################
xvals <- seq(0,10,length.out=1000)
gam1 <- dgamma(xvals, shape=2, scale=1/2)
gam2 <- dgamma(xvals, shape=10, scale= 1/10)
gam3 <- dgamma(xvals, shape=50, scale= 1/50)
plot(xvals, gam1, type="l", xlab="x",ylab="Gamma probability density",  ylim=c(0,2))
lines(xvals, gam2, lty=2)
lines(xvals, gam3, lty=3)
legend("topright", legend=c("alpha=2","alpha=10","alpha=50"),lty=c(1,2,3))


###################################################
### code chunk number 22: Beta10
###################################################
x <- seq(0,1,by=.005)
b1 <- c(3, 0.7, 1.2)
b2 <- c(5.6, 0.58, 0.2)
pbeta1 <- dbeta(x, b1[1],b2[1])
pbeta2 <- dbeta(x, b1[2],b2[2])
pbeta3 <- dbeta(x, b1[3],b2[3])
plot(x, pbeta1, type="n", xlab="x",ylab="Probability Density",ylim=c(0,4))
lines(x,pbeta1, lty=1)
lines(x,pbeta2, lty=2)
lines(x,pbeta3, lty=3)
legend(0.55, 3.5, legend=c("Beta(3,5.6)","Beta(0.7, 0.58)","Beta(1.2,0.2)"),lty=1:3)


###################################################
### code chunk number 23: ChiSquare1
###################################################
xvals <- seq(0,30,length.out=1000)
chisquare1 <- dchisq(xvals, df=5)
chisquare2 <- dchisq(xvals, df=10)
chisquare3 <- dchisq(xvals, df=20)
plot(xvals, chisquare1, type="l", xlab=expression(chi^2), ylab="probability density",  ylim=c(0,0.4), main="")
lines(xvals, chisquare2, lty=2)
lines(xvals, chisquare3, lty=3)
legend("topright",legend=(c(expression(nu==5), expression(nu==10),expression(nu==20))),lty=1:3)


###################################################
### code chunk number 24: ChiSquare20
###################################################
xvals <- seq(0,80,length.out=1000)
chisquare <- dchisq(xvals, df=50)
plot(xvals, chisquare, type="l", xlab=expression(chi^2), ylab="probability density",  ylim=c(0,0.10), main="")
critVal <- qchisq(0.05, df=50, lower.tail=F)
chiAtCrit <- dchisq(critVal, df=50)
lines(c(critVal,critVal), c(0, chiAtCrit), lty=4)
abline(h=0, lwd=0.5)
mtext(expression(hat(k)), side=1, line=1, at=critVal)
xvals <- seq(critVal, 80, length.out=50)
polygon( x=c(xvals, xvals[50], sort(xvals,decreasing=T), critVal), 
      y=c(dchisq(xvals,df=50), 0, rep(0,50), 0), col=gray(.90)) 
text(74, 0.018, expression(area == 1-F(hat(k))))


###################################################
### code chunk number 25: t05
###################################################
x <- seq(-4,4, length.out=1000)
px1 <- dt(x, df=1)
px2 <- dt(x, df=5)
px3 <- dt(x, df=20)
px4 <- dt(x, df=100)
plot(x, px1, xlab="t",ylab="probability density of t",type="l", ylim=c(0,0.5))
lines(x,px2, lty=2)
lines(x,px3, lty=3)
lines(x,px4, lty=4)
legend("topright",legend=c("df=1","df=5", "df=20", "df=100"),lty=1:4)


###################################################
### code chunk number 26: t10
###################################################
x <- seq(0,4, length.out=200)
y <- matrix(0, ncol=5, nrow=200)
y[,1] <- dt(x, df=1)
y[,2] <- dt(x, df=2)
y[,3] <- dt(x, df=5)
y[,4] <- dt(x, df=20)
y[,5] <- dt(x, df=1000)
matplot(x,y,  type="l",ylab="probability density", col="black")
lines(x, dnorm(x),lty=2, lwd=3)
text(0, 0.225, expression(t(nu==1)),pos=4)
text(-0.2, 0.33, expression(t(nu==2)),pos=4)
text(1.0, 0.25, pos=4, expression(t(nu==1000)))
text(1.05, 0.23, pos=4, "N(0,1)")
legend("topright",legend=c(expression(nu==1),expression(nu==2),expression(nu==5),expression(nu==20),expression(nu==1000),"N(0,1)"),lty=c(1:5,2), lwd=c(1,1,1,1,1,3))


###################################################
### code chunk number 27: t30
###################################################
mint <- -4; maxt <- 4
x <- seq(mint,maxt,length.out=1000)
myt <- dt(x, df=50)
plot(x, myt, type="l", xlab="t", ylab="probability density",  ylim=c(0,0.40), main="")
abline(h=0, lwd=0.5)
critValH <- qt(0.025, df=50, lower.tail=F)
statAtCritH <- dt(critVal, df=50)
lines(c(critValH,critValH), c(0, statAtCritH), lty=4)
xvals <- seq(critValH, maxt, length.out=50)
polygon( x=c(xvals, xvals[50], sort(xvals,decreasing=T), critValH), 
      y=c(dt(xvals,df=50), 0, rep(0,50), 0), col=gray(.90)) 
##Stupidly repeat same code for lower side
critValL <- qt(0.025, df=50, lower.tail=T)
statAtCritL <- dt(critVal, df=50)
lines(c(critValL,critValL), c(0, statAtCritL), lty=4)
xvals <- seq(mint, critValL,  length.out=50)
polygon( x=c(xvals, xvals[50], mint), 
      y=c(dt(xvals,df=50), 0, 0), col=gray(.90)) 


###################################################
### code chunk number 28: F20
###################################################
nu1 <- c(25,100,200)
nu2 <- c(25,50,100,200)
x <- seq(0.2, 5, length = 200)
dF11 <- df(x, nu1[1], nu2[1])
dF22 <- df(x, nu1[1], nu2[2])
dF23 <- df(x, nu1[2], nu2[3])
dF31 <- df(x, nu1[2], nu2[4])
dF33 <- df(x, nu1[3], nu2[3])
plot(x, dF11, ylab = "Probability Density", main = "", 
      type = "l", ylim=c(0,1.5))
lines(x, dF22, lty = 2)
lines(x, dF23, lty = 3)
lines(x, dF31, lty = 4)
lines(x, dF33, lty = 5)
legend("topright", legend = 
c(expression(paste(nu[1]==25,",", nu[2]==25)),
expression(paste(nu[1]==25,",", nu[2]==50)),
expression(paste(nu[1]==100,",", nu[2]==100)),
expression(paste(nu[1]==100,",", nu[2]==200)),
expression(paste(nu[1]==200, ",", nu[2]==100))), lty=1:6)


###################################################
### code chunk number 29: F10
###################################################
nu1 <- c(1,25,100,1000)
x <- seq(0.1,6, length = 200)
dF11 <- df(x, nu1[1], nu1[1])
dF22 <- df(x, nu1[2], nu1[2])
dF33 <- df(x, nu1[3], nu1[3])
dF44 <- df(x, nu1[4], nu1[4])
plot(x, dF11, ylab = "Probability Density", main = "", 
      type = "l", ylim=c(0,1.5))
lines(x, dF22, lty = 2)
lines(x, dF33, lty = 3)
lines(x, dF44, lty = 4)
abline(h=0, lwd=0.3, col=gray(.9))
legend("topright", legend = 
c(expression(paste(nu[1]==1,",", nu[2]==1)),
expression(paste(nu[1]==25,",", nu[2]==25)),
expression(paste(nu[1]==100,",", nu[2]==100)),
expression(paste(nu[1]==1000,",", nu[2]==1000))), lty=1:4)


###################################################
### code chunk number 30: Binomial10
###################################################
par(mfcol=c(1,2))
x <- 0:10
y <- dbinom(x, p=0.66, size=10)
plot(x,y, type="h", lty=4, xlab="10 Flips with a Biased Coin", ylab="Chance of Observing x Heads")
points(x,y,pch=16)
 y <- c(y[1],y)
x <- c(-1, x)
plot(x+0.5,y, type="s", lty=4, xlab="10 Flips with a Biased Coin", ylab="Chance of Observing x Heads")
par(mfcol=c(1,1))


###################################################
### code chunk number 31: Binomial20
###################################################
N <- 437; p<- 0.63; x1 <- max(0, N*p-4*sqrt(p*(1-p)*N)); x2 <- min(N*p+4*sqrt(p*(1-p)*N),N)
x <- as.integer(x1): as.integer(x2+1)
pseq <- dbinom(x, N, p)
plot(x, pseq, type="h", xlab="k", ylab=paste("Prob(k, N=",N,", p=", p,")"))
points(x, pseq, pch=18,cex=0.5)


###################################################
### code chunk number 32: Pois50
###################################################
x <- 0:10
y <- dpois(x, lambda=1.3)
par(mfcol=c(1,2))
plot(x,y, type="h", lty=4, xlab=expression(x ~~ group("(",lambda==1.3,")")) , ylab="Probability")
points(x,y, pch=16)
y <- dpois(x, lambda=4.0)
plot(x,y, type="h", lty=4, xlab=expression(x ~~ group("(",lambda==4.0,")")) , ylab="Probability")
points(x,y, pch=16)
par(mfcol=c(1,1))


