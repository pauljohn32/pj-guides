### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T29852/lyx_tmpbuf0/Interaction-Categorical-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Interaction-Categorical-1-lecture.Rnw:19-20
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Interaction-Categorical-1-lecture.Rnw:79-80
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(75645)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: gend10
###################################################
library(rockchalk)
gender <- gl(2,100, labels=c("F","M"))
athletic <- ifelse(runif(200) < 0.3, 1, 0)
weight <- 100 - 15 * athletic + 40*as.numeric(gender) + 20 * athletic * (as.numeric(gender)-1) + 10*rnorm(200)
athletic <- factor(athletic, labels=c("Yes","No"))
dat <- data.frame(gender, weight, athletic)
m1 <- lm(weight~gender, data=dat)
plot(weight ~ gender, data=dat, main="")
outreg(m1, tight=F)


###################################################
### code chunk number 5: gend20
###################################################
plot.default(x=as.numeric(dat$gender)-1,y=dat$weight, main="", xlab="Gender, 0=Female, 1=Male")
contrasts(dat$gender)
abline(m1)


###################################################
### code chunk number 6: gend30
###################################################
plot.default(x=as.numeric(dat$gender)-1, y=dat$weight, main="")
termplot(m1, terms="gender", partial=T, se=T)


###################################################
### code chunk number 7: gend50
###################################################
m2 <- lm(weight~gender+athletic, data=dat)
mcGraph3(x1=as.numeric(athletic)-1, x2=as.numeric(gender)-1, y=weight, main="", drawArrows=F)
outreg(m2, tight=F)


###################################################
### code chunk number 8: gend60
###################################################
m3 <- lm(weight~gender*athletic, data=dat)
mcGraph3(x1=as.numeric(athletic)-1, x2=as.numeric(gender)-1, y=weight, interaction=T, drawArrows=F, main="")
outreg(m3, tight=F)


###################################################
### code chunk number 9: gend80
###################################################
newx <- expand.grid(gender = levels(dat$gender), athletic = levels(dat$athletic))
(newx$pred <- predict(m3, newdata = newx))
grpmeans <-  aggregate(dat$weight, by = list("gender" = dat$gender, "athletic" =  dat$athletic), FUN = mean)
grpmeans


###################################################
### code chunk number 10: gend61
###################################################
interaction.plot(dat$gender, dat$athletic, dat$weight)


###################################################
### code chunk number 11: prestige05
###################################################
library(car)
m1by <- by(Prestige, Prestige$type, function(x) {lm(prestige ~ education, data=x)})
(lapply(m1by, summary))


###################################################
### code chunk number 12: prestige11
###################################################
plot( prestige ~ education, data=Prestige, col=Prestige$type)
abline(m1by[[1]], col=1, lty=1, lwd=2)
abline(m1by[[2]], col=2, lty=2, lwd=2)
abline(m1by[[3]], col=3, lty=3, lwd=2)
legend("bottomright", legend=levels(Prestige$type), lty=1:3, col=1:3, lwd=2)


###################################################
### code chunk number 13: prestige15
###################################################
library(lme4)
lml1 <- lmList( prestige ~ education | type, data=Prestige, pool=F)
summary(lml1)


###################################################
### code chunk number 14: prestige16
###################################################
library(lme4)
lml2 <- lmList( prestige ~ education | type, data=Prestige)
summary(lml2)


###################################################
### code chunk number 15: prestige20
###################################################
plot( prestige ~ education, data=Prestige, col=Prestige$type)
lml1c <- coef(lml1)
abline(a=lml1c[1,1], b=lml1c[1,2], col=1, lty=1, lwd=2)
abline(a=lml1c[2,1], b=lml1c[2,2], col=2, lty=2, lwd=2)
abline(a=lml1c[3,1], b=lml1c[3,2], col=3, lty=3, lwd=2)
legend("bottomright", legend=levels(Prestige$type), lty=1:3, col=1:3, lwd=2)


