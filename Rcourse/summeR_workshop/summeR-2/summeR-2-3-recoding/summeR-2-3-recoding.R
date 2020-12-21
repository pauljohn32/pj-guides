### R code from vignette source 'summeR-2-3-recoding-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-2-3-recoding-uniquebackupstring.Rnw:32-33
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
### code chunk number 4: summeR-2-3-recoding-uniquebackupstring.Rnw:298-299 (eval = FALSE)
###################################################
## dat.orig <- dat


###################################################
### code chunk number 5: summeR-2-3-recoding-uniquebackupstring.Rnw:304-305 (eval = FALSE)
###################################################
## table(dat$x123, dat.orig$x123)


###################################################
### code chunk number 6: summeR-2-3-recoding-uniquebackupstring.Rnw:310-311 (eval = FALSE)
###################################################
## plot.default(dat$x456, dat.orig$x456)


###################################################
### code chunk number 7: summeR-2-3-recoding-uniquebackupstring.Rnw:316-317 (eval = FALSE)
###################################################
## cbind(dat$x456, dat.orig$x456)


###################################################
### code chunk number 8: summeR-2-3-recoding-uniquebackupstring.Rnw:346-348
###################################################
x <- c("alpha", "beta", "gamma", "omega", "psi")
is.character(x)


###################################################
### code chunk number 9: summeR-2-3-recoding-uniquebackupstring.Rnw:354-355
###################################################
x <- c("alpha", 2, 3, 3, 4)


###################################################
### code chunk number 10: summeR-2-3-recoding-uniquebackupstring.Rnw:360-361
###################################################
x


###################################################
### code chunk number 11: summeR-2-3-recoding-uniquebackupstring.Rnw:368-370
###################################################
is.character(x)
mode(x)


###################################################
### code chunk number 12: summeR-2-3-recoding-uniquebackupstring.Rnw:376-377
###################################################
as.numeric(x)


###################################################
### code chunk number 13: summeR-2-3-recoding-uniquebackupstring.Rnw:383-387
###################################################
x <- c(55, 2, 3, 3, 4)
x
is.double(x)
is.integer(x)


###################################################
### code chunk number 14: summeR-2-3-recoding-uniquebackupstring.Rnw:396-399
###################################################
x <- c(55L, 2L, 3L, 3L, 4L)
x
is.integer(x)


###################################################
### code chunk number 15: summeR-2-3-recoding-uniquebackupstring.Rnw:406-410
###################################################
x <- c(2L, 3L, 3L, 4L, 5.5323)
is.integer(x)
x
is.double(x)


###################################################
### code chunk number 16: summeR-2-3-recoding-uniquebackupstring.Rnw:421-428
###################################################
x <- vector(mode = "integer", length = 5)
is.integer(x)
x <- c(1, 2, 3, 4, 5)
is.integer(x)
## R is hiding the decimals from you
x
mode(x)


###################################################
### code chunk number 17: summeR-2-3-recoding-uniquebackupstring.Rnw:466-476 (eval = FALSE)
###################################################
## set.seed(234)
## N <- 48 ## Small sample
## dat <- 
##   data.frame(x = exp(rnorm(N, mean = 5, sd = 0.7)), 
##      y = rpois(N, lambda = 13),
##      w = sample(letters[6:10], N, replace = TRUE), 
##      z = gl(4, 12, labels = c("eenie", "meanie", "miney", "mo")),
##      stringsAsFactors = FALSE) 
## ## Safe copy for checking recodes
## dat.orig <- dat


###################################################
### code chunk number 18: summeR-2-3-recoding-uniquebackupstring.Rnw:479-482
###################################################
dat <- readRDS(file = "data/smtest.rds")
str(dat)
dat.orig <- dat ## spare copy


###################################################
### code chunk number 19: summeR-2-3-recoding-uniquebackupstring.Rnw:493-494 (eval = FALSE)
###################################################
## dat$y[dat$y > 11] <- NA


###################################################
### code chunk number 20: summeR-2-3-recoding-uniquebackupstring.Rnw:501-502 (eval = FALSE)
###################################################
## dat$y <- ifelse(dat$y > 11, NA, dat$y)


###################################################
### code chunk number 21: summeR-2-3-recoding-uniquebackupstring.Rnw:514-515
###################################################
head(dat$y > 11, 10)


