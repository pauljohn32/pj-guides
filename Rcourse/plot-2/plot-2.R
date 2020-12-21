### R code from vignette source 'plot-2n.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: plot-2n.Rnw:83-85
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 2: Roptions
###################################################
options(width=180, prompt="> ", continue=" ")
options(useFancyQuotes = FALSE)
set.seed(12345)
op <- par()
pjmar <- c(5.1, 4.5, 1.5, 2.1)
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
pdf.options(onefile=F,family="Times",pointsize=6)
ps.options(horizontal=F, onefile=F, family="Times", paper="special", height=3.5, width=5.25)
options(papersize="special")


###################################################
### code chunk number 3: sav10 (eval = FALSE)
###################################################
## dev.new()


###################################################
### code chunk number 4: sav15 (eval = FALSE)
###################################################
## dev.new(height = 3, width = 7)


###################################################
### code chunk number 5: sav20 (eval = FALSE)
###################################################
## dev.cur()


###################################################
### code chunk number 6: sav30 (eval = FALSE)
###################################################
## dev.print(paper="letter", height=4, width=4)


###################################################
### code chunk number 7: sav50 (eval = FALSE)
###################################################
## ?Devices


###################################################
### code chunk number 8: sav55 (eval = FALSE)
###################################################
## capabilities()


###################################################
### code chunk number 9: plot-2n.Rnw:316-319 (eval = FALSE)
###################################################
## pdf.options(onefile = FALSE, family = "Times", paper = "special", height = 4, width = 6)
## ps.options(horizontal = FALSE, onefile = FALSE, family = "Times", paper = "special", height = 4, width = 6 )
## options(papersize="special")


###################################################
### code chunk number 10: posts10 (eval = FALSE)
###################################################
## pdf(file = "myimage.pdf")
## ##or postscript(file = "myimage.eps")
## ##"put your plot commands here")
## dev.off()   #vital to save your file!


###################################################
### code chunk number 11: pdf30 (eval = FALSE)
###################################################
## pdf(file = "myfavorite1.pdf", onefile = FALSE, family = "Times", paper = "special", height = 4, width = 6)
## #hist(x) or whatever
## dev.off()


###################################################
### code chunk number 12: pdf31 (eval = FALSE)
###################################################
## pdf(file="myfavorite1.pdf")
## #hist(x) or whatever
## dev.off()


###################################################
### code chunk number 13: pdf32 (eval = FALSE)
###################################################
## pdf(file="myfavorite1.pdf", height=8, width=7)
## #hist(x) or whatever
## dev.off()


###################################################
### code chunk number 14: plot-2n.Rnw:416-420 (eval = FALSE)
###################################################
## SAVEME <- FALSE
## if (SAVEME == TRUE) pdf(file="myfile1.pdf")
## ## your graph code here
## if (SAVEME == TRUE) dev.off()


###################################################
### code chunk number 15: plot-2n.Rnw:441-443 (eval = FALSE)
###################################################
## pdf(file = "myfile1%003d.pdf", onefile =FALSE)
## ## Add other arguments if pdf.options not set previously.


###################################################
### code chunk number 16: plot-2n.Rnw:447-448 (eval = FALSE)
###################################################
## dev.off()


###################################################
### code chunk number 17: pdf70 (eval = FALSE)
###################################################
## for (i in 1:10){
##    fn <- paste("fig", i, ".pdf", sep="")
##    mm <- 3*i; msd <- i^2;
##    mtitle <- paste("Histogram", i, "m =", mm, "sd =", msd)
##    pdf(file = fn)
##    hist(rnorm(1000, mean = 3*i, sd = i^2),  main = mtitle)
##    dev.off()
##   }


###################################################
### code chunk number 18: plot-2n.Rnw:491-492 (eval = FALSE)
###################################################
## par()


###################################################
### code chunk number 19: plot-2n.Rnw:495-496 (eval = FALSE)
###################################################
## par("oma")


###################################################
### code chunk number 20: plot-2n.Rnw:499-500 (eval = FALSE)
###################################################
## par(oma = c(1, 1, 1, 1))


