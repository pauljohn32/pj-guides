###################################################
### code chunk number 33: reg60
###################################################
bs <- coef(m2)
yhatmean <- bs[1] + bs[2] * mean(dat$x1) + bs[3] * mean(dat$x2) + bs[4]*mean(dat$x1)*mean(dat$x2)
yhatmean


