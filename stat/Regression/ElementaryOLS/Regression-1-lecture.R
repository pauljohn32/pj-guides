### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.hX3419/lyx_tmpbuf2/Regression-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Regression-1-lecture.Rnw:23-24
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-1-lecture.Rnw:79-80
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(4.1, 4.1, 1.5, 2.1) 
##pjmar <- par("mar")
par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: carinced10
###################################################
library(car)
plot(income ~ education, data=Prestige, ylab="Income", xlab="Education" )


###################################################
### code chunk number 5: carinced20
###################################################
incedmod1 <- lm(income~education, data=Prestige)
plot(income~education, data=Prestige, xlab="Education", ylab="Income")
abline(incedmod1)


###################################################
### code chunk number 6: carinced21
###################################################
summary(incedmod1)


###################################################
### code chunk number 7: outreg10
###################################################
library(rockchalk)
outreg(incedmod1, tight=F)


###################################################
### code chunk number 8: carinced60 (eval = FALSE)
###################################################
## incedmod1 <- lm(income~education, data=Prestige)
## summary(incedmod1)
## anova(incedmod1, test="F")
## vcov(incedmod1)
## confint(incedmod1)
## plot(incedmod1)
## termplot(incedmod1, se=T, partial=T)


###################################################
### code chunk number 9: q10a
###################################################
N <- 200
x <- runif(N, 0, 45)
y <- 2 + 0.1 *x + 0.5 * rnorm(N)
plot(y ~ x, xlab = "One Mysterious Predictor", ylab="An Output Variable")


###################################################
### code chunk number 10: q10b
###################################################
plot(y ~ x, xlab = "One Mysterious Predictor", ylab="An Output Variable")
m1 <- lm(y ~ x)
abline(m1, lwd = 2)
legend("topleft", legend=c("OLS Predicted value"), lty = 1)


###################################################
### code chunk number 11: q20a
###################################################
N <- 20
x <- runif(N, 0, 45)
y <- 2 + 0.4 *x + 7 * rnorm(N)
plot(y ~ x, xlab = "One Mysterious Predictor", ylab="An Output Variable")


###################################################
### code chunk number 12: q20b
###################################################
plot(y ~ x, xlab = "One Mysterious Predictor", ylab="An Output Variable")
m1 <- lm(y ~ x)
abline(m1, lwd = 2)
legend("topleft", legend=c("OLS Predicted value"), lty = 1)


###################################################
### code chunk number 13: q30a
###################################################
N <- 200
x <- runif(N, 0, 45)
y <- 2 + 0.1 *x + 10 * rnorm(N)
plot(y ~ x, xlab = "One Mysterious Predictor", ylab="An Output Variable")


###################################################
### code chunk number 14: q30b
###################################################
plot(y ~ x, xlab = "One Mysterious Predictor", ylab="An Output Variable")
m1 <- lm(y ~ x)
abline(m1, lwd = 2)
legend("topleft", legend=c("OLS Predicted value"), lty = 1)


###################################################
### code chunk number 15: q40a
###################################################
N <- 400
x <- 20 + rgamma(N, shape=2, scale=5)
y <- 2 + 0.1 *x + 10 * rnorm(N)
plot(y ~ x, xlab = "One Mysterious Predictor", ylab="An Output Variable")


###################################################
### code chunk number 16: q40b
###################################################
plot(y ~ x, xlab = "One Mysterious Predictor", ylab="An Output Variable")
m1 <- lm(y ~ x)
abline(m1, lwd = 2)
legend("topright", legend=c("OLS Predicted value"), lty = 1)


###################################################
### code chunk number 17: q50a
###################################################
N <- 400
x <- 20 + rgamma(N, shape=2, scale=5)
y <- 2 + ifelse(x < 30, 2 + 2 *x, 2 + 2 * x - 6 * (x-30)) + 5 * rnorm(N)
plot(y ~ x, col = gray(.50), xlab = "One Mysterious Predictor", ylab="An Output Variable")


###################################################
### code chunk number 18: q50b
###################################################
plot(y ~ x, col = gray(.50), xlab = "One Mysterious Predictor", ylab="An Output Variable")
m1 <- lm(y ~ x)
abline(m1, lwd = 2)
legend("topright", legend=c("OLS Predicted value"), lty = 1)


