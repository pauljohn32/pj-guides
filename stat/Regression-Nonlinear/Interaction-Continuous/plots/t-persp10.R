###################################################
### code chunk number 6: persp10
###################################################
x1 <- seq(0, 10, length=50)
x2 <- seq(-20, 30, length=50)
yfn <- function(x1,x2) 2 + 0.5 * x1 + 0.2 * x2 + 0.03 * x1 *x2
y <- outer(x1, x2, yfn)
matr <- persp(x=x1, y=x2, z=y, xlab="x1", ylab="x2", zlab="y")


