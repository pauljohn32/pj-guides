### R code from vignette source 'data-1n.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: data-1n.Rnw:92-94
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 2: Roptions
###################################################
options(width=160, prompt="> ", continue="  ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par()
pjmar <- c(5.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)


###################################################
### code chunk number 3: data-1n.Rnw:226-227 (eval = FALSE)
###################################################
##   colnames(dat)


###################################################
### code chunk number 4: data-1n.Rnw:298-299 (eval = FALSE)
###################################################
##    dat <- read.table(file = "whatever.txt", header = TRUE, sep = ",")


###################################################
### code chunk number 5: dat10
###################################################
  dat <- read.table("examples/practiceData.txt", header = TRUE)


###################################################
### code chunk number 6: dat15
###################################################
head(dat)


###################################################
### code chunk number 7: dat20
###################################################
str(dat)


###################################################
### code chunk number 8: dat25
###################################################
colnames(dat)


###################################################
### code chunk number 9: dat30
###################################################
   summary(dat)


###################################################
### code chunk number 10: dat35
###################################################
rockchalk::summarize(dat)


###################################################
### code chunk number 11: dat40
###################################################
dim(dat)


###################################################
### code chunk number 12: dat45
###################################################
rownames(dat)


###################################################
### code chunk number 13: data-1n.Rnw:389-390
###################################################
names(dat)


###################################################
### code chunk number 14: dat50
###################################################
attributes(dat)


###################################################
### code chunk number 15: exercise01 (eval = FALSE)
###################################################
## dat <- read.table("examples/trouble-1.txt")


###################################################
### code chunk number 16: exercise02 (eval = FALSE)
###################################################
## dat <- read.table("examples/trouble-2.txt")


###################################################
### code chunk number 17: dat51a (eval = FALSE)
###################################################
## View(dat)


###################################################
### code chunk number 18: dat51b (eval = FALSE)
###################################################
## fix(dat)


###################################################
### code chunk number 19: dat60
###################################################
plot(dat)


###################################################
### code chunk number 20: dat70 (eval = FALSE)
###################################################
## write.table(dat, file = "newPractice.txt", row.names = FALSE, sep = "|")


###################################################
### code chunk number 21: dat75 (eval = FALSE)
###################################################
## write.table(dat, file = "examples/newPractice.txt", row.names = FALSE, sep = "|")


###################################################
### code chunk number 22: dat80 (eval = FALSE)
###################################################
## dat <- read.table("examples/newPractice.txt", sep = "|", header = TRUE)


###################################################
### code chunk number 23: dat85 (eval = FALSE)
###################################################
## getwd()


###################################################
### code chunk number 24: dat90
###################################################
dat2 <- read.table(file=gzfile("examples/practiceData.txt.gz"), header=T)
identical(dat, dat2)


###################################################
### code chunk number 25: dat95 (eval = FALSE)
###################################################
## dat <- read.table(url("http://pj.freefaculty.org/guides/Rcourse/data-1/examples/practiceData.txt"), sep = ",", header = TRUE)


###################################################
### code chunk number 26: dat100 (eval = FALSE)
###################################################
## download.file("http://pj.freefaculty.org/guides/Rcourse/data-1/examples/practiceData.txt", destfile = "practiceData.txt")


###################################################
### code chunk number 27: dat105 (eval = FALSE)
###################################################
## fn1 <- "practiceData.txt"
## addr <- "http://pj.freefaculty.org/guides/Rcourse/data-1/examples"
## download.file(paste0(addr, fn1), destfile = fn1)
## dat <- read.table(fn1, header = TRUE, sep = ",")


###################################################
### code chunk number 28: dat110
###################################################
dat$noise <- rnorm(nrow(dat), m = 444, sd = 234)
dat[["moreNoise"]] <- rnorm(nrow(dat), m = 0, sd = 1)


###################################################
### code chunk number 29: dat115
###################################################
dat$newed <- dat$ed


###################################################
### code chunk number 30: dat120
###################################################
dat[["ed"]] <- NULL


###################################################
### code chunk number 31: dat130
###################################################
colnames(dat)
rockchalk::summarize(dat)


###################################################
### code chunk number 32: ren25 (eval = FALSE)
###################################################
## colnames(dat) <- c("colone", "coltwo", "three", "andSoForth")


###################################################
### code chunk number 33: ren30
###################################################
   mycolnames <- colnames(dat)
   mycolnames


###################################################
### code chunk number 34: ren40
###################################################
origname <- mycolnames[2] ##need a copy
mycolnames[2] <- "WhateverPJSays"
colnames(dat) <- mycolnames
colnames(dat)


###################################################
### code chunk number 35: ren50
###################################################
colnames(dat)[2] <- origname
dat$ed <- dat$newed
colnames(dat)


###################################################
### code chunk number 36: recode10 (eval = FALSE)
###################################################
## dat$ed[dat$ed == 47] <- 17


###################################################
### code chunk number 37: recode15 (eval = FALSE)
###################################################
## dat[dat$ed == 47, "ed"] <- 17


###################################################
### code chunk number 38: recode20 (eval = FALSE)
###################################################
## dat[7, 2] <- 17


###################################################
### code chunk number 39: recode25 (eval = FALSE)
###################################################
## dat$ed[dat$ed %in% c(190, 191, 192, 200) ] <- 99


###################################################
### code chunk number 40: recode30
###################################################
dat$ed[dat$ed == 99] <- NA


###################################################
### code chunk number 41: recode35
###################################################
dat$noise[dat$noise > mean(dat$noise)] <- NA


###################################################
### code chunk number 42: recode40 (eval = FALSE)
###################################################
## dat$ed[dat$ed %in% c(110, 190, 191, 192, 200) ] <- NA


###################################################
### code chunk number 43: recode45
###################################################
dat2 <- read.table("examples/newp.sas.txt",header=T,sep="|")
str(dat2$noise)


###################################################
### code chunk number 44: recode50
###################################################
dat2 <- read.table("examples/newp.sas.txt", header = TRUE, sep = "|", na.strings = c("NA","."))
str(dat2$noise)


###################################################
### code chunk number 45: recode55
###################################################
   attributes(dat$ed)
   is.numeric(dat$ed)
   is.factor(dat$ed)


###################################################
### code chunk number 46: recode60
###################################################
   dat$edlog <- log(1 + dat$ed)
   dat$edsqrt <- sqrt(dat$ed)
   dat$edexp <- exp(dat$ed)
   head(dat)


###################################################
### code chunk number 47: str
###################################################
dat$grp


###################################################
### code chunk number 48: data-1n.Rnw:974-977
###################################################
dat$grpfac1 <- factor(dat$grp)
str(dat$grpfac1)
with(dat, table(grpfac1, grp))


###################################################
### code chunk number 49: data-1n.Rnw:989-992
###################################################
dat$grpfac1 <- factor(dat$grp, labels = c("Number1", "Number2", "Number3"))
str(dat$grpfac1)
with(dat, table(grp, grpfac1))


###################################################
### code chunk number 50: data-1n.Rnw:1007-1010
###################################################
dat$grpfaco <- factor(dat$grp, levels = c("2","1","3"), labels = c("Number2", "Number1", "Number3"))
str(dat$grpfaco)



###################################################
### code chunk number 51: data-1n.Rnw:1013-1014
###################################################
with(dat, table(grp, grpfaco))


###################################################
### code chunk number 52: data-1n.Rnw:1019-1020
###################################################
head(dat[  , c("grp", "grpfaco", "grpfac1")])


###################################################
### code chunk number 53: data-1n.Rnw:1023-1024
###################################################
rbind(grp = dat$grp, grpfaco = as.numeric(dat$grpfaco))[ ,1:6]


###################################################
### code chunk number 54: data-1n.Rnw:1057-1058
###################################################
quantile(dat$moreNoise)


###################################################
### code chunk number 55: data-1n.Rnw:1061-1064
###################################################
dat$mn1 <- cut(dat$moreNoise, breaks = c(-10, -1, -0.3, 0.7, 1, 10))
table(dat$mn1)
levels(dat$mn1)


###################################################
### code chunk number 56: data-1n.Rnw:1071-1073 (eval = FALSE)
###################################################
## dat$mn1 <- cut(dat$moreNoise, breaks = c(-10, 1, -0.3, 0.7, 1, 10),
## labels = c("never", "seldom", "some", "freq", "often"))


###################################################
### code chunk number 57: data-1n.Rnw:1077-1078 (eval = FALSE)
###################################################
## levels$mn1 <- c("never", "seldom", "some", "freq", "often")


###################################################
### code chunk number 58: exercise10 (eval = FALSE)
###################################################
## x <- c("Y","N","Y","Y","F","N")
## is.factor(x)
## is.character(x)
## xf1 <- factor(x)
## xf1
## levels(xf1)
## x[1] <- "P"
## xf1[1] <- "P"
## xf1[1] <- "F"
## xf1levs <- levels(xf1)
## xf1[1] <-  xf1levs[2]
## xf2 <- factor(x, levels = c("Y","N","anything"), labels  = c("HECK","YES","irrelevant"))
## table(x, xf2, exclude = NULL)
## xf2[1] <- "Y"
## levels(xf2)
## xf2[1] <- "HECK"
## xf2


###################################################
### code chunk number 59: data-1n.Rnw:1118-1122
###################################################
 x <- c("Y","N","Y","Y","F","N")

is.factor(x)
is.character(x)


###################################################
### code chunk number 60: data-1n.Rnw:1126-1129
###################################################
xf1 <- factor(x)
xf1
levels(xf1)


###################################################
### code chunk number 61: data-1n.Rnw:1141-1142
###################################################
x[1] <- "P"


###################################################
### code chunk number 62: data-1n.Rnw:1149-1150
###################################################
levels(xf1)


###################################################
### code chunk number 63: data-1n.Rnw:1154-1155 (eval = FALSE)
###################################################
## xf1[1] <- "P"


###################################################
### code chunk number 64: data-1n.Rnw:1172-1173
###################################################
xf1[1] <- "F"


###################################################
### code chunk number 65: data-1n.Rnw:1180-1182
###################################################
xf1levs <- levels(xf1)
xf1[1] <-  xf1levs[2]


###################################################
### code chunk number 66: data-1n.Rnw:1185-1186
###################################################
xf1[1] <- levels(xf1[1])[2]


###################################################
### code chunk number 67: data-1n.Rnw:1202-1204
###################################################
xf2 <- factor(x, levels=c("Y","N","anything"), labels=c("HECK","YES","irrelevant"))
table(x, xf2, exclude = NULL)


###################################################
### code chunk number 68: data-1n.Rnw:1209-1211
###################################################
xf2 <- factor(xf2)
table(x, xf2, exclude = NULL)


###################################################
### code chunk number 69: data-1n.Rnw:1218-1219 (eval = FALSE)
###################################################
## xf2[1] <- "anything"


###################################################
### code chunk number 70: data-1n.Rnw:1230-1231
###################################################
levels(xf2)


###################################################
### code chunk number 71: data-1n.Rnw:1235-1236
###################################################
  xf2[1] <- "HECK"


###################################################
### code chunk number 72: echo
###################################################
 xf2


###################################################
### code chunk number 73: data-1n.Rnw:1254-1258
###################################################
xf3 <- xf2
levels(xf3) <- c(levels(xf3), "Denver")
xf3[5] <- "Denver"
data.frame(x, xf1, xf2, xf3)


###################################################
### code chunk number 74: data-1n.Rnw:1272-1275
###################################################
dat$grpfac2 <- factor(dat$grp, levels = c(2,1,3), labels = c("Western","Midwest","Eastern"))
str(dat$grpfac2)
with(dat, table(grpfac2, grp))


###################################################
### code chunk number 75: data-1n.Rnw:1292-1293 (eval = FALSE)
###################################################
## levels(dat$grpfac2) <- c("Midwest", "Eastern", "Western")


###################################################
### code chunk number 76: data-1n.Rnw:1297-1301
###################################################
dat$grpfac3 <- dat$grpfac2
levels(dat$grpfac3) <- c("Midwest","Western","Eastern")
str(dat$grpfac3)
with(dat, table(grpfac3, grpfac2))


###################################################
### code chunk number 77: data-1n.Rnw:1318-1319 (eval = FALSE)
###################################################
## levels(dat$grpfac3)


###################################################
### code chunk number 78: reorg10 (eval = FALSE)
###################################################
## newFactor <- levels(oldFactor, levels=c("C", "B", "A"), labels=c("car", "bus", "auto"))


###################################################
### code chunk number 79: reorg20
###################################################
levels(dat$grpfac2)


###################################################
### code chunk number 80: reorg30
###################################################
dat$grpfac4 <- with(dat,  factor(grpfac2, levels=c("Eastern","Western","Midwest")))
with(dat, table(grpfac4, grpfac2))


###################################################
### code chunk number 81: data-1n.Rnw:1382-1384
###################################################
dat$grpfac5 <- with(dat,  relevel(grpfac2, ref="Eastern"))
with(dat, table(grpfac5, grpfac2))


###################################################
### code chunk number 82: data-1n.Rnw:1399-1400
###################################################
coef(summary(lm(newed ~ grpfac2, data = dat)))[ ,1:2]


###################################################
### code chunk number 83: data-1n.Rnw:1410-1411
###################################################
coef(summary(lm(newed ~ grpfac4, data = dat)))[,1:2]


###################################################
### code chunk number 84: comb10
###################################################
x <- c("A","B","C","B","C")


###################################################
### code chunk number 85: data-1n.Rnw:1432-1433 (eval = FALSE)
###################################################
## f <- factor(x, levels = c("A","B","C"), labels = c("A","B","B"))


###################################################
### code chunk number 86: data-1n.Rnw:1444-1448
###################################################
levels(x) <- c(levels(x), "BorC")
x[ x %in% c("B", "C")] <- "BorC"
x <- factor(x)
table(x)


###################################################
### code chunk number 87: data-1n.Rnw:1452-1455
###################################################
levels(x)
levels(x) <- c("A","B")
table(x)


###################################################
### code chunk number 88: combineLevels
###################################################
x <- factor(c("A","B","C","B","C","A"))
xrc <- rockchalk::combineLevels(x, c("B","C"), "BorC")
table(xrc, x)


###################################################
### code chunk number 89: data-1n.Rnw:1496-1497 (eval = FALSE)
###################################################
## save(dat, file="practiceData.RData")


###################################################
### code chunk number 90: data-1n.Rnw:1501-1502 (eval = FALSE)
###################################################
##   rm(dat)


###################################################
### code chunk number 91: data-1n.Rnw:1506-1508 (eval = FALSE)
###################################################
## load("practiceData.RData")
## str(dat)


###################################################
### code chunk number 92: saveRDS
###################################################
saveRDS(dat, "practiceData.rds")
dat99 <- readRDS("practiceData.rds")
str(dat99)
identical(dat, dat99)