###################################################
### code chunk number 21: plot-2n.Rnw:517-522 (eval = FALSE)
###################################################
## old.par <- par(no.readonly = TRUE)
## ## make your changes to par
## par(xpd = TRUE, mar = c(3, 4, 1, 2))
## ## make desired figure. When done, restore device.
## par(old.par)


###################################################
### code chunk number 22: plot-2n.Rnw:537-540 (eval = FALSE)
###################################################
## par(mfcol = c(3,1))
## 
## par(mfrow = c(3,1))


###################################################
### code chunk number 23: plot-2n.Rnw:543-546 (eval = FALSE)
###################################################
## par(mfcol = c(3, 2))  # Fill columns first
## 
## par(mfrow = c(3, 2))  # Fill rows first


###################################################
### code chunk number 24: mfcol10
###################################################
x <- rpois(1000, lambda = 108);
y <- rnorm(1000, m = x, sd = 10);
par(mfcol = c(1,3))
hist(x, main = "Default hist(x)")
hist(y, main = "Default hist(y)")
plot(x, y, main = "Scatterplot x, y")


###################################################
### code chunk number 25: plot-2n.Rnw:650-651 (eval = FALSE)
###################################################
## example(coplot)


###################################################
### code chunk number 26: layout10
###################################################
mymat <- matrix( c(1, 1, 1, 1), ncol = 2)
layout(mat = mymat)
layout.show(1)


###################################################
### code chunk number 27: layout11
###################################################
mymat <- matrix(c(1,1,1,1), ncol = 2)
layout(mat = mymat)
hist(x,main = "Default hist(x)")


###################################################
### code chunk number 28: layout20
###################################################
mymat <- matrix(c(0,2,1,2), ncol = 2)
layout(mat = mymat)
layout.show(2)


###################################################
### code chunk number 29: layout21
###################################################
layout(mat=mymat)
hist(x, main = "Default hist(x)")
plot(x, y, main = "Scatterplot x, y")


###################################################
### code chunk number 30: layout30
###################################################
mymat <- matrix(c(1,2,4,1,0,0,1,3,5), nrow = 3)
layout(mat = mymat)
layout.show(5)


###################################################
### code chunk number 31: layout31
###################################################
layout(mat = mymat)
hist(x, main = "Default hist(x)")
hist(y, main = "Default hist(y)")
plot(x, y, main = "Scatterplot x, y")
plot(x, y, main = "Top Right Corner of Scatter", xlim = c(mean(x), max(x)), ylim = c(mean(y),max(y)))
plot(x, y, main = "Bottom Left Corner of Scatter", xlim = c(min(x), mean(x)), ylim = c(min(y), mean(y)))


###################################################
### code chunk number 32: plot-2n.Rnw:845-847
###################################################
library(lattice)
load("examples/gss-subset.RData")


###################################################
### code chunk number 33: xyplot10
###################################################
xyplot( hrs1 ~ age | sex , data=dat)


###################################################
### code chunk number 34: xyplot11
###################################################
xy1 <-
xyplot( hrs1 ~ age | sex , data=dat)
print(xy1)


###################################################
### code chunk number 35: lathist30
###################################################
histogram(~income06  | sex, data=dat)


###################################################
### code chunk number 36: lathist31
###################################################
xy1 <-
histogram(~income06  | sex, data=dat)
print(xy1)


###################################################
### code chunk number 37: lathist40
###################################################
histogram(~I(numwomen + nummen)  | sex, data = dat)


###################################################
### code chunk number 38: lathist41
###################################################
xy1<-
histogram(~I(numwomen + nummen)  | sex, data = dat)
print(xy1)


###################################################
### code chunk number 39: lathist50
###################################################
histogram(~I(numwomen+nummen)  | sex, data=dat, xlim=c(0,100))


###################################################
### code chunk number 40: lathist51
###################################################
xy1 <-
histogram(~I(numwomen+nummen)  | sex, data=dat, xlim=c(0,100))
print(xy1)


###################################################
### code chunk number 41: lathist60
###################################################
histogram(~I(numwomen+nummen)  | sex, data=dat, xlim=c(0,100), breaks=100)


