### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T25593/lyx_tmpbuf2/Nonparametric-1-guide.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Nonparametric-1-guide.Rnw:18-19
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Nonparametric-1-guide.Rnw:48-49
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(75645)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: 1
###################################################
x <- seq(from=0, to=50, length.out=200)
y <- 30 + 1.4 * x + 6*rnorm(200)
plot (x, y, main="Linear Equation",xlim=c(0,50), ylim=c(-10,100))
abline(lm(y~x))


###################################################
### code chunk number 5: 2
###################################################
#setting seed so this thing looks the same every time!

set.seed(2314)



x <- 10 * runif(100)

y <- 5*sin(x)+rnorm(100)

plot (x, y, main="Curvish data from Locfit example", pch=16)

abline(lm(y~x))



###################################################
### code chunk number 6: 4
###################################################
mymod1 <- lm(y~x+I(x^2))

newx <- seq(0,10, length.out=100)

predict1 <- predict(mymod1, newdata=data.frame(x=newx))

plot(x,y,main="Adding x squared", pch=16)

lines(newx,predict1) 



###################################################
### code chunk number 7: 5
###################################################
summary(mymod1)



###################################################
### code chunk number 8: 6
###################################################
mymod1 <- lm(y~x+I(x^2)+I(x^3)+I(x^4))

summary(mymod1)

newx <- seq(0,10, length.out=100)

predict2 <- predict(mymod1, newdata=data.frame(x=newx))

plot(x,y,main="Adding x^2, x^3, and x^4", pch=16)

lines(newx,predict2)



###################################################
### code chunk number 9: 7a
###################################################
knot <- c(1.8, 4.2, 8.0)

thedf <- data.frame(x=x, y=y)

thedf <- thedf[order(thedf$x),]

#handy function to create "plus variables"

createplusvar <- function(input,k) { it <- ifelse(input>k, input-k, 0)}

thedf$xp1<- createplusvar(thedf$x, knot[1])

thedf$xp2<- createplusvar(thedf$x, knot[2])

thedf$xp3<- createplusvar(thedf$x, knot[3])

mymod0 <- lm (y~x+xp1+xp2+xp3, data=thedf)

newx <- seq(round(min(x),1), round(max(x)+0.5,1),by=0.1)

newdf <- data.frame(x=newx, xp1=createplusvar(newx,knot[1]),  xp2=createplusvar(newx,knot[2]), xp3=createplusvar(newx,knot[3]))

newdf$pred <- predict(mymod0, newdata=newdf)

mytitle <- paste ("Manual Regression spline knots", knot[1], knot[2], knot[3])

plot(thedf$x, thedf$y, main=mytitle, type="n")

points(thedf$x, thedf$y, pch=16, cex=0.5)

lines(newdf$x,newdf$pred)

rm(thedf,mymod0,newdf)



###################################################
### code chunk number 10: 7b
###################################################
library(segmented)
mymod0 <- lm (y~x)
segmod <- segmented(mymod0, seg.Z=~x, psi=list(x=c(1.8,4.2,8.0)), it.max=200)
summary(segmod)
mynewdf <- data.frame(x=x,fitted=segmod$fitted.values)
mynewdf <- mynewdf[order(mynewdf$x),]
plot(x,y,main="Lines, cutpoints estimated by segmented", pch=16)
lines(mynewdf$x,mynewdf$fitted)
detach("package:segmented")


###################################################
### code chunk number 11: 7c
###################################################
library(mda)

mymars <- mars(x,y, degree=1) 

summary(mymars)

mymars$cuts

mymars$gcv 

mydf <- data.frame(x,y,fitted=mymars$fitted)

mydf2 <- mydf[order(mydf$x),]

plot(x,y,main="Linear splines: mars output", pch=16)

lines(mydf2$x,mydf2$fitted)

rm(mymars)



###################################################
### code chunk number 12: 7d
###################################################
library(mda)

mymars2 <- mars(x,y, degree=1, nk=5) 

summary(mymars2)

