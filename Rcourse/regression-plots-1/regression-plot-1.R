### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T11452/lyx_tmpbuf2/regression-plot-1.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: regression-plot-1.Rnw:18-19
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: regression-plot-1.Rnw:65-67
###################################################
##unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=160, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=FALSE,family="Times",pointsize=12)


###################################################
### code chunk number 4: regression-plot-1.Rnw:186-201 (eval = FALSE)
###################################################
## library(rockchalk)
## example(predictOMatic)
## ## Or create a fresh example for yourself with:
## dat <- genCorrelatedData2(1000, 
##     means = c(100,200,100, 40), 
##     sds = c(10, 20, 20, 5), 
##     rho = 0.2, 
##     beta = c(0.1, 0.3, 0.3, 0.1, -0.14, 0, 0.025), 
##     stde = 140)
## dat$xcat1 <- factor(sample(c("No","Yes","Yes"), 1000, replace = TRUE))
## m1 <- lm(y ~ x1 + x2 + x3 + x4 + xcat1, data = dat)
## summary(m1)
## predictOMatic(m1)
## predictOMatic(m1, divider = "std.dev.")
## predictOMatic(m1, divider = "seq", n = 7)


###################################################
### code chunk number 5: regression-plot-1.Rnw:225-236
###################################################
library(rockchalk)
library(foreign)
library(car)
filename <- "/home/pauljohn/SVN/SVN-guides/Rcourse/04245-0001-Data.dta"
#if(!file.exists("../04245-0001-Data.dta"))
if(!file.exists(filename)){
  download.file(url="http://pj.freefaculty.org/guides/Rcourse/04245-0001-Data.dta", dest = "../04245-0001-Data.dta")
mydta1 <- read.dta("../04245-0001-Data.dta")
} else {
mydta1 <- read.dta(filename)
}


###################################################
### code chunk number 6: anes10
###################################################
plot(V043038 ~ V043039, data = mydta1, xlab = "V043039: Kerry Thermo", ylab = "V043039: Bush Thermo")


###################################################
### code chunk number 7: anes20
###################################################
mydta1$th.bush.kerry <- mydta1$V043038 - mydta1$V043039


###################################################
### code chunk number 8: anes30
###################################################
##Party
mydta1$V043116 <- mydta1$V043116[,drop = TRUE]
levels(mydta1$V043116) <- c("SD","WD","ID","I","IR","WR","SR","O")
mydta1$V043116[ mydta1$V043116 %in% levels(mydta1$V043116)[8] ] <- NA
mydta1$V043116 <- mydta1$V043116[, drop=TRUE]
table(mydta1$V043116)

##IDEO
mydta1$V045117 <- mydta1$V045117[ ,drop = TRUE]
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
mydta1$V043213 <- mydta1$V043213[ ,drop = TRUE]
l <- levels(mydta1$V043213)
econnew <- factor(mydta1$V043213, levels=c(l[2],l[3],l[1]), labels=c("Worse","Same","Better"))
table(mydta1$V043213, econnew)
mydta1$V043213 <- econnew
rm(econnew)
##Flag
mydta1$V045145X <- mydta1$V045145X[,drop = TRUE] 


###################################################
### code chunk number 9: plot10
###################################################
## Step 1
mod1age <- lm(th.bush.kerry ~ V043250, data = mydta1)
## Step 2
plot(th.bush.kerry ~ V043250, type = "p", xlab = "V403250: Age", ylab = "Bush-Kerry thermometers", data = mydta1, col = gray(.7))
## Step 3
abline(mod1age, lwd = 1.5)


###################################################
### code chunk number 10: ablinecode
###################################################
abline


###################################################
### code chunk number 11: regression-plot-1.Rnw:402-403
###################################################
library(rockchalk)


###################################################
### code chunk number 12: rcps10
###################################################
plotSlopes(mod1age, plotx = "V043250", lwd = 0.3)


###################################################
### code chunk number 13: rcps20
###################################################
plotSlopes(mod1age, plotx = "V043250", interval = "confidence", lwd = 0.3)


###################################################
### code chunk number 14: plot12
###################################################
ndf <- data.frame(V043250 = range(mydta1$V043250))
ndf$fit <- predict(mod1age, newdata = ndf )
head(ndf)
plot(th.bush.kerry ~ V043250, data = mydta1, xlab = "V403250: Age", ylab = "th.bush.kerry = Bush-Kerry thermometers",  col = gray(.7)) ## Scatterplot
lines(fit ~ V043250, data = ndf, lwd = 1.5)


