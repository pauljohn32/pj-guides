dat <- read.table("/home/pauljohn/ps/SVN-guides/stat/DataSets/cystfibr/cystfibr.txt",header=T)



plot(height~weight, data=dat)

plot(log(height)~log(weight), data=dat)

plot(height~weight, data=dat)

mod1 <- lm (pemax ~ age + sex + height + weight, data=dat)
summary(mod1)
mod1vcov <- vcov(mod1)

coefficients(mod1)

mod1coef <- coefficients(mod1)

tnumerator <- mod1coef["height"]- mod1coef["weight"]

tdenominator <- sqrt(  mod1vcov["height","height"] +  mod1vcov["weight","weight"] - 2*mod1vcov["height","weight"] )

tdiff <- tnumerator/tdenominator
tdiff

pt(tdiff, df = mod1$df.residual )
