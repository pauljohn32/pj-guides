## Paul Johnson <pauljohn@ku.edu>
## 2012-01-24


library(foreign)

dat <- read.dta("QoG_c_s_v6Apr11.dta")

fix(dat)

vars <- c("p_polity2",
"fh_ipolity2", "fh_pr",
"gir_gii",
"kk_gg",
"qs_impar",
"ti_cpi",
"wbgi_cce",
"ht_regtype",
"hf_efiscore",
"qs_proff",
"bti_mes", "bti_ep", "bti_wr")


library(rockchalk)
#dat[ , vars]
plot( dat[ , vars])



m1 <- lm(ti_cpi ~ fh_pr, data=dat)

dat$fh_pr_sq <- dat$fh_pr^2
m2a <- lm(ti_cpi ~ fh_pr + fh_pr_sq, data=dat)
summary(m2a)
fh_pr_seq <- plotSeq(dat$fh_pr, length.out=25)
newdf <- data.frame( fh_pr=fh_pr_seq, fh_pr_sq = fh_pr_seq^2)
m2apred <- predict(m2a, newdata=newdf)


m2b <- lm(ti_cpi ~ fh_pr + I(fh_pr^2), data=dat)
summary(m2b)
m2bpred <- predict(m2b, newdata=newdf)

m2c <- lm(ti_cpi ~ poly(fh_pr, 2), data=dat)
summary(m2c)
m2cpred <- predict(m2b, newdata=newdf)


dat$fh_pr_mc <- with(dat, fh_pr - mean(dat$fh_pr, na.rm=TRUE))
m2d <-lm(ti_cpi ~ fh_pr_mc + I(fh_pr_mc^2), data=dat)
summary(m2d)
newdf$fh_pr_mc <- newdf$fh_pr - mean(dat$fh_pr, na.rm=TRUE)
m2dpred <- predict(m2d, newdata=newdf)



m2e <- lm(ti_cpi ~ poly(fh_pr_mc, 2), data=dat)
summary(m2e)
newdf$fh_pr_mc <- newdf$fh_pr - mean(dat$fh_pr, na.rm=TRUE)
m2epred <- predict(m2e, newdata=newdf)

plot(ti_cpi ~ fh_pr, data=dat, xlab="Political rights (Freedom House)", ylab="TI Corruptions Perceptions")
abline(m1)
lines(newdf$fh_pr, m2apred, lty=1, lwd=12, col="green")
lines(newdf$fh_pr, m2bpred, lty=1, lwd=8, col="purple")
lines(newdf$fh_pr, m2cpred, lty=2, lwd=8, col="pink")
lines(newdf$fh_pr, m2dpred, lty=3, lwd=8, col="red")
lines(newdf$fh_pr, m2epred, lty=5, lwd=4, col="yellow")
legend("topright", title="quadratic", legend=c("m2a:fh_sq","m2b:I(fh^2)","m2c:poly(fh)","m2d:fh_sq_mc","m2e:poly(fh_mc)"), lty=c(1,1,2,3,5), lwd=c(12,8,8,8,4), col=c("green", "purple","pink","red","yellow") )
                     "



outreg(list(m1, m2a, m2b, m2c, m2d, m2e), tight=TRUE)


plot( kk_gg ~ qs_proff, data=dat)


m3 <- lm(p_polity2 ~ ht_regtype * qs_impar, data=dat)
summary(m3)

plotSlopes(m3, plotx="qs_impar", modx="ht_regtype")


plotCurves(m3, plotx="qs_impar", modx="ht_regtype")