###################################################
### code chunk number 42: lathist61
###################################################
xy1 <-
histogram(~I(numwomen+nummen)  | sex, data=dat, xlim=c(0,100), breaks=100)
print(xy1)


###################################################
### code chunk number 43: plot-2n.Rnw:955-957
###################################################
dat$numwomen[dat$numwomen > 100] <- NA
dat$nummen[dat$nummen > 100] <- NA


###################################################
### code chunk number 44: lathist70
###################################################
histogram(~I(numwomen+nummen)  | sex, data=dat, xlim=c(0,100))


###################################################
### code chunk number 45: lathist71
###################################################
xy1 <-
histogram(~I(numwomen+nummen)  | sex, data=dat, xlim=c(0,100))
print(xy1)


###################################################
### code chunk number 46: lathist80
###################################################
histogram(~I(numwomen+nummen)  | sex * sexsex5, data=dat)


###################################################
### code chunk number 47: lathist81
###################################################
xy1 <-
histogram(~I(numwomen+nummen)  | sex * sexsex5, data=dat)
print(xy1)


###################################################
### code chunk number 48: lathist90
###################################################
histogram(~I(numwomen+nummen)  | sexsex5 * sex , data=dat)


###################################################
### code chunk number 49: lathist91
###################################################
xy1 <-
histogram(~I(numwomen+nummen)  | sexsex5 * sex , data=dat)
print(xy1)


###################################################
### code chunk number 50: pm10
###################################################
plot(1:10, 1:10, type="n")
text(4, 5, expression(paste( alpha  ," is alpha")))
text(7, 3, expression(paste( beta * alpha, " is beta * alpha")))
text(3, 6, expression(paste(frac(beta, alpha), " is frac(beta,alpha)")))
text(2,9, expression(paste(y[i] == beta[0]+beta[1]*x[1]+hat(e))))


###################################################
### code chunk number 51: pm11
###################################################
plot(1:10, 1:10, type="n")
text(4, 5, expression(paste( alpha  ," is alpha")))
text(7, 3, expression(paste( beta * alpha, " is beta * alpha")))
text(3, 6, expression(paste(frac(beta, alpha), " is frac(beta,alpha)")))
text(2,9, expression(paste(y[i] == beta[0]+beta[1]*x[1]+hat(e))))


###################################################
### code chunk number 52: pm20
###################################################
x <- 10
plot( 1:10, 1:10, type="n")
anexpression <-   bquote(x == .(x))
text( 4, 5, anexpression)
mnorm <- round(mean(rnorm(1000, m=10, sd=20)), 2 )
text( 7,5, bquote(mu == .(mnorm)))
text(4, 2, bquote(lambda == .(round(mean(rpois(100,lambda=7))))))


###################################################
### code chunk number 53: pm21
###################################################
x <- 10
plot( 1:10, 1:10, type="n")
anexpression <-   bquote(x == .(x))
text( 4, 5, anexpression)
mnorm <- round(mean(rnorm(1000, m=10, sd=20)), 2 )
text( 7,5, bquote(mu == .(mnorm)))
text(4, 2, bquote(lambda == .(round(mean(rpois(100,lambda=7))))))


###################################################
### code chunk number 54: pm90A
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )


###################################################
### code chunk number 55: pm90B
###################################################
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)


###################################################
### code chunk number 56: pm90C
###################################################
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)


###################################################
### code chunk number 57: pm90D
###################################################

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)


###################################################
### code chunk number 58: pm90E
###################################################
### Create a formula for the Normal
normalFormula <- expression (f(x) == frac (1, sigma* sqrt(2*pi)) * e^{~~ - ~~ frac(1,2)~~ bgroup("(", frac(x-mu,sigma),")")^2})
# Draw the Normal formula
text ( mu + 0.5*sigma, max(myDensity)- 0.10 * max(myDensity),  normalFormula, pos=4)


###################################################
### code chunk number 59: pm90F
###################################################

### Theory says we should have 2.5% of the area to the left of: -1.96 * sigma.
### Find the X coordinate of that "critical value"
criticalValue <- mu -1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx <= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 ,
      label=criticalValue, pos=1)


###################################################
### code chunk number 60: pm90G
###################################################

### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx < criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110),col="lightgray" )


