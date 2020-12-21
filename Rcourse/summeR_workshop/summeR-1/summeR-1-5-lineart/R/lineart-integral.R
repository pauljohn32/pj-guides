### Paul Johnson July 26, 2014 Revising for Summer camp

### Paul Johnson March 16, 2008

### For demonstration of integrals in math chapter

### How fast are you going == velocity ==  "derivative" 

### How far have you gone == cumulative distance == integral

### Demonstrates interesting uses of postscript(), text, and points.

### One tricky point was figuring out the labels on the first set of plots.
### With speed fixed at 50, it was important that distance show as
### 250, 500, 7500, 1000 miles exactly, and choosing the right position in the
### sequence was important.  Also, to make the sequence stretch from 0 to 20 at
### 0.20 steps requires 101 elements in the sequence.

outdir <- "../output/"
if(!file.exists(outdir)) dir.create(outdir, recursive = TRUE)

ps.options( horizontal = FALSE, onefile = FALSE, paper = "special", family = "Times")
pdf.options(onefile = FALSE, paper = "special", family = "Times")

upperLimit <- seq(0, 20, length.out = 101)

## for the area function, we need this package
library(MASS)

myfun <- function (x) { 50 }

integralis <- sapply( upperLimit, function(x) {area(myfun, 0, x)})

##for an all in one image:

### postscript( file="integral1.eps", width= 4, height=8,onefile=F)
##  par(mfcol=c(2,1))


### for 2 smaller images

### I was a bit surprised that postscript ignores par(mfcol) setting.
SAVEME <- TRUE
### That setting must be device specific
if (SAVEME) pdf(file = paste0(outdir, "integral1-%d.pdf"), width= 5, height=4, onefile=F)

plot(upperLimit, rep(50, length.out=length(upperLimit)), ylim=c(0,60), xlim=c(0,20), type="l", ylab="Speed (miles per hour)", xlab="Time (hours)", axes=F)
axis(1, pos = 0)
axis(2, pos = 0)
text( 6, 40, expression(italic("f(t)")))


plot(upperLimit, integralis, ylab="Distance Traveled (miles)", xlab="Time (hours)", ylim=c(0,1000), xlim=c(0,20), type="l", axes=F)
axis(1, pos = 0)
axis(2, pos = 0)

text(upperLimit[26], integralis[26], as.character( round( integralis[26], 2) ), pos =2, cex = 0.7 )
points(upperLimit[26], integralis[26])

text(upperLimit[51], integralis[51], as.character( round( integralis[51], 2) ), pos =2, cex = 0.7 )
points(upperLimit[51], integralis[51] )

text(upperLimit[76], integralis[76], as.character( round( integralis[76], 2) ), pos =2, cex = 0.7 )
points(upperLimit[76], integralis[76] )

text(upperLimit[length(upperLimit)], integralis[length(upperLimit)], as.character( round( integralis[length(upperLimit)], 2)), pos =2, cex = 0.7 )
points(upperLimit[length(upperLimit)], integralis[length(upperLimit)])
text( 7, 480, expression(italic("F(t)")), pos =3)

dev.off()



myfun <- function (x) {
   y <- 35 + 9.5*sin(x ) + 19 * sin( 0.4*x) 
   y
 }



integralis <- sapply( upperLimit, function(zz) { area(myfun, 0, zz)} )

##postscript( file="integral2%d.eps", width= 5,  height=4.0, onefile=F)
##par(mfcol=c(2,1))
if (SAVEME) pdf( file = paste0(outdir, "integral2-%d.pdf"), width = 5,
                height = 4, onefile=F) else dev.new(height = 4, width = 5)

plot(upperLimit, myfun(upperLimit), ylim = c(0,80), xlim = c(0,20),
     type="l", ylab="Speed (miles per hour)", xlab="Time (hours)", axes=F)
axis(1, pos = 0)
axis(2, pos = 0)
text( 11, 40, expression(italic("f(t)")))




plot(upperLimit, integralis, ylab="Distance Traveled (miles)",
     xlab="Time (hours)", ylim = c(0,1000), xlim = c(0,20), type = "l", axes = F)
axis(1, pos = 0)
axis(2, pos = 0)



text(upperLimit[26], integralis[26],
     as.character( round( integralis[26], 2) ), pos = 2, cex = 0.7 )
points(upperLimit[26], integralis[26])

text(upperLimit[51], integralis[51],
     as.character( round( integralis[51], 2) ), pos = 2, cex = 0.7 )
points(upperLimit[51], integralis[51] )

