## Paul Johnson <pauljohn@ku.edu>
## 2015-05-13

## A first practice R session to make sure
## everything is working correctly



x <- rnorm(500, m = 20, sd = 30)
hist(x)

y <- gl(5, 100)
z <- rnorm(500)
plot(z ~ x)
plot(y ~ x)

xmean <- mean(x)



xsd <- sd(x)

print(paste("The estimated mean is ", xmean))
print(paste("The estimated standard devation is ", xsd))
cat(paste("Sorry, I didn't remember how to round those numbers.\n"))

hist(x, prob = TRUE, breaks = 30)

hist(x, prob = TRUE, breaks = 30, main = "Histogram of Normal(20, 900)")

## Should create output file "hist-1.pdf" in current working directory
pdf(file = "hist-1.pdf", onefile = FALSE, paper = "special", width = 7,
    height = 5, family = "Times")
hist(x, prob = TRUE, breaks = 30, main = "Histogram of Normal(20, 900)",
     xlab = "Notice I used Times Roman Fonts Here")
dev.off()

## Make sure that "hist-1.pdf" shows up in this list
list.files()

sessionInfo()
