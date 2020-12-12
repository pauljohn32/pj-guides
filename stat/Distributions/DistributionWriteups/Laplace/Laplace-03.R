### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM9669/lyx_tmpbuf2/Laplace-03.Rnw'

###################################################
### code chunk number 1: Laplace-03.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Laplace-03.Rnw:90-92
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
### code chunk number 4: LaplaceMulti (eval = FALSE)
###################################################
## par(mfrow=c(2, 2)) 
## x1 <- seq(-15, 15, by = 0.05) 
## mylaplace1 <- dlaplace(x1, location = 0, scale = 1) 
## plot(x1, mylaplace1, type = "l", xlab = "x", ylab = "P(x)", 
## main="Laplace, location=0, scale=1")
## x2 <- seq(0, 15, by = 0.05)
## myexp1 <- dexp(x2, rate = 1) 
## plot(x2, myexp1, type = "l", xlab = "x", ylab = "P(x)", main = "Exponential, rate=1")
## myexp2 <- 0.5*dexp(x1,rate=1)
## plot(x1, myexp2, type = "l", xlab = "x", ylab = "0.5*P(x)", main = "0.5*Exponential PDF") 
## 


###################################################
### code chunk number 5: chunk7
###################################################


library(VGAM)



###################################################
### code chunk number 6: Laplace-03.Rnw:200-201
###################################################
par(mfrow=c(2, 2)) 
x1 <- seq(-15, 15, by = 0.05) 
mylaplace1 <- dlaplace(x1, location = 0, scale = 1) 
plot(x1, mylaplace1, type = "l", xlab = "x", ylab = "P(x)", 
main="Laplace, location=0, scale=1")
x2 <- seq(0, 15, by = 0.05)
myexp1 <- dexp(x2, rate = 1) 
plot(x2, myexp1, type = "l", xlab = "x", ylab = "P(x)", main = "Exponential, rate=1")
myexp2 <- 0.5*dexp(x1,rate=1)
plot(x1, myexp2, type = "l", xlab = "x", ylab = "0.5*P(x)", main = "0.5*Exponential PDF") 



###################################################
### code chunk number 7: chunk7
###################################################
library(VGAM)


###################################################
### code chunk number 8: LaplacePDF
###################################################
x <- seq(-4,12, by=0.05) 
mylaplace1 <- dlaplace(x, location=4, scale=2) 
mylaplace2 <- dlaplace(x, location=4, scale=4) 
mylaplace3 <- dlaplace(x, location=4, scale=8)
matplot(x, cbind(mylaplace1,mylaplace2, mylaplace3), type="l", xlab="x", ylab="P(x)",main="")
legend("topleft", c("Laplace(4,2)","Laplace(4,4)","Laplace(4,8)"),lty=1:3, col=1:3) 


###################################################
### code chunk number 9: Laplace-03.Rnw:267-277
###################################################
mylaplace1 <- dlaplace(x1, location=-2, scale=1)
mylaplace2 <- dlaplace(x1, location=2, scale=1) 
plot(x1, mylaplace2, type = "n", xlab = "x", ylab = "P(x)", main = "Laplace, scale=1")
mylaplace3 <- dlaplace(x1, location = 5, scale = 1) 
mylaplace4 <- dlaplace(x1, location = 10, scale = 1)
lines(x1, mylaplace1, lty = 1, col = 1)
lines(x1, mylaplace2, lty = 2, col = 2)
lines(x1, mylaplace3, lty = 3, col = 3)
lines(x1, mylaplace4, lty = 4, col = 4)
legend("topleft",c("location=-2", "location=2", "location=5", "location=10"), lty=1:4, col=1:4)


###################################################
### code chunk number 10: LaplacePDF2
###################################################
par(mfcol=c(2,1))
x <- seq(-8,16, by = 0.05) 
mylaplace1 <- dlaplace(x, location = 4, scale = 2) 
mydnorm <- dnorm(x, mean = 4, sd = sqrt(8)) 
matplot(x, cbind(mylaplace1, mydnorm), type = "l", xlab = "x", ylab = "P(x)", main="")
legend("topleft", c("Laplace(4,2)", "Normal(4,8)"), lty=1:2, col=1:2) 
x <- seq(8, 20, by = 0.05)
mylaplace1 <- dlaplace(x, location = 4, scale = 2) 
mydnorm <- dnorm(x, mean = 4, sd = sqrt(8)) 
matplot(x, cbind(mylaplace1, mydnorm), type = "l", xlab = "x", ylab = "P(x)", main = "Expanded view, x>8",)
legend("topleft", c("Laplace(4,2)","Normal(4,8)"), lty = 1:2, col = 1:2) 



