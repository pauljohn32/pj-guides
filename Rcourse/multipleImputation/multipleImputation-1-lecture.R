### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T25552/lyx_tmpbuf2/multipleImputation-1-lecture.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: multipleImputation-1-lecture.Rnw:24-25
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: multipleImputation-1-lecture.Rnw:81-82
###################################################
dir.create("plots", showWarnings=T)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=180, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: amelia10
###################################################
options(digits=2)
if (!file.exists("examples")) dir.create("examples")
if (!file.exists("examples/titanic.txt"))
download.file("http://lib.stat.cmu.edu/S/Harrell/data/ascii/titanic.txt", "examples/titanic.txt")
titanic <- read.table("examples/titanic.txt", sep = ',', header = TRUE)
titanic0 <- titanic
save(titanic0, file="examples/titanic0.rda")
set.seed(4321)
titanic$sex[sample(nrow(titanic), 10)] <- NA 
titanic$pclass[sample(nrow(titanic), 10)] <- NA 
titanic$survived[sample(nrow(titanic), 10)] <- NA


###################################################
### code chunk number 5: amelia11
###################################################
fullglm <- glm(survived ~ pclass + sex + age, family = binomial, data = titanic0)
library(xtable)
tout <- xtable(fullglm)
print(tout, type = "latex")


###################################################
### code chunk number 6: amelia12
###################################################
ldglm <- glm(survived ~ pclass + sex + age, family = binomial, data = titanic)
library(xtable)
tout <- xtable(ldglm)
print(tout, type = "latex")


###################################################
### code chunk number 7: amelia20
###################################################
library(Amelia) # generate multiple imputations 
titanic.amelia <- amelia(subset(titanic, select = c('survived', 'pclass', 'sex', 'age', 'embarked')), m = 10,  noms = c('survived', 'pclass', 'sex', 'embarked'), 
emburn = c(500, 500), p2s = F)


###################################################
### code chunk number 8: amelia30
###################################################
allimplogreg <- lapply(titanic.amelia$imputations, function(x){
    glm(survived ~ pclass + sex + age, family = binomial, data = x)
})


###################################################
### code chunk number 9: amelia40
###################################################
options(digits=2)
library(mitools) # MIextract
betas <- MIextract(allimplogreg, fun = coef)
vars <- MIextract(allimplogreg, fun = vcov)
summary(MIcombine(betas, vars))


###################################################
### code chunk number 10: amelia50
###################################################
library(mix)
se.glm <- MIextract(allimplogreg, fun = function(x){sqrt(diag(vcov(x)))}) 
as.data.frame(mi.inference(betas, se.glm))


###################################################
### code chunk number 11: amelia60
###################################################
df1 <- as.data.frame(mi.inference(betas, se.glm))
df2 <- cbind(df1[,1:2], ldbeta = coef(ldglm), ldse = sqrt(diag(vcov(ldglm))))
df2


###################################################
### code chunk number 12: amelia100
###################################################
set.seed(234234)
titanic <- titanic0
titanic$sex[sample(nrow(titanic), 400)] <- NA 
titanic$pclass[sample(nrow(titanic), 400)] <- NA 
titanic$survived[sample(nrow(titanic), 400)] <- NA


###################################################
### code chunk number 13: amelia111
###################################################
ldglm <- glm(survived ~ pclass + sex + age, family =binomial, data = titanic)
library(xtable)
tout <- xtable(ldglm)
print(tout, type = "latex")


###################################################
### code chunk number 14: amelia120
###################################################
titanic.amelia <- amelia(subset(titanic,select=c('survived', 'pclass', 'sex', 'age', 'embarked')), m = 10,  noms = c('survived', 'pclass', 'sex', 'embarked'), emburn = c(500,500), p2s = F)


###################################################
### code chunk number 15: amelia130
###################################################
 allimplogreg <- lapply(titanic.amelia$imputations, function(x){glm(survived ~ pclass + sex + age, family=binomial, data = x)})


###################################################
### code chunk number 16: amelia140
###################################################
options(digits = 2)
library(mitools) # MIextract
betas <- MIextract(allimplogreg, fun = coef)
vars <- MIextract(allimplogreg, fun = vcov)
se.glm <- MIextract(allimplogreg, fun = function(x){sqrt(diag(vcov(x)))}) 


