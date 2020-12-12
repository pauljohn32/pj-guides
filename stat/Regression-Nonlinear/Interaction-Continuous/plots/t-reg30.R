###################################################
### code chunk number 26: reg30
###################################################
dat$x1c <- dat$x1 - mean(dat$x1, na.rm = TRUE)
dat$x2c <- dat$x2 - mean(dat$x2, na.rm = TRUE)
m3 <- lm(y ~ x1c * x2c, data=dat)


