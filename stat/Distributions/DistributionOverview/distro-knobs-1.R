## Paul Johnson
## 2014-02-05

## Distributions: Where are the knobs? What does it mean to turn
## them

set.seed(1000)


## Normal distribution. The knobs are m and s, the "true mean"
## and "true standard deviation", which might also be called
## "mu" and "sigma"
x1 <- rnorm(1000, m = 0, s = 1)
hist(x1, xlim = c(-10, 10), prob = TRUE)


parms <- list(c( m = 0, s = 1), c(m = 5, s = 1), c(m = 0, s = 3))

dev.off()
par(mfrow = c(2,2))
for(i in 1:3){
    x1 <- rnorm(1000, m = parms[[i]]["m"], s = parms[[i]]["s"])
    hist(x1, xlim = c(-10, 10), ylim = c(0, 0.5),  prob = TRUE,
         breaks = seq(min(x1) - 0.2, max(x1) + 0.2, by = 0.2), 
         main = paste0("Normal(", parms[[i]]["m"],", ", parms[[i]]["s"], ")"),
         border = "gray70")
    lines(density(x1))
}
    

dev.off()
par(mfrow = c(2,2))

for(i in c(1, 3, 15)){

    x1 <- rpois(1000, lambda = i)
    hist(x1, xlim = c(0, 30), ylim = c(0, 1),  prob = TRUE,
         main = paste("lambda = ", i))
}