###################################################
### code chunk number 15: plint10
###################################################
x <- rnorm(100, m = 50, s = 20)
y <- 3 + 0.2 * x + 15 * rnorm(100)
mp1 <- lm(y ~ x)
ndf <- data.frame(x = plotSeq(x,40))
p1 <- as.data.frame(predict(mp1, interval="conf", newdata = ndf))
p2 <- as.data.frame(predict(mp1, interval="pred", newdata = ndf))
plot(x, y, ylim = magRange(y, 1.3))
lines(ndf$x, p1$fit, col = "black", lwd=3)
lines(ndf$x, p1$lwr, col = "red", lwd = 3, lty = 4)
lines(ndf$x, p1$upr, col = "red", lwd = 4, lty = 4)
lines(ndf$x, p2$lwr, col = "purple", lwd = 4, lty = 3)
lines(ndf$x, p2$upr, col = "purple", lwd = 4, lty = 3)
legend("topleft", legend = c("predicted","Conf. Interval", "Pred. Interval"), col = c("black", "red", "purple"), lty = c(1, 4,3), cex = 0.8, lwd = 3)


###################################################
### code chunk number 16: plot15
###################################################
plot(th.bush.kerry ~ V043250, type="n",xlab="V403250: Age", ylab="th.bush.kerry= Bush-Kerry thermometers", data=mydta1, ylim=c(-100,120))
points(th.bush.kerry ~ V043250, data=mydta1, col=gray(.7), lwd=0.5, cex=0.7)


###################################################
### code chunk number 17: plot16 (eval = FALSE)
###################################################
## ndf1 <- data.frame(V043250 = range(mydta1$V043250))
## mod1pred <- predict(mod1age, newdata = ndf1, interval="confidence")
## ndf1 <- cbind(ndf1, mod1pred)
## lines(fit ~ V043250, data = ndf1, lwd = 3, lty = 1)
## lines(lwr ~ V043250, data = ndf1, lwd = 2, lty = 2)
## lines(upr ~ V043250, data = ndf1, lwd = 2, lty = 2)
## legend("topleft", legend = c("predicted","95% CI"), lty = c(1,2), lwd = c(3,2), bg = "white")


###################################################
### code chunk number 18: plot17
###################################################
plot(th.bush.kerry ~ V043250, type="n",xlab="V403250: Age", ylab="th.bush.kerry= Bush-Kerry thermometers", data=mydta1, ylim=c(-100,120))
points(th.bush.kerry ~ V043250, data=mydta1, col=gray(.7), lwd=0.5, cex=0.7)
ndf1 <- data.frame(V043250 = range(mydta1$V043250))
mod1pred <- predict(mod1age, newdata = ndf1, interval="confidence")
ndf1 <- cbind(ndf1, mod1pred)
lines(fit ~ V043250, data = ndf1, lwd = 3, lty = 1)
lines(lwr ~ V043250, data = ndf1, lwd = 2, lty = 2)
lines(upr ~ V043250, data = ndf1, lwd = 2, lty = 2)
legend("topleft", legend = c("predicted","95% CI"), lty = c(1,2), lwd = c(3,2), bg = "white")


###################################################
### code chunk number 19: plot11
###################################################
fit <- predict(mod1age)
head(fit)
head(fitted(mod1age))


###################################################
### code chunk number 20: regression-plot-1.Rnw:659-662
###################################################
focalValues <- data.frame(x1 = c(1, 2, 3, 4), x2 = c(100,200))
mAndM <- expand.grid(focalValues)
mAndM[1:8, ]


###################################################
### code chunk number 21: chile05
###################################################
require(car)
data(Chile)
Chile$income <- Chile$income/1000
m2 <- lm(statusquo ~ income + age + sex, data=Chile)


###################################################
### code chunk number 22: chile15
###################################################
outreg(m2, tight=FALSE, title = "Chile Voter Survey (1972)", modelLabels=c("Status Quo Support"), varLabels=list(income = "Income (10000s pesos)", sexM = "Male"))


###################################################
### code chunk number 23: regression-plot-1.Rnw:715-718
###################################################
newdf <- data.frame(income = mean(Chile$income, na.rm=TRUE), age=median(Chile$age, na.rm = TRUE), sex = "M")
newdf$fit <- predict(m2, newdata = newdf)
newdf


###################################################
### code chunk number 24: plot14E (eval = FALSE)
###################################################
## sexlev <- levels(Chile$sex)
## newdf <- data.frame(income=c(mean(Chile$income, na.rm = T)),  age = c(55), sex = sexlev[1])
## newdf$fit <- predict(m1, newdata = newdf)


###################################################
### code chunk number 25: regression-plot-1.Rnw:788-789 (eval = FALSE)
###################################################
## termplot(m2)


###################################################
### code chunk number 26: tpchile05
###################################################
termplot(m2, terms = "income")