###################################################
### code chunk number 17: amelia150
###################################################
summary(MIcombine(betas,vars))


###################################################
### code chunk number 18: amelia160
###################################################
df2.1 <- as.data.frame(mi.inference(betas, se.glm))
df2.2 <- cbind("MI",df2.1[,1:2], "LD", ldbeta = coef(ldglm), ldse = sqrt(diag(vcov(ldglm))), "full", est = coef(fullglm))
df2.2


###################################################
### code chunk number 19: amelia180
###################################################
df2.1 <- as.data.frame(mi.inference(betas, se.glm))
df3 <- cbind(df2.1[,c(1,5:6)], "full", beta = coef(fullglm), confint(fullglm))
df3


###################################################
### code chunk number 20: amelia190
###################################################
options(digits=2)
df4 <- cbind("LDbeta" = coef(ldglm),confint(ldglm))
df4


###################################################
### code chunk number 21: mice10
###################################################
library(mice)
nhanes


###################################################
### code chunk number 22: mice11
###################################################
imp <- mice(nhanes, printFlag = FALSE) 
fit <- with(data = imp, exp = lm(bmi ~ hyp + chl))
fitpool <- pool(fit)
fitpool


###################################################
### code chunk number 23: multipleImputation-1-lecture.Rnw:669-670 (eval = FALSE)
###################################################
## fit <- list(call = call, call1 = object$call, call2 = object$call1, nmis = object$nmis, m = m, qhat = qhat, u = u, qbar = qbar, ubar = ubar, b = b, t = t, r = r, dfcom = dfcom, df = df,         fmi = fmi, lambda = lambda)


###################################################
### code chunk number 24: mice15
###################################################
round(summary(pool(fit))[,c(1:4,6:9)],2)


###################################################
### code chunk number 25: mice40
###################################################
nhanesf <- nhanes
nhanesf$age <- factor(nhanesf$age, labels = c("20-39", "40-59", "60-99"))
nhanesf$hyp <- factor(nhanesf$hyp, labels = c("no","yes"))
imp2 <- mice(nhanes, printFlag = FALSE) 
fit2 <- with(data = imp2, exp = lm(bmi~hyp+chl))
pool(fit2)


###################################################
### code chunk number 26: mice45
###################################################
cbind("F", nhanes,"imp1",complete(imp2,3),"imp2",complete(imp,3))


###################################################
### code chunk number 27: mice70
###################################################
load("/home/pauljohn/SVN/SVN-guides/Rcourse/DataSets/titanic0.rda")
set.seed(234234)
titanic <- titanic0
titanic$sex[sample(nrow(titanic), 400)] <- NA 
titanic$pclass[sample(nrow(titanic), 400)] <- NA 
titanic$survived[sample(nrow(titanic), 400)] <- NA
miceTitanic <- mice( subset( titanic, select = c('survived', 'pclass', 'sex', 'age', 'embarked')), m = 10, maxit  = 10, printFlag=FALSE) 
miceFitTitanic <- with(data = miceTitanic, exp = glm(survived ~ pclass + sex + age, family = binomial))
pool(miceFitTitanic)


###################################################
### code chunk number 28: mice75
###################################################
round(summary(pool(miceFitTitanic)), 2)


###################################################
### code chunk number 29: multipleImputation-1-lecture.Rnw:883-885
###################################################
library(mi)
library(mice)


###################################################
### code chunk number 30: mi00
###################################################
inf <- mi.info(nhanes2)
inf


###################################################
### code chunk number 31: mi01 (eval = FALSE)
###################################################
## miImputeNhanes2 <- mi(nhanes2, info = inf , n.imp = 8,  n.iter = 500, add.noise = FALSE)


###################################################
### code chunk number 32: mi02
###################################################
miImputeNhanes2 <- mi(nhanes2, info = inf , n.imp = 8,  n.iter = 500, add.noise = FALSE)


###################################################
### code chunk number 33: mi04
###################################################
M1 <- lm.mi(bmi ~ hyp + chl, miImputeNhanes2)
display(M1)
cbind(b=coef(M1), se=se.coef(M1), t=coef(M1)/se.coef(M1))


