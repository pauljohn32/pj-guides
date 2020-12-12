### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.M27337/lyx_tmpbuf2/Regression-Example-2.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Regression-Example-2.Rnw:18-19
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-Example-2.Rnw:68-69
###################################################
dir.create("plots3", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(4.1, 4.1, 1, 2.1) 
##pjmar <- par("mar")
##par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=11)


###################################################
### code chunk number 4: Regression-Example-2.Rnw:107-114
###################################################
## Either use the existing "StrengthJobData.rds" file, or make one
if (file.exists("StrencthJobData.rds")) {
  dat <- readRDS("StrengthJobData.rds")
} else { 
  dat <- read.table(url("http://pj.freefaculty.org/guides/stat/DataSets/StrengthJobData/StrengthJobdata.txt"), header = TRUE)
  saveRDS(dat, file = "StrengthJobData.rds")
}


###################################################
### code chunk number 5: str10
###################################################
str(dat)


###################################################
### code chunk number 6: str20
###################################################
sumdat <- apply(dat, 2, quantile, na.rm = TRUE)
sumdat <- rbind(sumdat, mean= apply(dat, 2, mean, na.rm = TRUE))
sumdat <- rbind(sumdat, sd= apply(dat, 2, sd, na.rm = TRUE))
sumdat <- rbind(sumdat, var= apply(dat, 2, var, na.rm = TRUE))
sumdat


###################################################
### code chunk number 7: str20b
###################################################
library(rockchalk)
sumdat2 <- summarize(dat)
sumdat2$numerics


###################################################
### code chunk number 8: str30
###################################################
 par(mfcol=c(2,2)) 
hist(dat$GRIP, prob = TRUE, xlab = "Grip strength", main = "Histogram: Grip Strength")
curve(dnorm(x, m = sumdat["mean","GRIP"], s = sumdat["sd", "GRIP"]), from =  range(dat$GRIP)[1], to = range(dat$GRIP)[2], add = TRUE) 

hist(dat$ARM, prob = TRUE, xlab = "Arm strength", main = "Histogram: Arm Strength") 
curve(dnorm(x, m = sumdat["mean","ARM"], s = sumdat["sd", "ARM"]), from =  range(dat$ARM)[1], to = range(dat$ARM)[2], add = TRUE) 

hist(dat$RATINGS, prob = TRUE, xlab = "Supervisor Rating", main = "Histogram: Rating") 
curve(dnorm(x, m = sumdat["mean","RATINGS"], s = sumdat["sd", "RATINGS"]), from = range(dat$RATINGS)[1], to = range(dat$RATINGS)[2], add = TRUE) 

hist(dat$SIMS, prob = TRUE, xlab="Sims Wrench Test", main="Histogram: Strength Simulation") 
curve(dnorm(x, m = sumdat["mean","SIMS"], s = sumdat["sd", "SIMS"]), from =  range(dat$SIMS)[1], to = range(dat$SIMS)[2], add = TRUE)


###################################################
### code chunk number 9: str40
###################################################
plot(dat) ## That's same as pairs(dat)


###################################################
### code chunk number 10: Regression-Example-2.Rnw:227-229
###################################################
mod1 <- lm (RATINGS ~ GRIP, data = dat)
summary(mod1)


###################################################
### code chunk number 11: Regression-Example-2.Rnw:242-243
###################################################
outreg(mod1, tight=T, showAIC=F)


###################################################
### code chunk number 12: Regression-Example-2.Rnw:287-288
###################################################
confint(mod1)


###################################################
### code chunk number 13: str60a
###################################################
mod1.predict <- predict(mod1)
head(mod1.predict, 10)


###################################################
### code chunk number 14: str60b
###################################################
ndf2 <- data.frame(GRIP = plotSeq(dat$GRIP, 5))
ndf2$pred2 <- predict(mod1, ndf2)
ndf2


###################################################
### code chunk number 15: ps100
###################################################
plotSlopes(mod1, plotx = "GRIP", xlab = "Grip Measurement", ylab = "Supervisor Rating", interval = "confidence")


###################################################
### code chunk number 16: str70
###################################################
plot(RATINGS ~ GRIP, data = dat, xlab = "Grip Strength", ylab = "Supervisor Rating")
abline(mod1)


###################################################
### code chunk number 17: str80
###################################################
plot(RATINGS ~ GRIP, data=dat, xlab="Grip Strength", ylab="Supervisor Rating")
abline(mod1)
newdf <- data.frame(GRIP=plotSeq(dat$GRIP, 20))
pconf <- predict(mod1, interval="confidence", newdata=newdf)
lines(newdf$GRIP, pconf[, "lwr"], lty=4, col="red")
lines(newdf$GRIP, pconf[, "upr"], lty=4, col="red")
legend("topright", legend=c("predicted","lower CI","upper CI"), lty=c(1,4,4), col=c("black", "red","red"))


###################################################
### code chunk number 18: str90
###################################################
plot(RATINGS ~ GRIP, data=dat, xlab="Grip Strength", ylab="Supervisor Rating", ylim = c(1,1.2)*range(dat$RATINGS))
abline(mod1)
newdf <- data.frame(GRIP=plotSeq(dat$GRIP, 20))
pconf <- predict(mod1, interval="confidence", newdata=newdf)
lines(newdf$GRIP, pconf[ ,"lwr"], lty=2, col="red")
lines(newdf$GRIP, pconf[ ,"upr"], lty=2, col="red")
ppred <- predict(mod1, interval="prediction", newdata=newdf)
lines(newdf$GRIP, ppred[ ,"lwr"], lty=4, col="green")
lines(newdf$GRIP, ppred[ ,"upr"], lty=4, col="green")
legend("topright", legend=c("predicted","conf. int.","pred. int."), lty=c(1,2,4), col=c("black", "red","green"))


###################################################
### code chunk number 19: abl100
###################################################
plot(1:10, 1:10)
abline(v = 5)
abline(h = 3.5, col = "red", lty = 3, lwd = 4)


###################################################
### code chunk number 20: Regression-Example-2.Rnw:455-457 (eval = FALSE)
###################################################
## plot(0:10, 0:10, type = "n")
## abline(a = 2.7, b = 0.55)


###################################################
### code chunk number 21: abl150
###################################################
plot(-1:10, -1:10, type = "n", xlim = c(-1, 10), ylim = c(-1,10), axes = FALSE, bty = "n", xlab = "one x variable", ylab = "one y variable")
axis(1, pos = 0, at = seq(1, 10, by = 1))
axis(2, pos = 0, at = seq(1, 10, by = 1))
abline(a = 2.7, b = 0.55)
abline(v = 0)
abline(h = 0)


###################################################
### code chunk number 22: ab20
###################################################
plot(seq(-1, 10, length.out = 21), -10:10, axes = FALSE,  type = "n")
## Make some phony graph paper
abline(v = 0, col= gray(.70)) ##get the idea?
abline(v = seq(1, 10), col = gray(.80), lwd = 0.7)
abline(h = seq(-10, 10), col = gray(.80), lwd = 0.7)
abline(a= 2, b = 0.5, col = "red", lwd = 2)
abline(coef = c(2, 0.5), col = "black", lwd = 2)
abline(coef = c(7, -0.3), col = "green", lwd = 4, lty = 3)
abline(coef = c(-3, 1.1), col = "pink", lwd =2, lty = 4)
abline(coef = c(-14, 0.8), col = "purple", lwd = 4, lty = 5)


