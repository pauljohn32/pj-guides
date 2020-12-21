### R code from vignette source 'regex-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: regex-uniquebackupstring.Rnw:29-30
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
### code chunk number 4: regex-uniquebackupstring.Rnw:340-341
###################################################
x <- c("Dieter-Charles", "Charles", "Charlie", "Charles-William", "Charlene")


###################################################
### code chunk number 5: regex-uniquebackupstring.Rnw:346-347
###################################################
grep("Charles$", x)


###################################################
### code chunk number 6: regex-uniquebackupstring.Rnw:352-353
###################################################
grep("^Charles", x)


###################################################
### code chunk number 7: regex-uniquebackupstring.Rnw:364-365
###################################################
grep("^Charles", x, value = TRUE)


###################################################
### code chunk number 8: regex-uniquebackupstring.Rnw:387-389
###################################################
aname <- "Fred \"The Hammer\" Williamson"
aname


###################################################
### code chunk number 9: regex-uniquebackupstring.Rnw:395-397
###################################################
aname <- 'Fred "The Hammer" Williamson'
aname


###################################################
### code chunk number 10: regex-uniquebackupstring.Rnw:408-409
###################################################
x <- c("Dieter\\Charles", "Friend/Foe")


###################################################
### code chunk number 11: regex-uniquebackupstring.Rnw:415-417
###################################################
print(x)
cat(x)


###################################################
### code chunk number 12: regex-uniquebackupstring.Rnw:426-427
###################################################
grep("\\\\", x)


###################################################
### code chunk number 13: regex-uniquebackupstring.Rnw:456-457
###################################################
grep("\\", x, fixed = TRUE)


###################################################
### code chunk number 14: regex-uniquebackupstring.Rnw:475-476
###################################################
cities <- c("Dallas Texas", "Denver Colorado", "Austin Texas", "Salem Oregon", "Salem Massachusetts", "California Pennsylvania", "Long Beach California", "San Francisco California", "Texas Missouri", "Nevada Missouri", "St. Louis Missouri", "Truth or Consequences New Mexico", "Charleston South Carolina", "Charleston North Carolina") 


###################################################
### code chunk number 15: regex-uniquebackupstring.Rnw:483-484
###################################################
grep("Texas", cities, fixed = TRUE, value = TRUE)


###################################################
### code chunk number 16: regex-uniquebackupstring.Rnw:499-500
###################################################
grep("Texas$", cities, value = TRUE)


###################################################
### code chunk number 17: ht10
###################################################
cnames <- c("ID", "Q1", "encounter", "forms", "ar_physinj.n", "ar_illness.n",
"ar_chronic.n", "ar_job.n", "ar_hunger.n", "ar_STI.n", "ar_sa.n",
"ar_UTI.n", "ar_abuse.n", "ar_dental.n", "ar_drugalc.n", "ar_suicide.n",
"ar_chronrun.n", "ar_truancy.n", "ar_sysinvolve.n", "ar_menthealth.n",
"ar_tattoos.n", "ar_other.n", "rf_pov.n", "rf_homeless.n", "rf_famdys.n",
"rf_control.n", "rf_addiction.n", "rf_physdis.n", "rf_cogdis.n",
"rf_race.n", "rf_LGBTQ.n", "rf_undoc.n", "rf_lang.n", "rf_pregnancy.n",
"rf_dropout.n", "rf_running.n", "rf_sex.n", "rf_abuse.n", "rf_fincontrol.n",
"rf_ssnetworks.n", "rf_other.n", "ar_physinj.l", "ar_illness.l",
"ar_chronic.l", "ar_job.l", "ar_hunger.l", "ar_STI.l", "ar_sa.l",
"ar_UTI.l", "ar_abuse.l", "ar_dental.l", "ar_drugalc.l", "ar_suicide.l",
"ar_chronrun.l", "ar_truancy.l", "ar_sysinvolve.l", "ar_menthealth.l",
"ar_tattoos.l", "ar_other.l", "rf_pov.l", "rf_homeless.l", "rf_famdys.l",
"rf_control.l", "rf_addiction.l", "rf_physdis.l", "rf_cogdis.l",
"rf_race.l", "rf_LGBTQ.l", "rf_undoc.l", "rf_lang.l", "rf_pregnancy.l",
"rf_dropout.l", "rf_running.l", "rf_sex.l", "rf_abuse.l", "rf_fincontrol.l",
"rf_ssnetworks.l", "rf_other.l", "ar_physinj.s", "ar_illness.s",
"ar_chronic.s", "ar_job.s", "ar_hunger.s", "ar_STI.s", "ar_sa.s",
"ar_UTI.s", "ar_abuse.s", "ar_dental.s", "ar_drugalc.s", "ar_suicide.s",
"ar_chronrun.s", "ar_truancy.s", "ar_sysinvolve.s", "ar_menthealth.s",
"ar_tattoos.s", "ar_other.s", "rf_pov.s", "rf_homeless.s", "rf_famdys.s",
"rf_control.s", "rf_addiction.s", "rf_physdis.s", "rf_cogdis.s",
"rf_race.s", "rf_LGBTQ.s", "rf_undoc.s", "rf_lang.s", "rf_pregnancy.s",
"rf_dropout.s", "rf_running.s", "rf_sex.s", "rf_abuse.s", "rf_fincontrol.s",
"rf_ssnetworks.s", "rf_other.s", "cr_strongfam", "cr_mentors",
"cr_faithcom", "cr_culturecom", "cr_employment", "cr_edaccess",
"cr_houseaccess", "cr_pathimm", "cr_physhealth", "cr_menthealth",
"cr_insurance", "cr_govprog", "cr_other", "or_protocol", "or_collab",
"or_lawenforce", "or_hotline", "or_training", "or_other", "sector",
"chronrun", "truancy", "region", "arak", "arub", "arakUTI", "Q57", "Q59",
"Q61", "Q63", "Q65", "Q19", "Q21", "Q23", "Q25", "Q27")


