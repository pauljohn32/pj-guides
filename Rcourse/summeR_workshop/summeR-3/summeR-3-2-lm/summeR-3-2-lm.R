### R code from vignette source 'summeR-3-2-lm-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-3-2-lm-uniquebackupstring.Rnw:27-28
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
### code chunk number 4: summeR-3-2-lm-uniquebackupstring.Rnw:257-258
###################################################
sessionInfo()


###################################################
### code chunk number 5: summeR-3-2-lm-uniquebackupstring.Rnw:269-270 (eval = FALSE)
###################################################
## install.packages(c("car", "lmtest", "rockchalk"))


###################################################
### code chunk number 6: summeR-3-2-lm-uniquebackupstring.Rnw:279-281 (eval = FALSE)
###################################################
## library(rockchalk)
## help(package = rockchalk)


###################################################
### code chunk number 7: summeR-3-2-lm-uniquebackupstring.Rnw:285-286 (eval = FALSE)
###################################################
## ?plotSlopes


###################################################
### code chunk number 8: summeR-3-2-lm-uniquebackupstring.Rnw:304-311
###################################################
dat <- read.table("data/affect.dat", header = FALSE)
colnames(dat) <- c("Agency1", "Agency2", "Agency3", 
            "Intrin1", "Intrin2", "Intrin3", 
            "Extrin1", "Extrin2", "Extrin3", 
            "PosAFF1", "PosAFF2", "PosAFF3",
            "NegAFF1", "NegAFF2", "NegAFF3", 
            "Sex", "Ethnic2", "Ethnic3", "Ethnic4")


###################################################
### code chunk number 9: summeR-3-2-lm-uniquebackupstring.Rnw:316-319
###################################################
options("width" = 70)
head(dat)
options("width" = 80)


###################################################
### code chunk number 10: summeR-3-2-lm-uniquebackupstring.Rnw:332-334
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 11: summeR-3-2-lm-uniquebackupstring.Rnw:339-344
###################################################
dat$agency <- rowMeans(dat[ , c("Agency1","Agency2","Agency3")], na.rm = TRUE)
dat$intMotiv <- rowMeans(dat[ , c("Intrin1","Intrin2","Intrin3")], na.rm = TRUE)
dat$extMotiv <- rowMeans(dat[ , c("Extrin1","Extrin2","Extrin3")], na.rm = TRUE)
dat$posAffect <- rowMeans(dat[ , c("PosAFF1","PosAFF2","PosAFF3")], na.rm = TRUE)
dat$negAffect <- rowMeans(dat[ , c("NegAFF1","NegAFF2","NegAFF3")], na.rm = TRUE)


###################################################
### code chunk number 12: summeR-3-2-lm-uniquebackupstring.Rnw:347-348
###################################################
options(options.orig)


###################################################
### code chunk number 13: summeR-3-2-lm-uniquebackupstring.Rnw:353-362
###################################################
table(dat$Sex)
dat$gender <- factor(dat$Sex, levels = c(1,2), labels = c("male", "female"))
dat$ethnicity <- as.factor(ifelse(dat$Ethnic2, "Black",
                           ifelse(dat$Ethnic3, "Hispanic",
                           ifelse(dat$Ethnic4, "Asian", "White"))))
dat$race <- rockchalk::combineLevels(dat$ethnicity,  levs = c("Black", "Hispanic", "Asian"), newLabel = "Nonwhite")
options("width" = 60)
head(dat)
options("width" = 80)


###################################################
### code chunk number 14: summeR-3-2-lm-uniquebackupstring.Rnw:367-368
###################################################
saveRDS(dat, file = "workingdata/affect.rds")


###################################################
### code chunk number 15: summeR-3-2-lm-uniquebackupstring.Rnw:383-384 (eval = FALSE)
###################################################
## dependent_variable ~ predictor_variable


###################################################
### code chunk number 16: summeR-3-2-lm-uniquebackupstring.Rnw:391-392 (eval = FALSE)
###################################################
## dependent_variable ~ -1 + predictor_variable


