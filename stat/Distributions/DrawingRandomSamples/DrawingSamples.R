ps.options(horizontal=F, onefile=F, family="Times", paper="special", height=4,
width=6 )
pdf.options(onefile=F, family="Times", paper="special", height=4, width=6)



pdf("importfigs/DrawRandom%003d.pdf", onefile=F, height=4, width=6)

#xfig("DrawRandom%003d.fig", onefile=F, height=3, width=6, textspecial=T, family="Times", pointsize=10)

x <- seq(-3,3, by =0.1)
y <- dnorm(x, mean=0, sd=1)
plot(x,y, type="l", xlab="x", ylab="f(x)")


ycum <- pnorm(x, mean=0, sd=1)
plot(x,ycum, type="l", xlab="x", ylab="F(x)")


plot(x,ycum, type="l", xlab="x", ylab="F(x)", axes=F)
axis(1, tick=T, labels=F, lwd.ticks=0 )
axis(2, at=c(0,1))

myp <- 23
lines(x=c(x[1],x[myp]), y=c(ycum[myp],ycum[myp]),  col="red", lty=4)  
lines(x=c(x[myp], x[myp]), y=c(0,ycum[myp]),  col="red", lty=4) 
mtext(text=x[myp], side=1, at=x[myp])
mtext(text=round(ycum[myp],2), side=2, at=ycum[myp])

myp <- 33
lines(x=c(x[1],x[myp]), y=c(ycum[myp],ycum[myp]),  col="red", lty=4)  
lines(x=c(x[myp], x[myp]), y=c(0,ycum[myp]),  col="red", lty=4) 
mtext(text=x[myp], side=1, at=x[myp])
mtext(text=round(ycum[myp],2), side=2, at=ycum[myp])

myp <- 40
lines(x=c(x[1],x[myp]), y=c(ycum[myp],ycum[myp]),  col="red", lty=4)  
lines(x=c(x[myp], x[myp]), y=c(0,ycum[myp]),  col="red", lty=4) 
mtext(text=x[myp], side=1, at=x[myp])
mtext(text=round(ycum[myp],2), side=2, at=ycum[myp])

####################################################3


## Rejection
##x11(height=4,width=6)
x <- seq(-2,3, by =0.1)
y <- dnorm(x, 0, 1)
x2 <- x[x >=0]
y2 <- 1.1* dnorm(x2,0,1)
plot(x,y, type="l", xlab="x", ylab="probability density",ylim=c(0,0.8))
lines(x2,y2, lty=4)
lines(x=c(x2[1], x2[1]), y=c(dnorm(x2[1],0,1), 1.1* dnorm(x2[1],0,1)), lty=4)
text (1.8, 0.5, label="Throw away this fraction")
arrows(1, 0.48, 0.58, 0.35,  length=0.05, angle=45)


x <- seq(0,3, by =0.1)
y <- dgamma(x, 0.5, 0.4)
plot(x,y, type="l", xlab="x", ylab="f(x)", ylim=c(-0.05,1.0))
text(x[15],y[15], pos=1, label=bquote(f)) 
y2 <- 0.1+ dexp (x, 1.3)
lines(x,y2, lty=4)
text(x[20],y2[20], pos=4, label=bquote(r))



plot(x,y, type="l", xlab="x", ylab="f(x)", ylim=c(-0.05,1.0))
text(x[20],y[20], pos=1, label=bquote(f( .(round(x[20],2),))) )
lines(x,y2, lty=4)
text(x[20],y2[20],adj=c(0,0), pos=3, label=bquote(r( .(x[20])),))

##lines(x=c(x[20],x[20]),y=c(y[20],y2[20]), lty=4, col="red")
arrows(x[20],y[20],x[20],y2[20], lty=4, col="red", angle=90, length=.05 , code=3)

text( x[20], (y[20]+0.1*y2[20]), pos=4, label=paste("gap=", round(y2[20]-y[20],2)))

y[20]
y2[20]





x <- seq(0,1, by =0.001)
y <- dbeta(x, 1.2, 1.9)
plot(x,y, type="l", xlab="x", ylab="probability density", ylim=range(y)*c(1,1.3))
text(0.88, 1.0, pos=1, label=bquote(f(x)==beta(1.2,1.9))) 
y2 <- 1.53 + 0*x
lines(x,y2, lty=4)
text(0.8, 1.4, pos=4, label=bquote(r(x)==1.53))


dev.off()
