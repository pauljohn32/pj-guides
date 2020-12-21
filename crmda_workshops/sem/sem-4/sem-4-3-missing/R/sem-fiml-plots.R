# Meghan Sullivan
# 20180503
# Plots for Maximum Likelihood Slides

# Load required packages
library(ggplot2)


# Define directories
odir <- "../output"
if(!file.exists(odir)) dir.create(odir, recursive = TRUE)


# Plot normal distributions
P1 <- ggplot(data.frame(x = c(-5, 5)), aes(x)) + 
  stat_function(fun = dnorm, args = list(mean = 0, sd = 1), aes(colour='red')) +
  stat_function(fun = dnorm, args = list(mean = 1, sd = .5), aes(colour='blue')) + 
  stat_function(fun = dnorm, args = list(mean = -1, sd = 1.5), aes(colour='orange')) +
  stat_function(fun = dnorm, args = list(mean = 0, sd = 2), aes(colour='dark green')) + 
  labs(x = "y", y = "f(y)") + 
  scale_colour_manual("Parameters", values = c("red", "blue", "orange", "dark green"),
                      labels = c("Mean = 0, SD = 1", 
                                 "Mean = 1, SD = 0.5", 
                                 "Mean = -1, SD = 1.5", 
                                 "Mean = 0, SD = 2")) +
  theme(legend.position = c(0.85, 0.75))

ggsave(file.path(odir, "plot-1.png"), plot = P1, width = 6, height = 5.5)


# Log-likelihood 
location = data.frame("LL" = 0.08, "Parameter" = 462.2)
P2 <- ggplot(data.frame(x = c(447, 477)), aes(x)) + 
  stat_function(fun = dnorm, args = list(mean = 462.2, sd = 5), aes(colour='blue')) +
  ylim(0.03, 0.10) +
  labs(x = "Mean = 462.2", y = "Log-Likelihood") +
  geom_segment(data = location, aes(x = Parameter, y = LL, xend=-Inf, yend=LL)) +
  geom_segment(data = location, aes(x = Parameter, y = LL, xend=Parameter, yend=-Inf)) +
  theme(legend.position="none")

ggsave(file.path(odir, "plot-2.png"), plot = P2, width = 2, height = 1.5)


## # Multivariate Normal
## mu = [0,0]; %// data
## sigma = [.5 0; 0 .5]; %// data
## x = -5:.1:5; %// x axis
## y = -4:.1:4; %// y axis

## [X Y] = meshgrid(x,y); %// all combinations of x, y
## Z = mvnpdf([X(:) Y(:)],mu,sigma); %// compute Gaussian pdf
## Z = reshape(Z,size(X)); %// put into same size as X, Y
## %// contour(X,Y,Z), axis equal  %// contour plot; set same scale for x and y...
## surf(X,Y,Z) %// ... or 3D plot

