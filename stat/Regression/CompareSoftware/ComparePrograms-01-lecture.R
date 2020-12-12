###################################################
### chunk number 1: 
###################################################
#line 16 "ComparePrograms-01-lecture.Rnw"
  if(exists("ls.enc")) options(encoding=ls.enc)


###################################################
### chunk number 2: 
###################################################
#line 66 "ComparePrograms-01-lecture.Rnw"
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### chunk number 3: Roptions
###################################################
#line 78 "ComparePrograms-01-lecture.Rnw"
options(width=100, prompt=" ", continue="  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 4.1, 1.5, 2.1) 
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)


###################################################
### chunk number 4: oregon0
###################################################
#line 116 "ComparePrograms-01-lecture.Rnw"
dat <- read.table("/home/pauljohn/ps/SVN-repo/stat/DataSets/OregonTemps/ortann.csv", header=T, sep=",")

#library(foreign)
#write.dta(dat,file="ortann.dta")


###################################################
### chunk number 5: oregon10
###################################################
#line 122 "ComparePrograms-01-lecture.Rnw"
plot(tann ~ elevation, data=dat, xlab="Elevation above sea level", ylab="Annual Average Temperature",main="")
mod <- lm (tann ~ elevation, data=dat)


###################################################
### chunk number 6: 
###################################################
#line 138 "ComparePrograms-01-lecture.Rnw"
options(width=55)


###################################################
### chunk number 7: oregon15
###################################################
#line 141 "ComparePrograms-01-lecture.Rnw"
summary(mod)


###################################################
### chunk number 8: oregon20
###################################################
#line 150 "ComparePrograms-01-lecture.Rnw"
plot(tann ~ elevation, data=dat, xlab="Elevation above sea level", ylab="Annual Average Temperature",main="")
abline(mod)


###################################################
### chunk number 9: 
###################################################
#line 157 "ComparePrograms-01-lecture.Rnw"
source("/home/pauljohn/ps/SVN-repo/stat/Regression/outreg-worked.R")


###################################################
### chunk number 10: 
###################################################
#line 164 "ComparePrograms-01-lecture.Rnw"
outreg(mod, tight=F,showAIC=F)