###################################################
### code chunk number 16: prestige30
###################################################
plot( prestige ~ education, data=Prestige, col=Prestige$type)
m5 <- lm(prestige ~ education + type, data=Prestige)
nd1 <- expand.grid(education=range(Prestige$education), type=levels(Prestige$type))
nd1$pred <- predict(m5, newdata=nd1)
for(i in 1:3){
with(nd1[nd1$type %in% levels(Prestige$type)[i], ], 
lines(education, pred, col=i, lty=i, lwd=2))
}
legend("bottomright", legend=levels(Prestige$type), lty=1:3, col=1:3, lwd=2)
outreg(m5, tight=F)


###################################################
### code chunk number 17: prestige40
###################################################
plot( prestige ~ education, data=Prestige, col=Prestige$type)
m6 <- lm(prestige ~ education *type, data=Prestige)
nd2 <- expand.grid(education=range(Prestige$education), type = levels(Prestige$type))
nd2$pred <- predict(m6, newdata=nd2)
for(i in 1:3){
with(nd2[nd2$type %in% levels(nd2$type)[i], ], 
lines(education, pred, col=i, lty=i, lwd=2))
}
legend("bottomright", legend=levels(Prestige$type), lty=1:3, col=1:3, lwd=2)
outreg(m6, tight=F)


###################################################
### code chunk number 18: prestige60
###################################################
plot( prestige ~ education, data=Prestige, col=Prestige$type)
m7 <- lm(prestige ~ type / education, data=Prestige)
nd2 <- expand.grid(education=range(Prestige$education), type = levels(Prestige$type))
nd2$pred <- predict(m7, newdata=nd2)
for(i in 1:3){
with(nd2[nd2$type %in% levels(nd2$type)[i], ], 
   lines(education, pred, col=i, lty=i, lwd=2))
}
legend("bottomright", legend=levels(Prestige$type), lty=1:3, col=1:3, lwd=2)
outreg(m7, tight=F)


###################################################
### code chunk number 19: Interaction-Categorical-1-lecture.Rnw:597-598 (eval = FALSE)
###################################################
## plot( prestige ~ education, data=Prestige, col=Prestige$type)
## m7 <- lm(prestige ~ type / education, data=Prestige)
## nd2 <- expand.grid(education=range(Prestige$education), type = levels(Prestige$type))
## nd2$pred <- predict(m7, newdata=nd2)
## for(i in 1:3){
## with(nd2[nd2$type %in% levels(nd2$type)[i], ], 
##    lines(education, pred, col=i, lty=i, lwd=2))
## }
## legend("bottomright", legend=levels(Prestige$type), lty=1:3, col=1:3, lwd=2)
## outreg(m7, tight=F)


###################################################
### code chunk number 20: mc45
###################################################
m7trouble <- lm(log(prestige) ~ as.numeric(education) + as.factor(type), data=Prestige)
colnames( model.frame(m7trouble) )


###################################################
### code chunk number 21: ps10
###################################################
m6ps <- plotSlopes(m6, plotx="education", modx="type")


###################################################
### code chunk number 22: ps20
###################################################
testSlopes(m6ps)


###################################################
### code chunk number 23: ps50
###################################################
m6ps


###################################################
### code chunk number 24: mc05b
###################################################
dat <- genCorrelatedData(100, beta = c(0, 0.1, 0.1, 0), rho = 0.8, means = c(30,20), sds = c(10,10), stde = 3)
m1 <- lm(y ~ x1, data = dat)
plotSlopes(m1, plotx="x1", interval="confidence", lwd = 0.4, axes = F)
axis(1)
axis(2, pos = 0)
abline(v = 0)
box(bty = "L")


###################################################
### code chunk number 25: mc05a
###################################################
outreg(list("m1" = m1), tight = FALSE)


###################################################
### code chunk number 26: mc05d
###################################################
outreg(list("m1" = m1), tight = FALSE)


###################################################
### code chunk number 27: Interaction-Categorical-1-lecture.Rnw:765-766
###################################################
predictOMatic(m1, predVals = list("x1" = c(0, 10, 20, 30, 40)), se.fit = TRUE, interval = "confidence")


