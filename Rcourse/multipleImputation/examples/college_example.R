

library(rockchalk)

dat <- read.table("/home/pauljohn/ps/SVN-guides/stat/DataSets/USNewsCollege/USNewsCollege.csv", sep = ",")

mynames <- c("FICE", "NAME", "STATE", "PRIVATE", "AVEMATH","AVEVERB",
"AVECOMB", "AVEACT", "FSTMATH", "TRDMATH", "FSTVERB", "TRDVERB",
"FSTACT", "TRDACT", "NUMAPPS", "NUMACC", "NUMENR", "PCTTEN",
"PCTQUART", "NUMFULL", "NUMPART", "INSTATE", "OUTSTATE", "RMBRDCST",
"ROOMCST", "BRDCST", "ADDFEES", "BOOKCST", "PRSNL","PCTPHD",
"PCTTERM", "STDTOFAC", "PCTDONAT", "INSTCST", "GRADRATE")

colnames(dat) <- tolower(mynames)

## Varname reminder
## FICE = College Federal ID number
## NAME = College name
## STATE = State (postal code)
## PRIVATE = Public (1) or Private (2) college
## AVEMATH = Average Math SAT score
## AVEVERB = Average Verbal SAT score
## AVECOMB = Average combined SAT score
## AVEACT = Average ACT score
## FSTMATH = First quartile - Math SAT
## TRDMATH = Third quartile - Math SAT
## FSTVERB = First quartile - Verbal SAT
## TRDVERB = Third quartile - Verbal SAT
## FSTACT = First quartile - ACT
## TRDACT = Third quartile - ACT
## NUMAPPS = Number of applications received
## NUMACC = Number of applications accepted
## NUMENR = Number of new students enrolled
## PCTTEN = Percent of new students from the top 10% of H.S. class
## PCTQUART = Percent of new students from top 25% of H.S. class
## NUMFULL = Number of full-time undergraduates
## NUMPART = Number of part-time undergraduates
## INSTATE = In-state tuition
## OUTSTATE = Out-of-state tuition
## RMBRDCST = Room and board costs
## ROOMCST = Room costs
## BRDCST = Board costs
## ADDFEES = Additional fees
## BOOKCST = Estimated book costs
## PRSNL = Estimated personal spending
## PCTPHD = Percent of faculty with Ph.D.'s
## PCTTERM = Percent of faculty with terminal degrees
## STDTOFAC = Student/faculty ratio
## PCTDONAT = Percent of alumni who donate to the college
## INSTCST = Instructional expenditure per student

## GRADRATE = Graduation rate


dat$private <- factor(dat$private, levels = c("1","2"), labels = c("public","private"))

summarize(dat)


m1 <- lm(gradrate ~ private + instcst + aveact + pctten, data = dat)
summary(m1)

par(mfcol = c(2,2))
plot(m1)

termplot(m1, se = T, partial = T, terms = "instcst")
termplot(m1, se = T, partial = T)

## hmm. some gradrate over 100
dat$gradrate[dat$gradrate > 100] <- NA
## instcst: kick out the huge spenders??
dat <- dat[ dat$instcst < 20000, ]


m1 <- lm(gradrate ~ private + instcst + aveact + pctten, data = dat)
summary(m1)
par(mfcol = c(2,2))
plot(m1)
termplot(m1, se = T, partial = T)


## got distracted by an outlier hunt here:
## dat[c(850,917), "instcst" ] <- NA

## m1 <- lm(gradrate ~ private + instcst + aveact + pctten, data = dat)
## par(mfcol = c(2,2))
## plot(m1)




m2 <- lm(gradrate ~ private *(instcst + aveact + pctten), data = dat)
summary(m2)

summary(meanCenter(m2))

par(mfcol = c(2,2))
plot(m2)

plot(gradrate ~ instcst, data = dat)
plotSlopes(m2, plotx = "instcst", modx = "private")
termplot(m1, se = T, partial = T, terms = "instcst")


##dat$lgradrate <- exp(dat$gradrate/100)/(1 + exp((dat$gradrate/100)))

dat$lgradrate <- log(((dat$gradrate-1)/100)/(1 -((dat$gradrate-1)/100)))


m3 <- lm(lgradrate ~ private *(instcst + aveact + pctten), data = dat)

m1 <- lm(lgradrate ~ private + instcst + aveact + pctten, data = dat)

summary(m3)



library(mice)


colimp <- mice(dat)

## 2012: error! gets nowhere.

## > colimp <- mice(dat)

##  iter imp variable
##   1   1  fice  nameError in augment(y, ry, x, ...) :
##   Maximum number of categories (50) exceeded
## In addition: Warning message:
## In rchisq(1, sum(ry) - ncol(x)) : NAs produced

## 2013 get different error
## > colimp <- mice(dat)

##  iter imp variable
##   1   1  avemath  aveverbError in solve.default(xtx + diag(pen)) :
##   system is computationally singular: reciprocal condition number = 2.80444e-17
## >

dat2  <- dat[ , -c(1,2,3)]

colimp <- mice(dat2)


## 2011: that took about 5 minutes on a laptop
## 2013: less than 90 seconds running on battery
## Notice multicore working, "for free"

m1mi <- with(data = colimp, exp = lm(gradrate ~ private + instcst + aveact + pctten))
summary(m1mi)

m1mip <- pool(m1mi)
summary(m1mip)
summary(m1)

m2mi <- with(data = colimp, exp = lm(gradrate ~ private *(instcst + aveact + pctten)))
summary(m2mi)

m2mip <- pool(m2mi)
summary(m2mip)
summary(m2)


colimp2 <- mice(dat2, m = 10)




m1mi <- with(data = colimp2, exp = lm(gradrate ~ private + instcst + aveact + pctten))
summary(m1mi)

m1mip <- pool(m1mi)
summary(m1mip)
summary(m1)

m2mi <- with(data = colimp2, exp = lm(gradrate ~ private *(instcst + aveact + pctten)))
summary(m2mi)

m2mip <- pool(m2mi)
summary(m2mip)
summary(m2)



m2 <- lm(gradrate ~ private * (instcst + aveact + pctten + pctphd + stdtofac + (I(numacc/numapps) < 0.3)), data = dat2)
summary(m2)
m2mi <- with(data = colimp2, exp = lm(gradrate ~ private * (instcst + aveact + pctten + pctphd + stdtofac)))
summary(m2mi)

m2mip <- pool(m2mi)
summary(m2mip)
summary(m2)


