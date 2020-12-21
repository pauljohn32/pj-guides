x0 <- c(-1, -4, 4.5)
y0 <- c(-1, -4, -8)
x1 <- c(2, -2, -3)
y1 <- c(4, 4, 18)
mylengths <- c(0.2, 0.3, 0.15)
mycodes <- c(3, 2, 1)
myangle <- c(10, 60, 80)

plot(x = c(-5, 5), y = c(-10, 20), 
     type = "n", xlab = "", ylab = "")

arrows(x0 = x0, y0 = y0, x1 = x1, y1 = y1,
       length = mylengths, code = mycodes, angle = myangle)

## workaround
plot(x = c(-5, 5), y = c(-10, 20), 
     type = "n", xlab = "", ylab = "")

mapply(arrows, x0 = x0, y0 = y0, x1 = x1, y1 = y1,
       length = mylengths, angle = myangle, code = mycodes)
