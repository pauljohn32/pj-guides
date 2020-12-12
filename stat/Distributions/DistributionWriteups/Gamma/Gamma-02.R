### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM9058/lyx_tmpbuf2/Gamma-02.Rnw'

###################################################
### code chunk number 1: Gamma-02.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Gamma-02.Rnw:90-92
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
### code chunk number 4: Gamma-02.Rnw:171-174
###################################################
xvals<-seq(0,5,by=0.05)
gammaxvals <- gamma(xvals)
plot(xvals, gammaxvals, type = "l", xlab = "x", ylab = expression(Gamma(x)), main = "The Gamma Function")


###################################################
### code chunk number 5: Gamma1
###################################################
xvals <- seq(0,10,length.out=1000)

gam1 <- dgamma(xvals, shape = 1, scale = 1)
gam2 <- dgamma(xvals, shape=2, scale= 1)
matplot(xvals, cbind(gam1,gam2), type = "l", ylab = "gamma probability density",  ylim = c(0,1), main = "Gamma Probability Densities")

text(.4, .7, "shape=1, scale=1", pos=4, col=1)
text(3, .2, "shape=2, scale=1", pos=4, col=2)


###################################################
### code chunk number 6: Gamma-02.Rnw:204-206
###################################################
xvals <- seq(0,10,length.out=1000)

gam1 <- dgamma(xvals, shape = 1, scale = 1)
gam2 <- dgamma(xvals, shape=2, scale= 1)
matplot(xvals, cbind(gam1,gam2), type = "l", ylab = "gamma probability density",  ylim = c(0,1), main = "Gamma Probability Densities")

text(.4, .7, "shape=1, scale=1", pos=4, col=1)
text(3, .2, "shape=2, scale=1", pos=4, col=2)



###################################################
### code chunk number 7: Gamma2
###################################################
par(mfcol=c(4,2))

for ( i in 1:8){
    shape <- c(0.5,1,2,3,5,10,15,30)
    scale <- 1
    xrange<-seq(from = 0, to = 50, by = 0.1)
    mainlabel<- paste("Gamma(shape=", shape[i],",scale=",scale,",)",sep="")
    xprob <- dgamma(xrange, shape = shape[i], scale = scale, log = F)
    plot(xrange, xprob, type = "l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x")
}


###################################################
### code chunk number 8: Gamma-02.Rnw:245-247
###################################################
par(mfcol=c(4,2))

for ( i in 1:8){
    shape <- c(0.5,1,2,3,5,10,15,30)
    scale <- 1
    xrange<-seq(from = 0, to = 50, by = 0.1)
    mainlabel<- paste("Gamma(shape=", shape[i],",scale=",scale,",)",sep="")
    xprob <- dgamma(xrange, shape = shape[i], scale = scale, log = F)
    plot(xrange, xprob, type = "l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x")
}



###################################################
### code chunk number 9: Gamma3
###################################################
par(mfcol=c(4,3))

for ( j in 1:3){
 for ( i in 1:4 ){
  shape <- c(0.5,1,2,10)
  scale <- c(0.5,1,3)
  xrange <- seq(from = 0, to = scale[j]*20, by = 0.1)
  mainlabel<- paste("shape=",shape[i],",scale=", scale[j],sep="")
  xprob <- dgamma(xrange, shape = shape[i], scale = scale[j], log = FALSE)
  plot(xrange, xprob, type="l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x")
 }
}


###################################################
### code chunk number 10: Gamma-02.Rnw:282-283
###################################################
par(mfcol=c(4,3))

for ( j in 1:3){
 for ( i in 1:4 ){
  shape <- c(0.5,1,2,10)
  scale <- c(0.5,1,3)
  xrange <- seq(from = 0, to = scale[j]*20, by = 0.1)
  mainlabel<- paste("shape=",shape[i],",scale=", scale[j],sep="")
  xprob <- dgamma(xrange, shape = shape[i], scale = scale[j], log = FALSE)
  plot(xrange, xprob, type="l", main = mainlabel, xlab = "possible values of x", ylab = "probability of x")
 }
}


