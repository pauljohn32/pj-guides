### R code from vignette source 'summeR-2-2-import-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-2-2-import-uniquebackupstring.Rnw:41-42
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
### code chunk number 4: summeR-2-2-import-uniquebackupstring.Rnw:321-322 (eval = FALSE)
###################################################
## getwd()


###################################################
### code chunk number 5: summeR-2-2-import-uniquebackupstring.Rnw:325-327
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 6: setddir
###################################################
ddir <- "data"


###################################################
### code chunk number 7: summeR-2-2-import-uniquebackupstring.Rnw:339-340 (eval = FALSE)
###################################################
## ddir <- "../data"


###################################################
### code chunk number 8: summeR-2-2-import-uniquebackupstring.Rnw:343-344 (eval = FALSE)
###################################################
## list.files(ddir)


###################################################
### code chunk number 9: summeR-2-2-import-uniquebackupstring.Rnw:347-348
###################################################
options(options.orig)


###################################################
### code chunk number 10: summeR-2-2-import-uniquebackupstring.Rnw:359-360
###################################################
swiss <- readRDS( file.path(ddir, "swiss.rds") )


###################################################
### code chunk number 11: summeR-2-2-import-uniquebackupstring.Rnw:363-365
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 12: summeR-2-2-import-uniquebackupstring.Rnw:369-370
###################################################
head(swiss)


###################################################
### code chunk number 13: summeR-2-2-import-uniquebackupstring.Rnw:373-374
###################################################
options(options.orig)


###################################################
### code chunk number 14: summeR-2-2-import-uniquebackupstring.Rnw:389-391
###################################################
fn <- file.path(ddir, "oregon.csv")
ore1 <- read.table(fn, sep = ",", header = TRUE)


###################################################
### code chunk number 15: matx1
###################################################
X <- matrix(1:24, nrow = 6, ncol = 4, dimnames = list(NULL, c("Den", "KC", "Oak", "SD")))
X


###################################################
### code chunk number 16: matx2
###################################################
X[5, 2]


###################################################
### code chunk number 17: matx3
###################################################
X[2, ]


###################################################
### code chunk number 18: matx4
###################################################
X[ , 3]


###################################################
### code chunk number 19: summeR-2-2-import-uniquebackupstring.Rnw:584-585
###################################################
swiss[3, ]


###################################################
### code chunk number 20: summeR-2-2-import-uniquebackupstring.Rnw:591-592
###################################################
X[1:5 , "Oak"]


###################################################
### code chunk number 21: summeR-2-2-import-uniquebackupstring.Rnw:597-598
###################################################
X[1:5 , c("Den", "SD")]


###################################################
### code chunk number 22: summeR-2-2-import-uniquebackupstring.Rnw:609-610
###################################################
X <- matrix(rnorm(12), ncol = 4)


###################################################
### code chunk number 23: summeR-2-2-import-uniquebackupstring.Rnw:614-615
###################################################
X <- matrix(sample(letters, 12, replace=TRUE), ncol = 4)


###################################################
### code chunk number 24: summeR-2-2-import-uniquebackupstring.Rnw:619-620
###################################################
X <- matrix(sample(c(TRUE,FALSE), 12, replace=TRUE), ncol = 4)


###################################################
### code chunk number 25: summeR-2-2-import-uniquebackupstring.Rnw:646-648 (eval = FALSE)
###################################################
## X[ , "column_name_here"]
## DF[ , "column_name_here"]


###################################################
### code chunk number 26: summeR-2-2-import-uniquebackupstring.Rnw:668-669
###################################################
is.data.frame(swiss)


###################################################
### code chunk number 27: summeR-2-2-import-uniquebackupstring.Rnw:674-675
###################################################
print(swiss)


###################################################
### code chunk number 28: swiss60 (eval = FALSE)
###################################################
## head(swiss)


###################################################
### code chunk number 29: summeR-2-2-import-uniquebackupstring.Rnw:720-721
###################################################
head(swiss)


###################################################
### code chunk number 30: summeR-2-2-import-uniquebackupstring.Rnw:730-731
###################################################
str(swiss)


###################################################
### code chunk number 31: summeR-2-2-import-uniquebackupstring.Rnw:742-744
###################################################
swiss$Edgt10 <- ifelse(swiss$Education > 10, TRUE, FALSE)
str(swiss)


###################################################
### code chunk number 32: summeR-2-2-import-uniquebackupstring.Rnw:749-750 (eval = FALSE)
###################################################
## View(swiss)


###################################################
### code chunk number 33: summeR-2-2-import-uniquebackupstring.Rnw:757-758
###################################################
summary(swiss)


###################################################
### code chunk number 34: summeR-2-2-import-uniquebackupstring.Rnw:762-765 (eval = FALSE)
###################################################
## rownames(swiss)
## colnames (swiss)
## attributes(swiss)


