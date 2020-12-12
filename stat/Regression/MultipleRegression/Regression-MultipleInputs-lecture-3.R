### R code from vignette source 'Regression-MultipleInputs-lecture-3.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Regression-MultipleInputs-lecture-3.Rnw:31-32
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-MultipleInputs-lecture-3.Rnw:75-77
###################################################
unlink("plots3", recursive=T)
dir.create("plots3", showWarnings=T)


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
### code chunk number 4: cars10
###################################################
plot(dist ~ speed, data=cars, main="Stopping Distance of Cars in the 1920s", xlab="Speed (mph)", ylab="Stopping Distance (feet)")


###################################################
### code chunk number 5: cars20
###################################################
plot(dist ~ speed, data=cars, main="Stopping Distance of Cars in the 1920s", xlab="Speed (mph)", ylab="Stopping Distance (feet)")
mod20 <- lm(dist~speed, data=cars)
abline(mod20)


###################################################
### code chunk number 6: cars30
###################################################
plot(dist ~ speed, data=cars, main="Stopping Distance of Cars in the 1920s", xlab="Speed (mph)", ylab="Stopping Distance (feet)")
mod20lo <- loess(dist~speed, data=cars, span=2/3, degree=1, family="symmetric", eval=50)
mod20lopred <- predict(mod20lo)
lines(mod20lopred ~ cars$speed, lty=2, lwd=2, col="red")
abline(mod20, col="black", lwd=1.5, lty=1)
legend("topleft", legend=c("OLS","loess"), col=c("black", "red"), lty=c(1,2), lwd=c(1.5,2)) 


###################################################
### code chunk number 7: cars40
###################################################
cars$mod20res <- resid(mod20)
plot(mod20res ~ speed, data=cars, main="Residuals for Stopping Distance", xlab="Speed (mph)", ylab="Stopping Residuals")
mod20reslo <- loess(mod20res~speed, data=cars, span=2/3, degree=1, family="symmetric", eval=50)
mod20reslopred <- predict(mod20reslo)
lines(mod20reslopred ~ cars$speed, lty=2, lwd=2, col="red")
abline(h=0, lty=4, lwd=3, col=gray(.60)) 
legend("topleft", legend=c("loess fit to residuals"), col=c( "red"), lty=c(4), lwd=c(3)) 


###################################################
### code chunk number 8: cars100
###################################################
par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(mod20)


###################################################
### code chunk number 9: cars100A
###################################################
plot(mod20, which=1)


###################################################
### code chunk number 10: cars100B
###################################################
plot(mod20, which=2)


###################################################
### code chunk number 11: cars100C
###################################################
plot(mod20, which=3)


###################################################
### code chunk number 12: cars100E
###################################################
plot(mod20, which=5)


###################################################
### code chunk number 13: prestige10
###################################################
library(car)
Prestige$income <- Prestige$income/10
presmod1 <- lm(prestige ~ income + education + women + type, data=Prestige)


###################################################
### code chunk number 14: prestige100
###################################################
library(rockchalk)
library(car)
Prestige$income <- Prestige$income/10
presmod1 <- lm(prestige ~ income + education + women + type, data=Prestige)
par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(presmod1)
outreg(presmod1, tight=F)


###################################################
### code chunk number 15: pres40A
###################################################
termplot(presmod1, se=T, partial=T, terms=c("education"))


###################################################
### code chunk number 16: pres40B
###################################################
termplot(presmod1, se=T, partial=T, terms=c("income"))


###################################################
### code chunk number 17: pres40C
###################################################
termplot(presmod1, se=T, partial=T, terms=c("women"))


###################################################
### code chunk number 18: pres40D
###################################################
termplot(presmod1, se=T, partial=T, terms=c("type"))


###################################################
### code chunk number 19: prestpl1
###################################################
plot(presmod1, which=1)


###################################################
### code chunk number 20: prestpl2
###################################################
plot(presmod1, which=2)


###################################################
### code chunk number 21: prestpl3
###################################################
plot(presmod1, which=3)


###################################################
### code chunk number 22: prestpl4
###################################################
plot(presmod1, which=5)


###################################################
### code chunk number 23: bad10
###################################################
x <- runif(200, min=0, max=100)
x <- x[order(x)]
y <- 3 + 13.4 * x - .15 * x^2 + rnorm(200,m=0, s=22)
modf <- lm(y~x)
fakeeqn <- expression(paste(y[i]== 3 + 13.4*x[i] - 0.15*x[i]^2 + e[i]))
plot(x,y, xlab="Fake x", ylab="Fake y", main=fakeeqn)
abline(modf, col="red", lty=2,lwd=2)
curve(3 + 13.4 * x - .15 * x * x, add=T, lty=1, col="black", lwd=3)
legend("bottomleft", legend=c("OLS Linear Fit","True Nonlinear Curve"), col=c( "red", "black"), lty=c(2,1), lwd=c(2,3)) 


###################################################
### code chunk number 24: bad40
###################################################
par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(modf)