###################################################
### code chunk number 17: summeR-3-2-lm-uniquebackupstring.Rnw:398-399 (eval = FALSE)
###################################################
## dependent_variable ~ 0 + predictor_variable


###################################################
### code chunk number 18: summeR-3-2-lm-uniquebackupstring.Rnw:411-412
###################################################
reg.mod.1 <- lm(posAffect ~ agency, data = dat)


###################################################
### code chunk number 19: summeR-3-2-lm-uniquebackupstring.Rnw:419-420
###################################################
reg.mod.1


###################################################
### code chunk number 20: summeR-3-2-lm-uniquebackupstring.Rnw:426-427
###################################################
attributes(reg.mod.1)


###################################################
### code chunk number 21: summeR-3-2-lm-uniquebackupstring.Rnw:439-440
###################################################
class(reg.mod.1)


###################################################
### code chunk number 22: summeR-3-2-lm-uniquebackupstring.Rnw:447-449
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 23: summeR-3-2-lm-uniquebackupstring.Rnw:453-454
###################################################
names(reg.mod.1)


###################################################
### code chunk number 24: summeR-3-2-lm-uniquebackupstring.Rnw:457-458
###################################################
options(options.orig)


###################################################
### code chunk number 25: summeR-3-2-lm-uniquebackupstring.Rnw:474-476
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 26: summeR-3-2-lm-uniquebackupstring.Rnw:480-481
###################################################
reg.mod.1$df.residual


###################################################
### code chunk number 27: summeR-3-2-lm-uniquebackupstring.Rnw:484-485
###################################################
options(options.orig)


###################################################
### code chunk number 28: summeR-3-2-lm-uniquebackupstring.Rnw:491-493
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 29: summeR-3-2-lm-uniquebackupstring.Rnw:497-498
###################################################
reg.mod.1[["df.residual"]]


###################################################
### code chunk number 30: summeR-3-2-lm-uniquebackupstring.Rnw:501-502
###################################################
options(options.orig)


###################################################
### code chunk number 31: summeR-3-2-lm-uniquebackupstring.Rnw:527-528
###################################################
coef(reg.mod.1)


###################################################
### code chunk number 32: summeR-3-2-lm-uniquebackupstring.Rnw:532-533
###################################################
reg.mod.1$coefficients


###################################################
### code chunk number 33: summeR-3-2-lm-uniquebackupstring.Rnw:541-542
###################################################
head(fitted(reg.mod.1))


###################################################
### code chunk number 34: summeR-3-2-lm-uniquebackupstring.Rnw:547-548
###################################################
head(reg.mod.1$fitted.values)


###################################################
### code chunk number 35: summeR-3-2-lm-uniquebackupstring.Rnw:559-561
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 36: summeR-3-2-lm-uniquebackupstring.Rnw:565-566
###################################################
head(resid(reg.mod.1), 4)


###################################################
### code chunk number 37: summeR-3-2-lm-uniquebackupstring.Rnw:569-570
###################################################
options(options.orig)


###################################################
### code chunk number 38: summeR-3-2-lm-uniquebackupstring.Rnw:576-578
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 39: summeR-3-2-lm-uniquebackupstring.Rnw:582-583
###################################################
head(reg.mod.1$residuals, 4)


###################################################
### code chunk number 40: summeR-3-2-lm-uniquebackupstring.Rnw:586-587
###################################################
options(options.orig)


###################################################
### code chunk number 41: summeR-3-2-lm-uniquebackupstring.Rnw:599-601
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 42: summeR-3-2-lm-uniquebackupstring.Rnw:605-606
###################################################
summary(reg.mod.1)


###################################################
### code chunk number 43: summeR-3-2-lm-uniquebackupstring.Rnw:609-610
###################################################
options(options.orig)


###################################################
### code chunk number 44: summeR-3-2-lm-uniquebackupstring.Rnw:615-616
###################################################
confint(reg.mod.1, level = .99)


###################################################
### code chunk number 45: summeR-3-2-lm-uniquebackupstring.Rnw:632-633 (eval = FALSE)
###################################################
## dependent_variable ~ log(predictor)


