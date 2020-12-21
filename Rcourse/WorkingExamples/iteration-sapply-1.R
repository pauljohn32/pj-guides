## Paul Johnson
## 2013-02-18

## response to Fan's question about assingment.

myMu <- rep(0, 1000)


getNormalMean <- function(mu, sigma, N){
    e <- rnorm(N, m = mu, sd = sigma)
    mean(e)
}

##first arg is "mu" from myMu.
myMeans1 <- sapply(myMu, getNormalMean, sigma=23, N = 15)

hist(myMeans1)



getPoissonMean <- function(lambda, N){
    e <- rpois(N, l = lambda)
    mean(e)
}



myLambda <- rep(0.7, 1000)

myMeans2 <- sapply(myLambda, getPoissonMean, N = 10)



myLambda <- rep(0.7, 1000)

myMeans2 <- sapply(myLambda, getPoissonMean, N = 1500)

hist(myMeans2, prob = TRUE)
lines(density(myMeans2))



