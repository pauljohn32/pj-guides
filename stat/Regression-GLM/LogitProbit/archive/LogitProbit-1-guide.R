### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T10208/lyx_tmpbuf2/LogitProbit-1-guide.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: LogitProbit-1-guide.Rnw:26-27
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: LogitProbit-1-guide.Rnw:68-70
###################################################
options(width=60)
system("mkdir plots")


###################################################
### code chunk number 3: LogitProbit-1-guide.Rnw:74-75
###################################################
options(continue=" ") 


###################################################
### code chunk number 4: LogitProbit-1-guide.Rnw:154-158
###################################################
set.seed(44444)
x <- 25:75
p= 1/(1+exp(2-0.05*x))
y <- rbinom(length(x), size=1, prob=p)


###################################################
### code chunk number 5: a (eval = FALSE)
###################################################
## plot(x,y,ylim=c(-.2,1.2),xlab="Normally distributed input", ylab="dichotomous output", type="n")
## points(x,y,pch=16,cex=0.5)


###################################################
### code chunk number 6: LogitProbit-1-guide.Rnw:170-171
###################################################
plot(x,y,ylim=c(-.2,1.2),xlab="Normally distributed input", ylab="dichotomous output", type="n")
points(x,y,pch=16,cex=0.5)


###################################################
### code chunk number 7: LogitProbit-1-guide.Rnw:192-195
###################################################
mod <- lm(y~x)
plot(x,y)
abline(mod)


###################################################
### code chunk number 8: LogitProbit-1-guide.Rnw:211-215
###################################################
x <- seq(0,150,length=200)
expbx <- exp((-1)*(-10+.145*x))
ProbY1 <- 1/(1+expbx)
for (i in 1:200){y[i] <- rbinom(1,1, ProbY1[i]) }


###################################################
### code chunk number 9: LogitProbit-1-guide.Rnw:218-219
###################################################
modl2 <- lm(y~x)


###################################################
### code chunk number 10: LogitProbit-1-guide.Rnw:227-231
###################################################
plot(x, y, ylim=c(-0.3,1.5),type="n");
points(x,y,cex=0.5)
abline(modl2);
lines(c(0,150),c(0,0),lty=c(2)); lines(c(0,150),c(1,1),lty=c(2));


###################################################
### code chunk number 11: LogitProbit-1-guide.Rnw:322-326
###################################################
X2 <- seq(0,150,length=200)
expbx <- exp((-1)*(-10+.115*X2))
ProbY1 <- 1/(1+expbx)
plot(X2,ProbY1,type="l",xlab='X',ylab='Probability(y=1)')


###################################################
### code chunk number 12: landn
###################################################
x <- seq(-6,6, by=0.05)

mylogis111 <- dlogis(x, location = 0, scale = 1, log = FALSE) 

myNorm <- dnorm(x, mean = 0, sd = pi/sqrt(3)) 

matplot(x, cbind(mylogis111, myNorm),type="l",ylim=c(0,0.5), xlab="x", ylab="P(x)", main="") 

normlabel = expression(paste("Normal(",0,",",pi^{2}/3,")"))
legend("topleft", c("Logistic(0,1)",normlabel), lty=1:2, col=1:2) 


