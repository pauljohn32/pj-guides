## Paul Johnson
##
## Just some random data with models plotted so I could
## make a lecture 
b0 <- 1
b1 <- 4

x <- rnorm(100)
e <- rnorm(100)

y <- b0 + b1 *x  + 8*e

x11(height=6,width=6)
mytitle<- paste("Linear Model With Error")

plot(x,y,main=mytitle)


modl1 <- lm(y~x)


abline(modl1)

newx <- seq(min(x),max(x),length.out=20)

pred1 <- predict(modl1,se=T,newdata=data.frame(x=newx))

#can manually produce "confidence intervals" for means
lines(newx,pred1$fit+1.95*pred1$se.fit,col="red",lty=5)
lines(newx,pred1$fit-1.95*pred1$se.fit,col="red",lty=5)

mtext(side=3,text=expression(paste("true model:  " , ~~ y[i] == 1 + 4 ~~ x[i]  +  e[i] ," , ",s.d.(e) == 8)))

text(locator(1),expression(paste("95% Conf. Intervals")))
text(locator(1),expression(hat(y) + 1.96 * ~~ widehat ( sigma [i] )))
text(locator(1),expression(hat(y) - 1.96 * ~~ widehat ( sigma [i] )))   

dev.copy(postscript,"modl1.eps",height=6,width=6,horizontal=F,onefile=F,paper="special")
dev.off()


pred2 <- predict(modl1,newdata=data.frame(x=newx),se.fit=T,interval="confidence")
matplot(newx,pred2$fit,type="l",lty=c(1,4,4),col=c("black","red","red"))
points(x,y)
text(locator(1),paste("95% confidence \nwhen predicting\n average score for \nan observation x"))

dev.copy(postscript,"modl2.eps",height=6,width=6,horizontal=F,onefile=F,paper="special")
dev.off()




pred3 <- predict(modl1,newdata=data.frame(x=newx),se.fit=T,interval="prediction")
matplot(newx,pred3$fit,type="l",lty=c(1,4,4),col=c("black","red","red"))
points(x,y)
text(locator(1),paste("95% confidence \nwhen predicting scores for \nindividual cases"))

dev.copy(postscript,"modl3.eps",height=6,width=6,horizontal=F,onefile=F)
dev.off()


### Read ?predict.lm notice it can produce the 2 types of "confidence intervals"
### So we could just ask for the "confidence" instead of using 1.96*se.fit.


pred4 <- predict(modl1,newdata=data.frame(x=newx),interval="confidence")
pred5 <- predict(modl1,newdata=data.frame(x=newx),interval="prediction")

pred4
pred5

mytitle <- paste("Comparing two 95% confidence intervals")

matplot(newx, cbind(pred4, pred5[,-1]),
             lty=c(1,2,2,3,3),  col=c(1,2,2,3,3), lwd=2, type="l", ylab="predicted y",main=mytitle)


text(locator(1),paste("prediction interval is wider!"),pos=2)
text(locator(1),paste("confidence interval is tighter!"),pos=4)


dev.copy(postscript,"modl4.eps",height=6,width=6,horizontal=F,onefile=F,paper="special")
dev.off()



source





#compare the plot from Design's OLS
x11(height=6,width=6)
library(Design)
mylm <- ols(y~x)
d <- datadist(x=seq(min(x),max(x),length.out=20))
options(datadist="d")
plot(mylm,conf.type=c("mean"))

points(x,y)
text(locator(1),paste("95% confidence when predicting\n average score for \nan observation x"))
dev.copy(postscript,"modlols1.eps",height=6,width=6,horizontal=F,onefile=F)
dev.off()




plot(mylm,ylim=c(-22,30),conf.type=c("individual"))

points(x,y)
text(locator(1),paste("95% confidence \nwhen predicting scores for \nindividual cases"))


#Compare that against output from built in "termplot)

dev.copy(postscript,"modlols2.eps",height=6,width=6,horizontal=F,onefile=F)
dev.off()

