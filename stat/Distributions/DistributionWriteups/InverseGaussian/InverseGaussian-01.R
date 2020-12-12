### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM9314/lyx_tmpbuf2/InverseGaussian-01.Rnw'

###################################################
### code chunk number 1: InverseGaussian-01.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: InverseGaussian-01.Rnw:100-102
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
### code chunk number 4: InverseGaussian-01.Rnw:145-147 (eval = FALSE)
###################################################
## help.search("inverse gaussian")
## 


###################################################
### code chunk number 5: 1 (eval = FALSE)
###################################################
## library(statmod)
## mu <- 1
## lambda <- 2
## xrange<- seq(from=0.0,to=2*mu+5/lambda,by=0.02)
## mainlabel<- expression(paste("IG(",mu,",",lambda,")",sep=""))
## xprob <- dinvgauss(xrange, mu = mu, lambda = lambda)
## plot(xrange, xprob, type = "l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x")
## 


###################################################
### code chunk number 6: InverseGaussian-01.Rnw:216-217
###################################################
library(statmod)
mu <- 1
lambda <- 2
xrange<- seq(from=0.0,to=2*mu+5/lambda,by=0.02)
mainlabel<- expression(paste("IG(",mu,",",lambda,")",sep=""))
xprob <- dinvgauss(xrange, mu = mu, lambda = lambda)
plot(xrange, xprob, type = "l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x")



###################################################
### code chunk number 7: 2 (eval = FALSE)
###################################################
## par(mfrow=c(4,3))
## for (i in 1:4){
##     for (j in 1:3) {
##         mu <- 3*i
##         lambda <- 20*j
##         xrange <- seq(from = 0.0, to = 3*mu, by = 0.02)
##         mainlabel<- paste("IG(",mu,",",lambda,")", sep = "")
##         xprob <- dinvgauss(xrange, mu = mu, lambda = lambda)
##         plot(xrange, xprob, type = "l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x")
##     }
## }


###################################################
### code chunk number 8: InverseGaussian-01.Rnw:252-253
###################################################
par(mfrow=c(4,3))
for (i in 1:4){
    for (j in 1:3) {
        mu <- 3*i
        lambda <- 20*j
        xrange <- seq(from = 0.0, to = 3*mu, by = 0.02)
        mainlabel<- paste("IG(",mu,",",lambda,")", sep = "")
        xprob <- dinvgauss(xrange, mu = mu, lambda = lambda)
        plot(xrange, xprob, type = "l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x")
    }
}


###################################################
### code chunk number 9: InverseGaussian-01.Rnw:275-282
###################################################
set.seed(124123)

mu <- 12
xlo <- rinvgauss(1000,mu=mu,lambda=2)  
plot(density(xlo),main=paste("Density plot, N=1000,mu=",mu,"lambda=2"))
text(240,0.10,paste("maximum observed x =",round(max(xlo),2)))
abline(v=mu,lty=2,col=3)


###################################################
### code chunk number 10: InverseGaussian-01.Rnw:291-302
###################################################
xmed <- rinvgauss(1000,mu=mu,lambda=5)
xhi <- rinvgauss(1000,mu=mu, lambda=20)

par(mfcol=c(3,1))

hist(xlo, breaks = 100, freq = TRUE, xlim = c(0,max(xlo)), main = paste("mu=", mu, "lambda=2"))
abline(v = mu, lty = 2, col = 3)
hist(xmed, breaks = 100, freq = TRUE, xlim = c(0, max(xlo)), main = paste("mu=", mu, "lambda=5"))
abline(v = mu, lty = 2, col = 3)
hist(xhi, breaks = 100, freq = TRUE, xlim = c(0,max(xlo)), main = paste("mu=", mu, "lambda=20"))
abline(v = mu, lty = 2, col = 3)


###################################################
### code chunk number 11: 3
###################################################
par(mfrow=c(2,1))

