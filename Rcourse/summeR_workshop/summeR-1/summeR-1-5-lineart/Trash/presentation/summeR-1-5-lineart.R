### R code from vignette source 'summeR-1-5-lineart-uniquebackupstring.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: tmpout
###################################################
tdir <- "tmpout"
if(!dir.exists(tdir)) dir.create(tdir, showWarnings=FALSE)


###################################################
### code chunk number 2: Roptions
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
### code chunk number 3: empty1
###################################################
plot(x = c(-5, 5), y = c(-10, 20))


###################################################
### code chunk number 4: empty2
###################################################
plot(x = c(-5, 5), y = c(-10, 20), type = "n", axes = FALSE, xlab = "", ylab = "")


###################################################
### code chunk number 5: margins1
###################################################
par(mar = c(5.1, 4.1, 4.1, 2.1), oma = c(2, 2, 2, 2))
plot(c(-5, 5), y = c(-10, 20), type="n", xlab="X", ylab="Y")
text(0 ,5, labels = "Plot Area", col = "red", cex = 3)
box("plot", col="red")
mtext("Figure", side = 1, line=3, adj=1.0, cex=3,   col="blue")
Margins <- par("mar")
Margins <- paste("mar = c(", paste0(Margins, collapse = ","), ")", sep="")
mtext(Margins, side = 3, line = 2, adj = 0.0, cex = 1.5, col = "blue")
box("figure",lty="dashed", col="blue")
box("inner", lty="dotted", col="green")
mtext("Outer Margin Area",
     side = 1, line=0.4, adj=1.0, cex=1.5, col="green", outer=TRUE)
box("outer", lty="solid", col="green")

OuterMargins <- par("oma")
OuterMargins <-
       paste("oma = c(", paste(OuterMargins, collapse=","), ")", sep="")
mtext(OuterMargins,
        side = 3, line=0.4, adj=0.0, cex=1.5, col="green", outer=TRUE)


###################################################
### code chunk number 6: summeR-1-5-lineart-uniquebackupstring.Rnw:601-604
###################################################
plot(x = c(-5, 5), y = c(-10, 20), 
    type = "n", xlab = "", ylab = "")
points(x = c(-2, 1, 3), y = c(9, 7, 2))


###################################################
### code chunk number 7: points20
###################################################
plot(x = c(-5, 5), y = c(-10, 20), type = "n", xlab = "", ylab = "")
x <- c(-2, 1, 3)
y <- c(9, 7, 2)
points(x = x, y = y)
## Same result as
## points(x, y)
## because of R positional matches


###################################################
### code chunk number 8: points30
###################################################
bdraw <- function() {
    plot(x = c(-5, 5), y = c(-10, 20), 
        type = "n", xlab = "", ylab = "")
}
bdraw()
points(x = x, y = y)


###################################################
### code chunk number 9: points40
###################################################
bdraw()
points(x = x, y = y, col = "red")


###################################################
### code chunk number 10: points50
###################################################
bdraw()
points(x = x, y = y, col = c("green", "blue", "red"))


###################################################
### code chunk number 11: points60
###################################################
bdraw()
points(x = x, y = y, col = gray.colors(3))


###################################################
### code chunk number 12: points70
###################################################
plot(x = c(-5, 5), y = c(-10, 20), type = "n", xlab = "", ylab = "")
x <- c(-2, 1, 3)
y <- c(9, 7, 2)
points(x = x, y = y, cex = c(1, 2, 3), col = c("orange", "red", "deeppink"))


###################################################
### code chunk number 13: summeR-1-5-lineart-uniquebackupstring.Rnw:722-723
###################################################
plot(y ~ x, axes = FALSE, xlab = "", ylab = "")


###################################################
### code chunk number 14: arrows10
###################################################
bdraw()
arrows(x0 = -1, y0 = -1, x1 = 2, y1 = 4)


###################################################
### code chunk number 15: arrows20
###################################################
bdraw()
arrows(x0 = -1, y0 = -1, x1 = 2, y1 = 4, length = 0.1)


###################################################
### code chunk number 16: arrows40
###################################################
bdraw()
# code 3 is both ways
arrows(x0 = -1, y0 = -1, x1 = 2, y1 = 4, length = 0.1, code = 3)
# code 2 points forwards
arrows(x0 = -4, y0 = -4, x1 = -2, y1 = 4, length = 0.3, code = 2)
# code 1 is backwards
arrows(x0 = 4.5, y0 = -8, x1 = -3, y1 = 18, length = 0.15, code = 1)


###################################################
### code chunk number 17: arrows50
###################################################
x0 <- c(-1, -4, 4.5)
y0 <- c(-1, -4, -8)
x1 <- c(2, -2, -3)
y1 <- c(4, 4, 18)
mylengths <- c(0.2, 0.3, 0.15)
mycodes <- c(3, 2, 1)
bdraw()
arrows(x0 = x0, y0 = y0, x1 = x1, y1 = y1, length = mylengths, code = mycodes)


###################################################
### code chunk number 18: text10
###################################################
x <- c(-1, 2, 1, 3); y <- c(8, -3, 6, 1)
labels <- c("Stallone", "Schwartzenegger", "Redford", "Hoffman")
mycolors <- rainbow(4)
bdraw()
points(x, y)
text(x = x, y = y, labels = labels, col = mycolors, cex = c(1.2, 1.7, 1.3, 1))


