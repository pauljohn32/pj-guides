### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM8292/lyx_tmpbuf2/ChiSquare.Rnw'

###################################################
### code chunk number 1: ChiSquare.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: ChiSquare.Rnw:92-94
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
options(SweaveHooks=list(fig=function() par(ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: Chi-Square1
###################################################
xvals <- seq(0,10,length.out=1000)
chisquare1 <- dchisq(xvals, df=1)
chisquare2 <- dchisq(xvals, df=6)
matplot(xvals, cbind(chisquare1, chisquare2), type="l", xlab="possible values of x", ylab="probability of x",  ylim=c(0,1), main="Chi-Square Probability Densities")
text(.4, .9, "df=1", pos=4, col=1)
text(4, .2, "df=6", pos=4, col=2)


###################################################
### code chunk number 5: ChiSquare.Rnw:229-230
###################################################
xvals <- seq(0,10,length.out=1000)
chisquare1 <- dchisq(xvals, df=1)
chisquare2 <- dchisq(xvals, df=6)
matplot(xvals, cbind(chisquare1, chisquare2), type="l", xlab="possible values of x", ylab="probability of x",  ylim=c(0,1), main="Chi-Square Probability Densities")
text(.4, .9, "df=1", pos=4, col=1)
text(4, .2, "df=6", pos=4, col=2)


###################################################
### code chunk number 6: Chi-Square2 (eval = FALSE)
###################################################
## xvals <- seq(0,22,length.out=1000)
## 
## chisquare1 <- dchisq(xvals, df=1)
## chisquare2 <- dchisq(xvals, df=6)
## chisquare3 <- dchisq(xvals, df=2)
## chisquare4 <- dchisq(xvals, df=3)
## chisquare5 <- dchisq(xvals, df=10)
## chisquare6 <- dchisq(xvals, df=15)
## 
## matplot(xvals, cbind(chisquare1, chisquare2, chisquare3, chisquare4, chisquare5, chisquare6), type="l", xlab="possible values of x", ylab="probability of x",  ylim=c(0,1), main="Chi-Square Probability Densities")
## text(.4, .9, "df=1", pos=4, col=1)
## text(4.2, .15, "df=6", pos=4, col=2)
## text(.44, .4, "df=2", pos=4, col=3)
## text(1.7, .23, "df=3", pos=4, col=4)
## text(10, .10, "df=10", pos=4, col=5)
## text(15, .08, "df=15", pos=4, col=6)


###################################################
### code chunk number 7: ChiSquare.Rnw:265-266
###################################################
xvals <- seq(0,22,length.out=1000)

chisquare1 <- dchisq(xvals, df=1)
chisquare2 <- dchisq(xvals, df=6)
chisquare3 <- dchisq(xvals, df=2)
chisquare4 <- dchisq(xvals, df=3)
chisquare5 <- dchisq(xvals, df=10)
chisquare6 <- dchisq(xvals, df=15)

matplot(xvals, cbind(chisquare1, chisquare2, chisquare3, chisquare4, chisquare5, chisquare6), type="l", xlab="possible values of x", ylab="probability of x",  ylim=c(0,1), main="Chi-Square Probability Densities")
text(.4, .9, "df=1", pos=4, col=1)
text(4.2, .15, "df=6", pos=4, col=2)
text(.44, .4, "df=2", pos=4, col=3)
text(1.7, .23, "df=3", pos=4, col=4)
text(10, .10, "df=10", pos=4, col=5)
text(15, .08, "df=15", pos=4, col=6)


