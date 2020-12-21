### Paul Johnson
### June 21, 2010

nf <- layout(matrix(c(1,2,3,4,5,6),2,3,byrow=TRUE), widths=c(lcm(5), lcm(5), lcm(5)), heights=c(1,1), TRUE)

layout.show(nf)

par(mar=c(1,0,0,0))

  plot(1:5, 1:5, xlab = "", ylab = "", xaxt = "n", col = "blue");
  axis(3, at = seq(1:5), labels = rep("", 5))


  plot(1:5, 1:5, xlab = "", ylab = "", xaxt = "n", yaxt = "n", col =
  "red"); axis(3, at = seq(1:5), labels = seq(1:5))

  plot(1:5, 1:5, xlab = "", ylab = "", xaxt = "n", yaxt = "n", col =
  "red"); axis(3, at = seq(1:5), labels = rep("", 5))
  axis(4, at = seq(1:5), labels = rep("", 5))
  


  plot(1:5, 1:5, xlab = "", ylab = "", xaxt = "n", col = "blue");
  axis(3, at = seq(1:5), labels = rep("", 5))


  plot(1:5, 1:5, xlab = "", ylab = "", xaxt = "n", yaxt = "n", col =
  "red"); axis(3, at = seq(1:5), labels = seq(1:5))

  plot(1:5, 1:5, xlab = "", ylab = "", xaxt = "n", yaxt = "n", col =
  "red"); axis(3, at = seq(1:5), labels = rep("", 5))
  axis(4, at = seq(1:5), labels = rep("", 5))

mylayout <- matrix(c(1,1,2,3,4,4),nrow=2,ncol=3,byrow=T)
nf <- layout(mylayout, widths=c(lcm(5), lcm(5), lcm(5)), heights=c(1,1), TRUE)

layout.show(nf)

##Run with this option, then run again without it.
## See? it sets plot margins!
par(mar=c(1,0,0,0))

  plot(1:5, 1:5, xlab = "", ylab = "", xaxt = "n", yaxt = "n", col =
  "red"); axis(3, at = seq(1:5), labels = seq(1:5))

  plot(1:5, 1:5, xlab = "", ylab = "", xaxt = "n", yaxt = "n", col =
  "red"); axis(3, at = seq(1:5), labels = rep("", 5))
  axis(4, at = seq(1:5), labels = rep("", 5))
  plot(1:5, 1:5, xlab = "", ylab = "", xaxt = "n", yaxt = "n", col =
  "red"); axis(3, at = seq(1:5), labels = seq(1:5))

  plot(1:5, 1:5, xlab = "", ylab = "", xaxt = "n", yaxt = "n", col =
  "red"); axis(3, at = seq(1:5), labels = rep("", 5))
  axis(4, at = seq(1:5), labels = rep("", 5))
