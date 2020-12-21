### R code from vignette source 'sem-2-1-R-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: sem-2-1-R-uniquebackupstring.Rnw:41-42
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: tmpout
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)


###################################################
### code chunk number 3: excludemeRoptions
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
### code chunk number 4: dat10
###################################################
ddir <- "data"
list.files(ddir)


###################################################
### code chunk number 5: dat20
###################################################
fn <- "affect.csv"
affect <- read.table(file.path(ddir, fn), header = TRUE, sep = ",", stringsAsFactors = FALSE)


###################################################
### code chunk number 6: dat30
###################################################
str(affect)


###################################################
### code chunk number 7: dat35 (eval = FALSE)
###################################################
## View(affect)


###################################################
### code chunk number 8: dat40
###################################################
affect$genderf <- factor(affect$gender, levels = c("male", "female"))


###################################################
### code chunk number 9: dat60
###################################################
table("genderf" = affect$genderf, "gender" = affect$gender)


###################################################
### code chunk number 10: dat70
###################################################
table(affect$genderf, affect$gender)


###################################################
### code chunk number 11: dat80
###################################################
table("gender as factor" = affect$genderf, "Sex as an integer" = affect$Sex)


###################################################
### code chunk number 12: dat90
###################################################
affect$ethnicityf <- factor(affect$ethnicity)


###################################################
### code chunk number 13: dat100
###################################################
table("ethnicity factor" = affect$ethnicityf, "ethnicity" = affect$ethnicity)


###################################################
### code chunk number 14: repos (eval = FALSE)
###################################################
## CRAN <- "http://rweb.crmda.ku.edu/cran"
## KRAN <- "http://rweb.crmda.ku.edu/kran"
## options(repos = c(KRAN, CRAN))
## install.packages(c("kutils", "rockchalk"), dep = c("Depends", "Imports", "LinkingTo"))


###################################################
### code chunk number 15: excludemeopts10a
###################################################
options.width <- unlist(options("width"))
options(width = 70)


###################################################
### code chunk number 16: summary10
###################################################
summary(affect)


###################################################
### code chunk number 17: excludemeopts10b
###################################################
options(width = options.width)


###################################################
### code chunk number 18: sem-2-1-R-uniquebackupstring.Rnw:547-549
###################################################
library(rockchalk)
summarize(affect)


###################################################
### code chunk number 19: reg10
###################################################
summary(lm(PosAFF1 ~ genderf, data = affect))


###################################################
### code chunk number 20: reg20
###################################################
m1 <- lm(PosAFF1 ~ genderf, data = affect)
summary(m1)


###################################################
### code chunk number 21: reg50
###################################################
m2 <- lm(PosAFF1 ~ genderf + Agency1, data = affect)


###################################################
### code chunk number 22: reg51
###################################################
summary(m2)


###################################################
### code chunk number 23: reg55a
###################################################
anova(m2)
anova(m1, m2)


###################################################
### code chunk number 24: reg55b
###################################################
anova(m1, m2)


###################################################
### code chunk number 25: reg60
###################################################
m2.inf <- influence.measures(m2)
summary(m2.inf)


###################################################
### code chunk number 26: plot60
###################################################
library(rockchalk)
plotSlopes(m2, plotx = "Agency1", modx = "genderf", interval = "confidence")


###################################################
### code chunk number 27: plot100
###################################################
library(lattice)
histogram( ~ PosAFF1 | genderf, data = affect, xlab = "Positive Affect")


###################################################
### code chunk number 28: norm10
###################################################
set.seed(234234)
N <- 1000
mu <- 44
sigma <- 10
x <- rnorm(N, m = mu, s = sigma)
hist(x, breaks = 30)


###################################################
### code chunk number 29: norm20
###################################################
x <- seq(mu + -3.5 * sigma, mu + 3.5 * sigma, by = 0.01)
xd <- dnorm(x, m = mu, s = sigma)
plot(xd ~ x, type = "l", xlab = "x", ylab = "Probability Density of Normal")


###################################################
### code chunk number 30: mvn10a
###################################################
library(rockchalk)
mu <- c(3, 1, 44, 19) # numbers from top of my head
mu


###################################################
### code chunk number 31: mvn10b
###################################################
rho <- lazyCor(c(0.5, 0.6, 0.7, -0.1, 0.1, 0.2))
sd <- c(1, 2, 7, 4) 
Sigma <- lazyCov(rho, sd)
Sigma


###################################################
### code chunk number 32: mvn15
###################################################
N <- 1
mvrnorm(N, m = mu, S = Sigma)


###################################################
### code chunk number 33: mvn20
###################################################
N <- 5
mvrnorm(N, m = mu, S = Sigma)


###################################################
### code chunk number 34: mvn50
###################################################
N <- 500
X <- mvrnorm(N, m = mu, S = Sigma)
pairs(X)


###################################################
### code chunk number 35: sem-2-1-R-uniquebackupstring.Rnw:880-881
###################################################
var(X)


###################################################
### code chunk number 36: sem-2-1-R-uniquebackupstring.Rnw:888-890
###################################################
X <- mvrnorm(N, m = mu, S = Sigma)
var(X)


###################################################
### code chunk number 37: wish50b
###################################################
X <- mvrnorm(N, m = mu, S = Sigma) 
var(X)


###################################################
### code chunk number 38: wish50c
###################################################
X <- mvrnorm(N, m = mu, S = Sigma) 
var(X)


###################################################
### code chunk number 39: wish10
###################################################
mu <- c(0, 0, 0, 0)
N <- 1000
X <- mvrnorm(N, m = mu, S = Sigma) 


###################################################
### code chunk number 40: wish50a
###################################################
var(X)


###################################################
### code chunk number 41: wish100a
###################################################
Sigma


###################################################
### code chunk number 42: wish100b
###################################################
(N-1) * Sigma


###################################################
### code chunk number 43: wish200a
###################################################
rWishart(1, df = N - 1, Sigma = Sigma)


###################################################
### code chunk number 44: wish200b
###################################################
rWishart(1, df = N - 1, Sigma = Sigma)


###################################################
### code chunk number 45: wish300a
###################################################
lotsofwishes <- rWishart(100, df = N - 1, Sigma = Sigma)


###################################################
### code chunk number 46: wish300b
###################################################
lotsofwishes[  , , 1]


###################################################
### code chunk number 47: wish300c
###################################################
lotsofwishes[  , , 53]


###################################################
### code chunk number 48: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 49: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


