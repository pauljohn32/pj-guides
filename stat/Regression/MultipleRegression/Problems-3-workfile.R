
x <- rpois(100, lambda=10)

y <- rnorm(100, m=50, s=10)

plot(x,y, xlab="x is here", ylab= "y is here", pch=8, cex=0.5)

mod1 <- lm(y ~ x)

xSequence <- range(x)

predSequence <- predict(mod1, newdata=data.frame(x=xSequence))

lines(xSequence, predSequence, col="red", lty=3, lwd=2)
lines(xSequence, predSequence, col=gray(.5), lty=3, lwd=2)


x <- c(1,2,3,4,5)
y <- c(5,4,3,4,5)
nam <- c("Bill", "Charles","Jane","Jill","Jaime")

dat <- data.frame(x,y,nam)
rm(x,y,nam)

plot(y~x, dat=dat)

with(dat,
identify(x,y, nam)
     )
