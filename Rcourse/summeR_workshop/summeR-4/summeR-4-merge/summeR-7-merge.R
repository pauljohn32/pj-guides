### R code from vignette source 'summeR-7-merge-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: summeR-7-merge-uniquebackupstring.Rnw:26-27
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
### code chunk number 4: summeR-7-merge-uniquebackupstring.Rnw:271-289
###################################################
#Build Some Data
authors <- data.frame(
  surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  deceased = c("yes", rep("no", 4)))

#Build Another Data Set
books <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis",
            "An Introduction to R"),
  other_author = c(NA, "Ripley", NA, NA, NA, NA,
                   "Venables & Smith"))


###################################################
### code chunk number 5: se10
###################################################
authors
books
merge(x = authors, y = books, by.x = "surname", by.y = "name")


###################################################
### code chunk number 6: summeR-7-merge-uniquebackupstring.Rnw:305-306 (eval = FALSE)
###################################################
## merge(x, y, by.x, by.y, by, incomparables, sort, all.x, all.y, all )


###################################################
### code chunk number 7: lj10
###################################################
dat_legs <- data.frame(animal = I(c("dog", "cats", "human", "snake", "tree")), legs = c(4, 4, 2, 0, 0))
dat_fur <- data.frame(animal = I(c("dog", "cats", "human", "bird")), fur = c("yes", "Mostly", "No", " No"))


###################################################
### code chunk number 8: lj20
###################################################
dat_legs
dat_fur
merge(x = dat_legs, y = dat_fur, by = "animal", all.x = TRUE)


###################################################
### code chunk number 9: lj30
###################################################
dat_legs
dat_fur
merge(x = dat_fur, y = dat_legs, by = "animal", all.x = TRUE)


###################################################
### code chunk number 10: ij10
###################################################
dat_legs

dat_fur

merge(x = dat_legs, y = dat_fur, by = "animal")


###################################################
### code chunk number 11: fj10
###################################################
dat_legs
dat_fur


###################################################
### code chunk number 12: fj20
###################################################
merge(x = dat_legs, y = dat_fur, by = "animal", all = TRUE)


###################################################
### code chunk number 13: summeR-7-merge-uniquebackupstring.Rnw:493-496
###################################################
dat1 <- data.frame(Company = I(c("A", "B", "C", "D", "E")), Earnings = c(126345, 492012, 234512, -28124, 128675))
  
dat2 <- data.frame(Company = I(c("A", "B", "C", "F")), Region = c("Midwest", "Southeast", "West", " North"))


###################################################
### code chunk number 14: summeR-7-merge-uniquebackupstring.Rnw:499-501
###################################################
dat1
dat2


###################################################
### code chunk number 15: summeR-7-merge-uniquebackupstring.Rnw:517-518
###################################################
merge(x = dat1, y = dat2, by = "Company", all.x = TRUE)


###################################################
### code chunk number 16: summeR-7-merge-uniquebackupstring.Rnw:529-530
###################################################
merge(x = dat2, y = dat1, by = "Company", all.x = TRUE)


###################################################
### code chunk number 17: summeR-7-merge-uniquebackupstring.Rnw:540-541
###################################################
merge(x = dat1, y = dat2, by = "Company", all = FALSE)


###################################################
### code chunk number 18: summeR-7-merge-uniquebackupstring.Rnw:551-552
###################################################
merge(x = dat1, y = dat2, by = "Company", all = TRUE)


###################################################
### code chunk number 19: long10
###################################################
dat_long <- data.frame(
  child_id = I(c("110", "110", "110", "210", "210", "210")), Time = c(1, 2, 3, 1, 2, 3), FSIQ = c(98, 102, 104, 89, 91, 95))

dat_edu <- data.frame(child_id = I(c("210", "110")), par_edu = c("BA", "HS"))


###################################################
### code chunk number 20: long50
###################################################
dat_long


###################################################
### code chunk number 21: long60
###################################################
dat_edu


###################################################
### code chunk number 22: summeR-7-merge-uniquebackupstring.Rnw:621-622
###################################################
merge(x = dat_long, y = dat_edu, by = "child_id", all = TRUE)


