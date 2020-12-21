### R code from vignette source 'regression-tables-1n.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: regression-tables-1n.Rnw:27-28
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: regression-tables-1n.Rnw:82-84
###################################################
##unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=160, prompt="> ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: regression-tables-1n.Rnw:149-151
###################################################
library(foreign)
mydta1 <- read.dta("/home/pauljohn/SVN/SVN-guides/Rcourse/DataSets/04245-0001-Data.dta")


###################################################
### code chunk number 5: anes10
###################################################
plot(V043038~V043039,data=mydta1,xlab="V043039: Kerry Thermo",ylab="V043039: Bush Thermo")


###################################################
### code chunk number 6: anes20
###################################################
mydta1$th.bush.kerry <- mydta1$V043038 - mydta1$V043039


###################################################
### code chunk number 7: anes30
###################################################
##Party
mydta1$V043116 <- mydta1$V043116[, drop = TRUE]
levels(mydta1$V043116) <- c("SD","WD","ID","I","IR","WR","SR","O")
mydta1$V043116[ mydta1$V043116 %in% levels(mydta1$V043116)[8] ] <- NA
mydta1$V043116 <- mydta1$V043116[, drop = TRUE]
table(mydta1$V043116)

##IDEO
mydta1$V045117 <- mydta1$V045117[ , drop = TRUE]
levels(mydta1$V045117) <- c("EL","L","SL","M","SC","C","EC")
table(mydta1$V045117)

##Gender
levels(mydta1$V041109A) <- c("M","F")

## Gay Marriage
levels(mydta1$V043210) 
mydta1$V043210[ mydta1$V043210 %in% levels(mydta1$V043210)[4:10] ] <-NA  
mydta1$V043210 <- mydta1$V043210[, drop = TRUE]
levels(mydta1$V043210) <- c("Allow","No","Med") 

## Economy
mydta1$V043213 <- mydta1$V043213[ , drop = TRUE]
l <- levels(mydta1$V043213)
econnew <- factor(mydta1$V043213, levels=c(l[2],l[3],l[1]), labels=c("Worse","Same","Better"))
table(mydta1$V043213, econnew)
mydta1$V043213 <- econnew
rm(econnew)
##Flag
mydta1$V045145X <- mydta1$V045145X[, drop = TRUE] 


###################################################
### code chunk number 8: anes39B
###################################################
library(rockchalk)


###################################################
### code chunk number 9: anes40 (eval = FALSE)
###################################################
## library(rockchalk)
## mod1age <- lm(th.bush.kerry~V043250, data=mydta1)
## outreg(mod1age, tight=F, modelLabels=c("Age as Predictor"))


###################################################
### code chunk number 10: anes41
###################################################
library(rockchalk)
mod1age <- lm(th.bush.kerry~V043250, data=mydta1)
outreg(mod1age, tight=F, modelLabels=c("Age as Predictor"))


###################################################
### code chunk number 11: anes45
###################################################
library(rockchalk)
mod1age <- lm(th.bush.kerry~V043250, data=mydta1)
outreg(mod1age, tight=F, modelLabels=c("Age as Predictor"))


###################################################
### code chunk number 12: anes50 (eval = FALSE)
###################################################
## ## Run a new regression
## mod2age <- lm(th.bush.kerry~V043250 + V041109A, data=mydta1)
## ## Put 2 regressions in same table
## outreg(list(mod1age,mod2age), tight=T, modelLabels=c("Age Only","Age With Gender"))


###################################################
### code chunk number 13: anes51
###################################################
## Run a new regression
mod2age <- lm(th.bush.kerry~V043250 + V041109A, data=mydta1)
## Put 2 regressions in same table
outreg(list(mod1age,mod2age), tight=T, modelLabels=c("Age Only","Age With Gender"))


###################################################
### code chunk number 14: regression-tables-1n.Rnw:415-417
###################################################
or1 <- outreg(list(mod1age,mod2age), tight=T, modelLabels=c("Age Only","Age With Gender"))
outreg2HTML(or1, file = "or1-test.html")


###################################################
### code chunk number 15: anes55 (eval = FALSE)
###################################################
## library(xtable)
## tabout1 <- xtable(mod2age)
## print(tabout1, type="latex")


###################################################
### code chunk number 16: anes57
###################################################
library(xtable)
tabout1 <- xtable(mod2age)
print(tabout1, type="latex")


###################################################
### code chunk number 17: anes58 (eval = FALSE)
###################################################
## print(tabout1, type="HTML")


###################################################
### code chunk number 18: anes59
###################################################
print(tabout1, type="HTML")


###################################################
### code chunk number 19: anes60
###################################################
library(memisc) 
mod3age <- lm(th.bush.kerry~V043250 * V041109A, data=mydta1)
mtable(mod1age,mod2age,mod3age) 


###################################################
### code chunk number 20: anes65 (eval = FALSE)
###################################################
## toLatex(mtable(mod1age,mod2age,mod3age))


###################################################
### code chunk number 21: anes66
###################################################
toLatex(mtable(mod1age,mod2age,mod3age))


###################################################
### code chunk number 22: tr10 (eval = FALSE)
###################################################
## library(texreg)
## to1 <- texreg(list(mod1age,mod2age), return.string = TRUE, use.packages = FALSE, booktabs = TRUE, dcolumn = TRUE)


###################################################
### code chunk number 23: regression-tables-1n.Rnw:628-629
###################################################
library(texreg)
to1 <- texreg(list(mod1age,mod2age), return.string = TRUE, use.packages = FALSE, booktabs = TRUE, dcolumn = TRUE)


###################################################
### code chunk number 24: tr20
###################################################
cat(to1)


