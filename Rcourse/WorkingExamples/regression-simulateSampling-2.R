## ols2.r
## PJ Feb. 8, 2002
## This is a little fancier version of ols1. This one
## highlights the fact that the standard error of b estimated
## in an individual run are close to the true standard deviation
## of b in its sampling distribution.

nOfRuns <- 100
a <- 2    #intercept parameter
b <- 5    #slope parameter
stderror <- 3  #standard deviation of error term

getPhonyData <- function (x){
  e<-rnorm(1000,sd=stderror)
  y<-b + b*x + e
}

x<- rnorm(1000,mean=10,sd=7)

conductSim <- function(i){
  y<-getPhonyData(x)  #x is grabbed from environment
  try(lm(y~x)) #output of last command is returned
}

## use lapply to run the sim over and over, stuff
## estimate objects into a list called result
result <- lapply(1:nOfRuns, conductSim)

## Get the estimates from run i
## Note you get the i'th one by result[[i]].
## here I take all coefficients
getCoeff <- function(i){result[[i]]$coefficients}

## collect up parameter estimates from all runs 
paramvector <- sapply(1:nOfRuns,getCoeff)

## get standard errors of estimates of "a" and "b" from run i
## second column of coefficients in summary is the standard errors
## so grab them.  There must be an easier way!
getSE <- function(i){summary(result[[i]])$coefficients[,2] }

## collect up standard errors of "a" and "b" from runs
sevector <- sapply(1:nOfRuns,getSE)

## print those out for fun
sevector

## the average of estimates of b across runs
meanb <- mean(paramvector[2,])
meanb
## the standard deviation of estimates of b across runs
stdb <- sd(paramvector[2,])
stdb 

hist(paramvector[2,])
text(x = 4.96, y = 20, paste("The true value of b is ", b))
text(x = 4.96, y = 15, paste("The average of the estimates \n of b is ", meanb))


## average of estimated standard errors of b
meanseb <- mean(sevector[2,])

## new histogram!
hist(sevector[2,], main="Sampling Distribution of Estimates of the Standard Error of b")

text(x = 0.0128, y = 24, adj = 0, paste("Std.Dev. of sampling dist of b= ", stdb))
text(x = 0.0128, y = 20, adj = 0, paste("The of mean se(b) was ", meanseb))
text(x = 0.0128, y = 15, adj = 0, paste ("The true sd(b) is ", stderror/sqrt(sum((x-mean(x))*(x-mean(x))))))