text(upperLimit[76], integralis[76],
     as.character( round( integralis[76], 2) ), pos = 2, cex = 0.7 )
points(upperLimit[76], integralis[76] )

text(upperLimit[length(upperLimit)], integralis[length(upperLimit)],
     as.character( round( integralis[length(upperLimit)], 2)),
     pos = 2, cex = 0.7 )
points(upperLimit[length(upperLimit)], integralis[length(upperLimit)])

text( 7, 480, expression(italic("F(t)")), pos =3)
dev.off()


##postscript( file="integral3.eps", width= 5,  height=4.0, onefile=F)
if (SAVEME) pdf( file = paste0(outdir, "integral3-%d.pdf"), width = 5, height = 4,
                onefile=F) else dev.new(height = 4, width = 5)


plot(upperLimit, myfun(upperLimit), ylim = c(0,80), xlim = c(0,20),
     type = "l", ylab = "Speed (miles per hour)", xlab = "Time (hours)", axes = FALSE)
axis(1, pos = 0)
axis(2, pos = 0)
text( 11, 40, expression(italic("f(t)")))



lines(x = c(upperLimit[26], upperLimit[26]), y = c(0, myfun(upperLimit[26])), lty = 2)
lines(x = c(upperLimit[51], upperLimit[51]), y = c(0, myfun(upperLimit[51])), lty = 2)

specialX <- upperLimit[26:51]
specialY <- myfun(upperLimit[26:51])

polygon(x = c(specialX[1], specialX, specialX[length(specialX )]),
        y = c(0, specialY, 0), density = c(10))
dev.off()



### Now show the area approximated by rectangles

## postscript( file="integral4.eps", width= 5,  height=4.0, onefile=F)
if (SAVEME) pdf( file = paste0(outdir, "integral4-%d.pdf"), width = 5, height = 4, onefile=F) else dev.new(height = 4, width = 5)


plot(upperLimit, myfun(upperLimit), ylim=c(0,80), xlim=c(0,20), type="l", ylab="Speed (miles per hour)", xlab="Time (hours)", axes=F)
axis(1, pos = 0)
axis(2, pos = 0)
text( 11, 40, expression(italic("f(t)")))


specialX <- upperLimit[seq(26, 51, by=5)]
specialY <- myfun(upperLimit[seq(26, 51, by=5)])


for (i in 1:(length(specialX)-1)){
  polygon( c(specialX[i], specialX[i], specialX[i+1], specialX[i+1]), c(0, specialY[i],specialY[i],0), density=c(5,5,5,5), angle=45-i*90)
}

dev.off()




## postscript( file="integral5.eps", width= 5,  height=4.0, onefile=F)
if (SAVEME) pdf( file = paste0(outdir, "integral5-%d.pdf"), width = 5, height = 4, onefile=F) else dev.new(height = 4, width = 5)


plot(upperLimit, myfun(upperLimit), ylim=c(0,80), xlim=c(0,20), type="l", ylab="Speed (miles per hour)", xlab="Time (hours)", axes=F)
axis(1, pos = 0)
axis(2, pos = 0)
text( 11, 40, expression(italic("f(t)")))


specialX <- upperLimit[seq(26, 51, by=2)]
specialY <- myfun(upperLimit[seq(26, 51, by=2)])


for (i in 1:(length(specialX)-1)){
  polygon( c(specialX[i], specialX[i], specialX[i+1], specialX[i+1]), c(0, specialY[i],specialY[i],0), density=c(5,5,5,5), angle=45-i*90)
}

dev.off()





##postscript( file="integral6.eps", width= 5,  height=4.0, onefile=F)
if (SAVEME) pdf( file = paste0(outdir, "integral6-%d.pdf"), width = 5, height = 4, onefile=F) else dev.new(height = 4, width = 5)


plot(upperLimit, myfun(upperLimit), ylim=c(0,80), xlim=c(0,20), type="l", ylab="Speed (miles per hour)", xlab="Time (hours)", axes=F)
axis(1, pos = 0)
axis(2, pos = 0)
text( 11, 40, expression(italic("f(t)")))


specialX <- upperLimit[seq(26, 51, by = 1)]
specialY <- myfun(upperLimit[seq(26, 51, by = 1)])


for (i in 1:(length(specialX)-1)){
  polygon( c(specialX[i], specialX[i], specialX[i+1], specialX[i+1]), c(0, specialY[i], specialY[i],0), density=c(5,5,5,5), angle=45-i*90)
}

dev.off()
