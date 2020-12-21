### R code from vignette source 'sem-3-4-difftest-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: sem-3-4-difftest-uniquebackupstring.Rnw:37-38
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 4: chi10
###################################################
x <- seq(0.1, 10, by = 0.01)
xprob <- dchisq(x, df = 1)
plot(x, xprob, type = "l")
xprob2 <- dchisq(x, df = 2)
lines(x, xprob2, lty = 2, col = 2, lwd = 2)
xprob3 <- dchisq(x, df = 3)
lines(x, xprob3, lty = 3, col = 3, lwd = 2)
xprob4 <- dchisq(x, df = 4)
lines(x, xprob4, lty = 4, col = 4, lwd = 2)
legend("topright", legend = c("df = 1", "df = 2", "df = 3", "df = 10"), 
       lty = 1:4, col = 1:4)


###################################################
### code chunk number 5: chi30
###################################################
df <- 1:10
critical.value <- qchisq(0.05, df, lower.tail = FALSE)
mytable <- cbind(df, critical.value)
library(xtable)
myxtable <- xtable(mytable)
print(myxtable, type = "latex", use.rownames = FALSE, floating = FALSE)


###################################################
### code chunk number 6: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 7: excludemeopts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


