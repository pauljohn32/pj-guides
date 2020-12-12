### R code from vignette source '/tmp/lyx_tmpdir.T17234/lyx_tmpbuf2/article-2.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: article-2.Rnw:24-25
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: article-2.Rnw:172-173
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
## Just for safe keeping, copy the par
op <- par() 
options(SweaveHooks=list(fig=function() par(ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: one
###################################################
set.seed(234234)
x <- rnorm(1000)
mean(x)
sd(x)


###################################################
### code chunk number 5: two
###################################################
hist(x, xlab = "A very well constructed variable", prob = TRUE, ylab = "These are proportions, not densities", breaks = 25)


###################################################
### code chunk number 6: three1
###################################################
dat <- data.frame(x1 = rnorm(1000), x2 = rnorm(1000))
b0 <- 0.5; b1 <- 0.7; b2 <- 0.15; se <- 10
dat$y <- b0 + b1*dat$x1 + b2*dat$x2 + se*rnorm(1000)
m0 <- lm(y ~ x1, data = dat)
m1 <- lm(y ~ x1 + x2, data = dat)
summary(m1)


###################################################
### code chunk number 7: three2
###################################################
require(rockchalk)
outreg(list("Model of Student Behavior" = m0, "A More Elaborate Model" = m1), varLabels = c("x1" = "Studying", "x2" = "Math Lessons"))


