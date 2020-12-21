## Paul E. Johnson
## 2013-05-17

## This is another worked example dealing with R's predict function
## and new data. It uses the USNews college data from the 1970s.

## Remember the mantra
## 1. fit regression
## 2. make newdata object of example predictors
## 3. predict(model, newdata) to get predictions.

library(rockchalk)

## download the file if you don't have the data yet
dat <- read.table(url("http://pj.freefaculty.org/guides/stat/DataSets/USNewsCollege/USNewsCollege.csv"),  sep = ",")

##dat <- read.table("/home/pauljohn/ps/SVN-guides/stat/DataSets/USNewsCollege/USNewsCollege.csv", sep=",")

colnames(dat) <- c("fice", "name", "state", "private",
    "avemath", "aveverb", "avecomb", "aveact", "fstmath", "trdmath",
    "fstverb", "trdverb", "fstact", "trdact", "numapps", "numacc",
    "numenr", "pctten", "pctquart", "numfull", "numpart", "instate",
    "outstate", "rmbrdcst", "roomcst", "brdcst", "addfees", "bookcst",
    "prsnl", "pctphd", "pctterm", "stdtofac", "pctdonat", "instcst",
    "gradrate")

dat$private <- factor(dat$private, labels = c("public", "private"))

dat <- dat[dat$instcst < 15000, ]

m1 <- lm (aveact ~ private  + numapps + pctten + stdtofac + pctphd + instcst , data=dat)
summary(m1)



## Now I want to run
## predict(m1, newdata = newdat)
##
## where newdat needs to be something like:
##
## > newdat
##   trdact  numapps   pctten stdtofac   pctphd private instcst
## 25.04478 2425.142 23.89552 14.94975 68.68905  public    2520
## 25.04478 2425.142 23.89552 14.94975 68.68905 private    2520
## 25.04478 2425.142 23.89552 14.94975 68.68905  public   14847
## 25.04478 2425.142 23.89552 14.94975 68.68905 private   14847

## That includes the mean values for trdact numapps pctten stdtofac
## pctphd and particular values of instcst and private for which we
## want predicted values in order to make the plot.
##

## It seems to me this should not be so tedious, and plotSlopes in
## rockchalk does the work.
##
## But there may be times when plotSlopes does not suit one's purpose,
##
## So here is a "manual" way to do it.  This does not use any
## facilitating code from rockchalk, just tools in R itself.

## 1. grab the data frame that was used to fit the model (as a
## starting point)

newdat1 <- model.frame(m1)

## 2. the exemplar variables for private and instcst.
mixAndMatch  <- expand.grid(private = levels(newdat1$private),
                     instcst = range(newdat1$instcst))

## 3. remove the dependent variable "aveact"
newdat1["aveact"] <- NULL
## and remove "instcst" and "private"
newdat1["instcst"] <- NULL
newdat1["private"] <- NULL

## 4. calculate the means of all of these variables.
newdat1means <- colMeans(newdat1)
## convert newdat1means to a row and put together with the
## new variables.
newdat2 <- merge(t(newdat1means), mixAndMatch)

newdat2$fit <- predict(m1, newdata = newdat2)

head(newdat2)

plot(aveact ~ instcst,  data=dat)
## Throw on some lines
by(newdat2, newdat2$private, function(x){lines(fit ~ instcst, data = x, col = x$private)})
 
## Job's done.


## However, if there were other factor variables in the model, then we
## would run into some trouble.  Since that often happens, I suppose
## it is only right to show what has to happen.
##
## So lets create a new factor variable to work on. Call it
## "expensive"

dat$cost <- ifelse(dat$outstate > mean(dat$outstate, na.rm=TRUE), "Expensive","Cheap")
dat$cost <- factor(dat$cost)

m2 <- lm (aveact ~ cost + private + numapps + pctten + stdtofac + pctphd + instcst, data = dat)
summary(m2)


## We want predicted values for various setting of the predictor.
## The standard process still holds.
## 1. Fit the regression
## 2. Make newdata
## 3. Predict with new data

## Getting the newdata object "just right" can be a hassle.  We have a
## tedious process of extracting the numeric variables, getting their
## means, and then filling in the factors.

## The end result should be a new data structure that looks like this:
##    numapps   pctten stdtofac   pctphd private      cost instcst     pred colors
## 1 2262.278 22.71048 15.18229 67.32571  public     Cheap    1834 21.33514      3
## 2 2262.278 22.71048 15.18229 67.32571 private     Cheap    1834 21.97996      5
## 3 2262.278 22.71048 15.18229 67.32571  public Expensive    1834 22.00777      4

## Here's the short cut way to get that using predictOMatic from the
## rockchalk package

predictOMatic(m2, predVals = list(private = levels(dat$private),
                      cost = levels(dat$cost), instcst = range(dat$instcst, na.rm = TRUE)))

## CAUTION. predictOMatic only works with regression models that it can
## understand (mainly, lm, glm, and a few others). If you use a different
## regression tool, it will likely fail. So you have to step back and
## 1. fit your model, 2. make new data, 3. calculate predictions.

## I can help with step 2. Observe

newdata(m2, predVals = list(private = levels(dat$private),
                cost = levels(dat$cost), instcst = range(dat$instcst, na.rm = TRUE)))


## Suppose you don't want to use rockchalk, you might be stranded on a desert
## island with only base R functions. Here's how we have to get this done.

newdat1 <- model.frame(m2)
newdat1means <- centralValues(newdat1)

## centralValues is from rockchalk. I should not use it here because
## I'm on the desert island, forgive me.

## That looks like this:
##
## > newdat1means
##  aveact  cost private   trdact  numapps   pctten stdtofac   pctphd  instcst
##  22.77958 Cheap private 25.38051 2702.497 26.40139  14.5522 70.35267 8887.181

## Suppose now we want predicted values to plot the relationship between
## aveact and instcst, for all combinations of private
## and cost.

## For the factor variables, we need to select either one or
## more example values for which to calculate predictions.

mixAndMatch <- expand.grid(private = levels(newdat1$private),
                           cost = levels(newdat1$cost),
                           instcst = range(newdat1$instcst))


## Now, in newdat1 we need to  get rid of the dependent variable
newdat1means["aveact"] <- NULL
## and remove "instcst" and "private" and "cost"
newdat1means["instcst"] <- NULL
newdat1means["private"] <- NULL
newdat1means["cost"] <- NULL

## Smash the two data frames together, job's done!
newdat2 <- merge(newdat1means, mixAndMatch)

newdat2$fit <- predict(m2, newdata = newdat2)

head(newdat2)

plot(aveact ~ instcst, data = newdat1)
## add a line for each combination of private and cost
by(newdat2, list(newdat2$private, newdat2$cost), function(x) { lines(fit ~ instcst, data = x)})



plot(aveact ~ instcst, data = newdat1, ylim=c(20,26))
## fighting to find nice way to add colors

newdat2$colors <- as.numeric(newdat2$cost) + 2* as.numeric(newdat2$private)
by(newdat2, list(newdat2$private, newdat2$cost),
   function(x) {lines(fit ~ instcst, data = x, col = x$colors, lty = x$colors, lwd = 2)})

legend("topleft",
       legend = c("Public-Cheap", "Private-Cheap", "Public-Expensive", "Private-Expensive"),
       col = newdat2$colors, lty = newdat2$colors, lwd = 2)

