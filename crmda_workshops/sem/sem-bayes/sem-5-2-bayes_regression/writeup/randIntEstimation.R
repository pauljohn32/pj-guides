## ----setup, include=FALSE------------------------------------------------
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
opts.orig <- options()
par.orig <- par(no.readonly=TRUE)
options(width = 70)

## ----themecopy, include = FALSE------------------------------------------
library(stationery)
## If theme directory does not have required images or TeX files
## we need to retrieve them and put them in "theme" directory. 
logos <- c(logoleft = "logoleft.png", 
           logoright = "logo-vert.png")
files <- c("kutils.css", "guide-boilerplate.html")
getFiles(logos, pkg = "crmda")
getFiles(files, pkg = "stationery")

## ------------------------------------------------------------------------
library(data.table)
library(lme4)
library(R2OpenBUGS)
library(rstan)

## ------------------------------------------------------------------------
rdir <- "R"
source(file.path(rdir, "drawCI.R"))

## ------------------------------------------------------------------------
## set directories
wdir <- "workingdata"
bugsdir <- "OpenBUGS"
standir <- "stan"

## read in data
df <- readRDS(file.path(wdir, "srrs2.mn.rds"))

## create aggregate data frame, one row per county
dt <- as.data.table(df)
setkey(dt, "county.numbers")

ctyDT <- dt[ , list(sample.size = length(radonlog),
                    cty.mns = mean(radonlog, na.rm=TRUE),
                    cty.vars = var(radonlog, na.rm=TRUE),
                    county.name = unique(county.name)), 
					by = c("county.numbers")]

ctyDT[ , cty.sds.sep := sqrt(cty.vars/sample.size)]

head(ctyDT)

## ------------------------------------------------------------------------
## J is the number of counties
J <- length(unique(df$county.name))

## G&H create their own jittered variant for plotting
ctyDT[ , ss.jittered := sample.size * exp(runif(J, -.1, .1))]

## ------------------------------------------------------------------------
m1 <- lm(radonlog ~ 0 + county.name, data=df)
m1.pred <- predict(m1, se.fit=TRUE, newdata=ctyDT)

## ------------------------------------------------------------------------
ctyDT$m1.fit <- m1.pred$fit
ctyDT$m1.se <- m1.pred$se.fit

## ---- fig.height=7, fig.width=9------------------------------------------
m1ci2 <- drawCI(ctyDT$ss.jittered, ctyDT$m1.fit, ctyDT$m1.se, 
                main = "LM Estimates of Intercepts")

## ------------------------------------------------------------------------
ctyDT[ctyDT$m1.fit > 2, c("county.numbers", "county.name", "m1.fit")]
ctyDT[ctyDT$m1.fit < 0.5, c("county.numbers", "county.name", "m1.fit")]

## ---- fig.height=7, fig.width=9------------------------------------------
m1ci2 <- drawCI(ctyDT$ss.jittered, ctyDT$m1.fit, ctyDT$m1.se,
                main="LM Estimates of Intercepts",
                focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)

## ------------------------------------------------------------------------
lme1 <- lmer(radonlog ~ (1 | county.numbers), data = df)
summary(lme1)

## ------------------------------------------------------------------------
lme1.ranef <- ranef(lme1, condVar = TRUE)

## ------------------------------------------------------------------------
lme1.ranef.df <- as.data.frame(lme1.ranef)

## ------------------------------------------------------------------------
## Insert the estimates into the county-level data
## fit is beta0 + random effect
ctyDT[ , "lme1.fit"] <- lme1.ranef.df$condval + fixef(lme1)[["(Intercept)"]]
## Check that lme1.fit is same as  coef output
ctyDT[ , "lme1.coef"] <- coef(lme1)$county.numbers["(Intercept)"]
## Insert std errs from lmer in county data frame
ctyDT[ , "lme1.se"] <- lme1.ranef.df$condsd

## ---- fig.height=6, fig.width=9------------------------------------------
par(mfrow=c(1,2))
m1ci <- drawCI(ctyDT$ss.jittered, ctyDT$m1.fit, ctyDT$m1.se,
                main="LM Estimates of Intercepts",
                focal=c(1, 36, 40, 77), labelfocal=TRUE)
lme1ci <- drawCI(ctyDT$ss.jittered, ctyDT$lme1.fit, ctyDT$lme1.se,
                 ylim=m1ci$ylim, main="lme4 Intercept Estimates",
				 focal=c(1, 36, 40, 77), labelfocal=TRUE)

## ------------------------------------------------------------------------
mData <- list(N = nrow(df), 
	  		  J=J,
              y = df$radonlog,
              county = df$county.numbers)

## ------------------------------------------------------------------------
radon.inits <- function (){
    list (a = rnorm(J), 
 	      mu.a = rnorm(1),
          sigma.y = runif(1), 
		  sigma.a = runif(1))
}

## ------------------------------------------------------------------------
radon.parameters <- c ("a", "mu.a", "sigma.y", "sigma.a")
    
## Run scratch files in temporary directory
bayeswd <- tempdir()
    
## Copy the BUGS code file to the bayes scratch dir
file.copy(file.path(bugsdir, "radon.multilevel.nopred.txt"), 
		  bayeswd, overwrite=TRUE)

mBugs1 <- bugs(model.file="radon.multilevel.nopred.txt",
			   data=mData, inits=radon.inits, n.iter=1000, n.chains=3,
               parameters.to.save=radon.parameters,
			   OpenBUGS.pgm="/usr/bin/OpenBUGS",
               useWINE=FALSE, working.directory=bayeswd, clearWD=FALSE)


## ---- fig.height=10, fig.width=9-----------------------------------------
plot(mBugs1)

