## Paul Johnson
## 2014-07-26

## I wanted to make some plots to illustrate convexity for our stats
## boot camp. I experimented quite a bit, found this was a pretty
## good (frustrating) illustration chore.

## I've left some tedious code here because I don't want to
## go back and fix everything. But you can see improvement in
## style as this goes along.

## There are some possibilities for animation here,
## I need to remember to ask a student to make something neat


outdir <- "../output/"
if(!file.exists(outdir)) dir.create(outdir, recursive = TRUE)

ps.options( horizontal = FALSE, onefile = FALSE, paper = "special",
           family = "Times")
pdf.options(onefile = FALSE, paper = "special",
            family = "Times", height = 5, width = 6)

SAVEME <- TRUE

lambda <- c(1, .7, .3, 0)
xx1 <- expression(paste(lambda * a + (1 - lambda) * b))

## 4 plots to "animate" convexity
if (SAVEME){
    pdf(file = paste0(outdir, "convex1-%d.pdf"))
} else {
    dev.new(height = 5, width = 6)
    par(ask = TRUE)
}

## This uses the "bail out now" approach
for (i in 1:4){
    plot(c(1, 1), c(0, 1), xlim = c(-.1, 1.1), ylim = c(0, .9),
         type="n", ylab = "", xlab= "", axes=F)
    text(x = c(0, 1), y = c(0, 0), c("a", "b"),
         pos = c(2,4), col = c("black", ifelse(i == 1, "gray50", "black")))
    lines( c(0.05, 0.95), c(0,0), col = "gray70")
    if (i != 1) lines( c(0.05, 0.95 * (1 - lambda[i])), c(0,0))

    text(.5, .79, "The convex combination ")
    text(.5, .72, as.expression(xx1), pos = 1)

    j <- 0
    mycol <- ifelse(i == 1, "black", "gray70")
    arrows(x0 = 0.5, y0 = 0.55, x1 = j + 0.07, y1 = 0.1, length = 0.05,
           code = 2, col = mycol)
    text(0.1, .3, expression(lambda == 1), col = mycol)
    if (i == 1) {
        next()
    }
    
    j <- .3
    mycol <- ifelse(i == 2, "black", "gray70")
    arrows(x0 = 0.5, y0 = 0.55, x1 = j + 0.03, y1 = 0.1, length = 0.05,
           code = 2, col = mycol)
    text(j + 0.05, .2, substitute(lambda == AA, list(AA = 1-j)),
         pos = 2, col = mycol)
    text(j, 0, substitute(AA*a + (1-AA)*b, list(AA = 1-j)),
         pos = 3, cex = 0.8, col = mycol)
    if (i == 2) {
        next()
    }
    
    j <-  .7
    mycol <- ifelse(i == 3, "black", "gray70")
    arrows(x0 = 0.5, y0 = 0.55, x1 = j - 0.05, y1 = 0.1, length = 0.05,
           code = 2, col = mycol)
    text(j - 0.08, .2, substitute(lambda == AA, list(AA = 1-j)),
         pos = 2, col = mycol)
    text(j, 0, substitute(AA*a + (1-AA)*b, list(AA = 1-j)), pos = 3,
         cex = 0.8, col = mycol)
    if (i == 3) {
        next()
    }

    j <- 1
    arrows(x0 = 0.5, y0 = 0.55, x1 = j-0.08, y1 = 0.1, length = 0.05, code = 2)
    text(j-0.04, .3, substitute(lambda == AA, list(AA = 1-j)), pos = 2)
}
dev.off()



## 4 plots to "animate" convexity
if (SAVEME){
    pdf(file = paste0(outdir, "convex2-%d.pdf"))
} else {
    dev.new(height = 5, width = 6)
    par(ask = TRUE)
}

lambda <- c(1, 0.7, 0.4, 0)

i <- 1
    ## arrows(x[1], y[1], lambda[i]*x[1] + (1-lambda[i])*x[2],
    ##        lambda[i]*y[1] + (1-lambda[i])*y[2],
    ##        length = 0.05, lwd = 2, code = 0)

    
