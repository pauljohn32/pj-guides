dat <- read.table("/home/pauljohn/ps/SVN-guides/stat/DataSets/PublicSpending/publicspending.txt",header=T)
EXfull <- lm(EX ~ ECAB + MET + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull)


EXfullcoef <- coefficients(EXfull)
EXfullcoef

EXfullvcov <- vcov(EXfull)
EXfullvcov

tYoungGrow <- (EXfullcoef["YOUNG"] - EXfullcoef["GROW"] )/sqrt(EXfullvcov["YOUNG","YOUNG"] + EXfullvcov["GROW","GROW"] -2 * EXfullvcov["YOUNG","GROW"] )
tYoungGrow

#Better doublecheck manually
## ( 0.5715895 - 6.6746586 ) /sqrt(7.48^2 + .425^2 - 2*(0.8))
## Whew.


EXonlyYoung <- lm(EX ~ YOUNG, data=dat)
summary(EXonlyYoung)


EXrestricted <-  lm(EX ~ ECAB + MET + WEST, data=dat)
summary(EXrestricted) 

anova(EXrestricted, EXfull, test="F") 