## ------------------------------------------------------------------------
ctyDT$bugs.fit <- mBugs1$median$a
ctyDT$bugs.se <- mBugs1$sd$a

## ---- fig.height=6, fig.width=9------------------------------------------
par(mfrow=c(1,2))
lme1ci <- drawCI(ctyDT$ss.jittered, ctyDT$lme1.fit, ctyDT$lme1.se,
   	             main="lme4 Intercept Estimates", ylim=c(0.3, 2.2),
                 focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)
mBugs1ci <- drawCI(ctyDT$ss.jittered, ctyDT$bugs.fit, ctyDT$bugs.se,
                   ylim=lme1ci$ylim, main="OpenBUGS Intercepts",
                   focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)

## ---- fig.height=5, fig.width=6, fig.align="center"----------------------
plot(lme1.fit ~ bugs.fit, ctyDT)

## ------------------------------------------------------------------------
mStan1 <- stan(file.path(standir, "radon-1.stan"), 
	           data=mData, warmup=1000, iter=2000, chains=4)

## ------------------------------------------------------------------------
post <- extract(mStan1)
ints <- apply(post$u, 2, function(x) x + post$b0)

## ------------------------------------------------------------------------
ctyDT$stan.fit <- apply(ints, 2, median)
ctyDT$stan.se <- apply(ints, 2, sd)
ctyDT$stan.mean <- apply(ints, 2, mean)

## ---- fig.height=5, fig.width=9------------------------------------------
par(mfrow=c(1,3))
lme1ci <- drawCI(ctyDT$ss.jittered, ctyDT$lme1.fit, ctyDT$lme1.se,
   	             main="lme4 Intercept Estimates", ylim=c(0.3, 2.2),
                 focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)
mBugs1ci <- drawCI(ctyDT$ss.jittered, ctyDT$bugs.fit, ctyDT$bugs.se,
                   ylim=lme1ci$ylim, main="OpenBUGS Intercepts",
                   focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)
mStan1ci <- drawCI(ctyDT$ss.jittered, ctyDT$stan.fit, ctyDT$stan.se,
	               ylim=lme1ci$ylim, main="Stan Intercepts",
                   focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)

## ---- fig.height=6, fig.width=9------------------------------------------
pairs(~ lme1.fit + bugs.fit + stan.fit, ctyDT)

## ------------------------------------------------------------------------
print(mStan1, pars="sigmaU")

## ------------------------------------------------------------------------
mStan2 <- stan(file.path(standir, "radon-1b.stan"), 
	           data=mData, warmup=1000, iter=2000, chains=4)
mStan3 <- stan(file.path(standir, "radon-1c.stan"), 
	           data=mData, warmup=1000, iter=2000, chains=4)

## ------------------------------------------------------------------------
post2 <- extract(mStan2)
ints2 <- apply(post2$u, 2, function(x) x + post2$b0)

post3 <- extract(mStan3)
ints3 <- apply(post3$u, 2, function(x) x + post3$b0)

## ------------------------------------------------------------------------
ctyDT$stan2.fit <- apply(ints2, 2, median)
ctyDT$stan2.se <- apply(ints2, 2, sd)
ctyDT$stan2.mean <- apply(ints2, 2, mean)

ctyDT$stan3.fit <- apply(ints3, 2, median)
ctyDT$stan3.se <- apply(ints3, 2, sd)
ctyDT$stan3.mean <- apply(ints3, 2, mean)

## ---- fig.height=9, fig.width=9------------------------------------------
par(mfrow=c(2, 2))
m1ci <- drawCI(ctyDT$ss.jittered, ctyDT$m1.fit, ctyDT$m1.se,
               main="LM baseline", ylim=c(-0.5, 3.5), 
               focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)
stan1ci <- drawCI(ctyDT$ss.jittered, ctyDT$stan.fit, ctyDT$stan.se,
   	              main="Stan baseline", ylim=c(-0.5, 3.5),
                  focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)
stan2ci <- drawCI(ctyDT$ss.jittered, ctyDT$stan2.fit, ctyDT$stan2.se,
                  ylim=c(-0.5, 3.5), main="SD on U Prior: 0.6",
                  focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)
stan3ci <- drawCI(ctyDT$ss.jittered, ctyDT$stan3.fit, ctyDT$stan3.se,
                  ylim=c(-0.5, 3.5), main="SD on U Prior: 1.0",
                  focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)


## ------------------------------------------------------------------------
mStan4 <- stan(file.path(standir, "radon-1d.stan"), 
	           data=mData, warmup=1000, iter=2000, chains=4)

## ------------------------------------------------------------------------
post4 <- extract(mStan4)
ints4 <- apply(post4$u, 2, function(x) x + post4$b0)

## ------------------------------------------------------------------------
ctyDT$stan4.fit <- apply(ints4, 2, median)
ctyDT$stan4.se <- apply(ints4, 2, sd)

## ---- fig.height=6, fig.width=9------------------------------------------
par(mfrow=c(1, 2))
m1ci <- drawCI(ctyDT$ss.jittered, ctyDT$m1.fit, ctyDT$m1.se,
               main="LM baseline", ylim=c(-0.5, 3.5), 
               focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)
stan4ci <- drawCI(ctyDT$ss.jittered, ctyDT$stan.fit, ctyDT$stan.se,
   	              main="Uniform Prior on U", ylim=c(-0.5, 3.5),
                  focal=c(36, 50, 81, 35, 37, 79), labelfocal=TRUE)

## ----sessionInfo, echo = FALSE-------------------------------------------
sessionInfo()

## ----warnings, echo = FALSE----------------------------------------------
if(!is.null(warnings())){
    print("Warnings:")
    warnings()
}

## ----RoptionsRestore, echo=FALSE, include=FALSE--------------------------
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
par(par.orig)

