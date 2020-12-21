### R code from vignette source 'summeR-3-1-stats-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-3-1-stats-uniquebackupstring.Rnw:33-34
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
### code chunk number 4: summeR-3-1-stats-uniquebackupstring.Rnw:261-262
###################################################
sessionInfo()


###################################################
### code chunk number 5: summeR-3-1-stats-uniquebackupstring.Rnw:273-274 (eval = FALSE)
###################################################
## help(package="stats")


###################################################
### code chunk number 6: summeR-3-1-stats-uniquebackupstring.Rnw:424-425 (eval = FALSE)
###################################################
## plot(y ~ x)


###################################################
### code chunk number 7: summeR-3-1-stats-uniquebackupstring.Rnw:447-448 (eval = FALSE)
###################################################
## m1 <- lm(mydv ~ x1 + x2 + x3 + x4, data = wonderful)


###################################################
### code chunk number 8: summeR-3-1-stats-uniquebackupstring.Rnw:532-533
###################################################
(ls.old <- ls())


###################################################
### code chunk number 9: load
###################################################
load("data/gss-subset2.Rda")


###################################################
### code chunk number 10: summeR-3-1-stats-uniquebackupstring.Rnw:545-547
###################################################
(ls.new <- ls())
setdiff(ls.new, ls.old)


###################################################
### code chunk number 11: summeR-3-1-stats-uniquebackupstring.Rnw:560-562
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 12: summeR-3-1-stats-uniquebackupstring.Rnw:567-568
###################################################
summary(dat)


###################################################
### code chunk number 13: summeR-3-1-stats-uniquebackupstring.Rnw:571-572
###################################################
options(options.orig)


###################################################
### code chunk number 14: summeR-3-1-stats-uniquebackupstring.Rnw:637-638
###################################################
mean(dat$age)


###################################################
### code chunk number 15: summeR-3-1-stats-uniquebackupstring.Rnw:644-646
###################################################
range(dat$age)
max(dat$age)


###################################################
### code chunk number 16: summeR-3-1-stats-uniquebackupstring.Rnw:667-670
###################################################
mean(dat$age, na.rm = TRUE)
range(dat$age, na.rm = TRUE)
quantile(dat$age, na.rm = TRUE)


###################################################
### code chunk number 17: summeR-3-1-stats-uniquebackupstring.Rnw:751-755
###################################################
t1 <- table(dat$gunlaw, dat$owngun)
t1
prop.table(t1, 2)
addmargins(t1)


###################################################
### code chunk number 18: summeR-3-1-stats-uniquebackupstring.Rnw:763-765
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 19: summeR-3-1-stats-uniquebackupstring.Rnw:769-771
###################################################
library(gmodels)
CrossTable(dat$gunlaw, dat$owngun)


###################################################
### code chunk number 20: summeR-3-1-stats-uniquebackupstring.Rnw:774-775
###################################################
options(options.orig)


###################################################
### code chunk number 21: summeR-3-1-stats-uniquebackupstring.Rnw:789-791
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 22: summeR-3-1-stats-uniquebackupstring.Rnw:795-797
###################################################
library(rockchalk)
pctable(gunlaw ~ owngun, data = dat, rvlab = "Stance on Gun Registration", cvlab = "Does Respondent Own a Gun?")


###################################################
### code chunk number 23: summeR-3-1-stats-uniquebackupstring.Rnw:800-801
###################################################
options(options.orig)


###################################################
### code chunk number 24: pctable20
###################################################
pctable20 <- pctable(gunlaw ~ owngun, data = dat, rvlab = "Stance on Gun Registration", cvlab = "Does Respondent Own a Gun?")
require(tables)
require(Hmisc)
tabsum <- summary(pctable20, rowpct = FALSE, colpct = TRUE)
tabsum <- apply(tabsum, 1:2, function(x) {gsub("%", "\\\\%", x) })
tabsum.hmisc <- Hmisc::latex(tabsum, file = "tmpout/t-pctable20a.tex")


###################################################
### code chunk number 25: scat10
###################################################
plot(sei ~ educ, data = dat, cex = 0.5, lwd = 0.2, main = "", 
xlab =  "Education (years)", ylab = "Socio-economic Status", ylim = c(0, 100))


###################################################
### code chunk number 26: scat20
###################################################
plot(sei ~ educ, data = dat,  main = "", xlab = "Education (years)", 
    ylab = "Socio-economic Status", ylim = c(0,120), type = "n")
sexcolor <- ifelse(dat$sex == "MALE", "black", "gray60")
sexpch <- ifelse(dat$sex == "MALE", 1, 4)
points(sei ~ educ, data = dat, cex = 0.5, lwd = 0.2, 
    col = sexcolor, pch = sexpch)
legend("topleft", legend = c("Male","Female"), 
    col = c("black","gray80"), pch = c(1,4))


###################################################
### code chunk number 27: scat30
###################################################
plot(jitter(sei) ~ jitter(educ), data = dat, cex = 0.5, lwd = 0.2, main = "", xlab =  "Education (years)", ylab = "Socio-economic Status", ylim = c(0, 100))