###################################################
### code chunk number 19: q60a
###################################################
N <- 300
x <- rnorm(N)
xcat2 <- cut(x, breaks=c(-Inf, 0.5, Inf), labels=c("L", "R"))
xcat2c <- contrasts(xcat2)[xcat2, ]	
xcat2n <- as.numeric(xcat2)-1
ycatn <- ifelse(x < x + rnorm(N), 0, 1)
plot.default(ycatn ~ xcat2n, xlim=c(-0.5, 1.5), ylim = c(-0.5, 1.5), xlab = "One Categorical Predictor", ylab="An Output Variable", axes = F, bty="L")
axis(1, at = c(0, 1), labels = c("L","R"))
axis(2, at = c(0, 1), labels = c("L", "H"))


###################################################
### code chunk number 20: q60b
###################################################
m1 <- lm(ycatn ~ xcat2n)
plot.default(ycatn ~ xcat2n, xlim=c(-0.5, 1.5),ylim = c(-0.5, 1.5), xlab = "One Categorical Predictor", ylab="An Output Variable", axes = F, bty="L")
axis(1, at = c(0, 1), labels = c("L=0","R=1"))
axis(2, at = c(0, 1), labels = c("L=0", "H=1"))


###################################################
### code chunk number 21: q70a
###################################################
N <- 300
xcat2 <- cut(rnorm(N), breaks=c(-Inf, 0.5, Inf), labels=c("R", "M"))
xcat2c <- contrasts(xcat2)[xcat2, ]	
xcat2n <- as.numeric(xcat2)-1
y <- 2 + 0.1 * xcat2n + 3 * rnorm(N)
plot.default(y ~ xcat2n, xlim=c(-0.5, 1.5), xlab = "One Categorical Predictor", ylab="An Output Variable", xaxt = "n")
axis(1, at = c(0, 1), labels = c("L","R"))


###################################################
### code chunk number 22: q70b
###################################################
m1 <- lm(y ~ xcat2n)
plot.default(y ~ xcat2n, xlab = "One Categorical Predictor", ylab = "An Output Variable", xaxt = "n", xlim = c(-0.5, 1.5))
axis(1, at = c(0, 1), labels = c("L=0","R=1"))
p1 <- predict(m1, newdata = data.frame(xcat2n = c(0,1)))
lines(c(-0.25, 0.25), c(p1[1], p1[1]), lwd = 2)
lines(c(0.75, 1.25), c(p1[2], p1[2]), lwd = 2)
legend("top", legend=c("OLS Predicted value"), lty = 1)


###################################################
### code chunk number 23: q80a
###################################################
N <- 500 
xcat2 <- cut(rnorm(N), breaks=c(-Inf, -2, 0, 0.5, 1, Inf), labels=c("R", "M", "D", "A", "F"))
xcat2n <- contrasts(xcat2)[xcat2, ]	
y <- 2 + xcat2n %*% c(3.5, -2.0, 1.3, -0.2) + 1 * rnorm(N)
plot(y ~ (as.numeric(xcat2) -1), xlab = "One Ordinal Predictor", ylab="An Output Variable", xaxt = "n")
axis(1, at = 1:5, labels = c("R", "M", "D", "A", "F"))


###################################################
### code chunk number 24: q80b
###################################################
plot(y ~ (as.numeric(xcat2)-1), xlab = "One Mysterious Predictor", ylab="An Output Variable", xaxt = "n")
axis(1, at = 1:5, labels = c("R=0", "M=1", "D=2", "A=3", "F=4"))
m1 <- lm(y ~ as.numeric(xcat2)-1)
abline(m1, lwd = 2)
legend("topright", legend=c("OLS Predicted value"), lty = 1)


###################################################
### code chunk number 25: line20
###################################################
x <- c(0,8)
ftrue <- function(x){3 + 1.3*x}
y <- ftrue(x)
plot(y ~ x, type = "l", xlab = expression(x[i]), ylab = expression(y[i]), ylim = c(0,10), xlim = c(-1,8), axes = F)
axis(1, pos = 0)
axis(2, pos = 0)


