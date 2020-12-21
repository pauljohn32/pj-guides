### R code from vignette source '/tmp/lyx_tmpdir.T16462/lyx_tmpbuf2/first-R-01.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: first-R-01.Rnw:25-26
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: first-R-01.Rnw:82-83
###################################################
dir.create("plots", showWarnings=F)


###################################################
### code chunk number 3: Roptions
###################################################
options(device = pdf)
options(width=160, prompt="> ", continue="+  ")
options(useFancyQuotes = FALSE) 
#set.seed(12345)
op <- par() 
pjmar <- c(5.1, 5.1, 1.5, 2.1) 
#pjmar <- par("mar")
options(SweaveHooks=list(fig=function() par(mar=pjmar, ps=12)))
pdf.options(onefile=F,family="Times",pointsize=12)


###################################################
### code chunk number 4: first-R-01.Rnw:173-177
###################################################
x <- c(3, 5, 7, 9, 11)
x
mean(x)
var(x)


###################################################
### code chunk number 5: first-R-01.Rnw:187-188
###################################################
x 


###################################################
### code chunk number 6: first-R-01.Rnw:193-194
###################################################
print(x)


###################################################
### code chunk number 7: first-R-01.Rnw:205-208
###################################################
y <- c(4, -2, 3, 5, 1)
mean(x)
var(x)


###################################################
### code chunk number 8: p1
###################################################
plot(y ~ x, main = "My First Plot")


###################################################
### code chunk number 9: first-R-01.Rnw:235-237
###################################################
x <- rnorm(40, m = 7, sd = 10)
y <- rpois(40, lambda = 11)


###################################################
### code chunk number 10: first-R-01.Rnw:244-246
###################################################
head(x)
head(y)


###################################################
### code chunk number 11: first-R-01.Rnw:260-263
###################################################
set.seed(66565) #put in any integer you like
x <- rnorm(40, m = 7, sd = 10)
y <- rpois(40, lambda = 11)


###################################################
### code chunk number 12: p2
###################################################
hist(x, prob = TRUE, main = "My First Histogram")


###################################################
### code chunk number 13: p3
###################################################
hist(y, prob = TRUE, main = "I'm too Cool for Titles", xlab = "This is x. Deal with it.", ylab = "Probability")
yden <- density(y)
lines(yden) ## lines is a "method." Will explain later :)


###################################################
### code chunk number 14: p4
###################################################
plot(y ~ x)


###################################################
### code chunk number 15: p5
###################################################
plot(y ~ x, main = "Here comes a line!")
mod1 <- lm(y ~ x)
abline(mod1)


###################################################
### code chunk number 16: p6
###################################################
pdf("RegPlot1.pdf", height = 5, width = 7, paper = "special")
plot(y ~ x, main = "Here comes a line!")
mod1 <- lm(y ~ x)
abline(mod1)
dev.off() # finishes the actual output file


###################################################
### code chunk number 17: first-R-01.Rnw:360-361 (eval = FALSE)
###################################################
## list.files()


###################################################
### code chunk number 18: first-R-01.Rnw:368-369 (eval = FALSE)
###################################################
## getwd()


