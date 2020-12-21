### R code from vignette source 'plot-1n.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: plot-1n.Rnw:87-89
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 2: Roptions
###################################################
options(width=180, prompt="> ", continue=" ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par(no.readonly = TRUE)
pjmar <- c(5.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)
ps.options(horizontal=F, onefile=F, family="Times", paper="special", height=3.5, width=5.25)
options(papersize="special")


###################################################
### code chunk number 3: plot-1n.Rnw:142-145
###################################################
set.seed(1234321)
x <- rnorm(5)
y <- rnorm(5)


###################################################
### code chunk number 4: plot-1n.Rnw:150-151 (eval = FALSE)
###################################################
## plot(mydata)


###################################################
### code chunk number 5: plot-1n.Rnw:155-156 (eval = FALSE)
###################################################
## plot(y ~ x, data = mydata)


###################################################
### code chunk number 6: plot-1n.Rnw:160-161 (eval = FALSE)
###################################################
## plot(mydata$x, mydata$y)


###################################################
### code chunk number 7: plot-1n.Rnw:165-166 (eval = FALSE)
###################################################
## with(mydata,  plot(x, y))


###################################################
### code chunk number 8: plot-1n.Rnw:179-180 (eval = FALSE)
###################################################
##   plot(y ~ x, data = mydata )


###################################################
### code chunk number 9: plot-1n.Rnw:197-198
###################################################
## plot( ...whatever..., type="n", axes = F)


###################################################
### code chunk number 10: plot-1n.Rnw:274-275 (eval = FALSE)
###################################################
## #     myObject <- SomeWonderfulFunction (X, myArgument = 7)


###################################################
### code chunk number 11: plot-1n.Rnw:279-280 (eval = FALSE)
###################################################
## #  class(myObject)


###################################################
### code chunk number 12: plot-1n.Rnw:284-285 (eval = FALSE)
###################################################
## #  plot(myObject)


###################################################
### code chunk number 13: plot-1n.Rnw:377-378 (eval = FALSE)
###################################################
## #  plot(myobject)


###################################################
### code chunk number 14: plot-1n.Rnw:383-384 (eval = FALSE)
###################################################
## #  plot.default(myobject)


###################################################
### code chunk number 15: den0
###################################################
myx <- rpois(1500,lambda=17)
den1 <- density(myx)
plot(den1)


###################################################
### code chunk number 16: den1
###################################################
plot(density(rpois(1500, lambda = 17)))


###################################################
### code chunk number 17: denplot02
###################################################
attributes(den1)


###################################################
### code chunk number 18: denplot03
###################################################
plot(den1$x,den1$y,type="l", xlab="x is Poisson(17)", ylab="density")
abline(h=0, col="gray50", lwd=0.6)


###################################################
### code chunk number 19: ex1
###################################################
age <- c( 14, 16, 19, 18, 21, 17, 15, 15)
sex <- c( "M","M","M","M","F","F","F","F")
salary <- c(8.00, 7.55, 20, 9.00, 26.00, 7.55, 5.00, 13.00)
mydf <- data.frame( age, sex, salary)
rm(age, sex, salary) ## clean up workspace
write.table(mydf, file = "examples/mydf.txt", sep = ",", row.names = FALSE)


###################################################
### code chunk number 20: plot-1n.Rnw:583-584 (eval = FALSE)
###################################################
## mydf <- read.table("examples/mydf.txt", sep = ",", header = TRUE)


###################################################
### code chunk number 21: plot-1n.Rnw:587-597 (eval = FALSE)
###################################################
## plot(salary ~ age, data = mydf)
## plot(salary ~ age, data = mydf, cex = 2)
## plot(salary ~ age, data = mydf, col = "pink", cex = 2, pch = 16)
## plot(salary ~ age, data = mydf, col = as.numeric(sex), cex = salary, pch = 16)
## plot(salary ~ age, data = mydf, type = "l")
## plot(salary ~ age, data = mydf, type = "b")
## plot(salary ~ age, data = mydf, type = "h")
## plot(salary ~ age, data = mydf, type = "s")
## plot(salary ~ age, data = mydf, type = "c")
## text(salary ~ age, data = mydf, labels = 1:8)


###################################################
### code chunk number 22: ex2
###################################################
plot(salary ~ age , data = mydf)


###################################################
### code chunk number 23: ex3prepplot
###################################################
plot(salary~age , data=mydf, type="n", xlab="Age (years)", ylab="Hourly Wage (US)")


###################################################
### code chunk number 24: ex3
###################################################
plot(salary~age , data=mydf, type="n", xlab="Age (years)", ylab="Hourly Wage (US)")


###################################################
### code chunk number 25: ex44prep
###################################################
with(mydf, points(age, salary, pch=6, cex=0.8))


###################################################
### code chunk number 26: ex44
###################################################
plot(salary~age , data=mydf, type="n", xlab="Age (years)", ylab="Hourly Wage (US)")
with(mydf, points(age, salary, pch=6, cex=0.8))


###################################################
### code chunk number 27: ex4prepplot
###################################################
##with(mydf, text(age, salary, labels = mydf$sex)) ## same as:
text(salary ~ age, data = mydf, labels = mydf$sex)


###################################################
### code chunk number 28: ex4
###################################################
plot(salary~age , data=mydf, type="n", xlab="Age (years)", ylab="Hourly Wage (US)")
##with(mydf, text(age, salary, labels = mydf$sex)) ## same as:
text(salary ~ age, data = mydf, labels = mydf$sex)


###################################################
### code chunk number 29: ex90names
###################################################
mydf$subjects <- c("Pat","Chris","Kris","Stacey","Leslie","Jaime","Terry","Mickey")


###################################################
### code chunk number 30: ex90plotnames
###################################################
myColors <- ifelse(mydf$sex == "M", "green", "red")  ##alternating red and green
# with(mydf,  text( age, salary, labels = subjects, col = myColors))
text(salary ~ age, data = mydf, labels = subjects, col = myColors)


###################################################
### code chunk number 31: ex90points
###################################################
## with(mydf, points(age, salary, pch = 4, cex=2)) ##same as:
points(salary ~ age, data = mydf, pch = 4, cex = 2)


###################################################
### code chunk number 32: ex90
###################################################
plot(salary~age , data=mydf, type="n", xlab="Age (years)", ylab="Hourly Wage (US)")
myColors <- ifelse(mydf$sex == "M", "green", "red")  ##alternating red and green
# with(mydf,  text( age, salary, labels = subjects, col = myColors))
text(salary ~ age, data = mydf, labels = subjects, col = myColors)


###################################################
### code chunk number 33: ex92
###################################################
plot(salary~age , data=mydf, type="n", xlab="Age (years)", ylab="Hourly Wage (US)")
myColors <- ifelse(mydf$sex == "M", "green", "red")  ##alternating red and green
# with(mydf,  text( age, salary, labels = subjects, col = myColors))
text(salary ~ age, data = mydf, labels = subjects, col = myColors)
## with(mydf, points(age, salary, pch = 4, cex=2)) ##same as:
points(salary ~ age, data = mydf, pch = 4, cex = 2)


###################################################
### code chunk number 34: exnaked
###################################################
plot(salary~age , data=mydf, type="n", bty="n", axes=F, xlab="", ylab="")


###################################################
### code chunk number 35: exgetmeans
###################################################
ma <- round(mean(mydf$age), 2)
ms <- round(mean(mydf$salary), 2)


###################################################
### code chunk number 36: exmtext
###################################################
text( ma, ms, label=paste("I'm centered on (",ma,",",ms,"), the means of age and salary", sep=""))


###################################################
### code chunk number 37: outeredge
###################################################
box(which="outer", col="gray90", lty=1)


###################################################
### code chunk number 38: ex5
###################################################
plot(salary~age , data=mydf, type="n", bty="n", axes=F, xlab="", ylab="")
text( ma, ms, label=paste("I'm centered on (",ma,",",ms,"), the means of age and salary", sep=""))
box(which="outer", col="gray90", lty=1)


###################################################
### code chunk number 39: exmaxmin
###################################################
text(max(mydf$age), max(mydf$salary), "MAX", offset=0)
text(min(mydf$age), min(mydf$salary), "MIN", offset=0)


###################################################
### code chunk number 40: exbox
###################################################
box(which="plot", col="red",lty=2)
legend("topleft", legend=paste("The Plot Region:", "axes would lie on this edge"), lty=c(2),col=c("red"), bty="n")


###################################################
### code chunk number 41: ex6
###################################################
plot(salary~age , data=mydf, type="n", bty="n", axes=F, xlab="", ylab="")
text(max(mydf$age), max(mydf$salary), "MAX", offset=0)
text(min(mydf$age), min(mydf$salary), "MIN", offset=0)
box(which="plot", col="red",lty=2)
legend("topleft", legend=paste("The Plot Region:", "axes would lie on this edge"), lty=c(2),col=c("red"), bty="n")
box(which="outer", col="gray90", lty=1)


###################################################
### code chunk number 42: puser
###################################################
(pu <- par("usr"))
text(pu[1], pu[4], label = paste("TL"), cex = 3)
text(pu[2], pu[3], label = paste("BR"), cex = 3)


###################################################
### code chunk number 43: ex6b
###################################################
plot(salary~age , data=mydf, type="n", bty="n", axes=F, xlab="", ylab="")
box(which="plot", col="red",lty=2)
legend("topleft", legend=paste("The Plot Region:", "axes would lie on this edge"), lty=c(2),col=c("red"), bty="n")
box(which="outer", col="gray90", lty=1)
(pu <- par("usr"))
text(pu[1], pu[4], label = paste("TL"), cex = 3)
text(pu[2], pu[3], label = paste("BR"), cex = 3)


###################################################
### code chunk number 44: ex6c
###################################################
par(xpd = TRUE)
plot(salary~age , data=mydf, type="n", bty="n", axes=F, xlab="", ylab="")
box(which="plot", col="red",lty=2)
legend("topleft", legend=paste("The Plot Region:", "axes would lie on this edge"), lty=c(2),col=c("red"), bty="n")
box(which="outer", col="gray90", lty=1)
(pu <- par("usr"))
text(pu[1], pu[4], label = paste("TL"), cex = 3)
text(pu[2], pu[3], label = paste("BR"), cex = 3)


###################################################
### code chunk number 45: exmean
###################################################
ma <- round(mean(mydf$age), 2)
ms <- round(mean(mydf$salary), 2)
points(ma, ms, pch=18)


###################################################
### code chunk number 46: exarrow
###################################################
arrows(1.01*ma, 1.01*ms, 1.03*ma, 1.03*ms, code=1, length=0.1)


###################################################
### code chunk number 47: exarrowtext
###################################################
text(1.03*ma, 1.03*ms, pos=4, label="The means")


###################################################
### code chunk number 48: ex8
###################################################
plot(salary~age , data=mydf, type="n", bty="n", axes=F, xlab="", ylab="")
text(max(mydf$age), max(mydf$salary), "MAX", offset=0)
text(min(mydf$age), min(mydf$salary), "MIN", offset=0)
ma <- round(mean(mydf$age), 2)
ms <- round(mean(mydf$salary), 2)
points(ma, ms, pch=18)
box(which="plot", col="red",lty=2)
legend("topleft", legend=paste("The Plot Region:", "axes would lie on this edge"), lty=c(2),col=c("red"), bty="n")
arrows(1.01*ma, 1.01*ms, 1.03*ma, 1.03*ms, code=1, length=0.1)
text(1.03*ma, 1.03*ms, pos=4, label="The means")


###################################################
### code chunk number 49: ex84pre
###################################################
plot(salary~age , data=mydf, type="n", bty="n", axes=F, xlab="", ylab="")
axis(1); mtext("Age (years)", side = 1, line = 3)
axis(2); mtext("Hourly Wage (US)", side = 2, line = 3)
box()
with(mydf, points(age, salary, pch=1, cex=1))


###################################################
### code chunk number 50: ex84
###################################################
plot(salary~age , data=mydf, type="n", bty="n", axes=F, xlab="", ylab="")
axis(1); mtext("Age (years)", side = 1, line = 3)
axis(2); mtext("Hourly Wage (US)", side = 2, line = 3)
box()
with(mydf, points(age, salary, pch=1, cex=1))


###################################################
### code chunk number 51: ex84
###################################################
plot(salary~age , data=mydf, type="n", bty="n", axes=F, xlab="", ylab="")
axis(1)
mtext("Age (years)", side = 1, line = 3)
axis(2)
mtext("Hourly Wage (US)", side = 2, line = 3)
box()
with(mydf, points( age, salary, pch = 1, cex = 1))


###################################################
### code chunk number 52: createnorm
###################################################
set.seed(1234321)
myx <- rnorm(1000, mean=50, sd=20)


###################################################
### code chunk number 53: plot-1n.Rnw:976-985 (eval = FALSE)
###################################################
## rockchalk::summarize(myx) ## or summary(myx)
## hist(myx)
## dev.new(height=3, width=8) ## fiddle values
## hist(myx)
## hist(myx, breaks = seq(min(myx), max(myx), length = 5))
## hist(myx, breaks = c(min(myx), 0, 40, 50, max(myx)))
## hist(myx, xlim = c(-200, 200))
## hist(myx, xlim = c(-200, 200), ylim = c(0, 350))
## text(-200, 300, pos = 4, labels = c("If you typed all this \nin I think you are the \nmost dedicated and well \nadjusted person who ever \ntook my course"))


###################################################
### code chunk number 54: mstd
###################################################
myxm <- mean(myx)
myxsd <- sd(myx)


###################################################
### code chunk number 55: hist2
###################################################
hist(myx)


###################################################
### code chunk number 56: hist3
###################################################
hist(myx , prob=T)


###################################################
### code chunk number 57: hist4
###################################################
hist(myx , breaks=30, prob=T)


###################################################
### code chunk number 58: histfinal
###################################################
hist(myx , breaks=30, prob=T, xlab="Perfect Scale", ylab="Density", main="The Great Histogram")


###################################################
### code chunk number 59: hist6
###################################################
hist(myx , breaks=30, prob=T, xlab="Perfect Scale", ylab="Density", main="The Great Histogram")
text(80, 0.02, label=paste("Mean = ", myxm))


###################################################
### code chunk number 60: textfinal
###################################################
text(80, 0.020, label=paste("Mean = ", round(myxm,2)))
text(82, 0.018, label=paste("Std. Dev. = ", round(myxsd,2)))


###################################################
### code chunk number 61: plot-1n.Rnw:1124-1126 (eval = FALSE)
###################################################
## myxm <- round(myxm, 2)
## myxsd <- round(myxsd, 2)


###################################################
### code chunk number 62: hist8
###################################################
hist(myx , breaks=30, prob=T, xlab="Perfect Scale", ylab="Density", main="The Great Histogram")
text(80, 0.020, label=paste("Mean = ", round(myxm,2)))
text(82, 0.018, label=paste("Std. Dev. = ", round(myxsd,2)))


###################################################
### code chunk number 63: densityline
###################################################
denx <- density(myx)
lines(denx, lty=2, col="red")


###################################################
### code chunk number 64: pdfline
###################################################
rangx <- range(myx)
testseq <- seq(rangx[1], rangx[2], by=1)
pdfseq <- dnorm(testseq, mean=50, sd=20)
lines(testseq, pdfseq)


###################################################
### code chunk number 65: histlegend
###################################################
legend("topleft", legend = c("Theoretical density", "Observed density"), lty = c(1,2), col = c("black","red"))


###################################################
### code chunk number 66: hist10
###################################################
hist(myx , breaks=30, prob=T, xlab="Perfect Scale", ylab="Density", main="The Great Histogram")
text(80, 0.020, label=paste("Mean = ", round(myxm,2)))
text(82, 0.018, label=paste("Std. Dev. = ", round(myxsd,2)))
denx <- density(myx)
lines(denx, lty=2, col="red")
rangx <- range(myx)
testseq <- seq(rangx[1], rangx[2], by=1)
pdfseq <- dnorm(testseq, mean=50, sd=20)
lines(testseq, pdfseq)
legend("topleft", legend = c("Theoretical density", "Observed density"), lty = c(1,2), col = c("black","red"))


###################################################
### code chunk number 67: hist11
###################################################
denx <- density(myx)
lines(denx, lty=2, col="red")


###################################################
### code chunk number 68: hist12
###################################################
rangx <- range(myx)
testseq <- seq(rangx[1], rangx[2], by=1)
pdfseq <- dnorm(testseq, mean=50, sd=20)
lines(testseq, pdfseq)


###################################################
### code chunk number 69: hist13
###################################################
legend("topleft", legend = c("Theoretical density", "Observed density"), lty = c(1,2), col = c("black","red"))


###################################################
### code chunk number 70: getGSS2006
###################################################
##library(foreign)
##dat <- read.spss("gss-pspp.sav", to.data.frame=T)

##dat <- subset (dat, select=c(hrs1, wrkslf, wrkgovt, marital, sex, race, educ, padeg, partyid , age, polint, news, newsfrom, income06, coninc, conrinc, realinc, gunlaw, owngun, vote00, pres00,  vote04, pres04, sexfreq, polviews, sei, mhgvthlt, mhgvthme, lessreg, numwomen, nummen, sexsex5, evstray ))

##save(dat, file="examples/gss-subset.RData")
load("examples/gss-subset.RData")


###################################################
### code chunk number 71: bar01
###################################################
t1 <- with(dat, table(pres04, partyid))
t1


###################################################
### code chunk number 72: bar02
###################################################
barplot(t1)


###################################################
### code chunk number 73: bar021
###################################################
  levels(dat$partyid)


###################################################
### code chunk number 74: bar03
###################################################
plev <- levels(dat$partyid)
dat$partyid[dat$partyid %in% plev[8]] <- NA
dat$partyid <- factor(dat$partyid)
levels(dat$partyid) <- c("Strong Dem.", "Dem.", "Ind. Near Dem.", "Independent", "Ind. Near Repub.", "Repub.", "Strong Repub.")


###################################################
### code chunk number 75: bar041
###################################################
levels(dat$pres04)


###################################################
### code chunk number 76: bar042
###################################################
preslev <- levels(dat$pres04)
dat$pres04[dat$pres04 %in% preslev[3:10]]<- NA
dat$pres04 <- factor(dat$pres04)
levels(dat$pres04) <- c("Kerry", "Bush")


###################################################
### code chunk number 77: bar05
###################################################
oldtable <- with(dat, table(pres04, partyid))
t1 <- prop.table(oldtable,2)
t1


###################################################
### code chunk number 78: bar06
###################################################
barplot(t1, beside=T)


###################################################
### code chunk number 79: bar07
###################################################
barplot(t1, beside=T, ylim=c(0,1), ylab="Proportion")


###################################################
### code chunk number 80: bar08
###################################################
barplot(t1,beside=T, las=2, ylim=c(0,1), ylab="Proportion")


###################################################
### code chunk number 81: margins01
###################################################
GenericFigure <- function(ID, size1, size2){
  plot(0:10, 0:10, type="n", xlab="X", ylab="Y")
  text(5,5, ID, col="red", cex=size1)
  box("plot", col="red")
  mtext("Figure",
        SOUTH<-1, line=3, adj=1.0, cex=size2,   col="blue")
}


###################################################
### code chunk number 82: margins02A
###################################################
# Figure 2A.  R Plot Area / Figure Area with Outer Margin Area present
par(mar=c(5.1,4.1,4.1,2.1))
Figure2A <- function(){
  par(oma=c(2,2,2,2))
  GenericFigure("Plot Area", 3,2)

  Margins <- capture.output( par()$mar )
  Margins <- substr(Margins, 5, nchar(Margins))
  Margins <-
       paste("mar = c(", gsub(" ",",",Margins), ")", sep="")
  mtext(Margins,
        NORTH<-3, line=2, adj=0.0, cex=1.5, col="blue")

  # "figure" box and "inner" margin box same for single figure plot
  box("figure",lty="dashed", col="blue")
  box("inner", lty="dotted", col="green")

  mtext("Outer Margin Area",
        SOUTH<-1, line=0.4, adj=1.0, cex=1.5, col="green", outer=TRUE)
  box("outer", lty="solid", col="green")

  OuterMargins <- capture.output( par()$oma )
  OuterMargins <- substr(OuterMargins, 5, nchar(OuterMargins))
  OuterMargins <-
       paste("oma = c(", gsub(" ",",",OuterMargins), ")", sep="")
  mtext(OuterMargins,
        NORTH<-3, line=0.4, adj=0.0, cex=1.5, col="green", outer=TRUE)
}
Figure2A()


###################################################
### code chunk number 83: plot-1n.Rnw:1486-1487
###################################################
options(SweaveHooks=list(fig=function() par(mar=pjmar)))


###################################################
### code chunk number 84: bar10pre
###################################################
par(mar=c(7.1, 4.1, 2, 2.1))
barplot(t1,beside=T, las=2, ylim=c(0,1))


###################################################
### code chunk number 85: bar10
###################################################
par(mar=c(7.1, 4.1, 2, 2.1))
barplot(t1,beside=T, las=2, ylim=c(0,1))


###################################################
### code chunk number 86: bar10post
###################################################
par(mar=pjmar)


###################################################
### code chunk number 87: bar11pre
###################################################
abline(h=seq(0.1, 0.9, by=0.10), lty=3,  lwd=0.2)


###################################################
### code chunk number 88: bar11
###################################################
par(mar=c(7.1, 4.1, 2, 2.1))
barplot(t1,beside=T, las=2, ylim=c(0,1))
abline(h=seq(0.1, 0.9, by=0.10), lty=3,  lwd=0.2)


###################################################
### code chunk number 89: bar12pre
###################################################
legend("top", legend=c("J.Kerry","G.W.Bush"), fill=gray.colors(2),bg="white")


###################################################
### code chunk number 90: bar12
###################################################
par(mar=c(7.1, 4.1, 2, 2.1))
barplot(t1,beside=T, las=2, ylim=c(0,1))
abline(h=seq(0.1, 0.9, by=0.10), lty=3,  lwd=0.2)
legend("top", legend=c("J.Kerry","G.W.Bush"), fill=gray.colors(2),bg="white")


###################################################
### code chunk number 91: bar70pre
###################################################
par(mar=c(7.1, 4.1, 2, 2.1))
par(xpd=T) ##write outside plot region
bp1 <- barplot(t1,beside=T, las=2, ylim=c(0,1))


###################################################
### code chunk number 92: bar71
###################################################
par(mar=c(7.1, 4.1, 2, 2.1))
par(xpd=T) ##write outside plot region
bp1 <- barplot(t1,beside=T, las=2, ylim=c(0,1))
abline(h=seq(0.1, 0.9, by=0.10), lty=3,  lwd=0.2)
legend("top", legend=c("J.Kerry","G.W.Bush"), fill=gray.colors(2),bg="white")
bp1
text(bp1,t1,label=round(t1,2), pos=1,cex=0.7,col=rbind(rep("white",7),rep("black",7)))



###################################################
### code chunk number 93: bar72
###################################################
par(mar=c(7.1, 4.1, 2, 2.1))
par(xpd=T) ##write outside plot region
bp1 <- barplot(t1,beside=T, las=2, ylim=c(0,1))
abline(h=seq(0.1, 0.9, by=0.10), lty=3,  lwd=0.2)
legend("top", legend=c("J.Kerry","G.W.Bush"), fill=gray.colors(2),bg="white")
bp1
text(bp1,t1,label=round(t1,2), pos=1,cex=0.7,col=rbind(rep("white",7),rep("black",7)))



###################################################
### code chunk number 94: bar70pre
###################################################
par(mar=c(7.1, 4.1, 2, 2.1))
bp1 <- barplot(t1,beside=T, las=2, ylim=c(0,1))


###################################################
### code chunk number 95: bar72pre
###################################################
par(xpd=TRUE)
text(bp1,t1,label=round(t1,2), pos=3,cex=0.7,col="black")


###################################################
### code chunk number 96: bar72
###################################################
par(mar=c(7.1, 4.1, 2, 2.1))
bp1 <- barplot(t1,beside=T, las=2, ylim=c(0,1))
abline(h=seq(0.1, 0.9, by=0.10), lty=3,  lwd=0.2)
legend("top", legend=c("J.Kerry","G.W.Bush"), fill=gray.colors(2),bg="white")


###################################################
### code chunk number 97: bar73
###################################################
par(mar=c(7.1, 4.1, 2, 2.1))
bp1 <- barplot(t1,beside=T, las=2, ylim=c(0,1))
abline(h=seq(0.1, 0.9, by=0.10), lty=3,  lwd=0.2)
legend("top", legend=c("J.Kerry","G.W.Bush"), fill=gray.colors(2),bg="white")
par(xpd=TRUE)
text(bp1,t1,label=round(t1,2), pos=3,cex=0.7,col="black")


