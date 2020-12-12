### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM8748/lyx_tmpbuf2/Beta.Rnw'

###################################################
### code chunk number 1: Beta.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Beta.Rnw:39-40
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=180, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
options(SweaveHooks=list(fig=function() par(ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: graph1
###################################################
N <- 30
alphaseq <- seq(0.2, 2 , length.out=N)
betaseq <- seq(0.2, 2 , length.out=N)
myProbX <- function(x1, x2){
beta(x1,x2)
}

mybeta<- outer(alphaseq,betaseq, FUN="myProbX")
persp(alphaseq,betaseq, mybeta, theta = 120, phi = 7, col = "pink", zlim=c(0,10),zlab="Beta Function", xlab="alpha", ylab="beta",ticktype="detailed")


###################################################
### code chunk number 5: graph2
###################################################
N <- 30
alphaseq <- seq(0.2, 2 , length.out=N)

betaseq <- seq(0.2, 2 , length.out=N)

VarMu <- function(x1, x2){
 v <- x2/((x1+x2)*(x1+x2+1))
}

myvar <- outer(alphaseq,betaseq, FUN="VarMu")

mypersp <- persp(alphaseq,betaseq, myvar, theta = 125, phi = 7, col = "pink", zlim=c(0,0.5),zlab="Multiplier", xlab="alpha", ylab="beta",ticktype="detailed")

text(trans3d(1.2,0.1,0.4, mypersp), label=expression(Var(x) == mu %*% Multiplier ))


###################################################
### code chunk number 6: graph3
###################################################
x <- seq(0,1,length=21)
myvar <- dbeta (x,1,1)
plot (x,myvar,main="",xlab="x",ylab="probability",ylim=c(0,1),type="l")


###################################################
### code chunk number 7: graph4
###################################################
#PJ 2004-05-04
#For project with erik herron to demonstrate Beta parameters
#
sampleSize <- 100
# Suppose you want to generate 10 distributions
# and display them in a single picture

par(mfrow=c(5,1))

# x11(height=3.0,width=5)

createDist <-function(mode){

  alphaMin <- 3

  B <- (alphaMin-mode*(alphaMin-2)-1)/mode
  A <- (mode*alphaMin-2*mode+1)/(1-mode)
  if (mode <= 0.5) {
      alpha1 <- alphaMin
      alpha2 <- B
    } else
    {

      alpha2 <- alphaMin

      alpha1 <- A

    }

 

  z <- dbeta(seq(0,1,length=100),shape1=alpha1,shape2=alpha2)

  plot(1:100,z, type="l",ylim=c(0,2.5),main=paste("Beta(",round(alpha1,2),",",round(alpha2,2),")"), xlab="x",ylab="probability density")

}
par(mfrow=c(3,1))
createDist(.3)
createDist(.5)
createDist(.7)


###################################################
### code chunk number 8: graph5
###################################################
#PJ 2004-05-04
#For project with erik herron do demonstrate Beta parameters
#
sampleSize <- 500

createDist <-function(alphaMin, mode) {
  B <- (alphaMin-mode*(alphaMin-2)-1)/mode
  A <- (mode*alphaMin-2*mode+1)/(1-mode)
  if (mode <= 0.5) {
      alpha1 <- alphaMin
      alpha2 <- B
} else {
   alpha2 <- alphaMin
   alpha1 <- A
}

  mean1 <- (alpha1)/(alpha1+alpha2)
  var1 <- (alpha1*alpha2)/(((alpha1+alpha2)^2)*(alpha1+alpha2+1));
  z <- dbeta(seq(0,1,length=100),shape1=alpha1,shape2=alpha2);

 plot(1:100,z, type="l",ylim=c(0,3.5),main=paste("Beta(",round(alpha1,2),", ", round(alpha2,2),")"," mode=",mode," mean=",round(mean1,2),", var=",round(var1,3),sep=""), xlab="ideal point",ylab="density")

}

makeDisp <- function(aseq, mode){
    par(mfrow=c(5,2))
    for (i in 1:length(aseq))
      createDist(aseq[i], mode)
  }

myseq <- seq(1.1, 7, length=10)
makeDisp(myseq,.3)


###################################################
### code chunk number 9: graph6
###################################################

createDist2 <-function(alpha1,alpha2) {
   mean1 <- (alpha1)/(alpha1+alpha2)
   var1 <-(alpha1*alpha2)/(((alpha1+alpha2)^2)*(alpha1+alpha2+1));
   inx <- seq(0,1,length.out=100)
   z <- dbeta(inx,shape1=alpha1,shape2=alpha2);

   mytitle <- paste("Beta(",alpha1,",",alpha2," mean=",round(mean1,2)," var=",round(var1,2),sep="")
   plot(inx,z,type="l",ylim=c(0,3.5),xlab="x",ylab="density",main=mytitle)
}

makeDisp <- function() {
    myalpha<- c(0.2, 0.5, 0.75 , 1.1)

    par(mfcol=c(4,2))
    for (j in 1:4){
      createDist2(0.7,myalpha[j])
    }

    for (j in 1:4){
      createDist2(1.2,myalpha[j])
    }
  }
makeDisp()


