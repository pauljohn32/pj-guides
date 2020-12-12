###################################################
### code chunk number 5: prob1b (eval = FALSE)
###################################################
## lfit <- loess(weight ~ height, data = dat, span = 0.5, degree = 2, family = "gaussian")
## dat <- dat[order(dat$height) ,]
## lopred <- predict(lfit, newdata = dat) 
## plot(weight ~ height, data = dat) 
## lines(dat$height, lopred)
## abline(mod1, lwd = 0.7, lty=2)
## legend("topleft", legend = c("loess","OLS"), lwd = c(1,0.7), lty = 1:2)


