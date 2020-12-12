### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.M22660/lyx_tmpbuf2/GammaGLM-01.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: GammaGLM-01.Rnw:15-16
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: GammaGLM-01.Rnw:115-117
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
#pjmar <- c(5.1, 4.1, 1.0, 2.1) 
#options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
options(SweaveHooks=list(fig=function() par(ps=10)))
pdf.options(onefile=F,family="Times",pointsize=10)


###################################################
### code chunk number 4: 1
###################################################
par (mfrow=c(2,2))

xseq <- seq(0,20,by=0.05)

plot(xseq,1/(3+ .25 * xseq),main="1/(3+0.25*x)",type="l")

plot(xseq,1/(3-0.25 * xseq),main="1/(3-0.25*x)",type="l")

plot(xseq,1/(-5+.25*xseq),main="1/(-5+0.25*x)",type="l")

plot(xseq,1/(-5-.25*xseq),main="1/(-5-0.25*x)",type="l")



###################################################
### code chunk number 5: 2
###################################################
set.seed(223456)

xseq<- seq(3, 20, length.out=800)

yobs <- vector()

mu <- vector()

for ( i in 1:800){

  mu[i] <- 1 + 65 / xseq[i]

  yobs[i] <- rgamma(1, shape=1.5, scale=mu[i]/1.5)

}

plot(xseq,yobs,type="n",main="Gamma DV, mu= 1 + 65/x",xlab="x",ylab="y")

points(xseq,yobs,pch=16,cex=0.25)

lines(xseq,mu, lty=1,lwd=3)



###################################################
### code chunk number 6: GammaGLM-01.Rnw:551-560
###################################################

agam <- glm(yobs ~ I(1/xseq), family = Gamma(link = "identity"), control = glm.control(maxit=100),start=c(1,65))

library(MASS)

myshape <- gamma.shape(agam)

gampred <- predict(agam,type="response", se=T, dispersion=1/myshape$alpha)



###################################################
### code chunk number 7: GammaGLM-01.Rnw:572-574
###################################################
summary(agam,dispersion=1/myshape$alpha)



###################################################
### code chunk number 8: GammaGLM-01.Rnw:585-589
###################################################
lmmod <- glm(yobs~ I(1/xseq))

lmpred <- predict(lmmod, se=T)



###################################################
### code chunk number 9: GammaGLM-01.Rnw:595-597
###################################################
summary(lmmod)



###################################################
### code chunk number 10: GammaGLM-01.Rnw:604-608
###################################################
lmmod1a <- lm ( yobs~I(1/xseq))

summary(lmmod1a)



###################################################
### code chunk number 11: 3
###################################################
plot(xseq,yobs,type="n", xlab="x",ylab="y")

points(xseq,yobs,pch=16,cex=0.25)

lines(xseq,lmpred$fit,lty=2,lwd=5,col="purple")

lines(xseq,gampred$fit, lty=3, lwd=5, col="red")



###################################################
### code chunk number 12: GammaGLM-01.Rnw:666-669
###################################################

cbind(glmGamma=gampred$fit[1:10],glmNormal=lmpred$fit[1:10])



###################################################
### code chunk number 13: GammaGLM-01.Rnw:681-695
###################################################
par(mfcol=c(2,1))

plot(xseq,gampred$fit,type="l",xlab="x",ylab="y", main="Gamma, link=identity")

lines(xseq, gampred$fit+2*gampred$se,lty=2,col="green")

lines(xseq, gampred$fit-2*gampred$se,lty=2,col="green")

plot(xseq,lmpred$fit,type="l",xlab="x",ylab="y", main="Gaussian, link=identity")

lines(xseq, lmpred$fit+2*lmpred$se,lty=2,col="green")

lines(xseq, lmpred$fit-2*lmpred$se,lty=2,col="green")



###################################################
### code chunk number 14: GammaGLM-01.Rnw:765-787
###################################################
set.seed(223456)

xseq <- seq(3, 20, length.out=800)

yobs2 <- vector()

mu2 <- vector()

for ( i in 1:800){

  mu2[i] <- xseq[i]/(3 + 0.25 * xseq[i])

  yobs2[i] <- rgamma(1, shape=1.5, scale=mu2[i]/1.5)

}

plot(xseq,yobs2,type="n",xlab="x",ylab="y")

points(xseq,yobs2,pch=16,cex=0.25)

lines(xseq, mu2, lty=1,lwd=3)



###################################################
### code chunk number 15: GammaGLM-01.Rnw:815-823
###################################################
agam2<-glm(yobs2~ I(1/xseq), family=Gamma(link="inverse"), control=glm.control(maxit=100),start=c(2,4))

library(MASS)

myshape2 <- gamma.shape(agam2)

gampred2 <- predict(agam2,type="response", se=T, dispersion=1/myshape2$alpha)



###################################################
### code chunk number 16: GammaGLM-01.Rnw:832-834
###################################################
summary(agam2, dispersion=1/myshape2$alpha)



###################################################
### code chunk number 17: GammaGLM-01.Rnw:850-855
###################################################

lmmod2 <- lm(I(1/yobs2)~I(1/xseq))

lmpred2 <- predict(lmmod2, se=T)



###################################################
### code chunk number 18: GammaGLM-01.Rnw:866-868
###################################################
summary(lmmod2)



###################################################
### code chunk number 19: GammaGLM-01.Rnw:883-893
###################################################
plot(xseq,yobs2,type="n",xlab="x",ylab="y")

points(xseq,yobs2,pch=16,cex=0.25)

lines(xseq,1/lmpred2$fit,lty=2,lwd=2,col="purple")

lines(xseq,gampred2$fit, lty=5, lwd=3, col="red")

legend(.2*max(xseq),.7*max(yobs2), legend=c("lm-Normal","glm-Gamma"), lty=c(2,5),col=c("purple","red"))



###################################################
### code chunk number 20: GammaGLM-01.Rnw:905-923
###################################################
par(mfcol=c(2,1))

plot(xseq,gampred2$fit,type="l",xlab="x",ylab="y", main="Gamma, link=inverse")

lines(xseq, gampred2$fit+2*gampred$se,lty=2,col="green")

lines(xseq, gampred2$fit-2*gampred$se,lty=2,col="green")

plot(xseq,1/lmpred2$fit,type="l",xlab="x",ylab="y", main="")

ypsem<- lmpred2$fit-1.96*lmpred$se

ypsep<- lmpred2$fit+1.96*lmpred$se

lines(xseq, 1/ypsem,lty=2,col="green")

lines(xseq, 1/ypsep,lty=2,col="green")



###################################################
### code chunk number 21: GammaGLM-01.Rnw:950-955
###################################################

lmmod3 <- glm(yobs2 ~ I(1/xseq), family=gaussian(link="inverse"))

summary(lmmod3)



###################################################
### code chunk number 22: GammaGLM-01.Rnw:971-983
###################################################
lmpred3 <- predict(lmmod3, se=T, type="response")

plot(xseq,yobs2,type="n",xlab="x",ylab="y")

points(xseq,yobs2,pch=16,cex=0.15)

lines(xseq,lmpred3$fit,lty=2,lwd=6,col="purple")

lines(xseq,gampred2$fit, lty=5, lwd=3, col="red")

legend(.2*max(xseq),.7*max(yobs2), legend=c("glm-Normal","glm-Gamma"), lty=c(2,5),col=c("purple","red"))



