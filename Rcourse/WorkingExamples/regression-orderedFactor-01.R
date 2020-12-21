# Paul Johnson <pauljohn@ku.edu> Nov. 16, 2005

# Ordinal predictors with a small number of possible values

# Here is R code and commentary about ordinal predictors.
# Please let me know if you have insights to explain this more clearly.

set.seed(199999)

sampleSize <- 100
subgroupSize <- sampleSize/5
# One of those "5 point opinion" questions: Strongly Disagree...
# Strongly agree with values assigned 1,3,5,7,9
surveyQuestion <- c(rep(1,subgroupSize),rep(3,subgroupSize),rep(5,subgroupSize),rep(7,subgroupSize),rep(9,subgroupSize))

### Make this an unordered factor
myufac <- factor(surveyQuestion)
### Study the contrasts:
contrasts(myufac)

### Make an ordered  factor
myofac <- ordered(surveyQuestion)
contrasts(myofac)

# another independent variable
x <- rnorm(sampleSize)
# a random error
e <- rnorm(sampleSize)


# First, suppose the output data is really just a
# linear reflection of the surveyQuestion. It is created
# by multiplying against the evenly spaced values
# observed in the survey

y1 <- -5 +  4*surveyQuestion + 6*x + 10 * e


mod0 <- lm(y1~x + surveyQuestion)
summary(mod0)

# Question: are you making a mistake by just "throwing"
# surveyQuestion into the analysis? You should not be
# making a mistake, because you (luckily) guessed the right model

# You might check by running the model with the unordered factor,
# which amounts to running "dummy variables"

mod1 <- lm(y1~x + myufac)
summary(mod1)

# or with the ordered factor, which estimates the orthogonal
# polynomials

mod2 <- lm(y1~x + myofac)
summary(mod2)

# Does either of those model appear to be "better" than
# the original mod0?

# If I did not know for sure the factor was ordered, I'd
# be stuck with the treatment contrasts in mod1.  And what
# I would really like to know is this: are the coefficients
# in mod1 "stepping up" in a clear, ordinal, evenly spaced pattern?

# Since we know the data is created with a coefficient of 4
# we would expect that the coefficients would "step up" like this
# myufac3   8    
# myufac5   16
# myufac7   24
# myufac9   32

# See why we expect this pattern? The intercept "gobbles up" myufac1,
# so each "impact" of the surveyQuestion has to be reduced by 4 units.
# The impact of myufac3, which you expect might be 3*4=12, is reduced
# to 3*4 - 4 = 8, and so forth.

# But that does not happen with a smallish sample. You can run this
# code a few times. It appears to me that a sample of more than
# 10,000 is necessary to get any faithful reproduction of the "steps"
# between values of surveyQuestion.

# Question: would we mistakenly think that the uneveness observed in
# summary(mod1) is evidence of the need to treat surveyQuestion as a
# nominal factor, even though we know (since we created the data) that
# we might as well just throw surveyQuestion in as a single variable?
# How to decide?

# We need a hypothesis test of the conjecture that
# the coefficient estimates in mod1 fall "along a line"
# i.e, myufac-i = (b2 * i ) - b2

# I believe that the correct test results from this command:

anova(mod0, mod1, test="Chisq")

# If that is significant, it means you are losing predictive
# power by throwing in surveyQuestion as if it were a numerical
# variable.



# Now, what if we are sure that the data gathered in surveyQuestion is
# really ordinal, and so we estimate mod2.

# What do those parameters mean? Here I'm just reasoning/guessing
# because I cannot find any complete idiot's guide to orthogonal
# polynomials and their use in regression and/or R.

# Take a look at the contrasts themselves
# > ord1 <- contrasts(myofac)
# ord1
#           .L         .Q            .C         ^4
# 1 -6.324555e-01  0.5345225 -3.162278e-01  0.1195229
# 3 -3.162278e-01 -0.2672612  6.324555e-01 -0.4780914
# 5 -3.287978e-17 -0.5345225  1.595204e-16  0.7171372
# 7  3.162278e-01 -0.2672612 -6.324555e-01 -0.4780914
# 9  6.324555e-01  0.5345225  3.162278e-01  0.1195229

