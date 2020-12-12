### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.hX2832/lyx_tmpbuf2/Categorical-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Categorical-1-lecture.Rnw:23-24
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Categorical-1-lecture.Rnw:77-78
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
#set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: chile20 (eval = FALSE)
###################################################
## library(car)
## mod1 <- lm(statusquo ~ sex, data=Chile)
## summary(mod1)


###################################################
### code chunk number 5: chile21
###################################################
library(car)
mod1 <- lm(statusquo ~ sex, data=Chile)
summary(mod1)


###################################################
### code chunk number 6: chile22
###################################################
library(rockchalk)
outreg(mod1, tight=FALSE, showAIC=FALSE)


###################################################
### code chunk number 7: chile10
###################################################
by(Chile$statusquo, Chile$sex, mean, na.rm = TRUE)
t.test(statusquo ~ sex, var.equal=TRUE, data=Chile) 


###################################################
### code chunk number 8: wages00
###################################################
library(rockchalk)
dat <- read.table("/home/pauljohn/ps/SVN-guides/stat/DataSets/wages/wages.txt", header=T, sep="") 
colnames(dat) <- tolower(colnames(dat))
dat$racef <- factor(dat$race, labels=c("Other", "Hispanic","White")) 
dat$occupationf <- factor(dat$occupation, labels=c("Management", "Sales", "Clerical", "Service", "Professional", "Other")) 
dat$marrf <- factor(dat$marr, levels=c("Unmarried","Married"))


###################################################
### code chunk number 9: wages10
###################################################
mod1 <- lm(wage ~ occupation, data=dat) 


###################################################
### code chunk number 10: wages10B
###################################################
outreg(mod1, tight=F, showAIC=F)


###################################################
### code chunk number 11: wages10C
###################################################
termplot(mod1, terms=c("occupation"), partial=T, se=T)


###################################################
### code chunk number 12: wages25A
###################################################
contrasts(dat$occupationf)


###################################################
### code chunk number 13: wages20
###################################################
mod2 <- lm(wage ~ occupationf, data=dat) 


###################################################
### code chunk number 14: wages20B
###################################################
outreg(mod2, tight=F, showAIC=F)


###################################################
### code chunk number 15: wages20C
###################################################
termplot(mod2, terms=c("occupationf"), partial=T, se=T)


###################################################
### code chunk number 16: wages25B
###################################################
levels(dat$occupationf)


###################################################
### code chunk number 17: wages25C
###################################################
summary(mod2)


###################################################
### code chunk number 18: wages25D
###################################################
anova(mod2, test="F")


###################################################
### code chunk number 19: wages30
###################################################
occlev <- levels(dat$occupationf)
dat$occupationf2 <- dat$occupationf
dat$occupationf2[dat$occupationf2 %in% occlev[2:4]] <- occlev[2]

levels(dat$occupationf2)[2] <- "sales/clerk/serv"
with(dat, table(occupationf2, occupationf))
mod3 <- lm(wage ~ occupationf2, data=dat)


###################################################
### code chunk number 20: wages30B
###################################################
outreg(mod3, tight=F, showAIC=F)


###################################################
### code chunk number 21: wages30D
###################################################
anova(mod3, mod2, test="F")


###################################################
### code chunk number 22: wages40
###################################################
dat$occupationf2[dat$occupationf2 %in% occlev[5]] <- occlev[1] 
levels(dat$occupationf2)[1] <- "manag/prof"
dat$occupationf2 <- dat$occupationf2[, drop=T]


###################################################
### code chunk number 23: wages40A
###################################################
contrasts(dat$occupationf2)


###################################################
### code chunk number 24: wages40B
###################################################
mod4 <- lm(wage ~ occupationf2, data=dat)


###################################################
### code chunk number 25: wages40C
###################################################
outreg(mod4, tight=F, showAIC=F)


###################################################
### code chunk number 26: wages40D
###################################################
anova( mod4, mod2,  test="F")


###################################################
### code chunk number 27: chile30M (eval = FALSE)
###################################################
## chile1M <- lm(statusquo ~ sex, data=Chile)


###################################################
### code chunk number 28: chile30F (eval = FALSE)
###################################################
## Chile$sex <- relevel(Chile$sex, ref="M")
## chile1F <- lm(statusquo ~ sex, data=Chile)


