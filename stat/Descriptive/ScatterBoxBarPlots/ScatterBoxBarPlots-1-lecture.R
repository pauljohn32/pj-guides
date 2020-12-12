### R code from vignette source 'ScatterBoxBarPlots-1-lecture-uniquebackupstring202009100916.Rnw'

###################################################
### code chunk number 1: ScatterBoxBarPlots-1-lecture-uniquebackupstring202009100916.Rnw:29-30
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: ignoremeRoptions
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)
library(stationery)
opts.orig <- options()
options(width=70, prompt="> ")
options(useFancyQuotes = FALSE)
set.seed(12345)
par.orig <- par(no.readonly = TRUE) 
pjmar <- c(4.1, 4.1, 1.5, 2.1)
par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 3: texcopy
###################################################
logos <- c("logo.pdf", "logomini.pdf")
## This will retrieve logo files from a designated package:
try(getFiles(logos, pkg = "stationery", overwrite = FALSE))
## If you do not have a file after that, 
## the following will manufacture a blank images for placeholders
if(!file.exists("theme/logo.pdf")){
  blankPDF(file = "theme/logo.pdf", height=1, width=2, messg = "")
}
if(!file.exists("theme/logomini.pdf")){
  blankPDF(file = "theme/logomini.pdf", height=1, width=11, messg = "")
}


###################################################
### code chunk number 4: scat05
###################################################
dat <- data.frame(x = c(1, 2, 3, 4.5, 5, 7, 9), y = c(3, 2, 3, 6, 5, 8, 4))
plot(y~x, data=dat, cex=1.5, main="", xlab="x", ylab="y", ylim=c(0,10))


###################################################
### code chunk number 5: scat06
###################################################
dat <- data.frame(x = c(1, 2, 3, 4.5, 5, 7, 9), y = c(3, 2, 3, 6, 5, 8, 4))
plot(y~x, data=dat, cex=1.5, main="", xlab="x", ylab="y", ylim=c(0,10))
text(dat$x, dat$y, labels=1:7, pos=3)


###################################################
### code chunk number 6: scat07
###################################################
plot(y~x, data=dat, cex=1.5, main="", xlab="x", ylab="y", type = "l", ylim=c(0,10))
points(y ~ x, data=dat)


###################################################
### code chunk number 7: scat08
###################################################
dat <- data.frame(x = runif(20, min=0, max=10), y = runif(20, min=0, max=10))
plot(y~x, data=dat, cex=1.5, main="", xlab="x", ylab="y", ylim=c(0,10))


###################################################
### code chunk number 8: scat09
###################################################
dat <- data.frame(x = runif(20, min=0, max=10))
dat$y <- 8 - dat$x + rnorm(20, 2)
plot(y~x, data=dat, cex=1.5, main="", xlab="x", ylab="y", ylim=c(0,10))


###################################################
### code chunk number 9: scat10
###################################################
load("../../DataSets/GSS/gss-subset2.Rda")
plot(sei~educ, data=dat, cex=0.5,main="", xlab="Education (years)", ylab="Socio-economic Status",ylim=c(0,100))


###################################################
### code chunk number 10: scat20
###################################################
plot(sei~educ, data=dat, cex=0.5,main="", xlab="Education (years)", ylab="Socio-economic Status",ylim=c(0,120), type="n")
points(dat$educ, dat$sei, col=c("black", "gray60"), pch=c(1, 4))
legend("topleft", legend=c("Male","Female"), col=c("black","gray80"), pch=c(1,4))


###################################################
### code chunk number 11: scat30
###################################################
plot(sei~educ, data=dat, cex=0.5,main="", xlab="Education (years)", ylab="Socio-economic Status",ylim=c(0,100))
mod1 <- lm(sei~educ, data=dat) 
abline(mod1) 
abline(2,3.3,lty=2)
abline(v=0,lty=2, lwd=0.3) 
abline(h=0,lty=2, lwd=0.3) 
legend("topleft",legend=c("OLS","PJ's Guess"),lty=c(1,2),bg="white",lwd=c(1,1))


###################################################
### code chunk number 12: scat100
###################################################
plot(as.numeric(dat$owngun) ~ realinc,data=dat, type="n", xlab="Income (Inflation Adjusted)", ylab="Gun Ownership")
points(dat$owngun ~ realinc, data=dat)


###################################################
### code chunk number 13: scat110
###################################################
plot(jitter(as.numeric(dat$owngun)) ~ jitter(realinc),data=dat, type="n", xlab="Income (Inflation Adjusted)", ylab="Gun Ownership")
points(jitter(as.numeric(dat$owngun)) ~ jitter(realinc), data=dat)


###################################################
### code chunk number 14: scat130
###################################################
plot(dat[, 1:6])


###################################################
### code chunk number 15: box10
###################################################
x <- rnorm(1000, m=50, sd=10)
boxplot(x, xlim=c(0,2))
text(0.8, median(x), paste("median is", round(median(x), 2)), pos=2)
text(1.2, 37, paste("box=interquartile \n range"))


###################################################
### code chunk number 16: box11
###################################################
x <- 40 + 8*rgamma(1000, 1, 2)
boxplot(x, xlim=c(0,2))
text(0.8, median(x), paste("median is", round(median(x), 2)), pos=2)
text(1.2, mean(x), paste("mean is", round(mean(x),1)), pos=4)
points(1.0, mean(x), pch=13, col="red", cex=2)


