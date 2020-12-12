#Paul Johnson
#2011-10-31

dat <- read.table("/home/pauljohn/ps/SVN-guides/stat/DataSets/PublicSpending/publicspending.txt",header=T)
EXfull <- lm(EX ~ ECAB + MET + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull)


##First problem to my eye is nonlinearity in MET, so fix that first:
EXfull2 <- lm(EX ~ ECAB + MET + I(MET^2) + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull2)

##Interesting: compare:
##EXfull2 <- lm(EX ~ ECAB + poly(MET,2, raw=TRUE) + GROW + YOUNG + OLD + WEST, data=dat)
EXfull2 <- lm(EX ~ ECAB + poly(MET,2, raw=FALSE) + GROW + YOUNG + OLD + WEST, data=dat)

influence.measures(EXfull2)

hatvalues(EXfull2)

dffits(EXfull2)
