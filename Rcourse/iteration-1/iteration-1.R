### R code from vignette source 'iteration-1n.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: iteration-1n.Rnw:104-105
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 2: Roptions
###################################################
options(width=200, prompt="> ", continue=" ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par()
pjmar <- c(5.1, 4.1, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)
ps.options(horizontal=F, onefile=F, family="Times", paper="special", height=3, width=4.75)
options(papersize="special")


###################################################
### code chunk number 3: rep10
###################################################
doubleMe <- function(input = 0){
  newval <- 2 * input
}
x1 <- vector(mode = "numeric", length = 57)
for(i in 1:57) {x1[i] <- doubleMe(i)}


###################################################
### code chunk number 4: iteration-1n.Rnw:244-246
###################################################
  x2 <- doubleMe(1:57)
  all.equal(x1,x2)


###################################################
### code chunk number 5: apply10
###################################################
xyz <- matrix( rnorm(9), ncol=3)
xyz
colnames(xyz) <- c("x", "y", "z")
apply(xyz, MARGIN = 2, FUN = mean)


###################################################
### code chunk number 6: apply20
###################################################
second <- function(acol = NULL){
    sort(acol)[2]
}
print(xyz)
apply(xyz, MARGIN = 2, FUN = second)


###################################################
### code chunk number 7: normedEntropy
###################################################
divr <- function(p = 0){
  ifelse ( p > 0 & p < 1, -p * log2(p), 0)
}
entropy <- function(p){
    sum( divr(p) )
}
maximumEntropy <- function(N) - log2(1 / N)
normedEntropy <- function(x) entropy(x) / maximumEntropy(length(x))


###################################################
### code chunk number 8: apply30
###################################################
  xmat <- matrix(rmultinom(6, size = 20, prob = c(1,2,3,4,5)), byrow = T, ncol = 5)
  xmat <- prop.table(xmat, 1)
  print(round(xmat,3 ))


###################################################
### code chunk number 9: apply31
###################################################

apply(xmat, MARGIN = 1, FUN = normedEntropy)


###################################################
### code chunk number 10: lapply10
###################################################
sampleList <- lapply(rep(1000,5), rnorm)
sampleList[[1]][888]


###################################################
### code chunk number 11: lapply11
###################################################
mean(sampleList[[1]])
mean(sampleList[[2]])


###################################################
### code chunk number 12: lapply12
###################################################
(aNewList <- lapply(sampleList, mean))


###################################################
### code chunk number 13: lapply15
###################################################

xlist <- list(x1 = c(1,1,1,2,3,3), x2 = rpois(10,lambda=3), x3 = round(rnorm(20,m=100,s=1),0))
elist <- lapply(xlist, function(x) { y <- table(x)/length(x); normedEntropy(y)})


###################################################
### code chunk number 14: lapply18
###################################################
   for(i in 1:length(xlist)){
     cat("Given List")
     print(xlist[[i]])
     cat("Normed Entropy")
     print(round(elist[[i]],3))
     cat("\n")
     }


###################################################
### code chunk number 15: lapply20
###################################################
sampleList <- lapply( rep(1000,5), rnorm)
sampleList[[1]][77] <- NA
(aNewList <- lapply(sampleList, mean))


###################################################
### code chunk number 16: lapply30
###################################################
(aNewList <- lapply(sampleList, mean, na.rm = TRUE))


###################################################
### code chunk number 17: regex05
###################################################
exs <- 10
exq <- 0.345
exstde <- 20
createOneDF <- function(run, s = NA, q = NA, stde = NA){
  x <- 18 + 43*runif(1000)
  y <- s + q * x + rnorm(1000, mean = 0, sd = stde)
  mydf <- data.frame(run,x,y)
}
mydatasets <- lapply(1:100, createOneDF, exs, exq, exstde)


###################################################
### code chunk number 18: regex06
###################################################
myregressions <- lapply(mydatasets, FUN = function(mydf) lm(y ~ x, data = mydf))


###################################################
### code chunk number 19: myregex20
###################################################
head( mydatasets[[33]])


###################################################
### code chunk number 20: myreg30
###################################################
myregressions[[33]]


###################################################
### code chunk number 21: myreg40
###################################################
summary ( myregressions[[33]] )


###################################################
### code chunk number 22: regex50
###################################################
mysummaries <- lapply(myregressions, FUN= summary)


###################################################
### code chunk number 23: regex55
###################################################
myrsq <- lapply(mysummaries, FUN = function(mr) {mr$r.square})
myrsq[1:5]
myrsq <- unlist(myrsq)
str(myrsq)


###################################################
### code chunk number 24: regex60
###################################################
myrsq <- sapply(mysummaries, FUN = function(mr) {mr$r.square})
mean(myrsq)
sd(myrsq)
median(myrsq)


###################################################
### code chunk number 25: regex70
###################################################
h1 <- hist(myrsq, plot = F, breaks = 10)
plot(h1, freq = F, ylim = c(0,1.2* max(h1$density)), xlim = c(0,0.10), xlab = "R-Squares From 100 Regressions")
lines(density(myrsq), lty = 2, col = "red")
legend("topleft", legend = c("observed density"), lty = c(2), col = c("red"))


###################################################
### code chunk number 26: logit10
###################################################

simLogit <- function(myeta){
   mypi <- exp(myeta) / (1 + exp(myeta)) ## SAME AS 1/(1+exp(-myeta))
   myunif <- runif(length(myeta))
   y <- ifelse(myunif < mypi, 1, 0)
}


###################################################
### code chunk number 27: logit20
###################################################
N <- 1000
A <- -1
B <- 0.3
x <- 1 + 10 * rnorm(N)
myeta <- A + B * x
y <- simLogit(myeta)


###################################################
### code chunk number 28: logit30
###################################################
plot(x,y, main = bquote(eta[i] == .(A) +  .(B) * x[i] ))

text ( 0.5*max(x), 0.5, expression( Prob( y[i] == 1) == frac( 1 , 1 + exp(-eta[i] ))))


###################################################
### code chunk number 29: logit35
###################################################

### This calculates just one logistic regression
myglm1 <- glm (y ~ x, family = binomial(link = "logit") )
xr <- range(x)
xseq <- seq(xr[1], xr[2], length = 100)
p1 <- predict(myglm1, newdata = data.frame(x = xseq), type = "response")

plot(x,y, main = bquote(eta[i] == .(A) +  .(B) * x[i] ))

text ( 0.5*max(x), 0.5, expression( Prob( y[i] == 1) == frac( 1 , 1 + exp(-eta[i] ))))
lines(xseq, p1)


###################################################
### code chunk number 30: logit50
###################################################

### This calculates just one logistic regression
myglm1 <- glm ( y ~ x, family = binomial(link = "logit"))
xr <- range(x)
xseq <- seq(xr[1], xr[2], length = 100)
p2 <- predict(myglm1, newdata = data.frame(x = xseq+2.3), type = "response")
plot(x,y, main = bquote(eta[i] == .(A) +  .(B) * x[i] ))

text ( 0.5*max(x), 0.5, expression( Prob( y[i] == 1) == frac( 1 , 1 + exp(-eta[i] ))))
lines(xseq, p1)
lines(xseq, p2,lty = 2)


###################################################
### code chunk number 31: logit60
###################################################
simUnbalanced <- function(iter=0, parm){
  A <- parm$A; B<- parm$B; C<- parm$C; PrFem <- parm$PrFem
  sex <- ifelse(runif(N) < PrFem,0,1)
  myeta <- A + B * x + C * sex
  sex <- factor(sex, levels = c(0,1), labels = c("M","F"))
  y <- simLogit(myeta)
  myglm2 <- glm( y ~ x + sex, family = binomial)
  myglm2sum <- coef(summary(myglm2))
  est <- myglm2sum[3,]
}


###################################################
### code chunk number 32: logit70
###################################################
p <- list()
p$A <- -1; p$B <- 0.3; p$C <- 0.4
p$PrFem <- 0.5
result45 <- list(sapply(1:1000, simUnbalanced, parm = p), parm = p)


###################################################
### code chunk number 33: logit80
###################################################
p$PrFem <- 0.9
result49 <- list(sapply(1:1000, simUnbalanced, parm = p), parm = p)


###################################################
### code chunk number 34: logit90
###################################################

createFigs <- function(result){
  dat <- result[[1]]
  C <- result$parm$C
  PrFem <- result$parm$PrFem
  mybeta <- dat[1,]

  hrow1 <- hist(mybeta, breaks=50, plot=F)
  mybreaks <- hrow1$breaks

  breakMember <- cut(dat[1,], mybreaks)

  mypval <- dat[4,]
  mysignif <- ifelse((mypval < 0.05 ), 1, 0)
  df <- data.frame(mybeta, mypval, mysignif, breakMember)

  propsig <- by(df$mysignif, INDICES = list(df$breakMember), mean, simplify = TRUE)
  mytrat <- dat[3,]
  mycounts <- hrow1$counts
  plot(dat[1,], dat[4,], xlab = "beta estimate", ylab = "estimated p", cex = 0.7, main = paste("True Beta=",C, "Prop. Fem.=", PrFem))
  gc <- c("gray98","gray70","gray50","gray40")

  cut(propsig, breaks=c(-1,0.1,0.5,0.9,1.1))

  catpropsig <- cut(propsig, breaks = c(-1,0.1,0.5,0.9,1.1), ordered = T, labels = c("0","lth","mth","1"))
  barplot(hrow1$density, col = gc[as.numeric(catpropsig)], names = hrow1$mids)
}


###################################################
### code chunk number 35: logit100
###################################################
par(mfrow = c(1,2))
createFigs(result45)


###################################################
### code chunk number 36: logit110
###################################################

par(mfrow = c(1,2))
createFigs(result49)
par(mfrow = c(1,1))


###################################################
### code chunk number 37: poisson10
###################################################
samp <- rpois(20, lambda=3)


###################################################
### code chunk number 38: poisson20
###################################################
median(samp)


###################################################
### code chunk number 39: poisson30
###################################################
calcMed <- function(dat, ind){
  median(dat[ind])
}


###################################################
### code chunk number 40: poisson90
###################################################
library(boot)
bpois <- boot(samp, calcMed, R = 1000)
bpois


###################################################
### code chunk number 41: poisson100
###################################################
  plot(bpois)


