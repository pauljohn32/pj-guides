set.seed(132)
b0 <- 0.1; b1 <- 0.2; b2 <- -0.15

x1 <- rnorm(100, m=50, s=10)
x2 <- rnorm(100, m=100, s=20)
eta <- b0 + b1 * x1 + b2 * x2
input <- exp(eta)
y <- rpois(100, lambda = input)

plot(x1, y, main="Ugly Poisson Data")


dat <- data.frame(x1,x2,y)


m1 <- glm(y ~ x1 + x2, data=dat, family=poisson(link=log))
summary(m1)

library(rockchalk)
newdat <- expand.grid(x1=plotSeq(dat$x1, length.out=50), x2=mean(dat$x2))
newdat$p1 <- predict(m1, newdata=newdat, type="response")


lines(newdat$x1, newdat$p1, lwd=3, col="red")

lm1 <- lm(y ~ x1 + x2, data=dat)
newdat$lmp1 <- predict(lm1, newdata=newdat)
lines(newdat$x1, newdat$lmp1, lwd=3, col="green")

legend("topleft", legend=c("Exp. Poisson", "OLS"), lwd=c(3,3), col=c("red","green"))






plot(x2, y, main="Ugly Poisson Data, Again")


newdat <- expand.grid(x1=mean(dat$x1), x2=plotSeq(dat$x2, length.out=50))
newdat$p1 <- predict(m1, newdata=newdat, type="response")

plot(y ~ x2, dat= dat)
lines(newdat$x2, newdat$p1, lwd=3, col="red")

lm1 <- lm(y ~ x1 + x2, data=dat)
newdat$lmp1 <- predict(lm1, newdata=newdat)
lines(newdat$x2, newdat$lmp1, lwd=3, col="green")

legend("topright", legend=c("Exp. Poisson", "OLS"), lwd=c(3,3), col=c("red","green"))