###################################################
### code chunk number 26: line90
###################################################
x <- c(0,8); b0=3; b1=1.3
fx <- function(x){b0 + b1*x}
y <- fx(x)
plot(y ~ x, type="l",xlab=expression(paste(x[i])), ylab=expression(paste(y[i])), ylim=c(0,10), xlim=c(-1,8), axes=F)
axis(1, pos=0)
axis(2, pos=0)
lines(c(0,2),c(b0, b0),lty=2)
text(2.2, b0, "the intercept", pos=4)
segments(c(4,5),fx(c(4,4)),c(5,5),fx(c(4,5)))
text(5, fx(3), paste("slope: \n over one \n up", b1), pos=4)


###################################################
### code chunk number 27: RSQ10
###################################################
set.seed(12323)
x <- rnorm(100, m=50,s=10)
y <-  2 + 3 *x + rnorm(100,m=0, s=20)
y2 <- 2 + 3 * x + rnorm(100, m=10, s=80)
mod1 <- lm(y ~ x)
mod2 <- lm(y2 ~ x)
plot(x,y, main="", xlab="Indep. Var.", ylab="Dep. Var",ylim=1.2*range(y2))
abline(2,3,lty=4, col="red")
abline(mod1)
legend("bottomright",legend=c("True Relationship","Sample Estimate"), lty=c(4,1),col=c("red","black"))


###################################################
### code chunk number 28: RSQ20
###################################################
plot(x,y2, main="", xlab="Indep. Var.", ylab="Dep. Var.",ylim=1.2*range(y2))
abline(2,3,lty=4, col="red")
abline(mod2)
legend("bottomright",legend=c("True Relationship","Sample Estimate"), lty=c(4,1),col=c("red","black"))


###################################################
### code chunk number 29: cor10
###################################################
set.seed(234234)
N <- 25; stde <- 2; b <- 0.14
x <- rnorm(N, m=50, sd=10)
x <- x[order(x)]
y <- 0.3 + b*x + rnorm(N, m=0, sd=stde)
mx <- round(mean(x),2)
my <- round(mean(y),2)
rx <- range(x)
ry <- range(y)
cov(x,y)
plot(x,y, main="")


###################################################
### code chunk number 30: cor30
###################################################
mycols <- ifelse((x-mx)*(y-my) > 0, "blue","red")
plot(x,y, main="", col=mycols)
abline(h=my, lty=4, col="black")
abline(v=mx, lty=4, col="black")
mtext(bquote(bar(x) ==.(mx)), side=1, line=2, at=mx)
mtext(bquote(bar(y) ==.(my)), side=2, line=2, at=my)


###################################################
### code chunk number 31: cor61
###################################################
plot(x,y, main="")
abline(h=my, lty=4, col="black")
abline(v=mx, lty=4, col="black")
mtext(bquote(bar(x) ==.(mx)), side=1, line=2, at=mx)
mtext(bquote(bar(y) ==.(my)), side=2, line=2, at=my)
text(1.2*rx[1],ry[2],pos=1, paste("Cov[x,y]=",round(cov(x,y),2),"\n r=",round(cor(x,y),2)))


###################################################
### code chunk number 32: cor70
###################################################
N <- 25; stde <- 3; b <- -1.0
x <- rnorm(N, m=50, sd=10)
x <- x[order(x)]
y <- 0.3 + b*x + rnorm(N, m=0, sd=stde)
mx <- round(mean(x),2)
my <- round(mean(y),2)
rx <- range(x)
ry <- range(y)
plot(x,y, main="")
abline(h=my, lty=4, col="black")
abline(v=mx, lty=4, col="black")
mtext(bquote(bar(x) ==.(mx)), side=1, line=2, at=mx)
mtext(bquote(bar(y) ==.(my)), side=2, line=2, at=my)
text(.9*rx[2],ry[2],pos=1, paste("Cov[x,y]=",round(cov(x,y),2),"\n r=", round(cor(x,y),2)))


###################################################
### code chunk number 33: reg10
###################################################
b0 <- 3; b1 <- 0.25; stde <- 0.0
x <- rnorm(100, m=50, s=10)
x <- x[order(x)]
y <- b0 + b1 * x
rx <- range(x)
ry <- range(y)
plot(y ~ x, type="p", xlab="x: the IV", ylab="y: the DV")
text(.8*rx[2],ry[2],pos=1, paste("Cov[x,y]=",round(cov(x,y),2),"\n r=",round(cor(x,y),2)))


