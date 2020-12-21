##stackoverflow

library(lattice)
#set up some simplified data
x <- seq(-.8, .8, .1)
y <- seq(-.8, .8, .1)
myGrid <- data.frame(expand.grid(x,y))
colnames(myGrid) <- c("x","y")
myGrid$z <- myGrid$x + myGrid$y
noise <- rnorm(length(myGrid$z),.3,.2)
myGrid$z2 <- myGrid$x + myGrid$y + noise


wireframe(myGrid$z ~ myGrid$x * myGrid$y, xlab="X", ylab="Y", zlab="Z")


cloud(myGrid$z2 ~ myGrid$x * myGrid$y, xlab="X", ylab="Y", zlab="Z")



mypanel <- function(x,y,z,z2,...) {
  panel.wireframe(x,y,z,...)
  panel.cloud(x,y,z2,...)
}
wireframe(z ~ x * y, data=myGrid, xlab="X", ylab="Y", zlab="Z",
          panel=mypanel, z2=myGrid$z2)


library(rockchalk)
dat <- genCorrelatedData(100, stde=5)
m1 <- lm(y ~ x1 + x2, data=dat)
summary(m1)

dats <- summarize(dat, sumstat=F)
m1.pm <- predictOMatic(m1, fl=list(x1=dats$numerics[,"x1"], x2=dats$numerics[, "x2"]))


cloud(y ~ x1 * x2, data=dat, xlab="X1", ylab="X2", zlab="Y")

wireframe(fit ~ x1 * x2, data=m1.pm, xlab="X1", ylab="X2", zlab="Y")


mypanel <- function(x,y,z,z2,...) {
  panel.wireframe(x,y,z,...)
  panel.cloud(x,y,z2,...)
}


##http://www.oga-lab.net/RGM2/func.php?rd_id=latticeExtra:panel.3dmisc
panel.3dbars
panel.3dpolygon

library(lattice)


     cloud(VADeaths, panel.3d.cloud = panel.3dbars,
           col.facet = "grey", xbase = 0.4, ybase = 0.4,
           screen = list(z = 40, x = -30))

     cloud(VADeaths, panel.3d.cloud = panel.3dbars,
           xbase = 0.4, ybase = 0.4, zlim = c(0, max(VADeaths)),
           scales = list(arrows = FALSE, just = "right"), xlab = NULL, ylab = NULL,
           col.facet = level.colors(VADeaths, at = do.breaks(range(VADeaths), 20),
                                    col.regions = terrain.colors,
                                    colors = TRUE),
           colorkey = list(col = terrain.colors, at = do.breaks(range(VADeaths), 20)),
           screen = list(z = 40, x = -30))


     cloud(as.table(prop.table(Titanic, margin = 1:3)[,,,2]),
           type = c("p", "h"),
           zlab = "Proportion\nSurvived",
           panel.3d.cloud = panel.3dbars,
           xbase = 0.4, ybase = 0.4,
           aspect = c(1, 0.3),
           scales = list(distance = 2),
           panel.aspect = 0.5)








# http://www.statmethods.net/advgraphs/trellis.html
## Trellis Examples
library(lattice)
attach(mtcars)

# create factors with value labels
gear.f<-factor(gear,levels=c(3,4,5),
   labels=c("3gears","4gears","5gears"))
cyl.f <-factor(cyl,levels=c(4,6,8),
   labels=c("4cyl","6cyl","8cyl"))

# kernel density plot
densityplot(~mpg,
   main="Density Plot",
   xlab="Miles per Gallon")

# kernel density plots by factor level
densityplot(~mpg|cyl.f,
   main="Density Plot by Number of Cylinders",
   xlab="Miles per Gallon")

# kernel density plots by factor level (alternate layout)
densityplot(~mpg|cyl.f,
   main="Density Plot by Numer of Cylinders",
   xlab="Miles per Gallon",
   layout=c(1,3))

# boxplots for each combination of two factors
bwplot(cyl.f~mpg|gear.f,
   ylab="Cylinders", xlab="Miles per Gallon",
   main="Mileage by Cylinders and Gears",
   layout=(c(1,3)))