###################################################
### code chunk number 19: text30
###################################################
bdraw()
points(x, y)
text(x = x, y = y, labels = labels, col = mycolors, cex = c(1.2, 1.7, 1.3, 1), pos = 3)


###################################################
### code chunk number 20: text40
###################################################
bdraw()
points(x, y)
text(x = x, y = y, labels = labels, col = mycolors, cex = c(1.2, 1.7, 1.3, 1), pos = 1, offset = 0.7)


###################################################
### code chunk number 21: curve10
###################################################
curve(exp(x), from = -2, to = 5, xlab = "Don't set x max too large", main = "The exponential function")


###################################################
### code chunk number 22: curve20
###################################################
curve(log(x), from = 0.00001, to = 10, xlab = "Note minimum x is 0.00001. Guess why?", main = "log is the natural log in R")


###################################################
### code chunk number 23: curve30
###################################################
curve(log(x), from = 0.00001, to = 10, xlab = "The domain is now -5, 5", main = "Compare exp and log", xlim = c(-5, 5), ylim = c(-12, 20))
curve(exp(x), from = -5, to = 5, add = TRUE)


###################################################
### code chunk number 24: curve31
###################################################
curve(log(x), from = 0.00001, to = 10, xlab = "The domain is now -5, 5", main = "Compare exp and log", xlim = c(-5, 5), ylim = c(-12, 20))
curve(exp(x), from = -5, to = 5, add = TRUE)
abline(v = 0, col = "gray80")
abline(h = 0, col = "gray80")


###################################################
### code chunk number 25: curve40
###################################################
curve(log(x), from = 0.00001, to = 5, xlab = "x", main = "Natural and base 10 log")
curve(log(x, 10), from = 0.00001, to = 5, add = TRUE)


###################################################
### code chunk number 26: curve50
###################################################
curve(log(x), from = 0.00001, to = 5, xlab = "x", main = "Natural and base 10 log")
curve(log(x, 10), from = 0.00001, to = 5, add = TRUE, lty = 2, col = "blue")
text(4, -1, "Dotted is base 10 log")
text(0, 1, "Solid line is natural log", pos = 4)


###################################################
### code chunk number 27: pdf05
###################################################
x <- seq(-3, 3, length.out = 200)
xprob <- dnorm(x, m = 0, s = 1)
plot(xprob ~ x, type = "n", xlab = "Domain of x", ylab = "Probability Density", main = "Normal")
lines(xprob ~ x)


###################################################
### code chunk number 28: pdf10
###################################################
plot(xprob ~ x, type = "l", xlab = "Domain of x", ylab = "Probability Density", main = "Normal")


###################################################
### code chunk number 29: pdf20
###################################################
plot(xprob ~ x, type = "l", xlab = "Domain of x", ylab = "Probability Density", main = "Normal")
x2prob <- dlogis(x, location = 0, scale = 1)
lines(x2prob ~ x, lty = 3, col = "blue")


###################################################
### code chunk number 30: pdf30
###################################################
plot(xprob ~ x, type = "l", xlab = "Domain of x", ylab = "Probability Density", main = "Normal")
x2prob <- dlogis(x, location = 0, scale = 1)
lines(x2prob ~ x, lty = 3, col = "blue")
legend("topleft", legend = c("Normal", "Logistic"), lty = c(1, 3), col = c("black", "blue"))


###################################################
### code chunk number 31: poly10
###################################################
bdraw()
x <- c(-3, -1.5, -1.8, 0, 2, -3)
y <- c(2,   10,    0.5, -8, 5, 2)
polygon(x, y)


###################################################
### code chunk number 32: poly20
###################################################
bdraw()
polygon(x, y, col = "pink", border = "red")


###################################################
### code chunk number 33: poly30
###################################################
bdraw()
polygon(x, y, col = "red", border = "black", density = 10, angle = 0)


###################################################
### code chunk number 34: rect10
###################################################
bdraw()
rect(xleft = -2, ybottom = -6, xright = 3, ytop = 7, col = "blue", border = "black", density = 10, angle = 45)


###################################################
### code chunk number 35: pm10
###################################################
plot(1:10, 1:10, type="n")
text(4, 5, expression(paste(alpha  ," is alpha")))
text(7, 3, expression(paste(beta * alpha, " is beta * alpha")))
text(3, 6, expression(paste(frac(beta, alpha), " is frac(beta,alpha)")))
text(2,9, expression(paste(hat(y)[i] == hat(beta)[0]+hat(beta)[1]*x[1])))


###################################################
### code chunk number 36: summeR-1-5-lineart-uniquebackupstring.Rnw:1143-1148 (eval = FALSE)
###################################################
## plot(1:10, 1:10, type = "n")
## abline(h = 2:9, v = c(3, 5, 7), col = "gray80")
## arrows(x0 = 2, y0 = 3, x1 = 9, y1 = 2, length = 0.1)
## text(3, 7, "Kansas in Summer is like Paris", pos = 4)
## text(3.2, 6.6, "if Paris were hot and humid", pos = 4)


###################################################
### code chunk number 37: sess10
###################################################
sessionInfo()


###################################################
### code chunk number 38: opts20
###################################################
## Don't delete this. It puts the interactive session options
## back the way they were. If this is compiled within a session
## it is vital to do this.
options(opts.orig)
options(par.orig)


