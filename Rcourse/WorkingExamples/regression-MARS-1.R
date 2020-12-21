## Paul Johnson <pauljohn@ku.edu>
## 2014-05-28
## MARS: Multivariate Adaptive Regression Splines


## I found it a bit difficult to interact with the
## MARS fitted objects created by the functions in
## the mda package.  Later, I found a very nice
## package "earth" with an implementation of MARS

## As far as I can see, estimates from earth are
## same, but the follow up methods and summary 
## printout are much better.


library(earth)

x <- rnorm(1000, 50, 20)
y <- 11.2*x -.21*x^2 + rnorm(1000, m = 0, s = 79)
df <- data.frame(x,y)
m3 <- earth(y ~ x, dat = df)
summary(m3)
plot(y ~ x, data = df)
xnew = seq_along(x)
ppp <- predict(m3, newdata = data.frame(x = xnew))
lines(ppp ~ xnew, data = df, col = "red", lwd = 2)


m3 <- earth(y ~ x, dat = df, degree = 3, trace = 1)
summary(m3)
plot(y ~ x, data = df)
xnew = seq_along(x)
ppp <- predict(m3, newdata = data.frame(x = xnew))
lines(ppp ~ xnew, data = df, col = "red", lwd = 2)

