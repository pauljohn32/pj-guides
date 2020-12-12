## Paul Johnson
## Chong Xing  
## 20180104

wdir <- "../workingdata"
ddir <- "../data"
odir <- "../output"
tdir <- "../tmp"

library(kutils)
##library(openxlsx)
library(rockchalk)

pdf.options(onefile=FALSE, family="Times", paper="special", height=4,
            width=6, pointsize=10)

## Reading in Data
fire <- read.csv(file.path(wdir, "fireworks-1617.csv" ),
                stringsAsFactors=FALSE)
if(interactive()) peek(fire)

## US government wants the number of accidents per 200,000 hours
## worked.  The "raw" accident score is then

fire$score <- 200000 * fire$accidents / fire$hours
hist(fire$score, prob=T,
     main="Fireworks accidents per 200000 hours worked",
     xlab = "Number of accidents per 200000")

fire$yearf <- as.factor(fire$year)
fire$junjul <- factor(ifelse(!fire$month %in% c("Jun", "Jul"), "no", "jj"),
                      levels = c("no", "jj"))
fire$hourslog <- log(fire$hours) # save for later
fire$oshastd <- log(200000) # save for later

## OSHA wants number of injuries per 200000 hours, verify
## the OSHA calculation

## First, a poisson model that does not introduce rates
## There is a dummy variable because June and July are supposed
## to be hot spot months for fireworks

m0 <-   glm(accidents ~ 1 + yearf + junjul, data = fire,
          family = "poisson")
summary(m0)



## Proceed in steps.  First, fit an intercept only model,
## meaning the accident rate is same all months, both years
m1 <- glm(accidents ~ offset(hourslog) + 1, data = fire,
          family = "poisson")
summary(m1)

nd <- data.frame(hourslog = log(200000))

(m1.p <- predict(m1, newdata = nd, se.fit = TRUE))
## This is number of accidents predicted per 200000 hours
## pooling both years of data:
exp(m1.p$fit)

(m1.p95 <- predictOMatic(m1, predVals = nd,
              interval = "confidence",
              level = 0.95))
(m1.p90 <- predictOMatic(m1, predVals = nd,
              interval = "confidence",
              level = 0.90))
(m1.p80 <- predictOMatic(m1, predVals = nd,
              interval = "confidence",
              level = 0.80))
m1cis <- merge(m1.p95, m1.p90, by = c("hourslog", "fit"), suffix = c("95", "90"))
m1cis <- merge(m1cis, m1.p80, by = c("hourslog", "fit"), suffix = c("", "80"))
m1cis

## Second, check for year-on-year change
m2 <- glm(accidents ~ offset(hourslog) + 1 + yearf, fire, family = "poisson")
summary(m2)

nd <- data.frame(hourslog = log(200000), yearf = c("2016", "2017"))
(m2.p <- predict(m2, newdata = nd, se.fit = TRUE))
exp(m2.p$fit)


predVals2 <- list(hourslog = log(200000), yearf= c("2016", "2017")) 
(m2.p95 <- predictOMatic(m2, predVals = predVals2,
              interval = "confidence",
              level = 0.95))
(m2.p90 <- predictOMatic(m2, predVals = predVals2, 
              interval = "confidence",
              level = 0.90))
(m2.p80 <- predictOMatic(m2, predVals = predVals2,
              interval = "confidence",
              level = 0.80))
m2cis <- merge(m2.p95, m2.p90, by = c("yearf", "hourslog", "fit"), suffix = c("95", "90"))
m2cis <- merge(m2cis, m2.p80, by = c("yearf", "hourslog", "fit"), suffix = c("", "80"))
m2cis$hourslog <- NULL
m2cis

m3 <- glm(accidents ~ offset(hourslog) + 1 + yearf + junjul,
          dat = fire, family = "poisson")
summary(m3)

nd <- data.frame(hourslog = log(200000), yearf = c("2016", "2017"),
                 junjul = factor(c("no", "jj"), levels = c("no", "jj")))
(m3.p <- predict(m3, newdata = nd, se.fit = TRUE))
exp(m3.p$fit)


predVals3 <- list(hourslog = log(200000),
                 yearf= c("2016", "2017"),
                 junjul = c("no", "jj"))
(m3.p95 <- predictOMatic(m3, predVals = predVals3,
              interval = "confidence",
              level = 0.95))


(m3.p90 <- predictOMatic(m3, predVals = predVals3),
                         interval = "confidence",
                         level = 0.90))
(m3.p80 <- predictOMatic(m3, predVals = predVals3,
                         interval = "confidence",  level = 0.80))
m3cis <- merge(m3.p95, m3.p90, by = c("yearf", "hourslog", "fit"), suffix = c("95", "90"))
m3cis <- merge(m3cis, m3.p80, by = c("yearf", "hourslog", "fit"), suffix = c("", "80"))
m3cis

 
## Note: The residual deviance of m3 is slightly higher
## than the degrees of freedom. This variable may be "overdispersed", it has
## higher variance than the Poisson allows.

                 
library(AER)
dispersiontest(m3)



## Note poi.obs.pred does not help because of rate transformation
## library(COUNT)
## m3pp <- poi.obs.pred(30, m3)

## If there were overdispersion, which there is not, we could employ
## a Negative Binomial model.


library(MASS)

