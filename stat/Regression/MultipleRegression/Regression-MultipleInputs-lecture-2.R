### R code from vignette source 'Regression-MultipleInputs-lecture-2.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Regression-MultipleInputs-lecture-2.Rnw:38-39
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-MultipleInputs-lecture-2.Rnw:86-88
###################################################
unlink("plots2", recursive=T)
dir.create("plots2", showWarnings=T)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: public10
###################################################
library(rockchalk)
dat <- read.table("/home/pauljohn/SVN/SVN-guides/stat/DataSets/PublicSpending/publicspending.txt", header=T)
mod1 <- lm(EX ~ ECAB + MET + GROW + OLD + YOUNG + WEST, data = dat)
outreg(mod1, tight=F)


###################################################
### code chunk number 5: public20
###################################################
mod1pcor <- getPartialCor(mod1, dvonly = FALSE)
round(mod1pcor, 4)


###################################################
### code chunk number 6: public30
###################################################
round(mod1pcor^2, 4)


###################################################
### code chunk number 7: public40
###################################################
m1 <- lm(EX ~ MET + GROW + YOUNG + OLD + WEST, data=dat)
EXStar <- resid(m1)
m2 <- lm(ECAB ~ MET + GROW + YOUNG + OLD + WEST, data=dat)
ECABStar <- resid(m2)
m3 <- lm(EXStar ~ ECABStar)
hopePcor <- summary(m3)
hopePcor$r.squared


###################################################
### code chunk number 8: public60
###################################################
mod2 <- lm(EX ~ YOUNG + WEST, data = dat)
mod2pcor <- getPartialCor(mod2, dvonly = FALSE)
round(mod2pcor^2, 4)


###################################################
### code chunk number 9: public105b
###################################################
EXfull <- lm(EX ~ ECAB + MET + GROW + YOUNG + OLD + WEST, data=dat)
getDeltaRsquare(EXfull)


###################################################
### code chunk number 10: public110
###################################################
EXfull <- lm(EX ~ ECAB + MET + GROW + YOUNG + OLD + WEST, data=dat)
EXnoECAB <- lm(EX ~ MET + GROW + YOUNG + OLD + WEST, data=dat)
(deltaRecab <- summary(EXfull)$r.square - summary(EXnoECAB)$r.square)


###################################################
### code chunk number 11: public150
###################################################
library(relaimpo)
EXFull <- lm(EX ~ ECAB+ MET + GROW + YOUNG + OLD + WEST, data=dat) 


###################################################
### code chunk number 12: public151
###################################################
(EXFull.relimp <- calc.relimp(EXFull, type=c("lmg"))) 
plot(EXFull.relimp)


###################################################
### code chunk number 13: rdesmatrix
###################################################
set.seed(123123)
xnum1 <- rnorm(100)
xcat2 <- factor(sample(c("Female", "Male"), 100, replace = TRUE))
z <- factor(sample(c("A","B","C","D"), 100, replace = TRUE))
y <- rnorm(100)
mod1 <- lm(y ~ xnum1 + xcat2 + z)
dat <- model.frame(mod1)
mod1mm <- model.matrix(mod1)
dat$y <- mod1mm %*% c(0.1, 0.45, -0.1, 0.2, 0.35, -0.45) + 0.8 *rnorm(100)
mod1 <- lm(y ~ xnum1 + xcat2 + z, data = dat)


###################################################
### code chunk number 14: WR55
###################################################
mod2 <- lm(y ~ xnum1 * z, data = dat)
mod2sum <- summary(mod2)
coef(mod2sum)


###################################################
### code chunk number 15: WR56
###################################################
mod4pmo <- predictOMatic(mod2, predVals = list(z = levels(dat$z), xnum1 = range(dat$xnum1)))
mod4pmo


###################################################
### code chunk number 16: WR60
###################################################
plotSlopes(mod2, plotx = "xnum1", modx = "z")


