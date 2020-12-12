## data on temperature in Oregon
##  http://geography.uoregon.edu/bartlein/courses/geog417/exercises/ex7.htm

dat <- read.table("ortann.csv", header=T, sep=",")

plot(tann ~ elevation, data=dat)

mod <- lm (tann ~ elevation, data=dat)

abline(mod)

summary(mod)

