###obtained bank.sav from http://www.wu-wien.ac.at/mathstat/hatz/spss/data/

library(foreign)
#?read.spss
bank <- read.spss("bank.sav", max.value.labels=10)

## to see all the data, type this:
## bank

## to see description of data
## attributes(bank)

## attach is risky, but lets use it anyway because
## we are not doing any assignments
attach(bank)
plot(EDLEVEL,SALBEG,main="Education and Beginning Salary")
##beautify labels
# ?plot
plot(EDLEVEL,SALBEG,main="Education and Beginning Salary in a Bank",xlab="Education (years)",ylab="Entry level salary")

dev.copy2eps(file="BankEdSalBeg.eps",height=6, width=6,horizontal=F,onefile=F)



plot(EDLEVEL,SALNOW,main="Education and Current Salary in a Bank",xlab="Education (years)",ylab="Current salary")
dev.copy2eps(file="BankEdSalCur.eps",height=6,width=6,horizontal=F,onefile=F)



myReg1 <- lm (SALBEG ~ EDLEVEL, data=bank)
summary(myReg1)

##run the plot again
plot(EDLEVEL,SALBEG,main="Education and Beginning Salary in a Bank",xlab="Education (years)",ylab="Entry level salary")

abline(myReg1)
dev.copy2eps(file="BankEdPredSalBeg.eps",height=6,width=6,horizontal=F,onefile=F)

attributes(myReg1)


# This will create a LaTeX table. If you want html, it can do it too
library(xtable)
myReg1.table <- xtable(myReg1)
print(myReg1.table)



##This saves the "x" input matrix
##lm experimentation
#?lm
#myReg1 <- lm (SALBEG ~ EDLEVEL, data=bank, x=T)
#attributes(myReg1)


plot(myReg1$fitted.values,myReg1$residuals,main="Bank Salary: Residuals and fitted values",xlab="fitted (predicted) values", ylab="OLS residuals")

dev.copy2eps(file="BankSalBegResid.eps",height=6, width=6, horizontal=F,onefile=F)

par(ask=T)
plot(myReg1)
par(ask=F)
# Note cases 2, 56, 122 are extreme


postscript(file="myReg1Diag%02d.eps",height=6, width=6,horizontal=F,onefile=F)
plot(myReg1)
dev.off()

## or all on one page
par(mfcol=c(2,2))
plot(myReg1)
dev.copy2eps(file="myReg12by2.eps", horizontal=F)

par(mfcol=c(1,1))



# Now try loess

myReg.lo <- loess(SALBEG~EDLEVEL, data=bank)
##that gave fitting errors
myReg.lo <- loess(SALBEG~EDLEVEL, data=bank, span=0.67, control=loess.control(surface="direct"), family="symmetric")


EDRange <-  seq(min(EDLEVEL),max(EDLEVEL),1)


lo.pred <- predict(myReg.lo,EDRange, se=TRUE)


plot(EDLEVEL,SALBEG,main="Loess: Education and Beginning Salary in a Bank",xlab="Education (years)",ylab="Entry level salary")

lines(EDRange, lo.pred$fit)


dev.copy2eps(file="bankloess1.eps",height=6, width=6, horizontal=F,onefile=F)


lines(EDRange,lo.pred$fit +1.96*lo.pred$se, lty=4)
lines(EDRange,lo.pred$fit -1.96*lo.pred$se, lty=4)

dev.copy2eps(file="bankloess2.eps",height=6, width=6, horizontal=F,onefile=F)


#try lowess
#easier because "lines" works the way I expect
#lowess man page says this is the old fashioned method, so really
#just ought to master loess



## got tired of cutting and pasting big old plot command in, so I wrote
## a function that calls that plot command, making it simpler to do over
## and over
salBegPlot1 <- function(title="") {
          plot(EDLEVEL,SALBEG,main=title,ylab="Entry level salary")
        }