###################################################
### code chunk number 27: regression-plot-1.Rnw:807-808 (eval = FALSE)
###################################################
## termplot(m2, se = TRUE, partial.resid = TRUE)


###################################################
### code chunk number 28: tpchile10
###################################################
termplot(m2, se = TRUE, partial.resid = TRUE, terms = "income")


###################################################
### code chunk number 29: tpchile20
###################################################
termplot(m2, se = TRUE, partial.resid = TRUE, terms = "age")


###################################################
### code chunk number 30: tpchile30
###################################################
termplot(m2, se = TRUE, partial.resid = TRUE, terms = "sex")


###################################################
### code chunk number 31: termplot09
###################################################
m3 <- lm (th.bush.kerry ~ V045117 + V043116 + V043210 + V043213 + V045145X + V041109A, data = mydta1)


###################################################
### code chunk number 32: termplot10
###################################################
outreg(m3, tight = FALSE, modelLabels = c("Bush-Kerry Thermometer Differential"), varLabels=list(V045117L = "Liberal", V045117SL = "Slight Lib.", V045117M = "Moderate", V045117SC = "Slight Con.", V045117C = "Conservative", V045117EC = "Ext. Cons.", V043116WD = "Weak Dem.", V043116WD = "Weak Dem.", V043116ID = "Indep. Lean Dem.", V043116I = "Independent", V043116IR = "Indep. Lean Rep.", V043116WR = "Weak Rep.", V043116R = "Republican", V043116SR = "Str. Repub.", V043210No = "No Gay Marr", V043210med = "Civ Union", V043213Same = "Econ. Same", V043213Better = "Econ. Better", V041109AF = "Female"))


###################################################
### code chunk number 33: termplot40
###################################################
termplot(m3, se = TRUE, partial.resid=TRUE, terms="V045117",xlab="V045117: Ideology")


###################################################
### code chunk number 34: termplot41
###################################################
termplot(m3, se=TRUE, partial.resid=TRUE, terms="V043116",xlab="V043116: Party ID")


###################################################
### code chunk number 35: termplot42
###################################################
termplot(m3, se=TRUE, partial.resid=T, terms="V043210",xlab="V043210: Gay Marriage")


###################################################
### code chunk number 36: termplot43
###################################################
termplot(m3, se=TRUE, partial.resid=TRUE, terms="V043213",xlab="V043213: Economy")


###################################################
### code chunk number 37: termplot44
###################################################
termplot(m3, se=TRUE, partial.resid=TRUE, terms="V045145X",xlab="V045145X: The Flag Makes Me Feel")


###################################################
### code chunk number 38: termplot45
###################################################
termplot(m3, se=TRUE, partial.resid=T, terms="V041109A",xlab="V041109a: Gender")


###################################################
### code chunk number 39: termplot46
###################################################
termplot(m3, se=TRUE, terms="V041109A",xlab="V041109A: Gender")


###################################################
### code chunk number 40: regression-plot-1.Rnw:1115-1121
###################################################
newdata(m2, predVals = c("income"))
newdata(m2, predVals = c("income"), n = 5)
## income data not continuous, barely numeric
sort(unique(Chile$income))
newdata(m2, predVals = list(income = "table", "sex" = c("M","F")), n = 5)
newdata(m2, predVals = list(income = "quantile", age = "std.dev."), n = 3)


###################################################
### code chunk number 41: regression-plot-1.Rnw:1133-1134
###################################################
predictOMatic(m2)


###################################################
### code chunk number 42: regression-plot-1.Rnw:1137-1138
###################################################
predictOMatic(m3)


###################################################
### code chunk number 43: plotslopes10
###################################################
m6 <- lm(th.bush.kerry ~ V043250 * V041109A, data=mydta1)
plotSlopes(m6, plotx = "V043250", modx = "V041109A", plotPoints = FALSE, plotLegend = FALSE,  xlab = "Age", ylab = "Bush-Kerry Thermometer", ylim = c(-100,150), col = c("black","gray60"), llwd=c(2,3))
legend("topleft", legend = levels(mydta1$V041109A), col=c("black","gray60"), lty=c(1,2), lwd=c(2,3))


###################################################
### code chunk number 44: plotslopes20
###################################################
plotSlopes(m6, plotx = "V043250", modx = "V041109A", xlab = "Age", ylab = "Bush-Kerry Thermometer", ylim = c(-100, 150), col = c("black","gray60"), llwd = c(2,3))


