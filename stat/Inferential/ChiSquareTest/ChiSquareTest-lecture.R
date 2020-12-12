### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM9920/lyx_tmpbuf2/ChiSquareTest-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: ChiSquareTest-lecture.Rnw:22-23
###################################################
  if(exists("ls.enc")) options(encoding=ls.enc)


###################################################
### code chunk number 2: ChiSquareTest-lecture.Rnw:76-78
###################################################
#unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 4.1, 1.5, 2.1) 
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)


###################################################
### code chunk number 4: CS2
###################################################
xvals <- seq(0,22,length.out=1000)

chisquare1 <- dchisq(xvals, df=1)
chisquare2 <- dchisq(xvals, df=6)
chisquare3 <- dchisq(xvals, df=2)
chisquare4 <- dchisq(xvals, df=3)
chisquare5 <- dchisq(xvals, df=10)
chisquare6 <- dchisq(xvals, df=15)

matplot(xvals, cbind(chisquare1, chisquare2, chisquare3, chisquare4, chisquare5, chisquare6), type="l", xlab="Observed sum (S)", ylab="probability of S",  ylim=c(0,1), main="Chi-Square Probability Densities")
text(.4, .9, expression(paste(nu==1)), pos=4, col=1)
text(4.2, .15, expression(paste(nu==6)), pos=4, col=2)
text(.44, .4, expression(paste(nu==2)), pos=4, col=3)
text(1.7, .23, expression(paste(nu==3)), pos=4, col=4)
text(10, .10, expression(paste(nu==10)), pos=4, col=5)
text(15, .08, expression(paste(nu==15)), pos=4, col=6)


###################################################
### code chunk number 5: CH3
###################################################
N <- 30
x <- seq(0, 3*N, by=0.1)
xden <- dchisq(x, df=N)

plot(x, xden, type="n",main="",xlab=expression(paste("A Chi-Square Variable (",nu == 30,")")), ylab="Density")
abline(h= 0, col=gray(.80))

cv <- qchisq(0.95, df=N)
chicv <- dchisq(cv, df=N)

xcrit <- seq(cv, max(x), by=0.1)
ycrit <- dchisq(xcrit, df=N)

polygon(x=c(xcrit, xcrit[length(xcrit):1]), y=c(ycrit,rep(0,length(xcrit))), density=95, col=gray(.90))

lines(x, xden, lty=1) 
lines( c(cv,cv),c(0,chicv),lty=4)
text(cv, (1.3)*chicv, pos=4, bquote(paste("Critical value of ", Chi^2==.(round(cv,2)))))
text(cv+0.15*(max(x)-cv), 0.5*chicv, pos=4, bquote(paste("Shaded: Prob(", Chi^2 > .(round(cv,2)), ")=0.05")),cex=0.7)


###################################################
### code chunk number 6: CH4
###################################################
N<- 300
xrange <- range( rchisq(50, df=N))
xrange[2] <-1.3*xrange[2]

x <- seq(xrange[1], xrange[2], by=0.1)
xden <- dchisq(x, df=N)

plot(x, xden, type="n",main="",xlab=expression(paste("A Chi-Square Variable (", nu == 300,")")), ylab="Density")
abline(h= 0, col=gray(.80))

cv <- qchisq(0.95, df=N)
chicv <- dchisq(cv, df=N)

xcrit <- seq(cv, max(x), by=0.1)
ycrit <- dchisq(xcrit, df=N)

polygon(x=c(xcrit, xcrit[length(xcrit):1]), y=c(ycrit,rep(0,length(xcrit))), density=95, col=gray(.90))

lines(x, xden, lty=1) 
lines( c(cv,cv),c(0,chicv),lty=4)
text(cv, (1.3)*chicv, pos=4, bquote(paste("Critical value of ", Chi^2==.(round(cv,2)))))
text(cv+0.15*(max(x)-cv), 0.5*chicv, pos=4, bquote(paste("Shaded: Prob(",Chi^2 > .(round(cv,2)),")=0.05")), cex=0.7)


###################################################
### code chunk number 7: ChiSquareTest-lecture.Rnw:481-484
###################################################
options(width=55)
library(gmodels)
 CrossTable(infert$education, infert$induced, expected = TRUE, format="SPSS", chisq=T, fisher=T, mcnemar=T)


