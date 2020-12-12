### R code from vignette source 'Regression-Overview-Lecture-uniquebackupstring202008241407.Rnw'

###################################################
### code chunk number 1: Regression-Overview-Lecture-uniquebackupstring202008241407.Rnw:23-24
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Regression-Overview-Lecture-uniquebackupstring202008241407.Rnw:75-77
###################################################
# unlink("plots", recursive=T)
if (!dir.exists("plots")) dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: oregon0
###################################################
dat <- read.table("~/GIT/pj-guides/stat/DataSets/OregonTemps/ortann.csv", header=T, sep=",")
mod1 <- lm (tann ~ elevation, data=dat)
summary(mod1)
library(foreign)
##write.dta(dat,file="ortann.dta")


###################################################
### code chunk number 5: oregon10
###################################################
plot(tann ~ elevation, data=dat, xlab="Elevation above sea level", ylab="Annual Average Temperature",main="")


###################################################
### code chunk number 6: oregon20
###################################################
plot(tann ~ elevation, data=dat, xlab="Elevation above sea level", ylab="Annual Average Temperature",main="")
abline(mod1)


###################################################
### code chunk number 7: Regression-Overview-Lecture-uniquebackupstring202008241407.Rnw:201-205
###################################################
library(rockchalk)
dat$elevper1000 <- dat$elevation/1000
mod2 <- lm (tann ~ elevper1000, data = dat)
outreg(mod2, tight=F, varLabels = list(elevper1000="elevation (1000s feet)"))


###################################################
### code chunk number 8: outl10
###################################################
x<- rnorm(300, m=50, s=10)
y <- 5+ 5*x + 18*rnorm(300, m=0, s=1)
x[301:320] <- 30 + rnorm(20, m=0, s=4)
y[301:320] <- 400 + rnorm(20, m=0, s=6)
plot(y~x, xlab="X", ylab="Y", main="")
mod1 <- lm(y~x)
summary(mod1)


###################################################
### code chunk number 9: outl20
###################################################
plot(y~x, type="n", xlab="X", ylab="Y", main="")
points(x,y, col=gray(.80))
abline(mod1)


###################################################
### code chunk number 10: UN10
###################################################
library(carData)
data(UN)
plot(infantMortality ~ ppgdp, data=UN, xlab="Gross Domestic Product (UN)", ylab="Infant Mortality (per 1000 births)", main="")
unmod <- lm(infantMortality ~ ppgdp, data=UN)


###################################################
### code chunk number 11: UN20
###################################################
plot(infantMortality ~ ppgdp, data=UN, xlab="Gross Domestic Product (UN)", ylab="Infant Mortality (per 1000 births)", main="")
abline(unmod)


###################################################
### code chunk number 12: UN40
###################################################
lppgdp <- log(UN$ppgdp)
lim <- log(UN$infantMortality)
plot(lim ~ lppgdp, xlab="Log of Gross Domestic Product (UN)", ylab="Log of Infant Mortality (per 1000 births)", main="")


###################################################
### code chunk number 13: UN50
###################################################
lppgdp <- log(UN$ppgdp)
lim <- log(UN$infantMortality)
plot(lim ~ lppgdp, xlab="Log of Gross Domestic Product (UN)", ylab="Log of Infant Mortality (per 1000 births)", main="")
unmod2 <- lm(lim ~ lppgdp, data=UN)
abline(unmod2)


###################################################
### code chunk number 14: UN70
###################################################
lppgdp <- log(UN$ppgdp)
lim <- log(UN$infantMortality)
UN <- na.omit(UN)
nmod2 <- nls(infantMortality  ~  A + B/(ppgdp^C), data=UN, start=list(A=10,B=21,C=1/10), control=nls.control(warnOnly=TRUE))
plot(infantMortality ~ ppgdp, data=UN, xlab="Gross Domestic Product (UN)", ylab="Infant Mortality (per 1000 births)", main="", type="n")
points(UN$ppgdp, UN$infantMortality, col=gray(.7))
summary(nmod2)
rppgdp <- range(UN$ppgdp)
ppgdp2 <- seq(rppgdp[1],rppgdp[2],length=100)
p2 <- predict(nmod2, newdata=data.frame(ppgdp=ppgdp2))
lines(ppgdp2, p2)


###################################################
### code chunk number 15: PE10
###################################################
dat <- read.table("~/GIT/pj-guides/stat/DataSets/PublicSpending/publicspending.txt", header=T)
plot(EX  ~  YOUNG, data=dat, xlab="Percentage of Population 5-19 Years", ylab="Public Expenditures (Per Capita, 1960)")
pemod <- lm(EX ~ YOUNG, data=dat)


###################################################
### code chunk number 16: PE20
###################################################
plot(EX  ~  YOUNG, data=dat, xlab="Percentage of Population 5-19 Years",ylab="Public Expenditures (Per Capita, 1960)")
abline(pemod)


###################################################
### code chunk number 17: PE40
###################################################
plot(EX  ~  MET, data=dat, xlab="Metropolitan Population (%)",ylab="Public Expenditures (Per Capita, 1960)")
pemod2 <- lm(EX ~ MET, data=dat)
abline(pemod2)


###################################################
### code chunk number 18: PE42
###################################################
plot(EX  ~  MET, data=dat, xlab="Metropolitan Population (%)",ylab="Public Expenditures (Per Capita, 1960)")
pemod3 <- lm(EX ~ poly(MET,2), data=dat)
rmet <- range(dat$MET)
smet <- seq( rmet[1], rmet[2], length.out=100)
polypred <- predict(pemod3, newdata=data.frame(MET=smet))
lines(smet, polypred)


###################################################
### code chunk number 19: PE71
###################################################
dat$fWEST <- factor(dat$WEST, labels=c("East","West")) 
pemod4 <- lm(EX ~ fWEST, data=dat)
termplot(pemod4, terms=c("fWEST"), partial.resid=T, xlab="Region (categorical)",ylab="Public Expenditures (Per Capita, 1960)")


###################################################
### code chunk number 20: LOGIT10
###################################################
x <- runif(500, -10,100)
y <- -0.8 + 0.079 * x
prob <- 1/(1+ exp(-y))
yobs <- rbinom(500, p=prob, size=1)
yobsf <- factor(yobs, labels=c("No","Yes"))
plot(x, as.numeric(yobsf)-1, xlab="Socio Economic Status", ylab="Will Vote for Republican", axes=F, ylim=c(-0.3,1.3))
axis(1)
axis(2, at=c(0,1), labels=c("No","Yes"))


###################################################
### code chunk number 21: LOGIT20
###################################################
plot(x,yobs, xlab="Socio Economic Status", ylab="Will Vote for Republican", axes=F, ylim=c(-0.3,1.3), col="gray80")
axis(1)
axis(2, at=c(0,0.5,1), labels=c("No","0.5","Yes"))
rx <- range(x)
seqx <- seq(rx[1],rx[2], length.out=100)
pry <- 1/(1+exp(0.8 - 0.079*seqx))
lines(seqx, pry)


###################################################
### code chunk number 22: PE72
###################################################
mod3 <- lm(EX  ~  ECAB + poly(MET,2)+YOUNG, data=dat)
plotPlane(mod3, plotx1="MET", plotx2="ECAB")


###################################################
### code chunk number 23: Regression-Overview-Lecture-uniquebackupstring202008241407.Rnw:523-524
###################################################
outreg(mod3, tight=F)