###################################################
### code chunk number 28: summeR-3-1-stats-uniquebackupstring.Rnw:881-885 (eval = FALSE)
###################################################
## library(hexbin)
## help(package = "hexbin")
## example(hexbin)
## vignette("hexabon_binning")


###################################################
### code chunk number 29: scat70
###################################################
library(hexbin)
hbin <- hexbin(dat$educ, dat$sei, xbins = 40)
plot(hbin, xlab = "Education", ylab = "Socio Economic Status", 
    main =  "Hexagon-binned Data Plot",
    lcex = 0.6)


###################################################
### code chunk number 30: scat80
###################################################
hexbinplot(sei ~ educ, dat, 
       xlab = "Education", ylab = "Socio Economic Status", 
       main =  "Hexagon via lattice graphics")


###################################################
### code chunk number 31: summeR-3-1-stats-uniquebackupstring.Rnw:930-933 (eval = FALSE)
###################################################
## library(lattice)
## example(xyplot)
## ?xyplot


###################################################
### code chunk number 32: scat90
###################################################
hexbinplot(sei ~ educ | sex, dat, 
       xlab = "Education", ylab = "Socio Economic Status", 
       main =  "Hexagon via lattice graphics")


###################################################
### code chunk number 33: box09
###################################################
set.seed(234234)
x <- rnorm(1000, m=50, sd=10)


###################################################
### code chunk number 34: box10
###################################################
boxplot(x)
text(0.8, median(x), paste("median is", round(median(x), 2)), pos=2)
text(1.2, 37, paste("box=interquartile \n range"))


###################################################
### code chunk number 35: box11
###################################################
x <- 40 + 8*rgamma(1000, 1, 2)


###################################################
### code chunk number 36: box12
###################################################
boxplot(x, xlim=c(0,2))
text(0.8, median(x), paste("median is", round(median(x), 2)), pos=2)
text(1.2, mean(x), paste("mean is", round(mean(x),1)), pos=4)
points(1.0, mean(x), pch=13, col="red", cex=2)


###################################################
### code chunk number 37: box13
###################################################
hist(x, main="")


###################################################
### code chunk number 38: box19
###################################################
dat$totnum <- dat$nummen + dat$numwomen
hist(dat$totnum, prob=TRUE, xlab="Total sexual partners (Male + Female)", main = "All Respondents")


###################################################
### code chunk number 39: box20
###################################################
dat$totnum <- dat$nummen + dat$numwomen
dat$totnum[dat$totnum > 99] <- NA  #exclude liars and prostitutes
par(mfcol=c(1,2))
datmale <- dat[dat$sex %in% levels(dat$sex)[1], ]
hist(datmale$totnum, prob=TRUE, xlab="Total sexual partners (Male + Female)", main="Respondents: Male")
datfemale <- dat[dat$sex %in% levels(dat$sex)[2], ]
hist(datfemale$totnum,  prob=TRUE, xlab="Total sexual partners (Male + Female)", main="Respondents: Female")
par(mfcol=c(1,1))


###################################################
### code chunk number 40: box40
###################################################
# One approach
boxplot(totnum~ sex , data=dat, ylab="Sex Partners since age 18 (excl. cases > 99)",xlab="Respondent Gender", names=c("Male","Female"))


###################################################
### code chunk number 41: box50
###################################################
lsex <- levels(dat$sex)
lsexsex5 <- levels(dat$sexsex5)

dat$gpref <- NA
dat$gpref[dat$sex %in% lsex[1] & dat$sexsex5 %in% lsexsex5[1]] <- "M-only M"
dat$gpref[dat$sex %in% lsex[1] & dat$sexsex5 %in% lsexsex5[2]] <- "M-bi"
dat$gpref[dat$sex %in% lsex[1] & dat$sexsex5 %in% lsexsex5[3]] <- "M-only W"
dat$gpref[dat$sex %in% lsex[2] & dat$sexsex5 %in% lsexsex5[1]] <- "W-only M"
dat$gpref[dat$sex %in% lsex[2] & dat$sexsex5 %in% lsexsex5[2]] <- "W-bi"
dat$gpref[dat$sex %in% lsex[2] & dat$sexsex5 %in% lsexsex5[3]] <- "W-only W"
dat$gpref <- factor(dat$gpref, levels= c( "M-only M","M-bi","M-only W", "W-only M","W-bi", "W-only W"  ))


bp1 <- boxplot(totnum ~ gpref , data=dat, ylab="Sex Partners since age 18 (excl. cases > 99)", xlab="Respondent Gender")

gprefcounts <- by(dat, dat$gpref, function(x) length(x$gpref))
gprefmeans <- by(dat, dat$gpref, function(x) mean(x$totnum, na.rm=T))
gprefmeans <- round(gprefmeans, 2)
gprefmeds <- bp1$stats[3,]

abline(h=seq(5,120,by=5), lty=2, lwd=0.7, col="gray80")
### Really wanted this, but does not fit!
###text( 1:6, gprefmeds, as.character(gprefmeds), pos=2, cex=0.7,bg="white")

