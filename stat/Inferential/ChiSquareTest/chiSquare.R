#Paul Johnson
#2011-04-14
# Plots a Chi Square distribution

# N is degrees of freedom.

## Exercise. Run this. Then adjust code to make figure "look nice" if N=2000

N <- 30
x <- seq(0, 3*N, by=0.1)
xden <- dchisq(x, df=N)

plot(x, xden, type="n",main="",xlab=paste("A Chi-Square Variable (df=",N,")"), ylab="Density")
abline(h= 0, col=gray(.80))

cv <- qchisq(0.95, df=N)
chicv <- dchisq(cv, df=N)

xcrit <- seq(cv, max(x), by=0.1)
ycrit <- dchisq(xcrit, df=N)

polygon(x=c(xcrit, xcrit[length(xcrit):1]), y=c(ycrit,rep(0,length(xcrit))), density=95, col=gray(.90))

lines(x, xden, lty=1) 
lines( c(cv,cv),c(0,chicv),lty=4)
text(cv, chicv, pos=4, bquote(paste("Critical value of", Chi^2==.(round(cv,2)))))
text(cv+0.25*(max(x)-cv), 0.25*chicv, pos=4, bquote(paste("Shaded Area = Prob(",Chi^2 > .(round(cv,2)),")=0.05")),cex=0.7)




#####################################
#########Answer######################
#########Answer######################


N<- 1999
xrange <- range( rchisq(50, df=N))
xrange[2] <-1.2*xrange[2]

x <- seq(xrange[1], xrange[2], by=0.1)
xden <- dchisq(x, df=N)

plot(x, xden, type="n",main="",xlab=paste("A Chi-Square Variable (df=",N,")"), ylab="Density")
abline(h= 0, col=gray(.80))

cv <- qchisq(0.95, df=N)
chicv <- dchisq(cv, df=N)

xcrit <- seq(cv, max(x), by=0.1)
ycrit <- dchisq(xcrit, df=N)

polygon(x=c(xcrit, xcrit[length(xcrit):1]), y=c(ycrit,rep(0,length(xcrit))), density=95, col=gray(.90))

lines(x, xden, lty=1) 
lines( c(cv,cv),c(0,chicv),lty=4)
text(cv, chicv, pos=4, bquote(paste("Critical value of", Chi^2==.(round(cv,2)))))
text(cv+0.25*(max(x)-cv), 0.25*chicv, pos=4, bquote(paste("Shaded Area = Prob(",Chi^2 > .(round(cv,2)),")=0.05")),cex=0.7)