###################################################
### code chunk number 22: summeR-2-3-recoding-uniquebackupstring.Rnw:526-527 (eval = FALSE)
###################################################
## table(is.na(dat$y), dat.orig$y, exclude = NULL)


###################################################
### code chunk number 23: summeR-2-3-recoding-uniquebackupstring.Rnw:545-551
###################################################
dat$y2 <- dat$y
dat$y2[dat$y2 > 11] <- NA
## I run this to save space in output
table(is.na(dat$y2), dat$y, exclude = NULL)
## Could as well do
## table(dat$y2, dat$y, exclude = NULL)


###################################################
### code chunk number 24: summeR-2-3-recoding-uniquebackupstring.Rnw:566-567
###################################################
seq(11, 19, by = 2)


###################################################
### code chunk number 25: summeR-2-3-recoding-uniquebackupstring.Rnw:572-573
###################################################
c(10, 11, 12, 13, 14, 15, 16) %in% seq(11, 19, by = 2)


###################################################
### code chunk number 26: summeR-2-3-recoding-uniquebackupstring.Rnw:577-578 (eval = FALSE)
###################################################
## dat$y[dat$y %in% seq(11, 19, by = 2)] <- NA


###################################################
### code chunk number 27: summeR-2-3-recoding-uniquebackupstring.Rnw:592-596
###################################################
dat$x2 <- 0.01 * dat$x
dat$xexp <- exp(dat$x)
dat$xlog <- log(dat$x)
dat$xsqrt <- sqrt(dat$x)


###################################################
### code chunk number 28: summeR-2-3-recoding-uniquebackupstring.Rnw:614-615
###################################################
dat[ , "xlog.2"] <- log(dat$x)


###################################################
### code chunk number 29: summeR-2-3-recoding-uniquebackupstring.Rnw:622-624
###################################################
newname <- paste0("xlog", ".3")
dat[ , newname] <- exp(dat$x)


###################################################
### code chunk number 30: summeR-2-3-recoding-uniquebackupstring.Rnw:638-642
###################################################
dat$xcut <-cut(dat$x, 
    breaks = c(-5, 60, 100, 1000000), 
    labels = c("Minimal", "Medium", "Huge"))
table(dat$xcut, exclude = NULL)


###################################################
### code chunk number 31: summeR-2-3-recoding-uniquebackupstring.Rnw:654-656
###################################################
y <- c(31, 33, 41, 61)
ifelse(x < 3, y, x)


###################################################
### code chunk number 32: summeR-2-3-recoding-uniquebackupstring.Rnw:666-668
###################################################
z <- c(-2, -0.4, 0, 1, 2, 3)
log(z)


###################################################
### code chunk number 33: summeR-2-3-recoding-uniquebackupstring.Rnw:678-680
###################################################
2/3
print(2/3, digits = 20)


###################################################
### code chunk number 34: summeR-2-3-recoding-uniquebackupstring.Rnw:697-698
###################################################
a <- 0.58; b <- 0.08 


###################################################
### code chunk number 35: summeR-2-3-recoding-uniquebackupstring.Rnw:701-702
###################################################
(a-b) >= 0.5


###################################################
### code chunk number 36: summeR-2-3-recoding-uniquebackupstring.Rnw:708-711
###################################################
a
b
a-b


###################################################
### code chunk number 37: summeR-2-3-recoding-uniquebackupstring.Rnw:717-719
###################################################
op.orig <- options()
options(digits=20)


###################################################
### code chunk number 38: summeR-2-3-recoding-uniquebackupstring.Rnw:722-725
###################################################
a
b
a-b


###################################################
### code chunk number 39: summeR-2-3-recoding-uniquebackupstring.Rnw:730-731
###################################################
options(op.orig)


###################################################
### code chunk number 40: summeR-2-3-recoding-uniquebackupstring.Rnw:741-744
###################################################
a <- 100*(23/40)
b <- (100*23)/40
all.equal(a, b)


###################################################
### code chunk number 41: summeR-2-3-recoding-uniquebackupstring.Rnw:749-751
###################################################
round(a)
round(b)


###################################################
### code chunk number 42: summeR-2-3-recoding-uniquebackupstring.Rnw:756-758
###################################################
print(a, digits = 20)
print(b, digits = 20)


###################################################
### code chunk number 43: summeR-2-3-recoding-uniquebackupstring.Rnw:764-765
###################################################
print((100/40)*23, digits = 20)


