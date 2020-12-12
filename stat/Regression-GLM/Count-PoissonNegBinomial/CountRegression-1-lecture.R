### R code from vignette source 'CountRegression-1-lecture-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: CountRegression-1-lecture-uniquebackupstring.Rnw:43-44
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
options(width=80, prompt="> ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly = TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)
if(!file.exists("tmpout")) dir.create("tmpout", showWarnings=F)


###################################################
### code chunk number 4: texcopy
###################################################
library(stationery)
## If theme directory does not have required logo files, retrieve them.
logos <- c(logo = "logo.pdf",
            logomini = "logomini.pdf")
getFiles(logos, pkg = "crmda")


###################################################
### code chunk number 5: smcheck
###################################################
beta <- seq(0, 0.2, length=1000)
betaexp <- exp(beta)
beta100 <- beta*100
plot(beta100, betaexp, type="l",  main = "100 * beta is very close to the decimal of betaexp * 100", xlab = "100 * beta", ylab = "exp(beta)")
m1 <- lm(betaexp ~ beta100)
abline(m1, col="red")
legend("topleft", legend = c("observed", "OLS fit"), 
      lty = c(1, 1), col = c("black", "red"))  


###################################################
### code chunk number 6: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 7: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