### Stupid. Should have used mapply to get this in 1 command
text(1, gprefmeans[1], bquote(paste(bar(y)[1] == .(gprefmeans[1]),sep="")),pos=3, cex=0.8 )
text(2, gprefmeans[2], bquote(paste(bar(y)[2] == .(gprefmeans[2]),sep="")),pos=3, cex=0.8)
text(3, gprefmeans[3], bquote(paste(bar(y)[3] == .(gprefmeans[3]),sep="")),pos=3, cex=0.8)
text(4, gprefmeans[4], bquote(paste(bar(y)[4] == .(gprefmeans[4]),sep="")),pos=3, cex=0.8)
text(5, gprefmeans[5], bquote(paste(bar(y)[5] == .(gprefmeans[5]),sep="")),pos=3, cex=0.8)
text(6, gprefmeans[6], bquote(paste(bar(y)[6] == .(gprefmeans[6]),sep="")),pos=3, cex=0.8)

mtext("N=", 1, 2, at=c(0.5))
mtext(gprefcounts, 1, 2, at=1:6)


###################################################
### code chunk number 42: bar10
###################################################
load("/home/pauljohn/ps/SVN-guides/stat/DataSets/GSS/gss-subset2.Rda")
library(memisc) 
t1 <- genTable(percent(factor(pres04))~sex, data=dat)

bp1 <- barplot(t1[1:2,], beside=T, names=c("Men","Women"), col=c("gray70","gray80"), density=c(15,20),angle=c(45,-45), ylim=c(0,60),ylab="Presidential Preference, 2004", xlab="Respondent Gender")

text(as.vector(bp1),as.vector(t1[1:2,]), label=as.vector(round(t1[1:2,],1)),pos=1) 
par(xpd=T) 
text(bp1,-1.5,c("Kerry","Bush"))


###################################################
### code chunk number 43: bar20
###################################################
par(xpd=TRUE)
ptvote <- 100*prop.table(table(dat$vote04, dat$vote00),2) 	
mycolors <- c("gray76", "gray80", "gray90")
bpbeside <- barplot(ptvote, ylim=c(0,100), beside = TRUE, col = mycolors, density = c(30,20,40), angle = c(45,-45,0), xlab = "Participation in 2000", ylab = "Participation in 2004")
legend("topright", legend = levels(factor(dat$vote04)), col = mycolors, density = c(30,20,40), angle = c(45,-45,0))
text(as.vector(bpbeside), as.vector(ptvote), labels=round(as.vector(ptvote),1),pos=3)


###################################################
### code chunk number 44: bar30
###################################################
opar <- par(no.readonly = TRUE)
newmar <- par("mar") + c(3, 0,0,0)
par(mar = newmar)
##From the 2010 midterm notes
dat$partyid[dat$partyid %in% levels(dat$partyid)[8]] <- NA 
dat$partyid <- factor(dat$partyid)
levels(dat$partyid) <- c("Strong Dem.", "Dem.", "Ind Near Dem", "Independent", "Ind. Near Repub.", "Repub.", "Strong Repub.")
dat$pres04[dat$pres04 %in% levels(dat$pres04)[3:10]]<-NA 
dat$pres04 <- factor(dat$pres04) 
t1 <- with(dat, prop.table(table(pres04, partyid), 2)) 
barplot(t1, beside = TRUE, las = 2, ylim = c(0,1)) 
abline(h=seq(0.05,1,by=0.05), lty=4, lwd=0.2) 
legend("top", legend=c("J.Kerry","G.W.Bush"), fill=gray.colors(2), bg="white")
par <- opar


###################################################
### code chunk number 45: ttest10
###################################################
t.test(sei ~ sex, data = dat)


###################################################
### code chunk number 46: ttest20
###################################################
t.test(sei ~ sex, data = dat, var.equal = TRUE)


###################################################
### code chunk number 47: ttest30
###################################################
t.test(dat$age, mu = 46, alternative = "less")


###################################################
### code chunk number 48: phony10
###################################################
set.seed(234234)
N <- 500
dat2 <- data.frame(x1 = rnorm(N, m = 4, sd = 5),
                   x2 = rpois(N, lambda = 4),
                   x3 = rgamma(N, shape = 0.4, scale = 10), 
                   x4 = rbinom(N, size = 8, prob = 0.5))
rockchalk::summarize(dat2)


###################################################
### code chunk number 49: phony20
###################################################
pairs(dat2, lwd = 0.8)


###################################################
### code chunk number 50: phony30
###################################################
par(mfcol=c(2,2))
hist(dat2$x1, main = "Normal", prob = TRUE, breaks = 20,  xlab = paste("E[x] = 4"), xlim = c(-16,24))
hist(dat2$x2, main = "Poisson", prob = TRUE, breaks = 20, xlab = paste("E[x] = 4"), xlim = c(-16,24))
hist(dat2$x3, main = "Gamma", prob = TRUE, breaks = 20, xlab = paste("E[x] = 4"), xlim = c(-16,24))
hist(dat2$x4, main = "Binomial", prob = TRUE, breaks = 20, xlab = paste("E[x] = 4"), xlim = c(-16,24))


###################################################
### code chunk number 51: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 52: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