###################################################
### code chunk number 61: pm90H
###################################################
### I want to insert annotation about area on left side.
shadedArea <- round(pnorm(mu - 1.96 * sigma, mean=mu, sd=sigma),4)
al1 <- bquote(Prob(x <= .(criticalValue)))
al2 <- bquote(phantom(0) == F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))

### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]


###################################################
### code chunk number 62: pm90H2
###################################################
text(medX, denAtMedX+0.0055, labels = al1)
text(medX, denAtMedX+0.004, labels = al2)
text(medX, denAtMedX+0.0025, labels = al3)

### point from text toward shaded area
arrows( x0 = medX, y0 = myDensity[indexMed]+0.002,
       x1 = mu-2.5 *sigma, y1 = 0.40*myDensity[length(specialX)], length = 0.1)


###################################################
### code chunk number 63: pm90I
###################################################

ss <- 0.1 * max(myDensity)
### Mark interval from mu to mu-1.96*sigma
arrows( x0 = mu, y0 = ss, x1 = mu-1.96*sigma, y1 = ss, code = 3, angle = 90, length = 0.1)
### Put text above interval
text( mu - 2.0*sigma,1.15*ss, bquote(paste(.(criticalValue), phantom(1)==mu-1.96 * sigma,sep="")), pos=4)


###################################################
### code chunk number 64: pm90J
###################################################
criticalValue <- mu +1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx >= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 , label= paste(criticalValue), pos=1)
### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx > criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110), col = "lightgray" )


###################################################
### code chunk number 65: pm90K
###################################################
shadedArea <- round(pnorm(mu + 1.96 * sigma, mean = mu, sd = sigma, lower.tail = F),4)


### Insert simpler comment on right side.

al2 <- bquote(phantom(0) == 1 - F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))


###################################################
### code chunk number 66: pm90L
###################################################
### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]


text(medX, denAtMedX+0.004, labels = al2)
text(medX, denAtMedX+0.0025, labels = al3)

### point from text toward shaded area
arrows(x0 = medX, y0 = myDensity[indexMed]+0.002, x1 = mu+2.5 *sigma, y1 = 0.40*myDensity[length(specialX)] ,   length = 0.1)


###################################################
### code chunk number 67: pm90M
###################################################
ss <- 0.05 * max(myDensity)
### Mark interval from mu to mu+1.96*sigma
arrows(x0 = mu, y0 = ss, x1 = mu+1.96*sigma, y1 = ss, code = 3, angle = 90, length = 0.1)
### Put text above interval
text(mu + 1.96*sigma,1.15*ss, bquote(paste(.(criticalValue), phantom(1)==mu+1.96 * sigma,sep="")), pos=2)


###################################################
### code chunk number 68: pm91
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)
### Create a formula for the Normal
normalFormula <- expression (f(x) == frac (1, sigma* sqrt(2*pi)) * e^{~~ - ~~ frac(1,2)~~ bgroup("(", frac(x-mu,sigma),")")^2})
# Draw the Normal formula
text ( mu + 0.5*sigma, max(myDensity)- 0.10 * max(myDensity),  normalFormula, pos=4)

### Theory says we should have 2.5% of the area to the left of: -1.96 * sigma.
### Find the X coordinate of that "critical value"
criticalValue <- mu -1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx <= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 ,
      label=criticalValue, pos=1)

### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx < criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110),col="lightgray" )
### I want to insert annotation about area on left side.
shadedArea <- round(pnorm(mu - 1.96 * sigma, mean=mu, sd=sigma),4)
al1 <- bquote(Prob(x <= .(criticalValue)))
al2 <- bquote(phantom(0) == F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))

### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]

ss <- 0.1 * max(myDensity)
### Mark interval from mu to mu-1.96*sigma
arrows( x0 = mu, y0 = ss, x1 = mu-1.96*sigma, y1 = ss, code = 3, angle = 90, length = 0.1)
### Put text above interval
text( mu - 2.0*sigma,1.15*ss, bquote(paste(.(criticalValue), phantom(1)==mu-1.96 * sigma,sep="")), pos=4)
criticalValue <- mu +1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx >= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 , label= paste(criticalValue), pos=1)
### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx > criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110), col = "lightgray" )
shadedArea <- round(pnorm(mu + 1.96 * sigma, mean = mu, sd = sigma, lower.tail = F),4)