###################################################
### code chunk number 44: summeR-2-3-recoding-uniquebackupstring.Rnw:773-774
###################################################
print(23/40, digits = 20)


###################################################
### code chunk number 45: summeR-2-3-recoding-uniquebackupstring.Rnw:784-789
###################################################
0.1
print(0.1, digits = 22)
x <- 0.1
x == 0.1
x == 0.1000000000000000055511


###################################################
### code chunk number 46: summeR-2-3-recoding-uniquebackupstring.Rnw:824-825
###################################################
dat$rn <- as.character(1:NROW(dat))


###################################################
### code chunk number 47: summeR-2-3-recoding-uniquebackupstring.Rnw:830-832
###################################################
dat$wn <- paste(dat$w, dat$rn, sep = "_")
head(dat[ ,c("w", "rn", "wn")])


###################################################
### code chunk number 48: fff
###################################################
dat$wn <- paste0(dat$w, dat$rn)
head(dat[ ,c("w", "rn", "wn")])


###################################################
### code chunk number 49: summeR-2-3-recoding-uniquebackupstring.Rnw:852-854
###################################################
oldnames <- colnames(dat)
oldnames


###################################################
### code chunk number 50: summeR-2-3-recoding-uniquebackupstring.Rnw:860-862
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 51: summeR-2-3-recoding-uniquebackupstring.Rnw:867-869
###################################################
colnames(dat) <- toupper(oldnames)
head(dat, 2)


###################################################
### code chunk number 52: summeR-2-3-recoding-uniquebackupstring.Rnw:872-873
###################################################
options(options.orig)


###################################################
### code chunk number 53: summeR-2-3-recoding-uniquebackupstring.Rnw:879-881
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 54: summeR-2-3-recoding-uniquebackupstring.Rnw:885-887
###################################################
colnames(dat) <- paste0(oldnames, "_", 2017) 
head(dat, 2)


###################################################
### code chunk number 55: summeR-2-3-recoding-uniquebackupstring.Rnw:890-891
###################################################
options(options.orig)


###################################################
### code chunk number 56: summeR-2-3-recoding-uniquebackupstring.Rnw:896-897
###################################################
colnames(dat) <- oldnames 


###################################################
### code chunk number 57: str10
###################################################
x <- c("hello", "jello", "fellow", "mellow")
substr(x, 2, 5)


###################################################
### code chunk number 58: str20
###################################################
strsplit(x, "ll")


###################################################
### code chunk number 59: summeR-2-3-recoding-uniquebackupstring.Rnw:948-950
###################################################
ees <- grep("ee", dat$z, fixed = TRUE)
head(ees)


###################################################
### code chunk number 60: str30
###################################################
ees <- grep("ee", dat$z, value = TRUE, fixed = TRUE)
head(ees)


###################################################
### code chunk number 61: str40
###################################################
startswd <- grep("^g", dat$wn, value = TRUE)
head(startswd, 10)


###################################################
### code chunk number 62: str50
###################################################
startswdl <- grepl("^g", dat$wn)
head(startswdl, 10)


###################################################
### code chunk number 63: str60
###################################################
dat$wn2 <- gsub("f", "PJ", dat$wn, fixed = TRUE)
head(dat[ , c("wn", "wn2")], 7)


###################################################
### code chunk number 64: str70 (eval = FALSE)
###################################################
## y <- gsub("[^a-zA-Z0-9\\\\'_()-]", "", x)


###################################################
### code chunk number 65: summeR-2-3-recoding-uniquebackupstring.Rnw:1040-1041
###################################################
table(dat$z)


###################################################
### code chunk number 66: summeR-2-3-recoding-uniquebackupstring.Rnw:1100-1101
###################################################
table(dat$w)


###################################################
### code chunk number 67: summeR-2-3-recoding-uniquebackupstring.Rnw:1105-1106
###################################################
dat$w2 <- factor(dat$w)


###################################################
### code chunk number 68: summeR-2-3-recoding-uniquebackupstring.Rnw:1110-1111
###################################################
table(dat$w2, dat$w)


###################################################
### code chunk number 69: summeR-2-3-recoding-uniquebackupstring.Rnw:1115-1117
###################################################
str(dat$w)
str(dat$w2)


