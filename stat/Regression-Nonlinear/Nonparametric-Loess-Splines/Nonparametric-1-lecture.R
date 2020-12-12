### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM6266/lyx_tmpbuf0/Nonparametric-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Nonparametric-1-lecture.Rnw:24-25
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Nonparametric-1-lecture.Rnw:86-87
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: 2a
###################################################
#setting seed so this thing looks the same every time!
set.seed(2314)
x <- 10 * runif(100)
y <- 5*sin(x)+rnorm(100)
dat <- data.frame(x,y)
dat <- dat[order(dat$x), ]
x <- dat$x
y <- dat$y
plot (x, y, main="Curvish data from Locfit example", pch=16)


###################################################
### code chunk number 5: 2b
###################################################
plot (x, y, main="Curvish data from Locfit example", pch=16)
abline(lm(y~x))


###################################################
### code chunk number 6: 4
###################################################
mymod1 <- lm(y ~ x+I(x^2), data = dat)
summary(mymod1)
ndat  <- data.frame(x = seq(0,10, length.out = 100))
predict1 <- predict(mymod1, newdata = ndat)
plot(x, y, main = "Adding x squared", pch = 16)
lines(ndat$x, predict1) 


###################################################
### code chunk number 7: 5
###################################################
summary(mymod1)


###################################################
### code chunk number 8: 6
###################################################
mymod2 <- lm(y~x+I(x^2)+I(x^3)+I(x^4), data=dat)
summary(mymod2)
newx <- seq(0,10, length.out=100)
predict2 <- predict(mymod2, newdata=data.frame(x=newx))
plot(x, y, main = expression(paste("Adding ", x^2, ",", x^3, ", and ", x^4)), pch=16)
lines(newx,predict2)


###################################################
### code chunk number 9: 7a
###################################################
knot <- c(1.8, 4.2, 8.0)
thedf <- data.frame(x=x, y=y)
thedf <- thedf[order(thedf$x),]

#handy function to create "plus variables"
createplusvar <- function(input,k) { it <- ifelse(input > k, input-k, 0)}
thedf$xp1 <- createplusvar(thedf$x, knot[1])
thedf$xp2 <- createplusvar(thedf$x, knot[2])
thedf$xp3 <- createplusvar(thedf$x, knot[3])
mymod0 <- lm (y ~ x + xp1 + xp2 + xp3, data = thedf)
newx <- seq(round(min(x),1), round(max(x)+0.5,1),by=0.1)
newdf <- data.frame(x = newx, xp1 = createplusvar(newx, knot[1]),  xp2 = createplusvar(newx,knot[2]), xp3 = createplusvar(newx,knot[3]))
newdf$pred <- predict(mymod0, newdata = newdf)
mytitle <- paste ("Manual Regression spline knots", knot[1], knot[2], knot[3])
plot(thedf$x, thedf$y, main = mytitle, type = "n")
points(thedf$x, thedf$y, pch = 16, cex = 0.5)
lines(newdf$x, newdf$pred)
rm(thedf, mymod0, newdf)


###################################################
### code chunk number 10: 7b
###################################################
library(segmented)
mymod0 <- lm(y ~ x)
segmod <- segmented(mymod0, seg.Z = ~x, psi=list(x = c(1.8,4.2,8.0)), it.max = 200)
summary(segmod)
mynewdf <- data.frame(x=x, fitted = segmod$fitted.values)
mynewdf <- mynewdf[order(mynewdf$x),]
plot(x, y, main = "Lines, cutpoints estimated by segmented", pch = 16)
lines(mynewdf$x, mynewdf$fitted)
detach("package:segmented")


###################################################
### code chunk number 11: 7c
###################################################
library(mda)
mymars <- mars(x, y, degree=1) 
summary(mymars)
mymars$cuts
mymars$gcv 
mydf <- data.frame(x, y, fitted = mymars$fitted)
mydf <- mydf[order(mydf$x),]
plot(x, y, main = "Linear splines: mars output", pch = 16)
lines(mydf$x,mydf$fitted)
rm(mymars)


###################################################
### code chunk number 12: 7d
###################################################
library(mda)
mymars2 <- mars(x,y, degree=1, nk=6) 
summary(mymars2)
mymars2$gcv 
mymars2$cuts
mydf <- data.frame(x,y,fitted=mymars2$fitted)
mydf <- mydf[order(mydf$x),]
plot(x,y,main="Linear splines: mars output nk=6", pch=16)
lines(mydf$x,mydf$fitted)
rm(mymars2, mydf)
detach("package:mda")


