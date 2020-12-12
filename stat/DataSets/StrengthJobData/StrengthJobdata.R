dat <- read.table("StrengthJobdata.txt", header=T)

str(dat)

sumdat <- apply(dat, 2, quantile)
sumdat <- rbind(sumdat, mean= apply(dat, 2, mean))
sumdat <- rbind(sumdat, sd= apply(dat, 2, sd))
sumdat <- rbind(sumdat, var= apply(dat, 2, var))
sumdat

##Caution. If there were many of these, repeated rbind is very slow, try instead:
## sumresults <- list()
## sumresults[[1]] <- apply(dat, 2, quantile) 
## sumresults[[2]] <- apply(dat, 2, mean) 
## sumresults[[3]] <- apply(dat, 2, sd) 
## sumresults[[4]] <- apply(dat, 2, var) 
## sumdat <- do.call("rbind", sumresults)
## rm(sumresults)
## sumdat


par(mfcol=c(2,2))
hist(dat$GRIP, prob=T, xlab="Grip strength")
curve(dnorm(x, m=sumdat["mean","GRIP"], s=sumdat["sd", "GRIP"]), from= range(dat$GRIP)[1], to = range(dat$GRIP)[2], add=TRUE)
hist(dat$ARM, prob=T, xlab="Arm strength")
curve(dnorm(x, m=sumdat["mean","ARM"], s=sumdat["sd", "ARM"]), from= range(dat$ARM)[1], to = range(dat$ARM)[2], add=TRUE)
hist(dat$RATINGS, prob=T, xlab="Supervisor Rating")
curve(dnorm(x, m=sumdat["mean","RATINGS"], s=sumdat["sd", "RATINGS"]), from= range(dat$RATINGS)[1], to = range(dat$RATINGS)[2], add=TRUE)
hist(dat$SIMS, prob=T, xlab="Sims Wrench Test")
curve(dnorm(x, m=sumdat["mean","SIMS"], s=sumdat["sd", "SIMS"]), from= range(dat$SIMS)[1], to = range(dat$SIMS)[2], add=TRUE)

par(mfcol=c(1,1))
plot(dat)


## I suppose the question is whether the worker's
## evaluation reflects strength
m1 <- lm(RATINGS ~ GRIP, data = dat)
summary(m1)

plot(RATINGS ~ GRIP, data = dat)
abline(m1)


m2 <- lm(RATINGS ~ ARM, data = dat)
summary(m2)


## Too easy
m3 <- lm(ARM ~ GRIP, data=dat)
summary(m3)


m4 <- lm(SIMS ~ GRIP, data=dat)
summary(m4)
