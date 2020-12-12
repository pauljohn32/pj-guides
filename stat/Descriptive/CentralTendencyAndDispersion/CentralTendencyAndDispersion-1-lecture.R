### R code from vignette source 'CentralTendencyAndDispersion-1-lecture-uniquebackupstring202009071501.Rnw'

###################################################
### code chunk number 1: CentralTendencyAndDispersion-1-lecture-uniquebackupstring202009071501.Rnw:25-26
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: ignoremeRoptions
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)
library(stationery)
opts.orig <- options()
options(width=70, prompt="> ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly = TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 3: texcopy
###################################################
logos <- c("logo.pdf", "logomini.pdf")
## This will retrieve logo files from a designated package:
## try(getFiles(logos, pkg = "stationery", overwrite = FALSE))
## If you do not have a file after that, 
## the following will manufacture a blank images for placeholders
if(!file.exists("theme/logo.pdf")){
  blankPDF(file = "theme/logo.pdf", height=1, width=2, messg = "")
}
if(!file.exists("theme/logomini.pdf")){
  blankPDF(file = "theme/logomini.pdf", height=1, width=11, messg = "")
}


###################################################
### code chunk number 4: logx
###################################################
x <- seq(0.25, 6.0, by=0.1)
y <- log(x)
plot(y ~ x, xlim=c(0, 6), type = "l", main=expression(paste(y[i]," is the log of ", x[i])), xlab=expression(x[i]), ylab=expression(y[i]))
abline(h=c(-1.0, -0.5, 0, 0.5, 1.0, 1.5), col="gray", lty=2)
abline(v=c(0.5, 1, 4, 4.5))			


###################################################
### code chunk number 5: c1
###################################################
x1 <- rnorm (20, mean=14, sd=5)
x2 <- rnorm (20, mean=84, sd=5)
par(mfcol=c(2,1))
hist(x1, prob=T, xlab="x", ylab="density", main="Lots of Low Scores", xlim=c(0,100))
hist(x2, prob=T, xlab="x", ylab="density", main="Lots of Big Scores", xlim=c(0,100))
par(mfcol=c(1,1))


###################################################
### code chunk number 6: c2
###################################################
x1 <- rnorm (20, mean=40, sd=2)
x2 <- rnorm (20, mean=40, sd=15)
par(mfcol=c(2,1))
hist(x1, prob=T, xlab="x", ylab="density", main="These are clumped together", xlim=c(0,100))
hist(x2, prob=T, xlab="x", ylab="density", main="These are spread out", xlim=c(0,100))
par(mfcol=c(1,1))


###################################################
### code chunk number 7: c10
###################################################
age <- rgamma(300, scale = 5, shape = 5)
age <- c(age, rep(999, 30))
hist(age, prob=T, xlab="age", ylab="density", main="Age data")


###################################################
### code chunk number 8: c11
###################################################
age <- age[age < 300]
hist(age, prob=T, xlab="age", ylab="density", main="Age data", xlim=c(0,100))


###################################################
### code chunk number 9: gss05
###################################################
load("../../DataSets/GSS/gss-subset2.Rda")
par(xpd=T)
mnummen <- round(mean(dat$nummen, na.rm=T),3) 
sdnummen <- round(sd(dat$nummen, na.rm=T),3) 
mednummen <- round(median(dat$nummen, na.rm=T),3) 
cvnummen <- round(sdnummen/mnummen,3)
h1 <- hist(dat$nummen, breaks=100, prob = T, main = "Male Sexual Partners (nummen)", xlab = "Number of Male Sexual Partners", ylim=c(0,0.7)) 
text(max(h1$mids), 0.5, pos=2, label=paste("Mean=", mnummen,"\nStd.Dev=", sdnummen,"\nMedian=", mednummen,"\nC.V.=", cvnummen))  


###################################################
### code chunk number 10: gss10
###################################################
par(xpd=T)
dat$nummen[dat$nummen > 99] <- NA
mnummen <- round(mean(dat$nummen, na.rm=T),3) 
sdnummen <- round(sd(dat$nummen, na.rm=T),3) 
mednummen <- round(median(dat$nummen, na.rm=T),3) 
cvnummen <- round(sdnummen/mnummen,3)
h1 <- hist(dat$nummen, breaks=100, prob=T, main="Male Sexual Partners (nummen)", xlab="Number of Male Sexual Partners", ylim=c(0,0.7)) 
text(max(h1$mids), max(h1$density)-.2, pos=2, label=paste("Mean=", mnummen,"\nStd.Dev=", sdnummen,"\nMedian=", mednummen,"\nC.V.=", cvnummen))  


###################################################
### code chunk number 11: gss15
###################################################
par(xpd=T)
h1 <- hist(dat$nummen, prob=T, main="Male Sexual Partners (nummen)", xlab="Number of Male Sexual Partners", ylim=c(0,0.7)) 
text(max(h1$mids), 0.5, pos=1, label=paste("Mean=", mnummen,"\nStd.Dev=", sdnummen,"\nMedian=", mednummen,"\nC.V.=", cvnummen))  


###################################################
### code chunk number 12: gss16
###################################################
par(xpd=T)
dennummen <- density(dat$nummen, na.rm=T)
plot(dennummen, main="The default plot of a density object")


###################################################
### code chunk number 13: gss30
###################################################
par(xpd=T)
h1 <- hist(dat$nummen, breaks=50, prob=T, main="Male Sexual Partners (nummen)", xlab="Number of Male Sexual Partners", ylim=c(0,0.5)) 
dennummen <- density(dat$nummen, na.rm=T)
lines(dennummen, lty=2, lwd=1, col="green")
text(35, 0.15, label=c("kernel density \n estimate (green)"),pos=3)
arrows(30, 0.15, 18,0.03, lty=2, length=0.1)


###################################################
### code chunk number 14: gss31
###################################################
par(xpd=T)
h1 <- hist(dat$nummen, breaks=50, prob=T, main="Male Sexual Partners", xlab="Number of Male Sexual Partners", ylim=c(0,0.5)) 
dennummen <- density(dat$nummen, na.rm=T)
lines(dennummen, lty=2, lwd=1, col="green")
legend("topright",legend=c("Histogram", "Kernel Density"), lty=c(1, 2), col=c("black","green"))


###################################################
### code chunk number 15: createnorm
###################################################
set.seed(1234321) 
myx <- rnorm(1000, mean=50, sd=20) 


###################################################
### code chunk number 16: mstd
###################################################
mx <- mean(myx, na.rm = TRUE)
sdx <- sd(myx, na.rm = TRUE)
sdx <- round(sdx, 3)


###################################################
### code chunk number 17: histfinal
###################################################
hist(myx , breaks=30, prob=T, xlab="A Beautiful Variable", ylab="Density", main="")
text(80, 0.020, label=paste("Mean = ", round(mx,2)), cex=1.5) 
#text(82, 0.018, label=paste("Std. Dev. = ", round(sdx,2)))


###################################################
### code chunk number 18: histfinal2
###################################################
myx2 <- rnorm(1000, 20, 20)
par(mfcol=c(1,2))
hist(myx, breaks=30, prob=TRUE, xlab="A Beautiful Variable", ylab="Density", main="", xlim=c(-40, 120), ylim=c(0, 0.025))
text(10, 0.020, label=paste("Mean = ", round(mx,2)), cex=1.5) 
#text(82, 0.018, label=paste("Std. Dev. = ", round(sdx,2)))
hist(myx2, breaks=30, prob=T, xlab="Another Variable", ylab="Density", main="", xlim=c(-40,120), ylim=c(0,0.025))
mx2 <- mean(myx2, na.rm=T)
sdx2 <- sd(myx2, na.rm=T)
text(45, 0.021, label=paste("Mean = ", round(mx2,2)), cex=1.5) 


###################################################
### code chunk number 19: V1
###################################################
myx1 <- rnorm(1000, 40, 10)
myx2 <- rnorm(1000, 40, 20)
mx1 <- round(mean(myx1, na.rm=T), 2)
sdx1 <- round(sd(myx1, na.rm=T), 2)
mx2 <- round(mean(myx2, na.rm=T), 2)
sdx2 <- round(sd(myx2, na.rm=T), 2)
par(mfcol=c(1,2))
hist(myx1 , breaks=30, prob=T, xlab="Small Variance", ylab="Density", main="", xlim=c(-20,100),ylim=c(0,0.035))
text(5, 0.026, label=paste("Mean = ", round(mx1,2))) 
text(5, 0.024, label=paste("Std. Dev. = ", round(sdx1,2)))
hist(myx2 , breaks=30, prob=T, xlab="Big Variance", ylab="Density", main="", xlim=c(-20,100), ylim=c(0,0.035))
text(70, 0.026, label=paste("Mean = ", round(mx2,2))) 
text(70, 0.024, label=paste("Std. Dev. = ", sdx2))


###################################################
### code chunk number 20: gss50
###################################################
par(xpd=T)
mh <- hist(dat$sei, xlab= "Socio-economic Index", ylab = "Proportion", xlim=c(0,100), ylim = c(0, 0.04), breaks=25, prob=T, main="")
densei <- density(dat$sei, na.rm=T)
lines(densei, lty=2)
text(10, 0.01, label=c("kernel \n density \n estimate"),pos=3)
arrows(10, 0.01, 18,0.003, lty=2, length=0.1)
text( 0.8*max(dat$sei,na.rm=T), max(densei$y), label = paste("mean=", round(mean(dat$sei, na.rm =T),2), "\n std.dev. =", round(sd(dat$sei,na.rm=T),2)), pos=3 )


###################################################
### code chunk number 21: gss55
###################################################
par(xpd=T)
men <- dat[dat$sex %in% levels(dat$sex)[1], ] 
women <- dat[dat$sex %in% levels(dat$sex)[2], ]
womend <- density(women$sei,na.rm = TRUE) 
mend <- density(men$sei, na.rm = TRUE)
mh <- hist(men$sei, xlab= "Socio-economic Index", ylab = "Proportion", xlim=c(0,100), ylim = c(0, 0.04), breaks = 25, prob = TRUE, main="")

lines(mend, lty=2)
text(10, 0.01, label=c("kernel \n density \n estimate"),pos=3)
arrows(10, 0.01, 18,0.003, lty=2, length=0.1)

text( 0.8*max(men$sei,na.rm = TRUE), 0.035, label = paste("mean=", round(mean(men$sei, na.rm =T),2), "\n std.dev. =", round(sd(men$sei,na.rm=T),2)), pos=3 )


###################################################
### code chunk number 22: gss60
###################################################
par(xpd=T) 
wh <- hist(women$sei, xlab="Socio-economic Index", ylab="Proportion", xlim=c(0,100), ylim=c(0, 0.04), breaks=25, prob = TRUE, main="")

lines(womend, lty=2)

text(10, 0.01, label=c("kernel \n density \n estimate"),pos=3)

arrows(10, 0.01, 18,0.003, lty=2, length=0.1)

text( 0.8*max(women$sei, na.rm = TRUE), 0.03, pos = 3, 
label = paste("mean=",round(mean(women$sei,na.rm = TRUE),2), "\n std.dev.=", round(sd(women$sei, na.rm = T),2)))


###################################################
### code chunk number 23: symmetry1A
###################################################
myx <- rgamma(1000, 1.5, 3)
hist(myx , breaks=30, prob=T, xlab="Skewed", ylab="Density", main="")
mx <- round(mean(myx, na.rm=T), 2)
sdx <- round(sd(myx), 2)
text(mx, 1.50, pos=4, label=paste("Mean = ", mx)) 
#text(mx, 1.35, pos=4, label=paste("Std. Dev. = ", sdx))
abline(v=mx, col="red")


###################################################
### code chunk number 24: symmetry1B
###################################################
myx <- rexp(1000, 5)
hist(myx , breaks=30, prob=T, xlab="Skewed", ylab="Density", main="")
mx <- round(mean(myx, na.rm=T), 2)
sdx <- round(sd(myx, na.rm=T), 2)
text(mx, 1.50, pos=4, label=paste("Mean = ", mx)) 
#text(mx, 1.35, pos=4, label=paste("Std. Dev. = ", sdx))
abline(v=mx, col="red")


###################################################
### code chunk number 25: symmetry2A
###################################################
myx <- rgamma(1000, 1.5, 3)
hist(myx , breaks=30, prob=T, xlab="Skewed", ylab="Density", main="")
mx <- round(mean(myx, na.rm=T), 2)
sdx <- round(sd(myx), 2)
text(mx, 1.45, pos=4, label=paste("Mean =", mx)) 
text(mx+0.5, 1.35, pos=4, label=paste("Std. Dev. =", sdx))
abline(v=mx, col="red")
medx <- round(median(myx), 2)
abline(v=medx, col="green")
text(medx, 1.20, pos=4, label=paste("Median =", medx))


###################################################
### code chunk number 26: symmetry2B
###################################################
myx <- rexp(1000, 5)
hist(myx , breaks=30, prob=T, xlab="Skewed", ylab="Density", main="")
mx <- round(mean(myx, na.rm=T), 2)
sdx <- round(sd(myx, na.rm=T), 2)
text(mx, 4.0, pos=4, label=paste("Mean = ", mx), col="red") 
text(mx+0.5, 1.35, pos=4, label=paste("Std. Dev. = ", sdx))
abline(v=mx, col="red")
medx <- round(median(myx), 2)
abline(v=medx, col="green")
text(medx, 3.0, pos=4, label=paste("Median =", medx), col="green")


###################################################
### code chunk number 27: scaling1
###################################################
x1 <- rnorm (20, mean=200, sd=50)
mx1 <- round(mean(x1), 2)
sdx1 <- round(sd(x1), 2)
x2 <- rnorm (20, mean=50, sd=12.5)
mx2 <- round(mean(x2), 2)
sdx2 <- round(sd(x2), 2)
par(mfcol=c(2,1))
hist(x1, prob=T, xlab="x", ylab="density", main=paste("Mean=",mx1,"SD=", sdx1), xlim=c(0,400))
hist(x2, prob=T, xlab="x", ylab="density", main=paste("Mean=",mx2,"SD=", sdx2), xlim=c(0,400))
par(mfcol=c(1,1))


###################################################
### code chunk number 28: scaling2
###################################################
par(mfcol=c(2,1))
stx1 <- x1/mx1; stx2 <- x2/mx2
hist(stx1, prob=T, xlab="x", ylab="density", main=paste("Hist of x1/Mean(x1)"), xlim=c(0,3))
hist(stx2, prob=T, xlab="x", ylab="density", main=paste("Hist of x2/Mean(x2)"), xlim=c(0, 3))
par(mfcol=c(1,1))


###################################################
### code chunk number 29: sumlr
###################################################
df <- cbind(top=c(summary(x1), mean=mean(x1),sd=sd(x1), sd.over.mean=sd(x1)/mean(x1)), bottom=c(summary(x2),mean(x2), sd(x2),sd(x2)/mean(x2)))
#means <- round(mean(df),2)
#sds <- round(sd(df),2)
#sd.over.mean <- round(sds/means,2)
#df2 <- rbind(as.data.frame(summary(df)),means, sds, sd.over.mean)


###################################################
### code chunk number 30: sumlr2
###################################################
df


###################################################
### code chunk number 31: z1
###################################################
x <- exp(rnorm(500))
hist(x, prob=T, xlab="x", ylab="density", main="x is skewed")


###################################################
### code chunk number 32: z2
###################################################
x.log <- log(x)
hist(x.log, prob=T, xlab="log of x", ylab="density", main="x is not so skewed")


###################################################
### code chunk number 33: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 34: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


