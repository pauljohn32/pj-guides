Nsampsize <- 100
x <- rnorm(Nsampsize, m=50, sd=10);
b0 <- 3; b1 <- 0.25; stde <- 10;
simrhomo <- function(i){
e <- rnorm(Nsampsize, m=0, s=1)
y <- b0 + b1 * x + stde*e
mod <- lm(y ~ x)
print(mod)
##abline(mod, col=gray(.7))
mod
}
nsims <- 1000
reshomo <- lapply(1:nsims, simrhomo)

e <- rnorm(Nsampsize, m=0, s=1)
y <- b0 + b1 * x + stde*e

plot(y~x, main="Homoskedastic Variance")
lapply(reshomo, abline, col=gray(0.70))
abline(b0,b1,col="red")




