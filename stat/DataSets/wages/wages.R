## Example Code to access the data "wages.txt" from R
## Paul Johnson 2011-08-09

dat <- read.table("wages.txt", header=T, sep="")
colnames(dat) <- tolower(colnames(dat))

plot(dat)


### Following code was made in preparation for a lecture
### about categorical (or "factor") variables. It examines
### how we ought to code "occupation" in a model.


dat$racef <- factor(dat$race, labels=c("Other", "Hispanic","White"))
dat$occupationf <- factor(dat$occupation, labels=c("Management", "Sales", "Clerical", "Service", "Professional", "Other"))
dat$marrf <- factor(dat$marr, levels=c("Unmarried","Married"))

#check coding
with(dat, table(race, racef) )
with(dat, table(occupation, occupationf) )
with(dat, table(marr, marrf) )


mod1 <- lm(wage ~ occupation, data=dat)

summary(mod1)

termplot(mod1, partial=T, se=T)


mod2 <- lm(wage ~ occupationf, data=dat)

summary(mod2)

termplot(mod2, partial=T, se=T)

occlev <- levels(dat$occupationf)
dat$occupationf2 <- dat$occupationf
dat$occupationf2[dat$occupationf2 %in% occlev[2:4]] <- occlev[2]

levels(dat$occupationf2)[2] <- "sales/clerk/serv"
with(dat, table(occupationf2, occupationf))

mod3 <- lm(wage ~ occupationf2, data=dat)
summary(mod3)
anova( mod2, mod3, test="F")

dat$occupationf2[dat$occupationf2 %in% occlev[5]] <- occlev[1]
levels(dat$occupationf2)[1] <- "manag/prof"
contrasts(dat$occupationf2)

dat$occupationf2 <- dat$occupationf2[, drop=T]



mod4 <- lm(wage ~ occupationf2, data=dat)
summary(mod4)
anova( mod2, mod4, test="F")



