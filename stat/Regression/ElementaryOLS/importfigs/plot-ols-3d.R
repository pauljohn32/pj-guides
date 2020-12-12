##Paul Johnson
## draw 3d model of OLS minimization

set.seed(2342423)
x1 <- rnorm(100)
y1 <- 0.4 + 0.8 * x1 + rnorm(100)
dat <- data.frame(x1, y1)

b0 = seq(-2, 2, by = 0.2)
b1 = seq(-2, 2, by = 0.2)


## A vectorized sum-of-squared errors calcuator
## Need this to use outer
sserrorVec <- function(b0, b1, dat){
    step1 <- kronecker(t(b1), dat$x1)
    step2 <- matrix(rep(b0, each=100), nrow= 100)
    predVals <- (step1 + step2)
    resid <- (dat$y - predVals)
    rsq <- colSums(resid^2)
}


m1 <- lm(y1 ~ x1, data = dat)
ssmat <- outer(b0, b1, FUN="sserrorVec", dat)


## plot3d functions want same info in various formats
## betas <- expand.grid(b0 = b0, b1 = b1)

## sserrorBetas <- function(betas, dat){
##     ypred <- betas[1] + betas[2] * dat$x1
##     sum( (dat$y1 - ypred)^2 )
## }

## betas$sserrors <- apply(betas, 1, sserrorBetas, dat)


library(rockchalk)


yrange <- range(c(-200, ssmat))

SAVE <- TRUE
if(SAVE) pdf(file = "OLSdemo-3d.pdf", paper = "special", height = 6, width = 6, family = "Times")

res <- perspEmpty(x1 = plotSeq(b0, 7), x2 = plotSeq(b1, 7),
                  y = plotSeq(yrange, 10),
                  x1lab = "hat b0",
                  x2lab = "hat b1",
                  ylab = "Sum of Squared Residuals",
                  ticktype = "detailed",
                  nticks = 5,
                  col = gray(.97),
                  phi = 05, theta = 130 )

for (i in 1: length(b0)) {
    lines(trans3d(b0[i], b1, ssmat[i, ], pmat = res),
          lwd = 0.5, col = 1, lty = 4)
}

for (j in 1:length(b1)) {
    lines(trans3d(b0, b1[j], ssmat[, j], pmat = res),
          lwd = 0.5, col = 1, lty = 2)
}


solv1 <- c(coef(m1)[1], coef(m1)[2], yrange[1])

points(trans3d(solv1[1], solv1[2], solv1[3], pmat = res), col = "red", pch= 18)

if(SAVE) dev.off()




