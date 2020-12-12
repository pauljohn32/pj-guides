### R code from vignette source '/home/pauljohn/GIT/CRMDA/software_R_winteR/winteR-7-merge/winteR-7-mergen.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: winteR-7-mergen.Rnw:182-183
###################################################
if(!file.exists("tmpout")) dir.create("tmpout", showWarnings=F)


###################################################
### code chunk number 2: winteR-7-mergen.Rnw:190-199
###################################################
options(width=70, prompt="> ", continue="  ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par()
pjmar <- c(4.1, 4.1, 1.5, 2.1)
##pjmar <- par("mar")
par(mar=pjmar, ps=11)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12, xpd=F)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 3: winteR-7-mergen.Rnw:256-274
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
### code chunk number 4: se10
###################################################
authors
books
merge(x = authors, y = books, by.x = "surname", by.y = "name")


###################################################
### code chunk number 5: winteR-7-mergen.Rnw:290-291 (eval = FALSE)
###################################################
## merge(x, y, by.x, by.y, by, incomparables, sort, all.x, all.y, all )


###################################################
### code chunk number 6: lj10
###################################################
dat_legs <- data.frame(animal = I(c("dog", "cats", "human", "snake", "tree")), legs = c(4, 4, 2, 0, 0))
dat_fur <- data.frame(animal = I(c("dog", "cats", "human", "bird")), fur = c("yes", "Mostly", "No", " No"))


###################################################
### code chunk number 7: lj20
###################################################
dat_legs
dat_fur
merge(x = dat_legs, y = dat_fur, by = "animal", all.x = TRUE)


###################################################
### code chunk number 8: lj30
###################################################
dat_legs
dat_fur
merge(x = dat_fur, y = dat_legs, by = "animal", all.x = TRUE)


###################################################
### code chunk number 9: ij10
###################################################
dat_legs

dat_fur

merge(x = dat_legs, y = dat_fur, by = "animal", all = FALSE)


###################################################
### code chunk number 10: fj10
###################################################
dat_legs
dat_fur


###################################################
### code chunk number 11: fj20
###################################################
merge(x = dat_legs, y = dat_fur, by = "animal", all = TRUE)


###################################################
### code chunk number 12: winteR-7-mergen.Rnw:487-490
###################################################
dat1 <- data.frame(Company = I(c("A", "B", "C", "D", "E")), Earnings = c(126345, 492012, 234512, -28124, 128675))
  
dat2 <- data.frame(Company = I(c("A", "B", "C", "F")), Region = c("Midwest", "Southeast", "West", " North"))


###################################################
### code chunk number 13: winteR-7-mergen.Rnw:493-495
###################################################
dat1
dat2


###################################################
### code chunk number 14: winteR-7-mergen.Rnw:511-512
###################################################
merge(x = dat1, y = dat2, by = "Company", all.x = TRUE)


###################################################
### code chunk number 15: winteR-7-mergen.Rnw:523-524
###################################################
merge(x = dat2, y = dat1, by = "Company", all.x = TRUE)


###################################################
### code chunk number 16: winteR-7-mergen.Rnw:534-535
###################################################
merge(x = dat1, y = dat2, by = "Company", all = FALSE)


###################################################
### code chunk number 17: winteR-7-mergen.Rnw:545-546
###################################################
merge(x = dat1, y = dat2, by = "Company", all = TRUE)


###################################################
### code chunk number 18: long10
###################################################
dat_long <- data.frame(
  child_id = I(c("110", "110", "110", "210", "210", "210")), Time = c(1, 2, 3, 1, 2, 3), FSIQ = c(98, 102, 104, 89, 91, 95))

dat_edu <- data.frame(child_id = I(c("210", "110")), par_edu = c("BA", "HS"))


###################################################
### code chunk number 19: long50
###################################################
dat_long


###################################################
### code chunk number 20: long60
###################################################
dat_edu


###################################################
### code chunk number 21: winteR-7-mergen.Rnw:617-618
###################################################
merge(x = dat_long, y = dat_edu, by = "child_id", all = TRUE)


###################################################
### code chunk number 22: long71a
###################################################
dat_edu2 <- data.frame(child_id = I(c("210")), par_edu =
c("BA"))


###################################################
### code chunk number 23: long71b
###################################################
dat_edu2


###################################################
### code chunk number 24: long71c
###################################################
merge(x = dat_long, y = dat_edu2, by = "child_id", all = TRUE)


###################################################
### code chunk number 25: long80
###################################################
dat_edu2 <- data.frame(child_id = I(c("210", "110",  "400", "501")), par_edu =
c("BA", "HS", "ES", "HS"))


###################################################
### code chunk number 26: long82
###################################################
dat_edu2


###################################################
### code chunk number 27: long85
###################################################
merge(x = dat_long, y = dat_edu2, by = "child_id", all = TRUE)


###################################################
### code chunk number 28: long86
###################################################
merge(x = dat_long, y = dat_edu2, by = "child_id", all.x = TRUE, all.y = FALSE)