###################################################
### code chunk number 18: ht20
###################################################
reslt1 <- data.frame(
  n = grep("^ar_.*\\.n$", cnames, value = TRUE), 
  s = grep("^ar_.*\\.s$", cnames, value = TRUE), 
  l = grep("^ar_.*\\.s$", cnames, value = TRUE))
head(reslt1, 15)


###################################################
### code chunk number 19: ht30
###################################################
reslt2 <- grep("_chronrun\\.", cnames, value = TRUE)
reslt2


###################################################
### code chunk number 20: cities10
###################################################
cities <- c("Dallas Texas", "Denver Colorado", "Austin Texas", "Salem Oregon", "Salem Massachusetts", "California Pennsylvania", "Long Beach California", "San Francisco California", "Texas Missouri", "Nevada Missouri", "St. Louis Missouri", "Truth or Consequences New Mexico", "Charleston South Carolina", "Charleston North Carolina") 


###################################################
### code chunk number 21: step11
###################################################
gsub("Texas$", "TX", cities)


###################################################
### code chunk number 22: step12
###################################################
head(state.name)
head(state.abb)


###################################################
### code chunk number 23: step13
###################################################
names(state.name) <- state.abb


###################################################
### code chunk number 24: step13statename1
###################################################
head(state.name)


###################################################
### code chunk number 25: step13statename2
###################################################
state.name["TX"]


###################################################
### code chunk number 26: step14
###################################################
cities2 <- cities
## I'll iterate on the abbreviations
for(i in state.abb) {
    cities2 <- gsub(state.name[i], i, cities2)
}  


###################################################
### code chunk number 27: step13b
###################################################
cities2
cities2[10]


###################################################
### code chunk number 28: step13c
###################################################
## Keep cities safe, write on a copy cities2
cities2 <- cities
## Method 1
## Puts the target match correction into the for loop
for(i in state.abb) {
    ## target is a string, only has one element
    target <- paste0(state.name[i], "$") 
    cities2 <- gsub(target, i, cities2)
} 
## Appears correct:
cities2
##
## Here is method 2. We start over,
## Creating a target VECTOR before the for loop.
## After this, target is a vector of corrected matches
cities2 <- cities
target <- paste0(state.name, "$") 
## names were lost, so re-apply them
names(target) <- names(state.name)
## inspect
head(target, 5)
for(i in state.abb) {
    ## target is a vector, choose the i'th one
    cities2 <- gsub(target[i], i, cities2)
} 
cities2


###################################################
### code chunk number 29: regex-uniquebackupstring.Rnw:791-794
###################################################
library(kutils)
target <- paste0(state.name, "$")
mgsub(target, state.abb, cities)


###################################################
### code chunk number 30: step21
###################################################
head(cities2, 5)
cities3 <- gsub(" ..$", "", cities2) 
head(cities3, 5)


###################################################
### code chunk number 31: step31
###################################################
stabbs <- gsub(".* ", "", cities2) 
stabbs


###################################################
### code chunk number 32: step41
###################################################
stnames <- state.name[stabbs]
stnames


###################################################
### code chunk number 33: step42
###################################################
reslt <- data.frame(address = cities, 
            cities = cities3, st.abb = stabbs, 
            st.name = stnames)
head(reslt)


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