###################################################
### code chunk number 46: summeR-3-2-lm-uniquebackupstring.Rnw:639-640 (eval = FALSE)
###################################################
## dependent_variable ~ sqrt(predictor)


###################################################
### code chunk number 47: summeR-3-2-lm-uniquebackupstring.Rnw:653-654 (eval = FALSE)
###################################################
## dependent_variable ~ predictor1 + predictor2


###################################################
### code chunk number 48: summeR-3-2-lm-uniquebackupstring.Rnw:658-659 (eval = FALSE)
###################################################
## dependent_variable ~ predictor1 * predictor2


###################################################
### code chunk number 49: summeR-3-2-lm-uniquebackupstring.Rnw:671-672 (eval = FALSE)
###################################################
## dependent_variable ~ predictor + predictor^2


###################################################
### code chunk number 50: summeR-3-2-lm-uniquebackupstring.Rnw:686-688 (eval = FALSE)
###################################################
## dependent_variable ~ predictor 
##           + I(predictor^2)


###################################################
### code chunk number 51: summeR-3-2-lm-uniquebackupstring.Rnw:702-703 (eval = FALSE)
###################################################
## plot(reg.mod.1)


###################################################
### code chunk number 52: plotlm10
###################################################
par(mfrow = c(2,2))
plot(reg.mod.1)


###################################################
### code chunk number 53: summeR-3-2-lm-uniquebackupstring.Rnw:734-735
###################################################
inf1 <- influence.measures(reg.mod.1)


###################################################
### code chunk number 54: summeR-3-2-lm-uniquebackupstring.Rnw:740-741 (eval = FALSE)
###################################################
## inf1


###################################################
### code chunk number 55: sumry10 (eval = FALSE)
###################################################
## summary(inf1)


###################################################
### code chunk number 56: sumry20
###################################################
summary(inf1)


###################################################
### code chunk number 57: summeR-3-2-lm-uniquebackupstring.Rnw:764-765
###################################################
inf1sum <- summary(inf1)


###################################################
### code chunk number 58: summeR-3-2-lm-uniquebackupstring.Rnw:769-770
###################################################
round(inf1sum[1, ], 3)


###################################################
### code chunk number 59: summeR-3-2-lm-uniquebackupstring.Rnw:800-801 (eval = FALSE)
###################################################
## predict(reg.mod.1, newdata = some_data_frame_we_make_up)


###################################################
### code chunk number 60: summeR-3-2-lm-uniquebackupstring.Rnw:806-807 (eval = FALSE)
###################################################
## predict(reg.mod.1, newdata = some_data_frame_we_make_up, interval = "confidence")


###################################################
### code chunk number 61: summeR-3-2-lm-uniquebackupstring.Rnw:828-832
###################################################
library(rockchalk)
nd <- newdata(reg.mod.1, predVals = c("agency"), n = 5)
nd
## n = 5 is 5 evenly spaced quartile values


###################################################
### code chunk number 62: summeR-3-2-lm-uniquebackupstring.Rnw:836-838
###################################################
reg.mod.1.pred <- predict(reg.mod.1, newdata = nd)
reg.mod.1.pred


###################################################
### code chunk number 63: summeR-3-2-lm-uniquebackupstring.Rnw:848-849
###################################################
nd$reg.mod.1.pred <- predict(reg.mod.1, newdata = nd)


###################################################
### code chunk number 64: summeR-3-2-lm-uniquebackupstring.Rnw:855-857
###################################################
reg.mod.1.pm <- predictOMatic(reg.mod.1, predVals = c("agency"), n = 5)
reg.mod.1.pm


###################################################
### code chunk number 65: summeR-3-2-lm-uniquebackupstring.Rnw:873-875
###################################################
reg.mod.1.pred2 <- predict(reg.mod.1, newdata = nd, interval = "confidence")
reg.mod.1.pred2


