### R code from vignette source 'summeR-1-1-hello-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-1-1-hello-uniquebackupstring.Rnw:29-30
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: tmpout
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)


###################################################
### code chunk number 3: Roptions
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
### code chunk number 4: summeR-1-1-hello-uniquebackupstring.Rnw:293-295 (eval = FALSE)
###################################################
## curve(3 + 0.2 * x + 0.1 * x^2, from = -2, 
## to = 2)


###################################################
### code chunk number 5: summeR-1-1-hello-uniquebackupstring.Rnw:420-421 (eval = FALSE)
###################################################
## q(save = "no")


###################################################
### code chunk number 6: summeR-1-1-hello-uniquebackupstring.Rnw:456-458
###################################################
x <- c(3, 5, 7, 9, 11)
x


###################################################
### code chunk number 7: summeR-1-1-hello-uniquebackupstring.Rnw:463-465
###################################################
mean(x)
var(x)


###################################################
### code chunk number 8: summeR-1-1-hello-uniquebackupstring.Rnw:476-477 (eval = FALSE)
###################################################
## y <- 2 * x


###################################################
### code chunk number 9: summeR-1-1-hello-uniquebackupstring.Rnw:486-487
###################################################
ls()


###################################################
### code chunk number 10: summeR-1-1-hello-uniquebackupstring.Rnw:494-495
###################################################
print(x)


###################################################
### code chunk number 11: summeR-1-1-hello-uniquebackupstring.Rnw:498-499
###################################################
x


###################################################
### code chunk number 12: summeR-1-1-hello-uniquebackupstring.Rnw:522-525
###################################################
y <- c(21, 41, 44, 115, 105)
mean(y)
var(y)


###################################################
### code chunk number 13: p1
###################################################
plot(y ~ x, xlab = "Age", ylab = "Weight", main = "My First Plot")


###################################################
### code chunk number 14: summeR-1-1-hello-uniquebackupstring.Rnw:554-555
###################################################
rnorm(n = 5, mean = 100, sd = 10)


###################################################
### code chunk number 15: summeR-1-1-hello-uniquebackupstring.Rnw:569-572
###################################################
set.seed(66565) #put in any integer you like
x <- rnorm(n = 40, mean = 7, sd = 2)
y <- rnorm(n = 40, mean = 35, sd = 10)


###################################################
### code chunk number 16: p2
###################################################
hist(x, prob = TRUE, main = "My First Histogram")


###################################################
### code chunk number 17: p3
###################################################
hist(x, prob = TRUE, ylim = c(0, 0.20), xlim = c(0, 14), main = "", xlab = "Ages of Jane's 40 Hypothetical Children")


###################################################
### code chunk number 18: summeR-1-1-hello-uniquebackupstring.Rnw:612-613 (eval = FALSE)
###################################################
## ?hist


###################################################
### code chunk number 19: summeR-1-1-hello-uniquebackupstring.Rnw:617-618 (eval = FALSE)
###################################################
## example(hist)


###################################################
### code chunk number 20: p4
###################################################
plot(y ~ x)


###################################################
### code chunk number 21: summeR-1-1-hello-uniquebackupstring.Rnw:654-655
###################################################
mydf <- data.frame(x = x, y = y)


###################################################
### code chunk number 22: summeR-1-1-hello-uniquebackupstring.Rnw:663-664
###################################################
rm(x, y)


###################################################
### code chunk number 23: summeR-1-1-hello-uniquebackupstring.Rnw:671-672
###################################################
ls()


###################################################
### code chunk number 24: plotdf10
###################################################
plot(y ~ x, data = mydf, main = "Notice I used a data frame")


###################################################
### code chunk number 25: summeR-1-1-hello-uniquebackupstring.Rnw:693-695 (eval = FALSE)
###################################################
## set.seed(1234)
## x <- rnorm(n = 40, mean = 7, sd = 2)


###################################################
### code chunk number 26: summeR-1-1-hello-uniquebackupstring.Rnw:700-702 (eval = FALSE)
###################################################
## set.seed(1234)
## x <- rnorm(40, 7, 2)


###################################################
### code chunk number 27: summeR-1-1-hello-uniquebackupstring.Rnw:710-712 (eval = FALSE)
###################################################
## set.seed(1234)
## x <- rnorm(sd = 2, mean = 7, n = 40)


###################################################
### code chunk number 28: summeR-1-1-hello-uniquebackupstring.Rnw:717-719 (eval = FALSE)
###################################################
## set.seed(1234)
## x <- rnorm(40, m = 7, s = 2)


###################################################
### code chunk number 29: sessionInfo
###################################################
sessionInfo()


###################################################
### code chunk number 30: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 31: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


