## Paul Johnson
## 2014-02-05



## Distributions: Visualize Covariance = 0

x1 <- rnorm(1, m = 0, s = 1)
x2 <- rnorm(1, m = 0, s = 1)

plot(-3:3, -3:3, type = "n")
abline(h = 0, lty = 4)
abline(v = 0, lty = 4)

points(x1, x2)

x1 <- rnorm(1, m = 0, s = 1)
x2 <- rnorm(1, m = 0, s = 1)
points(x1, x2)

x1 <- rnorm(1, m = 0, s = 1)
x2 <- rnorm(1, m = 0, s = 1)
text(x1, x2, "3")

x1 <- rnorm(1, m = 0, s = 1)
x2 <- rnorm(1, m = 0, s = 1)
text(x1, x2, "4")

x1 <- rnorm(1, m = 0, s = 1)
x2 <- rnorm(1, m = 0, s = 1)
text(x1, x2, "5")


for (i in 6:100){
    x1 <- rnorm(1, m = 0, s = 1)
    x2 <- rnorm(1, m = 0, s = 1)
    text(x1, x2, i)
}


## Now, lets manufacture 2 variables that have a positive covariance.
## This is a fairly common way to do it.

## First, collect 100 values for x1

x1 <- rnorm(100, m = 0, s = 1)

## Second, collect some "noise" data. Call it e1. It is truly uncorrelated with x1

e1 <- rnorm(100, m = 0, s = 1)

## Create x2 that is partly a reflection of x1 and partly of e1

x2 <- x1 + e1

plot(-3:3, -3:3, type = "n")
abline(h = 0, lty = 4)
abline(v = 0, lty = 4)
points(x1, x2)
cov(x1, x2)
legend("topleft", legend = c("'True' Covariance = 1.0"))

x2 <- - x1 + e1
plot(-3:3, -3:3, type = "n")
abline(h = 0, lty = 4)
abline(v = 0, lty = 4)
points(x1, x2)
cov(x1, x2)
legend("topleft", legend = c("'True' Covariance = 11.0"))


