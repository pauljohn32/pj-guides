##Paul Johnson 2011-05-02

##Here's a nice example that shows use of Amelia
#and it compares 2 different packages for the combination and
#evaluation of the MI estimates.  The "mix" package offers the
#degrees of freedom for the estimators, whereas "mitools" does not.

## In r-help, Chuck Cleland posted this
##http://finzi.psych.upenn.edu/Rhelp10/2010-June/244113.html
## Here is an example using the Amelia package to generate imputations
##and the mitools and mix packages to make the pooled inferences.

titanic <-
read.table("http://lib.stat.cmu.edu/S/Harrell/data/ascii/titanic.txt",
sep=',', header=TRUE)

set.seed(4321)

titanic$sex[sample(nrow(titanic), 10)] <- NA
titanic$pclass[sample(nrow(titanic), 10)] <- NA
titanic$survived[sample(nrow(titanic), 10)] <- NA

library(Amelia) # generate multiple imputations
library(mitools) # for MIextract()
library(mix) # for mi.inference()

titanic.amelia <- amelia(subset(titanic,
                                select=c('survived','pclass','sex','age')),
                         m=10, noms=c('survived','pclass','sex'),
emburn=c(500,500), p2s=F)

allimplogreg <- lapply(titanic.amelia$imputations,
function(x){glm(survived ~ pclass + sex + age, family=binomial, data = x)})

mice.betas.glm <- MIextract(allimplogreg, fun=function(x){coef(x)})
mice.se.glm <- MIextract(allimplogreg, fun=function(x){sqrt(diag(vcov(x)))})

as.data.frame(mi.inference(mice.betas.glm, mice.se.glm))

# Or using only mitools for pooled inference

betas <- MIextract(allimplogreg, fun=coef)
vars <- MIextract(allimplogreg, fun=vcov)
summary(MIcombine(betas,vars))


library(mi)

load("/home/pauljohn/ps/SVN-repo/Rcourse/titanic0.Rda")
set.seed(234234)
titanic <- titanic0
titanic$sex[sample(nrow(titanic), 400)] <- NA 
titanic$pclass[sample(nrow(titanic), 400)] <- NA 
titanic$survived[sample(nrow(titanic), 400)] <- NA

ss <- subset( titanic,   select = c('survived', 'pclass', 'sex', 'age'))
inf <- mi.info(ss)
dat.transformed <- mi.preprocess(ss, inf)

IMP <- mi(dat.transformed, n.iter=400, n.imp=5, add.noise=F)


## Add embarked which can serve as a predictor
## DOES NOT CONVERGE
ss2 <- subset( titanic,   select = c('survived', 'pclass', 'sex', 'age', 'embarked'))
inf2 <- mi.info(ss2)
dat.transformed2 <- mi.preprocess(ss2, inf2)

IMP2 <- mi(dat.transformed2, n.iter=400, n.imp=5, 
       add.noise=F)



## Impose some missings in embarked, and it will converge!
titanic$embarked[sample(nrow(titanic), 400)] <- NA

ss3 <- subset( titanic,   select = c('survived', 'pclass', 'sex', 'age', 'embarked'))
inf3 <- mi.info(ss3)
dat.transformed2 <- mi.preprocess(ss3, inf3)

IMP3 <- mi(dat.transformed3, n.iter=400, n.imp=5, 
       add.noise=F)



 M2 <- glm.mi( survived ~ pclass + sex + age, IMP, family = binomial(link="logit"))
display(M2)
coef(M2)
se.coef(M2)

cbind( b= coef(M2), se=se.coef(M2), t=coef(M2)/se.coef(M2))



##mi.preprocess similar "idea" to avas in aregImpute

##like complete in mice
imputed.data.frame <- mi.data.frame(IMP, m=3) 

mi.titanic <- mi.completed(IMP)

missSex <- which(is.na(titanic$sex))
compareSex <- function(x){
  table(x[missSex,c("sex")],titanic0[missSex,c("sex")])
}
do.call("rbind", lapply(mi.titanic, compareSex))



library(mi)
library(help=mi)



library(mice)
library(mi)
miImputeNhanes2 <- mi(nhanes2, n.imp=10,  n.iter=100, add.noise=FALSE)
M1 <- lm.mi(bmi ~ hyp + chl, miImputeNhanes2)
display(M1)
cbind(b=coef(M1), se=se.coef(M1), t=coef(M1)/se.coef(M1))


?pooled
