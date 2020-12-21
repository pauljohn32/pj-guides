
##Paul Johnson
## 2011-05-05
## plot the plane of a regression

x <- data.frame(x1=rnorm(100),x2=rpois(100,lambda=4),y=rnorm(100))

m1 <- lm(y ~ x1 + x2, data=x)

#plot(y ~ x1, data=x)
#abline( lm(y~x1,data=x))


par(bg = "white")

x1r <- range(x$x1)

x1seq <- seq(x1r[1], x1r[2], length = 30)

#If x2 is numeric:
x2r <- range(x$x2)
x2seq <- seq(x2r[1], x2r[2], length=30)

## if is factor
##x2seq <- levels(x$x2)


z <- outer(x1seq, x2seq, function(a,b) predict(m1, newdata=data.frame(x1=a,x2=b)))

persp(x=x1seq,y=x2seq, z=z)

persp(x=x1seq,y=x2seq, z=z, zlim=c(-4,4))

## theta and phi control the viewing angle.
## theta moves the viewing angle  left and right
## phi moves it up and down.
persp(x=x1seq,y=x2seq, z=z, zlim=c(-4,4),theta=40)

persp(x=x1seq,y=x2seq, z=z, zlim=c(-4,4),phi=-20)


## After you fiddle theta and phi to suit you,
## then use that angle to impose points into the 3d object.
## the "transd3" function takes 3d points and smashes them
## into the 2d perspective. trans3d needs the perspective
## matrix object, which we get from persp.

## need to grab a perspective matrix object "res" while plotting
res <- persp(x=x1seq,y=x2seq, z=z, zlim=c(-4,4),theta=40, phi=-20)

points(trans3d(x$x1, x$x2, x$y, pmat = res), pch =1, col="red")

vpred <- trans3d(x$x1, x$x2, fitted(m1),   pmat=res)
vobs <- trans3d(x$x1, x$x2, x$y,   pmat=res)
segments(vpred$x, vpred$y, vobs$x, vobs$y, col="red", lty=2)



########################################



nrz <- nrow(z)
ncz <- ncol(z)

# Create a function interpolating colors in the range of specified colors
jet.colors <- colorRampPalette( c("blue", "green") )

# Generate the desired number of colors from this palette
nbcol <- 100
color <- jet.colors(nbcol)

# Compute the z-value at the facet centres
zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]

# Recode facet z-values into color indices
facetcol <- cut(zfacet, nbcol)


persp(x1seq, x2seq, z, col=color[facetcol], phi=30, theta=30)





x1 <- rnorm(100)
x2 <- rpois(100,lambda=4)
logist <- function(x1,x2){
  y <- 1/(1 + exp((-1)*(-3 + 0.6*x1 + .5*x2)))
}
par(bg = "white")
x1r <- range(x1)
x1seq <- seq(x1r[1], x1r[2], length = 30)

#If x2 is numeric:
x2r <- range(x2)
x2seq <- seq(x2r[1], x2r[2], length=30)

## if is factor
##x2seq <- levels(x$x2)


z <- outer(x1seq, x2seq, logist)

persp(x=x1seq,y=x2seq, z=z, theta=-30, zlim=c(-0.2,1.2))
###############################################




nrz <- nrow(z)
ncz <- ncol(z)

# Create a function interpolating colors in the range of specified colors
jet.colors <- colorRampPalette( c("blue", "green") )

# Generate the desired number of colors from this palette
nbcol <- 100
color <- jet.colors(nbcol)

# Compute the z-value at the facet centres
zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]

# Recode facet z-values into color indices
facetcol <- cut(zfacet, nbcol)


persp(x1seq, x2seq, z, col=color[facetcol], phi=30, theta=30)







###############################################

x <- data.frame(x1=rnorm(100),x2=gl(2,50),y=rnorm(100))


m1 <- lm(y ~ x1 + x2, data=x)

plot(y ~ x1, data=x)

abline( lm(y~x1,data=x))



par(bg = "white")

x1r <- range(x$x1)

x1seq <- seq(x1r[1], x1r[2], length = 30)

#x2r <- range(x$x2)
#x2seq <- seq(x2r[1], x2r[2], length=30)

x2seq <- levels(x$x2)


z <- outer(x1seq, x2seq, function(a,b) predict(m1, newdata=data.frame(x1=a,x2=b)))

persp> nrz <- nrow(z)

persp> ncz <- ncol(z)

persp> # Create a function interpolating colors in the range of specified colors
persp> jet.colors <- colorRampPalette( c("blue", "green") )

persp> # Generate the desired number of colors from this palette
persp> nbcol <- 100

persp> color <- jet.colors(nbcol)

persp> # Compute the z-value at the facet centres
persp> zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]

persp> # Recode facet z-values into color indices
persp> facetcol <- cut(zfacet, nbcol)

persp(x=x1seq,y=as.numeric(x2seq), z=z)