## now, if i == 2, add this
for (i in 1:4){
    plot(c(0, 1), c(0, 1), xlim = c(-.1, 1.1), ylim = c(-.1, 1.1),
         type="n", ylab = "", xlab= "", axes=F)
    axis(1, pos=0)
    axis(2, pos=0)

    
    text(0.0, 1.0, "Calculation of", pos = 4)
    text(0.0, 0.91, expression(lambda*group("(", list(x[1],y[1]), ")")
                                +(1-lambda)*group("(", list(x[2],y[2]),")")),
                                pos = 4)

    if (i == 1){ 
        text(0.0, 0.83, expression(paste("Traces a line from ", group("(", list(x[1],y[1]),")"))),  pos = 4)
    } else if (i == 4) {
        text(0.0, 0.83, expression(paste("Traces a line to ", group("(", list(x[2],y[2]),")"))),  pos = 4)
    } else {
        text(0.0, 0.83, expression(paste("Traces a line from ", group("(", list(x[1],y[1]),")"), " to ", group("(", list(x[2],y[2]),")"))),  pos = 4)
        
    }
    
    x <- c(0.1, 0.9)
    y <- c(0.2, 0.8)
    points(x, y, pch = 16)
   
    text(x[1], y[1], expression(group("(", list(x[1],y[1]),")")),  pos = 1)
    text(x[2], y[2], expression(group("(", list(x[2],y[2]),")")), pos = 4)
           
    arrows(x[1], 0.7,
           x[1], (1.3)*(y[1]),
           length = 0.05, col = ifelse(i==1, "black", "gray60"))
    
    text(x = x[1],
         1.9*y[1],
         substitute(lambda == AA, list(AA = 1)),
         col = ifelse(i==1, "black", "gray60"), pos = 4)
    
    ## could draw point at point?
    ## points(lambda[i]*x[1] + (1-lambda[i])*x[2],
    ##       lambda[i]*y[1] + (1-lambda[i])*y[2], cex = 0.5)

    ## Had to read an algebra book to draw line in
    ## direction from one point to the other. hence deltax deltay
    ##
    ##line from (xp=[1], 0.7) toward
    if (i == 1) next()

    for(j in 2:i){
        deltay <- (lambda[j]*y[1] + (1-lambda[j])*y[2]) - 0.7
        deltax <- (lambda[j]*x[1] + (1-lambda[j])*x[2]) - x[1]
        slope <- deltay / deltax
        
        arrows(x[1], 0.7,
               x[1] + 0.9*deltax,
               0.7 + slope * 0.9 *(deltax),
               length = 0.05,  col = ifelse(i==j, "black", "gray60"))
        text(x[1] + 0.9*deltax,
             0.7 + slope * 0.9 *(deltax),
             labels = substitute(lambda == AA, list(AA = lambda[j])),
             col = ifelse(i==j, "black", "gray60"), pos = 3)
        
        ## Draw line of progress
        arrows(x[1], y[1],
               lambda[j]*x[1] + (1-lambda[j])*x[2],
               lambda[j]*y[1] + (1-lambda[j])*y[2],
               length = 0.05, lwd = 2, code = 0)
        if(i == j) next()
    }
}
dev.off()



## A convex set: a line between any pair if ellements
## lies within the set
if (SAVEME){
    pdf(file = paste0(outdir, "convex3-%d.pdf"))
} else {
    dev.new(height = 5, width = 6)
    par(ask = TRUE)
}

## Please, somebody. Find me a less tedious way to write out the points and
## lines.  

library(plotrix)
plot(c(0,10), c(0,10), type = "n", main = "A Convex Set", xlab = "", ylab = "")
draw.ellipse(c(5, 5), c(5.5), c(6), c(2), border=1,
             angle=c(35), lty=3)
text(5, 7.5, "X")

text(5.5, 2,  expression(paste("Any convex combination ")), pos = 4)
text(5.5, 1.2, expression(group("(", list(lambda*x[i]+(1-lambda)*x[j],lambda*y[i]+(1-lambda)*y[j]),")")), pos = 4)
text(5.5, 0.4, expression(paste("belongs to X")), pos = 4)

x <- c(4, 5)
y <- c(5, 7)
text(x[1], y[1], expression(group("(", list(x[1],y[1]), ")")), cex = 0.8, pos = 1)
text(x[2], y[2], expression(group("(", list(x[2],y[2]), ")")), cex = 0.8, pos = 2)
points(y ~ x)
lines(y ~ x)

x <- c(5, 9)
y <- c(3.5, 8.8)
text(x[1], y[1], expression(group("(", list(x[3],y[3]), ")")), cex = 0.8, pos = 2)
text(x[2], y[2], expression(group("(", list(x[4],y[4]), ")")), cex = 0.8, pos = 2)
points(y ~ x)
lines(y ~ x)

x <- c(1, 1)
y <- c(2, 4.1)
text(x[1], y[1], expression(group("(", list(x[5],y[5]), ")")), cex = 0.8, pos = 4)
text(x[2], y[2], expression(group("(", list(x[6],y[6]), ")")), cex = 0.8, pos = 4)
points(y ~ x)
lines(y ~ x)
dev.off()


## Now, show importance of convexity in maximization
   

if (SAVEME){
    pdf(file = paste0(outdir, "convex4-%d.pdf"))
} else {
    dev.new(height = 5, width = 6)
    par(ask = TRUE)
}

x <- seq(0.1, 0.9, length.out = 100)
y <- 0.2 + 1.8 * x - 2 * x^2

plot(c(0, 1), c(0, 1), xlim = c(-.1, 1.1),
     ylim = c(-.1, 1.1),  type="n",
     ylab = "", xlab= "", axes=F, main = "A Concave Down Function")
axis(1, pos=0)
axis(2, pos=0)
lines(y ~ x)
mtext(side = 1, line = 0, "All line segments are below f(x)")

points(x[5], y[5])
points(x[50], y[50])
lines(x[c(5, 50)], y[c(5, 50)])

points(x[90], y[90])
points(x[15], y[15])

lines(x[c(15, 90)], y[c(15, 90)])

points(x[20], y[20])
points(x[95], y[95])
lines(x[c(20, 95)], y[c(20, 95)])
dev.off()

