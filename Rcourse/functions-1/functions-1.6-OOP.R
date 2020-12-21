### R code from vignette source '/home/pauljohn/SVN/SVN-guides/Rcourse/functions-1/functions-1.6-OOPn.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: functions-1.6-OOPn.Rnw:89-90
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 2: Roptions
###################################################
options(width=200, prompt="> ", continue=" ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par()
pjmar <- c(5.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)
ps.options(horizontal=F, onefile=F, family="Times", paper="special", height=3, width=4.75)
options(papersize="special")


###################################################
### code chunk number 3: s410
###################################################
 setClass("pjfriend", representation(
 name="character",
 gender="factor",
 food="factor",
 age="integer"))


###################################################
### code chunk number 4: s420
###################################################
william <- new("pjfriend", name = "william", gender =
  factor("male"), food=factor("pizza"), age=33L)
william

jane <- new("pjfriend", name="pumpkin", gender = factor("female"), food=factor("hamburger"), age=21L)
jane


###################################################
### code chunk number 5: s450 (eval = FALSE)
###################################################
## setMethod("some-generic-function-name", "pjfriend",
##           function(x) {
##               #do something with x
##               }
## )