###################################################
### code chunk number 25: bado10
###################################################
x <- runif(200, min=0, max=100)
x <- x[order(x)]
fresherror <- rnorm(200,m=0, s=22)
badcases <- sample(1:200, 10)
badcases <- badcases[order(badcases)]
error <- fresherror
for(i in badcases) error[i] <- fresherror[i] * 4
y <- 3 + 1.4 * x + error
modo <- lm(y~x)
fakeeqn <- expression(paste(y[i]== 3 + 1.4*x[i] + e[i]))
plot(x,y, xlab="Fake x", ylab="Fake y", main=fakeeqn)
abline(modo, col="red", lty=2,lwd=2)
curve(3 + 1.4 * x, add=T, lty=1, col="black", lwd=3)
legend("bottomleft", legend=c("OLS Linear Fit","True Line"), col=c( "red", "black"), lty=c(2,1), lwd=c(2,3)) 


###################################################
### code chunk number 26: bado11
###################################################
badcases


###################################################
### code chunk number 27: bado12
###################################################
outreg(modo, tight=F)


###################################################
### code chunk number 28: bado20
###################################################
par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(modo)


###################################################
### code chunk number 29: bado22
###################################################
plot(modo, which=5)


###################################################
### code chunk number 30: bado30
###################################################
error <- fresherror
for(i in badcases) error[i] <- fresherror[i] * 10
y <- 3 + 1.4 * x + error
modo <- lm(y~x)
fakeeqn <- expression(paste(y[i]== 3 + 1.4*x[i] + e[i]))
plot(x,y, xlab="Fake x", ylab="Fake y", main=fakeeqn)
abline(modo, col="red", lty=2,lwd=2)
curve(3 + 1.4 * x, add=T, lty=1, col="black", lwd=3)
legend("topleft", legend=c("OLS Linear Fit","True Line"), col=c( "red", "black"), lty=c(2,1), lwd=c(2,3)) 


###################################################
### code chunk number 31: bado31
###################################################
badcases


###################################################
### code chunk number 32: bado32
###################################################
outreg(modo, tight=F)


###################################################
### code chunk number 33: bado40
###################################################
par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(modo)


###################################################
### code chunk number 34: bado60
###################################################
error <- fresherror
poserr <- which(fresherror > 0)
badcases <- poserr[ (length(poserr)-10):length(poserr)]
for(i in badcases) error[i] <- fresherror[i] * 10
y <- 3 + 1.4 * x + error
modo <- lm(y~x)
fakeeqn <- expression(paste(y[i]== 3 + 1.4*x[i] + e[i]))
plot(x,y, xlab="Fake x", ylab="Fake y", main=fakeeqn)
abline(modo, col="red", lty=2,lwd=2)
curve(3 + 1.4 * x, add=T, lty=1, col="black", lwd=3)
legend("topleft", legend=c("OLS Linear Fit","True Line"), col=c( "red", "black"), lty=c(2,1), lwd=c(2,3)) 


###################################################
### code chunk number 35: bado61
###################################################
badcases


###################################################
### code chunk number 36: bado62
###################################################
outreg(modo, tight=F)


###################################################
### code chunk number 37: bado70
###################################################
par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(modo)


###################################################
### code chunk number 38: bado100
###################################################
error <- fresherror
poserr <- which(fresherror > 0)
badcases <- poserr[length(poserr)]
for(i in badcases) error[i] <- fresherror[i] * 10
y <- 3 + 1.4 * x + error
modo <- lm(y~x)
fakeeqn <- expression(paste(y[i]== 3 + 1.4*x[i] + e[i]))
plot(x,y, xlab="Fake x", ylab="Fake y", main=fakeeqn)
abline(modo, col="red", lty=2,lwd=2)
curve(3 + 1.4 * x, add=T, lty=1, col="black", lwd=3)
legend("topleft", legend=c("OLS Linear Fit","True Line"), col=c( "red", "black"), lty=c(2,1), lwd=c(2,3)) 


###################################################
### code chunk number 39: bado101
###################################################
badcases


###################################################
### code chunk number 40: bado102
###################################################
outreg(modo, tight=F)


###################################################
### code chunk number 41: bado110
###################################################
par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(modo)


###################################################
### code chunk number 42: bado112
###################################################
plot(modo, which=5)


###################################################
### code chunk number 43: badh10
###################################################
x <- runif(200, min=0, max=100)
x <- x[order(x)]
xsquare <- x*x
error <- rnorm(200, m=0, s=0.5*xsquare)
y <- 3 + 1.4 * x - .15 * x^2 + error
modh <- lm(y~x)
fakeeqn <- expression(paste(y[i]== 3 + 1.4*x[i] + e[i]))
plot(x,y, xlab="Fake x", ylab="Fake y", main=fakeeqn)
abline(modh, col="red", lty=2,lwd=2)
curve(3 + 1.4 * x, add=T, lty=1, col="black", lwd=3)
legend("bottomleft", legend=c("OLS Linear Fit","True Linear Equation"), col=c( "red", "black"), lty=c(2,1), lwd=c(2,3)) 


###################################################
### code chunk number 44: badh12
###################################################
outreg(modh, tight=F)


###################################################
### code chunk number 45: badh20
###################################################
modhres <- resid(modh)
plot(modhres ~ x, main=fakeeqn, xlab="fake x", ylab="Residuals")
modhreslo <- loess(modhres~x, span=2/3, degree=1, family="symmetric", eval=50)
modhreslopred <- predict(modhreslo)
lines(modhreslopred ~ x, lty=2, lwd=2, col="red")
abline(h=0, lty=4, lwd=3, col=gray(.60)) 
legend("topleft", legend=c("loess fit to residuals"), col=c( "red"), lty=c(4), lwd=c(3)) 


###################################################
### code chunk number 46: badh40
###################################################
par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(modh)