###################################################
### code chunk number 66: ps60
###################################################
plot(posAffect ~ agency, data = dat, cex = 0.6, col = "gray60")
lines(reg.mod.1.pred2[ , "fit"] ~ nd$agency, lty = 1)
lines(reg.mod.1.pred2[ , "lwr"] ~ nd$agency, lty = 3, lwd = 2, col = "blue")
lines(reg.mod.1.pred2[ , "upr"] ~ nd$agency, lty = 3, lwd = 2, col = "blue")


###################################################
### code chunk number 67: ps70
###################################################
plotSlopes(reg.mod.1, plotx = "agency")


###################################################
### code chunk number 68: summeR-3-2-lm-uniquebackupstring.Rnw:921-923
###################################################
reg.mod.1.pm <- predictOMatic(reg.mod.1, predVals = c("agency"), n = 5, interval = "confidence")
reg.mod.1.pm


###################################################
### code chunk number 69: ps50
###################################################
plotSlopes(reg.mod.1, plotx = "agency", n = 5, interval = "confidence")


###################################################
### code chunk number 70: ps55 (eval = FALSE)
###################################################
## reg.mod.ps <- plotSlopes(reg.mod.1, plotx = "agency", n = 5, interval = "confidence")


###################################################
### code chunk number 71: ps56
###################################################
reg.mod.ps <- plotSlopes(reg.mod.1, plotx = "agency", n = 5, interval = "confidence")


###################################################
### code chunk number 72: summeR-3-2-lm-uniquebackupstring.Rnw:948-949
###################################################
reg.mod.ps$newdata


###################################################
### code chunk number 73: gend10
###################################################
levels(dat$gender)


###################################################
### code chunk number 74: summeR-3-2-lm-uniquebackupstring.Rnw:970-972
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 75: gend20
###################################################
reg.mod.2 <- lm(posAffect ~ gender, data = dat)
summary(reg.mod.2)


###################################################
### code chunk number 76: summeR-3-2-lm-uniquebackupstring.Rnw:981-982
###################################################
options(options.orig)


###################################################
### code chunk number 77: gend21
###################################################
reg.mod.2b <- lm(posAffect ~ 0 + gender, data = dat)
summary(reg.mod.2b)


###################################################
### code chunk number 78: summeR-3-2-lm-uniquebackupstring.Rnw:1014-1016
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 79: gend22
###################################################
dat$gender2 <- factor(dat$gender, levels = c("female", "male"))
reg.mod.2c <- lm(posAffect ~ gender2, data = dat)
summary(reg.mod.2c)


###################################################
### code chunk number 80: summeR-3-2-lm-uniquebackupstring.Rnw:1026-1027
###################################################
options(options.orig)


###################################################
### code chunk number 81: gend23
###################################################
library(car)
leveneTest(reg.mod.2)


###################################################
### code chunk number 82: eth10
###################################################
levels(dat$ethnicity)


###################################################
### code chunk number 83: summeR-3-2-lm-uniquebackupstring.Rnw:1054-1056
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 84: eth20
###################################################
reg.mod.3 <- lm(posAffect ~ ethnicity, data = dat)
summary(reg.mod.3)


###################################################
### code chunk number 85: summeR-3-2-lm-uniquebackupstring.Rnw:1065-1066
###################################################
options(options.orig)


###################################################
### code chunk number 86: bug10
###################################################
rm1.mf <- model.frame(reg.mod.1)
head(rm1.mf)


###################################################
### code chunk number 87: bug20
###################################################
rm1.mf <- model.frame(posAffect ~ log(agency), data = dat)
head(rm1.mf)


###################################################
### code chunk number 88: bug30
###################################################
rm1.dm <- model.matrix(reg.mod.1)
head(rm1.dm)


###################################################
### code chunk number 89: summeR-3-2-lm-uniquebackupstring.Rnw:1105-1107
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 90: bug40
###################################################
rm2.dm <- model.matrix(posAffect ~ ethnicity, data = dat)
head(rm2.dm)


###################################################
### code chunk number 91: summeR-3-2-lm-uniquebackupstring.Rnw:1116-1117
###################################################
options(options.orig)


