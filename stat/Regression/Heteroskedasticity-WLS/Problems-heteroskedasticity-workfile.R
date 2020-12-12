#Paul Johnson
#2011-10-18

### Outline
### 1. explore heteroskedasticity with plots and diagnostics

### 2. compare "categorical heteroskedasticity" measures like bartlett's test,
### fligner test, levene's test, and the gqtest applied to the categorical data.

### 1. Open the public spending data set, check for heteroskedasticy.
### Also unearths problems with one "outlier" and/or the need for logged data

dat <- read.table("/home/pauljohn/ps/SVN-guides/stat/DataSets/PublicSpending/publicspending.txt",header=T)
EXfull <- lm(EX ~ ECAB + MET + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull)


##Compare vcov with hccm
EXfullcoef <- coefficients(EXfull)

EXfullvcov <- vcov(EXfull)

##confirm those match ols summary
tstats <- EXfullcoef/sqrt(diag(EXfullvcov))


library(car)
?hccm

##White's famous proposal
EXrobustvcovh0 <- hccm(EXfull, type="hc0")
robtstatsh0 <- EXfullcoef/sqrt(diag(EXrobustvcovh0))

EXrobustvcovh3 <- hccm(EXfull, type="hc3")
robtstatsh3 <- EXfullcoef/sqrt(diag(EXrobustvcovh3))

##compare the 3 columns of t statistics
cbind(tstats, robtstatsh0, robtstatsh3)

## try sandwich package

library(sandwich)
vcovHC(EXfull)
EXrobustvcovHC <- vcovHC(EXfull)
robtstatsh4 <- EXfullcoef/sqrt(diag(EXrobustvcovHC))


##compare the 4 columns of t statistics
cbind(tstats, robtstatsh0, robtstatsh3, robtstatsh4)
### Hmm. Mismatch on ECAB is provocative (but not definitive)

### Throw a White/bp test at it:
library(lmtest)
bptest(EXfull) #fails, so go on

gqtest(EXfull, order.by= ~dat$ECAB, fraction=0.2 )




### Look around
termplot(EXfull, partial=T)
par(mfcol=c(2,2))
plot(EXfull)
par(mfcol=c(1,1))


##First problem to my eye is nonlinearity in MET, so fix that first:
EXfull2 <- lm(EX ~ ECAB + MET + I(MET^2) + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull2)

bptest(EXfull2) ##Still fails

gqtest(EXfull2, order.by= ~dat$ECAB, fraction=0.2 )
##passes, but closely

termplot(EXfull2, partial=T)

robustvcov <- hccm(EXfull2)
robtstat <- coef(EXfull2)/sqrt(diag(robustvcov))
robtstat
###

### Considered just removing that one extreme case, see what happens.
### can't figure how to use subset option in lm. 
EXfull2nv <- lm(EX ~ ECAB + MET + I(MET^2) + GROW + YOUNG + OLD + WEST, data=dat[!dat$STATE %in% c("NV"),])
summary(EXfull2nv)

bptest(EXfull2nv) ##passed

gqtest(EXfull2nv, order.by= model.matrix(EXfull2nv)[ ,"ECAB"], fraction=0.2 )
##passes, but closely

termplot(EXfull2, partial=T)

robustvcov <- hccm(EXfull2nv)
robtstat <- coef(EXfull2nv)/sqrt(diag(robustvcov))
robtstat

par(mfcol=c(2,2))
plot(EXfull2nv)
par(mfcol=c(1,1))

###


### Feel guilty cutting Nevada that way. Go on.

hist(dat$EX) ## Not so suspicious
hist(dat$ECAB) ##more dubious

EXfull3 <- lm(log(EX) ~ log(ECAB) + MET + I(MET^2) + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull3)

petest(EXfull3, EXfull2)
##Seems to indicate log model better, wonder if need log lhs

## why not this?
EXfull4 <- lm(EX ~ log(ECAB) + MET + I(MET^2) + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull4)

robustvcov <- hccm(EXfull4)
robtstat <- coef(EXfull4)/sqrt(diag(robustvcov))
robtstat
###
petest(EXfull3, EXfull4)
##Seems to say don't log


