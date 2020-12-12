### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T10840/lyx_tmpbuf2/Poisson_v1-2.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Poisson_v1-2.Rnw:19-20
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Poisson_v1-2.Rnw:95-97
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
### code chunk number 4: Poisson_v1-2.Rnw:217-231
###################################################
par(mfrow=c(2,1))

xvals <- seq(0,5, by=0.05)

eulers <- exp(xvals)

plot(xvals, eulers, type="l", xlab="x",ylab=expression(e^x == exp(x)))

eulers <- exp(-xvals)

plot(xvals, eulers, type="l", xlab="x",ylab=expression(e^(-x) == exp(-x)))

par(mfcol=c(1,1))



###################################################
### code chunk number 5: Poisson_v1-2.Rnw:343-371
###################################################
createPlot <- function(xin,lamb){

 probability <- dpois(xin,lambda=lamb)

 myTitle <- bquote( lambda == .(lamb))



 plot(xin, probability, ylab = "probability",type="h",main = myTitle)

 points(xin,probability,pch=16,cex=0.7)

}



par(mfrow = c(3,2))

x <- seq(0, 15, 1)

lambdas <- c(0.01, 0.1, 0.25, 0.5, 1.0, 2.0)

  for (i in 1:6){

createPlot(x,lambdas[i])

}



###################################################
### code chunk number 6: Poisson_v1-2.Rnw:380-414
###################################################
createPlot <- function(xin,lamb){

 probability <- dpois(xin,lambda=lamb)

 myTitle <- bquote( lambda == .(lamb))



 plot(xin, probability, ylab = "probability",type="h",main = myTitle)

 points(xin,probability,pch=16,cex=0.7)

}



par(mfrow= c(3,2))

uppers <- c(10 ,10, 40, 40, 400, 400)

lambdas <- c(2, 5, 10, 20, 100, 200)

for (i in 1:6){



  x <- seq(0, uppers[i], 1)

   createPlot(x,lambdas[i])

}





###################################################
### code chunk number 7: Poisson_v1-2.Rnw:423-461
###################################################
createPlot <- function(xin,lamb){

 probability <- dpois(xin,lambda=lamb)

 myTitle <- bquote( lambda == .(lamb))



 plot(xin, probability, ylab = "probability",type="s",main = myTitle)



}



par(mfrow = c(3,2))



lambdas <- c(2, 5, 10, 20, 100, 200)

uppers <- c(10 ,10, 40, 40, 400, 400)

for (i in 1:6){

   

    x <- seq(0, uppers[i], 1)

    createPlot(x,lambdas[i])

 

}





###################################################
### code chunk number 8: Poisson_v1-2.Rnw:470-508
###################################################
createPlot <- function(xin,lamb){

 probability <- dpois(xin,lambda=lamb)

 myTitle <- bquote( lambda == .(lamb))



 plot(xin, probability, ylab = "probability",type="l",main = myTitle)



}



par(mfrow = c(3,2))



lambdas <- c(2, 5, 10, 20, 100, 200)

uppers <- c(10 ,10, 40, 40, 400, 400)

for (i in 1:6){

   

    x <- seq(0, uppers[i], 1)

    createPlot(x,lambdas[i])

 

}





