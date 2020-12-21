### R code from vignette source 'data2n.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: data2n.Rnw:84-86
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
### code chunk number 3: data2n.Rnw:301-302 (eval = FALSE)
###################################################
## plot(y ~ x, data = mydf)


###################################################
### code chunk number 4: data2n.Rnw:305-306 (eval = FALSE)
###################################################
## lm(y ~ x, data = mydf)


###################################################
### code chunk number 5: data2n.Rnw:504-505 (eval = FALSE)
###################################################
## system("unzip 10243963.zip")


###################################################
### code chunk number 6: exercise10 (eval = FALSE)
###################################################
## require(foreign)
## mydta1 <- read.dta("examples/04245-0001-Data.dta")
## str(mydta1)
## colnames(mydta1)
## attributes(mydta1)
## View(mydta1)


###################################################
### code chunk number 7: data2n.Rnw:597-598 (eval = FALSE)
###################################################
## levels(mydta1$V043116)


###################################################
### code chunk number 8: data2n.Rnw:641-642 (eval = FALSE)
###################################################
## table(mydta1$V043116)


###################################################
### code chunk number 9: data2n.Rnw:676-679 (eval = FALSE)
###################################################
## partyid <- mydta1$V043116
## levels(partyid) <- c("SD","WD","ILD","II",
##               "ILR","WR","SR","O","APol","DK")


###################################################
### code chunk number 10: data2n.Rnw:684-687 (eval = FALSE)
###################################################
## partyid <- partyid[ , drop=TRUE]
## # same as partyid <- factor(partyid)
## table(partyid)


###################################################
### code chunk number 11: data2n.Rnw:713-714 (eval = FALSE)
###################################################
## partyid[partyid %in% levels(partyid)[8]] <- NA


###################################################
### code chunk number 12: data2n.Rnw:725-726 (eval = FALSE)
###################################################
## table(partyid, exclude = NULL)


###################################################
### code chunk number 13: data2n.Rnw:738-739 (eval = FALSE)
###################################################
## partyid[partyid %in% levels(partyid)[5:8] ] <- NA


###################################################
### code chunk number 14: data2n.Rnw:752-754 (eval = FALSE)
###################################################
## mydtanum1 <- read.dta("examples/04245-0001-Data.dta",
##                 convert.factors=F)


###################################################
### code chunk number 15: data2n.Rnw:769-770 (eval = FALSE)
###################################################
## table(mydtanum1$V1234, mydat1$V1234)


###################################################
### code chunk number 16: data2n.Rnw:1091-1093 (eval = FALSE)
###################################################
## datraw <- read.spss("04697-0001-Data.sav", to.data.frame=T,
##                  trim.factor.names=T)


###################################################
### code chunk number 17: data2n.Rnw:1169-1171 (eval = FALSE)
###################################################
## datnum <- read.spss("04697-0001-Data.sav", use.value.labels = FALSE,
##                  to.data.frame=T, trim.factor.names=T)


###################################################
### code chunk number 18: data2n.Rnw:1175-1176 (eval = FALSE)
###################################################
## table(datraw$SEX, datnum$SEX)


###################################################
### code chunk number 19: data2n.Rnw:1294-1295 (eval = FALSE)
###################################################
## dat2 <- datraw[datraw$YEAR == 2006, ]


###################################################
### code chunk number 20: data2n.Rnw:1317-1326 (eval = FALSE)
###################################################
## ### sapply a function that counts NAP in each variable
## ### result sout is a vector with an NAP count for each column
## sout <- sapply( dat2, function(x) length(x[x == "NAP"]))
## ### which variables have less than 4000 cases NAP
## wsout <- which(sout < 4000)
## ### choose those variables
## datnew <- dat2[, wsout]
## ### Save to R data frame
## save(datnew, file="gss-subset1.Rda")


###################################################
### code chunk number 21: data2n.Rnw:1411-1412 (eval = FALSE)
###################################################
## d2 <- read.spss("ESS3e03_2.por", to.data.frame = TRUE)


###################################################
### code chunk number 22: data2n.Rnw:1436-1437 (eval = FALSE)
###################################################
## d2 <- read.spss("ESS3e03_2.por")


###################################################
### code chunk number 23: data2n.Rnw:1441-1442 (eval = FALSE)
###################################################
## d2 <- as.data.frame(d2)


