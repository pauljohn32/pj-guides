### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM9796/lyx_tmpbuf2/Logistic-01.Rnw'

###################################################
### code chunk number 1: Logistic-01.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Logistic-01.Rnw:100-102
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
### code chunk number 4: LogisticPDF3 (eval = FALSE)
###################################################
## par(mfrow=c(4,2))
## scale<-c(0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.25)
## location <- c(1, 1, 1, 1, 1, 1, 1, 1)
## ylim2<-c(.5, .5, .4, .4, .3, .3, .2, .2)
## for(i in 1:8){
##     loc <- location[i]
##     x <- seq(-3,7, by = 0.05)
##     mainlabel <- paste("location=", loc,", scale=", scale[i], sep="")
##     xlogis <- dlogis(x, scale = scale[i],  loc = loc, log = F)
##     plot(x, xlogis, type = "l", main = mainlabel, xlab = "x", ylab = "probability of x", ylim = c(0, ylim2[i]))
## }


###################################################
### code chunk number 5: Logistic-01.Rnw:220-224
###################################################


par(mfrow=c(4,2))
scale<-c(0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.25)
location <- c(1, 1, 1, 1, 1, 1, 1, 1)
ylim2<-c(.5, .5, .4, .4, .3, .3, .2, .2)
for(i in 1:8){
    loc <- location[i]
    x <- seq(-3,7, by = 0.05)
    mainlabel <- paste("location=", loc,", scale=", scale[i], sep="")
    xlogis <- dlogis(x, scale = scale[i],  loc = loc, log = F)
    plot(x, xlogis, type = "l", main = mainlabel, xlab = "x", ylab = "probability of x", ylim = c(0, ylim2[i]))
}



###################################################
### code chunk number 6: LogisticPDF
###################################################
x <- seq(-10,10, by=0.05)
mylogis1 <- dlogis(x, location = 0, scale = 1, log = FALSE) 
mylogis2 <- dlogis(x, location = 0, scale = 2, log = FALSE) 
mylogis3 <- dlogis(x, location = 0, scale = 3, log = FALSE) 
matplot(x, cbind(mylogis1, mylogis2, mylogis3),type="l",ylim=c(0,0.5), xlab="x",ylab="P(x)", main="") 
legend("topleft", c("scale=1","scale=2","scale=3"),lty=1:3, col=1:3) 


###################################################
### code chunk number 7: LogisticPDF2
###################################################
x <- seq(-10,10, by=0.05)
mylogis111 <- dlogis(x, location = 0, scale = 1, log = FALSE) 
mylogis222 <- dlogis(x, location = 2, scale = 1, log = FALSE) 
mylogis333 <- dlogis(x, location = 4, scale = 1, log = FALSE) 
matplot(x, cbind(mylogis111, mylogis222, mylogis333),type="l",ylim=c(0,0.5), xlab="x",ylab="P(x)", main="") 
legend("topleft", c("location=0","location=2","location=4"), lty=1:3, col=1:3) 


###################################################
### code chunk number 8: 6
###################################################
x <- seq(-6,6, by=0.05)
mylogis111 <- dlogis(x, location = 0, scale = 1, log = FALSE) 
myNorm <- dnorm(x, mean = 0, sd = pi/sqrt(3)) 
matplot(x, cbind(mylogis111, myNorm),type="l",ylim=c(0,0.5), xlab="x",ylab="P(x)", main="") 
legend("topleft", c("Logistic(0,1)","Normal(0,pi^2/3))"), lty=1:2, col=1:2) 


###################################################
### code chunk number 9: LogisticCDF
###################################################
x <- seq(-10,10, by=0.05)
mylogis11<- plogis(x, location = 0, scale = 1, log = FALSE)
mylogis22 <- plogis(x, location = 0, scale = 2, log = FALSE)
mylogis33 <- plogis(x, location = 0, scale = 3, log = FALSE)
matplot(x, cbind(mylogis11, mylogis22, mylogis33),type="l",ylim=c(0,1), xlab="x", ylab="P(x)", main="")
legend("topleft", c("scale=1","scale=2","scale=3"),lty=1:3, col=1:3)