###################################################
### code chunk number 35: summeR-2-2-import-uniquebackupstring.Rnw:775-782
###################################################
# The $ accessor
f1 <- swiss$Fertility
# matrix style, choose column 1
f2 <- swiss[ , 1]
# By column name (my favorite)
f3 <- swiss[ , "Fertility"]
all.equal(f1, f2, f3)


###################################################
### code chunk number 36: summeR-2-2-import-uniquebackupstring.Rnw:791-797
###################################################
# matrix style, cols 1, 3, 5
f2 <- swiss[ , c(1, 3, 5)]
# By column name (my favorite)
f3 <- swiss[ , c("Fertility", "Examination", "Catholic")]
all.equal(f2, f3)
head(f2)


###################################################
### code chunk number 37: summeR-2-2-import-uniquebackupstring.Rnw:815-816
###################################################
head(ore1, 8)


###################################################
### code chunk number 38: summeR-2-2-import-uniquebackupstring.Rnw:820-821
###################################################
str(ore1)


###################################################
### code chunk number 39: summeR-2-2-import-uniquebackupstring.Rnw:832-834 (eval = FALSE)
###################################################
## ore1 <- read.table("data/oregon.csv", sep = ",", 
##             header = TRUE, stringsAsFactors = FALSE)


###################################################
### code chunk number 40: summeR-2-2-import-uniquebackupstring.Rnw:861-862
###################################################
summary(ore1)


###################################################
### code chunk number 41: summeR-2-2-import-uniquebackupstring.Rnw:868-870
###################################################
library(rockchalk)
summarize(ore1)


###################################################
### code chunk number 42: summeR-2-2-import-uniquebackupstring.Rnw:930-931 (eval = FALSE)
###################################################
## mydata <- read.table("../data/filename.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)


###################################################
### code chunk number 43: summeR-2-2-import-uniquebackupstring.Rnw:994-998
###################################################
set.seed(234)
fd <- data.frame(v3 = rnorm(5), 
                 v4 = rnorm(5), 
                 v5 = LETTERS[1:5], stringsAsFactors = FALSE)


###################################################
### code chunk number 44: summeR-2-2-import-uniquebackupstring.Rnw:1005-1006
###################################################
head(fd)


###################################################
### code chunk number 45: summeR-2-2-import-uniquebackupstring.Rnw:1011-1016
###################################################
fd[ , "v4"]
fd$v4

fd[ , 2]
fd[ , c(FALSE, TRUE, FALSE)]


###################################################
### code chunk number 46: summeR-2-2-import-uniquebackupstring.Rnw:1030-1031
###################################################
fd[ , 2]


###################################################
### code chunk number 47: summeR-2-2-import-uniquebackupstring.Rnw:1036-1037
###################################################
fd[ , "v4"]


###################################################
### code chunk number 48: summeR-2-2-import-uniquebackupstring.Rnw:1049-1050
###################################################
fd["1", "v4"]


###################################################
### code chunk number 49: summeR-2-2-import-uniquebackupstring.Rnw:1056-1057
###################################################
rownames(fd)


###################################################
### code chunk number 50: summeR-2-2-import-uniquebackupstring.Rnw:1062-1063
###################################################
rownames(fd) <- c("Bill", "Joe", "Frosty", "Mickey", "Henry")


###################################################
### code chunk number 51: summeR-2-2-import-uniquebackupstring.Rnw:1068-1070
###################################################
fd[1, ] # position 1
fd["Bill", ] # rowname "Bill"


###################################################
### code chunk number 52: summeR-2-2-import-uniquebackupstring.Rnw:1083-1086
###################################################
fd13 <- fd[ , c("v3", "v5")] 
str(fd13)
head(fd13)


###################################################
### code chunk number 53: gotcha10
###################################################
z <- fd[ , "v4"]
str(z)


###################################################
### code chunk number 54: gotcha20
###################################################
w1 <- fd[ , "v4", drop = FALSE]
w1
str(w1)


###################################################
### code chunk number 55: gotcha10
###################################################
w2 <- fd["v4"]
w2
str(w2)


###################################################
### code chunk number 56: summeR-2-2-import-uniquebackupstring.Rnw:1138-1139
###################################################
fd13$v3 <- NULL


###################################################
### code chunk number 57: summeR-2-2-import-uniquebackupstring.Rnw:1146-1148
###################################################
fdnew <- fd[ , -c(2)]
head(fdnew)


###################################################
### code chunk number 58: hist1
###################################################
hist(ore1$tann, prob = TRUE)


