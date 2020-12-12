###################################################
### code chunk number 7: persp20
###################################################
plot(x1, y=plotSeq(range(y), length(x1)), type="n", ylab="y")
intr <- function(x) 2 + 0.2 *x
sloper <- function(x) 0.5 + 0.03*x
abline(a=intr(-20), b=sloper(-20), lty=1, lwd=2)
abline(a=intr(-10), b=sloper(-10), lty=2, lwd=2)
abline(a=intr(10), b=sloper(10), lty=3, lwd=2)
abline(a=intr(20), b=sloper(20), lty=4, lwd=2)
legend("topleft",c("x2=-20", "x2=-10", "x2=10", "x2=20"), lty=c(1,2,3,4), lwd=2)


