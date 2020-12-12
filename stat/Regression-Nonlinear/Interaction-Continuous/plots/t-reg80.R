###################################################
### code chunk number 35: reg80
###################################################
V <- vcov(m2)
varsum <- V[2,2]+mean(dat$x2)^2*V[4,4]+2*mean(dat$x2)*V[2,4]
varsum
sqrt(varsum)