###################################################
### code chunk number 34: reg20
###################################################
b0 <- 3; b1 <- 0.25; stde <- 5
e1 <- rnorm(100,m=0, s=1)
y <- b0 + b1 * x + stde*e1
rx <- range(x)
ry <- range(y)
plot(y ~ x, type="p", xlab="x: the IV", ylab="y: the DV")
abline(lm(y~x))
text(.93*rx[2],ry[1],pos=3, paste("Cov[x,y]=",round(cov(x,y),2),"\n r=",round(cor(x,y),2)))


###################################################
### code chunk number 35: reg20mod
###################################################
library(rockchalk)
mod <- lm(y~x)
outreg(mod, tight=F, showAIC=F, float=F)


###################################################
### code chunk number 36: reg30
###################################################
b0 <- 3; b1 <- 0.25; stde <- 10
y <- b0 + b1 * x + stde*e1
rx <- range(x)
ry <- range(y)
mod <- lm(y~x)
plot(y ~ x, type="p", xlab="x: the IV", ylab="y: the DV")
text(.93*rx[2],ry[1],pos=3, paste("Cov[x,y]=",round(cov(x,y),2),"\n r=",round(cor(x,y),2)))
abline(mod, col="gray80")


###################################################
### code chunk number 37: reg30mod
###################################################
outreg(mod, tight=F, showAIC=F, float=F)


###################################################
### code chunk number 38: reg45
###################################################
b0 <- 3; b1 <- 0.25; stde <- 50
y <- b0 + b1 * x + stde*e1
rx <- range(x)
ry <- range(y)
mod <- lm(y~x)
plot(y ~ x, type="p", xlab="x: the IV", ylab="y: the DV")
text(.93*rx[2],ry[1],pos=3, paste("Cov[x,y]=",round(cov(x,y),2),"\n r=",round(cor(x,y),2)))
abline(mod, col="gray80")


###################################################
### code chunk number 39: reg45mod
###################################################
outreg(mod, tight=F, showAIC=F, float=F)


###################################################
### code chunk number 40: reg50
###################################################
b0 <- 3; b1 <- 2; stde <- 50
y <- b0 + b1 * x + stde*e1
rx <- range(x)
ry <- range(y)
mod <- lm(y~x)
plot(y ~ x, type="p", xlab="x: the IV", ylab="y: the DV")
text(.93*rx[2],ry[1],pos=3, paste("Cov[x,y]=",round(cov(x,y),2),"\n r=",round(cor(x,y),2)))
abline(mod, col="gray80")


###################################################
### code chunk number 41: reg50mod
###################################################
outreg(mod, tight=F, showAIC=F, float=F)


###################################################
### code chunk number 42: reg60
###################################################
b0 <- 3; b1 <- 10
y <- b0 + b1 * x + stde*e1
rx <- range(x)
ry <- range(y)
mod <- lm(y~x)
plot(y ~ x, type="p", xlab="x: the IV", ylab="y: the DV")
text(.93*rx[2],ry[1],pos=3, paste("Cov[x,y]=",round(cov(x,y),2),"\n r=",round(cor(x,y),2)))
abline(mod, col="gray80")


###################################################
### code chunk number 43: reg60mod
###################################################
outreg(mod, tight=F, showAIC=F, float=F)


###################################################
### code chunk number 44: reg70
###################################################
b0 <- 3; b1 <- 10
y <- b0 + b1 * x + stde*e1
rx <- range(x)
ry <- range(y)
x2 <- x
x2[x2 > mean(x)] <- NA
mod <- lm(y~x2)
plot(y ~ x, type="n", xlab="x: the IV", ylab="y: the DV")
points(x2,y)
text(.93*rx[2],ry[1],pos=3, paste("Cov[x,y]=",round(cov(x2,y,use="complete.obs"),2),"\n r=",round(cor(x2,y,use="complete.obs"),2)))
abline(mod, col="gray80")


###################################################
### code chunk number 45: reg70mod
###################################################
outreg(mod, tight=F, showAIC=F, float=F)