###################################################
### code chunk number 92: summeR-3-2-lm-uniquebackupstring.Rnw:1131-1132 (eval = FALSE)
###################################################
## dep_var ~ log(predictor1) + sqrt(predictor2) + predictor3 + predictor4


###################################################
### code chunk number 93: summeR-3-2-lm-uniquebackupstring.Rnw:1148-1149 (eval = FALSE)
###################################################
## dep_var ~ predictor1 * predictor2 + predictor3


###################################################
### code chunk number 94: summeR-3-2-lm-uniquebackupstring.Rnw:1154-1155 (eval = FALSE)
###################################################
## dep_var ~ predictor1 + predictor2 + predictor1:predicor2 + predictor3


###################################################
### code chunk number 95: summeR-3-2-lm-uniquebackupstring.Rnw:1168-1169 (eval = FALSE)
###################################################
## posAffect ~ gender * agency 


###################################################
### code chunk number 96: opts10
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 97: mod10
###################################################
reg.mod.5 <- lm(posAffect ~ agency + gender, data = dat)
summary(reg.mod.5)


###################################################
### code chunk number 98: opts.mod10
###################################################
options(options.orig)


###################################################
### code chunk number 99: mod11
###################################################
plotSlopes(reg.mod.5, plotx = "agency", modx = "gender", col = c("gray60", "black"))


###################################################
### code chunk number 100: opts10
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 101: mod20
###################################################
reg.mod.6 <- lm(posAffect ~ agency*gender, data = dat)


###################################################
### code chunk number 102: opts.mod20
###################################################
options(options.orig)


###################################################
### code chunk number 103: opts10
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 104: mod21
###################################################
summary(reg.mod.6)


###################################################
### code chunk number 105: opt.mod21
###################################################
options(options.orig)


###################################################
### code chunk number 106: mod30
###################################################
ps30 <- plotSlopes(reg.mod.6, plotx = "agency", modx = "gender", col = c("gray40", "black"))


###################################################
### code chunk number 107: mod31
###################################################
ps31 <- plotSlopes(reg.mod.6, plotx = "agency", modx = "gender", col = c("blue", "black"), interval = "confidence")


###################################################
### code chunk number 108: gg10
###################################################
library(ggplot2)
p1 <- ggplot(dat, aes(x = agency, y = posAffect))
p1


###################################################
### code chunk number 109: gg20
###################################################
p1 <- p1 + geom_point(shape = 1, alpha = 0.5)
p1


###################################################
### code chunk number 110: gg30
###################################################
p1 <- p1 + geom_point(shape = 1, alpha = 0.5)
p1 <- p1 + facet_grid(. ~ gender)
p1


###################################################
### code chunk number 111: gg40
###################################################
ps31$newdata$posAffect <- ps31$newdata$fit
p1 <- p1 + geom_line(data = ps31$newdata, color = "blue")
p1


###################################################
### code chunk number 112: gg70
###################################################

p1 <- p1 + geom_ribbon(data = ps31$newdata, 
            aes(ymin = lwr, ymax = upr), 
			fill = "pink", alpha = 0.5)
p1


###################################################
### code chunk number 113: gg50
###################################################
p1 <- p1 + theme_bw()
p1


###################################################
### code chunk number 114: gg60
###################################################
p1 <- p1 + theme(strip.background = element_rect(color="darkgoldenrod4", fill="lightgoldenrod"))
p1


###################################################
### code chunk number 115: summeR-3-2-lm-uniquebackupstring.Rnw:1453-1455
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 116: mod70
###################################################
reg.mod.7 <- lm(posAffect ~ agency*ethnicity + gender, data = dat)
summary(reg.mod.7)


###################################################
### code chunk number 117: summeR-3-2-lm-uniquebackupstring.Rnw:1464-1465
###################################################
options(options.orig)


###################################################
### code chunk number 118: mod71
###################################################
plotSlopes(reg.mod.7, plotx = "agency", modx = "ethnicity", ylim = c(0.9,5.5))