EXbox <- boxcox( EX ~ log(ECAB) + MET + I(MET^2) + GROW + YOUNG + OLD + WEST, data=dat , lambda = seq(-1.75, 1.75, length = 100) )
##ML estimate is about 0.3, Does not support rejection of 0 or 1. 

## data is not speaking loudly to me.  I expect most practitioners
## would want to log both, but who knows?

###
### as an alternative, try a robust regression approach
EXfull3rlm <- rlm(log(EX) ~ log(ECAB) + MET + I(MET^2) + GROW + YOUNG + OLD + WEST, data=dat)
summary(EXfull3rlm)


###############################################################
###############################################################

## Manufacture test data for the Categorical heteroskedasticity estimators

library(lmtest)

x <- c( rep(-1, 50), rep(1, 50))
err1 <- c(rnorm(50, m=0, s=1), rnorm(50, m=0, s=2))
y1 <- 1 + x + err1

### Now check to see if various het tests give similar p values
mod1 <- lm(y1~x)
res1 <- resid(lm(y1~x))

gqtest(y1 ~ x)
gqtest(y1 ~ x, point=0.5)#same
gqtest(mod1, point=0.5, order.by = ~x)#same

bartlett.test(res1, g=x)
fligner.test(res1, g=x)

library(car)
leveneTest(y1, factor(x))


###In this case x is already sorted from low to hi, but can
### order it to be sure. Here's one way

#xorder <- order(x)
#y <- y[xorder]
#x <- x[xorder]
## would be easier with a data frame. Get it in one shot:
## dat <- dat[order(dat$x),   ]

###build a function so we can do this over and over
###
simHet <- function(i, N=100, diffsd=1){
  x <- c( rep(-1,  N/2), rep(1, N/2))
  err1 <- c(rnorm(N/2, m=0, s=1), rnorm(N/2, m=0, s=(1+diffsd)))
  y1 <- 1 + x + err1
  mod1 <- lm(y1~x)
  res1 <- resid(lm(y1~x))
  bartlettp <- bartlett.test(res1, g=x)$p.value
  flp <- fligner.test(res1, g=x)$p.value
  levenep <- leveneTest(y1, factor(x))[1,3]
  gqp <-  gqtest(mod1, point=0.5, order.by = ~x)$p.value
  c(bartlettp, flp, levenep, gqp)
}

simHetResult <- sapply(1:100, simHet, N=100, diffsd=1)

###Massage into data frame, then explore
###Need transpose that
tsimHetResult <- t(simHetResult)
tsimHetResult <- as.data.frame(tsimHetResult)
colnames(tsimHetResult) <- c("bartlettp", "flp", "levenep", "gqp")

cor(tsimHetResult)

plot(as.data.frame(tsimHetResult))

### Wow. Bartlet's test and the categorical application of the
### Goldfield Quandt test are almost completely identical.

### Categorical levene test and flp are almost completely identical
###

### Compare conclusions of 0.05 hypo test
hypotests <- apply(tsimHetResult, 2, function(x) x <= 0.05)
colMeans(hypotests)



## Now repeat same with smaller variance difference
simHetResult <- sapply(1:100, simHet, N=100, diffsd=0.25)


## Now repeat same, make N bigger
simHetResult <- sapply(1:100, simHet, N=2000, diffsd=0.25)

## Maybe Mauricio was correct. If you make N larger, these
## tests become increasingly likely to reject null.
## However, that pre-supposed null was wrong.

## Now, what if difference is truly 0?

simHetResult <- sapply(1:100, simHet, N=2000, diffsd=0.0)
##That's not so bad. Not falsely rejecting 0 often



simHetResult <- sapply(1:100, simHet, N=10000, diffsd=0.0)

## In my test, Bartlett's is on the spot correct, which
## makes sense because the errors really are Normal.
## the others have a higher "false positive" rate.
## I wonder if that's known?



simHetResult <- sapply(1:100, simHet, N=20000, diffsd=0.0)
### Interesting. Rejecting null less often.

simHetResult <- sapply(1:100, simHet, N=50000, diffsd=0.0)
### Rejects null less and less often as N gets bigger

##Now, suppose heteroskedasticity is truly small, but not 0
simHetResult <- sapply(1:100, simHet, N=100, diffsd=0.05)


simHetResult <- sapply(1:100, simHet, N=50000, diffsd=0.05)
## With large N, we reject null even when effect really is small