mymars2$gcv 

mymars2$cuts

mydf <- data.frame(x,y,fitted=mymars2$fitted)

mydf2 <- mydf[order(mydf$x),]

plot(x,y,main="Linear splines: mars output nk=5", pch=16)

lines(mydf2$x,mydf2$fitted)

rm(mymars2, mydf, mydf2)

detach("package:mda")



###################################################
### code chunk number 13: 8
###################################################
plot(seq(-1,10,length.out=100),type="n",axes=F,ylab="",xlab="",xlim=c(-1,11),ylim=c(-1,1))

 axis(1, at = c(0,4,5,7,9,10),labels=expression(tau[0],tau[1],tau[2],tau[3],tau[4],tau[5]))



###################################################
### code chunk number 14: 9
###################################################
newx <- seq(0,100,length=200)

knots<- c(0,24,61,100)

parama<-c(1,2,-3)

paramb<-c(4,-5,8)

paramc<-c(1,1.1,.9)

paramd<-c(0.1,-0.2,-0.01)

y1 <- parama[1]+paramb[1]*newx +paramc[1]*newx^2+paramd[1]*newx^3

y1 <- ifelse(newx < knots[2], y1, NA)

y2 <- parama[2]+paramb[2]*newx +paramc[2]*newx^2+paramd[2]*newx^3

y2 <- ifelse(newx >= knots[2] & newx < knots[3],y2, NA)

y3 <- parama[3]+paramb[3]*newx +paramc[3]*newx^2+paramd[3]*newx^3

y3 <- ifelse(newx >= knots[3],y3, NA)

newy <- ifelse(newx < knots[2], y1, ifelse(newx > knots[2] & newx < knots[3],y2, y3))

plot(newx,newy,main="Unrestricted cubic splines",type="n",xlab="x",ylab="y")

lines(newx,y1)

lines(newx,y2)

lines(newx,y3)

rm (newx, newy, parama, paramb, paramc, paramd, y1, y2, y3)



###################################################
### code chunk number 15: 9b
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

rm (newx, parama, paramb, paramc, paramd, y1, y2, y3, y4,int0,int1,int2,int3)





###################################################
### code chunk number 16: 10
###################################################
library(Design)



###################################################
### code chunk number 17: 11
###################################################
asequence <- 1:20

splineMatrix <- rcs(asequence,4)

splineMatrix





###################################################
### code chunk number 18: 12 (eval = FALSE)
###################################################
## 
## mymod4 <- lm(y ~ rcs(x,4))
## 
## newx <- seq(0,10, length.out=100)
## 
## predict4 <- predict(mymod1, newdata=data.frame(x=newx))
## 
## plot(x,y,main="Using lm(y~rcs(x,4))", type="n")
## 
## points(x,y, pch=16)
## 
## lines(newx, predict4)
## 


###################################################
### code chunk number 19: 13
###################################################


mymod4 <- lm(y ~ rcs(x,4))

newx <- seq(0,10, length.out=100)

predict4 <- predict(mymod1, newdata=data.frame(x=newx))

plot(x,y,main="Using lm(y~rcs(x,4))", type="n")

points(x,y, pch=16)

lines(newx, predict4)




###################################################
### code chunk number 20: 14
###################################################

summary(mymod4)



###################################################
### code chunk number 21: 15
###################################################

mymod4 <- lm(y ~ rcs(x,10))

newx <- seq(0,10, length.out=100)

predict4 <- predict(mymod1, newdata=data.frame(x=newx))

plot(x,y,main="10 Knots! Using lm(y~rcs(x,10))", pch=16)

lines(newx, predict4)



###################################################
### code chunk number 22: 16
###################################################
summary(mymod4)

rm (mymod4, predict4, newx)



###################################################
### code chunk number 23: 17
###################################################
library(mgcv)

gam(y~s(x,k=4,bs="cr"))

mygams <- list()

for ( i in 3:10 ) { 

mygams[[i-2]] <- gam(y~s(x,k=i,bs="cr"))

}

