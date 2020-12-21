#PJ
# 2003-08-30

# This is a program I wrote in 2002 to show what would
# happen if you really could calculate regression estimates
# for many repeated samples.  IT makes a histogram showing
# the variation in slope estimates.

# The later program, ols2, makes a little fancier output.


# The number of samples to collect is:
nOfRuns <- 100

a <- 2    #intercept parameter
b <- 5    #slope parameter
stderror <- 3  #standard deviation of error term


# This function creates some data to use in a regression.
# Note we are treating the x as a fixed thing in the exercise.
# Because the last element here creates y, y gets returned by
# this function.
getPhonyData <- function (x){
    e <-rnorm(1000,mean=0,sd=stderror)
    y <- a + b*x + e
}


# This is the column for the input variable.
# We use the same inputs for every sample of error terms/ dependant
# variables.
x <- 10+5*rnorm(1000)

conductSim <- function(i){
  y<-getPhonyData(x)  #x is grabbed from environment
  try(lm(y~x)) #output of last command is returned
}

result <- lapply(1:nOfRuns, conductSim)

#result is a list of model results. You can get the i'th one by
#result[[i]].

#collect up the estimates of "b"
getB <- function(i){result[[i]]$coefficients[2]}

#collect up estimated standard errors

bvector <- sapply(1:nOfRuns,getB)

meanb <- mean(bvector)
sdb <- sd(bvector)

hist(bvector,main="Sampling distribution of b")

text(x=5.02,y=20,paste("The true value of b is ", b))
text(x=5.02,y=15,paste("The average of the estimates \n of b is ", meanb))
text (x=5.02,y=10,paste("The standard deviation of estimates is \n of b is ", sdb))

