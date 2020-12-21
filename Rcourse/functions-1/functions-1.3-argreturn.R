### R code from vignette source '/home/pauljohn/SVN/SVN-guides/Rcourse/functions-1/functions-1.3-argreturnn.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: functions-1.3-argreturnn.Rnw:97-98
###################################################
source("functions-1.1-intro.R")


###################################################
### code chunk number 2: functions-1.3-argreturnn.Rnw:101-102
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=200, prompt="> ", continue=" ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par()
pjmar <- c(5.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)
ps.options(horizontal=F, onefile=F, family="Times", paper="special", height=3, width=4.75)
options(papersize="special")


###################################################
### code chunk number 4: formals1
###################################################
names(formals(hist.default))


###################################################
### code chunk number 5: formals2
###################################################
dput(names(formals(hist.default)))


###################################################
### code chunk number 6: doubleMe80a
###################################################
newthing <- doubleMe(32)
newthing
is.numeric(newthing)
is.vector(newthing)


###################################################
### code chunk number 7: doubleMe80b
###################################################
newthing <- doubleMe(c(1,2,3,4,5))
newthing
is.numeric(newthing)
is.vector(newthing)


###################################################
### code chunk number 8: attr1
###################################################
x <- c(1, 2, 3, 4, 6)
y <- c(44, 12, 44, 22, 4)
attributes(x)
attr(x, "hi") <- paste("Oh, my hearty friend, I greet  you warmly", rnorm(6))
attr(x, "areg") <- lm(y ~ x)
attributes(x)
summary(attr(x, "areg"))


###################################################
### code chunk number 9: regex10 (eval = FALSE)
###################################################
## aRegMod <- function(xin1, xin2, yout){ lm(yout ~ xin1 + xin2) }


###################################################
### code chunk number 10: regex10b (eval = FALSE)
###################################################
## dat <- rockchalk::genCorrelatedData(N = 100, rho = 0.3, beta = c(1, 1.0, -1.1, 0.0))
## m1 <- with(dat, aRegMod(x1, x2, y))


