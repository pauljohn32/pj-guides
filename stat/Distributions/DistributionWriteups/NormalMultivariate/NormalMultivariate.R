### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.T10301/lyx_tmpbuf2/NormalMultivariate.Rnw'

###################################################
### code chunk number 1: NormalMultivariate.Rnw:16-17
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: NormalMultivariate.Rnw:92-94
###################################################
unlink("plots", recursive=T)
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(width=100, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
set.seed(12345)
op <- par() 
options(SweaveHooks=list(fig=function() par(ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: 0
###################################################


library(mvtnorm)





N <- 100



meanX <- c( 0, 0 )

varX <- matrix ( c( 1, 0, 0, 1), nrow=2 , byrow = TRUE) 



x1 <- seq( meanX[1]-3*varX[1,1], meanX[1]+3*varX[1,1], length.out=N)

x2 <- seq(  meanX[2]-3*varX[2,2], meanX[2]+3*varX[2,2] , length.out=N)





myProbX <- function(x1, x2){

  dmvnorm( cbind(x1,x2), mean = meanX, sigma= varX)  

}







###################################################
### code chunk number 5: 1
###################################################


probX <- outer(x1,x2, FUN="myProbX")

persp(x1,x2, probX, theta = 140, phi = 10, zlim=c(0,.25), xlab="y1",ylab="y2", zlab="probability", ticktype="detailed")



###################################################
### code chunk number 6: NormalMultivariate.Rnw:372-376
###################################################
#image(x1, x2, probX, col = terrain.colors(100), axes = FALSE)

contour(x1,x2,probX)



###################################################
### code chunk number 7: NormalMultivariate.Rnw:395-415
###################################################


meanX <- c( 0, 0 )

varX <- matrix ( c( 1, 0, 0, 3), nrow=2 , byrow = TRUE) 

 

x1 <- seq( meanX[1]-2.5*varX[1,1], meanX[1]+2.5*varX[1,1], length.out=N)

x2 <- seq(  meanX[2]-2.5*varX[2,2], meanX[2]+2.5*varX[2,2] , length.out=N)





probX <- outer(x1,x2, FUN="myProbX")

persp(x1,x2, probX, theta = 120, phi = 15, zlim=c(0,.25), col = "pink", xlab="y1",ylab="y2", zlab="probability",ticktype="detailed")



###################################################
### code chunk number 8: NormalMultivariate.Rnw:435-455
###################################################


meanX <- c( 0, 0 )

varX <- matrix ( c( 1, .8, .8, 1), nrow=2 , byrow = TRUE) 



x1 <- seq( meanX[1]-2.5*varX[1,1], meanX[1]+2.5*varX[1,1], length.out=N)

x2 <- seq(  meanX[2]-2.5*varX[2,2], meanX[2]+2.5*varX[2,2] , length.out=N)





probX <- outer(x1,x2, FUN="myProbX")

persp(x1,x2, probX, theta = 120, phi = 20, zlim=c(0,.25), zlab="probability", xlab="y1",ylab="y2",col = "pink", ticktype="detailed")



###################################################
### code chunk number 9: NormalMultivariate.Rnw:464-468
###################################################
#image(x1, x2, probX, col = terrain.colors(100), axes = FALSE)

contour(x1,x2,probX)



###################################################
### code chunk number 10: 3
###################################################
meanX <- c( 0, 0 )

varX <- matrix ( c( 1, 0, 0, 1), nrow=2 , byrow = TRUE) 

x1 <- seq( meanX[1]-2.5*varX[1,1], meanX[1]+2.5*varX[1,1], length.out=N)

x2 <- seq(  meanX[2]-2.5*varX[2,2], meanX[2]+2.5*varX[2,2] , length.out=N)



nx2 <- ifelse(x2 <= 0.75, x2, NA)

nx2 <- ifelse(0.65 < nx2, nx2, NA)

probX <- outer(x1,nx2, FUN="myProbX")

persp(x1,x2, probX, theta = 140, phi = 15, zlim=c(0,.25), zlab="probability", xlab="y1",ylab="y2",ticktype="detailed")



