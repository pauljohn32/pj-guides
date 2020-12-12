###################################################
### code chunk number 19: jn51
###################################################
dat2b <- genCorrelatedData(N=400, rho=.1, stde=300, beta=c(2, 0, 0.3, 0.15), means = c(50,0), sds = c(10, 40))
m2b <- lm(y ~ x1*x2, data=dat2b)
m2bps <- plotSlopes(m2b, plotx="x1", modx="x2")
plot(testSlopes(m2bps))


