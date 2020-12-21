### R code from vignette source 'sem-2-3-semexample-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: sem-2-3-semexample-uniquebackupstring.Rnw:27-28
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: excludemetmpout
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
dat <- read.csv("data/job_placement.csv", header = FALSE)
colnames(dat) <- c("id", "wjcalc", "wjspl", "wratspl", "wratcalc", "waiscalc", "waisspl", "edlevel", "newschl", "suspend", "expelled", "haveld", "female", "age")
dat[dat == 99999] <- NA
scalescores <- dat[,2:7]
scalescores <- na.omit(scalescores)


###################################################
### code chunk number 5: factanal10
###################################################
head(scalescores)
output1 <- factanal(scalescores, 1, rotation = "varimax") 
output1
output2 <- factanal(scalescores, 2, rotation = "varimax") 
output2


###################################################
### code chunk number 6: lav10
###################################################
library(lavaan)
CFAmodel <- "
  MATH =~ wratcalc + wjcalc + waiscalc
  SPELL =~ wratspl + wjspl + waisspl
"
testOutput <- cfa(model = CFAmodel, data = dat, std.lv = TRUE, missing = "fiml")
summary(testOutput, fit.measures = TRUE)


###################################################
### code chunk number 7: lav100
###################################################
configModel <- "
  MATH =~ wratcalc + wjcalc + waiscalc
  SPELL =~ wratspl + wjspl + waisspl
"
configOutput <- cfa(model = configModel, data = dat, group = "female", std.lv = TRUE, missing = "fiml")
summary(configOutput)


###################################################
### code chunk number 8: lav110
###################################################
metricModel <- "
  MATH =~ wratcalc + wjcalc + waiscalc
  SPELL =~ wratspl + wjspl + waisspl
  MATH ~~ c(1, NA)*MATH
  SPELL ~~ c(1, NA)*SPELL
"
metricOutput <- cfa(model = metricModel, data = dat, std.lv = TRUE,
                    group = "female", group.equal = "loadings",
                    missing = "fiml")
summary(metricOutput)
anova(configOutput, metricOutput)


###################################################
### code chunk number 9: lav120
###################################################
scalarModel <- "
  MATH =~ wratcalc + wjcalc + waiscalc
  SPELL =~ wratspl + wjspl + waisspl
  MATH ~~ c(1, NA)*MATH
  SPELL ~~ c(1, NA)*SPELL
  MATH ~ c(0, NA)*1
  SPELL ~ c(0, NA)*1
"
scalarOutput <- cfa(model = scalarModel, data = dat, std.lv = TRUE,
                    group = "female",
                    group.equal = c("loadings", "intercepts"),
                    missing = "fiml")
summary(scalarOutput)
anova(metricOutput, scalarOutput)


###################################################
### code chunk number 10: lav200
###################################################
MLRModel <- "
wjspl ~ edlevel + newschl + suspend + expelled + haveld + female + age
wjspl ~ 1
"
output <- sem(model = MLRModel, data = dat)
summary(output)


###################################################
### code chunk number 11: lav400
###################################################
SEMModel <- "
  MATH =~ wratcalc + wjcalc + waiscalc
  SPELL =~ wratspl + wjspl + waisspl
  MATH ~ edlevel + newschl + suspend + expelled + haveld + female + age
  SPELL ~ edlevel + newschl + suspend + expelled + haveld + female + age
  MATH ~~ SPELL
"
output <- sem(model = SEMModel, data = dat, missing = "fiml")
summary(output)


###################################################
### code chunk number 12: lav500
###################################################
dat <- read.table("data/anxiety.dat", header = F) 
names(dat) <- c("a1", "a2", "a3", "a4")
model <- "
  intercept =~ 1*a1 + 1*a2 + 1*a3 + 1*a4 
  slope =~ 0*a1 + 1*a2 + 2*a3 + 3*a4 
  a1 ~ 0*1 
  a2 ~ 0*1 
  a3 ~ 0*1 
  a4 ~ 0*1 
  intercept ~ 1 
  slope ~ 1 
"
output <- sem(model, data = dat) 
summary(output)


###################################################
### code chunk number 13: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 14: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