###################################################
### code chunk number 70: summeR-2-3-recoding-uniquebackupstring.Rnw:1128-1131
###################################################
myintegers <- c(1, 3, 5, 7, 9, 9, 7, 5, 3, 1)
myfactor <- factor(myintegers, levels = c(1, 3, 5, 7, 9), 
                   labels = c("E", "D", "C", "B", "A"))


###################################################
### code chunk number 71: summeR-2-3-recoding-uniquebackupstring.Rnw:1135-1136
###################################################
str(myfactor)


###################################################
### code chunk number 72: summeR-2-3-recoding-uniquebackupstring.Rnw:1163-1164
###################################################
as.integer(myfactor)


###################################################
### code chunk number 73: summeR-2-3-recoding-uniquebackupstring.Rnw:1170-1173
###################################################
myintegers <- c(1, 3, 5, 7, 9, 9, 7, 5, 3, 1)
yourfactor <- factor(myintegers, levels = c(1, 9, 7), 
labels = c("cold", "warm", "hot"))


###################################################
### code chunk number 74: summeR-2-3-recoding-uniquebackupstring.Rnw:1179-1180
###################################################
str(yourfactor)


###################################################
### code chunk number 75: summeR-2-3-recoding-uniquebackupstring.Rnw:1185-1186
###################################################
table(as.integer(myfactor), as.integer(yourfactor), exclude = NULL)


###################################################
### code chunk number 76: summeR-2-3-recoding-uniquebackupstring.Rnw:1197-1200
###################################################
x <- c(1, 2, 1, 2, 2, 7)
xf <- factor(x, levels = c(7, 2, 1), labels = c("seven","two", "one"))
levels(xf)


###################################################
### code chunk number 77: summeR-2-3-recoding-uniquebackupstring.Rnw:1233-1235
###################################################
xf2 <- factor(x, levels = c(7, 2, 1))
levels(xf2)


###################################################
### code chunk number 78: summeR-2-3-recoding-uniquebackupstring.Rnw:1268-1269
###################################################
as.numeric(xf2)


###################################################
### code chunk number 79: summeR-2-3-recoding-uniquebackupstring.Rnw:1274-1277
###################################################
xnew <- as.numeric(levels(xf2))[xf2]
xnew
table(xnew, x)


###################################################
### code chunk number 80: summeR-2-3-recoding-uniquebackupstring.Rnw:1282-1285
###################################################
xnew2 <- as.numeric(as.character(xf2))
xnew2
table(xnew2, x)


###################################################
### code chunk number 81: summeR-2-3-recoding-uniquebackupstring.Rnw:1302-1304
###################################################
m1 <- lm(x ~ z + w2, data = dat)
summary(m1)


###################################################
### code chunk number 82: factor20
###################################################
plot(xf, main = "plot noticed its a factor!", xlab = "xf: a factor", ylab = "Count")
text(0.2, 2, "R noticed xf \n is a factor. \n So R ran table \n and sent output \n to barplot", pos=4)


###################################################
### code chunk number 83: summeR-2-3-recoding-uniquebackupstring.Rnw:1348-1350
###################################################
dat$w5 <- dat$w2
levels(dat$w5)


###################################################
### code chunk number 84: summeR-2-3-recoding-uniquebackupstring.Rnw:1354-1356
###################################################
levels(dat$w5) <- c("John", "Paul", "George", "Ringo", "Eric")
table(dat$w5, dat$w2)


###################################################
### code chunk number 85: summeR-2-3-recoding-uniquebackupstring.Rnw:1362-1364
###################################################
dat$w6 <- factor(dat$w2, levels = c("f", "g", "h", "i", "j"), labels = c("John", "Paul", "George", "Ringo", "Eric"))
table(dat$w6, dat$w2, exclude = NULL)


###################################################
### code chunk number 86: summeR-2-3-recoding-uniquebackupstring.Rnw:1372-1375
###################################################
library(rockchalk)
dat$w5 <- combineLevels(dat$w2, levs = c("f", "j"), newLabel = c("fandj"))
table(dat$w5, dat$w2)


###################################################
### code chunk number 87: summeR-2-3-recoding-uniquebackupstring.Rnw:1390-1393
###################################################
library(plyr)
dat$w5 <- mapvalues(dat$w2, from = c("f", "g", "h", "i", "j"), to = c("John", "Paul", "George", "Ringo", "Erik"))
str(dat$w5)


