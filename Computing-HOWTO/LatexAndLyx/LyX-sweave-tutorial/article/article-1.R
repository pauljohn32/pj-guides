### R code from vignette source 'article-1.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: article-1.Rnw:18-19
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: one
###################################################
set.seed(234234)
x <- rnorm(1000)
mean(x)
sd(x)


###################################################
### code chunk number 3: two
###################################################
hist(x)


###################################################
### code chunk number 4: three
###################################################
dat <- data.frame(x1 = rnorm(1000), x2 = rnorm(1000))
b0 <- 0.5; b1 <- 0.7; b2 <- 0.15; se <- 10
dat$y <- b0 + b1*dat$x1 + b2*dat$x2 + se*rnorm(1000)
m0 <- lm(y ~ x1, data = dat)
m1 <- lm(y ~ x1 + x2, data = dat)
require(rockchalk)
outreg(list("Model of Student Behavior" = m0, "A More Elaborate Model" = m1), varLabels = c("x1" = "Studying", "x2" = "Math Lessons"))


