## Example code from lmtest package dwtest
library(lmtest)


## generate two AR(1) error terms with parameter
## rho = 0 (white noise) and rho = 0.9 respectively
err1 <- rnorm(100)

## generate regressor and dependent variable
beta0 <- 1
beta1 <- 1
STDE <- 1
dat <- data.frame(x = rep(c(-1,1), 50))
dat$y1 <- beta0 + beta1 * dat$x + STDE * err1

m1 <- lm(y1 ~ x, data = dat)
summary(m1)

## perform Durbin-Watson test
with(dat, dwtest(y1 ~ x))

## creates an AR with rho = 0.9
err2 <- filter(err1, 0.3, method="recursive")
dat$y2 <- 1 + dat$x + err2

m2 <- lm(y2 ~ x, data = dat)
summary(m2)

with(dat, dwtest(y2 ~ x))

plot(y2 ~ x, dat)

dat$id <- gl(50, 2)
m3 <- lm(y2 ~ x * id, data = dat)
summary(m3)
library(rockchalk)
plotSlopes(m3, plotx = "x", modx = "id", plotLegend=FALSE)

library(lme4)
m3.mixed <- lmer(y2 ~ x + (1|id), dat)
summary(m3.mixed)

nd <- newdata(m3.mixed, predVals = list(x = c(-1, 1), id = levels(dat$id)))
m3.mixed.pred <- predict(m3.mixed, newdata = nd)
nd <- cbind(nd, "fit" = m3.mixed.pred)

rockchalk:::plotFancy(nd, data.frame(modxVar = dat$id,
                                     plotxVar = dat$x, depVar = dat$y2),
                      plotx = "x", modx = "id",
                      modxVals = levels(dat$id),
                      interval = "none", xlim = c(-1, 1),
                      ylim = c(-10, 20),
                      opacity = 100,
                      plotPoints = TRUE, plotLegend = FALSE)



library(foreign)
write.dta(dat, file = "dwtest-20181129.dta")


library(orcutt)

co2 <- cochrane.orcutt(m2)
summary(co2)
summary(m2)