###################################################
### code chunk number 59: hist2a
###################################################
hist(ore1$tann, prob = TRUE,  xlab = "Annual Temperatures in Oregon", ylab = "Density of Observed Temperatures", main = "Oregon: Where Good Professors Hope to Retire", ylim = c(0, 0.30))


###################################################
### code chunk number 60: sc10
###################################################
pairs(ore1[ , -1])


###################################################
### code chunk number 61: ex10
###################################################
library(openxlsx)
fn <- file.path(ddir, "gradebook.xlsx")
grades <- read.xlsx(fn, colNames = TRUE, check.names = TRUE)
head(grades)


###################################################
### code chunk number 62: ex20
###################################################
library(openxlsx)
fn <- file.path(ddir, "gradebook.xlsx")
grades <- read.xlsx(fn, colNames = TRUE, check.names = TRUE)
head(grades)


###################################################
### code chunk number 63: ex30
###################################################
str(grades)


###################################################
### code chunk number 64: summeR-2-2-import-uniquebackupstring.Rnw:1324-1327 (eval = FALSE)
###################################################
## library(foreign)
## ## as always, review
## help(package = "foreign")


###################################################
### code chunk number 65: toe1
###################################################
library(foreign)
toe1f <- read.dta("data/toenail.dta")


###################################################
### code chunk number 66: summeR-2-2-import-uniquebackupstring.Rnw:1359-1361
###################################################
fn <- file.path(ddir, "toenail.dta")
toe1n <- read.dta(fn, convert.factors = FALSE)


###################################################
### code chunk number 67: summeR-2-2-import-uniquebackupstring.Rnw:1370-1371
###################################################
table(toe1f$treatment, toe1n$treatment, exclude = NULL, dnn = list("factor", "numeric"))


###################################################
### code chunk number 68: summeR-2-2-import-uniquebackupstring.Rnw:1397-1399 (eval = FALSE)
###################################################
## dat <- read.spss("whatever.sav")
## dat <- as.data.frame(dat)


###################################################
### code chunk number 69: summeR-2-2-import-uniquebackupstring.Rnw:1403-1404 (eval = FALSE)
###################################################
## dat <- read.spss("whatever.sav", to.data.frame = TRUE)


###################################################
### code chunk number 70: summeR-2-2-import-uniquebackupstring.Rnw:1514-1516 (eval = FALSE)
###################################################
## library(kutils)
## keyw <- keyTemplate(grades, file = "key-wide.csv")


###################################################
### code chunk number 71: summeR-2-2-import-uniquebackupstring.Rnw:1519-1520
###################################################
keyw <- read.csv("key-wide.csv", stringsAsFactors=FALSE)


###################################################
### code chunk number 72: summeR-2-2-import-uniquebackupstring.Rnw:1542-1545
###################################################
library(xtable)
xt1 <- xtable(keyw)
print(xt1, include.rownames=FALSE, size = "\\tiny")


###################################################
### code chunk number 73: summeR-2-2-import-uniquebackupstring.Rnw:1568-1570 (eval = FALSE)
###################################################
## library(kutils)
## keyl <- keyTemplate(grades, long=TRUE, file = "key-long.csv")


###################################################
### code chunk number 74: summeR-2-2-import-uniquebackupstring.Rnw:1573-1574
###################################################
keyl <- read.csv("key-long.csv", stringsAsFactors=FALSE)


###################################################
### code chunk number 75: summeR-2-2-import-uniquebackupstring.Rnw:1578-1581
###################################################
xt2 <- xtable(keyl)
print(xt2, include.rownames=FALSE, size = "\\footnotesize", 
         tabular.environment="longtable")


###################################################
### code chunk number 76: summeR-2-2-import-uniquebackupstring.Rnw:1611-1615
###################################################
V1 <- seq(1, 10, by = 0.01)
V2 <- c(3)
V3 <- c(1, 2, 3, 4, 5)
head(fd)


###################################################
### code chunk number 77: summeR-2-2-import-uniquebackupstring.Rnw:1619-1621
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 78: summeR-2-2-import-uniquebackupstring.Rnw:1626-1627
###################################################
ls()


###################################################
### code chunk number 79: summeR-2-2-import-uniquebackupstring.Rnw:1630-1631
###################################################
options(options.orig)


###################################################
### code chunk number 80: summeR-2-2-import-uniquebackupstring.Rnw:1638-1639 (eval = FALSE)
###################################################
## rm(V1)


###################################################
### code chunk number 81: summeR-2-2-import-uniquebackupstring.Rnw:1643-1644 (eval = FALSE)
###################################################
## rm(list = c("V1", "V2"))


###################################################
### code chunk number 82: summeR-2-2-import-uniquebackupstring.Rnw:1651-1652 (eval = FALSE)
###################################################
## rm(list = ls())


###################################################
### code chunk number 83: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 84: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


