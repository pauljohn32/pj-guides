### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM4347/lyx_tmpbuf0/RegDiagnostics-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: RegDiagnostics-1-lecture.Rnw:17-18
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: RegDiagnostics-1-lecture.Rnw:91-94
###################################################
##causes failure, don't understand why
##unlink("plots", recursive=T)
dir.create("plots", showWarnings=T)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=65, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: hideme
###################################################
library(car)
library(rockchalk)


###################################################
### code chunk number 5: regress05
###################################################
dat <- read.table("/home/pauljohn/ps/SVN-guides/stat/DataSets/PublicSpending/publicspending.txt", header = TRUE)


###################################################
### code chunk number 6: RegDiagnostics-1-lecture.Rnw:186-187 (eval = FALSE)
###################################################
## dat <- read.table("http://pj.freefaculty.org/guides/stat/DataSets/PublicSpending/publicspending.txt", header = TRUE)


###################################################
### code chunk number 7: regress06
###################################################
summarize(dat)


###################################################
### code chunk number 8: regress10
###################################################
dat$METSQ <- dat$MET*dat$MET
EXfull2 <- lm(EX ~ ECAB + MET + METSQ + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull2)


###################################################
### code chunk number 9: regress11
###################################################
par(mfcol=c(2,2))
plot(EXfull2)
par(mfcol=c(1,1))


###################################################
### code chunk number 10: regress20
###################################################
EXfull2infl <- influence.measures(EXfull2)
print(EXfull2infl)


###################################################
### code chunk number 11: regress30
###################################################


summary(EXfull2infl)


###################################################
### code chunk number 12: regress40
###################################################
dat$hat <- hatvalues(EXfull2)
sum(dat$hat)
data.frame(dat$STATE, dat$hat)


###################################################
### code chunk number 13: regress60
###################################################
dat$rstudent <- rstudent(EXfull2)
data.frame(dat$STATE, dat$rstudent)


###################################################
### code chunk number 14: regress50
###################################################
dat$dffits <- dffits(EXfull2)
data.frame(dat$STATE, dat$dffits)


###################################################
### code chunk number 15: regress70
###################################################
dfbetasPlots(EXfull2)


###################################################
### code chunk number 16: carinfl10
###################################################
influencePlot(EXfull2)


###################################################
### code chunk number 17: ex3d10
###################################################
library(rockchalk)
set.seed(22323)
stde <- 3
x1 <- rnorm(15, m=50, s=10)
x2 <- rnorm(15, m=50, s=10)
y <- 2 + 0.2 *x1 + 0.2*x2 + stde * rnorm(15,m=0,s=1)
modbase <- lm(y~x1 + x2)
outreg(modbase)


###################################################
### code chunk number 18: ex3d11
###################################################
modout <- mcGraph3(x1, x2, y)


###################################################
### code chunk number 19: ex3d12
###################################################
rstudent(modbase)


###################################################
### code chunk number 20: ex3d13
###################################################
dfbetasPlots(modbase)


###################################################
### code chunk number 21: ex3d14
###################################################
##plot.lm(modbase, which=5)
plot(modbase, which=5)


###################################################
### code chunk number 22: ex3d20
###################################################
x1[16] <- 50
x2[16] <- 0
y[16] <- 30
outreg(mod3A <- lm(y~x1+x2))
modout <- mcGraph3(x1, x2, y)


###################################################
### code chunk number 23: ex3d23
###################################################
rstudent(mod3A)


###################################################
### code chunk number 24: ex3d24
###################################################
dfbetasPlots(mod3A)


###################################################
### code chunk number 25: ex3d25
###################################################
#plot.lm(mod3A, which=5)
plot(mod3A, which=5)


###################################################
### code chunk number 26: ex3d30
###################################################
y[16] <- -10
outreg(mod3B <- lm(y~x1+x2))
modout <- mcGraph3(x1, x2, y)


###################################################
### code chunk number 27: ex3d31
###################################################
rstudent(mod3B)


###################################################
### code chunk number 28: ex3d32
###################################################
dfbetasPlots(mod3B)


###################################################
### code chunk number 29: ex3d33
###################################################
##plot.lm(mod3B, which=5)
plot(mod3B, which=5)


###################################################
### code chunk number 30: ex3d40
###################################################
y[16] <- -30
outreg(mod3C <- lm(y~x1+x2))
modout <- mcGraph3(x1, x2, y)


###################################################
### code chunk number 31: ex3d41
###################################################
rstudent(mod3C)


###################################################
### code chunk number 32: ex3d42
###################################################
dfbetasPlots(mod3C)


###################################################
### code chunk number 33: ex3d43
###################################################
#plot.lm(mod3C, which=5)
plot(mod3C, which=5)


