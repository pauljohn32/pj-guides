### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM5386/lyx_tmpbuf2/rockchalk-slides.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: rockchalk-slides.Rnw:39-40
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: rockchalk-slides.Rnw:109-110
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
#set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=10)
pdf.options(useDingbats = FALSE) ##suggestion to avoid bad symbols


###################################################
### code chunk number 4: rockchalk-slides.Rnw:264-273
###################################################
library(rockchalk)
dat <- data.frame(income = rnorm(1000, m=10000, sd=20000), 
educ = rpois(1000, lambda = 10),
age = rpois(1000, lambda = 22),
religion = factor(sample(c("cath","roman","prot","jewish","muslem","other"), 1000, replace = TRUE, prob = c(.20, .10, .20, .10, .10, .30))),
gender = factor(sample(c("male","female"), 1000, replace = TRUE)))
dat$educ[sample(1:1000, 42, replace = TRUE)] <- NA
dat$income[sample(1:1000, 82, replace = TRUE)] <- NA
dat$religion[sample(1:1000, 77, replace = TRUE)] <- NA


###################################################
### code chunk number 5: desc10
###################################################
(datsum <- summary(dat))


###################################################
### code chunk number 6: desc11
###################################################
datsum[ ,1]


###################################################
### code chunk number 7: desc20
###################################################
datsum2 <- summarize(dat)


###################################################
### code chunk number 8: rockchalk-slides.Rnw:312-313
###################################################
datsum2$numerics


###################################################
### code chunk number 9: rockchalk-slides.Rnw:320-321
###################################################
datsum2$factors


###################################################
### code chunk number 10: rockchalk-slides.Rnw:340-341
###################################################
dat$religion2 <- combineLevels(dat$religion, c("cath", "roman"), "cath")


###################################################
### code chunk number 11: rockchalk-slides.Rnw:346-347
###################################################
table(dat$religion2, dat$religion, dnn = c("religion2", "religion"))


###################################################
### code chunk number 12: rockchalk-slides.Rnw:385-386
###################################################
mydta1 <- readRDS("/home/pauljohn/SVN/SVN-guides/Rcourse/rockchalk-2013/04245.rds")


###################################################
### code chunk number 13: anes40 (eval = FALSE)
###################################################
## mod1age <- lm(th.bush.kerry ~ V043250, data = mydta1)
## outreg(mod1age, tight = FALSE, modelLabels = c("Age as Predictor"))


###################################################
### code chunk number 14: anes41
###################################################
mod1age <- lm(th.bush.kerry ~ V043250, data = mydta1)
outreg(mod1age, tight = FALSE, modelLabels = c("Age as Predictor"))


###################################################
### code chunk number 15: anes45
###################################################
mod1age <- lm(th.bush.kerry ~ V043250, data = mydta1)
outreg(mod1age, tight = FALSE, modelLabels = c("Age as Predictor"))


###################################################
### code chunk number 16: anes50 (eval = FALSE)
###################################################
## ## Run a new regression
## mod2age <- lm(th.bush.kerry ~ V043250 + V041109A, data = mydta1)
## ## Put 2 regressions in same table
## outreg(list(mod1age, mod2age), tight = TRUE, modelLabels = c("Age Only","Age With Gender"))


###################################################
### code chunk number 17: anes51
###################################################
## Run a new regression
mod2age <- lm(th.bush.kerry ~ V043250 + V041109A, data = mydta1)
## Put 2 regressions in same table
outreg(list(mod1age, mod2age), tight = TRUE, modelLabels = c("Age Only","Age With Gender"))


###################################################
### code chunk number 18: anes60 (eval = FALSE)
###################################################
## outreg(list("Age Only" = mod1age, "Age With Gender" = mod2age), tight = FALSE)


###################################################
### code chunk number 19: anes61
###################################################
outreg(list("Age Only" = mod1age, "Age With Gender" = mod2age), tight = FALSE)


###################################################
### code chunk number 20: anes70 (eval = FALSE)
###################################################
##  outreg(list("Age Only" = mod1age, "Age With Gender" = mod2age), tight = TRUE, varLabels = list("V043250" = "Age", "V041109A" = "Gender")) 


###################################################
### code chunk number 21: anes71 (eval = FALSE)
###################################################
##  outreg(list("Age Only" = mod1age, "Age With Gender" = mod2age), tight = FALSE, varLabels = list(V043250 = "Age", V041109A = "Gender")) 


###################################################
### code chunk number 22: anes72
###################################################
 outreg(list("Age Only" = mod1age, "Age With Gender" = mod2age), tight = FALSE, varLabels = list(V043250 = "Age", V041109A = "Gender")) 


###################################################
### code chunk number 23: rockchalk-slides.Rnw:574-576 (eval = FALSE)
###################################################
## or1 <- outreg(list(mod1age, mod2age), tight = TRUE, modelLabels = c("Age Only", "Age With Gender"))
## outreg2HTML(or1, file = "or1-test.html")


###################################################
### code chunk number 24: mod05
###################################################
set.seed(234234)
x1 <- 0.5 * rpois(100, lambda = 7)
x2 <- rnorm(100, m = 50, sd = 2)
x3 <- sample(c(0,1), 100, replace = TRUE)
y <- 2*x1 + 11.45*x2 + 2.8*x1*(x2-45) + 0.3*x1*x3 + rnorm(100, sd = 10)
y2 <- 2*x1 + 0.15*x2 + 1*x1*x3 + rnorm(100, sd = 10)
x3 <- factor(x3, labels=c("left", "right"))
dat <- data.frame(x1, x2, x3, y, y2)


