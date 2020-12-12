### R code from vignette source 'LogitExample-1-guide-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: LogitExample-1-guide-uniquebackupstring.Rnw:50-51
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: tmpout
###################################################
if(!dir.exists("tmpout")) dir.create("tmpout", showWarnings=FALSE)


###################################################
### code chunk number 3: Roptions
###################################################
opts.orig <- options()
options(width=90, prompt="> ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
options(SweaveHooks=list(fig=function() par(ps=10)))
pdf.options(onefile=FALSE,family="Times",pointsize=10)


###################################################
### code chunk number 4: 2a
###################################################
url <- "http://pj.freefaculty.org/DataSets/ANES/2002/PJTEST.sasxport"
fn <- "anes2002.sasxport"
if(!file.exists(fn)){
    download.file(url, mode="wb", destfile="anes2002.sasxport")
}


###################################################
### code chunk number 5: LogitExample-1-guide-uniquebackupstring.Rnw:409-411
###################################################
library(foreign) 
nes2002 <- read.xport(fn)


###################################################
### code chunk number 6: LogitExample-1-guide-uniquebackupstring.Rnw:421-422
###################################################
str(nes2002)


###################################################
### code chunk number 7: rec10
###################################################
nes2002$bushvotef <- factor(nes2002$V023111, levels = c(1, 3), labels = c("Gore", "Bush"))
table(nes2002$bushvote, nes2002$V023111, exclude = NULL)


###################################################
### code chunk number 8: rec15
###################################################
nes2002$bushvote <- ifelse(nes2002$bushvotef == "Bush", 1, 0)
table(nes2002$bushvote, nes2002$V023111)


###################################################
### code chunk number 9: rec20
###################################################
nes2002$partyid <- factor(nes2002$V023036, levels = c(3,1, 2), labels = c("I", "D", "R"))
table(nes2002$partyid, nes2002$V023036, exclude = NULL)


###################################################
### code chunk number 10: rec30
###################################################
nes2002$democ <- ifelse(nes2002$partyid == "D", 1, 0)
table(nes2002$democ, nes2002$partyid, exclude = NULL)
nes2002$repub <-ifelse(nes2002$partyid == "R", 1, 0)
table(nes2002$repub, nes2002$partyid, exclude = NULL, dnn = list("repub", "partyid"))


###################################################
### code chunk number 11: rec31
###################################################
nes2002$democ <- 0
nes2002$democ[!is.na(nes2002$partyid) & nes2002$partyid == "D"] <- 1
table(nes2002$democ, nes2002$partyid, exclude = NULL)
nes2002$repub <- 0
nes2002$repub[!is.na(nes2002$partyid) & nes2002$partyid == "R"] <- 1
table(nes2002$repub, nes2002$partyid, exclude = NULL, dnn = list("repub", "partyid"))


###################################################
### code chunk number 12: rec50
###################################################
nes2002$ideolf <- factor(nes2002$V023022, levels = 1:7, labels = c("EL", "L", "SL", "M", "SC", "C", "EC"))
table("ideology factor" = nes2002$ideolf, "original ideology" = nes2002$V023022, exclude = NULL)
nes2002$ideolo <- factor(nes2002$V023022, levels = 1:7, labels = c("EL", "L", "SL", "M", "SC", "C", "EC"), ordered = TRUE)


###################################################
### code chunk number 13: rec52
###################################################
nes2002$ideoln <- as.numeric(nes2002$ideolf) # converts to 1 thru 7
table(nes2002$ideolf, nes2002$ideoln, dnn = list("factor version", "ideology: numeric version"), exclude = NULL)


###################################################
### code chunk number 14: LogitExample-1-guide-uniquebackupstring.Rnw:629-640
###################################################
## Categorical, unordered
nes2002$educf <- factor(nes2002$V023131, levels = 1:7, 
        labels = c("Elem.","Some HS","HS","Some coll.","AA","BA","Grad"))
## Ordered categories
nes2002$educo <- factor(nes2002$V023131, levels = 1:7, 
        labels = c("Elem.","Some HS","HS","Some coll.","AA","BA","Grad"),
        ordered = TRUE)
## Numeric
nes2002$educn <- nes2002$V023131
table("Education(ordered)" = nes2002$educo, 
      "Education (orig)" = nes2002$V023131, exclude = NULL)


###################################################
### code chunk number 15: LogitExample-1-guide-uniquebackupstring.Rnw:644-650
###################################################
nes2002$usecono <- factor(nes2002$V023027, levels = c(1, 3, 5),  
        labels = c("Better", "Same", "Worse"),
        ordered = TRUE)
nes2002$useconn <- nes2002$V023027
table("US Econ(ordered)" = nes2002$usecono, 
      "US Econ (orig)" = nes2002$V023027, exclude = NULL)


###################################################
### code chunk number 16: 3b
###################################################
plot(nes2002$ideoln, nes2002$bushvote, ylim=c(0,1), xlab="Ideology (numeric)", ylab="Vote (Bush=1, Gore=0)")


###################################################
### code chunk number 17: 3c
###################################################
ols1 <- lm(bushvote ~ ideoln, data=nes2002) 
summary(ols1)


###################################################
### code chunk number 18: 3d
###################################################
with(nes2002, plot(jitter(ideoln), jitter(bushvote), ylim=c(-0.2, 1.2), 
   xlab="Ideology (numeric)", ylab="Vote (Bush=1,Gore=0)"))
nd <- data.frame(ideoln = 1:7)
nd$fit <- predict(ols1, newdata = nd)
lines(nd$ideoln, nd$fit)


###################################################
### code chunk number 19: 3e
###################################################
bushideoglm1 <- glm(bushvote ~ ideoln, family=binomial, data=nes2002) 
summary(bushideoglm1)


###################################################
### code chunk number 20: 3e2
###################################################
library(memisc)
library(rockchalk)


###################################################
### code chunk number 21: 3f
###################################################
toLatex(mtable(bushideoglm1))


###################################################
### code chunk number 22: vl
###################################################
vl = c("ideoln" = "Ideology", "ideolf" = "Ideology", 
       "ideolo" = "Ideology", "repub" = "Repub.", 
       "democ" = "Democ.", "V023010" = "Bush Therm",
       "useconn" = "US economy", "usecono" = "US economy",
       "educn" = "Education", educo = "Education", educf = "Education",
       "partyidD" = "Party Dem.", "partyidR" = "Party Rep.",
       "ideolo^4" = "ideolo.4", "ideolo^5" = "ideolo.5",
       "ideolo^6" = "ideolo.6")


###################################################
### code chunk number 23: 3g
###################################################

outreg(bushideoglm1, tight=F, varLab = vl)


###################################################
### code chunk number 24: 52
###################################################
nd <- data.frame(ideoln = 1:7)
pp3 <-predict(bushideoglm1, newdata=nd, type="response", se.fit=T)
pp3


###################################################
### code chunk number 25: LogitExample-1-guide-uniquebackupstring.Rnw:858-867
###################################################
plot(bushvote ~ ideoln, data=nes2002, ylim=c(0,1), xlab="Ideology(numeric)", ylab="Vote (Bush=1, Gore=0)", main="Predicted Probabilities from Logistic Regression")
pp3 <- predict(bushideoglm1, newdata=nd, se.fit=T)
pp3$upr <- pp3$fit + 1.96*pp3$se.fit
pp3$lwr <- pp3$fit - 1.96*pp3$se.fit
pp3logistic <- lapply(pp3, plogis)
pp3logistic
lines(1:7, pp3logistic$fit)
lines(1:7, pp3logistic$lwr, lty=4)
lines(1:7, pp3logistic$upr, lty=4)


###################################################
### code chunk number 26: pm10
###################################################
predictOMatic(bushideoglm1, predVals = list(ideoln=1:7), interval="confidence")


###################################################
### code chunk number 27: pm20
###################################################
plotCurves(bushideoglm1, plotx=ideoln, interval="confidence", ylim = c(0, 1.2))


###################################################
### code chunk number 28: LogitExample-1-guide-uniquebackupstring.Rnw:943-946
###################################################
#start adding variables 
bushideoglm2 <- glm(bushvote ~ ideoln + repub + democ, family=binomial, data=nes2002) 
summary(bushideoglm2)


###################################################
### code chunk number 29: 622
###################################################
lnth <- length(nes2002$ideoln) 
newdfD1 <-data.frame(ideoln=seq(1,7), repub=0, democ=1)
newdfD1
predvalsD1 <- predict(bushideoglm2, newdata=newdfD1, type="response")
newdfR1 <-data.frame(ideoln=seq(1,7), repub=1, democ=0)
newdfR1
predvalsR1 <- predict(bushideoglm2, newdata=newdfR1, type="response")
newdfI1 <-data.frame(ideoln=seq(1,7), repub=0, democ=0)
predvalsI1 <- predict(bushideoglm2, newdata=newdfI1, type="response")


###################################################
### code chunk number 30: 623
###################################################
plot(seq(1,7), predvalsD1, type="n", ylim=c(0,1), xlim=c(0,8), xlab="ideoln: ideology", ylab="Vote (Bush=1, Gore=0)") 
text(seq(1,7), predvalsR1, labels=rep("r",7))
text(seq(1,7), predvalsD1, labels=rep("d",7))
text(seq(1,7), predvalsI1, labels=rep("i",7))
lines(seq(1,7), predvalsR1, type="c")
lines(seq(1,7), predvalsD1, type="c")
lines(seq(1,7), predvalsI1, type="c")


###################################################
### code chunk number 31: ideol200
###################################################
bushideoglm3 <- glm(bushvote ~ ideoln + partyid, family=binomial, data=nes2002) 
summary(bushideoglm3)


###################################################
### code chunk number 32: ideol210
###################################################
predictOMatic(bushideoglm3, predVals = list(ideoln=1:7, partyid = c("I", "D", "R")))


###################################################
### code chunk number 33: ideol220
###################################################
plotCurves(bushideoglm3, plotx=ideoln, modx=partyid, ylim = c(0, 1.3),
            xlab = "Ideology(numeric)", ylab = "Vote(Bush=1, Gore=0)")


###################################################
### code chunk number 34: ideol240
###################################################
bushideoglm4 <- glm(bushvote ~ ideoln * partyid, family=binomial, data=nes2002) 
summary(bushideoglm4)


###################################################
### code chunk number 35: ideol250
###################################################
plotCurves(bushideoglm4, plotx=ideoln, modx=partyid, ylim = c(0, 1.3), xlab = "Ideology(numeric)", ylab = "Vote(Bush=1, Gore=0)")


###################################################
### code chunk number 36: ideol260
###################################################
predictOMatic(bushideoglm3, predVals = list(ideoln=1:7, partyid = c("I", "D", "R")), type = "link")


###################################################
### code chunk number 37: ideol300
###################################################
plotCurves(bushideoglm4, plotx=ideoln, modx=partyid,
            xlab="Ideology(numeric)", ylab="Linear predictor: XB",
            type="link", plotPoints=FALSE, ylim = c(-4,4))


###################################################
### code chunk number 38: bushtherm
###################################################
hist(nes2002$V023010, prob=T, xlab = "Bush Feeling Thermometer", breaks = seq(0, 100, by = 5), main="")


###################################################
### code chunk number 39: olsthermoreg
###################################################
olsthermo1 <- lm(bushvote ~ V023010, data=nes2002) 
summary(olsthermo1)


###################################################
### code chunk number 40: 6122
###################################################
glmthermo1 <- glm(bushvote ~ V023010, data=nes2002, family=binomial) 
summary(glmthermo1) 


###################################################
### code chunk number 41: 6122
###################################################
glmthermo2 <- glm(bushvote ~ V023010, data=nes2002, family=binomial(link=probit))


###################################################
### code chunk number 42: 6123
###################################################
outreg(list("OLS" = olsthermo1, "Logistic" = glmthermo1, "Probit" = glmthermo2), tight=FALSE, varLab = vl)


###################################################
### code chunk number 43: 6124
###################################################
nd <- data.frame(V023010 =seq(0,100))
nd$glmpred1 <- predict(glmthermo1, newdata=nd, type="response")
nd$olspred1 <- predict(olsthermo1, newdata=nd)
plot(nes2002$V023010, nes2002$bushvote, ylim=c(-0.2,1.2), xlim=c(0,100), xlab="Bush Thermometer", ylab="Predicted Probability of Bush Vote")
lines(glmpred1 ~ V023010, data = nd, lty = 1)
lines(olspred1 ~ V023010, data = nd, lty = 2)
legend("left", legend = c("OLS", "Logistic"), lty = c(2,1))


###################################################
### code chunk number 44: 66
###################################################
bushlogit5 <- glm(bushvote ~ V023010 + ideoln + partyid + useconn + educn , data=nes2002, family=binomial(link=logit), model=TRUE)
summary(bushlogit5)


###################################################
### code chunk number 45: glm5outreg
###################################################
outreg(list("Full Model" = bushlogit5), tight=F, varLab = vl)


###################################################
### code chunk number 46: glm5outreg2
###################################################
outreg(list("Full Model"=bushlogit5, "Ideology Only"=bushideoglm1,
"Ideol. Party Dummies" = bushideoglm2, "Ideol. w/party id" = bushideoglm3, "Interaction" = bushideoglm4), 
tight=T, varLab = vl)


###################################################
### code chunk number 47: bush5b1
###################################################
bushlogit5b <- glm(bushvote ~ V023010 + ideoln + educn, 
data=model.frame(bushlogit5), family=binomial(link=logit), model=TRUE)


###################################################
### code chunk number 48: bush5b2
###################################################
anova(bushlogit5, bushlogit5b, test = "Chisq")


###################################################
### code chunk number 49: 811
###################################################
bushlogit6 <- glm(bushvote ~ V023010 + ideoln + partyid + useconn  + educf, data=nes2002, family=binomial(link=logit), model=TRUE)
summary(bushlogit6)


###################################################
### code chunk number 50: 812
###################################################
drop1(bushlogit6, test="Chisq")


###################################################
### code chunk number 51: 821
###################################################
termplot(bushlogit6, terms="educf")


###################################################
### code chunk number 52: glm6anova
###################################################
anova(bushlogit5, bushlogit6, test="Chisq")


###################################################
### code chunk number 53: 840
###################################################
nes2002$educf2 <- combineLevels(nes2002$educf, levs=c(5,6,7),  "Higher Ed")
table("educ: reduced" = nes2002$educf2, "educ: 7 categories" = nes2002$educf, exclude = NULL)
bushlogit6c <- glm(bushvote ~ V023010 + ideoln + partyid + educf2 + useconn, data=nes2002, family=binomial(link=logit))
summary(bushlogit6c)


###################################################
### code chunk number 54: 850
###################################################
anova(bushlogit6c, bushlogit6, test="Chisq")


###################################################
### code chunk number 55: LogitExample-1-guide-uniquebackupstring.Rnw:1357-1358
###################################################
drop1(bushlogit6c, test="Chisq")


###################################################
### code chunk number 56: 822
###################################################
bushideolrm7f <- glm(bushvote ~ V023010 + ideolf + partyid + educn + useconn, data=nes2002, family=binomial(link=logit))
summary(bushideolrm7f)


###################################################
### code chunk number 57: LogitExample-1-guide-uniquebackupstring.Rnw:1386-1387
###################################################
anova(bushlogit5, bushideolrm7f, test="Chisq")


###################################################
### code chunk number 58: 822o
###################################################
bushideolrm7o <- glm(bushvote ~ V023010 + ideolo + partyid + educn + useconn, data=nes2002, family=binomial(link=logit))
summary(bushideolrm7o)


###################################################
### code chunk number 59: LogitExample-1-guide-uniquebackupstring.Rnw:1426-1427
###################################################
outreg(list("ideolf"=bushideolrm7f, "ideolo"=bushideolrm7o), tight = F, varLab = vl)


###################################################
### code chunk number 60: LogitExample-1-guide-uniquebackupstring.Rnw:1434-1435
###################################################
anova(bushlogit5, bushideolrm7o, test="Chisq")


###################################################
### code chunk number 61: LogitExample-1-guide-uniquebackupstring.Rnw:1444-1447
###################################################
x <- 1:7
xf <- factor(x)
contrasts(xf)


###################################################
### code chunk number 62: LogitExample-1-guide-uniquebackupstring.Rnw:1461-1463
###################################################
xo <- factor(x, ordered = TRUE)
contrasts(xo)


###################################################
### code chunk number 63: LogitExample-1-guide-uniquebackupstring.Rnw:1480-1481
###################################################
drop1(bushideolrm7f, test = "Chisq")


###################################################
### code chunk number 64: usecon10
###################################################
bushlogit8 <- glm(bushvote ~ V023010 + ideoln + partyid + usecono + educn, data=nes2002, family=binomial(link=logit), model=TRUE)
summary(bushlogit8)


###################################################
### code chunk number 65: LogitExample-1-guide-uniquebackupstring.Rnw:1516-1517
###################################################
drop1(bushlogit8, test = "Chisq")


###################################################
### code chunk number 66: LogitExample-1-guide-uniquebackupstring.Rnw:1524-1526
###################################################
bushlogit8r <- glm(bushvote ~ V023010 + ideoln + partyid + educn, data=model.frame(bushlogit8), family=binomial(link=logit))
anova(bushlogit8r, bushlogit8, test = "Chisq")


###################################################
### code chunk number 67: usecon20
###################################################
anova(bushlogit5, bushlogit8, test = "Chisq")


###################################################
### code chunk number 68: LogitExample-1-guide-uniquebackupstring.Rnw:1557-1559
###################################################
bushideoProbit1 <- glm(bushvote~ideoln, family=binomial(link=probit), data=nes2002) 
summary(bushideoProbit1)


###################################################
### code chunk number 69: LogitExample-1-guide-uniquebackupstring.Rnw:1568-1569
###################################################
outreg(list(ols1, bushideoglm1, bushideoProbit1), tight=T, showAIC=T, modelLabels=c("OLS","Logit","Probit"), varLab = vl)


###################################################
### code chunk number 70: 99
###################################################
bushprobit5 <- glm(bushvote ~ V023010 + ideoln + partyid + educn + useconn, data=nes2002, family=binomial(link=probit), model=T)
summary(bushprobit5)


###################################################
### code chunk number 71: 100
###################################################
bushols5 <- lm(bushvote ~ V023010 + ideoln + partyid + educn + useconn, data=nes2002)


###################################################
### code chunk number 72: 101
###################################################
outreg(list(bushols5, bushlogit5, bushprobit5), tight=T, showAIC=T, modelLabels=c("OLS","Logit","Probit"), varLab = vl)


###################################################
### code chunk number 73: 110
###################################################
logitcoef <- coef(bushlogit5)
probitcoef <- coef(bushprobit5)
cbind(logitcoef, probitcoef, ratio=logitcoef/probitcoef)


###################################################
### code chunk number 74: 120
###################################################
options(digits=3)
logitsummary <- summary(bushlogit5)
probitsummary <- summary(bushprobit5)
zcompare <- cbind(logitsummary$coefficients[, c(3,4)], probitsummary$coefficients[, c(3,4)])
zcompare <- as.data.frame(zcompare)
colnames(zcompare) <- c("logit-z","logit-p", "probit-z", "probit-p")
zcompare$ratioz <- zcompare[ ,1] / zcompare[ ,3]
zcompare


###################################################
### code chunk number 75: 130
###################################################
logitpred <- predict(bushlogit5, type="response")
probitpred <- predict(bushprobit5, type="response")
plot(logitpred, probitpred, xlab="Predicted Probabilities from Logit Model", ylab="Predicted Probabilties from Probit Model", main="Scatterplot of Predictions from Logit and Probit")
pmod1 <- lm(probitpred ~ logitpred)
summary(pmod1)
abline(pmod1, col="red", lwd=2)
legend("topleft", legend=c("OLS regression"), col="red", lwd=2)


###################################################
### code chunk number 76: roc10
###################################################
library(pROC)
bl5roc <- roc(model.frame(bushlogit5)$bushvote, logitpred)
bl5roc


###################################################
### code chunk number 77: roc20
###################################################
plot(bl5roc, print.auc = TRUE, xlab = "specificity = TNR = 1 - FPR", ylab = "Sensitivity = TPR = 1 - FNR")


###################################################
### code chunk number 78: session
###################################################
sessionInfo()
if(!is.null(warnings())){
    print("Warnings:")
    warnings()}


###################################################
### code chunk number 79: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)


