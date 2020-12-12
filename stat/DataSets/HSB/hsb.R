## Paul Johnson
## 2015-04-15

## The HSB data: High School and Beyond was popularized in a
## multi-level regression book by S.W. Raudenbush and A.S.Bryk,
## Hierarchical Linear MOdels: Applications and Data Analysis Methods,
## 2ed (Thousand Oaks: Sage). The full, restricted-use data can be
## obtained from the US Government's National Center for
## Educational Statistics, https://nces.ed.gov/surveys/hsb/


## Subsets from the HSB data have been used in many articles and textbooks.
## I've found quite a few extracts floating about in the internet.
##
## Lets import the Stata data file provided by Rabe-Hesketh and Skrondal
## in support of their fine book, Multilivel and Longitudinal Modeling Uinst
## Stata.

library(foreign)

if (file.exists("hsb.rds")){
    hsb <- readRDS("hsb.rds")
} else {
    hsb.url <- "http://www.stata-press.com/data/mlmus3/hsb.dta"
    hsb <- read.dta(hsb.url)
    saveRDS(hsb, "hsb.rds")
}




rockchalk::summarize(hsb)

## All of these variables present themselves as numeric variables, but
## some are clearly categorical. Female is 0 or 1. The R tradition
## would not have us treat that as a number, but rather it should be a
## factor variable. Same with minority. Lets make factor versions of
## them. So we need to make them into factor variables. 

## I'll take some liberty here and rename in a way that is, in my
## opinion, more correct. The variable is "gender" (not female), which
## takes values Male and Female.

hsb$gender <- factor(hsb$female, levels= c(0, 1), labels = c("Male", "Female"))
hsb$ethnicity <- factor(hsb$minority, levels = c(0, 1), labels = c("White", "Non-white"))
hsb$sector <- factor(hsb$sector, levels = c(0, 1), labels = c("Public", "Catholic"))


## Double-check the recoding
with(hsb, table(gender, female))
with(hsb, table(ethnicity, minority))

## If you are comfortable with those recodes, you can move on. Just to show off
## I'm going to remove the original variables, just to show I can.

hsb$female <- NULL
hsb$minority <- NULL

## If we were going to do any "multi-level" regressions, we would need
## the school variable as a factor, not as an integer. I'm going to make
## that one into a factor called schoolidf

hsb$schoolidf <- as.factor(hsb$schoolid)

## Plainly, there are other variables in the collection that need the same
## treatment, but I'm not bothering with them now. 

rockchalk::summarize(hsb)
str(hsb)

## You might wonder, why does it matter if we make schoolid into a factor?
## Well, you asked for it.

mean(hsb$schoolid)
mean(hsb$schoolidf)

plot(hsb$schoolid)

plot(hsb$schoolidf, ylab = "the number of students in each school",
     xlab = "School ID number")

## I'll save that as an R serial data format file, like so.
saveRDS(hsb, file = "hsb.rds")

## Next time I want to use that, I will run
## hsb <- readRDS("hsb.rds")
 
## Question 1. Are males more likely to be white than females?

library(gmodels)

with(hsb, CrossTable( ethnicity, gender))

library(memisc)

genTable(percent(ethnicity) ~ gender, data = hsb)


## Question 2. Describe Math Achievement with histograms

rockchalk::summarize(hsb$mathach)

with(hsb, hist(mathach))

## Make list of subsets with split and plot them. 
hsbsplit <- split(hsb, hsb$gender)
par(mfrow = c(2,1))
lapply(hsbsplit, function(subdat) with(subdat, hist(mathach, prob = TRUE,  main = paste("Math Achievement:",  unique(subdat$gender)))))
lapply(hsbsplit, function(subdat) with(subdat, hist(ses, prob = TRUE, xlim = c(-4, 3), main = paste0("SES:", unique(subdat$gender)))))

## Question 3. Show the boxplot view of the same

plot(mathach ~ gender, data = hsb)

## Note: plot was a shortcut
boxplot(mathach ~ gender, data = hsb)

bp1 <- boxplot(mathach ~ gender, data = hsb)

text(1, 14.3, "Median of Male")
text(2, 12.1, "Median of Female")


## Show a scatterplot of 2 "numeric" variables

plot(mathach ~ ses, data = hsb)




## Lets see if there is an interaction between ses and gender

m1 <- lm(mathach ~ ses * gender, data = hsb)
summary(m1)

m2 <-  lm(mathach ~ ses + gender, data = hsb)
summary(m2)

library(rockchalk)
plotSlopes(m1, plotx = "ses", modx = "gender")

plotSlopes(m1, plotx = "ses", modx = "gender", col = c("orange", "blue"))

plotSlopes(m1, plotx = "ses", modx = "gender", col = gray.colors(2, 0.1, 0.5), main = "50 - 48 Shades of Gray")

mycol <- c("black", "gray40")
mypch <- c(1, 8) 

plotSlopes(m1, plotx = "ses", modx = "gender", col = mycol, pch = mypch[hsb$gender])

dev.new()
plotSlopes(m2, plotx = "ses", modx = "gender", col = mycol, pch = mypch[hsb$gender] )

## Compare the p-value from the anova test  
anova(m1, m2)