# scatterplots for each combination of two factors
xyplot(mpg~wt|cyl.f*gear.f,
   main="Scatterplots by Cylinders and Gears",
   ylab="Miles per Gallon", xlab="Car Weight")

# 3d scatterplot by factor level
cloud(mpg~wt*qsec|cyl.f,
   main="3D Scatterplot by Cylinders")

# dotplot for each combination of two factors
dotplot(cyl.f~mpg|gear.f,
   main="Dotplot Plot by Number of Gears and Cylinders",
   xlab="Miles Per Gallon")

# scatterplot matrix
splom(mtcars[c(1,3,4,5,6)],
   main="MTCARS Data")






                                        # https://stat.ethz.ch/pipermail/r-help/2009-February/189288.html

# sundar

library(lattice)
x <- seq(-2, 2, length = 20)
y <- seq(-2, 2, length = 20)
grid <- expand.grid(x=x, y=y)
grid$z <- dnorm(grid$x) * dnorm(grid$y)
contourplot(z ~ x * y, grid,
            panel = function(at, lty, col, ...) {
              at.o <- at[seq(1, length(at), 2)]
              at.e <- at[seq(2, length(at), 2)]
              panel.contourplot(at = at.o, lty = 1, col = "blue", ...)
              panel.contourplot(at = at.e, lty = 4, col = "red", ...)
            },
            at = pretty(grid$z, 10))



http://stackoverflow.com/questions/1406202/plotting-a-wireframe-and-a-cloud-with-lattice-in-r

library(lattice)
#set up some simplified data
x <- seq(-.8, .8, .1)
y <- seq(-.8, .8, .1)
myGrid <- data.frame(expand.grid(x,y))
colnames(myGrid) <- c("x","y")
myGrid$z <- myGrid$x + myGrid$y
noise <- rnorm(length(myGrid$z),.3,.2)
myGrid$z2 <- myGrid$x + myGrid$y + noise


wireframe(myGrid$z ~ myGrid$x * myGrid$y, xlab="X", ylab="Y", zlab="Z")

cloud(myGrid$z2 ~ myGrid$x * myGrid$y, xlab="X", ylab="Y", zlab="Z")


mypanel <- function(x,y,z,...) {
  panel.wireframe(x,y,z,...)
  panel.cloud(x,y,z,...)
}
wireframe(myGrid$z2 ~ myGrid$x * myGrid$y, xlab="X", ylab="Y", zlab="Z",
          panel=mypanel)


mypanel <- function(x,y,z,z2,...) {
  panel.wireframe(x,y,z,...)
  panel.cloud(x,y,z2,...)
}

wireframe(z ~ x * y, data=myGrid, xlab="X", ylab="Y", zlab="Z",
          panel=mypanel, z2=myGrid$z2)

wireframe(z ~ x * y, data=myGrid, xlab="X", ylab="Y", zlab="Z")

#####################




# http://stackoverflow.com/questions/5397670/how-to-preserve-scale-of-rotated-lattice-cloud-scatter-plot

require ("rgl")

df <- data.frame(x=runif(10,0,1), y=runif(10,0,1), z=runif(10,0,1), color=round(runif(10,1,3)))

plot3d(df$x, df$y, df$z, col=df$color, size=2, type='s')

?movie3d()

demo(flag)

test <- spin3d(rpm=6,axis=c(0,0,1))
?spin3d

open3d()
plot3d(oh3d(col="lightblue", alpha=0.5))
play3d(spin3d(axis=c(0,0,1), rpm=10), duration=23)


open3d()
plot3d( cube3d(col="green") )
M <- par3d("userMatrix")
play3d( par3dinterp( userMatrix=list(M,
                                 rotate3d(M, pi/2, 1, 0, 0),
                                 rotate3d(M, pi/2, 0, 1, 0) ) ),
    duration=4 )

movie3d( spin3d(), duration=5 )



       ##############################
#http://code.google.com/p/playwith/wiki/Screenshots
cloud(-depth ~ long * lat, quakes, zlab = "altitude")

library(playwith)
library(lattice)

