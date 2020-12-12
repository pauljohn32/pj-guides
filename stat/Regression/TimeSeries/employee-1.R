
## I found data "employee.txt" here:
##https://onlinecourses.science.psu.edu/stat501/node/365/

## Re-create their graphs


dat <- read.table("employee.txt", header = TRUE)

library(kutils)
peek(dat)

par(ask=FALSE)

xlab = "Number of Vendor Employees"
ylab = "Number of Fabricator Employees"

plot(metal ~  vendor, data = dat, xlab = xlab,
     ylab = xlab)

m1 <- lm(metal ~  vendor, data = dat)
library(rockchalk)
plotSlopes(m1, plotx = "vendor", 
           xlab = xlab, ylab = xlab, plotLegend = FALSE,
           main = "Employee Data")


dat$m1resid <- resid(m1)

plot(m1resid ~ time, data = dat, xlab = "Order(t)",
     ylab = "Residuals", main = "Residuals")
abline(h = 0)


library(lmtest)
dwtest(m1)


##
acf(dat$m1resid, lag.max = 15)


## ?pacf: partial acf
pacf(dat$m1resid, lag.max = 15)

pacf(dat$m1resid, lag.max = 15,
     ylim = c(-1, 1))

library(orcutt)
co1 <- cochrane.orcutt(m1)
summary(co1)

## Manual method. 

dat$metal.lag <- c(NA, dat$metal[1:NROW(dat)-1])
dat$vendor.lag <- c(NA, dat$vendor[1:NROW(dat)-1])


## use fitted model to get rho estimate
dat$m1resid <- resid(m1)
dat$m1resid.lag <- c(NA, dat$m1resid[1:NROW(dat)-1]) 
rhoest <- lm(m1resid ~ 0 + m1resid.lag, dat)
summary(rhoest)
rho <- coef(rhoest)["m1resid.lag"]
## use rho to transform variables
dat$metalstar <- dat$metal - dat$metal.lag * rho
dat$vendorstar <- dat$vendor - dat$vendor.lag * rho
## second state model
co1 <- lm(metalstar ~ vendorstar, data = dat)
summary(co1)


## So far, so good. Should be able to repeat
## process to get closer and closer to cochrane-orcutt
## estimates

## Repeat
co1resid <- resid(co1)
co1resid.lag <- c(NA, co1resid[1:length(co1resid)-1])
rhoest <-  lm(co1resid ~ 0 + co1resid.lag)
(rho <- coef(rhoest)["co1resid.lag"])
dat$metalstar <- dat$metal - dat$metal.lag * rho
dat$vendorstar <- dat$vendor - dat$vendor.lag * rho
co1 <- lm(metalstar ~ vendorstar, data = dat)
summary(co1)



## Repeat 50 times
for(i in 1:50){
    co1resid <- resid(co1)
    co1resid.lag <- c(NA, co1resid[1:length(co1resid)-1])
    rhoest <- lm(co1resid ~ 0 + co1resid.lag)
    (rho <- coef(rhoest)["co1resid.lag"])
    dat$metalstar <- dat$metal - dat$metal.lag * rho
    dat$vendorstar <- dat$vendor - dat$vendor.lag * rho
    co1 <- lm(metalstar ~ vendorstar, data = dat)
    print(summary(co1))
}