###################################################
### code chunk number 23: long71a
###################################################
dat_edu2 <- data.frame(child_id = I(c("210")), par_edu =
c("BA"))


###################################################
### code chunk number 24: long71b
###################################################
dat_edu2


###################################################
### code chunk number 25: long71c
###################################################
merge(x = dat_long, y = dat_edu2, by = "child_id", all = TRUE)


###################################################
### code chunk number 26: long80
###################################################
dat_edu2 <- data.frame(child_id = I(c("210", "110",  "400", "501")), par_edu =
c("BA", "HS", "ES", "HS"))


###################################################
### code chunk number 27: long82
###################################################
dat_edu2


###################################################
### code chunk number 28: long85
###################################################
merge(x = dat_long, y = dat_edu2, by = "child_id", all = TRUE)


###################################################
### code chunk number 29: long86
###################################################
merge(x = dat_long, y = dat_edu2, by = "child_id", all.x = TRUE, all.y = FALSE)


###################################################
### code chunk number 30: summeR-7-merge-uniquebackupstring.Rnw:693-703
###################################################
dat_long1 <- data.frame(
  child_id = I(c("110", "110", "110", "210", "210", "210")),
  Time = c(1, 2, 3, 1, 2, 3),
  FSIQ = c(98, 102, 104, 89, 91, 95))

dat_long2 <- data.frame(
  child_id = c("210", "210", "210", "110", "110", "110"),
  Time = c(1, 2, 3, 1, 2, 3),
  Reaction = c(0.34, 0.28, 0.19, 0.33, 0.32, 0.28), 
  stringsAsFactors = FALSE)


###################################################
### code chunk number 31: summeR-7-merge-uniquebackupstring.Rnw:705-707
###################################################
dat_long1
dat_long2


###################################################
### code chunk number 32: summeR-7-merge-uniquebackupstring.Rnw:715-716
###################################################
head(merge(x = dat_long1, y = dat_long2, by = "child_id", all.x = TRUE), 12)


###################################################
### code chunk number 33: summeR-7-merge-uniquebackupstring.Rnw:725-726
###################################################
merge(x = dat_long1, y = dat_long2, by = c("child_id", "Time"), all.x = TRUE)


###################################################
### code chunk number 34: summeR-7-merge-uniquebackupstring.Rnw:729-730
###################################################
by = c("child_id", "Time")


###################################################
### code chunk number 35: summeR-7-merge-uniquebackupstring.Rnw:750-757
###################################################

dat_nat <- data.frame(
  ID = c("USA", "USA", "USA", "USA", "UK", "UK", "UK", "UK"),
  Year = c(1990, 1990, 1991, 1991, 1990, 1990, 1991, 1991),
  Quarter = c("Q1", "Q2", "Q1", "Q2", "Q1", "Q2", "Q1", "Q2"),
  population = rnorm(8, 10, 1),
  illnesses = rnorm(8, 100, 10), stringsAsFactors = FALSE)


###################################################
### code chunk number 36: summeR-7-merge-uniquebackupstring.Rnw:760-761
###################################################
dat_nat


###################################################
### code chunk number 37: summeR-7-merge-uniquebackupstring.Rnw:768-769
###################################################
table(dat_nat$ID)


###################################################
### code chunk number 38: summeR-7-merge-uniquebackupstring.Rnw:772-773
###################################################
table(dat_nat$ID, dat_nat$Quarter)


###################################################
### code chunk number 39: summeR-7-merge-uniquebackupstring.Rnw:776-777
###################################################
table(dat_nat$ID, dat_nat$Quarter, dat_nat$Year)


###################################################
### code chunk number 40: summeR-7-merge-uniquebackupstring.Rnw:783-796
###################################################
datX <- data.frame(
  ID = c("USA", "USA", "USA", "USA", "UK", "UK", "UK", "UK"),
  Year = c(1990, 1990, 1991, 1991, 1990, 1990, 1991, 1991),
  Quarter = c("Q1", "Q2", "Q1", "Q2", "Q1", "Q2", "Q1", "Q2"),
  pop = rnorm(8, 10, 1), illnesses = rnorm(8, 100, 10), 
  stringsAsFactors = FALSE)
  