### Insert simpler comment on right side.

al2 <- bquote(phantom(0) == 1 - F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))
### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]


text(medX, denAtMedX+0.004, labels = al2)
text(medX, denAtMedX+0.0025, labels = al3)

### point from text toward shaded area
arrows(x0 = medX, y0 = myDensity[indexMed]+0.002, x1 = mu+2.5 *sigma, y1 = 0.40*myDensity[length(specialX)] ,   length = 0.1)
ss <- 0.05 * max(myDensity)
### Mark interval from mu to mu+1.96*sigma
arrows(x0 = mu, y0 = ss, x1 = mu+1.96*sigma, y1 = ss, code = 3, angle = 90, length = 0.1)
### Put text above interval
text(mu + 1.96*sigma,1.15*ss, bquote(paste(.(criticalValue), phantom(1)==mu+1.96 * sigma,sep="")), pos=2)


###################################################
### code chunk number 69: pm92AB
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)


###################################################
### code chunk number 70: pm92C
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)


###################################################
### code chunk number 71: pm92D
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)


###################################################
### code chunk number 72: pm92E
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)
### Create a formula for the Normal
normalFormula <- expression (f(x) == frac (1, sigma* sqrt(2*pi)) * e^{~~ - ~~ frac(1,2)~~ bgroup("(", frac(x-mu,sigma),")")^2})
# Draw the Normal formula
text ( mu + 0.5*sigma, max(myDensity)- 0.10 * max(myDensity),  normalFormula, pos=4)


###################################################
### code chunk number 73: pm92F
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)
### Create a formula for the Normal
normalFormula <- expression (f(x) == frac (1, sigma* sqrt(2*pi)) * e^{~~ - ~~ frac(1,2)~~ bgroup("(", frac(x-mu,sigma),")")^2})
# Draw the Normal formula
text ( mu + 0.5*sigma, max(myDensity)- 0.10 * max(myDensity),  normalFormula, pos=4)

### Theory says we should have 2.5% of the area to the left of: -1.96 * sigma.
### Find the X coordinate of that "critical value"
criticalValue <- mu -1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx <= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 ,
      label=criticalValue, pos=1)


###################################################
### code chunk number 74: pm92G
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)
### Create a formula for the Normal
normalFormula <- expression (f(x) == frac (1, sigma* sqrt(2*pi)) * e^{~~ - ~~ frac(1,2)~~ bgroup("(", frac(x-mu,sigma),")")^2})
# Draw the Normal formula
text ( mu + 0.5*sigma, max(myDensity)- 0.10 * max(myDensity),  normalFormula, pos=4)

### Theory says we should have 2.5% of the area to the left of: -1.96 * sigma.
### Find the X coordinate of that "critical value"
criticalValue <- mu -1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx <= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 ,
      label=criticalValue, pos=1)

### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx < criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110),col="lightgray" )


###################################################
### code chunk number 75: pm92H
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)
### Create a formula for the Normal
normalFormula <- expression (f(x) == frac (1, sigma* sqrt(2*pi)) * e^{~~ - ~~ frac(1,2)~~ bgroup("(", frac(x-mu,sigma),")")^2})
# Draw the Normal formula
text ( mu + 0.5*sigma, max(myDensity)- 0.10 * max(myDensity),  normalFormula, pos=4)

### Theory says we should have 2.5% of the area to the left of: -1.96 * sigma.
### Find the X coordinate of that "critical value"
criticalValue <- mu -1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx <= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 ,
      label=criticalValue, pos=1)

### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx < criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110),col="lightgray" )
### I want to insert annotation about area on left side.
shadedArea <- round(pnorm(mu - 1.96 * sigma, mean=mu, sd=sigma),4)
al1 <- bquote(Prob(x <= .(criticalValue)))
al2 <- bquote(phantom(0) == F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))

### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]
text(medX, denAtMedX+0.0055, labels = al1)
text(medX, denAtMedX+0.004, labels = al2)
text(medX, denAtMedX+0.0025, labels = al3)