myReg1.low <- lowess(EDLEVEL, SALBEG)
salBegPlot1("Lowess: Education and Salary, f=2/3(default)")
lines(myReg1.low)
dev.copy2eps(file="lowess1.eps",height=6, width=6, horizontal=F,onefile=F)


myReg1.low <- lowess(EDLEVEL, SALBEG,f=.2)
salBegPlot1("Lowess(MASS): Education and Salary, f=.2")
lines(myReg1.low)
dev.copy2eps(file="lowess2.eps",height=6, width=6, horizontal=F,onefile=F)

myReg1.low <- lowess(EDLEVEL, SALBEG,f=.05)
salBegPlot1("Lowess(MASS): Education and Salary, f=.05")
lines(myReg1.low)
dev.copy2eps(file="lowess3.eps",height=6, width=6, horizontal=F,onefile=F)



#SPLINE ALERT
#fit a model with a "knot" at 14
myReg2 <- lm(SALBEG~EDLEVEL*I(EDLEVEL > 14), data=bank)
summary(myReg2)

myReg2Fits <- predict(myReg2,data.frame(EDLEVEL=EDRange),se.fit=T)

salBegPlot1("Linear model with 1 knot at 14: note bozosity b/t 14 & 15")
attributes(myReg2Fits)
lines(EDRange,myReg2Fits$fit)

dev.copy2eps(file="bankShift14.eps",height=5, width=5, horizontal=F,onefile=F)


library(xtable)
myReg2.table <- xtable(myReg2)
print(myReg2.table)




# now focus on the outliers for a while
# Recall the trouble cases: 2, 56, 122
# How to get rid of them?

# I thought bank was a data.frame, but its a list, so

bank2 <- as.data.frame(bank)


# now it will answer commands to select rows
# this kills rows 2  56 122 (preserving numbering)
bank3 <- bank2[-c(2,56,122),]


myReg4 <- lm(SALBEG~EDLEVEL*I(EDLEVEL > 14), data=bank3)
summary(myReg4)


library(xtable)
myReg4.table <- xtable(myReg4)
print(myReg4.table)




myReg4Fits <- predict(myReg4,data.frame(EDLEVEL=EDRange),se.fit=T)

plot(bank3$EDLEVEL,bank3$SALBEG,main="Education and Beginning Salary: cases \
   2, 56, and 122 removed",xlab="Education (years)", ylab="Entry Level Salary")

lines(EDRange,myReg4Fits$fit)

dev.copy2eps(file="bank3SplineOutlier.eps",height=5, width=5, horizontal=F,onefile=F)

# add in se lines

lines(EDRange, myReg4Fits$fit + 2*myReg4Fits$se.fit, col=4, lty=3)
lines(EDRange, myReg4Fits$fit - 2*myReg4Fits$se.fit, col=4, lty=3)

dev.copy2eps(file="bank3SplineOutlierSE.eps",height=5, width=5, horizontal=F,onefile=F)

                                        # CAUTION: notice bogus element in that graph. It should be 2 disjointed
# single straight lines, not a thing that goes in 3 links.

# How to fix that?  Diddle EDRange

myReg4a <- lm(SALBEG~EDLEVEL*I(EDLEVEL > 14), data=bank3,subset=EDLEVEL<= 14)

myReg4b <- lm(SALBEG~EDLEVEL*I(EDLEVEL > 14), data=bank3,subset=EDLEVEL > 14)


plot(bank3$EDLEVEL,bank3$SALBEG,main="Education and Beginning Salary: cases \
   2, 56, and 122 removed",xlab="Education (years)", ylab="Entry Level Salary")

abline(myReg4a)
abline(myReg4b)

text(locator(2),c("I <= 14","I > 14"))
## note, you have to click 2 times in the graph to place these markers
## The program won't continue unless you do


dev.copy2eps(file="bank3SplineOutlier2.eps",horizontal=F,onefile=F)

par(mfcol=c(2,2))
plot(myReg4)

dev.copy2eps(file="bank3SplineDiagPlot.eps",height=9,width=6, horizontal=F,onefile=F)