###################################################
### code chunk number 25: mod10
###################################################
mod1 <- lm(y ~ x1, data = dat)
plot(y ~ x1, data = dat)
abline(mod1)


###################################################
### code chunk number 26: rockchalk-slides.Rnw:628-629 (eval = FALSE)
###################################################
## mod1 <- lm(y ~ x1, data = dat)
## plot(y ~ x1, data = dat)
## abline(mod1)


###################################################
### code chunk number 27: ps1
###################################################
ps1 <- plotSlopes(mod1, plotx = "x1", interval = "confidence")


###################################################
### code chunk number 28: rockchalk-slides.Rnw:649-650 (eval = FALSE)
###################################################
## ps1 <- plotSlopes(mod1, plotx = "x1", interval = "confidence")


###################################################
### code chunk number 29: ps10
###################################################
mod1 <- lm(y2 ~ x1*x3, data = dat)
ps1 <- plotSlopes(mod1, plotx = "x1", modx = "x3")


###################################################
### code chunk number 30: rockchalk-slides.Rnw:791-792 (eval = FALSE)
###################################################
## mod1 <- lm(y2 ~ x1*x3, data = dat)
## ps1 <- plotSlopes(mod1, plotx = "x1", modx = "x3")


###################################################
### code chunk number 31: ps10b
###################################################
outreg(list("Example Interaction" = mod1), tight = FALSE)


###################################################
### code chunk number 32: ps20
###################################################
ps2 <- plotSlopes(mod1, plotx = "x1", modx = "x3", interval = "confidence") 


###################################################
### code chunk number 33: rockchalk-slides.Rnw:820-821
###################################################
ps2 <- plotSlopes(mod1, plotx = "x1", modx = "x3", interval = "confidence") 


###################################################
### code chunk number 34: ps30a
###################################################
ps3a <- plotSlopes(mod1, plotx = "x1", modx = "x3", modxVals = c("left"), interval = "confidence")


###################################################
### code chunk number 35: rockchalk-slides.Rnw:840-841 (eval = FALSE)
###################################################
## ps3a <- plotSlopes(mod1, plotx = "x1", modx = "x3", modxVals = c("left"), interval = "confidence")


###################################################
### code chunk number 36: ps30b
###################################################
ps3b <- plotSlopes(mod1, plotx = "x1", modx = "x3", modxVals = c("right"), interval = "confidence")


###################################################
### code chunk number 37: rockchalk-slides.Rnw:860-861 (eval = FALSE)
###################################################
## ps3b <- plotSlopes(mod1, plotx = "x1", modx = "x3", modxVals = c("right"), interval = "confidence")


###################################################
### code chunk number 38: ps50
###################################################
mod2 <- lm(y ~ x1*x2, data = dat) 
ps5 <- plotSlopes(mod2, plotx = "x1", modx = "x2")


###################################################
### code chunk number 39: rockchalk-slides.Rnw:906-907 (eval = FALSE)
###################################################
## mod2 <- lm(y ~ x1*x2, data = dat) 
## ps5 <- plotSlopes(mod2, plotx = "x1", modx = "x2")


###################################################
### code chunk number 40: ps60
###################################################
ps5 <- plotSlopes(mod2, plotx = "x1", modx = "x2", interval = "confidence")


###################################################
### code chunk number 41: rockchalk-slides.Rnw:928-929 (eval = FALSE)
###################################################
## ps5 <- plotSlopes(mod2, plotx = "x1", modx = "x2", interval = "confidence")


###################################################
### code chunk number 42: ps70
###################################################
ps7 <- plotSlopes(mod2, plotx = "x1", modx = "x2", modxVals = "std.dev.", interval = "confidence")


###################################################
### code chunk number 43: rockchalk-slides.Rnw:948-949 (eval = FALSE)
###################################################
## ps7 <- plotSlopes(mod2, plotx = "x1", modx = "x2", modxVals = "std.dev.", interval = "confidence")


###################################################
### code chunk number 44: ps80
###################################################
ps8 <- plotSlopes(mod2, plotx = "x1", modx = "x2", modxVals = "std.dev.", n = 5, interval = "confidence")


###################################################
### code chunk number 45: rockchalk-slides.Rnw:968-969 (eval = FALSE)
###################################################
## ps8 <- plotSlopes(mod2, plotx = "x1", modx = "x2", modxVals = "std.dev.", n = 5, interval = "confidence")


###################################################
### code chunk number 46: ts10
###################################################
ps5ts <- testSlopes(ps5)


###################################################
### code chunk number 47: ts20
###################################################
plot(ps5ts)


###################################################
### code chunk number 48: rockchalk-slides.Rnw:1047-1048 (eval = FALSE)
###################################################
## plot(ps5ts)


###################################################
### code chunk number 49: mc10
###################################################
dat$y5 <- dat$y + rnorm(length(dat$y), sd = 30)
mod5 <- lm(y5 ~ x1, data = dat)
plotSlopes(mod5, plotx = "x1", interval = "confidence", plotLegend = F, xlim = c(0, 1.05 * max(dat$x1)), axes = F)
axis(1)
axis(2, pos = 0)
axis(2, pos = mean(dat$x1), labels = FALSE)
arrows(0.3, 1.15*mean(dat$y5), 0.80 * mean(dat$x1), 1.2*mean(dat$y5), col = "red")