### point from text toward shaded area
arrows( x0 = medX, y0 = myDensity[indexMed]+0.002,
       x1 = mu-2.5 *sigma, y1 = 0.40*myDensity[length(specialX)], length = 0.1)


###################################################
### code chunk number 76: pm92I
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)
### Create a formula for the Normal
normalFormula <- expression (f(x) == frac (1, sigma* sqrt(2*pi)) * e^{~~ - ~~ frac(1,2)~~ bgroup("(", frac(x-mu,sigma),")")^2})
# Draw the Normal formula
text ( mu + 0.5*sigma, max(myDensity)- 0.10 * max(myDensity),  normalFormula, pos=4)

### Theory says we should have 2.5% of the area to the left of: -1.96 * sigma.
### Find the X coordinate of that "critical value"
criticalValue <- mu -1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx <= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 ,
      label=criticalValue, pos=1)

### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx < criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110),col="lightgray" )
### I want to insert annotation about area on left side.
shadedArea <- round(pnorm(mu - 1.96 * sigma, mean=mu, sd=sigma),4)
al1 <- bquote(Prob(x <= .(criticalValue)))
al2 <- bquote(phantom(0) == F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))

### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]
text(medX, denAtMedX+0.0055, labels = al1)
text(medX, denAtMedX+0.004, labels = al2)
text(medX, denAtMedX+0.0025, labels = al3)

### point from text toward shaded area
arrows( x0 = medX, y0 = myDensity[indexMed]+0.002,
       x1 = mu-2.5 *sigma, y1 = 0.40*myDensity[length(specialX)], length = 0.1)

ss <- 0.1 * max(myDensity)
### Mark interval from mu to mu-1.96*sigma
arrows( x0 = mu, y0 = ss, x1 = mu-1.96*sigma, y1 = ss, code = 3, angle = 90, length = 0.1)
### Put text above interval
text( mu - 2.0*sigma,1.15*ss, bquote(paste(.(criticalValue), phantom(1)==mu-1.96 * sigma,sep="")), pos=4)


###################################################
### code chunk number 77: pm92J
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)
### Create a formula for the Normal
normalFormula <- expression (f(x) == frac (1, sigma* sqrt(2*pi)) * e^{~~ - ~~ frac(1,2)~~ bgroup("(", frac(x-mu,sigma),")")^2})
# Draw the Normal formula
text ( mu + 0.5*sigma, max(myDensity)- 0.10 * max(myDensity),  normalFormula, pos=4)

### Theory says we should have 2.5% of the area to the left of: -1.96 * sigma.
### Find the X coordinate of that "critical value"
criticalValue <- mu -1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx <= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 ,
      label=criticalValue, pos=1)

### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx < criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110),col="lightgray" )
### I want to insert annotation about area on left side.
shadedArea <- round(pnorm(mu - 1.96 * sigma, mean=mu, sd=sigma),4)
al1 <- bquote(Prob(x <= .(criticalValue)))
al2 <- bquote(phantom(0) == F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))

### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]
text(medX, denAtMedX+0.0055, labels = al1)
text(medX, denAtMedX+0.004, labels = al2)
text(medX, denAtMedX+0.0025, labels = al3)

### point from text toward shaded area
arrows( x0 = medX, y0 = myDensity[indexMed]+0.002,
       x1 = mu-2.5 *sigma, y1 = 0.40*myDensity[length(specialX)], length = 0.1)

ss <- 0.1 * max(myDensity)
### Mark interval from mu to mu-1.96*sigma
arrows( x0 = mu, y0 = ss, x1 = mu-1.96*sigma, y1 = ss, code = 3, angle = 90, length = 0.1)
### Put text above interval
text( mu - 2.0*sigma,1.15*ss, bquote(paste(.(criticalValue), phantom(1)==mu-1.96 * sigma,sep="")), pos=4)
criticalValue <- mu +1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx >= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 , label= paste(criticalValue), pos=1)
### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx > criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110), col = "lightgray" )


