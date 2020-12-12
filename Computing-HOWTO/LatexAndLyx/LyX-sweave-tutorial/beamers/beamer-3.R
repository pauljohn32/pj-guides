### R code from vignette source 'beamer-3.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: beamer-3.Rnw:28-29
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Rfirst
###################################################
dir.create("plots", showWarnings=F)
options(width=160, prompt=" ", continue="  ")


###################################################
### code chunk number 3: Roptions
###################################################
## Other settings I like
options(device = pdf)
options(useFancyQuotes = FALSE) 
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: beamer-3.Rnw:298-313
###################################################
set.seed(234234)
x1 <- rnorm(1000)
mean(x1)
sd(x1)
se <- 1.5
b0 <- 0.7
b1 <- 0.04
y <- b0 + b1 * x1 + se * rnorm(1000)
dat <- data.frame(x1, y)
m1 <- lm(y ~ x1, data = dat)
summary(m1)
dat$x2 <- rpois(1000, lambda = 2)
m2 <- lm(y ~ x1 + x2, data = dat)
summary(m2)
anova(m2, m1, test = "F")


###################################################
### code chunk number 5: beamer-3.Rnw:323-325
###################################################
library(rockchalk)
plotSlopes(m2, plotx = x1, modx = x2, interval = "confidence")


###################################################
### code chunk number 6: ps50
###################################################
plotSlopes(m2, plotx = x1, modx = x2, predVals="std.dev.", interval = "confidence")


###################################################
### code chunk number 7: ps60
###################################################
plotSlopes(m2, plotx = x2, modx = x1, predVals="std.dev.", interval = "confidence")