mu <- c(2,10)
for (i in 1:2){
  xmax <- 2*mu[i]

  xrange <- seq(from = 0.0, to = xmax, by = 0.02)
  mainlabel<- paste("IG(",mu[i],", various lambda)", sep="")
  xprob <- dinvgauss(xrange, mu = mu[i], lambda = lambda)
  plot(1:2, 1:2, main = mainlabel, xlab="possible values of x",  ylab = "probability of x", type = "n", ylim = c(0,1.0-0.2*i), xlim = c(0,xmax))

  lambda <- vector()
  lambda <- c(1,10,50,100)
  for (j in 1:4) {
    lines(xrange, dinvgauss(xrange, mu[i], lambda[j]), col = j, lty = j)
   }
   legend(xmax-0.8*mu[i], 0.5, paste("lambda=",lambda), lty = 1:4, col = 1:4)
}


###################################################
### code chunk number 12: 6
###################################################
par(mfrow=c(3,2))

lambda <- c(50,10,5,1,0.5,00.001)

#myrange <- c(10,10,5,5,1,1)

myrange <- c(2,2,2,2,1,1)

for ( i in 1:6){
  mu=1
  xrange<-seq(from=0.0,to=myrange[i],by=0.02)
  mainlabel<- paste("IG(",mu,",",lambda[i],")",sep="")
  xprob <- dinvgauss(xrange, mu=mu, lambda=lambda[i])
  plot(xrange, xprob, type="l", main=mainlabel, xlab="possible values of x", ylab="probability of x")
}


###################################################
### code chunk number 13: InverseGaussian-01.Rnw:411-423
###################################################
xvals <- seq(0,20, length.out=200)

gam <- dgamma(xvals, shape=2, scale=1)

igaus <- dinvgauss(xvals,mu=2,lambda=5)

plot(xvals,gam,type="l",lty=1,main="")

lines(xvals,igaus,lty=2)

legend(6,.2,c("gamma(sh=2,sc=1)","inv gauss(mu=2,lambda=5)"),lty=1:2,)



###################################################
### code chunk number 14: InverseGaussian-01.Rnw:437-448
###################################################
par(mfcol=c(3,1))

for (i in 1:3){
    minx <- 20 + 50 * (i-1)
    xvals <- seq(minx,300, length.out=1000)
    gam <- dgamma(xvals, shape = 2, scale = 1)
    igaus <- dinvgauss(xvals, mu = 2, lambda = 5)
    plot(xvals,gam, type="l", lty = 1, main="")
    lines(xvals, igaus, lty = 2)
    legend(150, 0.7*max(gam), c("gamma(sh=2,sc=1)", "inv gauss(mu=2,lambda=5)"), lty = 1:2,)
}


###################################################
### code chunk number 15: InverseGaussian-01.Rnw:457-466
###################################################
par(mfcol=c(2,1))
gam <- rgamma(500, shape=2, scale=1)
igaus <- rinvgauss(500,mu=2,lambda=4)
hist(gam, main="Gamma,sh=2,sc=1")
hist(igaus,main="Inv Gaus, mu=2,lambda=4")
summary(gam)
var(gam)
summary(igaus)
var(igaus)


###################################################
### code chunk number 16: 15
###################################################
par(mfcol=c(2,1))
gam <- rgamma(1000, shape=2, scale=2)
igaus <- rinvgauss(1000, mu=4, lambda=8)
hist(gam, main="Gamma, sh=2, sc=2")
hist(igaus, main="Inv Gauss, mu=4, lambda=8")
summary(gam)
var(gam)
summary(igaus)
var(igaus)


###################################################
### code chunk number 17: 16
###################################################
par(mfcol=c(2,1))
gam <- rgamma(1000, shape=3, scale=4)
igaus <- rinvgauss(1000,mu=12,lambda=34)
hist(gam,breaks=100,main="Gamma, sh=3,sc=4")
hist(igaus,breaks=100,main="Inv Gauss, mu=12,lambda=34")
summary(gam)
var(gam)
summary(igaus)
var(igaus)


