###################################################
### code chunk number 4: example10
###################################################
library(rockchalk)
set.seed(123412)
dat <- genCorrelatedData(N=400, rho=.1, stde=300, beta=c(2,-0.1,0.1,0.2))
m1 <- lm(y ~ x1*x2, data=dat)
fit1 <- plotPlane(m1, plotx1="x1", plotx2="x2", plotPoints=F, drawArrows=F, ticktype="detailed", theta=-20, npp=10, x1floor = 3, x2floor = 3)


