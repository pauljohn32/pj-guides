Paul Johnson
2014-03-02

Greetings. 

I came onto the HSB train at a late stage of the game, pardon me
if this is naive. 

HSB was conducted for the US
National Center on Educational Statistics (NCES). The sophomore and
senior classes of high school students in 1980 were included in the
study. They were surveyed biannually until 1986.  The website for it
is:

http://nces.ed.gov/surveys/hsb/

The official, full data set is not available for public use because
it contains private information about the students. 

If the data is private, how can we use it? Well, other scholars have
obtained permission to release pieces.  The High School and Beyond
data set was emphasized in Raudenbush & Bryk and Rabe-Hesketh and
Skrondal.  There are sanitized versions of the data floating about.

I noticed today that there is a 6 variable excerpt in the R package
"nlme" called MathAchievement. That includes just a few variables on
7185 cases. The help page describes them:

School: an ordered factor identifying the school that the student attends 
Minority: a factor with levels No Yes indicating if the student is a member of a minority racial group. 
Sex: a factor with levels Male Female 
SES:  a numeric vector of socio-economic status. 
MathAch: a numeric vector of mathematics achievement scores. 
MEANSES: a numeric vector of the mean SES for the school. 


A very widely used packaging is distributed for the book
Multilevel Modeling Using Stata (Rabe-Hesketh and Skrondal), versions
2 and 3

http://www.stata-press.com/data/mlmus3.html

You can download a zip file that has a lot of stata data sets, 
one of which is hsb.dta

http://www.stata-press.com/data/mlmus3/mlmus3.zip

That is the one I illustrate in my R code in this folder. It has the
same variables, plus a few more.

Information on the students we focus on is

mathach: Math Achievenment
ses: student socio economic status
gender: male or female?
ethnicity: white or not

There are also school-level predictors, including
sector: public (0) or catholic (1) school
pracad: proportion of students on the academic trac
schoolid: the school's id number
size: school enrolment
disclim: the school's disciplinary climate
himnty: high fraction minority: more than 40% minority enrolment, 0 if less than 40%) 


The full variable list as downloaded is:
 [1] "minority" "female"   "ses"      "mathach"  "size"     "sector"  
 [7] "pracad"   "disclim"  "himinty"  "schoolid" "mean"     "sd"      
[13] "sdalt"    "junk"     "sdalt2"   "num"      "se"       "sealt"   
[19] "sealt2"   "t2"       "t2alt"    "pickone"  "mmses"    "mnses"   
[25] "xb"       "resid"   

One of the usual puzzles we face is figuring out what those other
columns are for. I read ahead in the book and, actually, I don't think
they belong there at all, but the Stata users tend to disagree. A
lot of them are "recodes" that one would think should not be
redistributed with a data set, but that's just an opinion.


There is also a version for SPSS, which I found in 
a website at Butler University

http://rpadgett.butler.edu/ps310/classdata.php

and at UCLA, the very excellent idre has versions for SPSS:

http://www.ats.ucla.edu/stat/paperexamples/singer/

and SAS
SAS FAQ: From an OLS model to full mixed models using proc nlmixed
http://www.ats.ucla.edu/stat/sas/faq/nlmixed_reg.htm

In my hsb.R, I show how I use the data, converting some of the numeric
scores to categorical variables.


@ONLINE{uclasinger,
	author = {Bruin, J.},
	 title = {Using SAS Proc Mixed to Fit Multilevel Models,
	Hierarchical Models, and Individual Growth Models {ONLINE}},
	month = FEB,
	year = {2011},
	 url = {http://www.ats.ucla.edu/stat/paperexamples/singer/}
}

Rabe-Hesketh, Sophia and Multilevel and Longitudinal Modeling Using
Stata, Third Edition

Skrondal, Anders, & Sophia Rabe-Hesketh(2004). Generalized Latent
Variable Modeling: Multilevel, Longitudinal, and Structural Equation
Models. New York, NY: Chapman & Hall/CRC.

Raudenbush, S. W., & Bryk, A. S. (2002). Hierarchical linear models:
applications and data analysis methods. Thousand Oaks, CA: Sage.

Zahs, D., Pedlow, S., Morrissey, M., Marnell, P., Nichols,
B. 1995. High School and Beyond Fourth Follow-Up Methodology
Report. Prepared by the National Opinion Research Center for the
National Center for Education Statistics.