###################################################
### code chunk number 28: mc06b
###################################################
dat$x1a <- dat$x1 - 5
m2 <- lm(y ~ x1a, data = dat)
plotSlopes(m2, plotx="x1a", interval="confidence", lwd = 0.4, axes = F)
axis(1)
axis(2, pos = 0)
abline(v = 0)


###################################################
### code chunk number 29: mc06a
###################################################
outreg(list("m2" = m2), tight = FALSE)


###################################################
### code chunk number 30: mc07b
###################################################
dat$x1b <- dat$x1 - 15
m3 <- lm(y ~ x1b, data = dat)
plotSlopes(m3, plotx="x1b", interval="confidence", lwd = 0.4,axes = F)
axis(1)
axis(2, pos = 0)
abline(v=0)


###################################################
### code chunk number 31: mc07a
###################################################
outreg(list("m3" = m3), tight = FALSE)


###################################################
### code chunk number 32: mc08b
###################################################
dat$x1b <- dat$x1 - mean(dat$x1, na.rm = TRUE)
m4 <- lm(y ~ x1b, data = dat)
plotSlopes(m4, plotx="x1b", interval="confidence", lwd = 0.4, axes=FALSE)
axis(1)
axis(2, pos = 0)
abline(v = 0)


###################################################
### code chunk number 33: mc08a
###################################################
outreg(list("m4" = m4), tight = FALSE)


###################################################
### code chunk number 34: mc100
###################################################
m1 <- lm(prestige ~ education * type, data = Prestige)
m1c <- meanCenter(m1)
outreg(list("Not Centered" = m1, "Centered" = m1c), tight = FALSE)


###################################################
### code chunk number 35: center1 (eval = FALSE)
###################################################
## Prestige$educcenter <- Prestige$education - mean(Prestige$education, na.rm=TRUE)
## m1 <- lm(prestige ~ education * type, data = Prestige)
## m2 <- lm(prestige ~ educcenter * type, data = Prestige)
## outreg(list("Not Centered" = m1, "Centered Wrongly" = m2), tight = FALSE)


###################################################
### code chunk number 36: Interaction-Categorical-1-lecture.Rnw:913-914
###################################################
Prestige$educcenter <- Prestige$education - mean(Prestige$education, na.rm=TRUE)
m1 <- lm(prestige ~ education * type, data = Prestige)
m2 <- lm(prestige ~ educcenter * type, data = Prestige)
outreg(list("Not Centered" = m1, "Centered Wrongly" = m2), tight = FALSE)


###################################################
### code chunk number 37: center2 (eval = FALSE)
###################################################
## m1mf <- model.frame(m1)
## m1mf[ , "education"] <- m1mf[, "education"] - mean(m1mf[ , "education"], na.rm = TRUE) 
## m3 <- lm( prestige ~ education * type, data=m1mf)
## summary(m3)


###################################################
### code chunk number 38: mc10
###################################################
m1mc <- meanCenter(m1)
summary(m1mc)


###################################################
### code chunk number 39: center10 (eval = FALSE)
###################################################
## outreg(list(m1,m2,m1mc), tight=F, modelLabels=c("Not Centered","Centered Wrongly", "meanCenter"))


###################################################
### code chunk number 40: center11
###################################################
outreg(list(m1,m2,m1mc), tight=F, modelLabels=c("Not Centered","Centered Wrongly", "meanCenter"))


###################################################
### code chunk number 41: Interaction-Categorical-1-lecture.Rnw:988-990
###################################################
predictOMatic(m1, predVals = c("education"))
predictOMatic(m2, predVals = c("educcenter"))


###################################################
### code chunk number 42: Interaction-Categorical-1-lecture.Rnw:997-998
###################################################
predictOMatic(m1mc, predVals = c("educationc"))


###################################################
### code chunk number 43: center20
###################################################
preds <- data.frame(m1 = predict(m1), m2 = predict(m2), m1mc = predict(m1mc))
plot(preds)


###################################################
### code chunk number 44: center30
###################################################
anova(m2, m1, m1mc, test = "F")


###################################################
### code chunk number 45: center31
###################################################
plotSlopes(m1mc, plotx="educationc", modx="type", modxVals = c("wc","prof"), interval = "confidence")


