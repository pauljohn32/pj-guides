dat <- read.table("/home/pauljohn/ps/SVN-guides/stat/DataSets/PublicSpending/publicspending.txt",header=T)
EXfull <- lm(EX ~ ECAB + MET + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull)
EXnoECAB <- lm(EX ~ MET + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXnoECAB)
(deltaRecab <- summary(EXfull)$r.square - summary(EXnoECAB)$r.square)

library(gRbase)

(cov2pcor(cov(dat[, c("EX", "ECAB", "MET", "GROW", "YOUNG","OLD","WEST")])))^2
 


library(ppcor)
spcor(EXfull$model)


library(lmSupport)

lm.sumSquares(EXfull)
dat$WEST <- factor(dat$WEST, labels=c("Not West","West"))

EXfull <- lm(EX ~ ECAB + MET + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull)


library(relaimpo)

EXFull <- lm(EX ~ ECAB+ MET + GROW + YOUNG + OLD + WEST, data=dat)
(crelimp <- calc.relimp(EXFull, type=c("lmg")))
plot(crelimp)







plot(EXfull)


plot(EXfull, which=1)


plot(EXfull, which=2)

plot(EXfull, which=3)

plot(EXfull, which=5)
