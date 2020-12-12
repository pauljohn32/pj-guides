### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T12888/lyx_tmpbuf0/Ordinal-1.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Ordinal-1.Rnw:31-32
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Ordinal-1.Rnw:498-514
###################################################
library(foreign)
nes2002 <- read.xport("/home/pauljohn/ps/ps707/LogisticRegression/PJTEST.sasxport") 
bushvote <- nes2002$V023111 
bushvote[bushvote>3] <- NA 
bushvote[bushvote==0] <- NA 
bushvote[bushvote==1] <- 0
bushvote[bushvote==3] <- 1
democ <- ifelse(nes2002$V023036==1,1,0) 
repub <- ifelse(nes2002$V023036==2,1,0)
nes2002$V023027[ nes2002$V023027 == 9] <- NA
nes2002$economy <- ordered(nes2002$V023027,labels=c("better","same","worse"))
nes2002$conservatism <- nes2002$V023022
nes2002$democ <- ifelse(nes2002$V023036==1,1,0) 
nes2002$repub <- ifelse(nes2002$V023036==2,1,0)
#library(foreign)
#write.dta(nes2002, file="nes2002.dta")


###################################################
### code chunk number 3: Ordinal-1.Rnw:525-526
###################################################
with(nes2002, prop.table(table(economy,conservatism), margin = 2))


###################################################
### code chunk number 4: Ordinal-1.Rnw:546-549
###################################################
library (MASS) 
polr1 <- polr(economy~conservatism, data=nes2002, Hess=T)
summary(polr1)


###################################################
### code chunk number 5: Ordinal-1.Rnw:809-810
###################################################
library(rms)


###################################################
### code chunk number 6: Ordinal-1.Rnw:812-815
###################################################

lrm1 <- lrm(economy~conservatism, data=nes2002)
lrm1


###################################################
### code chunk number 7: Ordinal-1.Rnw:837-841
###################################################
newds <- polr1$model
newds$polr1p1 <- predict(polr1)
(t1 <- table(newds$polr1p1))
prop.table(table(newds$polr1p1, newds$conservatism), 2)


###################################################
### code chunk number 8: Ordinal-1.Rnw:859-860
###################################################
table(newds$polr1p1, newds$economy)


###################################################
### code chunk number 9: Ordinal-1.Rnw:868-871
###################################################
newds$polr1p2 <- predict(polr1, type="p")
colnames(newds)
newds[1:5, ]


###################################################
### code chunk number 10: Ordinal-1.Rnw:880-883
###################################################
library (MASS) 
polr2 <- polr(economy~conservatism+repub+democ+V023010 + as.factor(V023131), data=nes2002, Hess=T)
summary(polr2)


###################################################
### code chunk number 11: Ordinal-1.Rnw:889-895
###################################################
newds <- polr2$model
newds$polr2p1 <- predict(polr2)
(t2 <- table(newds$polr2p1))
table(newds$polr2p1, newds$economy)
newds$polr2p2 <- predict(polr2, type="p")
newds[1:5, ]


###################################################
### code chunk number 12: Ordinal-1.Rnw:899-915
###################################################
library (MASS) 
nes2002$income <- factor(nes2002$V023149, levels=c("1","2","3","4","5","6","7"))
nes2002$income <- as.numeric(levels(nes2002$income))[nes2002$income]
nes2002$income[nes2002$income == 4] <- 3
nes2002$income[nes2002$income == 5] <- 4
nes2002$income[nes2002$income == 6] <- 5
nes2002$income[nes2002$income == 7] <- 6
table(nes2002$income)
race.black <- ifelse(nes2002$V023150 %in% c("1"),1,0)
race.hispanic <- ifelse(nes2002$V023150 %in% c("4"),1,0)
race.white <- ifelse(nes2002$V023150 %in% c("5"),1,0)
table(race.black)
table(race.white)
polr3 <- polr(economy~conservatism+repub+democ+V023010 + as.factor(V023131) + race.black + race.white + race.hispanic + income , data=nes2002, Hess=T)
summary(polr3)



###################################################
### code chunk number 13: Ordinal-1.Rnw:919-925
###################################################
newds <- polr3$model
newds$polr3p1 <- predict(polr3)
(t3 <- table(newds$polr3p1))
table(newds$polr3p1, newds$economy)
newds$polr3p2 <- predict(polr3, type="p")
newds[1:5, ]


###################################################
### code chunk number 14: Ordinal-1.Rnw:936-938
###################################################
(t6 <- with(nes2002, table(conservatism, income )))
prop.table(t6, 2)