gcvresults <- vector()

for (i in 1:7){

gcvresults[i] <- mygams[[i]]$gcv.ubre

}

gcvresults

bestone <- mygams[[which.min(gcvresults)]]

summary(bestone)

plot(bestone)

points(x,y,pch=16,cex=0.5)



#G<-gam(y~s(x),fit=FALSE)

#mgfit<-mgcv(G$y,G$X,G$sp,G$S,G$off,G$rank,C=G$C)





###################################################
### code chunk number 24: 18
###################################################
x3 <- seq(0,10,length=200)

xprime <- 4

bandwidth <- 3.1

weight <- (1- (abs((x3-xprime)/bandwidth))^3)^3

weight <- ifelse(abs(xprime-x3)>bandwidth,0,weight)

plot(x3,weight,type="l",main="Default loess weighting for x=4, bandwidth=3.1")



###################################################
### code chunk number 25: locex
###################################################
library(locfit)



###################################################
### code chunk number 26: 18c (eval = FALSE)
###################################################
## fit1 <- locfit(y~lp(x,nn=0.5)) 
## 
## plot(fit1,main="Local fitting in locfit package",ylim=c(-6,6))
## 
## points(x,y,pch=16)
## 
## gcv(fit1)
## 


###################################################
### code chunk number 27: Nonparametric-1-guide.Rnw:1049-1051
###################################################
fit1 <- locfit(y~lp(x,nn=0.5)) 

plot(fit1,main="Local fitting in locfit package",ylim=c(-6,6))

points(x,y,pch=16)

gcv(fit1)




###################################################
### code chunk number 28: locMASS (eval = FALSE)
###################################################
## library(MASS)
## 
## fit2 <- loess(y~x,span=0.5)
## 
## testx <- x[order(x)]
## 
## pred3 <- predict(fit2, data.frame(x=testx))
## 
## plot(x,y, pch=16, main="loess output from MASS",ylim=c(-6,6))
## 
## lines(testx, pred3)
## 


###################################################
### code chunk number 29: Nonparametric-1-guide.Rnw:1080-1082
###################################################
library(MASS)

fit2 <- loess(y~x,span=0.5)

testx <- x[order(x)]

pred3 <- predict(fit2, data.frame(x=testx))

plot(x,y, pch=16, main="loess output from MASS",ylim=c(-6,6))

lines(testx, pred3)




###################################################
### code chunk number 30: Nonparametric-1-guide.Rnw:1085-1095
###################################################
plot(x, y, type="n", main="loess output from MASS without deceptive line", ylim=c(-6,6))

points(x, y, pch=16)

points(x, fit2$fitted, pch=3)

#detach("package:MASS")

#rm(testx, fit2, pred3)



###################################################
### code chunk number 31: 20a
###################################################
library(MASS)



###################################################
### code chunk number 32: 20b
###################################################

ss1 <- smooth.spline(x,y, all.knots=T)

print(ss1)

plot(x,y, type="n", main="Comparing smooth.spline results")

lines(ss1$x,ss1$y,lty=1)

ss2 <- smooth.spline(x,y, all.knots=F, nknots=4)

print(ss2)

lines(ss2$x,ss2$y,lty=4)

legend(.7,-3, c("all.knots=T","knots=4"), lty=c(1,4))

points(x,y,pch=16,cex=0.5)



###################################################
### code chunk number 33: 22
###################################################

library(acepack)

avasfit <- avas(x, y)

plot(avasfit$tx, avasfit$ty,main="AVAS procedure from Acepack",xlab="transformed values of x",ylab="transformed values of y",type="n")

points(avasfit$tx, avasfit$ty,cex=0.5)

abline(lm(avasfit$ty~avasfit$tx))



###################################################
### code chunk number 34: 23
###################################################

par(mfcol=c(2,1))

plot(avasfit$x, avasfit$tx,ylab="transformed x",xlab="original x")

plot(avasfit$y, avasfit$ty,ylab="transformed y",xlab="original y")



