### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.HiGLfXV14373/lyx_tmpbuf0/GLM-2-guide.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: GLM-2-guide.Rnw:20-21
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: 0
###################################################
options(useFancyQuotes=FALSE)
library(faraway) 
gavote$undercount <- gavote$ballots - gavote$votes 


###################################################
### code chunk number 3: 1
###################################################
myPois1<- glm(undercount ~ rural+perAA+equip, family=poisson, data=gavote)
summary(myPois1) 


###################################################
### code chunk number 4: GLM-2-guide.Rnw:249-253
###################################################
anova(myPois1,test="Chisq")
drop1(myPois1, test="Chisq")
library(car)
Anova(myPois1)


###################################################
### code chunk number 5: GLM-2-guide.Rnw:259-262
###################################################
myPois2<- glm(undercount ~ equip, family=poisson, data=gavote)
summary(myPois2) 
anova(myPois2, myPois1,  test="Chisq")