datY <- data.frame(
  Country = c("USA", "USA", "USA", "USA", "UK", "UK", "UK", "UK"),
  year = c(1990, 1990, 1991, 1991, 1990, 1990, 1991, 1991),
  Semester = c("Q1", "Q2", "Q1", "Q2", "Q1", "Q2", "Q1", "Q2"),
  percipitation = rnorm(8, 10, 1), cars = rnorm(8, 100, 10), 
  stringsAsFactors = FALSE)


###################################################
### code chunk number 41: summeR-7-merge-uniquebackupstring.Rnw:798-800
###################################################
head(datX)
head(datY)


###################################################
### code chunk number 42: summeR-7-merge-uniquebackupstring.Rnw:808-820
###################################################
datX <- data.frame(
  ID = I(c("USA", "USA", "USA", "USA", "UK", "UK", "UK", "UK")),
  Year = c(1990, 1990, 1991, 1991, 1990, 1990, 1991, 1991),
  Quarter = I(c("Q1", "Q2", "Q1", "Q2", "Q1", "Q2", "Q1", "Q2")),
  pop = rnorm(8, 10, 1), illnesses = rnorm(8, 100, 10))
  
datY <- data.frame(
  Country = I(c(
  "USA", "USA", "USA", "USA", "UK", "UK", "UK", "UK")),
  year = c(1990, 1990, 1991, 1991, 1990, 1990, 1991, 1991),
  Semester = I(c("Q1", "Q2", "Q1", "Q2", "Q1", "Q2", "Q1", "Q2")),
  percipitation = rnorm(8, 10, 1),cars = rnorm(8, 100, 10))


###################################################
### code chunk number 43: summeR-7-merge-uniquebackupstring.Rnw:822-824
###################################################
head(datX)
head(datY)


###################################################
### code chunk number 44: summeR-7-merge-uniquebackupstring.Rnw:831-832
###################################################
merge(x = datX, y = datY, by.x = c("ID", "Year", "Quarter"), by.y = c("Country", "year", "Semester"), all = TRUE)


###################################################
### code chunk number 45: summeR-7-merge-uniquebackupstring.Rnw:840-845
###################################################
datX <- data.frame(
  ID = I(c(
  "111", "112", "NA", "114", "115", "116", "NA")), cars = rbinom(7, 10, 0.5), fear = rnorm(7, 100, 10))
  
datY <- data.frame(ID = I( c("111", "NA", "113", "114", "115", "NA", "117")), pets = rbinom(7, 10, 0.5))


###################################################
### code chunk number 46: summeR-7-merge-uniquebackupstring.Rnw:847-849
###################################################
datX
datY


###################################################
### code chunk number 47: summeR-7-merge-uniquebackupstring.Rnw:856-857
###################################################
merge(x = datX, y = datY, by = "ID", all.x = TRUE)


###################################################
### code chunk number 48: summeR-7-merge-uniquebackupstring.Rnw:867-868
###################################################
merge(x = datX, y = datY, by = "ID", all= FALSE, incomparables = "NA")


###################################################
### code chunk number 49: summeR-7-merge-uniquebackupstring.Rnw:878-881
###################################################
library(kutils)
df1 <- data.frame(id = 1:7, x = rnorm(7))
df2 <- data.frame(id = c(2:6, 9:10), x = rnorm(7))


###################################################
### code chunk number 50: summeR-7-merge-uniquebackupstring.Rnw:883-885
###################################################
df1
df2


###################################################
### code chunk number 51: summeR-7-merge-uniquebackupstring.Rnw:891-893
###################################################
library(kutils)
mergeCheck(df1, df2, by = "id")


###################################################
### code chunk number 52: summeR-7-merge-uniquebackupstring.Rnw:904-907
###################################################
library(kutils)
df1 <- data.frame(idx = c(1:5, NA, NaN), x = rnorm(7))
df2 <- data.frame(idy = c(2:6, 9:10), x = rnorm(7))


###################################################
### code chunk number 53: summeR-7-merge-uniquebackupstring.Rnw:909-911
###################################################
df1
df2


###################################################
### code chunk number 54: summeR-7-merge-uniquebackupstring.Rnw:917-918
###################################################
mergeCheck(df1, df2, by.x = "idx", by.y = "idy")


###################################################
### code chunk number 55: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 56: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


