### R code from vignette source '/home/pauljohn/SVN/SVN-guides/Rcourse/functions-1/functions-1.2-entropyn.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: functions-1.2-entropyn.Rnw:97-98
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
### code chunk number 3: entropy10
###################################################
divr <- function(p = 0){
  ifelse ( p > 0 & p < 1, -p * log2(p), 0)
}


###################################################
### code chunk number 4: entropy20
###################################################
  pseq <- seq(0.001, 0.999, length=999)
  pseq.divr <- divr(pseq)
  plot(pseq.divr ~ pseq, xlab = "p", ylab = "Diversity Contribution of One Observation",  main = expression(paste("Diversity: ", -p %*% log[2](p))), type = "l")


###################################################
### code chunk number 5: entropy40
###################################################
entropy <- function(p){
    sum( divr(p) )
}


###################################################
### code chunk number 6: entropy41
###################################################
entropy( c(1/5, 1/5, 1/5, 1/5, 1/5) )

entropy( c(3/5, 1/5, 1/5, 0/5, 0/5) )


###################################################
### code chunk number 7: entropy50
###################################################
entropy(rep(1/8, 8))


###################################################
### code chunk number 8: entropy51
###################################################
entropy(rep(1/14, 14))


###################################################
### code chunk number 9: entropy59
###################################################
maximumEntropy <- function(N) - log2(1/N)
Nmax <- 15
M <- 2:Nmax
plot(M, maximumEntropy(M), xlab = "N of Possible Types", ylab = "Maximum Possible Diversity",  main = "Maximum Possible Entropy For N Categories", type = "h", axes = FALSE)
axis(1)
axis(2)
points(M, maximumEntropy(M), pch=19)


###################################################
### code chunk number 10: entropy60
###################################################
normedEntropy <- function(x) entropy(x)/ maximumEntropy(length(x))


###################################################
### code chunk number 11: entropy61
###################################################
normedEntropy(c(1/4,1/4,1/4,1/4))

normedEntropy(c(1/2, 1/2, 0, 0))

normedEntropy(c(1, 0, 0, 0))


###################################################
### code chunk number 12: entropy62
###################################################

normedEntropy(rep(1/7, 7))

normedEntropy((1:7)/(sum(1:7)))

normedEntropy(c(2/7, 2/7, 3/7, 0, 0, 0, 0))

normedEntropy(c(5/7, 2/7, 0, 0, 0, 0, 0))



###################################################
### code chunk number 13: entropy90
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
### code chunk number 14: functions-1.2-entropyn.Rnw:407-408
###################################################
round(testcase3,2)


###################################################
### code chunk number 15: functions-1.2-entropyn.Rnw:410-415
###################################################
library(rockchalk)
testcase3v <- factor(c(1,2,2,3,3,3, 4,4,4,4, 5,5,5,5,5, 6,6,6,6,6,6, 7,7,7,7,7,7,7 ))
round((table(testcase3v)/length(testcase3v)), 2)
dat <- data.frame(testcase3v)
summarizeFactors(dat)