###################################################
### code chunk number 13: 8
###################################################
plot(seq(-1,10,length.out=100), type="n", axes=F,ylab="", xlab="",xlim=c(-1,11), ylim=c(-1,1))

axis(1, at = c(0,4,5,7,9,10), labels = expression(tau[0], tau[1], tau[2], tau[3], tau[4], tau[5]))


###################################################
### code chunk number 14: 9b
###################################################
knots<- c(1.7,4.63,7.9)
int0 <- ifelse (x<knots[1], 1, 0)
xp0 <- ifelse (x<knots[1], x, 0)
int1 <- ifelse(x>knots[1]&x<knots[2], 1, 0)
xp1 <- ifelse(x>knots[1]&x<knots[2], x, 0)
int2 <- ifelse(x>knots[2]&x<knots[3], 1, 0)
xp2 <- ifelse(x>knots[2]&x<knots[3], x, 0)
int3<- ifelse( x>knots[3],1,0)
xp3 <- ifelse(x>knots[3], x, 0)

mycubic <- lm(y~-1+ int0+ xp0+ I(xp0^2)+ I(xp0^3) + int1+ xp1+ I(xp1^2) + I(xp1^3)+ int2 + xp2 + I(xp2^2)+ I(xp2^3)+ int3+ xp3+I(xp3^2)+I(xp3^3))
b<-coef(mycubic)
newx <- seq(round(min(x)),ceiling(max(x)),length=200)
y1 <- b[1]+b[2]*newx +b[3]*newx^2+b[4]*newx^3
y1 <- ifelse(newx <= knots[1], y1, NA)
y2 <- b[5]+b[6]*newx +b[7]*newx^2+b[8]*newx^3
y2 <- ifelse(newx > knots[1] & newx <= knots[2], y2, NA)
y3 <- b[9]+b[10]*newx +b[11]*newx^2+b[12]*newx^3
y3 <- ifelse(newx > knots[2] & newx <= knots[3], y3, NA)
y4 <- b[13]+b[14]*newx +b[15]*newx^2+b[16]*newx^3
y4 <- ifelse(newx > knots[3], y4, NA)
plot(x,y,main="Unrestricted cubic splines",type="n",xlab="x",ylab="y")
lines(newx,y1)
lines(newx,y2)
lines(newx,y3)
lines(newx,y4)
points(x,y,cex=0.4)
rm (newx,y1, y2, y3, y4,int0,int1,int2,int3)


###################################################
### code chunk number 15: 10
###################################################
library(rms)


###################################################
### code chunk number 16: 12
###################################################
mymod5 <- lm(y ~ rcs(x, parms=5), data=dat)
predict5 <- mymod5$fitted.values
plot(dat$x, dat$y,main="Using lm(y~rcs(x,parms=5))", type="n")
points(dat$x, dat$y, pch=16)
lines(dat$x, predict5)


###################################################
### code chunk number 17: 14
###################################################
summary(mymod5)


###################################################
### code chunk number 18: 14compare
###################################################
library(splines)
modbs <- lm(y ~ ns(x, df=4), data=dat) 
plot(predict5, modbs$fitted, main="scatter of predictions from ns and rcs", xlab="predicted with rcs(x, parms=5)", ylab="predicted with ns(x, df=4)") 


###################################################
### code chunk number 19: 15-4
###################################################
mymod3 <- lm(y ~ rcs(x,parms=3), data=dat)
predict3 <- mymod3$fitted.values
plot(x,y,main="3 Knots! Using lm(y~rcs(x,parms=3))", pch=16)
lines(dat$x, predict3)
summary(mymod3)


###################################################
### code chunk number 20: 15-6
###################################################
mymod6 <- lm(y ~ rcs(x,parms=6), data=dat)
predict6 <- mymod6$fitted.values
plot(x,y,main="6 Knots! Using lm(y~rcs(x,parms=6))", pch=16)
lines(dat$x, predict6)
summary(mymod6)


###################################################
### code chunk number 21: 15-all
###################################################
mymod7 <- lm(y ~ rcs(x,7), data=dat)
predict7 <- mymod7$fitted.values
mymod8 <- lm(y ~ rcs(x,8), data=dat)
predict8 <- mymod8$fitted.values
mymod9 <- lm(y ~ rcs(x,9), data=dat)
predict9 <- mymod9$fitted.values
plot(x,y,main="5- 9 Knots!", pch=16)
lines(dat$x, predict5, col=1, lty=1)
lines(dat$x, predict6, col=2, lty=2)
lines(dat$x, predict7, col=3, lty=3)
lines(dat$x, predict8, col=4, lty=4)
lines(dat$x, predict9, col=5, lty=5)
legend("top",legend=paste("knots",5:9),col=1:5,lty=1:5)


