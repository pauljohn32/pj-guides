### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.M30935/lyx_tmpbuf2/Regression-Example-3.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Regression-Example-3.Rnw:19-20
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-Example-3.Rnw:75-76
###################################################
dir.create("plots3", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=90, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(4.1, 4.1, 1, 2.1) 
##pjmar <- par("mar")
##par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=11)


###################################################
### code chunk number 4: Regression-Example-3.Rnw:116-124
###################################################
if (file.exists("USNewsCollege.rds")){
  dat <- readRDS("USNewsCollege.rds")
}else{
 dat <- read.table(url("http://pj.freefaculty.org/guides/stat/DataSets/USNewsCollege/USNewsCollege.csv"), header = FALSE, sep=",")
mynames <- c("fice", "name", "state", "private", "avemath", "aveverb", "avecomb", "aveact", "fstmath", "trdmath", "fstverb", "trdverb", "fstact", "trdact", "numapps", "numacc", "numenr", "pctten", "pctquart", "numfull", "numpart", "instate", "outstate", "rmbrdcst", "roomcst", "brdcst", "addfees", "bookcst", "prsnl","pctphd", "pctterm", "stdtofac", "pctdonat", "instcst", "gradrate")
  colnames(dat) <- mynames
  saveRDS(dat, file = "USNewsCollege.rds")
}


###################################################
### code chunk number 5: usn10
###################################################
str(dat)


###################################################
### code chunk number 6: usn20
###################################################
library(rockchalk)
summarize(dat)


###################################################
### code chunk number 7: usn21
###################################################
dat$schtype <- factor(dat$private, levels = c("1","2"), labels = c("public","private"))
## Proofread
table(dat$schtype, dat$private, exclude = NULL)
levels(dat$schtype)


###################################################
### code chunk number 8: usn22
###################################################
dat <- dat[ , c("gradrate", "instcst", "stdtofac", "aveact", "instate", "outstate", "schtype")]


###################################################
### code chunk number 9: usn25
###################################################
datpublic  <- dat[dat$schtype %in% levels(dat$schtype)[1], ]
datprivate <- dat[dat$schtype %in% levels(dat$schtype)[2], ]
par(mfcol = c(1,2))
hist(datpublic$gradrate, prob = TRUE, breaks = 50, main = "Public Graduation Rates", xlab = "Graduation Rates")
hist(datprivate$gradrate, prob = TRUE, breaks = 50, main = "Private Graduate Rates", xlab = "Graduation Rates")


###################################################
### code chunk number 10: usn26
###################################################
dat <- dat[ dat$gradrate <= 100, ]
datpublic  <- dat[dat$schtype %in% levels(dat$schtype)[1], ]
datprivate <- dat[dat$schtype %in% levels(dat$schtype)[2], ]
par(mfcol=c(1,2))
hist(datpublic$gradrate, prob = TRUE, breaks = 50, main = "Public Graduation Rates")
hist(datprivate$gradrate, prob = TRUE, breaks = 50, main = "Private Graduate Rates")


###################################################
### code chunk number 11: usn30
###################################################
summarize(datpublic)
summarize(datprivate)


###################################################
### code chunk number 12: usn31
###################################################
(t1 <- table(dat$schtype))
prop.table(t1)


###################################################
### code chunk number 13: usn35a
###################################################
t.test(gradrate ~ schtype, data = dat)


###################################################
### code chunk number 14: usn35b
###################################################
t.test(gradrate ~ schtype, data = dat, var.equal = TRUE)


###################################################
### code chunk number 15: Regression-Example-3.Rnw:300-302
###################################################
mod1 <- lm (gradrate ~ schtype, data = dat)
summary(mod1)


###################################################
### code chunk number 16: Regression-Example-3.Rnw:310-311
###################################################
head(model.matrix(mod1))


###################################################
### code chunk number 17: Regression-Example-3.Rnw:324-326
###################################################
library(rockchalk)
outreg(mod1, tight=TRUE, showAIC=F)


###################################################
### code chunk number 18: Regression-Example-3.Rnw:366-367
###################################################
confint(mod1)


###################################################
### code chunk number 19: usn60
###################################################
dat$schnum <- as.numeric(dat$schtype) - 1
plot(gradrate ~ schnum, data = dat, xlab = "Private or Public?", ylab = "Graduation Rate")
abline(mod1)


###################################################
### code chunk number 20: usn65
###################################################
termplot(mod1, terms = c("schtype"), partial = TRUE, se = TRUE)


###################################################
### code chunk number 21: usn70
###################################################
plot(gradrate ~ schtype, data = dat, xlab = "Private or Public?", ylab = "Graduation Rate")
abline(mod1)


###################################################
### code chunk number 22: Regression-Example-3.Rnw:437-439
###################################################
bp1 <- predict(mod1, interval = "confidence")
head(bp1)


###################################################
### code chunk number 23: usn71
###################################################
newdf <- data.frame(schtype = factor(c("public", "private"), levels = c("public", "private")))
gradratehat <- predict(mod1, interval = "conf", newdata = newdf)
newdf <- cbind(gradratehat, newdf)
newdf


###################################################
### code chunk number 24: usn75
###################################################
#newdf <- data.frame(schtype = levels(dat$schtype))
#newdf$schtype <- relevel(newdf$schtype, "public") ###WOW:  problem required this
plot(gradrate ~ schtype, data = dat, xlab = "Private or Public?", ylab = "Graduation Rate", ylim = range(dat$gradrate, na.rm = TRUE))
gradratehat <- predict(mod1, interval="conf", newdata=newdf)
lines(gradratehat[ , 1] ~ schtype, data = newdf, col = "black", lty = 1)
lines(gradratehat[ , 2] ~ schtype, data = newdf, col = "red", lty = 4)
lines(gradratehat[ , 3] ~ schtype, data = newdf, col = "red", lty = 4)


###################################################
### code chunk number 25: usn80
###################################################
plot(gradrate ~ schtype, data = dat, xlab = "Private or Public?", ylab = "Graduation Rate", ylim = range(dat$gradrate, na.rm = TRUE)) 
points(gradratehat[ , 1] ~ as.numeric(schtype), data = newdf, pch = "x", col = "red", cex = 1)

arrows(x0 = as.numeric(newdf$schtype), y0 = gradratehat[ , 2],x1=as.numeric(newdf$schtype),  y1 = gradratehat[ , 3], col = "green", angle = 90, code = 3)

text( c(30,25) ~ c( 1.5, 1.5), pos = 1, adj = 2, label = c("x: Predicted Value", "Green brackets 95% CI"), cex = 0.8, col = c("red", "green"))


###################################################
### code chunk number 26: usn100
###################################################
plot(gradrate ~ instcst, data=dat)


###################################################
### code chunk number 27: usn110
###################################################
mod2 <- lm(gradrate ~ instcst, data = dat)
summary(mod2)


###################################################
### code chunk number 28: usn115
###################################################
plotSlopes(mod2, plotx = "instcst", interval = "confidence")


###################################################
### code chunk number 29: usn130
###################################################
mod3 <- lm(gradrate ~ instcst, data = dat, subset = instcst < 25000)
plotSlopes(mod3, plotx = "instcst", interval = "confidence")


###################################################
### code chunk number 30: Regression-Example-3.Rnw:587-589
###################################################
library(rockchalk)
outreg(mod3, tight = TRUE, showAIC = FALSE)


###################################################
### code chunk number 31: usn160
###################################################
dat$instcstP1000 <- dat$instcst/1000
mod3 <- lm(gradrate ~ instcstP1000, data = dat, subset = instcstP1000 < 25)


###################################################
### code chunk number 32: usn161
###################################################
outreg(mod3, tight=TRUE, showAIC=FALSE)



###################################################
### code chunk number 33: usn162
###################################################
plotSlopes(mod3, plotx="instcstP1000", interval = "confidence")


###################################################
### code chunk number 34: Regression-Example-3.Rnw:678-679
###################################################
confint(mod3)


###################################################
### code chunk number 35: subset10
###################################################
dat <- dat[dat$instcstP1000 < 25, ]
datpublic  <- dat[dat$schtype %in% levels(dat$schtype)[1], ]
datprivate <- dat[dat$schtype %in% levels(dat$schtype)[2], ]
par(mfrow=c(1,2))
plot(gradrate ~ instcstP1000, data = datpublic, main = "Public", xlab = "Instructional Cost/1000", ylab = "Graduation Rate")
plot(gradrate ~ instcstP1000, data = datprivate, main = "Private", xlab = "Instructional Cost/1000", ylab = "Graduation Rate")


###################################################
### code chunk number 36: usn150
###################################################
plot(gradrate ~ instcstP1000, data = dat, col = schtype, xlab = "Instructional Cost/1000", ylab = "Graduation Rate", pch = c("o","+")[dat$schtype])
legend("topleft", legend = levels(dat$schtype), col = c(1,2), pch = c("o","+"))


###################################################
### code chunk number 37: usn170
###################################################
plot(gradrate ~ instcstP1000, data = dat, subset = instcstP1000 < 25, pch = c("o","+")[schtype], col = schtype)
m3byPrivate <- by(dat, dat$schtype, function(subdat){m1 <- lm(gradrate ~ instcstP1000, data = subdat)})
abline(m3byPrivate[[1]], col = 1); abline(m3byPrivate[[2]], col = 2)
legend("topleft", legend = levels(dat$schtype), col = c(1,2),  pch = c("o", "+"), lty=c(1,1))


###################################################
### code chunk number 38: usn175
###################################################
outreg(list("Public" = m3byPrivate[[1]], "Private" =  m3byPrivate[[2]]),  tight=TRUE, showAIC=F)


