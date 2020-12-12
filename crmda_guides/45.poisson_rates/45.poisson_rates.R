### R code from vignette source '45.poisson_rates-tanglebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: 45.poisson_rates-tanglebackupstring.Rnw:28-29
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
options(width=100, prompt="> ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
options(SweaveHooks=list(fig=function() par(ps=10)))
pdf.options(onefile=FALSE,family="Times",pointsize=10)


###################################################
### code chunk number 4: texcopy
###################################################
library(stationery)
## If theme directory does not have required images or TeX files
## we need to retrieve them and put them in "theme" directory. 
logos <- c(logoleft = "logoleft.pdf", 
           logoright = "logo-vert.pdf",
           address = "addressFooter.tex")
getFiles(logos, pkg = "crmda")


###################################################
### code chunk number 5: sas10
###################################################
wdir <- "workingdata"
fn <- "insure.csv"

insure <- read.csv(file.path(wdir, fn), stringsAsFactors = FALSE)
insure$car <- factor(insure$car, levels = c("small", "medium", "large"))
insure$agen <- insure$age
insure$age <- factor(insure$age)
colnames(insure) <- gsub("^ln$", "nlog", colnames(insure))
colnames(insure) <- gsub("^c$", "claims", colnames(insure))


###################################################
### code chunk number 6: 45.poisson_rates-tanglebackupstring.Rnw:454-456
###################################################
library(xtable)
print(xtable(insure), floating=FALSE)


###################################################
### code chunk number 7: sas100
###################################################
ins2 <- glm(claims ~ offset(log(n)) + car + age, family = "poisson", data = insure)
summary(ins2)
vl <- c("carmedium" = "Car: medium", "carlarge" = "Car: large", "age2" = "Age: senior")


###################################################
### code chunk number 8: sas150
###################################################
library(rockchalk)
print(xtable(descriptiveTable(ins2, varLabels = vl)), floating=FALSE)


###################################################
### code chunk number 9: sas200
###################################################
library(rockchalk)
outreg(list("Poisson with offset"=ins2),
       runFuns = c("AIC" = "Akaike IC"), 
       varLabels = vl, centering = "siunitx")


###################################################
### code chunk number 10: sas300
###################################################
ins2.pom <- predictOMatic(ins2, predVals = list("car" = "table", "age" = "table","n" = 1), interval = "confidence")



###################################################
### code chunk number 11: 45.poisson_rates-tanglebackupstring.Rnw:515-516
###################################################
print(xtable(ins2.pom), floating=FALSE, include.rownames=FALSE)


###################################################
### code chunk number 12: 45.poisson_rates-tanglebackupstring.Rnw:547-550
###################################################
fn <- "goals.rds"
wdir <- "workingdata"
goals <- readRDS(file.path(wdir, fn))


###################################################
### code chunk number 13: 45.poisson_rates-tanglebackupstring.Rnw:564-566
###################################################
library(xtable)
print(xtable(goals[1:15, ]), floating = FALSE)


###################################################
### code chunk number 14: 45.poisson_rates-tanglebackupstring.Rnw:571-572
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(jitter(goals) ~ jitter(played), goals, xlab = "matches played (jittered)", ylab = "goals scored (jittered)")


###################################################
### code chunk number 15: goals100
###################################################
m1 <- glm(goals ~ position, data = goals, family = poisson)
summary(m1)


###################################################
### code chunk number 16: 45.poisson_rates-tanglebackupstring.Rnw:605-607
###################################################
library(rockchalk)
outreg(list("Poisson Regression (without offset)" = m1))


###################################################
### code chunk number 17: 45.poisson_rates-tanglebackupstring.Rnw:613-615
###################################################
library(rockchalk)
desctab <- descriptiveTable(m1, stats = c("min", "max", "mean", "sd", "skewness", "kurtosis"))


###################################################
### code chunk number 18: 45.poisson_rates-tanglebackupstring.Rnw:617-618
###################################################
print(xtable(desctab), floating = FALSE)


###################################################
### code chunk number 19: goals150
###################################################
library(COUNT)
newnames <- c(propObsv = "Observed", propPred = "Predicted", Diff= "Difference")
poipred <- poi.obs.pred(10, m1)
library(kutils)
colnames(poipred) <- mgsub(names(newnames), newnames, colnames(poipred))
poipred


###################################################
### code chunk number 20: 45.poisson_rates-tanglebackupstring.Rnw:633-634
###################################################
print(xtable(poipred), floating=FALSE)


###################################################
### code chunk number 21: goals200
###################################################
m1.p.resids <- residuals(m1, type="pearson") 
test.stat <- sum(m1.p.resids^2) 
test.stat 
pchisq(test.stat, m1$df.residual, lower.tail=FALSE) 


###################################################
### code chunk number 22: goals250
###################################################
library(AER)
dispersiontest(m1, trafo=2)


###################################################
### code chunk number 23: goals290
###################################################
predictOMatic(m1, predVals = list(position = "table"), interval = "confidence")


###################################################
### code chunk number 24: goals300
###################################################
nd <- newdata(m1, predVals = list(position = "table"))
predict(m1, newdata = nd, type = "link", interval = "confidence", se.fit = TRUE)


###################################################
### code chunk number 25: 45.poisson_rates-tanglebackupstring.Rnw:688-689
###################################################
predict(m1, newdata = nd, type = "response", interval = "confidence", se.fit = TRUE)


###################################################
### code chunk number 26: 45.poisson_rates-tanglebackupstring.Rnw:703-707
###################################################
 ## Offset model for rate of goals per game
m3 <- glm(goals ~ position + offset(log(played)),           
        data = goals, family = poisson) 
summary(m3)


###################################################
### code chunk number 27: 45.poisson_rates-tanglebackupstring.Rnw:713-715
###################################################
outreg(list("Without offset)" = m1,
       "With offset" = m3), centering = "siunitx")


###################################################
### code chunk number 28: goals500
###################################################
newnames <- c(propObsv = "Observed", propPred = "Predicted", Diff= "Difference")
poipred <- poi.obs.pred(20, m3)
colnames(poipred) <- mgsub(names(newnames), newnames, colnames(poipred))
poipred


###################################################
### code chunk number 29: 45.poisson_rates-tanglebackupstring.Rnw:728-729
###################################################
print(xtable(poipred), floating=FALSE)


###################################################
### code chunk number 30: 45.poisson_rates-tanglebackupstring.Rnw:736-737
###################################################
dispersiontest(m3, trafo=2)


###################################################
### code chunk number 31: 45.poisson_rates-tanglebackupstring.Rnw:754-759
###################################################
library(MASS)
m2 <- glm.nb(goals ~ position, data = goals)
summary(m2)
m4 <- glm.nb(goals ~ position + offset(log(played)), data = goals) 
summary(m4)


###################################################
### code chunk number 32: 45.poisson_rates-tanglebackupstring.Rnw:767-768
###################################################
outreg(list("Without Offset" = m2, "With Offset" = m4), request = c("theta" = "theta"), runFuns =c("deviance" = "Deviance", "AIC" = "AIC"), centering = "siunitx")


###################################################
### code chunk number 33: 45.poisson_rates-tanglebackupstring.Rnw:774-778
###################################################
m2.p.resids <- residuals(m2, type="pearson")
test.stat <- sum(m2.p.resids^2)
test.stat
pchisq(test.stat, m1$df.residual, lower.tail=FALSE)


###################################################
### code chunk number 34: goals1100
###################################################
newnames <- c(propObsv = "Observed", propPred = "Predicted", Diff= "Difference")
nbpred1 <- nb2.obs.pred(15, m2)
colnames(nbpred1) <- mgsub(names(newnames), newnames, colnames(nbpred1))
nbpred1


###################################################
### code chunk number 35: 45.poisson_rates-tanglebackupstring.Rnw:797-798
###################################################
print(xtable(nbpred1), floating=FALSE)


###################################################
### code chunk number 36: goals1200
###################################################
nbpred2 <- nb2.obs.pred(15, m4)
colnames(nbpred2) <- mgsub(names(newnames), newnames, colnames(nbpred2))
nbpred2


###################################################
### code chunk number 37: 45.poisson_rates-tanglebackupstring.Rnw:809-810
###################################################
print(xtable(nbpred2), floating=FALSE)


###################################################
### code chunk number 38: 45.poisson_rates-tanglebackupstring.Rnw:823-829
###################################################
options.orig <- options()
options(width=80)
anova(m2, m4, test = "Chisq")
library(lmtest)
lrtest(m2, m4)
options(options.orig)


###################################################
### code chunk number 39: 45.poisson_rates-tanglebackupstring.Rnw:852-853
###################################################
m4a.pom <-predictOMatic(m4, predVals=list(played=1, position = "table"), interval = "confidence")


###################################################
### code chunk number 40: 45.poisson_rates-tanglebackupstring.Rnw:863-864
###################################################
print(xtable(m4a.pom), floating = FALSE, include.rownames=FALSE)


###################################################
### code chunk number 41: import10
###################################################
wdir <- "workingdata"
fire <- read.csv(file.path(wdir, "fireworks-1617.csv"), header=TRUE)
fire$yearf <- as.factor(fire$year)
fire$junjul <- factor(ifelse(!fire$month %in% c("June", "Jul"), "other", "June.or.July"),                       levels = c("other", "June.or.July"))
fire$hourslog <- log(fire$hours)
rockchalk::summarize(fire)


###################################################
### code chunk number 42: xtab10
###################################################
library(xtable)
keepers <- c("year", "month", "hours", "accidents")
fire.xt <- xtable(fire[ , keepers], caption = "Monthly Injury Data", label = "monthly")
print(fire.xt, caption.placement="top")


###################################################
### code chunk number 43: 45.poisson_rates-tanglebackupstring.Rnw:909-911
###################################################
m0 <-   glm(accidents ~ 1 + yearf + junjul, data = fire, family = "poisson") 
summary(m0)


###################################################
### code chunk number 44: 45.poisson_rates-tanglebackupstring.Rnw:916-918
###################################################
m1 <- glm(accidents ~ offset(hourslog) + 1, data = fire, family = "poisson") 
summary(m1) 


###################################################
### code chunk number 45: 45.poisson_rates-tanglebackupstring.Rnw:925-939
###################################################
nd <- data.frame(hourslog = log(200000))
## This is number of accidents predicted per 200000 hours
## pooling both years of data:
m1.p95 <- predictOMatic(m1, predVals = nd,
              interval = "confidence",
              level = 0.95)
m1.p90 <- predictOMatic(m1, predVals = nd,
              interval = "confidence",
              level = 0.90)
m1.p80 <- predictOMatic(m1, predVals = nd,
              interval = "confidence",
              level = 0.80)
m1cis <- merge(m1.p95, m1.p90, by = c("hourslog", "fit"), suffix = c("95", "90"))
m1cis <- merge(m1cis, m1.p80, by = c("hourslog", "fit"), suffix = c("", "80"))


###################################################
### code chunk number 46: 45.poisson_rates-tanglebackupstring.Rnw:942-943
###################################################
m1cis


###################################################
### code chunk number 47: 45.poisson_rates-tanglebackupstring.Rnw:948-950
###################################################
m2 <- glm(accidents ~ offset(hourslog) + 1 + yearf, fire, family = "poisson") 
summary(m2)


###################################################
### code chunk number 48: 45.poisson_rates-tanglebackupstring.Rnw:956-971
###################################################
nd <- data.frame(hourslog = log(200000), yearf = c("2016", "2017"))
m2.p <- predict(m2, newdata = nd, se.fit = TRUE)
predVals2 <- list(hourslog = log(200000), yearf= c("2016", "2017")) 
m2.p95 <- predictOMatic(m2, predVals = predVals2,
              interval = "confidence",
              level = 0.95)
m2.p90 <- predictOMatic(m2, predVals = predVals2, 
              interval = "confidence",
              level = 0.90)
m2.p80 <- predictOMatic(m2, predVals = predVals2,
              interval = "confidence",
              level = 0.80)
m2cis <- merge(m2.p95, m2.p90, by = c("yearf", "hourslog", "fit"), suffix = c("95", "90"))
m2cis <- merge(m2cis, m2.p80, by = c("yearf", "hourslog", "fit"), suffix = c("", "80"))
m2cis$hourslog <- NULL


###################################################
### code chunk number 49: 45.poisson_rates-tanglebackupstring.Rnw:974-975
###################################################
m2cis


###################################################
### code chunk number 50: 45.poisson_rates-tanglebackupstring.Rnw:978-981
###################################################
m3 <- glm(accidents ~ offset(hourslog) + 1 + yearf + junjul,
          dat = fire, family = "poisson")
summary(m3)


###################################################
### code chunk number 51: 45.poisson_rates-tanglebackupstring.Rnw:984-1002
###################################################
nd <- data.frame(hourslog = log(200000), yearf = c("2016", "2017"),
                 junjul = factor(c("no", "jj"), levels = c("other", "June.or.July")))
m3.p <- predict(m3, newdata = nd, se.fit = TRUE)

predVals3 <- list(hourslog = log(200000),
                 yearf= c("2016", "2017"),
                 junjul = c("other", "June.or.July"))
m3.p95 <- predictOMatic(m3, predVals = predVals3,
              interval = "confidence",
              level = 0.95)
m3.p90 <- predictOMatic(m3, predVals = predVals3,
                         interval = "confidence",
                         level = 0.90)
m3.p80 <- predictOMatic(m3, predVals = predVals3,
                         interval = "confidence",  level = 0.80)
m3cis <- merge(m3.p95, m3.p90, by = c("yearf", "hourslog", "fit"), suffix = c("95", "90"))
m3cis <- merge(m3cis, m3.p80, by = c("yearf", "hourslog", "fit"), suffix = c("", "80"))
m3cis


###################################################
### code chunk number 52: 45.poisson_rates-tanglebackupstring.Rnw:1005-1006
###################################################
m3cis


###################################################
### code chunk number 53: 45.poisson_rates-tanglebackupstring.Rnw:1013-1015
###################################################
library(AER) 
dispersiontest(m3)


###################################################
### code chunk number 54: agg10
###################################################
fireagg <- aggregate(fire[ , c("accidents", "hours")] , list(year = fire$year), sum, na.rm=TRUE)
fireagg$hourslog <- log(fireagg$hours)
fireagg$yearf <- factor(fireagg$year)


###################################################
### code chunk number 55: xtab20
###################################################
keepers <- c("year", "hours", "accidents")
fire.xtagg <- xtable(fireagg[ , keepers], caption = "Annual fire Data", label = "annual")
print(fire.xtagg, caption.placement="top")


###################################################
### code chunk number 56: m2montly
###################################################
m2.monthly <- glm(accidents ~ offset(hourslog) + 1 + yearf, fire, family = "poisson") 
summary(m2.monthly)


###################################################
### code chunk number 57: 45.poisson_rates-tanglebackupstring.Rnw:1063-1064
###################################################
(m2.monthly.p95 <- rockchalk::predictOMatic(m2.monthly, predVals=list(hourslog=log(200000), yearf=c("2016", "2017")), interval="confidence", level=0.95))


###################################################
### code chunk number 58: 45.poisson_rates-tanglebackupstring.Rnw:1078-1080
###################################################
m2.annual <- glm(accidents ~ offset(hourslog) + 1 + yearf, fireagg, family = "poisson") 
summary(m2.annual)


###################################################
### code chunk number 59: 45.poisson_rates-tanglebackupstring.Rnw:1086-1087
###################################################
rockchalk::predictOMatic(m2.annual, predVals=list(hourslog=log(200000),                                             yearf= c("2016", "2017")), interval = "confidence", level = 0.95)


###################################################
### code chunk number 60: outreg10
###################################################
library(rockchalk)
cat(outreg(list("Annual" = m2.annual, "Monthly" = m2.monthly), float=TRUE, title = "Comparing Annual and Monthly Fits"))


###################################################
### code chunk number 61: session
###################################################
sessionInfo()
if(!is.null(warnings())){
    print("Warnings:")
    warnings()}


###################################################
### code chunk number 62: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)


