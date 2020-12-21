### R code from vignette source 'functions-1n.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: functions-1n.Rnw:104-105
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
### code chunk number 14: functions-1n.Rnw:665-666
###################################################
predict.glm


###################################################
### code chunk number 15: functions-1n.Rnw:712-714 (eval = FALSE)
###################################################
## set.seed(234234)
## x1 <- rnorm(10000, m = 7, sd = 19)


###################################################
### code chunk number 16: functions-1n.Rnw:721-723 (eval = FALSE)
###################################################
## x1mean <- myGreatFunction(x1)
## x1mean


###################################################
### code chunk number 17: functions-1n.Rnw:727-729 (eval = FALSE)
###################################################
## x1[c(13, 44, 99, 343, 555)]  <- NA
## myGreatFunction(x1)


###################################################
### code chunk number 18: entropy10
###################################################
divr <- function(p = 0){
  ifelse ( p > 0 & p < 1, -p * log2(p), 0)
}


###################################################
### code chunk number 19: entropy20
###################################################
  pseq <- seq(0.001, 0.999, length=999)
  pseq.divr <- divr(pseq)
  plot(pseq.divr ~ pseq, xlab = "p", ylab = "Diversity Contribution of One Observation",  main = expression(paste("Diversity: ", -p %*% log[2](p))), type = "l")


###################################################
### code chunk number 20: entropy40
###################################################
entropy <- function(p){
    sum( divr(p) )
}


###################################################
### code chunk number 21: entropy41
###################################################
entropy( c(1/5, 1/5, 1/5, 1/5, 1/5) )

entropy( c(3/5, 1/5, 1/5, 0/5, 0/5) )


###################################################
### code chunk number 22: entropy50
###################################################
entropy(rep(1/8, 8))


###################################################
### code chunk number 23: entropy51
###################################################
entropy(rep(1/14, 14))


###################################################
### code chunk number 24: entropy59
###################################################
maximumEntropy <- function(N) - log2(1/N)
Nmax <- 15
M <- 2:Nmax
plot(M, maximumEntropy(M), xlab = "N of Possible Types", ylab = "Maximum Possible Diversity",  main = "Maximum Possible Entropy For N Categories", type = "h", axes = FALSE)
axis(1)
axis(2)
points(M, maximumEntropy(M), pch=19)


###################################################
### code chunk number 25: entropy60
###################################################
normedEntropy <- function(x) entropy(x)/ maximumEntropy(length(x))


###################################################
### code chunk number 26: entropy61
###################################################
normedEntropy(c(1/4,1/4,1/4,1/4))

normedEntropy(c(1/2, 1/2, 0, 0))

normedEntropy(c(1, 0, 0, 0))


###################################################
### code chunk number 27: entropy62
###################################################

normedEntropy(rep(1/7, 7))

normedEntropy((1:7)/(sum(1:7)))

normedEntropy(c(2/7, 2/7, 3/7, 0, 0, 0, 0))

normedEntropy(c(5/7, 2/7, 0, 0, 0, 0, 0))



###################################################
### code chunk number 28: entropy90
###################################################
### Save par values so we can put them back later
saveParVals <- par(no.readonly=T)

par(mfcol=c(1,3), xpd=T)

testcase1 <- c( 1/10, 1/10, 1/10, 1/10, 2/10, 2/10, 2/10, 0/10, 0/10, 0/10)
testcase2 <- c( 1/5, 2/5, 2/5, 0, 0)
testcase3 <- (1:7)/sum(1:7)

et1 <- round(normedEntropy(testcase1),2)
et2 <- round(normedEntropy(testcase2),2)
et3 <- round(normedEntropy(testcase3),2)


bp1 <- barplot( testcase1, names.arg=1:(length(testcase1)), density=12, ylim=c(0,0.5))

legend("topright", legend=paste("Normed Entropy=", et1) )

### Can slip xpd=T into text command, instead of running par(xpd=T)
text(bp1, testcase1, testcase1, pos=3,  cex=0.7, xpd=T)

bp2 <- barplot( testcase2, names.arg= 1:(length(testcase2)), density=12, ylim=c(0,0.5))

legend("topleft", legend=paste("Normed Entropy=", et2 ))

text(bp2, testcase2, testcase2, pos=3, cex=0.7, xpd=T)

bp3 <- barplot( testcase3, names.arg= 1:(length(testcase3)), density=12, ylim=c(0,0.5))

legend("topleft", legend=paste("Normed Entropy=", et3) )

text(bp3, testcase3, round(testcase3,2), pos=3, cex=0.7, xpd=T, las=2)

### Restore par values to default
par(saveParVals)


###################################################
### code chunk number 29: functions-1n.Rnw:1010-1011
###################################################
round(testcase3,2)


###################################################
### code chunk number 30: functions-1n.Rnw:1013-1018
###################################################
library(rockchalk)
testcase3v <- factor(c(1,2,2,3,3,3, 4,4,4,4, 5,5,5,5,5, 6,6,6,6,6,6, 7,7,7,7,7,7,7 ))
round((table(testcase3v)/length(testcase3v)), 2)
dat <- data.frame(testcase3v)
summarizeFactors(dat)