###################################################
### code chunk number 88: summeR-2-3-recoding-uniquebackupstring.Rnw:1398-1399
###################################################
newvals <- c("f" = "John", "g" = "Paul", "h" = "George", "i" = "Ringo", "j" = "Erik")


###################################################
### code chunk number 89: summeR-2-3-recoding-uniquebackupstring.Rnw:1405-1406
###################################################
names(newvals)


###################################################
### code chunk number 90: summeR-2-3-recoding-uniquebackupstring.Rnw:1411-1413
###################################################
dat$w6 <- mapvalues(dat$w2, from = names(newvals), to = newvals)
table(dat$w6, dat$w5)


###################################################
### code chunk number 91: summeR-2-3-recoding-uniquebackupstring.Rnw:1418-1420
###################################################
dat$w8 <- mapvalues(dat$w2, from = c("f", "g"), to = c("Roosevelt", "Lincoln"))
table(dat$w8)


###################################################
### code chunk number 92: summeR-2-3-recoding-uniquebackupstring.Rnw:1425-1428
###################################################
dat$w9 <- mapvalues(dat$w2, from = c("f", "g", "h"), 
          to = c("fgh", "fgh","fgh"))
table(dat$w9)


###################################################
### code chunk number 93: summeR-2-3-recoding-uniquebackupstring.Rnw:1438-1441
###################################################
dat$w7 <- dat$w2
dat$w7[dat$w7 %in% c("i","j")] <- NA
table(dat$w7, exclude = NULL)


###################################################
### code chunk number 94: summeR-2-3-recoding-uniquebackupstring.Rnw:1445-1448
###################################################
dat$w8 <- dat$w2
levels(dat$w8) <- c("f", "g", "h", NA, NA)
table(dat$w8)


###################################################
### code chunk number 95: summeR-2-3-recoding-uniquebackupstring.Rnw:1451-1452
###################################################
table(dat$w8, exclude = NULL)


###################################################
### code chunk number 96: summeR-2-3-recoding-uniquebackupstring.Rnw:1460-1462
###################################################
(xl <- levels(dat$w2))
xl[4:5]


###################################################
### code chunk number 97: xf60 (eval = FALSE)
###################################################
## dat$w10 <- dat$w2
## dat$w10[dat$w10 %in% xl[4:5]] <- NA


###################################################
### code chunk number 98: summeR-2-3-recoding-uniquebackupstring.Rnw:1481-1484
###################################################
x <- c(1, 2, 3, 3, 2, 1)
xf <- factor(x, levels = 1:7, labels = letters[1:7])
str(xf)


###################################################
### code chunk number 99: summeR-2-3-recoding-uniquebackupstring.Rnw:1488-1489
###################################################
table(xf)


###################################################
### code chunk number 100: xf130 (eval = FALSE)
###################################################
## y <- factor(y)


###################################################
### code chunk number 101: xf140 (eval = FALSE)
###################################################
## y <- y[ , drop = FALSE]


###################################################
### code chunk number 102: summeR-2-3-recoding-uniquebackupstring.Rnw:1520-1523 (eval = FALSE)
###################################################
## wdir <- "workingdata" 
## # That's our preferred name for created data
## saveRDS(myOldDat, file = file.path(wdir, "myWonderful.rds"))


###################################################
### code chunk number 103: summeR-2-3-recoding-uniquebackupstring.Rnw:1528-1530 (eval = FALSE)
###################################################
## wdir <- "workingdata"
## awesomeDat <- readRDS(file = file.path(wdir, "myWonderful.rds"))


###################################################
### code chunk number 104: summeR-2-3-recoding-uniquebackupstring.Rnw:1551-1556
###################################################
library(foreign)
ddir <- "data"
fp <- file.path(ddir, "04245-0001-Data.dta")
anes1 <- read.dta(fp)
anes1.orig <- anes1


###################################################
### code chunk number 105: key10a
###################################################
library(kutils)
keywide <- kutils::keyTemplate(anes1, file = "anes-widetemp.csv")


###################################################
### code chunk number 106: key10b
###################################################
keylong <- kutils::keyTemplate(anes1, long = TRUE)
keySave(keylong, file = "anes-longtemp.csv")


###################################################
### code chunk number 107: key10c
###################################################
keystata <- kutils::keyTemplateStata(fp, long = TRUE)


