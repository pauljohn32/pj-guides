### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM6128/lyx_tmpbuf0/Interaction-Continuous-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Interaction-Continuous-1-lecture.Rnw:26-27
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Interaction-Continuous-1-lecture.Rnw:87-88
###################################################
dir.create("plots", showWarnings=T)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=165, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(75645)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: example10
###################################################
library(rockchalk)
set.seed(123412)
dat <- genCorrelatedData(N=400, rho=.1, stde=300, beta=c(2,-0.1,0.1,0.3))
m1 <- lm(y ~ x1*x2, data=dat)
fit1 <- plotPlane(m1, plotx1="x1", plotx2="x2", plotPoints=F, drawArrows=F, ticktype="detailed", theta=-20, npp=10, x1floor = 3, x2floor = 3)


###################################################
### code chunk number 5: demo10
###################################################
m1ps <- plotSlopes(m1, plotx="x1", modx="x2", modxVals = "std.dev")
plot(testSlopes(m1ps))


###################################################
### code chunk number 6: persp10
###################################################
x1 <- seq(0, 10, length=50)
x2 <- seq(-20, 30, length=50)
yfn <- function(x1,x2) 2 + 0.5 * x1 + 0.2 * x2 + 0.03 * x1 *x2
y <- outer(x1, x2, yfn)
matr <- persp(x=x1, y=x2, z=y, xlab="x1", ylab="x2", zlab="y")


###################################################
### code chunk number 7: persp20
###################################################
plot(x1, y=plotSeq(range(y), length(x1)), type="n", ylab="y")
intr <- function(x) 2 + 0.2 *x
sloper <- function(x) 0.5 + 0.03*x
abline(a=intr(-20), b=sloper(-20), lty=1, lwd=2)
abline(a=intr(-10), b=sloper(-10), lty=2, lwd=2)
abline(a=intr(10), b=sloper(10), lty=3, lwd=2)
abline(a=intr(20), b=sloper(20), lty=4, lwd=2)
legend("topleft",c("x2=-20", "x2=-10", "x2=10", "x2=20"), lty=c(1,2,3,4), lwd=2)


###################################################
### code chunk number 8: persp22
###################################################
matr <- persp(x=x1, y=x2, z=y, xlab="x1", ylab="x2", zlab="y")
for(j in c(1,11,31,41)){
lines(trans3d(x1, x2[j], y[,j], pmat=matr), col="yellow", lwd=3)
}


###################################################
### code chunk number 9: jn10
###################################################
m1ps <- plotSlopes(m1, plotx="x1", modx="x2")


###################################################
### code chunk number 10: jn11a
###################################################
m1ps <- plotSlopes(m1, plotx="x1", modx="x2", modxVals = "std.dev", n = 2, interval = "conf")


###################################################
### code chunk number 11: jn11b
###################################################
m1ps2 <- plotSlopes(m1, plotx="x1", modx="x2", interval = "conf", modxVals = round(range(dat$x2, na.rm=TRUE), 2))


###################################################
### code chunk number 12: jn20
###################################################
m1psts <- testSlopes(m1ps)


###################################################
### code chunk number 13: jn40
###################################################
plot(m1psts)


###################################################
### code chunk number 14: jn50
###################################################
dat2a <- genCorrelatedData(N=400, rho=.1, stde=300, means =c(50,0), beta=c(2, -2.4, 0.1, 0.44))
m2a <- lm(y ~ x1*x2, data=dat2a)


###################################################
### code chunk number 15: jn50a
###################################################
m2aps <- plotSlopes(m2a, plotx="x1", modx="x2")


###################################################
### code chunk number 16: jn50b
###################################################
m2app <- plotPlane(m2a, plotx1="x1", plotx2="x2", npp = 7, llwd = .5, plwd = 0.7, pcex = 0.75, pcol = gray(.6))


###################################################
### code chunk number 17: jn50c
###################################################
m2app <- plotPlane(m2a, plotx1="x1", plotx2="x2", npp = 7, llwd = .5, plwd = 0.7, pcex = 0.75, pcol = gray(.6))
addLines(from = m2aps, to = m2app)


###################################################
### code chunk number 18: jn50d
###################################################
m2apsts <- testSlopes(m2aps)
plot(m2apsts)


###################################################
### code chunk number 19: jn51
###################################################
dat2b <- genCorrelatedData(N=400, rho=.1, stde=300, beta=c(2, 0, 0.3, 0.05), means = c(50,0), sds = c(10, 40))
m2b <- lm(y ~ x1*x2, data=dat2b)
m2bps <- plotSlopes(m2b, plotx="x1", modx="x2")
plot(testSlopes(m2bps))


###################################################
### code chunk number 20: reg11
###################################################
dat <- genCorrelatedData(N=400, rho=.1, stde=250, beta=c(2,0.1,-0.1,0.5))
m1 <- lm(y ~ x1 + x2, data=dat)
fit1 <- plotPlane(m1, plotx1="x1", plotx2="x2", ticktype="detailed")


###################################################
### code chunk number 21: reg15
###################################################
summary(m1)


###################################################
### code chunk number 22: reg15b
###################################################
outreg(m1)


###################################################
### code chunk number 23: reg25
###################################################
m2 <- lm(y ~ x1*x2, data=dat)
summary(m2)


###################################################
### code chunk number 24: reg20
###################################################
fit1 <- plotPlane(m2, plotx1="x1", plotx2="x2", ticktype="detailed")


###################################################
### code chunk number 25: reg25b
###################################################
outreg(m2, tight=T)


###################################################
### code chunk number 26: reg30
###################################################
dat$x1c <- dat$x1 - mean(dat$x1, na.rm = TRUE)
dat$x2c <- dat$x2 - mean(dat$x2, na.rm = TRUE)
m3 <- lm(y ~ x1c * x2c, data=dat)


###################################################
### code chunk number 27: reg31
###################################################
m2centered <- meanCenter(m2)
summary(m2centered)


###################################################
### code chunk number 28: reg31b
###################################################
fit1 <- plotPlane(m2centered, plotx1="x1c", plotx2="x2c", ticktype="detailed")


###################################################
### code chunk number 29: Interaction-Continuous-1-lecture.Rnw:1068-1070 (eval = FALSE)
###################################################
## m2centered <- meanCenter(m2)
## summary(m2centered)
## fit1 <- plotPlane(m2centered, plotx1="x1c", plotx2="x2c", ticktype="detailed")


###################################################
### code chunk number 30: reg35
###################################################
outreg(m2centered)


###################################################
### code chunk number 31: reg40
###################################################
outreg(list(m2, m2centered), tight=F, modelLabels=c("Not Centered", "Centered"))


###################################################
### code chunk number 32: reg50
###################################################
pfit2 <- fitted(m2)
pfit3 <- fitted(m2centered)
plot(pfit2, pfit3, xlab="Predicted from Uncentered Model", ylab="Predicted from Centered Model")


###################################################
### code chunk number 33: reg60
###################################################
bs <- coef(m2)
yhatmean <- bs[1] + bs[2] * mean(dat$x1) + bs[3] * mean(dat$x2) + bs[4]*mean(dat$x1)*mean(dat$x2)
yhatmean


###################################################
### code chunk number 34: reg70
###################################################
partialx1 <- bs[2] + bs[4] * mean(dat$x2)
partialx1


###################################################
### code chunk number 35: reg80
###################################################
V <- vcov(m2)
varsum <- V[2,2]+mean(dat$x2)^2*V[4,4]+2*mean(dat$x2)*V[2,4]
varsum
sqrt(varsum)


