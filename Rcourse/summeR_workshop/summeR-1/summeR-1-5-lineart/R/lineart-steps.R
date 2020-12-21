## Paul E Johnson
## 20160404



## Choose format output, or none
## SAVEME as "svg" "pdf" or "" (draw on screen)
## SAVEME <- "svg"
SAVEME <- ""

if (SAVEME != ""){
    outdir <- "../output/"
    if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
    pdf.options(height = 5, width = 7, paper = "special", onefile = FALSE, family = "Times")

    if (SAVEME == "pdf") {
        pdf(file = paste0(outdir, "lineart-steps-1.pdf"),  family="Times")
    } else if (SAVEME == "svg") {
        svg(file = paste0(outdir, "lineart-steps-1.svg"),  family="Times")
    } else print(paste("Sorry, I'm Saving nothing, your SAVEME string is not pdf or svg"))
}

time <- seq(-2, 8, by = 1)
y <- seq(-5, 5, length.out = length(time))

b0 <- -1.5
effect1 <- -0.5
timeafter2 <- seq(4, 8, by = 1)
effect2 <- rep(2, length(timeafter2))


plot (time, y, type = "n", ylab = "Response",
      xlab = "Time (seconds)", axes = TRUE, xlim = c(-2, 10),
      main = "")

lines(time, rep(b0, length = length(time)),
      lty = 4, lwd = 2, col = "gray70")

text(-1, b0 - 0.5, labels = c("The baseline level"), pos = 4)
text(-1.5, b0 - 0.5, labels = expression(b[0]), pos = 4)

lines(time[3:14], rep(effect1, length = length(time))[3:14],
      lty = 2, lwd = 2)
arrows(time[5], b0 + 0.15,
       time[5], effect1 - 0.15,
       length = 0.05, code = 3, col = "darkgreen")

text(time[4], 0.5*(effect1 + b0), labels = expression(beta[1]), pos = 4)
text(time[5], effect1 - 0.5, labels = c("The First Incremental Effect"), pos = 4)


lines(timeafter2, effect2, lty = 2, lwd = 2, col = "black")
arrows(timeafter2[2], effect1 + 0.15, timeafter2[2], effect2 - 0.15,
       length = 0.05, code = 3, col = "darkgreen")

text(timeafter2[2], 0.5 * (effect1 + effect2),
     labels = expression(beta[2]), pos = 2)
text(timeafter2[3], 0.8, -1.0,
     labels = c("The Second\nIncremental Effect"), pos = 4)

text(-0.15, -0.5, labels = expression(b[0] + beta[1]), pos = 2)
text(3.85, effect2, labels = expression(b[0] + beta[1] + beta[2]), pos = 2)

if (SAVEME != "") dev.off()




## Choose format output, or none
## SAVEME as "svg" "pdf" or FALSE (draw on screen)
## SAVEME <- "svg"
## SAVEME <- "pdf"
if (SAVEME %in% c("pdf", "svg")) {
    if (SAVEME == "pdf") {
        pdf(file = paste0(outdir, "lineart-steps-2.pdf"),  family="Times")
    } else if (SAVEME == "svg") {
        svg(file = paste0(outdir, "lineart-steps-2.svg"),  family="Times")
    }
}

time <- seq(-2, 11, by = 1)
y <- seq(-5, 5, length.out = length(time))
b0 = -1.5
b1 = +.9
beta1 <- + 1.7
beta2 <- 2.1
beta3 <- 0.5
beta4 <- 1.3

plot (time, y, type = "n", ylab = "Response", xlab = "Time (seconds)",
      axes = FALSE,
      main = "Comparing Stimulus Types: Shared Baseline Approach")

axis(2)
axis(1, at = c(-2, 0, 2, 4))
axis(1, at = c(5, 7, 9, 11), labels = c(-2, 0, 4, 6))
box(bty = "7")
parusr <- par("usr")
lines(c(parusr[1], parusr[1]), c(parusr[3], parusr[4]), lwd = 1.1)