###################################################
### code chunk number 22: 18
###################################################
x3 <- seq(0,10,length=200)
xprime <- 4
bandwidth <- 3.1
weight <- (1- (abs((x3-xprime)/bandwidth))^3)^3
weight <- ifelse(abs(xprime-x3)>bandwidth,0,weight)
plot(x3,weight,type="l",main="Default loess weighting for x=4, bandwidth=3.1")


###################################################
### code chunk number 23: locex
###################################################
library(locfit)


###################################################
### code chunk number 24: 18c
###################################################
fit1 <- locfit(y~lp(x,nn=0.5)) 
plot(fit1,main="Local fitting, 0.5 nearest neighbors included",ylim=c(-6,6))
points(x,y)


###################################################
### code chunk number 25: 18d
###################################################
fit1 <- locfit(y~lp(x,nn=0.5)) 
pred1 <- predict(fit1, newdata=data.frame(x), se.fit=TRUE, band="local")
plot(fit1,main="Local fitting, 0.5 nearest neighbors included",ylim=c(-6,6), band="local")
points(x,y)


###################################################
### code chunk number 26: locMASS
###################################################
fit2 <- loess(y~x,span=0.5)
pred2 <- fit2$fitted
plot(x,y, main="loess with span=0.5",ylim=c(-6,6))
lines(x, pred2)


###################################################
### code chunk number 27: loesscompare
###################################################
plot(pred2, pred1$fit, main="Compare locfit and loess with span=0.5", xlab="loess predictions", ylab="locfit predictions", ylim=c(-6,6))


###################################################
### code chunk number 28: pspline10
###################################################
library(pspline)
#dat <- data.frame(x,y)
#dat <- dat[order(x), ]
#x <- dat$x
#y <- dat$y


###################################################
### code chunk number 29: pspline10b
###################################################
psp10 <- smooth.Pspline(x, y)
psp10


###################################################
### code chunk number 30: pspline10c
###################################################
plot(x, y, type="n", main="pspline Method 1 Follows Orders, spar=0")
points(x, y, col=gray(.70))
lines(psp10$x, psp10$ysmth)


###################################################
### code chunk number 31: pspline15a
###################################################
psp15 <- smooth.Pspline(x, y, spar=0.8, method=1)
psp15


###################################################
### code chunk number 32: pspline15b
###################################################
plot(x, y, type="n", main="pspline with spar=0.8")
points(x, y, col=gray(.70))
lines(psp15$x, psp15$ysmth)


###################################################
### code chunk number 33: pspline17a
###################################################
psp17 <- smooth.Pspline(x, y, spar=10, method=1)
psp17


###################################################
### code chunk number 34: pspline17b
###################################################
plot(x, y, type="n", main="pspline with spar=10")
points(x, y, col=gray(.70))
lines(psp17$x, psp17$ysmth)


###################################################
### code chunk number 35: pspline25a
###################################################
psp25 <- smooth.Pspline(x, y, df=5, method=2)
psp25


###################################################
### code chunk number 36: pspline25b
###################################################
plot(x, y, type="n", main="pspline, df=5")
points(x, y, col=gray(.70))
lines(psp25$x, psp25$ysmth, pch=3, cex=1.5)


###################################################
### code chunk number 37: pspline26a
###################################################
psp26 <- smooth.Pspline(x, y, df=10, method=2)
psp26


###################################################
### code chunk number 38: pspline26b
###################################################
plot(x, y, type="n", main="pspline method=2, df=10")
points(x, y, col=gray(.70))
lines(psp26$x, psp26$ysmth, pch=3, cex=1.5)


###################################################
### code chunk number 39: pspline35a
###################################################
psp35 <- smooth.Pspline(x, y, method=4)
psp35


###################################################
### code chunk number 40: pspline35b
###################################################
plot(x, y, type="n", main="pspline with CV selection of smooth parameter")
points(x, y, col=gray(.70))
lines(psp35$x, psp35$ysmth)


###################################################
### code chunk number 41: pspline50
###################################################
plot(x, y, type="n", main="pspline with CV selection of smooth parameter")
points(x, y, col=gray(.70))
lines(psp10$x, psp10$ysmth, lty=4, lwd=0.6)
lines(psp15$x, psp15$ysmth, lty=3)
lines(psp26$x, psp26$ysmth, lty=2)
lines(psp35$x, psp35$ysmth, lty=1)
legend("top", legend=c("spar=0","spar=0.8","df=10","CV"),lty=4:1)


