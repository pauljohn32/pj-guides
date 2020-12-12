## academicsalary.R
## Paul Johnson <pauljohn@ku.edu>
## 2011-08-23

dat <- read.table("academicsalary.txt", header=T, sep="\t")

##I prefer lower case variable names
## Change DEPART PUB TIME    SALARY SEX
colnames(dat) <- tolower(colnames(dat))
## To "depart" "pub"    "time"   "salary" "sex"  
colnames(dat)

## Note department is not a factor, so convert
dat$departf <- factor(dat$depart, labels=c("psychology","sociology","history"))
## Make sure that's not wrong
table(dat$depart, dat$departf)

## Same for sex
dat$sexf <- factor(dat$sex, labels=c("Male","Female"))
table(dat$sex, dat$sexf)


with(dat, hist(salary/1000, prob=T, xlab="salary (1000s)"))


plot(salary ~ pub, data=dat)

mod1 <- lm(salary~pub, data=dat)
summary(mod1)

mod2 <- lm(salary~pub+time, data=dat)
summary(mod1)

mod3 <- lm(salary~pub+time+departf, data=dat)
summary(mod3)

drop1(mod3, test="F")
anova(mod3, mod2,test="F")
#Note previous same where settings coincide

termplot(mod3, partial.resid=T, se=T )



mod4 <- lm(salary~pub+time+departf+sex*pub, data=dat)
summary(mod4)
anova(mod4)

drop1(mod4, test="F")


coplot(salary~pub| departf * sex, data=dat)
###I may never understand coplot panels or xyplot.


library(car)
vif(mod4)
