### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.hX4121/lyx_tmpbuf2/Standardized-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Standardized-1-lecture.Rnw:23-24
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Standardized-1-lecture.Rnw:84-86
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=T)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: prestige10
###################################################
library(car)
Prestige$income <- Prestige$income/10
presmod1 <- lm(prestige ~ income + education + women, data = Prestige)


###################################################
### code chunk number 5: prestige100
###################################################
library(rockchalk)
outreg(presmod1, tight = FALSE)


###################################################
### code chunk number 6: Standardized-1-lecture.Rnw:301-302
###################################################
predictOMatic(presmod1, predVals = "margins", divider = "quantile")


###################################################
### code chunk number 7: Standardized-1-lecture.Rnw:305-306
###################################################
predictOMatic(presmod1, predVals = "margins", divider = "std.dev.")


###################################################
### code chunk number 8: Standardized-1-lecture.Rnw:309-310
###################################################
predictOMatic(presmod1, predVals = "auto", divider = "quantile")


###################################################
### code chunk number 9: Standardized-1-lecture.Rnw:313-314
###################################################
predictOMatic(presmod1, predVals = "auto", divider = "std.dev.")


###################################################
### code chunk number 10: prestige10st
###################################################
stPrestige <- Prestige
stPrestige$income <- scale(stPrestige$income)
stPrestige$education <- scale(stPrestige$education) 
stPrestige$women <- scale(stPrestige$women)  
stPrestige$prestige <- scale(stPrestige$prestige)
presmod1st <- lm(prestige ~ income + education + women, data = stPrestige)
summary(presmod1st)


###################################################
### code chunk number 11: prestige15
###################################################
pres1st <- standardize(presmod1)
summary(pres1st)


###################################################
### code chunk number 12: prestige20
###################################################
outreg(list(presmod1, presmod1st), tight=F, modelLabels=c("Unstandardized","Standardized"))


###################################################
### code chunk number 13: prestige30
###################################################
round(cbind(summary(presmod1)$coefficients[ ,c(1,3)], summary(pres1st)$coefficients[, c(1,3)]),2)


###################################################
### code chunk number 14: Prest10e
###################################################
hist(Prestige$education, prob = TRUE,  xlab = "education (car::Prestige)", main = "")
lines(density(Prestige$education))


###################################################
### code chunk number 15: Prest10i
###################################################
hist(Prestige$income, prob = TRUE, xlab = "income (car::Prestige)", main = "")
lines(density(Prestige$income))


###################################################
### code chunk number 16: Prest10w
###################################################
hist(Prestige$women, prob = TRUE, xlab = "women (car::Prestige)", main = "")
lines(density(Prestige$women ))


###################################################
### code chunk number 17: prestige200
###################################################
library(car)
presmod2 <- lm(prestige ~ income + education + women + type, data = Prestige)
presmod2st <- lm(prestige ~ income + education + women + type, data = stPrestige)
outreg(list(presmod2, presmod2st), tight = FALSE, modelLabels = c("Unstandardized", "Partly Standardized"))


###################################################
### code chunk number 18: prestige220
###################################################
presmod3st <- standardize(presmod2)
summary(presmod3st)


###################################################
### code chunk number 19: prestige250
###################################################
outreg(list(presmod2, presmod2st, presmod3st), tight = F, modelLabels = c("Unstandardized", "Standardized (except type)", "All Standardized"))