###################################################
### code chunk number 34: mi10
###################################################
load("/home/pauljohn/SVN/SVN-guides/Rcourse/DataSets/titanic0.rda")
set.seed(234234) 
titanic <- titanic0 
titanic$sex[sample(nrow(titanic), 400)] <- NA  
titanic$pclass[sample(nrow(titanic), 400)] <- NA  
titanic$survived[sample(nrow(titanic), 400)] <- NA 


###################################################
### code chunk number 35: mi20
###################################################
ss <- subset( titanic,   select = c('survived', 'pclass', 'sex', 'age'))  
inf <- mi.info(ss)
inf


###################################################
### code chunk number 36: mi30 (eval = FALSE)
###################################################
## miImpTitanic <- mi(ss, info = inf, n.imp = 10,  n.iter = 400, add.noise = FALSE)


###################################################
### code chunk number 37: mi31
###################################################
miImpTitanic <- mi(ss, info = inf, n.imp = 10,  n.iter = 400, add.noise = FALSE)


###################################################
### code chunk number 38: mi40
###################################################
M2 <- glm.mi( survived ~ pclass + sex + age, miImpTitanic, family = binomial(link = "logit"))  
display(M2)


###################################################
### code chunk number 39: mi50
###################################################
(miTitanicResult <- cbind(b = coef(M2), se = se.coef(M2), t = coef(M2)/se.coef(M2)))


###################################################
### code chunk number 40: rms10
###################################################
library(rms)
## Not run: 
print(paste("f <- aregImpute(~ age + bmi + hyp + chl, data=nhanesf, nk=0)"))
## End(Not run)


###################################################
### code chunk number 41: rms20
###################################################
cat("fmi <- fit.mult.impute(bmi ~ hyp + chl, lm, f, data= nhanesf)")
cat("sqrt(diag(vcov(fmi)))")


###################################################
### code chunk number 42: rms60
###################################################
load("/home/pauljohn/SVN/SVN-guides/Rcourse/DataSets/titanic0.rda")
set.seed(234234)
titanic <- titanic0
titanic$sex[sample(nrow(titanic), 400)] <- NA 
titanic$pclass[sample(nrow(titanic), 400)] <- NA 
titanic$survived[sample(nrow(titanic), 400)] <- NA
rmsImputeTitanic <- aregImpute(~ survived + pclass + sex + age + embarked, n.impute=10, data=titanic, nk=3)


###################################################
### code chunk number 43: rms80
###################################################
rmsFmiTitanic <- fit.mult.impute( survived ~ pclass + sex + age, glm, family=binomial(link=logit), rmsImputeTitanic, data= titanic, fit.reps=TRUE)
summary(rmsFmiTitanic)


###################################################
### code chunk number 44: rms90
###################################################
sqrt(diag(vcov(rmsFmiTitanic)))
(rmsTitanicResult <- cbind(b=rmsFmiTitanic$coefficients, se=diag(vcov(rmsFmiTitanic))))


###################################################
### code chunk number 45: rms91
###################################################
require(mitools)
rmsbetas <- MIextract(rmsFmiTitanic$fits, fun=coef)
rmsvars <- MIextract(rmsFmiTitanic$fits, fun=vcov)
rmsTitanicMItools <- summary(MIcombine(rmsbetas,rmsvars))


###################################################
### code chunk number 46: rms100
###################################################
for(i in 1:length(rmsFmiTitanic$fits)) print(summary(rmsFmiTitanic$fits[[i]]))


###################################################
### code chunk number 47: rms110
###################################################
fmi2 <- fit.mult.impute( survived ~ pclass + sex + age, lrm, rmsImputeTitanic, data= titanic, fit.reps=TRUE)
fmi2


###################################################
### code chunk number 48: rms120
###################################################
d <- datadist(titanic)
options(datadist="d")
summary(fmi2)


###################################################
### code chunk number 49: mi300
###################################################
cbind("Amelia"="Amelia",df1[ , 1:2 ], "rms"="rms", rmsTitanicMItools[,1:2])
cbind( "mi"="mi", round(miTitanicResult,2),  "mice"="mice", round(summary(pool(miceFitTitanic)),2)[,1:3])


###################################################
### code chunk number 50: mi1000
###################################################
save.image(file = "/tmp/ws.rda")