###################################################
### code chunk number 24: data2n.Rnw:1474-1475 (eval = FALSE)
###################################################
## d2$whichSurvey <- 2


###################################################
### code chunk number 25: data2n.Rnw:1480-1483 (eval = FALSE)
###################################################
## d3 <- read.spss("ESS2e03_1.por")
## d3 <- as.data.frame(d3)
## d3$whichSurvey <- 3


###################################################
### code chunk number 26: data2n.Rnw:1502-1508 (eval = FALSE)
###################################################
## namesd2 <- names(d2)
## namesd3 <- names(d3)
## 
## commonNames <- intersect( namesd3, namesd2)
## combod23 <- rbind(d2[ , commonNames], d3[, commonNames])
## save(combod23, file = "combod23.Rda")


###################################################
### code chunk number 27: data2n.Rnw:1538-1539 (eval = FALSE)
###################################################
## levels(combod23$HAPPY)


###################################################
### code chunk number 28: data2n.Rnw:1568-1569 (eval = FALSE)
###################################################
## combod23$HAPPY2 <- combod23$HAPPY


###################################################
### code chunk number 29: data2n.Rnw:1574-1575 (eval = FALSE)
###################################################
## levels(combod23$HAPPY2)[1] <- "0"


###################################################
### code chunk number 30: data2n.Rnw:1580-1581 (eval = FALSE)
###################################################
## levels(combod23$HAPPY2)[11] <- "10"


###################################################
### code chunk number 31: data2n.Rnw:1586-1587 (eval = FALSE)
###################################################
## happyLevels <- levels(combod23$HAPPY2)


###################################################
### code chunk number 32: data2n.Rnw:1602-1605 (eval = FALSE)
###################################################
## combod23$HAPPY2[combod23$HAPPY2 %in% happyLevels[12:14] ] <- NA
## ## Check result
## table(combod23$HAPPY, combod23$HAPPY2)


###################################################
### code chunk number 33: data2n.Rnw:1610-1611 (eval = FALSE)
###################################################
## combod23$HAPPY2 <- factor(combod23$HAPPY2)


###################################################
### code chunk number 34: data2n.Rnw:1616-1617 (eval = FALSE)
###################################################
## combod23$HAPPYN <- as.numeric(happyLevels)[combod23$HAPPY2]


###################################################
### code chunk number 35: data2n.Rnw:1623-1624 (eval = FALSE)
###################################################
## table(combod23$HAPPYN)


###################################################
### code chunk number 36: data2n.Rnw:1705-1715 (eval = FALSE)
###################################################
## library(memisc)
## scbs <- spss.portable.file("usmisc2000-soccap.por")
## ## shows var names & descriptions
## description(scbs)
## ## Generates a codebook
## codebook(scbs)
## ## Causes the data to actually be read
## scbsdat <- as.data.frame(scbs)
## ## If only need a few variables, do this instead
## ##scbsdat <- subset(scbs, select = c(tr2nei,tr2cop, effcom, polknow))


###################################################
### code chunk number 37: data2n.Rnw:1806-1808
###################################################
library(foreign)
dat <- read.spss("examples/AB_10-23-2009_Eng_for_deposit.sav", to.data.frame = TRUE)


###################################################
### code chunk number 38: hist1
###################################################
hist(dat$q701, breaks = 20, prob = TRUE, xlab = "Age in Years, except Morocco 1-7")


###################################################
### code chunk number 39: data2n.Rnw:1872-1873
###################################################
datm <- dat[dat$country == "Morocco", ]


###################################################
### code chunk number 40: data2n.Rnw:1876-1877
###################################################
dato <- dat[! dat$country == "Morocco", ]


###################################################
### code chunk number 41: data2n.Rnw:1892-1894
###################################################
datm$q701f <- factor(datm$q701, levels=1:7, labels=c("18-24", "25-34", "35-44","45-54","55-64","65-74","75+"))
table(datm$q701f, datm$q701)


###################################################
### code chunk number 42: data2n.Rnw:1905-1908
###################################################
dato$q701f <- cut(dato$q701,  breaks <- c(17, 24, 34, 44, 54, 64, 74, 110),
labels=c("18-24", "25-34", "35-44", "45-54", "55-64", "65-74", "75+"))
table(dato$q701f)


###################################################
### code chunk number 43: data2n.Rnw:1919-1921
###################################################
dat2 <- rbind(dato, datm)
table(dat2$q701f, dat2$country)


