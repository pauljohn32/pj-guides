### R code from vignette source 'intro-R-1-uniquebackupstring202012121635.Rnw'

###################################################
### code chunk number 1: intro-R-1-uniquebackupstring202012121635.Rnw:26-27
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: ignoremeRoptions
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)
library(stationery)
opts.orig <- options()
options(width=70, prompt="> ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly = TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 3: texcopy
###################################################
logos <- c("logo.pdf", "logomini.pdf")
## This will retrieve logo files from a designated package:
try(getFiles(logos, pkg = "stationery", overwrite = FALSE))
## If you do not have a file after that, 
## the following will manufacture a blank images for placeholders
if(!file.exists("theme/logo.pdf")){
  blankPDF(file = "theme/logo.pdf", height=1, width=2, messg = "")
}
if(!file.exists("theme/logomini.pdf")){
  blankPDF(file = "theme/logomini.pdf", height=1, width=11, messg = "")
}


###################################################
### code chunk number 4: calc1
###################################################
2+3 #addition
43 * 67 #multiplication
33/699 #division
5%%3   #modulo (remainer)
3^4 #power
log(17.44) #natural log
exp(2.33)  #exponentiation
sin(2*pi)  #sine


###################################################
### code chunk number 5: calc2
###################################################
myvector <- c(1,2,3,4,5,6,7)
sqrt(myvector)


###################################################
### code chunk number 6: calc3
###################################################
x <- c(1,2,3,4,5,6,7,8,9)
xmat <- matrix(x, ncol=3)
xmat
xmat[1,3]
xmat[ ,2]
xmat[2, ]
apply(xmat, 2, sum)


###################################################
### code chunk number 7: loadsudo
###################################################
library(sudoku)


###################################################
### code chunk number 8: intro-R-1-uniquebackupstring202012121635.Rnw:647-648
###################################################
generateSudoku()


###################################################
### code chunk number 9: printmypuzzle
###################################################
myPuzzle <- generateSudoku(Nblank = 20, print.it = FALSE)
printSudoku(myPuzzle)


###################################################
### code chunk number 10: printUK (eval = FALSE)
###################################################
## printSudoku(fetchSudokuUK())


###################################################
### code chunk number 11: toolbench1
###################################################
x <- runif(10)
x
mean(x)


###################################################
### code chunk number 12: proglang1
###################################################
celToFaren <- function(input=0){ 9/5 * input + 32 }
celToFaren(100)
celToFaren(25)
celToFaren(0)


###################################################
### code chunk number 13: proglang2
###################################################
mytemps <- 50 * runif(10)
mytemps
celToFaren(mytemps)


###################################################
### code chunk number 14: proglang3
###################################################
exists("sqrt")
exists("c")


###################################################
### code chunk number 15: intro-R-1-uniquebackupstring202012121635.Rnw:997-998 (eval = FALSE)
###################################################
## q()


###################################################
### code chunk number 16: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 17: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


