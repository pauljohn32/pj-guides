### R code from vignette source '/tmp/lyx_tmpdir.MT8528/lyx_tmpbuf3/Regression-2-lecture-problems.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Regression-2-lecture-problems.Rnw:29-30
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-2-lecture-problems.Rnw:81-82
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: prob1 (eval = FALSE)
###################################################
## library(datasets)
## library(help=datasets)
## ?Orange
## m1 <- lm( circumference ~ age, data = Orange)
## summary(m1)
## ?cars
## m2 <- lm(dist ~ speed, data=cars) 
## summary(m2)


###################################################
### code chunk number 5: prob3a (eval = FALSE)
###################################################
## stde <- 1
## dat <- data.frame(x=rpois(500, lambda=200))
## dat$y <- 3 + 0.08 * dat$x + stde * rnorm(500)
## m1 <- lm(y ~ x, data=dat); summary(m1)
## plot(y ~ x, data=dat); abline(m1)


###################################################
### code chunk number 6: prob3b (eval = FALSE)
###################################################
## stde <- 2
## dat$y2 <- 3 + 0.08 * dat$x + stde * rnorm(500)
## m2 <- lm(y2 ~ x, data=dat); summary(m2)
## plot(y2 ~ x, data=dat); abline(m2)


###################################################
### code chunk number 7: scat1
###################################################
x <- rnorm(200,m=30,s=5)
sigma <- 5
y <- -3 + 30*x -0.5*x*x + sigma*rnorm(200)
plot(x, y, main="", xlab="x", ylab="y")
mod1 <- lm(y~x)
#abline(mod1)


###################################################
### code chunk number 8: regmod1
###################################################
library(rockchalk)
outreg(mod1, tight=T)