# What does this mean?  I believe: we act "as though" there are 4
# independent variables in the regression, L, Q, C, and ^4, and for
# each respondent in the dataset, we choose a row of these numbers
# to act as independent variables.  A person who
# answered 1 on the survey would have the input values (-.63, -.53,
# -.31, 0.11) for those four variables.

# This begs the question, what are L, Q, C, and ^4?

### This is tough to explain.

# Background Recall from calculus that any function can be
# approximated by a polynomial.  Since surveyQuestion has only 5
# possible values, a polynomial of degree 4 is needed to "replace it"
# in a regression model. It can replace it EXACTLY, not just
# approximately. So we might fit


#    y1 <- a +  b* x + c*surveyQuestion
#                    + d*surveyQuestion^2
#                    + e*surveyQuestion^3
#                    + f*surveyQuestion^4

# That would give a "direct test" of whether you need to worry
# about the coding of surveyQuestion. If d, e, and f are zero
# then that means the inclusion of surveyQuestion as a linear
# is the right way to go.  If you get significant estimates on
# ^2, ^3, and/or ^2, then you would know it was a mistake
# to throw in surveyQuestion by itself.

# Here is the big problem.
# There would be *severe multicollinearity* in those estimates.
# The standard errors would be huge, and the variance of the
# estimated coefficients would be massive. That would happen 
# because the ^2 ^3 and ^4 variables are so proportional to each other
# in many datasets.

# But there is a way to re-scale those terms so they are not
# multicollinear.  So, instead of estimating the polynomial
# directly, we use the "rescaled" orthogonal polynomial values.

# Note that there is no correlation between these 4 columns of of the
# orgthogonal contrasts. They are "orthogonal polynomials", so there
# is absolutely no multicollinearity problem among them.

# Observe:
  
# > ord1 <- contrasts(myofac)
# > t(ord1[,2])%*% ord1[,3]
#              [,1]
# [1,] -3.579222e-17

# That's very very close to 0.0.
# We can do all of those multiplications at once: check diagonal here
# > t(ord1) %*% ord1
#              .L            .Q            .C            ^4
# .L  1.000000e-00  4.710858e-17 -7.123208e-17  2.143332e-17
# .Q  4.710858e-17  1.000000e-00 -3.579222e-17 -3.916680e-17
# .C -7.123208e-17 -3.579222e-17  1.000000e+00  3.582678e-16
# ^4  2.143332e-17 -3.916680e-17  3.582678e-16  1.000000e+00


# That is as much illinformed guessing as I can do right now about
# orthogonal polynomials.

# Anyway, if you run the regression mod2 and the higher
# order terms are not significant, then it is a hint that your coding is
# OK. That is, just "throw in" surveyQuestion.

# And I believe a rigorous hypothesis test is obtained by

anova (mod0, mod2, test="Chisq")

# What's the good news? The Hypothesis Test result is EXACTLY THE
# SAME whether we test the ordinal or the nominal coding. Whew!
# Not such a big issue, then, whether we do factor or ordered when
# deciding if we can just "throw" surveyQuestion into the model.





# Now change the problem so that the "real data" is not created
# by multiplying against the pure, unadulterated surveyQuestion
# Now, the ordinal impact of the "real effect" is not reflected
# perfectly well by the data of surveyQuestion

surveyImpact <- NA
surveyImpact[surveyQuestion==1] <- 0
surveyImpact[surveyQuestion==3] <- 5
surveyImpact[surveyQuestion==5] <- 6
surveyImpact[surveyQuestion==7] <- 9
surveyImpact[surveyQuestion==9] <- 14


y2 <- -5 +  4*surveyImpact + 6*x + 10 * e

# Proceed as if you were not wrong and "throw in" survey question.

mod3 <- lm(y2~x + surveyQuestion)
summary(mod3)

# Question: are you making a mistake?

# If you are one of the people who says silly things like "my p values
# are good, so I must have the correct model," the results should be
# very very sobering.

mod4 <- lm(y2~x + myufac)
summary(mod4)

# or with the ordered factor, which estimates the orthogonal
# polynomials

mod5 <- lm(y2~x + myofac)
summary(mod5)

anova(mod3,mod4, test="Chisq")

anova(mod3,mod5, test="Chisq")

# Again, the happy result that the 2 significance tests are the
# same. Both tell you that you were just flat-out wrong to put
# surveyQuestion into the regression model.
