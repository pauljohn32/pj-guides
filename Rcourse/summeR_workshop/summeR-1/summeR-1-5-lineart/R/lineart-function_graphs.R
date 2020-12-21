## Paul Johnson
## 20160503

## Create some line art for illustrating functions

outdir <- "../output/" 
if(!file.exists(outdir)) dir.create(outdir)

x <- seq(0, 30, length.out=10)

y <- seq(0, 30, length.out=10)


pdf.options(height = 5, width = 6, paper = "special", onefile = FALSE, family = "Times")


SAVEME <- TRUE
if (SAVEME) pdf(file = paste0(outdir, "cartesian-1.pdf"),  family="Times")
plot (x, y, type = "n", xlab = "X: a predictor", ylab = "Y: an outcome", axes = FALSE)
axis(1, pos = 0)
axis(2, pos = 0)
points(10, 15, pch = 16)
text(10, 15.4, expression(group("(", list(x[1]==10,y[1]==15),")")), pos = 4)
abline(h = 15, v = 10, lty = 2, lwd = 0.25)
if (SAVEME) dev.off()


##############limits###################################
if (SAVEME) pdf(file = paste0(outdir, "limits-1.pdf"),  family="Times")
x <- seq(0, 500, by = 1)
y <- 4 - 5.3 * (1/x)
plot (x, y, type = "n", xlab = "x", ylab = "y", axes = FALSE, ylim = c(3,5))
axis(1, pos = 3)
axis(2, pos = 0)
lines(y ~ x, lwd = 2)
abline(h = 4, col = "red", lty = 2, lwd = 1.5)
lines(x = c(0, x[51]), y = rep(y[51],2), lty = 2, lwd = 1.5, col = "blue")
lines(x = rep(x[51],2), y = c(y[51],0), lty = 2, lwd = 1.5, col = "blue")
text(x[52], y[30], substitute(group("(", list(x[1]==AA,y[1]==BB),")"), list(AA = x[51], BB = y[51])), pos = 4)

text(200, 4.4, expression(y== 4 - 5.3 %*% (1/x)), cex = 1.15)
if (SAVEME) dev.off()



if (SAVEME) pdf(file = paste0(outdir, "reciprocal-1.pdf"),  family="Times")
op <- par(no.readonly = TRUE)
par("mar" = c(5.1, 4.1, 4.1, 6), xpd = TRUE)
x <- seq(0, 10, length.out = 1000)
y <- (1/x)
plot (x, y, type = "n", xlab = "x", ylab = "y", axes = FALSE, ylim = c(0, 10))
axis(1, pos = 0)
axis(2, pos = 0)
lines(y ~ x, lwd = 2)
text(4, 1.5, expression(f(x) == 1/x), pos = 1)
text(10, 0.1, expression(limit[x %->% infinity] == 0), pos = 4)
if (SAVEME) dev.off()
par(op)




if (SAVEME) pdf(file = paste0(outdir, "calculus-quadratic-%d.pdf"),  family="Times", height = 6, width = 6)
op <- par(no.readonly = TRUE)
par("mar" = c(5.1, 4.1, 4.1, 4.1), xpd = FALSE, pty = "s")
x <- seq(-4, 4, length.out = 100)
y <- 2*x
y2 <- x^2

for ( i in 1:2){
    plot (x, y, type = "n", xlab = "x", ylab = "y", axes = FALSE, ylim = c(-6, 6))
    axis(1, pos = 0, at = c(-4, -2, 2, 4))
    axis(2, pos = 0, at = c(-6, -4, -2, 2, 4, 6))
    lines(y2 ~ x, lwd = 2)
    text(-3.5, 3.5, expression(y == x^2))
    
    points(1, 1, pch = 1)
    points(-2, 4)
    text(-2, 4, expression(group("(", list(-2, 4), ")")), pos = 2)
    
    points(1, 1)
    text(1, 1, expression(group("(", list(1, 1), ")")), pos = 2)
    points(2, 4)
    text(2, 4, expression(group("(", list(2, 4), ")")), pos = 2)
    
    xshort <- c(0.25, 2)
    yshort <- -1 + 2*xshort
    lines(xshort, yshort, col = "blue")
    msg2 <- "tanget at x = 1 has \n slope = 2"
    text(1.25, 1, msg2, pos = 4)
    
    
    xshort <- c(-2, -1.25, -0.5)
    slope <-  2*(xshort[2])
    yshort <- +(xshort[2]^2) + slope *(xshort - xshort[2]) 

    xleft <--1.25
    yleft <- (-1.25)^2
    points(xleft, yleft)
    lines(xshort, yshort, col = "blue")

    text(xleft, yleft, expression(group("(", list(-1.25, 1.5625), ")")), pos = 2)
    msg2 <- "tanget at x = -1.25 \n has slope = -2.5"
    text(-1.25, .7, msg2, pos = 2)
    
    msg3 <- expression(paste("The slope of ", x^2, " is ", 2*x)) 
    text(0.5, -1.5, msg3, pos = 4)
    if (i == 1) next()
### Picture 1 ends there



    lines(y ~ x, lwd = 2, col = "red", lty =2 )
    msg1 <- "slope of curve is 2x \n (the red line)"
    text(2, 3.5, msg1, pos = 4)
    points(1, 2, col = "red")
    lines(c(1, 1), c(1, 2), col = "red", lty = 3 ) 
    lines(c(-1.25, -1.25), c(1.5625, -2.5), col = "red", lty = 3 ) 
    points(-1.25, -2.5, col = "red")
}    
if (SAVEME) dev.off()


