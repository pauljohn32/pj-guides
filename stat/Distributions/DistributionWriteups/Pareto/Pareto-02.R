### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T10675/lyx_tmpbuf2/Pareto-02.Rnw'

###################################################
### code chunk number 1: Pareto-02.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Pareto-02.Rnw:90-92
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
options(SweaveHooks=list(fig=function() par(ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: Pareto1 (eval = FALSE)
###################################################
## library(VGAM)
## 
## xvals <- seq(0.1,10,len=1000)
## 
## plot(xvals, dpareto(xvals, location=1, shape=1), type="l", xlab="possible values of x", ylab="probability of x", main="Pareto Probability Density")
## 
## text(2, .6, "shape=1, location=1", pos=4, col=1)
## 


###################################################
### code chunk number 5: Pareto-02.Rnw:196-198
###################################################
library(VGAM)

xvals <- seq(0.1,10,len=1000)

plot(xvals, dpareto(xvals, location=1, shape=1), type="l", xlab="possible values of x", ylab="probability of x", main="Pareto Probability Density")

text(2, .6, "shape=1, location=1", pos=4, col=1)




###################################################
### code chunk number 6: Pareto2 (eval = FALSE)
###################################################
## leftedge <- 1
## xvals2 <- seq(leftedge,20,len=1000)
## y1 <- dpareto(xvals2, location = leftedge, shape = 1.1)
## y2 <- dpareto(xvals2, location = leftedge, shape = 7.5)
## y3 <- dpareto(xvals2, location = leftedge, shape = 15)
## plot(xvals2, y1, type = "l", xlab = "possible values of x", ylab = "probability of x", ylim = c(0,2))
## lines(xvals2, y2, lty = 2, col = 2)
## lines(xvals2, y3, lty = 3, col = 4)
## legend("topright",c("shape=1.1","shape=7.5","shape=15"), lty=1:3, col = c(1,2,4))


###################################################
### code chunk number 7: Pareto-02.Rnw:224-225
###################################################
leftedge <- 1
xvals2 <- seq(leftedge,20,len=1000)
y1 <- dpareto(xvals2, location = leftedge, shape = 1.1)
y2 <- dpareto(xvals2, location = leftedge, shape = 7.5)
y3 <- dpareto(xvals2, location = leftedge, shape = 15)
plot(xvals2, y1, type = "l", xlab = "possible values of x", ylab = "probability of x", ylim = c(0,2))
lines(xvals2, y2, lty = 2, col = 2)
lines(xvals2, y3, lty = 3, col = 4)
legend("topright",c("shape=1.1","shape=7.5","shape=15"), lty=1:3, col = c(1,2,4))


###################################################
### code chunk number 8: Pareto3 (eval = FALSE)
###################################################
## leftedge <- c(1,3,5)
## x1 <- seq(leftedge[1],20,len=1000)
## y1 <- dpareto(x1, location = leftedge[1], shape = 1)
## x2 <- seq(leftedge[2], 20, len = 1000)
## y2 <- dpareto(x2, location = leftedge[2], shape = 1)
## x3 <- seq(leftedge[3], 20, len = 1000)
## y3 <- dpareto(x3, location = leftedge[3], shape = 1)
## plot(x1, y1, type="l", xlab = "possible values of x", ylab = "probability of x", ylim = c(0,1))
## lines(x2, y2, lty = 2, col=2)
## lines(x3, y3, lty = 3, col=4)
## legend("topright", c("location=1","location=3","location=5"), lty=1:3, col=c(1,2,4))


###################################################
### code chunk number 9: Pareto-02.Rnw:258-259
###################################################
leftedge <- c(1,3,5)
x1 <- seq(leftedge[1],20,len=1000)
y1 <- dpareto(x1, location = leftedge[1], shape = 1)
x2 <- seq(leftedge[2], 20, len = 1000)
y2 <- dpareto(x2, location = leftedge[2], shape = 1)
x3 <- seq(leftedge[3], 20, len = 1000)
y3 <- dpareto(x3, location = leftedge[3], shape = 1)
plot(x1, y1, type="l", xlab = "possible values of x", ylab = "probability of x", ylim = c(0,1))
lines(x2, y2, lty = 2, col=2)
lines(x3, y3, lty = 3, col=4)
legend("topright", c("location=1","location=3","location=5"), lty=1:3, col=c(1,2,4))


