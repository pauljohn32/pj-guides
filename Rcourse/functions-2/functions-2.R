### R code from vignette source '/home/pauljohn/SVN/SVN-guides/Rcourse/functions-2/functions-2n.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: functions-2n.Rnw:101-102
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 2: Roptions
###################################################
options(width=150, prompt="> ", continue=" ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par()
pjmar <- c(5.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)
ps.options(horizontal=F, onefile=F, family="Times", paper="special", height=3, width=4.75)
options(papersize="special")


###################################################
### code chunk number 3: functions-2n.Rnw:244-249 (eval = FALSE)
###################################################
## set.seed(234234)
## y <- rnorm(100)
## x <- rnorm(100)
## debug(lm)
## m1 <- lm( y ~ x )


###################################################
### code chunk number 4: def10
###################################################
myf <- function(z){
   log(z) + 2*x
}


###################################################
### code chunk number 5: def30
###################################################
x <- c(1,2,3)
myf(1)


###################################################
### code chunk number 6: def40
###################################################
library(codetools)
rm(x)
checkUsage(myf)


