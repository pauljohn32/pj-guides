x <- 10 * runif(100)

y <- 5*sin(x)+rnorm(100)

plot (x, y, main="Curvish data from Locfit example", pch=16)

library(mgcv)


mygam <- gam(y~s(x), fit=F)
mymgfit <- mgcv( mygam$y, mygam$X,mygam$sp, mygam$S, mygam$off, C=mygam$C) 
mygam <- gam(y~s(x))