nb2 <- glm.nb(accidents ~ offset(hourslog) + yearf, fire,
             control =  glm.control(epsilon = 1e-10, maxit = 1000, trace = TRUE))

summary(nb2)


nb3 <- glm.nb(accidents ~ offset(hourslog) + yearf + junjul, fire,
             control =  glm.control(epsilon = 1e-10, maxit = 1000, trace = TRUE))

summary(nb3)
(nb3.p <- predict(nb3, newdata = nd, se.fit = TRUE))
## Note the predicted number is same
exp(nb3.p$fit)

library(COUNT)
dd <- ml.nb2(accidents ~  yearf + junjul, fire, offset = fire$hourslog)
dd


## Ignore row 3, it is not logically meaningful
(nb3.p95 <- predictOMatic(nb3, predVals = list(hourslog = log(200000),
                                             yearf= c("2016", "2017"),
                                             junjul = c("no", "jj")),
              interval = "confidence",
              level = 0.95))
(nb3.p90 <- predictOMatic(nb3, predVals = list(hourslog = log(200000),
                                             yearf= c("2016", "2017"),
                                             junjul = c("no", "jj")),
                         interval = "confidence",
                         level = 0.90))
(nb3.p80 <- predictOMatic(nb3, predVals = list(hourslog = log(200000),
                                             yearf= c("2016", "2017"),
                                             junjul = c("no", "jj")),
                         interval = "confidence",
                         level = 0.80))

## If we were in the "robust variance matrix" crowd, we could play
## around with the estimation and standard errors, but in this
## case not necessary
library(sandwich)
library(lmtest)
coeftest(m3, vcov=sandwich)
coeftest(nb3, vcov = sandwich)



## Using rateratio.test comparing poissoon rates
library(rateratio.test)

for(i in 1:(nrow(nd) - 1)) {
    out <- rateratio.test(x = c(nd$accidents[i], 0),
                          n = c(nd$hours[i], (200000/12)),
                          RR = 1,
                          alternative = "greater")
    print(c(out$p.value, out$conf.int))
}

rate2016 <- (sum(nd$accidents[nd$year == "2016"]) * 200000) /
    (sum(nd$hours[nd$year == "2016"]))

rate2017 <- (sum(nd$accidents[nd$year == "2017"], na.rm = TRUE) * 200000) /
    (sum(nd$hours[nd$year == "2017"], na.rm = TRUE))

## Number of accidents assumed by 2.5 OSHA in 2016
(2.5 *  (sum(nd$hours[nd$year == "2016"]))) / 200000

## Comparing observed rate against assumed rate
rateratio.test(x = c(sum(nd$accidents[nd$year == "2016"]), 206),
               n = c(sum(nd$hours[nd$year == "2016"]), 200000),
               alternative = "less")

## NUmber of accidents assumed by 2.5 OSHA in 2017
(2.5 *  (sum(nd$hours[nd$year == "2017"], na.rm = TRUE))) / 200000

## Comparing observed rate against assumed rate
rateratio.test(x = c(sum(nd$accidents[nd$year == "2017"], na.rm = TRUE), 199),
               n = c(sum(nd$hours[nd$year == "2017"], na.rm = TRUE), 200000),
               alternative = "less")


## Poisson regressions using yearly observations 

## Creating yearly accidents column
nd$yearAccidents[nd$year == "2016"] <- sum(nd$accidents[nd$year == "2016"])
nd$yearAccidents[nd$year == "2017"] <- sum(nd$accidents[nd$year == "2017"], na.rm = TRUE)

## Creating yearly hours column
nd$yearHours[nd$year == "2016"] <- sum(nd$hours[nd$year == "2016"])
nd$yearHours[nd$year == "2017"] <- sum(nd$hours[nd$year == "2017"], na.rm = TRUE)

## Creating log hour column
nd$yearHoursLog <- log(nd$yearHours)

## Replicating m2 using yearly accidents and hours
m2a <- glm(yearAccidents ~ offset(yearHoursLog) + yearf, data = nd, family = "poisson")

summary(m2a)
summary(m2)

(m2a.p <- predict(m2a, newdata = nd, se.fit = TRUE))
exp(m2a.p$fit)
(m2.p <- predict(m2, newdata = nd, se.fit = TRUE))
exp(m2.p$fit)

(m2a.p95 <- predictOMatic(m2a, predVals = list(yearHoursLog = log(200000),
                                               yearf= c("2016", "2017")),
                         interval = "confidence",
                         level = 0.95))

(m2.p95 <- predictOMatic(m2, predVals = list(hourslog = log(200000),
                                             yearf= c("2016", "2017")),
                         interval = "confidence",
                         level = 0.95))




## Sidetrack: compare to aggreated data 
fireagg <- aggregate(fire[ , c("accidents", "hours")] , list(year = fire$year), sum, na.rm=TRUE)
fireagg$hourslog <- log(fireagg$hours)
fireagg$yearf <- factor(fireagg$year)

m2.agg <- glm(accidents ~ offset(hourslog) + 1 + yearf, fireagg, family = "poisson")
summary(m2.agg)

## Note following is exact same as model using the monthly data
predictOMatic(m2.agg, predVals = list(hourslog = log(200000),
                                             yearf= c("2016", "2017")),
              interval = "confidence",
              level = 0.95)
