### R code from vignette source '/home/pauljohn/tmp/lyxtmp/lyx_tmpdir.XM8853/lyx_tmpbuf0/Dirichlet.Rnw'

###################################################
### code chunk number 1: Dirichlet.Rnw:14-15
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: Dirichlet.Rnw:91-93
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
#pjmar <- c(5.1, 4.1, 1.0, 2.1) 
#options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=10)))
options(SweaveHooks=list(fig=function() par(ps=10)))
pdf.options(onefile=F,family="Times",pointsize=10)


###################################################
### code chunk number 4: 1 (eval = FALSE)
###################################################
## library (gtools)
## 
## N <- 100       
## y1 <-seq(0.001, 0.999, length.out=N)
## y2 <-seq(0.001, 0.999, length.out=N)   
## z <- matrix (0,N,N) 
## 
## myz <-function(a1,a2,a3){
##    z <- matrix (NA,N,N)
##    for (i in 1:N) {   
## 
##        for (j in 1:N) {
##          ddirchprob <- ddirichlet( c(y1[i],y2[j],1-y1[i]-y2[j]), c(a1,a2,a3))
##          z[i,j] <- ifelse (y1[i]+y2[j]<1.02, ddirchprob, NA)
##    }
## } 
## z
## }
## 
## z1 <-myz(1,1,1)
## persp(y1,y2,z1, theta = 100, phi = 40, xlab="p1", ylab="p2", zlab="probability", ticktype="detailed")


###################################################
### code chunk number 5: 2
###################################################
library (gtools)

N <- 100       
y1 <-seq(0.001, 0.999, length.out=N)
y2 <-seq(0.001, 0.999, length.out=N)   
z <- matrix (0,N,N) 

myz <-function(a1,a2,a3){
   z <- matrix (NA,N,N)
   for (i in 1:N) {   

       for (j in 1:N) {
         ddirchprob <- ddirichlet( c(y1[i],y2[j],1-y1[i]-y2[j]), c(a1,a2,a3))
         z[i,j] <- ifelse (y1[i]+y2[j]<1.02, ddirchprob, NA)
   }
} 
z
}

z1 <-myz(1,1,1)
persp(y1,y2,z1, theta = 100, phi = 40, xlab="p1", ylab="p2", zlab="probability", ticktype="detailed")


###################################################
### code chunk number 6: Dirichlet.Rnw:366-369
###################################################
z2 <- myz(1,3,3)

persp(y1,y2,z2, theta = 100, phi = 40, xlab="p1", ylab="p2", zlab="probability", ticktype="detailed" )


###################################################
### code chunk number 7: Dirichlet.Rnw:377-380
###################################################
z2 <- myz(1,6,3)

persp(y1,y2,z2, theta = 100, phi = 40, xlab="p1", ylab="p2", zlab="probability", ticktype="detailed")


