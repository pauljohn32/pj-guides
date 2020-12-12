###################################################
### code chunk number 7: prob1d (eval = FALSE)
###################################################
## mod4 <- lm( weight ~ ns(height, df = 4), data = dat) 
## summary(mod4)
## #dang. Should have sorted dat by height first.
## dat <- dat[order(dat$height), ] 
## mod4pred <- predict(mod4, newdata = dat)
## plot(weight ~ height, data = dat) 
## lines(dat$height, mod4pred, col = green, lty = 4, lwd = 2)