###################################################
### code chunk number 78: pm92L
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)
### Create a formula for the Normal
normalFormula <- expression (f(x) == frac (1, sigma* sqrt(2*pi)) * e^{~~ - ~~ frac(1,2)~~ bgroup("(", frac(x-mu,sigma),")")^2})
# Draw the Normal formula
text ( mu + 0.5*sigma, max(myDensity)- 0.10 * max(myDensity),  normalFormula, pos=4)

### Theory says we should have 2.5% of the area to the left of: -1.96 * sigma.
### Find the X coordinate of that "critical value"
criticalValue <- mu -1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx <= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 ,
      label=criticalValue, pos=1)

### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx < criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110),col="lightgray" )
### I want to insert annotation about area on left side.
shadedArea <- round(pnorm(mu - 1.96 * sigma, mean=mu, sd=sigma),4)
al1 <- bquote(Prob(x <= .(criticalValue)))
al2 <- bquote(phantom(0) == F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))

### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]
text(medX, denAtMedX+0.0055, labels = al1)
text(medX, denAtMedX+0.004, labels = al2)
text(medX, denAtMedX+0.0025, labels = al3)

### point from text toward shaded area
arrows( x0 = medX, y0 = myDensity[indexMed]+0.002,
       x1 = mu-2.5 *sigma, y1 = 0.40*myDensity[length(specialX)], length = 0.1)

ss <- 0.1 * max(myDensity)
### Mark interval from mu to mu-1.96*sigma
arrows( x0 = mu, y0 = ss, x1 = mu-1.96*sigma, y1 = ss, code = 3, angle = 90, length = 0.1)
### Put text above interval
text( mu - 2.0*sigma,1.15*ss, bquote(paste(.(criticalValue), phantom(1)==mu-1.96 * sigma,sep="")), pos=4)
criticalValue <- mu +1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx >= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 , label= paste(criticalValue), pos=1)
### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx > criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110), col = "lightgray" )
shadedArea <- round(pnorm(mu + 1.96 * sigma, mean = mu, sd = sigma, lower.tail = F),4)


### Insert simpler comment on right side.

al2 <- bquote(phantom(0) == 1 - F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))
### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]


text(medX, denAtMedX+0.004, labels = al2)
text(medX, denAtMedX+0.0025, labels = al3)

### point from text toward shaded area
arrows(x0 = medX, y0 = myDensity[indexMed]+0.002, x1 = mu+2.5 *sigma, y1 = 0.40*myDensity[length(specialX)] ,   length = 0.1)


###################################################
### code chunk number 79: pm92M
###################################################
###Set mu and sigma at your pleasure:
mu <- 10.03
sigma <- 12.5786786

myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

myDensity <- dnorm(myx,mean=mu,sd=sigma)


# It is challenging to combine plotmath with values of mu and sigma in one expression.
# Either bquote or substitute can be used.  First use bquote:

myTitle1 <- bquote (paste("x ~ Normal(", mu== .(round(mu,2)), ',', sigma== .(round(sigma,2)),")") )

### Using substitute:
### myTitle1 <-  substitute( "x ~ Normal" ~~ group( "(", list(mu==mu1, sigma^2==sigma2)#, ")") ,  list(mu1=round(mu,2), sigma2=round(sigma^2,2)))

### Or combine the two:
### t1 <- substitute ( mu == a ,  list (a = mu))
### t2 <- substitute ( sigma == a, list(a = round(sigma,2)))
### myTitle1 <- bquote(paste("x ~ Normal(", .(t1),",", .(t2),")" ) )
### xpd needed to allow writing outside strict box of graph
par(xpd=TRUE, ps=10)

plot(myx, myDensity, type="l", xlab="x", ylab="Probability Density ", main=myTitle1, axes=FALSE)
axis(2, pos= mu - 3.6*sigma)
axis(1, pos=0)
lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes

# bquote creates an expression that text plotters can use
t1 <-  bquote( mu== .(mu))

# Find a value of myx that is "very close to" mu
centerX <- max(which (myx <= mu))
# plot light vertical line under peak of density
lines( c(mu, mu), c(0, myDensity[centerX]), lty= 14, lwd=.2)

# label the mean in the bottom margin
mtext(bquote( mu == .(mu)), 1, at=mu, line=-1)

