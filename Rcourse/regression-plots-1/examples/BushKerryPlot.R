library(foreign)
mydta1 <- read.dta("../04245-0001-Data.dta")


## V043038     B1a. Feeling Thermometer: GW Bush
## V043039     B1b. Feeling Thermometer: John Kerry

## V043210     R1. R position on gay marriage

## V043213     S3. National economy better/worse since GW Bush took ofc

## V045117     G4a. Liberal/conservative 7-point scale: self-placement

## V045145x    H5x. Summary: Pre-Post US flag makes R feel

## V041109a    HHListing.9a. Respondent gender

##      J1x. Summary: R party ID

## V043250     Y1x. Summary: Respondent age



#Surprise
plot(V043038, V043039)


mydta1$th.bush.kerry <- mydta1$V043038 - mydta1$V043039

plot(th.bush.kerry~V043039, data=mydta1)


mydta1$V045117 <- factor(mydta1$V045117)
table(mydta1$V045117)




##Party
mydta1$V043116 <- mydta1$V043116[,drop=T]
levels(mydta1$V043116) <- c("SD","WD","ID","I","IR","WR","SR","O")
mydta1$V043116[ mydta1$V043116 %in% levels(mydta1$V043116)[8] ] <- NA
mydta1$V043116 <- mydta1$V043116[,drop=T]
table(mydta1$V043116)

##IDEO
mydta1$V045117 <- mydta1$V045117[ ,drop=T]
levels(mydta1$V045117) <- c("EL","L","SL","M","SC","C","EC")
table(mydta1$V045117)

##Gender
levels(mydta1$V041109A) <- c("M","F")


## Gay Marriage
levels(mydta1$V043210) 
mydta1$V043210[ mydta1$V043210 %in% levels(mydta1$V043210)[4:10] ] <-NA  
mydta1$V043210 <- mydta1$V043210[, drop=T]
levels(mydta1$V043210) <- c("Allow","No","Med") 



mydta1$V043116n <- as.numeric(mydta1$V043116)
plot(th.bush.kerry ~ V043116n, data=mydta1)
mod0 <- lm(th.bush.kerry ~ V043116n, data=mydta1)
abline(mod0)
mod0f <- lm(th.bush.kerry ~ V043116, data=mydta1)
plot(th.bush.kerry ~ V043116, data=mydta1)
abline(mod0)







mod1 <- lm (th.bush.kerry ~ V045117 + V043116 + V043210 + V043213 + V045145X + V041109A, data=mydta1)
summary(mod1)




plot(  th.bush.kerry ~ V045145X, data=mydta1 )

gender1 <- lm (th.bush.kerry ~ V041109A, data=mydta1)

gender2 <- lm (th.bush.kerry ~ V041109A + V045117, data=mydta1)

gender3a <- lm(th.bush.kerry ~ V041109A + V043116, data=mydta1)
gender3b <- lm(th.bush.kerry ~ V041109A + as.numeric(V043116), data=mydta1)
anova(gender3a, gender3b)

coplot(th.bush.kerry ~ V043116 | V041109A, data=mydta1)




mod1age <- lm(th.bush.kerry~V043250, data=mydta1)
mod2age <- lm(th.bush.kerry~V043250 + V041109A, data=mydta1)
mod3age <- lm(th.bush.kerry~V043250 * V041109A, data=mydta1)

ar <- range(mydta1$V043250)
aseq <- seq(ar[1],ar[2],length.out=5)
newdf1 <- expand.grid(V043250=aseq, V041109A=levels(mydta1$V041109A))
newdf1
newdf1$p1 <- predict(mod2age, newdata=newdf1)
plot(th.bush.kerry ~ V043250, type="n", data=mydta1,xlab="Age (years)",ylab="Bush-Kerry Thermometer Differential")
mycols <- c(gray(.6), rgb(0.8,0.2,0.2),"black","red")

points(th.bush.kerry ~ V043250,data=mydta1,  col=ifelse(V041109A %in% c("M"),mycols[1], mycols[2]))
by(newdf1, newdf1$V041109A, function(x) lines(p1~V043250,data=x, col=mycols[2+as.numeric(x$V041109A)], lty=as.numeric(x$V041109A),lwd=3 ))
legend("topleft",legend=c("Male","Female"),col=mycols[3:4],lty=c(1,2),bg="white",lwd=3)




mod1 <- lm (th.bush.kerry ~ V045117 + V043116 + V043210 + V043213 + V045145X + V041109A, data=mydta1)
outreg(mod1)


library(effects)

mod1.ae <- allEffects(mod1)
plot(mod1.ae, "V041109A")

termplot(mod1, terms="V041109A")
termplot(mod1, terms="V041109A", partial.resid=T, se=T)


termplot(mod1, partial.resid=T, se=T)
