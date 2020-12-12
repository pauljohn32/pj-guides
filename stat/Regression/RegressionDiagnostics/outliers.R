
### Homework Exercise

library(car) 
set.seed(22323)
stde <- 3
x <- rnorm(15, m=50, s=10)
y <- 2 + 0.4 *x + stde * rnorm(15,m=0,s=1)
plot(y~x)
mod1 <- lm(y~x)
summary(mod1)
abline(mod1)

## add in an extreme case

x[16] <- 100
y[16] <- predict(mod1, newdata=data.frame(x=100))+ stde*rnorm(1)

plot(y~x)
mod2 <- lm(y~x, x=T)
summary(mod2)
abline(mod2)
hatvalues(mod2)
rstudent(mod2)
mod2x <- mod2$x
fullHat <- mod2x %*% solve(t(mod2x) %*% mod2x) %*% t(mod2x)
round(fullHat, 2)
colSums(fullHat) ##all 1
sum(diag(fullHat))

##

x[16] <- 100
y[16] <- 10

plot(y~x)
abline(mod2, lty=1)
mod3 <- lm(y~x, x=T)
summary(mod3)
abline(mod3, lty=2)
hatvalues(mod3) ##hat values same
rstudent(mod3)
mod3x <- mod3$x
fullHat <- mod3x %*% solve(t(mod3x) %*% mod3x) %*% t(mod3x)
round(fullHat, 2)
colSums(fullHat) ##all 1
sum(diag(fullHat))

round(dffits(mod3),2)

dfbetasPlots(mod2)
dfbetasPlots(mod3)


################Change to 2 dimensional #####

stde <- 3
x1 <- rnorm(15, m=50, s=10)
x2 <- rnorm(15, m=50, s=10)
y <- 2 + 0.2 *x1 + 0.2*x2 + stde * rnorm(15,m=0,s=1)
plot(y~x)
mod4 <- lm(y~x1 + x2)
summary(mod4)


library(rockchalk)
mcGraph3(x1, x2, y)
x1[16] <- mean(x1)
x2[16] <- 0
y[16] <- 30
mcGraph3(x1, x2, y)
mod3A <- lm (y~x1 +x2)
rstudent(mod3A)
dfbetasPlots(mod3A)

x1[16] <- mean(x1)
x2[16] <- 0
y[16] <- -10
mcGraph3(x1, x2, y)
mod3B <- lm (y~x1 +x2)
rstudent(mod3B)
dfbetasPlots(mod3B)


x1[16] <- mean(x1)
x2[16] <- mean(x2)
y[16] <- -20
mcGraph3(x1, x2, y)
mod3C <- lm (y~x1 +x2)
rstudent(mod3C)
dfbetasPlots(mod3C)




library(car)
Angell: Moral Integration In American Cities
modA <- lm (moral ~ hetero + mobility + region, data=Angell)

summary(influence.measures(modA))
plot(modA)
termplot(modA, partial.resid=T, se=T)

rstudent(modA)
drop1(modA, test="F")

library(lmSupport)

lm.sumSquares(modA)