###################################################
### code chunk number 29: winteR-7-mergen.Rnw:689-698
###################################################
dat_long1 <- data.frame(
  child_id = I(c("110", "110", "110", "210", "210", "210")),
  Time = c(1, 2, 3, 1, 2, 3),
  FSIQ = c(98, 102, 104, 89, 91, 95))

dat_long2 <- data.frame(
  child_id = I(c("210", "210", "210", "110", "110", "110")),
  Time = c(1, 2, 3, 1, 2, 3),
  Reaction = c(0.34, 0.28, 0.19, 0.33, 0.32, 0.28))


###################################################
### code chunk number 30: winteR-7-mergen.Rnw:700-702
###################################################
dat_long1
dat_long2


###################################################
### code chunk number 31: winteR-7-mergen.Rnw:710-711
###################################################
head(merge(x = dat_long1, y = dat_long2, by = "child_id", all.x = TRUE), 12)


###################################################
### code chunk number 32: winteR-7-mergen.Rnw:720-721
###################################################
merge(x = dat_long1, y = dat_long2, by = c("child_id", "Time"), all.x = TRUE)


###################################################
### code chunk number 33: winteR-7-mergen.Rnw:724-725
###################################################
by = c("child_id", "Time")


###################################################
### code chunk number 34: winteR-7-mergen.Rnw:744-753
###################################################

dat_nat <- data.frame(
  ID = I(c(
  "USA", "USA", "USA", "USA", "UK", "UK", "UK", "UK")),
  Year = c(1990, 1990, 1991, 1991, 1990, 1990, 1991, 1991),
  Quarter = I(c("Q1", "Q2", "Q1", "Q2", "Q1", "Q2", "Q1", "Q2")),
  population = rnorm(8, 10, 1),
  illnesses = rnorm(8, 100, 10))



###################################################
### code chunk number 35: winteR-7-mergen.Rnw:756-757
###################################################
dat_nat


###################################################
### code chunk number 36: winteR-7-mergen.Rnw:764-765
###################################################
table(dat_nat$ID)


###################################################
### code chunk number 37: winteR-7-mergen.Rnw:768-769
###################################################
table(dat_nat$ID, dat_nat$Quarter)


###################################################
### code chunk number 38: winteR-7-mergen.Rnw:772-773
###################################################
table(dat_nat$ID, dat_nat$Quarter, dat_nat$Year)


###################################################
### code chunk number 39: winteR-7-mergen.Rnw:782-795
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
### code chunk number 40: winteR-7-mergen.Rnw:797-799
###################################################
head(datX)
head(datY)


###################################################
### code chunk number 41: winteR-7-mergen.Rnw:812-824
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
### code chunk number 42: winteR-7-mergen.Rnw:826-828
###################################################
head(datX)
head(datY)


###################################################
### code chunk number 43: winteR-7-mergen.Rnw:835-836
###################################################
merge(x = datX, y = datY, by.x = c("ID", "Year", "Quarter"), by.y = c("Country", "year", "Semester"),all = TRUE)


###################################################
### code chunk number 44: winteR-7-mergen.Rnw:844-849
###################################################
datX <- data.frame(
  ID = I(c(
  "111", "112", "NA", "114", "115", "116", "NA")), cars = rbinom(7, 10, 0.5), fear = rnorm(7, 100, 10))
  
datY <- data.frame(ID = I( c("111", "NA", "113", "114", "115", "NA", "117")), pets = rbinom(7, 10, 0.5))


###################################################
### code chunk number 45: winteR-7-mergen.Rnw:851-853
###################################################
datX
datY


###################################################
### code chunk number 46: winteR-7-mergen.Rnw:860-861
###################################################
merge(x = datX, y = datY, by = "ID", all.x = TRUE)


###################################################
### code chunk number 47: winteR-7-mergen.Rnw:871-872
###################################################
merge(x = datX, y = datY, by = "ID", all= FALSE, incomparables = "NA")


###################################################
### code chunk number 48: winteR-7-mergen.Rnw:881-884
###################################################
library(kutils)
df1 <- data.frame(id = 1:7, x = rnorm(7))
df2 <- data.frame(id = c(2:6, 9:10), x = rnorm(7))


###################################################
### code chunk number 49: winteR-7-mergen.Rnw:886-888
###################################################
df1
df2


###################################################
### code chunk number 50: winteR-7-mergen.Rnw:894-896
###################################################
library(kutils)
mergeCheck(df1, df2, by = "id")


###################################################
### code chunk number 51: winteR-7-mergen.Rnw:907-910
###################################################
library(kutils)
df1 <- data.frame(idx = c(1:5, NA, NaN), x = rnorm(7))
df2 <- data.frame(idy = c(2:6, 9:10), x = rnorm(7))


###################################################
### code chunk number 52: winteR-7-mergen.Rnw:912-914
###################################################
df1
df2


###################################################
### code chunk number 53: winteR-7-mergen.Rnw:920-921
###################################################
mergeCheck(df1, df2, by.x = "idx", by.y = "idy")


