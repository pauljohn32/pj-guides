## PJ
## 20201105

x <- c("R", "I", "D", "R", "I", "D")

xf <- factor(x, levels = c("R", "I", "D"))


y <- c(3, 4, 4, 1, 4, 6)
dat <- data.frame(x,y, xf)


m1 <- lm(y ~ xf, data=dat)
summary(m1)

xf

library(rockchalk)

dat$xf2 <- combineLevels(dat$xf, levs = c("I", "D"), newLabel= "notR")

m2 <- lm(y ~ xf2, data=dat)


library(plyr)
?mapvalues


mapvalues(dat$xf, from = c("I", "D"), to = c("notR", "notR"))

mapvalues(dat$xf, from = c("I", "D"), to = rep("notR", length.out = 2))

mapvalues



factor(dat$xf, levels = c("R", "I", "D"), labels = c("R", "notR", "notR"))
