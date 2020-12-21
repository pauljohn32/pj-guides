### R code from vignette source '/home/pauljohn/SVN/SVN-guides/Rcourse/functions-1/functions-1.1-intron.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: functions-1.1-intron.Rnw:104-105
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 2: Roptions
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
### code chunk number 3: doubleMe
###################################################
doubleMe <- function(input = 0){
  newval <- 2 * input
}


###################################################
### code chunk number 4: doubleMe04 (eval = FALSE)
###################################################
## doubleMe <- function(x){
##     out <- 2 * x
## }


###################################################
### code chunk number 5: callDoubleMe10
###################################################
(doubleMe(7))


###################################################
### code chunk number 6: callDoubleMe10b
###################################################
(doubleMe(input = 8))


###################################################
### code chunk number 7: callDoubleMe10c
###################################################
print(doubleMe(input = 3))


###################################################
### code chunk number 8: callDoubleMe10d
###################################################
x <- doubleMe(input = 2)
x


###################################################
### code chunk number 9: callDoubleMe40 (eval = FALSE)
###################################################
##     doubleMe(10)


###################################################
### code chunk number 10: callDoubleMe50 (eval = FALSE)
###################################################
## doubleMe(input = 10)


###################################################
### code chunk number 11: callDoubleMe60
###################################################
(doubleMe(c(1,2,3,4,5)))


###################################################
### code chunk number 12: callDoubleMe25 (eval = FALSE)
###################################################
## doubleMe()


###################################################
### code chunk number 13: callDoubleMe70
###################################################
doubleMe


###################################################
### code chunk number 14: functions-1.1-intron.Rnw:665-666
###################################################
predict.glm


###################################################
### code chunk number 15: functions-1.1-intron.Rnw:712-714 (eval = FALSE)
###################################################
## set.seed(234234)
## x1 <- rnorm(10000, m = 7, sd = 19)


###################################################
### code chunk number 16: functions-1.1-intron.Rnw:721-723 (eval = FALSE)
###################################################
## x1mean <- myGreatFunction(x1)
## x1mean


###################################################
### code chunk number 17: functions-1.1-intron.Rnw:727-729 (eval = FALSE)
###################################################
## x1[c(13, 44, 99, 343, 555)]  <- NA
## myGreatFunction(x1)