lines(time[1:7], rep(b0, length = length(time))[1:7],
      lty = 4, lwd = 2, col = "gray70")
lines(time[8:14], rep(b0, length = length(time))[8:14],
      lty = 4, lwd = 2, col = "gray70")
text(time[7] + 0.5*(time[8] - time[7]), -1.5, labels = expression(b[0]))

lines(time[8:14], rep(-0.6, length = length(time))[8:14],
      lty = 4, lwd = 2, col = "gray50")
text(time[8] + 0.5*(time[9] - time[8]), -0.6,
     labels = expression(b[0] + b[1]), pos = 2)


timeafter1 <- seq(0,2, by = 1)
badeffect1 <- rep(b0 + beta1, length(timeafter1))
lines(timeafter1, badeffect1, lty = 2, lwd = 2, col = "blue")
text(timeafter1[1], badeffect1[1], labels = expression(b[0] + beta[1]), pos = 2)
arrows(-0.2, 0.9 *b0, -0.2, 0.2*badeffect1[1], length = 0.05, code = 3, col = "blue")
text(-0.2, b0 + 0.5 * beta1, expression(beta[1]), pos = 4)


timeafter2 <- seq(2, 4, by = 1)
badeffect2 <- rep(b0 + beta2, length(timeafter2))
lines(timeafter2, badeffect2, lty = 2, lwd = 2, col = "blue")
text(2, badeffect2[1], labels = expression(b[0]+beta[2]), pos = 2)
arrows(2.2, 0.9 *b0 , 2.2, 0.5*badeffect2[1], length = 0.05, code = 3, col = "blue")
text(2, b0 + 0.5 * beta2, expression(beta[2]), pos = 4)


text(1, -3, "Stimulus Type 1")
text(time[12], -3, "Stimulus Type 2")


timeafter2 <- seq(7, 9, by = 1)
goodeffect2 <- rep(b0 + b1 + beta1 + beta3, length(timeafter2))
lines(timeafter2, goodeffect2, lty = 2, lwd = 2, col = "darkgreen")
text(timeafter2[1], goodeffect2[1], labels = expression(b[0]+b[1]+beta[1]+beta[3]), pos = 2)

arrows(timeafter2[1], b0+b1, timeafter2[1], b0+b1+beta1, angle = 45, code= 3, length = 0.05, col = "darkgreen")
arrows(timeafter2[1], b0+b1+beta1, timeafter2[1],
       b0+b1+beta1 + beta3, angle = 45, code= 3, length = 0.05, col = "darkgreen")

text(timeafter2[1], b0+b1+0.5 * (beta1), expression(beta[1]), pos = 4)
text(timeafter2[1], b0+b1+ beta1 + 0.5* beta3, expression(beta[3]), pos = 4)

timeafter2 <- seq(9, 11, by = 1)
goodeffect2 <- rep(b0 + b1 + beta2 + beta4, length(timeafter2))

lines(timeafter2, goodeffect2, lty = 2, lwd = 2, col = "darkgreen")

text(timeafter2[1], goodeffect2[1],
     labels = expression(b[0]+b[1]+beta[2]+beta[4]), pos = 2)


arrows(timeafter2[2], b0+b1, timeafter2[2], b0+b1+beta2, angle = 45,
       code= 3, length = 0.05, col = "darkgreen")

arrows(timeafter2[2], b0+b1+beta2, timeafter2[2], b0+b1+beta2 + beta4,
       angle = 45, code= 3, length = 0.05, col = "darkgreen")

text(timeafter2[2], b0+b1+0.5 * (beta4 + beta2), expression(beta[2]),
     pos = 4)

text(timeafter2[2], b0+b1+ 0.9*(beta2 + beta4), expression(beta[4]),
     pos = 4)

if (SAVEME != "") dev.off()