### find position 20% "up" vertically, to use for arrow coordinate
ss = 0.2 * max(myDensity)
# Insert interval to represent width of one sigma
arrows( x0=mu, y0= ss, x1=mu+sigma, y1=ss, code=3, angle=90, length=0.1)

### Write the value of sigma above that interval
t2 <-  bquote( sigma== .(round(sigma,2)))
text( mu+0.5*sigma, 1.15*ss, t2)
### Create a formula for the Normal
normalFormula <- expression (f(x) == frac (1, sigma* sqrt(2*pi)) * e^{~~ - ~~ frac(1,2)~~ bgroup("(", frac(x-mu,sigma),")")^2})
# Draw the Normal formula
text ( mu + 0.5*sigma, max(myDensity)- 0.10 * max(myDensity),  normalFormula, pos=4)

### Theory says we should have 2.5% of the area to the left of: -1.96 * sigma.
### Find the X coordinate of that "critical value"
criticalValue <- mu -1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx <= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 ,
      label=criticalValue, pos=1)

### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx < criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110),col="lightgray" )
### I want to insert annotation about area on left side.
shadedArea <- round(pnorm(mu - 1.96 * sigma, mean=mu, sd=sigma),4)
al1 <- bquote(Prob(x <= .(criticalValue)))
al2 <- bquote(phantom(0) == F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))

### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]
text(medX, denAtMedX+0.0055, labels = al1)
text(medX, denAtMedX+0.004, labels = al2)
text(medX, denAtMedX+0.0025, labels = al3)

### point from text toward shaded area
arrows( x0 = medX, y0 = myDensity[indexMed]+0.002,
       x1 = mu-2.5 *sigma, y1 = 0.40*myDensity[length(specialX)], length = 0.1)

ss <- 0.1 * max(myDensity)
### Mark interval from mu to mu-1.96*sigma
arrows( x0 = mu, y0 = ss, x1 = mu-1.96*sigma, y1 = ss, code = 3, angle = 90, length = 0.1)
### Put text above interval
text( mu - 2.0*sigma,1.15*ss, bquote(paste(.(criticalValue), phantom(1)==mu-1.96 * sigma,sep="")), pos=4)
criticalValue <- mu +1.96 * sigma
criticalValue <- round(criticalValue, 2)
### Then grab all myx values that are "to the left" of that critical value.
specialX <-  myx[myx >= criticalValue]

### mark the critical value in the graph
text ( criticalValue, 0 , label= paste(criticalValue), pos=1)
### Take sequence parallel to values of myx inside critical region
specialY <- myDensity[myx > criticalValue]
#  Polygon makes a nice shaded illustration
polygon(c(specialX[1], specialX, specialX[length(specialX )]), c(0, specialY, 0), density=c(-110), col = "lightgray" )
shadedArea <- round(pnorm(mu + 1.96 * sigma, mean = mu, sd = sigma, lower.tail = F),4)


### Insert simpler comment on right side.

al2 <- bquote(phantom(0) == 1 - F( .(criticalValue) ))
al3 <- bquote(phantom(0) == .(round(shadedArea,3)))
### Hard to position this text "just right"
### Have tried many ideas, this may be least bad.
### Get center position in shaded area
medX <- median(specialX)
### density at that center point:
denAtMedX <- myDensity[indexMed <- max(which(specialX < medX))]


text(medX, denAtMedX+0.004, labels = al2)
text(medX, denAtMedX+0.0025, labels = al3)

### point from text toward shaded area
arrows(x0 = medX, y0 = myDensity[indexMed]+0.002, x1 = mu+2.5 *sigma, y1 = 0.40*myDensity[length(specialX)] ,   length = 0.1)
ss <- 0.05 * max(myDensity)
### Mark interval from mu to mu+1.96*sigma
arrows(x0 = mu, y0 = ss, x1 = mu+1.96*sigma, y1 = ss, code = 3, angle = 90, length = 0.1)
### Put text above interval
text(mu + 1.96*sigma,1.15*ss, bquote(paste(.(criticalValue), phantom(1)==mu+1.96 * sigma,sep="")), pos=2)


