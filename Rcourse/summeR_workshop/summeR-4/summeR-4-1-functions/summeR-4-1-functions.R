### R code from vignette source 'summeR-4-1-functions-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: tmpout
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)


###################################################
### code chunk number 2: Roptions
###################################################
opts.orig <- options()
options(width=100, prompt="> ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly = TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)
if(!file.exists("theme")) file.symlink("../../../../template/theme", "theme")


###################################################
### code chunk number 3: summeR-4-1-functions-uniquebackupstring.Rnw:511-512 (eval = FALSE)
###################################################
## g <- somethingGood(whatever1, whatever2)


###################################################
### code chunk number 4: summeR-4-1-functions-uniquebackupstring.Rnw:519-520 (eval = FALSE)
###################################################
## whatever1 <- somethingGood(whatever1, whatever2)


###################################################
### code chunk number 5: summeR-4-1-functions-uniquebackupstring.Rnw:552-564
###################################################
##' terse statement of function purpose
##'
##' paragraph about function
##'
##' Paragraphs of "Details"
##' @param x words about x
##' @param y words about y
##' @return a description of the function's return
##' @author Paul Johnson <pauljohn@@ku.edu>
myfunction <- function(x, y){
   ## imagine code here
}


###################################################
### code chunk number 6: revs10
###################################################
##' Reverse a factor's levels
##'
##' This requires a factor variable
##' @param x A factor variable
##' @return A reversed factor variable
##' @author Paul Johnson <pauljohn@@ku.edu>
revs <- function (x){
    if (!is.factor(x)) stop("your variable is not a factor")
    rlevels <- rev(levels(x))
    factor(x, levels = rlevels)
}


###################################################
### code chunk number 7: revs20
###################################################
x <- c("hot", "hot", "cold", "medium", "medium", "hot")
zz1 <- ordered(x, levels = c("hot", "medium", "cold"))
x2 <- revs(zz1)
table(x2, zz1, dnn = list("x2", "zz1 is the original"))


###################################################
### code chunk number 8: fun10
###################################################
x <- 30
aa <- letters[5:10]
getXYZ <- function(m1, m2){
   res1 <- paste(m1, x, sep = "_")
   res2 <- paste(aa, m2, sep = "_what?_")
   list(res1, res2)
}
getXYZ(m1 = c(1, 2, 3), m2 = c(98, 99))


###################################################
### code chunk number 9: summeR-4-1-functions-uniquebackupstring.Rnw:726-737
###################################################
newname <- c("Respondent ID", "Respondent Age", "city - residence", "state - residence")
## Change space to underscore
newname <- gsub(" ", "_", newname, fixed = TRUE)
## Replace minus with underscore
newname <- gsub("-", "_", newname, fixed = TRUE)
## Replace multiple underscores with one underscore
newname <- gsub("(_)\\1+", "_", newname)
## Lower case
newname <- tolower(newname)
newname
##colnames(dat) <- newname


###################################################
### code chunk number 10: summeR-4-1-functions-uniquebackupstring.Rnw:749-763 (eval = FALSE)
###################################################
## ##' Remove spaces, minus signs, and change letters to lower case
## ##'
## ##' Cleans up a character string. Does not do comprenensive
## ##' cleanup, just minus, spaces and capitals. Could extend to other flaws
## ##' @param x A vector of character string.
## ##' @return cleaned vector of strings
## ##' @author pauljohn@@ku.edu
## cleanVarName <- function(x){
##     x <- gsub(" ", "_", x, fixed = TRUE)
##     x <- gsub("-", "_", x, fixed = TRUE)
##     x <- gsub("(_)\\1+", "_", x)
##     x <- tolower(x)
##     x
## }


###################################################
### code chunk number 11: summeR-4-1-functions-uniquebackupstring.Rnw:768-773 (eval = FALSE)
###################################################
## colnames(dat1) <- cleanVarName(colnames(dat1))
## colnames(dat2) <- cleanVarName(colnames(dat2))
## ## ...
## colnames(dat10) <- cleanVarNames(colname(dat10))
## 


###################################################
### code chunk number 12: summeR-4-1-functions-uniquebackupstring.Rnw:791-792
###################################################
getXYZ


###################################################
### code chunk number 13: summeR-4-1-functions-uniquebackupstring.Rnw:800-801 (eval = FALSE)
###################################################
## debug(getXYZ)


###################################################
### code chunk number 14: summeR-4-1-functions-uniquebackupstring.Rnw:833-839 (eval = FALSE)
###################################################
## getXYZ <- function(m1, m2){
##    res1 <- paste(m1, x, sep = "_")
##    res2 <- paste(aa, m2, sep = "_what?_")
##    browser()
##    list(res1, res2)
## }


###################################################
### code chunk number 15: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 16: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


