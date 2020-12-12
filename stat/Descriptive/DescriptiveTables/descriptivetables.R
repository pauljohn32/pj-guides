### R code from vignette source 'descriptivetables-tanglebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: descriptivetables-tanglebackupstring.Rnw:28-29
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: tmpout
###################################################
if(!dir.exists("tmpout")) dir.create("tmpout", showWarnings=FALSE)


###################################################
### code chunk number 3: Roptions
###################################################
opts.orig <- options()
options(width=90, prompt="> ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
options(SweaveHooks=list(fig=function() par(ps=10)))
pdf.options(onefile=FALSE,family="Times",pointsize=10)


###################################################
### code chunk number 4: texcopy
###################################################
library(stationery)
## If theme directory does not have required images or TeX files
## we need to retrieve them and put them in "theme" directory. 
logos <- c(logoleft = "logoleft.pdf", 
           logoright = "logo-vert.pdf",
           address = "addressFooter.tex")
getFiles(logos, pkg = "crmda")


###################################################
### code chunk number 5: hsbget
###################################################
odir <- "output"
if(!file.exists(odir)) dir.create(odir)
wd <- "workingdata"
fn <- "hsb2.rds"
hsb <- readRDS(file.path(wd, fn))


###################################################
### code chunk number 6: hsbsumry10
###################################################
library(rockchalk)
sum.hsb <- summarize(hsb)


###################################################
### code chunk number 7: descriptivetables-tanglebackupstring.Rnw:658-659
###################################################
sum.hsb[[1]]


###################################################
### code chunk number 8: hsbsumry20
###################################################
sum.hsb.2 <- sum.hsb[[1]][c("mean", "sd")]
library(xtable)
xt <- xtable(sum.hsb.2)


###################################################
### code chunk number 9: hsbsumry21
###################################################
print(xt, file = file.path(odir, "hsbsumry20.tex"), 
      floating=FALSE)


###################################################
### code chunk number 10: descriptivetables-tanglebackupstring.Rnw:712-713
###################################################
sum.hsb[[2]]


###################################################
### code chunk number 11: descriptivetables-tanglebackupstring.Rnw:719-720 (eval = FALSE)
###################################################
## str(sum.hsb[[2]])


###################################################
### code chunk number 12: descriptivetables-tanglebackupstring.Rnw:743-748
###################################################
library(xtable)
xt1 <- xtable(as.table(sum.hsb[[2]][["sector"]]$table), 
              caption = "The Sector Summary", label = "tab:sector", 
              digits = 2)
print(xt1, table.placement="H", caption.placement="top")


###################################################
### code chunk number 13: descriptivetables-tanglebackupstring.Rnw:751-755
###################################################
xt2 <- xtable(as.table(sum.hsb[[2]][["gender"]]$table), 
              caption = "The Gender Summary", label = "tab:gender", 
              digits = 2)
print(xt2, table.placement="H", caption.placement="top")


###################################################
### code chunk number 14: descriptivetables-tanglebackupstring.Rnw:758-762
###################################################
xt3 <- xtable(as.table(sum.hsb[[2]][["ethnicity"]]$table), 
              caption = "The Ethnicity Summary", label = "tab:ethnicity",
              digits = 2)
print(xt3, table.placement="H", caption.placement="top")


###################################################
### code chunk number 15: descriptivetables-tanglebackupstring.Rnw:777-778
###################################################
m1 <- lm(mathach ~ ses + size + sector + gender + ethnicity, data = hsb)


###################################################
### code chunk number 16: descriptivetables-tanglebackupstring.Rnw:782-783
###################################################
summary(m1)


###################################################
### code chunk number 17: descriptivetables-tanglebackupstring.Rnw:792-793
###################################################
outreg(list("One regression I ran" = m1), tight = FALSE)


###################################################
### code chunk number 18: descriptivetables-tanglebackupstring.Rnw:797-799
###################################################
hsb.mm1 <- model.matrix(m1)



###################################################
### code chunk number 19: descriptivetables-tanglebackupstring.Rnw:805-806
###################################################
head(hsb.mm1)


###################################################
### code chunk number 20: descriptivetables-tanglebackupstring.Rnw:812-815
###################################################
## convert from matrix to data frame needed for summarize
hsb.mm1 <- as.data.frame(hsb.mm1)
hsb.smry2 <- rockchalk::summarize(hsb.mm1)


###################################################
### code chunk number 21: descriptivetables-tanglebackupstring.Rnw:821-828
###################################################
## I just want mean and sd, so pick those out
hsb.smry3 <- hsb.smry2[[1]][ , c("mean", "sd")]
## I dial up digits here
xt3 <- xtable(hsb.smry3, caption="xtable output from model.matrix output",
       label = "tab:sumry3", digits=4)
options(scipen=20) ## I don't want scientific notation
print(xt3, table.placement="H", caption.placement="top")


###################################################
### code chunk number 22: descriptivetables-tanglebackupstring.Rnw:834-836
###################################################
print(xt3, digits = 2, table.placement="H", caption.placement="top",
      file = file.path(odir, "mm.sumry3.tex"))


###################################################
### code chunk number 23: descriptivetables-tanglebackupstring.Rnw:854-859
###################################################
m1.noint <- lm(mathach ~ -1 +  ses + size + sector + gender + ethnicity, data = hsb)
hsb.mm1.noint <- model.matrix(m1.noint)
hsb.mm1.noint <- as.data.frame(hsb.mm1.noint)
hsb.smry.noint <- rockchalk::summarize(hsb.mm1.noint)
hsb.smry.noint <- hsb.smry.noint[[1]][ , c("mean", "sd")]


###################################################
### code chunk number 24: descriptivetables-tanglebackupstring.Rnw:862-866
###################################################
xt.noint <- xtable(hsb.smry.noint, caption="Summary showing all categories",
       label = "tab:sumry.noint", digits=4)
options(scipen=20) ## I don't want scientific notation
print(xt.noint, table.placement="H", caption.placement="top")


###################################################
### code chunk number 25: fake10
###################################################
dat <- genCorrelatedData2(1000, means=c(10, 10, 10), sds = 3, stde = 3, beta = c(1, 1, -1, 0.5))
dat$xcat1 <- factor(sample(c("a", "b", "c", "d"), 1000, replace=TRUE))
dat$xcat2 <- factor(sample(c("M", "F"), 1000, replace=TRUE), levels = c("M", "F"), labels = "Male", "Female")
dat$y <- dat$y + contrasts(dat$xcat1)[dat$xcat1, ] %*% c(0.1, 0.2, 0.3)
m4 <- lm(y ~ x1 + x2  + x3 + xcat1 + xcat2, dat)


###################################################
### code chunk number 26: makedesc50
###################################################
##' Summary stats table-maker for regression users
##'
##' rockchalk::summarize does the numerical calculations
##' 
##' This is, roughly speaking, doing the right thing, but
##' not in a clever way. I need to think harder on that.
##'
##' @param object A fitted regression or an R data.frame, or any
##'      other object type that does not fail in code{model.frame(object)}.
##' @param stats Default is a vector c("mean", "sd", "min", "max"). Other
##'      stats reported by rockchalk::summarize should work fine as well
##' @param digits 2 decimal points is default
##' @param ... Other arguments passed to rockchalk::summarizeNumerics and
##'      summarizeFactors.
##' @return a character matrix
##' @author Paul Johnson
descriptiveTable <- function(object, stats = c("mean", "sd", "min", "max"), 
                            digits = 2, probs = c(0, .5, 1), ...){
    mc <- match.call(expand.dots = TRUE)
    dots <- list(...)
    
    dat <- model.frame(object)    
    arglist <- list(dat = dat, stats = stats, digits = digits)
    arglist <- modifyList(arglist, dots)
    summ.dat <- do.call(rockchalk::summarize, arglist)
    reslt <- data.frame(variable = rownames(summ.dat[["numerics"]]), 
                                    summ.dat[["numerics"]][stats[stats %in% names(summ.dat[["numerics"]])]],
                        stringsAsFactors = FALSE)
    numbers <- names(which(sapply(reslt, is.numeric)))
    for(j in numbers) reslt[ , j] <- formatC(reslt[ , j], digits = digits)
    
    reslt2 <- vector("list", length = length(summ.dat[["factors"]]))
    names(reslt2) <- names(summ.dat[["factors"]])
    for(j in names(summ.dat[[2]])){
        tab <- summ.dat[[2]][[j]]
        tab.prop <- tab[["table"]]/tab[["table"]]["nobs"]
        ## remove elements after nobs
        nobs.col <- which(names(tab.prop) == "nobs")
        tab.prop <- tab.prop[1:(nobs.col - 1)]
        reslt2[[j]] <- data.frame(variable=names(tab.prop), 
                                  mean = formatC(tab.prop, digits = digits), 
                                  stringsAsFactors = FALSE)
        reslt2[[j]] <- rbind(data.frame(variable = j, mean = "", 
                                        stringsAsFactors = FALSE), 
                             reslt2[[j]])
    }
   
    reslt3 <- do.call(rbind, reslt2)
    
    reslt4 <- plyr::rbind.fill(reslt, reslt3)
    reslt4[is.na(reslt4)] <- ""
    reslt4
}


###################################################
### code chunk number 27: makedesc60
###################################################
m4.desc <- descriptiveTable(m4)


###################################################
### code chunk number 28: makedesc100
###################################################
library(xtable)
m4.desc.tab <- xtable(m4.desc, caption="Testing descriptiveTable", label = "tab:makedesc100")
## Put one copy in a file
print(m4.desc.tab, file = file.path(odir, "makedesc100.tex"), include.rownames = FALSE,
      table.placement="H", caption.placement="top")
## print another copy to screen
print(m4.desc.tab, include.rownames = FALSE,
      table.placement="H", caption.placement="top")


###################################################
### code chunk number 29: makedesc160
###################################################
m4.desc2 <- descriptiveTable(m4, stats = c("mean", "var", "skewness"), probs = c(0.0, 0.2, 0.8, 1))


###################################################
### code chunk number 30: makedesc180
###################################################
m4.desc2


###################################################
### code chunk number 31: makedesc200
###################################################
m4.desc.tab2 <- xtable(m4.desc2, caption="Testing descriptiveTable", label = "tab:makedesc100")
print(m4.desc.tab2, include.rownames = FALSE,
      table.placement="H", caption.placement="top")


###################################################
### code chunk number 32: session
###################################################
sessionInfo()
if(!is.null(warnings())){
    print("Warnings:")
    warnings()}


###################################################
### code chunk number 33: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)


