library(rockchalk)
set.seed(234234)
x1 <- rpois(100, lambda = 7)
x2 <- rnorm(100, m = 50, sd = 2)
x3 <- sample(c(0,1), 100, replace = TRUE)
y <- 2*x1 + 0.2*x2 + 0.3*x1*x2 + 0.5*x1*x3 + rnorm(200, sd = 5)
y2 <- 2*x1 + 0.2*x2 + 0.7*x1*x3 + rnorm(200, sd = 5)
x3 <- factor(x3, labels=c("left", "right"))
dat <- data.frame(x1, x2, x3, y, y2)

mod1 <- lm(y ~ x1, data = dat)
plot(y ~ x1, data = dat)
abline(mod1)


mod1 <- lm(y2 ~ x1*x3, data = dat)
ps1 <- plotSlopes(mod1, plotx = "x1", modx = "x3")

ps2 <- plotSlopes(mod1, plotx = "x1", modx = "x3", interval = "confidence")


ps3a <- plotSlopes(mod1, plotx = "x1", modx = "x3", modxVals = c("left"))

ps3b <- plotSlopes(mod1, plotx = "x1", modx = "x3", modxVals = c("right"))


mod2 <- lm(y ~ x1*x2, data = dat)
ps1 <- plotSlopes(mod2, plotx = "x1", modx = "x2")
ps1 <- plotSlopes(mod2, plotx = "x1", modx = "x2", interval = "confidence")


ps1ts <- testSlopes(ps1)

plot(ps1ts)

dat <- data.frame(income = rnorm(1000, m=10000, sd=20000), 
educ = rpois(1000, lambda = 10),
religion = factor(sample(c("cath","prot","jewish","muslem","other"), 1000, replace = TRUE)