###################################################
### code chunk number 45: plot22B
###################################################
m6 <- lm(th.bush.kerry~V043250 + V041109A, data=mydta1)
mycols <- c(gray(.7), rgb(0.7, 0.1, 0.1), "black", "red") 
V043250r <- range(mydta1$V043250)
newdf1 <- expand.grid(V043250 = V043250r,  V041109A = levels(mydta1$V041109A))
newdf1$fit <- predict(m6, newdata = newdf1)
plot(th.bush.kerry ~ V043250, type = "n", data = mydta1, xlab = "V043250: Age (years)", ylab = "Bush-Kerry Thermometer Differential")
points(th.bush.kerry ~ V043250, data = mydta1,  lwd = 0.6, col = ifelse(V041109A %in% c("M"), mycols[1], mycols[2]))
by(newdf1, newdf1$V041109A, function(x) lines(fit~V043250, data = x, col = mycols[2+as.numeric(x$V041109A)], lty = as.numeric(x$V041109A), lwd = 3 ))
legend("topleft", legend = c("Male", "Female"), col = mycols[3:4], lty = c(1,2), bg = "white", lwd = 3)


###################################################
### code chunk number 46: chile40
###################################################
m6 <- lm(statusquo ~ income * region + sex, data = Chile)
plotSlopes(m6, plotx = "income", modx = "sex", plotLegend = FALSE, ylim = magRange(Chile$statusquo, c(1,1.3)), llwd = c(2,2), cex = 1.0, lwd = 0.5)
legend("topleft", c("Female", "Male"), col = c(1, 2), lty = 1:2, bg = "white") 


###################################################
### code chunk number 47: chile70
###################################################
m6ps <- plotSlopes(m6, plotx = "income", modx = "region", ylim = magRange(Chile$statusquo, c(1, 1.3)), llwd = c(2, 2), cex = 1.0)
m6ps$newdata


###################################################
### code chunk number 48: numer05
###################################################
mydta1$V045117n <- as.numeric(mydta1$V045117)
mydta1$V043116n <- as.numeric(mydta1$V043116)
mydta1$V043210n <- as.numeric(mydta1$V043210)
mydta1$V043213n <- as.numeric(mydta1$V043213)
mydta1$V045145Xn <- as.numeric(mydta1$V045145X)
m3n <- lm (th.bush.kerry ~ V045117n + V043116n + V043210n + V043213n + V045145Xn + V041109A, data=mydta1) 


###################################################
### code chunk number 49: numer09 (eval = FALSE)
###################################################
## outreg(m3n, tight=FALSE, modelLabels=c("Numeric Predictors"), varLabels=list(V045117n="Ideology", V043116n="Party ID", V043210n="AntiGay", V043213n="Economy", V045145Xn="Flag Love", V041109AF="Female"))


###################################################
### code chunk number 50: numer10
###################################################
outreg(m3n, tight=FALSE, modelLabels=c("Numeric Predictors"), varLabels=list(V045117n="Ideology", V043116n="Party ID", V043210n="AntiGay", V043213n="Economy", V045145Xn="Flag Love", V041109AF="Female"))


###################################################
### code chunk number 51: numer20
###################################################
termplot(m3n, se=TRUE, partial.resid=T, terms="V045117n",xlab="V045117n: Ideology")


###################################################
### code chunk number 52: numer21
###################################################
plot(th.bush.kerry~V045117, data=mydta1)


###################################################
### code chunk number 53: numer30
###################################################
termplot(m3n, se=TRUE, partial.resid=TRUE, terms="V043116n",xlab="V043116n: Party ID")


###################################################
### code chunk number 54: numer40
###################################################
plot(th.bush.kerry~V043116, data=mydta1)


###################################################
### code chunk number 55: numer50
###################################################
anova(m3,m3n, test="F")


###################################################
### code chunk number 56: numer65
###################################################
mod2 <- lm (th.bush.kerry ~ V045117n + V043116 + V043210n + V043213n + V045145Xn + V041109A, data=mydta1) 
mod2n <- lm (th.bush.kerry ~ V045117n + V043116n + V043210n + V043213n + V045145Xn + V041109A, data=mydta1) 


###################################################
### code chunk number 57: numer69 (eval = FALSE)
###################################################
## outreg(list(mod2, mod2n), tight=FALSE, modelLabels=c("Party Factor","Numeric Predictors"), varLabels=list(V045117n="Ideology", V043116="Party ID", V043210n="AntiGay", V043213n="Economy", V045145Xn="Flag Love", V041109AF="Female"))


###################################################
### code chunk number 58: numer70
###################################################
outreg(list(mod2, mod2n), tight=FALSE, modelLabels=c("Party Factor","Numeric Predictors"), varLabels=list(V045117n="Ideology", V043116="Party ID", V043210n="AntiGay", V043213n="Economy", V045145Xn="Flag Love", V041109AF="Female"))


###################################################
### code chunk number 59: numer75
###################################################
anova(mod2, mod2n, test="F")


