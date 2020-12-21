library(car)
data(Chile)


mod1 <- lm ( statusquo ~ income , data=Chile)
summary(mod1)


source ("../R/outreg-worked.R")
### Caution. income effect rounded to 0. Can't accept that

outreg(mod1)


mod2 <- lm(statusquo ~ income + sex, data=Chile)
summary(mod2)

outreg(mod2)


plot(statusquo ~ income, data=Chile, type="n")
points(statusquo~income, data=Chile, col=sex)

incrange <- range(Chile$income, na.rm=T)
pseqincome <- seq(incrange[1], incrange[2], length.out=5)

justwomen <- predict(mod2, newdata=data.frame(income=pseqincome, sex=levels(Chile$sex)[1]))

justmen <- predict(mod2, newdata=data.frame(income=pseqincome, sex=levels(Chile$sex)[2]))

lines(pseqincome, justwomen, col=1)
lines(pseqincome, justmen, col=2)
legend("topleft", c("Female","Male"), col=c(1,2), lty=1)

## Note, also works to do

plot(statusquo ~ income, data=Chile, type="n")
points(statusquo~income, data=Chile, col=sex)
incrange <- range(Chile$income, na.rm=T)
pseqincome <- seq(incrange[1], incrange[2], length.out=5)

mynewdf <- expand.grid(income=pseqincome, sex=levels(Chile$sex))

mynewdf$pred <- predict(mod2, mynewdf)

by(mynewdf, mynewdf$sex, function(dat) lines(dat$income, dat$pred, col=as.numeric(dat$sex)))
legend("topleft", levels(mynewdf$sex), col=c(1,2), lty=1)


###############


mod3 <- lm(statusquo ~ income + sex + region, data=Chile)
summary(mod3)

outreg(mod3)
## note: fix the income output

plot(statusquo ~ income, data=Chile, type="n")
points(statusquo~income, data=Chile, col=sex)
incrange <- range(Chile$income, na.rm=T)
pseqincome <- seq(incrange[1], incrange[2], length.out=5)

mynewdf <- expand.grid(income=pseqincome, sex=levels(Chile$sex)[1], region=levels(Chile$region))

mynewdf$pred <- predict(mod3, mynewdf)


by(mynewdf, mynewdf$region, function(dat) lines(dat$income, dat$pred, col=as.numeric(dat$region)))
legend(160000, -0.6, levels(mynewdf$region), col=1:length(levels(mynewdf$region)), lty=1, bg="white")


plot(statusquo ~ income, data=Chile, type="n", xlab="Income (10000s of pesos)",ylab="Support for Status Quo (scale)") 
points(statusquo~income, data=Chile, col=sex)
incrange <- range(Chile$income, na.rm=T) 
pseqincome <- seq(incrange[1], incrange[2], length.out=5)
justwomen <- data.frame(income=pseqincome, sex=levels(Chile$sex)[1])
justwomen$p <- predict(mod2, newdata= justwomen)
justmen <- data.frame(income=pseqincome, sex=levels(Chile$sex)[2])
justmen$p <- predict(mod2, newdata=justmen)
lines(p~pseqincome, data=justwomen, col=1) 
lines(p~pseqincome, data=justmen, col=2) 
legend("topleft", c("Female","Male"), col=c(1,2), lty=1, bg="white") 