###################################################
### code chunk number 29: chile30NI (eval = FALSE)
###################################################
## chile1NI <- lm(statusquo ~ -1 + sex, data=Chile)


###################################################
### code chunk number 30: chile31
###################################################
chile1M <- lm(statusquo ~ sex, data=Chile)
Chile$sex <- relevel(Chile$sex, ref="M")
chile1F <- lm(statusquo ~ sex, data=Chile)
chile1NI <- lm(statusquo ~ -1 + sex, data=Chile)


###################################################
### code chunk number 31: chile32
###################################################
outreg(list(chile1M, chile1F, chile1NI), modelLabels=c("M","F","No Int."), tight=TRUE, showAIC=FALSE)


###################################################
### code chunk number 32: chile40
###################################################
termplot(chile1F, partial.resid=TRUE, se=TRUE, ylabs="Statusquo Support")


###################################################
### code chunk number 33: chile45
###################################################
termplot(chile1NI, partial.resid=TRUE, se=TRUE, ylabs=c("Statusquo Support"))


###################################################
### code chunk number 34: chile50
###################################################
head(predict(chile1F))


###################################################
### code chunk number 35: chile51
###################################################
head(predict(chile1NI))


###################################################
### code chunk number 36: chile110
###################################################
library(car)
agg1 <- aggregate(Chile$statusquo, by=list(region=Chile$region), mean, na.rm=T)
agg1


###################################################
### code chunk number 37: chile145
###################################################
(munweighted <- mean(agg1$x))


###################################################
### code chunk number 38: chile120
###################################################
modr1 <- lm( statusquo ~ -1 + region, data=Chile)
outreg(modr1, tight=FALSE, showAIC=F)


###################################################
### code chunk number 39: chile130
###################################################
modr2 <- lm( statusquo ~ region, data=Chile, x=T, y=T)
outreg(modr2, tight=FALSE, showAIC=F)


###################################################
### code chunk number 40: chile135A
###################################################
contrasts(Chile$region)


###################################################
### code chunk number 41: chile135B
###################################################
options(contrasts=c("contr.sum", "contr.poly"))
contrasts(Chile$region)


###################################################
### code chunk number 42: chile140
###################################################
modr3 <- lm( statusquo ~ region, data=Chile)


###################################################
### code chunk number 43: chile140B
###################################################
outreg(modr3, tight=FALSE, showAIC=F)


###################################################
### code chunk number 44: chile142 (eval = FALSE)
###################################################
## #agg1 <- aggregate(Chile$statusquo, by=list(region=Chile$region), mean, na.rm=T)
## agg1


###################################################
### code chunk number 45: chile147
###################################################
agg1$diff <- agg1$x - munweighted
agg1


###################################################
### code chunk number 46: chile140C
###################################################
Chile$region2 <- factor(Chile$region, levels=c("M","N","S","SA","C"))
modr4 <- lm( statusquo ~ region2, data=Chile)


###################################################
### code chunk number 47: chile140D
###################################################
contrasts(Chile$region2)


###################################################
### code chunk number 48: chile141D
###################################################
outreg(modr4, tight=FALSE, showAIC=F)


###################################################
### code chunk number 49: Categorical-1-lecture.Rnw:1351-1352
###################################################
outreg(modr1, tight=T,showAIC=F)


###################################################
### code chunk number 50: Categorical-1-lecture.Rnw:1359-1360
###################################################
outreg(modr2, tight=T,showAIC=F)


###################################################
### code chunk number 51: Categorical-1-lecture.Rnw:1367-1368
###################################################
outreg(modr4, tight=T,showAIC=F)


###################################################
### code chunk number 52: chile164
###################################################
pmr1 <- aggregate(predict(modr1), by=list(region=modr1$model$region), mean)
pmr2 <- aggregate(predict(modr2), by=list(region=modr2$model$region), mean)
pmr3 <- aggregate(predict(modr3), by=list(region=modr3$model$region), mean)


###################################################
### code chunk number 53: chile167.5
###################################################
dat <-data.frame(pmr1,pmr2,pmr3)
dat <- dat[ ,c(1,2,4,6)]
colnames(dat) <- c("region", "NoInt", "Treatment", "Effects")


###################################################
### code chunk number 54: chile167.6
###################################################
dat


###################################################
### code chunk number 55: chile169
###################################################
all.equal(predict(modr1), predict(modr2), predict(modr3))


