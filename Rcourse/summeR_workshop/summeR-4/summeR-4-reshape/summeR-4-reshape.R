### R code from vignette source 'summeR-4-reshape-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-4-reshape-uniquebackupstring.Rnw:32-33
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
### code chunk number 4: summeR-4-reshape-uniquebackupstring.Rnw:324-325 (eval = FALSE)
###################################################
## help("reshape")


###################################################
### code chunk number 5: summeR-4-reshape-uniquebackupstring.Rnw:389-392
###################################################
ddir <- "data"
gpa <- read.csv(unzip(file.path(ddir, "gpa.csv.zip")))
head(gpa, 10)


###################################################
### code chunk number 6: summeR-4-reshape-uniquebackupstring.Rnw:401-407
###################################################
gpa2 <- reshape(gpa, direction = "long",
        varying = list(c("job1", "job2", "job3", "job4", "job5", "job6"),     
        c("gpa1", "gpa2", "gpa3", "gpa4", "gpa5", "gpa6")), 
        v.names = c("job", "gpa"),  
        idvar = "student") 
head(gpa2, 10)


###################################################
### code chunk number 7: summeR-4-reshape-uniquebackupstring.Rnw:424-426
###################################################
gpa2 <- gpa2[order(gpa2$student, gpa2$time), ]
head(gpa2, 40)


###################################################
### code chunk number 8: summeR-4-reshape-uniquebackupstring.Rnw:431-437
###################################################
gpa2 <- reshape(gpa, direction = "long", 
           varying = list(paste0("job", 1:6), paste0("gpa", 1:6)), 
           v.names = c("job", "gpa"),  
           idvar = "student") 
gpa2 <- gpa2[order(gpa2$student, gpa2$time), ]
head(gpa2, 12)


###################################################
### code chunk number 9: summeR-4-reshape-uniquebackupstring.Rnw:447-452
###################################################
gpa3 <- reshape(gpa, varying = list(paste0("job", 1:6)), 
          v.names = c("job"),  direction = "long", 
          idvar = "student")
gpa3 <- gpa3[order(gpa3$student, gpa3$time), ]
head(gpa3, 12)


###################################################
### code chunk number 10: summeR-4-reshape-uniquebackupstring.Rnw:460-474
###################################################
for(i in 7:2){
   gpa[ , paste0("gpa", i)] <- gpa[ , paste0("gpa", i-1)]
}
gpa$gpa1 <- NULL
for(i in 7:2){
   gpa[ , paste0("job", i)] <- gpa[ , paste0("job", i-1)]
}
gpa$job1 <- NULL
colnames(gpa)
gpa4 <- reshape(gpa, varying = list(paste0("job", 2:7), paste0("gpa", 2:7)), 
                v.names = c("job", "gpa"),  direction = "long", 
                idvar = "student") 
gpa4 <- gpa4[order(gpa4$student, gpa4$time), ]
head(gpa4, 12)


###################################################
### code chunk number 11: summeR-4-reshape-uniquebackupstring.Rnw:479-484
###################################################
gpa5 <- reshape(gpa, varying = list(paste0("job", 2:7), paste0("gpa", 2:7)), 
                v.names = c("job", "gpa"),  direction = "long", 
                idvar = "student", times = 2:7) 
gpa5 <- gpa5[order(gpa5$student, gpa5$time), ]
head(gpa5, 12)


###################################################
### code chunk number 12: summeR-4-reshape-uniquebackupstring.Rnw:489-494
###################################################
gpa5 <- reshape(gpa, varying = list(paste0("job", 2:7), paste0("gpa", 2:7)), 
                v.names = c("job", "gpa"),  direction = "long", 
                idvar = "student", times = 7:2) 
gpa5 <- gpa5[order(gpa5$student, gpa5$time), ]
head(gpa5, 12)


###################################################
### code chunk number 13: summeR-4-reshape-uniquebackupstring.Rnw:665-667
###################################################
tti_dat <- read.csv(unzip(file.path(ddir, "TTI_Data.csv.zip")), header = TRUE)
colnames(tti_dat, 20)


###################################################
### code chunk number 14: summeR-4-reshape-uniquebackupstring.Rnw:679-681
###################################################
tti_dat_wide <- reshape(tti_dat, direction = "wide", timevar = "Year", idvar = "Urban.Area")
colnames(tti_dat_wide)


###################################################
### code chunk number 15: summeR-4-reshape-uniquebackupstring.Rnw:692-693
###################################################
tti_dat_wide2 <- reshape(tti_dat, direction = "wide", timevar = "Year", idvar = "Urban.Area", v.names = c("Annual.Congestion.Cost", "Delay.per.Commuter"))


###################################################
### code chunk number 16: summeR-4-reshape-uniquebackupstring.Rnw:704-705
###################################################
ttisub <- tti_dat[ , c("Urban.Area", "Year", "Annual.Congestion.Cost", "Delay.per.Commuter", "Population")]


###################################################
### code chunk number 17: summeR-4-reshape-uniquebackupstring.Rnw:708-713
###################################################
tti_dat_wide2 <- 
    reshape(ttisub, direction = "wide", 
            timevar = "Year",
            idvar = "Urban.Area",
            v.names = c("Annual.Congestion.Cost", "Delay.per.Commuter"))


###################################################
### code chunk number 18: summeR-4-reshape-uniquebackupstring.Rnw:723-724
###################################################
tti_dat_wide2[1:10, c("Urban.Area", "Population", "Annual.Congestion.Cost.2011")]


###################################################
### code chunk number 19: summeR-4-reshape-uniquebackupstring.Rnw:732-733
###################################################
tti_dat_wide[1:10 , grep("Population", colnames(tti_dat_wide), value = TRUE)[1:5]]


###################################################
### code chunk number 20: summeR-4-reshape-uniquebackupstring.Rnw:760-768
###################################################
tti_dat_wide3 <- 
    reshape(ttisub, direction = "wide", 
            timevar = "Urban.Area",
            idvar = "Year")
## Leaves some illegal column names, fix with make.names
colnames(tti_dat_wide3) <- make.names(colnames(tti_dat_wide3))
tti_dat_wide3[1:10, 1:5]
colnames(tti_dat_wide3)[1:40]


###################################################
### code chunk number 21: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 22: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


