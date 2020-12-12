###################################################
### code chunk number 8: persp22
###################################################
matr <- persp(x=x1, y=x2, z=y, xlab="x1", ylab="x2", zlab="y")
for(j in c(1,11,31,41)){
lines(trans3d(x1, x2[j], y[,j], pmat=matr), col="yellow", lwd=3)
}