###################################################
### code chunk number 119: gg110
###################################################
## Data must be subdivided by groups
ps71 <- plotSlopes(reg.mod.7, plotx = "agency", modx = "ethnicity", interval = "confidence")
ps71$newdata$posAffect <- ps71$newdata$fit
p1 <- ggplot(dat, aes(x = agency, y = posAffect)) + geom_point(shape = 1, alpha = 0.5) + 
facet_wrap( ~ ethnicity, ncol = 2) + geom_line(data = ps71$newdata, color = "blue") +
geom_ribbon(data = ps71$newdata, aes(ymin = lwr, ymax = upr), fill = "pink", alpha = 0.5) +
theme_bw() + 
theme(strip.background = element_rect(color="darkgoldenrod4", fill="lightgoldenrod"))
p1


###################################################
### code chunk number 120: summeR-3-2-lm-uniquebackupstring.Rnw:1504-1506
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 121: summeR-3-2-lm-uniquebackupstring.Rnw:1510-1512
###################################################
reg.mod.10 <- lm(posAffect ~ agency + intMotiv + extMotiv, data = dat)
summary(reg.mod.10)


###################################################
### code chunk number 122: summeR-3-2-lm-uniquebackupstring.Rnw:1515-1516
###################################################
options(options.orig)


###################################################
### code chunk number 123: summeR-3-2-lm-uniquebackupstring.Rnw:1527-1529
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 124: summeR-3-2-lm-uniquebackupstring.Rnw:1533-1535
###################################################
reg.mod.11 <- lm(posAffect ~ intMotiv + agency*extMotiv, data = dat)
summary(reg.mod.11)


###################################################
### code chunk number 125: summeR-3-2-lm-uniquebackupstring.Rnw:1538-1539
###################################################
options(options.orig)


###################################################
### code chunk number 126: mod80
###################################################
ps80 <- plotSlopes(reg.mod.11, plotx = "agency", modx = "extMotiv", modxVals = c(1.14, 1.4, 1.75, 3.6))


###################################################
### code chunk number 127: mod81
###################################################
ps80ts <- testSlopes(ps80)


###################################################
### code chunk number 128: mod82
###################################################
plot(ps80ts)


###################################################
### code chunk number 129: summeR-3-2-lm-uniquebackupstring.Rnw:1598-1600
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 130: mod83
###################################################
reg.mod.12 <- lm(posAffect ~ agency * intMotiv * extMotiv, data = dat)
summary(reg.mod.12)


###################################################
### code chunk number 131: summeR-3-2-lm-uniquebackupstring.Rnw:1609-1610
###################################################
options(options.orig)


###################################################
### code chunk number 132: mod84
###################################################
anova(reg.mod.10, reg.mod.11, reg.mod.12,  test = "F")


###################################################
### code chunk number 133: summeR-3-2-lm-uniquebackupstring.Rnw:1642-1644
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 134: mod85
###################################################
## The mean-centered model sets the predictors at (x - xmean)
reg.mod.14 <- meanCenter(reg.mod.11)
summary(reg.mod.14)


###################################################
### code chunk number 135: summeR-3-2-lm-uniquebackupstring.Rnw:1654-1655
###################################################
options(options.orig)


###################################################
### code chunk number 136: summeR-3-2-lm-uniquebackupstring.Rnw:1660-1662
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 137: mod85b
###################################################
reg.mod.14b <- meanCenter(reg.mod.11, centerOnlyInteractors = FALSE)
summary(reg.mod.14b)


###################################################
### code chunk number 138: summeR-3-2-lm-uniquebackupstring.Rnw:1671-1672
###################################################
options(options.orig)


###################################################
### code chunk number 139: mod86
###################################################
plot(fitted(reg.mod.14), fitted(reg.mod.11), xlab = "Uncentered predictors", ylab = "Mean-Centered predictors", main = "Predicted Values")


###################################################
### code chunk number 140: summeR-3-2-lm-uniquebackupstring.Rnw:1685-1687
###################################################
options.orig <- options()
options(width=60)


###################################################
### code chunk number 141: summeR-3-2-lm-uniquebackupstring.Rnw:1693-1694
###################################################
options(options.orig)


###################################################
### code chunk number 142: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 143: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


