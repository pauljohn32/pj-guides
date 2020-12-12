TIME <- rep(1:5, 20)
STATENAM <- 1:20
STATE <- STATENAM %x% rep(1,5)

dat <- data.frame(STATE=c(STATE),TIME=c(TIME))

ranInt <- rnorm(length(STATENAM),0,15)


dat$ranInt <- c(ranInt %x% rep(1,5))


statex1 <- rep(0, length(dat$TIME))
statex1[STATE < 6] <- 0
statex1[STATE >= 6] <- 1
statex1[STATE > 14] <- 2

dat$statex1 <- factor(statex1)
dat$statex2 <- rnorm(length(dat$STATE),6, 5)
E <- rnorm(length(dat$STATE),0, 5)

dat$y <- 50 + dat$ranInt + 6*as.numeric(dat$statex1) + 3* dat$statex2 + E
dat

 yunstack <- unstack(dat$y, form = dat$y~ dat$STATE)
 x2unstack <- unstack(dat$statex2, form= dat$statex2~dat$STATE)


matplot(x2unstack,yunstack,type="p",pch=1:20)

fit1 <- lm (y ~ statex2, data=dat)

abline(fit1)

matplot(x2unstack,yunstack,type="p",pch=as.character(1:20))

plot(dat$statex2,dat$y,type="n")
lines(x2unstack[[1]],yunstack[[1]])
lines(x2unstack[[16]],yunstack[[16]])


 myColors <- as.character(dat$STATE)
 myColors[dat$statex1==0]<- "red"
 myColors[dat$statex1==1]<- "blue"
 myColors[dat$statex1==2]<- "black"
 plot(dat$statex2,dat$y,type="n")
 text(dat$statex2, dat$y, as.character(dat$STATE),col=myColors)
 abline(fit1)

fit2 <- lm (y ~ statex2+statex1, data=dat)
summary(fit2)

library(nlme)
fitlme1 <- lme(fixed=y~statex1+statex2, data=dat, random=~1 | STATE)
summary(nlme)


library(gee)
geefit1 <- gee(y ~ statex1+statex2, data=dat, id=STATE)
summary(geefit1)