###################################################
### code chunk number 31: doubleMe80a
###################################################
newthing <- doubleMe(32)
newthing
is.numeric(newthing)
is.vector(newthing)


###################################################
### code chunk number 32: doubleMe80b
###################################################
newthing <- doubleMe(c(1,2,3,4,5))
newthing
is.numeric(newthing)
is.vector(newthing)


###################################################
### code chunk number 33: functions-1n.Rnw:1367-1368 (eval = FALSE)
###################################################
## x1 <- rnorm(10000, m=7, sd=19)


###################################################
### code chunk number 34: functions-1n.Rnw:1371-1372 (eval = FALSE)
###################################################
## myGreatFunction(x1)


###################################################
### code chunk number 35: functions-1n.Rnw:1376-1378 (eval = FALSE)
###################################################
## x1[c(13, 44, 99, 343, 555)]  <- NA
## myGreatFunction(x1)


###################################################
### code chunk number 36: regex10 (eval = FALSE)
###################################################
## aRegMod <- function(xin1, xin2, yout){ lm(yout ~ xin1 + xin2) }


###################################################
### code chunk number 37: regex10b (eval = FALSE)
###################################################
## dat <- rockchalk::genCorrelatedData(N = 100, rho = 0.3, beta = c(1, 1.0, -1.1, 0.0))
## m1 <- with(dat, aRegMod(x1, x2, y))


###################################################
### code chunk number 38: lmcode
###################################################
lm


###################################################
### code chunk number 39: functions-1n.Rnw:2011-2049 (eval = FALSE)
###################################################
## 
## ##Create one MPlus Input file corresponding to following parameters.
## createInpFile <- function(path="apath", gen="afilename.inp", perclust=2, nclust=100, iter=1000, mod=1, strong=1, between=1, within=1){
##     cat("MONTECARLO:
##       NAMES ARE y1-y6;
##       NOBSERVATIONS = ", perclust*nclust, "; \n",
##         ifelse(perclust != 7.5 ,
##                paste("NCSIZES = 1; \n    CSIZES =", nclust, "(", perclust, ");\n"),
##                paste("  NCSIZES = 2; \n   CSIZES = ", nclust/2, " (7) ", nclust/2 , " (8); \n" ) ), file=gen,   append=T,
##         sep="")
## 
##   ##user-specified iterations
##     cat( "NREPS = ", iter, ";
##        SEED = 791305;
##        REPSAVE=ALL;
##        SAVE=", path, "\\data*.dat;
##        ANALYSIS: TYPE = TWOLEVEL;
##        MODEL POPULATION:
##        %WITHIN% \n", file=gen, append=T, sep="")
## 
##     ## baseline loadings are all .3, add .4 if "within" = 1, but change based on mod/strong
## 
##     cat("FW BY y1-y2*", .3+(within*(.4+strong*.1)),
##         "y3-y4*", .3+(within*(.4-mod*.3)),
##         "y5-y6*", .3+(within*(.4-strong*.1)),
##         "FW@1; \n",
##         "y1-y2*", 1-(.3+(within*(.4+strong*.1)))^2, "; \n",
##         "y3-y4*", 1-(.3+(within*(.4-mod*.3)))^2, "; \n",
##         "y5-y6*", 1-(.3+(within*(.4-strong*.1)))^2, "; \n",
##         " %BETWEEN% ",
##         "FB BY y1-y2*", sqrt((.3+(between*(.4+strong*.1)))^2*(1+(icc*(.053-1)))),
##         "y3-y4*", sqrt((.3+(between*(.4-mod*.3)))^2 *(1+(icc*(.053-1)))),
##         "y5-y6*", sqrt((.3+(between*(.4-strong*.1)))^2 *(1+(icc*(.053-1)))),"; FB@1;  \n",
##         "y1-y2*", 1+(icc*(.053-1))-sqrt((.3+(between*(.4+strong*.1)))^2*(1+(icc*(.053-1))))^2, ";",
##         "y3-y4*", 1+(icc*(.053-1))-sqrt((.3+(between*(.4-mod*.3)))^2 *(1+(icc*(.053-1))))^2, ";",
##        "y5-y6*", 1+(icc*(.053-1))-sqrt((.3+(between*(.4-strong*.1)))^2 *(1+(icc*(.053-1))))^2, ";",
##        "\n", file=gen, append=T, sep="")
## }


###################################################
### code chunk number 40: s410
###################################################
 setClass("pjfriend", representation(
 name="character",
 gender="factor",
 food="factor",
 age="integer"))


###################################################
### code chunk number 41: s420
###################################################
william <- new("pjfriend", name = "william", gender =
  factor("male"), food=factor("pizza"), age=33L)
william

jane <- new("pjfriend", name="pumpkin", gender = factor("female"), food=factor("hamburger"), age=21L)
jane


###################################################
### code chunk number 42: s450 (eval = FALSE)
###################################################
## setMethod("some-generic-function-name", "pjfriend",
##           function(x) {
##               #do something with x
##               }
## )


