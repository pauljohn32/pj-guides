## Paul E Johnson
## 20160404

## Illustrates the over-time impact of a hypothetical program
## change in one district

## This one makes a png ouptput file that is 600x600 pixels


set.seed(234234)

dat <- data.frame(time = 1:20,
                  Y1 = rnorm(20, m = 0.1, s = 0.05),
                  Y2 = rnorm(20, m = -.1, s = 0.05))
dat$Y3 = dat$Y2
dat$Y3[11:12] <- dat$Y2[10:11] + cumsum(abs(rnorm(2, .15, .1)))
dat$Y3[13:20] <- dat$Y3[11] + dat$Y2[13:20]

if (!file.exists("../output")) dir.create("../output", recursive = TRUE, showWarnings = FALSE)
                 
SAVEME <- TRUE
if (SAVEME) png("../output/lineart-intervention-1.png", height = 600, width = 600)

plot(Y1 ~ time, type = "b", data = dat, ylim = c(-0.3, 0.3),
     ylab = "Hypothetical: Opinion Variations around National Norms",
     xlab = "Time", yaxt = "n")
axis(2, at = seq(-0.20, 0.20, by = 0.05))
mtext(text = c("Worse", "Better"), side = 2, at = c(-0.3, .3), line = 0.4, las = 2)

lines(Y3 ~ time, type = "b", dat[1:10, ], pch = 5)
lines(Y3 ~ time, col = "red", type = "b", dat[10:20, ], pch = 5)

text(3, 0.15, "District 1", pos = 3)
text(7, -0.23, "District 2 Preintervention")
text(12.2, 0.23, "District 2 Post", pos = 4)

text(14, -.08, "Intervention Occurred")
arrows(11, -.08, 10.3, -0.075, code = 2, length = 0.1)

lines(Y2 ~ time, col = "gray70", type = "b", dat[10:20, ])
text(17, -.2, "Without Intervention", col = "gray70")

if (SAVEME) dev.off()