###################################################
### code chunk number 108: key11 (eval = FALSE)
###################################################
## View(keystata)


###################################################
### code chunk number 109: key20
###################################################
key <- keyImport("anes-wide.csv")


###################################################
### code chunk number 110: summeR-2-3-recoding-uniquebackupstring.Rnw:1656-1657 (eval = FALSE)
###################################################
## View(key)


###################################################
### code chunk number 111: key30
###################################################
anes2 <- keyApply(anes1, key, drop = "vars", diagnostic = TRUE)


###################################################
### code chunk number 112: summeR-2-3-recoding-uniquebackupstring.Rnw:1672-1673 (eval = FALSE)
###################################################
## peek(anes2)


###################################################
### code chunk number 113: summeR-2-3-recoding-uniquebackupstring.Rnw:1678-1680
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 114: key60
###################################################
rockchalk::summarize(anes2)


###################################################
### code chunk number 115: summeR-2-3-recoding-uniquebackupstring.Rnw:1688-1689
###################################################
options(options.orig)


###################################################
### code chunk number 116: key50
###################################################
hist(anes2$V043038, breaks = 50, xlim = c(-1, 101), main = "Bush Thermometer Scale")


###################################################
### code chunk number 117: key70
###################################################
anes2$th.bk <- anes2$V043038 - anes2$V043039


###################################################
### code chunk number 118: summeR-2-3-recoding-uniquebackupstring.Rnw:1721-1723
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 119: summeR-2-3-recoding-uniquebackupstring.Rnw:1726-1727
###################################################
table(anes1$V043038)


###################################################
### code chunk number 120: summeR-2-3-recoding-uniquebackupstring.Rnw:1730-1731
###################################################
options(options.orig)


###################################################
### code chunk number 121: num30
###################################################
hist(anes1$V043250, breaks = 40, main = "", xlab = "Age")


###################################################
### code chunk number 122: summeR-2-3-recoding-uniquebackupstring.Rnw:1762-1764
###################################################
anes1$aged <- cut(anes1$V043250, breaks = c(-1, 57, 200), labels = c("young", "old"))
table(anes1$aged)


###################################################
### code chunk number 123: num40
###################################################
plot(anes1$aged, xlab = "Age dichotomized")


###################################################
### code chunk number 124: num41
###################################################
t1 <- table(anes1$aged)
barplot(t1, beside = TRUE)


###################################################
### code chunk number 125: num10
###################################################
anes1$th.bk <- anes1$V043038 - anes1$V043039


###################################################
### code chunk number 126: num20
###################################################
hist(anes1$th.bk, breaks = 40, main = "Bush - Kerry", xlab = "Thermometer Difference")


###################################################
### code chunk number 127: anes30a0
###################################################
##Party
table(anes1$V043116, exclude = NULL)


###################################################
### code chunk number 128: anes30a2
###################################################
party_value_old <- levels(anes1$V043116)
party_value_new <- c("SD","WD","ID","I","IR","WR","SR", NA, NA, NA)
names(party_value_old) <- party_value_new
party_value_old


###################################################
### code chunk number 129: anes30a3
###################################################
levels(anes1$V043116) <- names(party_value_old)
## Could instead rely on plyr
## anes1$V043116 <- plyr::mapvalues(anes1$V043116, 
##            from = party_value_old, 
##            to = names(party_value_old))
table(anes1.orig$V043116, anes1$V043116)


###################################################
### code chunk number 130: summeR-2-3-recoding-uniquebackupstring.Rnw:1855-1857
###################################################
anes1$V043116 <- anes1$V043116[, drop = TRUE]
table(anes1$V043116, exclude = NULL)


###################################################
### code chunk number 131: summeR-2-3-recoding-uniquebackupstring.Rnw:1865-1867
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 132: anes30b1
###################################################
##IDEO
table(anes1$V045117, exclude = NULL)
levels_old <- levels(anes1$V045117)
levels_old
levels_new <- c("EL", "L", "SL", "M", "SC", "C", "EC", NA, NA, NA)
ideolevels <- data.frame(levels_old = levels_old,
               levels_new = levels_new,
               stringsAsFactors = FALSE)
ideolevels


###################################################
### code chunk number 133: anes30b2
###################################################
anes1$V045117 <- mapvalues(anes1$V045117, 
                    from = ideolevels$levels_old, 
                    to = ideolevels$levels_new)
