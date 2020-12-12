
set.seed(1234)
## Create an alphabetic variable
xcat <- c("yes","no","yes","no","maybe","yes","maybe","maybe","no","yes")

xcatf <- factor(xcat) 

y <- rnorm(10) ##a dependent variable

is.factor(xcat)
is.factor(xcatf)


mod1 <- lm(y ~ xcatf)
summary(mod1)
anova(mod1, test="F")


mod1n <- lm(y ~ -1 + xcatf)
summary(mod1n)
anova(mod1n, test="F")

##Ask for means of y for each value of xcatf
by(y, xcatf, mean)



## Create another categorical variable, but with levels in different order


xcatf2 <- factor(xcat, levels=c("yes","maybe","no"))


## Absorb xcat again, taking the existing levels in a given order,  but use new ## labels for them in the future
xcatf3 <- factor(xcat, levels=c("yes","maybe","no"), labels=c("aff","neut","neg"))

str(xcatf)
str(xcatf2)
str(xcatf3)
cbind(xcat, xcatf, xcatf2, xcatf3)

levels(xcatf)
levels(xcatf2)
levels(xcatf3)


mod1 <- lm(y ~ xcatf)
summary(mod1)



mod1 <- lm(y ~ xcatf)
summary(mod1)
