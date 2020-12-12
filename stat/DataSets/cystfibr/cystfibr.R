## Example Code to access the data "cystfibr.txt" from R
## Paul Johnson 2011-08-09

dat <- read.table("cystfibr.txt", header=T)

plot(height~weight, data=dat)

plot(log(height)~log(weight), data=dat)

plot(height~weight, data=dat)

myhw <- loess(height~weight, data=dat)
newweight <-sort(dat$weight) 
lopred1 <- predict(myhw, newdata=data.frame(weight=newweight))
lines(newweight, lopred1)


plot(height ~ log(weight), data=dat)

dat$logweight <- log(dat$weight)
myhw2 <- loess(height~logweight, data=dat)
newweight2 <-  sort(dat$logweight)
lopred2 <- predict(myhw2, newdata=data.frame(logweight=newweight2))
lines(newweight2, lopred2)


mod1 <- lm(pemax ~ age + sex + height + weight, data=dat)
summary(mod1)
termplot(mod1,se=T, partial=T)


mod2 <- lm(pemax ~  weight, data=dat)
summary(mod2)

mod3 <- lm(pemax ~ height + weight, data=dat)
summary(mod3)

mod4 <- lm(pemax ~ height, data=dat)
summary(mod4)

mod5 <- lm(pemax ~ age, data=dat)
summary(mod5)

library(lmSupport)
lm.sumSquares(mod1)

