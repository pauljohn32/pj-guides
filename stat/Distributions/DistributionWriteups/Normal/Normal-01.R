### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T10105/lyx_tmpbuf2/Normal-01.Rnw'

###################################################
### code chunk number 1: Normal-01.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Normal-01.Rnw:100-102
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
### code chunk number 4: Normal-01.Rnw:148-152
###################################################
asequence<- seq(from=0,to=5,by=0.1)
expnegx2 <- exp(-asequence^2)

plot(asequence, expnegx2, type = "l", ylab = expression(exp(-z^2)), xlab = "z")


###################################################
### code chunk number 5: Normal1 (eval = FALSE)
###################################################
## mu <- 3
## sigma <- 5
## xrange <- seq(from = mu-3*sigma, to = mu+3*sigma, by = 0.2)
## mainlabel <- expression(paste("Normal Distribution, N(",mu,",",sigma,"^2",")", sep=""))
## xprob <- dnorm(xrange, mean = mu, sd = sigma, log = FALSE)
## plot(xrange, xprob, type = "l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x")
## 


###################################################
### code chunk number 6: Normal-01.Rnw:200-201
###################################################
mu <- 3
sigma <- 5
xrange <- seq(from = mu-3*sigma, to = mu+3*sigma, by = 0.2)
mainlabel <- expression(paste("Normal Distribution, N(",mu,",",sigma,"^2",")", sep=""))
xprob <- dnorm(xrange, mean = mu, sd = sigma, log = FALSE)
plot(xrange, xprob, type = "l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x")



###################################################
### code chunk number 7: Normal2 (eval = FALSE)
###################################################
## par(mfrow=c(4,2))
## 
## for (i in 1:4){
##     for (j in 1:2) {
##        mu <- 3*j
##        sigma <- 2*i
##        xrange <- seq(from=mu-3*sigma,to=mu+3*sigma,by=0.2)
##        mainlabel <- paste("N(",mu,",",sigma*sigma,",)",sep="")
##        xprob <- dnorm(xrange, mean=mu, sd=sigma, log = FALSE)
##        plot(xrange, xprob, type="l", main=mainlabel, xlab="possible values of x", ylab="probability of x")
##     }
## }


###################################################
### code chunk number 8: Normal-01.Rnw:231-232
###################################################
par(mfrow=c(4,2))

for (i in 1:4){
    for (j in 1:2) {
       mu <- 3*j
       sigma <- 2*i
       xrange <- seq(from=mu-3*sigma,to=mu+3*sigma,by=0.2)
       mainlabel <- paste("N(",mu,",",sigma*sigma,",)",sep="")
       xprob <- dnorm(xrange, mean=mu, sd=sigma, log = FALSE)
       plot(xrange, xprob, type="l", main=mainlabel, xlab="possible values of x", ylab="probability of x")
    }
}


###################################################
### code chunk number 9: Normal3
###################################################
par(mfrow=c(4,2))

for (i in 1:4){
   for ( j in 1:2) {
       mu <- 3*j
       sigma <- 2*i
       xrange <- seq(from = mu-3*sigma, to = mu+3*sigma, by = 0.2)
       mainlabel <- paste("N(",mu,",",sigma*sigma,",)", sep="")
       xprob <- dnorm(xrange, mean = mu, sd = sigma, log = FALSE)
       plot(xrange, xprob, type = "l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x", xlim = c(-20,30))
    }
}


###################################################
### code chunk number 10: Normal-01.Rnw:269-271
###################################################
par(mfrow=c(4,2))

for (i in 1:4){
   for ( j in 1:2) {
       mu <- 3*j
       sigma <- 2*i
       xrange <- seq(from = mu-3*sigma, to = mu+3*sigma, by = 0.2)
       mainlabel <- paste("N(",mu,",",sigma*sigma,",)", sep="")
       xprob <- dnorm(xrange, mean = mu, sd = sigma, log = FALSE)
       plot(xrange, xprob, type = "l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x", xlim = c(-20,30))
    }
}



