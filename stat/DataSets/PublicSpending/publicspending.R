dat <- read.table("publicspending.txt",header=T)

plot(EX ~ ECAB, data=dat)

plot(log(EX) ~ log(ECAB), data=dat)

mod <- lm(EX ~ ECAB + MET + GROW + OLD + YOUNG + WEST, data=dat)
summary(mod)
anova(mod)
drop1(mod,test="Chisq")

termplot(mod, partial.resid=T, rug=T, se=T)

termplot(mod, partial.resid=T, rug=T, se=T, smooth=panel.smooth, span.smth=1/2)


#a not strong relationship
plot(EX~YOUNG, data=dat)

plot(EX~MET, data=dat)

modsq1 <- lm(EX ~ poly(MET,2), data=dat)
summary(modsq1)

modsq2 <- lm(EX ~ MET + I(MET*MET), data=dat)
summary(modsq2)

p1 <- predict(modsq1)
p2 <- predict(modsq2)
rMET <- range(dat$MET)

df <- cbind(mean(dat[,1:5]), MET=seq(rMET[1],rMET[2],length.out=20))
cbind(df, 

predict(modsq1,  terms="MET")
      
p <- predict(modsq1, newdata=df)




termplot(mod, partial.resid=T, rug=T, se=T, terms="YOUNG")

dat2 <- expand.grid(YOUNG=range(dat$YOUNG),ECAB=range(dat$ECAB), GROW=range(GROW=dat$GROW), MET=range(MET=dat$MET))

p1 <- predict(mod, newdata=dat2)
dat2 <- cbind(p1,dat2)

lines(dat2$YOUNG, dat2$p1)


plot(EX ~ MET, data=dat)
msq <- lm(EX ~ MET*MET, data=dat)
summary(msq)


library(gam)
modlo <- gam( EX ~ ECAB + lo(MET) + GROW, data=dat)
summary(modlo)


modpoly <- gam( EX ~ ECAB + poly(MET,3) + GROW, data=dat)
plot(modpoly)
