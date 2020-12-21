#Title: Get the American National Election Study 2004
#Author: Paul Johnson
#Date: 2009-01-27

#Browse: http://www.icpsr.umich.edu/cgi-bin/bob/newark?study=4245

#take all files, download to "DataExample-ANES2004"

list.files()

### In terminal, could just run "unzip 10243963.zip", but I'm in the R
### session now, so I have to tell the system to do that for me.
system("unzip 10243963.zip")

library(foreign)


mydta1 <- read.dta("10243963/ICPSR_04245/DS0001/04245-0001-Data.dta")

names(mydta1)


##review this file: DS0001/04245-0001-Codebook.pdf

#=============================================================================
#V043116 J1x. Summary: R party ID
#=============================================================================
#PRE-ELECTION SURVEY:
#QUESTION:
#---------
#Generally speaking, do you usually think of yourself as a
#REPUBLICAN, a DEMOCRAT, an INDEPENDENT, or what?
#Would you call yourself a STRONG [Democrat/Republican] or
#a NOT VERY STRONG [Democrat/Republican]?
#Do you think of yourself as CLOSER to the Republican
#Party or to the Democratic party?
#VALID CODES:
#------------
#0. Strong Democrat (2/1/.)
#1. Weak Democrat (2/5-8-9/.)
#2. Independent-Democrat (3-4-5/./5)
#3. Independent-Independent
#(3/./3-8-9 ; 5/./3-8-9 if not apolitical)
#4. Independent-Republican (3-4-5/./1)
#5. Weak Republican (1/5-8-9/.)
#6. Strong Republican (1/1/.)
#7. Other; minor party; refuses to say (9/./. ; 4/./3-8-9)
#MISSING CODES:
#--------------
#8. Apolitical (5/./3-8-9 if apolitical)
#9. DK


table(mydta1$V043116)

t1 <- table(mydta1$V043116)
summary(t1)

NofCases <- sum(t1)

barplot(t1/NofCases)

attributes(mydta1$V043116)


## Be cautious about making changes "on top" of existing variables.

## Observe levels of the party variable as it stands now:
levels(mydta1$V043116)

### Copy to new variable

partyid <- mydta1$V043116
       
## Can put new symbols in 

levels(partyid) <- c("SD","WD","ILD","II","ILR","WR","SR","O","APol","DK")

###compare with

table(partyid, mydta1$V043116)
  
###Note the levels that are not being used. drop them from the factor                  
partyid <- partyid[, drop=TRUE]
### same effect as partyid2 <- factor(partyid2)

table(partyid)

### Get rid of those 5 "O" respondents

partyid[partyid %in% levels(partyid)[8]] <- NA

table(partyid)
### Drop the unused level again
partyid <- partyid[, drop=TRUE]

table(partyid)

##double check coding
table(partyid, mydta1$V043116)

### make it show the NAs
table(partyid, exclude=NULL)

table(partyid, exclude=c("WR"))

library(gmodels)

CrossTable(partyid)


#=============================================================================
#V045026     C6a. Voter: R's vote for President
#=============================================================================
#POST-ELECTION SURVEY:
#IF R VOTED FOR PRESIDENT:
#QUESTION:
#---------
#Who did you vote for?
#VALID CODES:
#------------
#1. John Kerry
#3. George W. Bush
#5. Ralph Nader
#7. Other {SPECIFY}
#MISSING CODES:
#--------------
#8. Don't know
#9. Refused
#INAP. 5,8,9 in C1a or 1-3,8,9 in C1b; 5,8,9 in C6; no post IW
#TYPE:
#-----
#Numeric  Dec 0
#.         377
#1         399
#3         412
#5           4
#7           8
#9          12



presch <- mydta1$V045026

table(presch)

presch <- presch[ , drop=T]

table(presch, partyid)

prop.table(table(presch, partyid), 2)

library(memisc)

mytab <- genTable(percent(presch)~ partyid )
mytab

mytab <- genTable(round(percent(presch),2)~ partyid )
mytab
toLatex(mytab)


#=============================================================================
#V043250 Y1x. Summary: Respondent age
#=============================================================================
#PRE-ELECTION SURVEY:
#QUESTION:
#---------
#SUMMARY: RESPONDENT AGE
#VALID CODES:
#------------
#17-90
#MISSING CODES:
#--------------
#98. DK
#99. RF
#00. NA
#NOTES:
#------
#Age was calculated by subtracting the year of birth from
#2004. For cases where R refused to give year of birth or
#year of birth was NA in the survey variable, a check was
#made of Household listing information: if age of R was
#included in the Household listing, it was included here.
#TYPE:
#-----
#Numeric Dec 0


attributes(mydta1$V043250)

hist(mydta1$V043250)

table(mydta1$V043250)

table(mydta1$V043250,exclude=NULL)