###################################################
### code chunk number 42: 22
###################################################
library(acepack)
avasfit <- avas(x, y)
plot(avasfit$tx, avasfit$ty,main="avas Function With the Sine Wave Data",xlab="transformed values of x",ylab="transformed values of y",type="n")
points(avasfit$tx, avasfit$ty,cex=0.5)
abline(lm(avasfit$ty~avasfit$tx))


###################################################
### code chunk number 43: 23
###################################################
par(mfcol=c(1,2))
plot(avasfit$x, avasfit$tx,ylab="transformed x",xlab="original x")
plot(avasfit$y, avasfit$ty,ylab="transformed y",xlab="original y")


###################################################
### code chunk number 44: cpi10
###################################################
library(foreign)
library(rockchalk)
dat <- read.dta("/home/pauljohn/ps/SVN-guides/stat/DataSets/QoG/QoG_c_s_v6Apr11.dta")
vars <- c("p_polity2", "fh_ipolity2", "fh_pr", "gir_gii", 
"kk_gg", "qs_impar", "ti_cpi", "wbgi_cce", "ht_regtype", 
"hf_efiscore", "qs_proff", "bti_mes", "bti_ep", "bti_wr")
dat <- dat[ , vars]
fit1 <- locfit(ti_cpi ~ lp(fh_pr, nn=0.5), data=dat) 
pred1 <- predict(fit1, newdata=data.frame(fh_pr=dat$fh_pr), se.fit=TRUE, band="local")
plot(fit1, main="Locfit(nn=0.5) with Confidence Intervals", type="l", lwd=3, band="local", xlab="Political rights (Freedom House)", ylab="TI Corruptions Perceptions")
points(ti_cpi ~ fh_pr, data=dat)
m2b <- lm(ti_cpi ~ fh_pr + I(fh_pr^2), data=dat)
fh_pr_seq <- sort(unique(dat$fh_pr))
newdf <- data.frame( fh_pr=fh_pr_seq, fh_pr_sq = fh_pr_seq^2) 
m2bpred <- as.data.frame(predict(m2b, newdata=newdf, interval="confidence"))
lines(newdf$fh_pr, m2bpred$fit, lty=1, lwd=2, col="red")
lines(newdf$fh_pr, m2bpred$lwr, lty=2, lwd=2, col="red")
lines(newdf$fh_pr, m2bpred$upr, lty=2, lwd=2, col="red")


###################################################
### code chunk number 45: cpi20
###################################################
fit1 <- locfit(ti_cpi ~ lp(fh_pr, nn=0.75), data=dat) 
pred1 <- predict(fit1, newdata=data.frame(fh_pr=dat$fh_pr), se.fit=TRUE, band="local")
plot(fit1, main="Locfit(nn=0.75) with Confidence Intervals", type="l", lwd=3, band="local", xlab="Political rights (Freedom House)", ylab="TI Corruptions Perceptions")
points(ti_cpi ~ fh_pr, data=dat)
m2b <- lm(ti_cpi ~ fh_pr + I(fh_pr^2), data=dat)
m2bpred <- as.data.frame(predict(m2b, newdata=newdf, interval="confidence"))
lines(newdf$fh_pr, m2bpred$fit, lty=1, lwd=2, col="red")
lines(newdf$fh_pr, m2bpred$lwr, lty=2, lwd=2, col="red")
lines(newdf$fh_pr, m2bpred$upr, lty=2, lwd=2, col="red")


###################################################
### code chunk number 46: cpi40
###################################################
dat <- dat[order(dat$fh_pr),  ]
m3a <- lm(ti_cpi ~ rcs(fh_pr, 4), data=dat)
m3apred <- predict(m3a, newdata=dat)
summary(m3a)
plot(ti_cpi ~ fh_pr, data=dat, xlab="Political rights (Freedom House)", ylab="TI Corruptions Perceptions")
#m3apred <- as.data.frame(predict(m3a, newdata=newdf, interval="confidence"))
lines(dat$fh_pr, m3apred, lty=1, lwd=2, col="black")
#lines(newdf$fh_pr, m3apred$fit, lty=1, lwd=2, col="red")
#lines(newdf$fh_pr, m3apred$lwr, lty=2, lwd=2, col="red")
#lines(newdf$fh_pr, m3apred$upr, lty=2, lwd=2, col="red")


###################################################
### code chunk number 47: cpi60
###################################################
dat$fh_prf <- factor(dat$fh_pr)
m4a <- lm(ti_cpi ~ fh_prf, data=dat)
#newdf <- data.frame(fh_prf=levels(dat$fh_prf))
#m4apred <- predict(m3a, newdata=newdf)
summary(m4a)
termplot(m4a, partial=T, se=T, xlab="Political rights (Freedom House)", ylab="TI Corruptions Perceptions")


