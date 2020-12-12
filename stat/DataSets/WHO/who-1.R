library(gdata)
dat <- read.xls("WHO-InfMortality-Combined.xls")

colnames(dat)

#fix(dat) ##shows all NA after row 193
dat <- dat[1:193, ]

##Double check country values

countryNames <- cbind(levels(dat$country)[dat$country], levels(dat$country2)[dat$country2])
countryNames[ ,1] == countryNames[ ,2]
countryNames[155:165, ]
## OK, just NAs..

## encoding problem (international characters)
dat$country <- iconv(dat$country, to="UTF-8")

str(dat)

## ##Numeric version
## dat$hlthGovPerCapitaN <- as.numeric(levels(dat$hlthGovPerCapita))[dat$hlthGovPerCapita]

plot(neonatalMortality~ hlthGovPerCapita, data=dat)
plot(neonatalMortality~ hlthPerCap, data=dat)
plot(neonatalMortality ~ hlthPerCap, data=dat, log = "xy")
dev.new()
plot(log(neonatalMortality) ~ log(hlthPerCap), data=dat)
plot(hlthGovPerCapita ~ hlthPerCap, data=dat)

plot(neonatalMortality~ hlthGovPerCapita, data=dat, log="xy", xlab="Health Expenditures-Gov't (log)", ylab="Neonatal Mortality (log)")
plot(log(neonatalMortality) ~ log(hlthGovPerCapita), data=dat)
## Previous appears same, but axes scale differ
plot(neonatalMortality ~ hlthPerCap, data=dat, log="xy")
## Similar


library(rockchalk)

m1 <- lm(log(neonatalMortality) ~ log(hlthPerCap) + log( hlthGovPerCapita), data=dat)
summary(m1)
mcDiagnose(m1)



m2 <- lm(log(neonatalMortality)~ log(hlthGovPerCapita), data=dat)
summary(m2)
plot(log(neonatalMortality)~ log(hlthGovPerCapita), data=dat)
abline(m2)


## Reconsider simple log transform.  Explore
## "logtrans" to fit alpha in log(y + alpha) and
## "boxcox" to do the boxcox transform on y

library(MASS)

m3 <-  lm(neonatalMortality ~ log(hlthGovPerCapita), data=dat)

m3lt <- logtrans(m3, alpha = seq(0, 50, length=100))

m3bc <- boxcox(m3, lambda = seq(-0.25, 0.5, length=100))

lambdaOpt <- m3bc$x[which.max(m3bc$y)]
## Appears lambda= 0.25

## Adapted From Teaching Demos.
## includes geometric mean. 
bcpowertrans <- function (y, lambda)
{
    gm <- exp(mean(log(y), na.rm=T))
    if (lambda == 0)
        return(log(y) * gm)
    yt <- (y^lambda - 1)/(lambda * gm^(lambda - 1))
    return(yt)
}

## Simple BoxCox transform. Omit geometric mean
bctrans <- function (y, lambda)
{
   if (abs(lambda) < 1e-06)
        return(log(y))
    yt <- (y^lambda - 1)/(lambda)
    yt
}

invbctrans <- function(yt, lambda){
  if (abs(lambda) <  1e-06) y <- exp(yt)
  else y <- (lambda*yt + 1)^(1/lambda)
  y
}



m4 <-  lm(bctrans(neonatalMortality, lambdaOpt) ~ log(hlthGovPerCapita), data=dat)
summary(m4)
plot(bctrans(neonatalMortality, lambdaOpt)~ log(hlthGovPerCapita), data=dat)
abline(m4)

## 0 param same as log, verify:
### 

m5 <-  lm(bctrans(neonatalMortality, lambdaOpt) ~bctrans(hlthGovPerCapita, 0), data=dat)
summary(m5)
plot(bctrans(neonatalMortality, lambdaOpt)~ bctrans(hlthGovPerCapita, 0), data=dat)
abline(m5)

## transform between .1 and .2 appears better than 0, if going by R-square.
dev.new()
m5 <-  lm(bctrans(neonatalMortality, lambdaOpt) ~bctrans(hlthGovPerCapita, 0.15), data=dat)
summary(m5)
plot(bctrans(neonatalMortality, lambdaOpt)~ bctrans(hlthGovPerCapita, 0.15), data=dat)
abline(m5)

##need transformed input variable
dat$hlthGovPerCapitabc <- bctrans(dat$hlthGovPerCapita, 0.15)
dat$neonatalMortalitybc <- bctrans(dat$neonatalMortality, lambdaOpt)
m6 <-  lm(neonatalMortalitybc ~ hlthGovPerCapitabc, data=dat)

summary(m6)
plot(bctrans(neonatalMortality, lambdaOpt)~ hlthGovPerCapitabc, data=dat)
abline(m6)


newdf <- data.frame(hlthGovPerCapitabc = bctrans(plotSeq(dat$hlthGovPerCapita, 50), 0.15))
m6pred <- predict(m6, newdata=newdf, interval="conf")
m6predbci <- invbctrans(m6pred, lambdaOpt)

plot(neonatalMortality~ hlthGovPerCapita, data=dat)
matplot( invbctrans(newdf$hlthGovPerCapitabc, 0.15), m6predbci, lty=c(1,2,2), type="l", add=TRUE)

###ALL Good BEFORE THIS LINE####### 2012-02-22

plot(stillbirth2009 ~ hlthPerCap, data=dat)
plot(stillbirth2009 ~ hlthGovPerCapita, data=dat)


plot(stillbirth2009 ~ hlthPerCap, data=dat, log="xy")
plot(stillbirth2009 ~ hlthGovPerCapita, data=dat, log="xy")


