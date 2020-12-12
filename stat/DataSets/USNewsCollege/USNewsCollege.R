dat <- read.table("USNewsCollege.csv", sep=",")

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


dat$private <- factor(dat$private, levels=c("1","2"), labels = c("public","private"))




m1 <- lm(gradrate ~ instcst, data=dat)
summary(m1)
plot(gradrate ~ instcst, data=dat)
par(mfcol=c(2,2))
plot(m1)



m2 <- lm(gradrate ~ instate, data=dat)
summary(m2)
plot(gradrate ~ instate, data=dat)
par(mfcol=c(2,2))
plot(m2)

plot(gradrate ~ instate, data=dat)
plot(gradrate ~ instate, data=dat, col=private)


bymod2 <- by(dat, dat$private, function(subdat){modsub <- lm(gradrate ~ instate, data=subdat)})

abline(bymod2[[1]])
abline(bymod2[[2]])


plot(gradrate ~ outstate, data=dat)
plot(gradrate ~ outstate, data=dat, col=private)


bymod2 <- by(dat, dat$private, function(subdat){modsub <- lm(gradrate ~ outstate, data=subdat)})

abline(bymod2[[1]])
abline(bymod2[[2]])




plot(gradrate ~ pctphd, data=dat)
plot(gradrate ~ pctphd, data=dat, col=private)

bymod2 <- by(dat, dat$private, function(subdat){modsub <- lm(gradrate ~ pctphd, data=subdat)})

abline(bymod2[[1]])
abline(bymod2[[2]])


library(rockchalk)
outreg(bymod2)



plot(gradrate ~ instcst, data=dat)
plot(gradrate ~ instcst, data=dat, col=private)

bymod2 <- by(dat, dat$private, function(subdat){modsub <- lm(gradrate ~ instcst, data=subdat)})

abline(bymod2[[1]])
abline(bymod2[[2]])

library(rockchalk)
outreg(bymod2)








plot(log(gradrate) ~ log(instate), data=dat)

plot(log(gradrate) ~ log(instate), data=dat, col=private)

plot(gradrate ~ instate, data=dat, col=private)



bymod2 <- by(dat, dat$private, function(subdat){modsub <- lm(log(gradrate) ~ log(instate), data=subdat); abline(modsub, col=subdat$private); modsub})
abline(bymod2[[1]])



m3 <- lm(gradrate ~ aveact, data=dat)
summary(m3)
par(mfcol=c(2,2))
plot(m3)



m20 <- lm(gradrate ~ instcst + aveact + instate, data=dat)
summary(m20)
par(mfcol=c(2,2))
plot(m20)


plot(gradrate ~ instcst, data=dat)

plot(gradrate ~ instcst, data=dat[dat$instcst < 25000 ,])

m1 <- lm(gradrate ~ instcst, data=dat, subset= instcst < 25000)

par(mfcol=c(2,2))
plot(m1)

plot(gradrate ~ instcst, data=dat, subset= instcst < 25000, col=private)

par(mfcol=c(2,1))
 by(dat, dat$private, function(subdat){plot(gradrate ~ instcst, data=subdat, subset= instcst < 25000, xlim= c(0,25000), ylim=range(dat$gradrate, na.rm=TRUE))})

par(mfcol=c(2,1))
 by(dat, dat$private, function(subdat){plot(gradrate ~ instcst, data=subdat, subset= instcst < 25000, xlim= c(0,25000), ylim=range(dat$gradrate, na.rm=TRUE)); m1 <- lm(gradrate ~ instcst, data=subdat, subset= instcst < 25000); abline(m1)})


by(dat, dat$private, function(subdat){m1 <- lm(gradrate ~ instcst, data=subdat, subset= instcst < 25000)})





> plot(gradrate ~ instcst, data=dat[dat$private=="public" && dat$instcst < 20000 , ], col=private)
> plot(gradrate ~ instcst, data=dat[dat$private=="public" & dat$instcst < 20000 , ], col=private)
> 
