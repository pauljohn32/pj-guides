### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.M26742/lyx_tmpbuf2/Regression-Example-1.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Regression-Example-1.Rnw:19-20
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-Example-1.Rnw:76-77
###################################################
dir.create("plots3", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
##pjmar <- c(2.1, 3.1, 1, 2.1) 
##pjmar <- par("mar")
##par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=11)


###################################################
### code chunk number 4: Regression-Example-1.Rnw:105-116
###################################################
## If you have the ortann.rds file already, use it.
## Otherwise download
if (file.exists("ortann.rds")){
    print("Using saved file ortann.rds")
    dat <- readRDS("ortann.rds")
} else {
    print("Wait. Downloading ortann.csv file")
dat <- read.table(url("http://pj.freefaculty.org/guides/stat/DataSets/OregonTemps/ortann.csv"), header=T, sep=",")
    saveRDS(dat, file = "ortann.rds")
}
str(dat)


###################################################
### code chunk number 5: Regression-Example-1.Rnw:125-127
###################################################
library(rockchalk)
summarize(dat)


###################################################
### code chunk number 6: Regression-Example-1.Rnw:140-141
###################################################
dat$elevationP100 <- dat$elevation / 100


###################################################
### code chunk number 7: elev10
###################################################
plot(tann ~ elevationP100, data = dat, xlab = "Elevation (100s feet)", ylab="Annual Temperature Average")


###################################################
### code chunk number 8: Regression-Example-1.Rnw:169-171
###################################################
mod1 <- lm (tann ~ elevationP100, data=dat)
summary(mod1)


###################################################
### code chunk number 9: Regression-Example-1.Rnw:184-186
###################################################
library(rockchalk)
outreg(list("One Predictor Model" = mod1), varLabels = c("elevationP100" = "elevation/100"))


###################################################
### code chunk number 10: Regression-Example-1.Rnw:233-234
###################################################
confint(mod1)


###################################################
### code chunk number 11: elev20
###################################################
plot(tann ~ elevationP100, data = dat, xlab = "Elevation (100s feet)", ylab = "Annual Temperature Average")
abline(mod1)


###################################################
### code chunk number 12: elev30
###################################################
plot(tann ~ elevationP100, data = dat, xlab="Elevation (100s feet)", ylab="Annual Temperature Average")
abline(mod1)
newdf <- data.frame(elevationP100 = plotSeq(dat$elevationP100, 20))
pconf <- predict(mod1, interval = "confidence", newdata = newdf)
lines(newdf$elevation, pconf[, "lwr"], lwd = 1.5, lty=4, col="red")
lines(newdf$elevation, pconf[, "upr"], lwd = 1.5, lty=4, col="green")
legend("topright", legend=c("predicted","lower CI","upper CI"), lty=c(1,4,4), col=c("black", "red","green"), lwd = c(1, 1.5, 1.5))


###################################################
### code chunk number 13: elev40
###################################################
plot(tann ~ elevationP100, data = dat, xlab = "Elevation (100s feet)", ylab="Annual Temperature Average")
abline(mod1)
newdf <- data.frame(elevationP100 = plotSeq(dat$elevationP100, 20))
pconf <- predict(mod1, interval="confidence", newdata=newdf)
lines(newdf$elevationP100, pconf[ ,"lwr"], lwd = 1.5, lty=2, col="red")
lines(newdf$elevationP100, pconf[ ,"upr"], lwd = 1.5, lty=2, col="red")
ppred <- predict(mod1, interval="prediction", newdata=newdf)
lines(newdf$elevationP100, ppred[ ,"lwr"], lwd = 1.5, lty=4, col="green")
lines(newdf$elevationP100, ppred[ ,"upr"], lwd = 1.5, lty=4, col="green")
legend("topright", legend=c("predicted","conf. int.","pred. int."), lty=c(1,2,4), col=c("black", "red","green"), lwd = c(1, 1.5, 1.5))


###################################################
### code chunk number 14: elev50
###################################################
plotSlopes(mod1, plotx = "elevationP100", xlab="Elevation (100s feet)", ylab="Annual Temperature Average", interval = "confidence")