if (SAVEME) pdf(file = paste0(outdir, "calculus-quadratic-1b.pdf"),  family="Times", height = 6, width = 6)
op <- par(no.readonly = TRUE)
par("mar" = c(5.1, 4.1, 4.1, 4.1), xpd = FALSE, pty = "s")
plot (x, y, type = "n", xlab = "x", ylab = "y", axes = FALSE, ylim = c(-6, 6))
axis(1, pos = 0)
axis(2, pos = 0, at = c(-6, -4, -2, 1, 2, 4, 6))
lines(y2 ~ x, lwd = 2)
lines(y2 ~ x, lwd = 2, col = "gray70")
text(-3.5, 3.5, expression(y == x^2))

lines(y ~ x, lwd = 2, col = "red", lty =2 )
msg1 <- "slope of curve \n is 2x \n (the red line)"
text(2, 3.5, msg1, pos = 4)
points(1, 2, col = "red")
lines(c(1, 1), c(1, 2), col = "red", lty = 3 ) 
lines(c(-1.25, -1.25), c(1.5625, -2.5), col = "red", lty = 3 ) 
points(-1.25, -2.5, col = "red")

if (SAVEME) dev.off()



if (SAVEME) pdf(file = paste0(outdir, "calculus-max-min-1.pdf"),  family="Times", height = 6, width = 6)
op <- par(no.readonly = TRUE)
par(pty = "s")

x <- seq(-3, 3, length.out = 200)
y <- sin(x)
plot(x, y, type = "l", ylim = c(-1.5, 1.5), bty = "L", xlab = "", ylab = "")
mtext("x", 1, 1)
mtext("y", 2, 1)

lines(c(0.5, 2.5), c(1,1), col = "red")
text(1.5, 1.1, "Maximum: slope tangent line = 0")

lines(c(-2.5, -0.5), c(-1, -1), col = "red")
text(-1.5, -1.1, "Minimum: slope tangent line = 0")
if (SAVEME) dev.off()


if (SAVEME) pdf(file = paste0(outdir, "calculus-max-min-2.pdf"),  family="Times", height = 6, width = 6)
op <- par(no.readonly = TRUE)
par(pty = "s")

x <- seq(-3, 3, length.out = 200)
y <- sin(x)
plot(x, y, type = "l", ylim = c(-1.5, 1.5), bty = "L")

drawPYline <- function (x){
    xshort <- c(x - 0.5, x, x + 0.5)
    slope <-  cos(xshort[2])
    yshort <- +sin(xshort[2]) + slope *(xshort - xshort[2]) 

    xleft <- xshort[2]
    yleft <- sin(xshort[2])
    points(xleft, yleft)
    if (slope == 0) mycol = "red" else mycol = "blue"
    lines(xshort, yshort, col = mycol, lwd = 2)
    ## text(xshort[2], yshort[2], pos = 4, paste("Slope = ", round(slope, 2)))
}

#drawPYline(-1)
#drawPYline(-0.5)
drawPYline(0.6)
drawPYline(1.35)
#drawPYline(-2.75)


lines(c(0.5, 2.5), c(1,1), col = "red")

if (SAVEME) dev.off()


if (SAVEME) pdf(file = paste0(outdir, "calculus-log-1.pdf"),  family="Times", height = 6, width = 6)
op <- par(no.readonly = TRUE)
par(pty = "s")

x <- seq(0.1, 8, length.out = 200)
y <- log(x)
plot(x, y, type = "l", ylim = c(-1.5, 3.5), bty = "L")

drawPYline <- function (x, text = TRUE){
    xshort <- c(x - 0.5, x, x + 0.5)
    slope <-  1/(xshort[2])
    yshort <- log(xshort[2]) + slope *(xshort - xshort[2]) 

    points(xshort[2], yshort[2])
    if (slope == 0) mycol = "red" else mycol = "blue"
    lines(xshort, yshort, col = mycol, lwd = 2)
    if(text) text(xshort[2], yshort[2], pos = 4, paste("Slope at ", xshort[2], " is ", round(slope, 2)))
}

drawPYline(1)
#drawPYline(-0.5)
drawPYline(0.25)
drawPYline(3, text = FALSE)
text(3.3, log(3), pos = 4, paste("Slope at ", 3, " is 1/3"))

drawPYline(6, text = FALSE)
text(6.6, log(6), pos = 1, paste("Slope at ", 6, " is 1/6"))
text(2, 2.5, expression (y == ln(x)))
text(2, 1.5, expression (frac(dy,dx) == 1/x))

if (SAVEME) dev.off()

