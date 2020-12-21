### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T26993/lyx_tmpbuf0/intro-R-1.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: intro-R-1.Rnw:20-21
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: intro-R-1.Rnw:70-72
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=60, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
pjmar <- c(5.1, 4.1, 1.5, 2.1) 
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)


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
### code chunk number 8: intro-R-1.Rnw:538-539
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
### code chunk number 15: intro-R-1.Rnw:903-904 (eval = FALSE)
###################################################
## q()


