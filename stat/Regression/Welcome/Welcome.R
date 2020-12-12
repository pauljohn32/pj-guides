### R code from vignette source '/tmp/lyx_tmpdir.MT4662/lyx_tmpbuf2/Welcome.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Welcome.Rnw:43-44
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Welcome.Rnw:103-105
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=T)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 4.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: example1
###################################################
dat <- read.table("/home/pauljohn/SVN/SVN-guides/stat/DataSets/AcademicSalary/academicsalary.txt", header = TRUE, sep = "\t")


###################################################
### code chunk number 5: example10 (eval = FALSE)
###################################################
## ## Could use R's summary function, but 
## ## rockchalk summarize is my favorite
## library(rockchalk)
## summarize(dat)


###################################################
### code chunk number 6: example11
###################################################
## Could use R's summary function, but 
## rockchalk summarize is my favorite
library(rockchalk)
summarize(dat)