anes1$V043116 <- anes1$V045117[, drop = TRUE]
rm(ideolevels) # remove unneeded object
table(anes1.orig$V045117, anes1$V045117) # check


###################################################
### code chunk number 134: summeR-2-3-recoding-uniquebackupstring.Rnw:1891-1892
###################################################
options(options.orig)


###################################################
### code chunk number 135: anes30c1
###################################################
##Gender
table(anes1$V041109A, exclude = NULL)


###################################################
### code chunk number 136: anes30c2
###################################################
levels(anes1$V041109A) <- c("M","F")


###################################################
### code chunk number 137: anes30d
###################################################
## Gay Marriage
levels(anes1$V043210) 
## Shorter names
levels(anes1$V043210) <- c("Allow","No","Some", NA, NA, NA) 
anes1$V043210 <- anes1$V043210[ , drop = TRUE]
table(anes1$V043210, exclude = NULL)


###################################################
### code chunk number 138: summeR-2-3-recoding-uniquebackupstring.Rnw:1927-1929
###################################################
anes1$V043210 <- factor(anes1$V043210, levels = c("No", "Some", "Allow"))
table(anes1.orig$V043210, anes1$V043210)


###################################################
### code chunk number 139: anes30e1
###################################################
## Economy
anes1$V043213 <- anes1$V043213[ , drop = TRUE]
table(anes1$V043213, exclude = NULL)


###################################################
### code chunk number 140: anes30e2
###################################################
lvl <- levels(anes1$V043213)
econnew <- factor(anes1$V043213, levels = lvl[c(2, 3, 1)], labels = c("Worse", "Same", "Better"))
table(anes1$V043213, econnew)
anes1$V043213 <- econnew
rm(econnew)


###################################################
### code chunk number 141: summeR-2-3-recoding-uniquebackupstring.Rnw:1957-1959
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 142: anes30f
###################################################
##Flag
(lvl <- levels(anes1$V045145X))
anes1$V045145X[anes1$V045145X %in% lvl[6:7]] <- NA
anes1$V045145X <- anes1$V045145X[, drop = TRUE] 
table(anes1$V045145X)
levels(anes1$V045145X) <- c("EG", "VG", "SG", "NVG", "DFA")
table(anes1$V045145X)


###################################################
### code chunk number 143: summeR-2-3-recoding-uniquebackupstring.Rnw:1973-1974
###################################################
options(options.orig)


###################################################
### code chunk number 144: summeR-2-3-recoding-uniquebackupstring.Rnw:1991-1992 (eval = FALSE)
###################################################
## kutils:::keyDiagnostic(anes1, anes2, kutils:::makeKeylist(key))


###################################################
### code chunk number 145: save1
###################################################
today <- format(Sys.time(), "%Y%m%d")
wdir <- "workingdata"
if(!file.exists(wdir)) dir.create(wdir)
saveRDS(anes1, file = file.path(wdir, paste0("nes2004-", today, ".rds")))


###################################################
### code chunk number 146: anes20
###################################################
plot(V043038 ~ V043213, ylab="Bush Thermometer", xlab="Economic Expectations", data = anes1)


###################################################
### code chunk number 147: anes15
###################################################
plot(jitter(V043038) ~ V043250, ylab = "Bush Thermometer", xlab = "Age", data = anes1)


###################################################
### code chunk number 148: anes40
###################################################
mod1 <- lm(th.bk ~ V043250, data = anes1)
summary(mod1)


###################################################
### code chunk number 149: anes45
###################################################
mod2 <- lm(th.bk ~ V043250 + V041109A, data = anes1)
summary(mod2)


###################################################
### code chunk number 150: anes60b
###################################################
mod2mm <- model.matrix(mod2)
head(mod2mm)


###################################################
### code chunk number 151: anes70
###################################################
mod3 <- lm(th.bk ~ V043250 + V041109A + V043116, data = anes1)
summary(mod3)


###################################################
### code chunk number 152: anes70b
###################################################
mod3mm <- model.matrix(mod3)
head(mod3mm, 10)


###################################################
### code chunk number 153: save2
###################################################
save(mod1, mod2, mod3, file = file.path(wdir, paste0("nes2004-objects-", today,  ".RData")))


###################################################
### code chunk number 154: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 155: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