###################################################
### code chunk number 17: box12
###################################################
hist(x, main="")


###################################################
### code chunk number 18: box20
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
### code chunk number 19: box40
###################################################
# One approach
boxplot(totnum~ sex , data=dat, ylab="Sex Partners since age 18 (excl. cases > 99)",xlab="Respondent Gender", names=c("Male","Female"))


###################################################
### code chunk number 20: box50
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
### code chunk number 21: ScatterBoxBarPlots-1-lecture-uniquebackupstring202009100916.Rnw:991-993
###################################################
library(rockchalk)
p1 <- pctable(gunlaw ~ owngun, data=dat)


###################################################
### code chunk number 22: ScatterBoxBarPlots-1-lecture-uniquebackupstring202009100916.Rnw:997-998
###################################################
p1sum <- summary(p1)


###################################################
### code chunk number 23: ScatterBoxBarPlots-1-lecture-uniquebackupstring202009100916.Rnw:1002-1006
###################################################
library(xtable)
p1xt <- xtable(p1sum)
outfn <- file.path(tdir, "pctable1.tex")
print(p1xt, type="latex", file = outfn)


###################################################
### code chunk number 24: ScatterBoxBarPlots-1-lecture-uniquebackupstring202009100916.Rnw:1013-1015
###################################################
outfn2 <- file.path(tdir, "pctable1.csv")
write.csv(p1xt, file=outfn2, row.names=FALSE)


###################################################
### code chunk number 25: ScatterBoxBarPlots-1-lecture-uniquebackupstring202009100916.Rnw:1028-1030
###################################################
load("../../DataSets/GSS/gss-subset2.Rda")
with(dat, table(gunlaw, owngun) )


###################################################
### code chunk number 26: options20
###################################################
options(scipen=5)


###################################################
### code chunk number 27: ScatterBoxBarPlots-1-lecture-uniquebackupstring202009100916.Rnw:1048-1052
###################################################
t1 <- with(dat, table(gunlaw, owngun, exclude=NULL) )
t1.prop <- 100 * prop.table(t1, margin=2)
t1.prop <- round(t1.prop, 1)
t1.prop


###################################################
### code chunk number 28: ScatterBoxBarPlots-1-lecture-uniquebackupstring202009100916.Rnw:1063-1066
###################################################
t1.marg <- margin.table(t1, margin=2)
t1.result <- rbind(t1.prop, t1.marg)
t1.result


###################################################
### code chunk number 29: ScatterBoxBarPlots-1-lecture-uniquebackupstring202009100916.Rnw:1089-1091
###################################################
library(gmodels)
with(dat, CrossTable(gunlaw, owngun))


###################################################
### code chunk number 30: descr10
###################################################
library(descr);
descrCT <- with(dat , descr::CrossTable(gunlaw, owngun))
descrCT


###################################################
### code chunk number 31: bar10
###################################################
load("../../DataSets/GSS/gss-subset2.Rda")
library(memisc) 
t1 <- genTable(percent(factor(pres04))~sex, data=dat)

bp1 <- barplot(t1[1:2,], beside=T, names=c("Men","Women"), col=c("gray70","gray80"), density=c(15,20),angle=c(45,-45), ylim=c(0,60),ylab="Presidential Preference, 2004", xlab="Respondent Gender")

text(as.vector(bp1),as.vector(t1[1:2,]), label=as.vector(round(t1[1:2,],1)),pos=1) 
par(xpd=T) 
text(bp1,-1.5,c("Kerry","Bush"))


###################################################
### code chunk number 32: bar20
###################################################
###tough to get width correct to match stacked plot, so I cut that option 
### after fighting it a while 
par(xpd=TRUE)
ptvote <- 100*prop.table(table(factor(dat$vote04), factor(dat$vote00)),2) 	
mycolors <- c("gray76","gray80","gray90")
bpbeside <- barplot(ptvote, ylim=c(0,100), beside=T, col=mycolors, density=c(30,20,40), angle=c(45,-45,0), xlab="Participation in 2000", ylab="Participation in 2004")

legend("topright", legend = levels(factor(dat$vote04)), col = mycolors, density = c(30,20,40), angle = c(45,-45,0))
text(as.vector(bpbeside), as.vector(ptvote), labels=round(as.vector(ptvote),1),pos=3)


###################################################
### code chunk number 33: bar30
###################################################
opar <- par(no.readonly = TRUE)
newmar <- par("mar") + c(3, 0,0,0)
par(mar = newmar)
##From the 2010 midterm notes
dat$partyid[dat$partyid %in% levels(dat$partyid)[8]] <- NA 
dat$partyid <- factor(dat$partyid)
levels(dat$partyid) <- c("Strong Dem.","Dem.","Ind Near Dem", "Independent","Ind. Near Repub.", "Repub.","Strong Repub.")
dat$pres04[dat$pres04 %in% levels(dat$pres04)[3:10]]<-NA 
dat$pres04 <- factor(dat$pres04) 
t1 <- with(dat, prop.table(table(pres04, partyid),2)) 
barplot(t1,beside=T, las=2, ylim=c(0,1)) 
abline(h=seq(0.05,1,by=0.05), lty=4, lwd=0.2) 
legend("top", legend=c("J.Kerry","G.W.Bush"), fill=gray.colors(2), bg="white")
par <- opar


###################################################
### code chunk number 34: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 35: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


