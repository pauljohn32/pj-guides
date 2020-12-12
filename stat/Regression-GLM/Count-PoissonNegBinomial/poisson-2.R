b0 <-   40; b1 <- 0.08; b2 <- 0.05

x1 <- rnorm(500, m=5, s=10)
x2 <- rnorm(500, m=10, s=15)
eta <- b0 + b1 * x1 + b2 * x2
input <- exp(eta)
y <- rpois(500, lambda = input)

plot(x1, y, main="Ugly Poisson Data, 2")


dat <- data.frame(x1,x2,y)


m1 <- glm(y ~ x1 + x2, data=dat, family=poisson(link=log))
summary(m1)

library(rockchalk)
newdat <- expand.grid(x1=plotSeq(dat$x1, length.out=20), x2=mean(dat$x2))
newdat$p1 <- predict(m1, newdata=newdat, type="response")

lines(newdat$x1, newdat$p1, lwd=3, col="red")

lm1 <- lm(y ~ x1 + x2, data=dat)
summary(lm1)
newdat$lmp1 <- predict(lm1, newdata=newdat)
lines(newdat$x1, newdat$lmp1, lwd=3, col="green")

legend("topleft", legend=c("Exp. Poisson", "OLS"), lwd=c(3,3), col=c("red","green"))
