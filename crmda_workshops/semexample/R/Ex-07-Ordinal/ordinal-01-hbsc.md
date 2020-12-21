---
title: "SEM Example 07 - Comparing ML and WLSMV Estimators for Ordinal, Likert-Type Items"
subtitle: "Demonstrations with the Health Behaviour in School-Aged Children Dataset"
author:
  - name: Chong Xing
    affiliation: Center for Research Methods and Data Analysis, University of Kansas
    email: cxing@ku.edu
  - name: Paul Johnson
    affiliation: Center for Research Methods and Data Analysis, University of Kansas
    email: pauljohn@ku.edu
  - name: Meghan Sullivan
    affiliation: Center for Research Methods and Data Analysis, University of Kansas
    email: meg.sullivan@ku.edu
advertise: >
    Please  visit [http://crmda.ku.edu/guides](http://crmda.ku.edu/guides)
keywords: Structural Equation Modeling, Ordinal Data, Weighted Least Squares Estimators, Maximum Likelihood, HBSC"
abstract: >
  Likert scale data can be treated as numbers, say 1 through 5, or
    they can be treated as ordinal labels, say "Strongly Disagree" to
    "Strongly Agree".  Methods to estimate the ordinal version have
    been available for some time, and yet it is still common to treat
    the ordinal data as if it were numeric. Here we explore the
    question by presenting examples of structural equation models estimated in
    both ways. The Maximum Likelihood (ML) method is used when the
    data are treated as numbers, while Weighted Least Squares (WLSMV)
    estimator is employed when the data is treated as
    categorical. Example data was obtained from the Health Behavior 
    in School-Aged Children study 
    [(HBSC; Iannotti, 2005-2006)](https://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/28241?q=HBSC).
    Our data set includes students in grades 6 and 7 (N = 4,284). 
checked_by: "First Last"
Note to Authors: please_dont_change_the_next 4 lines!
output:
  stationery::crmda_html_document:
    toc: true
    toc_depth: 2
    theme: null
    css: theme/kutils.css
    template: theme/guide-template.html
    mathjax-url: "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
logoleft: theme/logoleft.png
logoright: theme/logo-vert.png
---





# Data Importation

A subset of the HBSC data, `hbsc-subset2.dat`, was created and prepared
for usage in Mplus. The Mplus exercises that investigate this data
can be found in [Mplus](../../Mplus/Ex-07-Ordinal "Mplus version of
ordinal data models").

Here we import the same data file in R, assign column names, and then
use the `kutils` variable key to create additional categorical
variables.


```r
hbsc.colnames <- scan(file.path(ddir, "hbsc-subset2-colnames.txt"), what = "character")
hbsc.orig <- read.table(file.path(ddir, "hbsc-subset2.dat"),
                        header = FALSE, col.names = hbsc.colnames,
                        na.strings = c("-999", ".", "NA"))
key <- keyImport("hbsc-subset2-key2.csv")
```

```
keyImport guessed that is a wide format key.
```

```r
hbsc <- keyApply(hbsc.orig, key, drop = FALSE, ignoreCase = FALSE, debug = FALSE,
                 diagnostic = FALSE)
```

The file named `hbsc-subset2.dat` is that "raw" text data file that
was used in our companion Mplus exercises. 

We restrict our attention to the students in the 6th and 7th grades.

```r
hbsc <- hbsc[!is.na(hbsc$Grade) & hbsc$Grade %in% c("6", "7"), ]
```

The variables in our R analysis have the same names that are used in
the Mplus files. However, to demonstrate the different methods
available in R for dealing with ordered categorical variables, we
insert ordinal versions of the same variables with the letters "_o"
appended.



<!-- html table generated in R 3.5.2 by xtable 1.8-3 package -->
<!-- Thu Jan 24 17:41:15 2019 -->
<table border=1>
<tr> <th> Ordinal.Versions </th> <th> Integer.Versions </th>  </tr>
  <tr> <td> body1r_o </td> <td> body1r </td> </tr>
  <tr> <td> body2_o </td> <td> body2 </td> </tr>
  <tr> <td> body3r_o </td> <td> body3r </td> </tr>
  <tr> <td> body4_o </td> <td> body4 </td> </tr>
  <tr> <td> body5r_o </td> <td> body5r </td> </tr>
  <tr> <td> phyhlth1_o </td> <td> phyhlth1 </td> </tr>
  <tr> <td> phyhlth2_o </td> <td> phyhlth2 </td> </tr>
  <tr> <td> phyhlth3_o </td> <td> phyhlth3 </td> </tr>
  <tr> <td> phyhlth4_o </td> <td> phyhlth4 </td> </tr>
  <tr> <td> phyhlth5_o </td> <td> phyhlth5 </td> </tr>
  <tr> <td> phyhlth6_o </td> <td> phyhlth6 </td> </tr>
  <tr> <td> phyhlth7_o </td> <td> phyhlth7 </td> </tr>
  <tr> <td> phyhlth8_o </td> <td> phyhlth8 </td> </tr>
  <tr> <td> depress1_o </td> <td> depress1 </td> </tr>
  <tr> <td> depress2_o </td> <td> depress2 </td> </tr>
  <tr> <td> depress3_o </td> <td> depress3 </td> </tr>
  <tr> <td> depress4_o </td> <td> depress4 </td> </tr>
  <tr> <td> depress5_o </td> <td> depress5 </td> </tr>
  <tr> <td> depress6_o </td> <td> depress6 </td> </tr>
  <tr> <td> bullied1_o </td> <td> bullied1 </td> </tr>
  <tr> <td> bullied2_o </td> <td> bullied2 </td> </tr>
  <tr> <td> bullied3_o </td> <td> bullied3 </td> </tr>
  <tr> <td> bullied4_o </td> <td> bullied4 </td> </tr>
  <tr> <td> bullied5_o </td> <td> bullied5 </td> </tr>
  <tr> <td> bullied6_o </td> <td> bullied6 </td> </tr>
  <tr> <td> bullied7_o </td> <td> bullied7 </td> </tr>
  <tr> <td> bullied8_o </td> <td> bullied8 </td> </tr>
  <tr> <td> bullied9_o </td> <td> bullied9 </td> </tr>
  <tr> <td> bullier1_o </td> <td> bullier1 </td> </tr>
  <tr> <td> bullier2_o </td> <td> bullier2 </td> </tr>
  <tr> <td> bullier3_o </td> <td> bullier3 </td> </tr>
  <tr> <td> bullier4_o </td> <td> bullier4 </td> </tr>
  <tr> <td> bullier5_o </td> <td> bullier5 </td> </tr>
  <tr> <td> bullier6_o </td> <td> bullier6 </td> </tr>
  <tr> <td> bullier7_o </td> <td> bullier7 </td> </tr>
  <tr> <td> bullier8_o </td> <td> bullier8 </td> </tr>
  <tr> <td> bullier9_o </td> <td> bullier9 </td> </tr>
  <tr> <td> alc1_o </td> <td> alc1 </td> </tr>
  <tr> <td> alc2_o </td> <td> alc2 </td> </tr>
  <tr> <td> alc3_o </td> <td> alc3 </td> </tr>
  <tr> <td> alc4_o </td> <td> alc4 </td> </tr>
  <tr> <td> alc5_o </td> <td> alc5 </td> </tr>
   </table>

The following demonstrates that the R summary function is somewhat
 befuddled by the categorical variables.  When we provide the same
 information in 2 variables, one as an integer and one as a factor, 
 the numeric version is displayed quite differently (Mean and Median),
 while the categorical varsion is treated as tabular information. 


```r
vars <- c("Grade", "depress1", "depress2", "depress3", "depress1_o", "depress2_o", "depress3_o")
summary(hbsc[ , vars])
```

```
     Grade          depress1        depress2        depress3    
 Min.   :6.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
 1st Qu.:6.000   1st Qu.:1.000   1st Qu.:2.000   1st Qu.:1.000  
 Median :6.000   Median :2.000   Median :3.000   Median :1.000  
 Mean   :6.439   Mean   :2.332   Mean   :2.684   Mean   :1.817  
 3rd Qu.:7.000   3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:3.000  
 Max.   :7.000   Max.   :5.000   Max.   :5.000   Max.   :5.000  
                 NA's   :78      NA's   :87      NA's   :96     
     depress1_o       depress2_o       depress3_o  
 Never    :1212   Never    : 800   Never    :2558  
 Seldom   :1113   Seldom   : 977   Seldom   : 566  
 Sometimes:1307   Sometimes:1449   Sometimes: 558  
 Often    : 420   Often    : 693   Often    : 286  
 Always   : 154   Always   : 278   Always   : 220  
 NA's     :  78   NA's     :  87   NA's     :  96  
                                                   
```

The values represented `depress1` and `depress1_o` are the same. The
difference is that most R functions will treat `depress1` as an integer (or
numeric) score, while the ordinal variant is an R factor. For example:


```
                  depress1 as integer
depress1 as factor    1    2    3    4    5
         Never     1212    0    0    0    0
         Seldom       0 1113    0    0    0
         Sometimes    0    0 1307    0    0
         Often        0    0    0  420    0
         Always       0    0    0    0  154
```
## Complication: Missing Values (methodological moving target)

Historically, cases in which there  were missing values were subjected
to the listwise deletion. That was the standard through the 1970s and
1980s.

In the 1970s, would-be SEM practitioners had no choice. They were
forced to treat categorical "Likert-type" variables as if the scores
were numbers.  Although there were several different estimators
considered during that time, lets refer to them as "ML of covariance
structures," or ML for short.

Early in the 1980s, a chain of technical developments results in new
methods that explicitly treated the ordinal variables as categorical
methods. Again, there were several similar implementations with
slightly different terminology, but lets call these "Weighted Least
Squares" methods, or WLS for short.  Those methods were developed with
the assumption of listwise deletion of missing data.

There were efforts to find methods that avoided deletion of cases on
which there were missing values. The most important analytical
breakthrough was full information maximum likelihood, a method
suitable for numeric indicator variables.  Colloquilly referred to as
"FIML," this technique was originally developed for factor analysis.
Its technique was readily "grafted onto" estimators for confirmatory
factor analysis and structural equation models. FIML is regarded as an
analytic breakthrough and there are many studies which suggest it
should be preferred to listwise deletion.  It is possibly as good, or
even more desirable than, multiple imputation for missing values.

FIML requires individual-level data. In the days before FIML, we could
exchange covariance matrices and conduct replication analysis because
the covariance structure contained all of the information necessary to
conduct SEM calculations. That is not true of FIML, which uses the
individual scores to work its magic.  In a real sense, the adoption of
FIML was a methodological watershed. It was not meaningful, anymore,
to refer to the field as "the analysis of covariance structures" (as
it was known in the 1990s).

In the time when SEM was thought of as the analysis of covariance
structures, methods of dealing with missing values in the
construction of the observed covariance matrix were considered. The
"pairwise complete" method does what its name implies, it takes
variables in pairs and uses the available observations.  There were mixed
results about this method, some suggested it was less desirable even
than listwise deletion of missing values.

Now the bad news: FIML was not applicable to SEM estimators for
ordinal data. FIML succeeded in large part because the indicators were
assumed to be draws from a multivariate normal distribution. Since
that assumption does not apply when the observed variables are
discrete (ordinal) or non-normal, the researcher was forced
into an unpleasant choice. The options seemed to be

  1. Assert that the data is actually numeric (normal), in order to use FIML,
     or
  2. Apply the ordinal estimator, which uses listwise deletion of
  cases with missing values.
  

Those were the options, at least until very recently. This is the
point at which we hit a confusing problem. In order to compare results
between Mplus and R, it is necessary to keep track of at least three
key terms

  1. The estimator: ML, or WLS, or others
  2. The treatment of missing values: listwise deletion,
     pairwise-complete correlation matrix
  3. Corrections for standard errors and test diagnostics, often
     referred to as "robust" methods. 
	 
In order to align the results from R's lavaan package and Mplus, it is
necessary for us to make sure all 3 elements are in line. Estimates
can also be returned in different scalings, depending on the
parameters.

Once this is understood, we hit a problem.  Mplus implements some
estimators that are not available in R.

We are able to align the R and Mplus results for data that is treated
as if it were numeric. The estimator full information maximum
likelihood with robust standard errors (MLR) offers the same results
in either. Both use FIML. 

However, the Mplus estimators for categorical variables have changed
over the years. Mplus WLSMV is no longer using listwise deletion of
missing values. It now uses a "pairwise complete" correlation
matrix. We were "bitten" by the fact that WLSMV estimates from R's
lavaan and Mplus are no longer equivalent. In order to align the
lavaan estimates for categorical data using WLSMV with Mplus, we need
to run the Mplus estimator with the argument `LISTWISE ON;`. At the
current time, lavaan uses listwise deletion by default, but it is not
harmful to explicitly state `missing = "listwise"`

However, it now becomes tricky for us to compare the MLR estimates for
the numeric version with the categorical estimates because they are
based on samples of different sizes. We made it possible to align the
categorical data parameter estimates between Mplus and lavaan, but
within lavaan, it is more difficult to compare the numeric ML with
categorical WLSMV because the sample sizes differ. We ought to compare
WLSMV-listwise with ML-listwise, that is to say.

Putting that issue aside, in Mplus 7, a new maximum likelihood
estimator for the categorical data model was introduced. This is an ML
estimator for categorical indicators.  It uses the estimator familiar
to researchers in education, the marginal maximum likelihood estimator
that had risen to prominence in item response theory (IRT). The
IRT-based ML estimator in Mplus 7 is very time consuming and, at the
current time, the lavaan implementation of that estimator is under
development.


# SECTION-I: One-Factor CFA Models

This section presents three single-factor CFA analyses of depression,
alcohol use, and bullying victimization.  We provide two sets of
estimates, one that treats the 1-2-3-4-5 scores as if they were
numeric (MLR, Maximum Likelihood with Robust standard errors) and
ordinal (WLSMV, Weighted Least Squares with Mean and Variance
adjustment). The WLSMV estimates employ listwise deletion of missing values.

## One-Factor CFA for Depression

Depression was measured by six items with five-point Likert
scales. Items were framed with the following stem:

    "Think about how you have been feeling over the last 30 days.  Mark
    the number that goes with how often you have felt or done each of
    these." 

Example items include "Were you very sad?" and "Did you feel hopeless
about the future?"

Response options were 1) Never, 2) Seldom, 3) Sometimes, 4) Often, and
5) Always.

### Method 1 - ML estimates treat data as numeric

The first model is estimated with lavaan MLR.

A few highlights in our model code:

* Fixed-factor identification sets the factor variance equal
  to 1. This was done to set the scale of the latent variable.
* `NA*` specifies that the item's factor loading should be freely estimated.
* `depress ~~ 1*depress` sets/fixes the variance of the latent variable, `depress`, to 1.
* Alternatively, `std.lv = TRUE` can be included in the cfa() function to achieve the same purpose.



```r
cfa.depress <- '
depress =~ NA*depress1 + depress2 + depress3
            + depress4 + depress5 + depress6
depress ~~ 1*depress
'
```


```r
cfa.depress.mlr.listwise <-
  cfa(model = cfa.depress, data = hbsc,
      mimic = "Mplus", estimator = "MLR", meanstructure = TRUE, 
      missing = "listwise", std.ov = TRUE)
```

 * meanstructure: The `meanstructure` parameter is included because there is a quirk
 in the lavaan output.  With `missing = "listwise"`, the Intercepts are
 not included in the output, but with FIML, they are.
 * std.ov: The output from WLSMV will provide coefficients that are
   scaled. The most similar scaling for the MLR model is for
   standardized observed variables. (Note in the output the columns
   for the usual and standardized coefficients will be the same
   because of this setting.)

Lavaan's `summary` function does not create an output object. It
prints direct to the screen. The style of the output is similar to
another well-known SEM software program.


```r
summary(cfa.depress.mlr.listwise, fit.measures = TRUE, standardized = TRUE)
```

```
lavaan 0.6-3 ended normally after 12 iterations

  Optimization method                           NLMINB
  Number of free parameters                         18

                                                  Used       Total
  Number of observations                          4103        4284

  Estimator                                         ML      Robust
  Model Fit Test Statistic                     257.596     195.851
  Degrees of freedom                                 9           9
  P-value (Chi-square)                           0.000       0.000
  Scaling correction factor                                  1.315
    for the Yuan-Bentler correction (Mplus variant)

Model test baseline model:

  Minimum Function Test Statistic             5718.519    4373.368
  Degrees of freedom                                15          15
  P-value                                        0.000       0.000

User model versus baseline model:

  Comparative Fit Index (CFI)                    0.956       0.957
  Tucker-Lewis Index (TLI)                       0.927       0.929

  Robust Comparative Fit Index (CFI)                         0.957
  Robust Tucker-Lewis Index (TLI)                            0.928

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)             -32197.967  -32197.967
  Scaling correction factor                                  1.000
    for the MLR correction
  Loglikelihood unrestricted model (H1)     -32069.169  -32069.169
  Scaling correction factor                                  1.105
    for the MLR correction

  Number of free parameters                         18          18
  Akaike (AIC)                               64431.934   64431.934
  Bayesian (BIC)                             64545.684   64545.684
  Sample-size adjusted Bayesian (BIC)        64488.488   64488.488

Root Mean Square Error of Approximation:

  RMSEA                                          0.082       0.071
  90 Percent Confidence Interval          0.074  0.091       0.064  0.079
  P-value RMSEA <= 0.05                          0.000       0.000

  Robust RMSEA                                               0.082
  90 Percent Confidence Interval                             0.072  0.092

Standardized Root Mean Square Residual:

  SRMR                                           0.030       0.030

Parameter Estimates:

  Information                                 Observed
  Observed information based on                Hessian
  Standard Errors                   Robust.huber.white

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  depress =~                                                            
    depress1          0.668    0.016   41.208    0.000    0.668    0.668
    depress2          0.616    0.016   38.771    0.000    0.616    0.616
    depress3          0.656    0.018   37.152    0.000    0.656    0.656
    depress4          0.652    0.016   42.079    0.000    0.652    0.652
    depress5          0.543    0.016   32.912    0.000    0.543    0.543
    depress6          0.547    0.017   32.907    0.000    0.547    0.547

Intercepts:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .depress1         -0.000    0.016   -0.000    1.000   -0.000   -0.000
   .depress2          0.000    0.016    0.000    1.000    0.000    0.000
   .depress3          0.000    0.016    0.000    1.000    0.000    0.000
   .depress4         -0.000    0.016   -0.000    1.000   -0.000   -0.000
   .depress5         -0.000    0.016   -0.000    1.000   -0.000   -0.000
   .depress6         -0.000    0.016   -0.000    1.000   -0.000   -0.000
    depress           0.000                               0.000    0.000

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
    depress           1.000                               1.000    1.000
   .depress1          0.554    0.017   32.684    0.000    0.554    0.554
   .depress2          0.620    0.017   36.527    0.000    0.620    0.621
   .depress3          0.569    0.018   31.370    0.000    0.569    0.569
   .depress4          0.574    0.017   33.127    0.000    0.574    0.574
   .depress5          0.705    0.018   39.011    0.000    0.705    0.705
   .depress6          0.700    0.018   38.212    0.000    0.700    0.701
```




After this point, we will not include the voluminous output within our
presentation here. Instead, we will divert the output into files that
can be reviewed in separate files. For this summary, the lavaan output
is saved in the file:
[output/cfa.depress.mlr.listwise.Rout](output/cfa.depress.mlr.listwise.Rout)


If the listwise option is not specified, ML uses the so-called FIML
estimator, which does not result in the omission of as many cases in
this CFA. Note the Warning, however.  Some cases are missing on all
of the variables, so they are removed from the analysis.  In order to
be kept in the calculation, an observation must have at least one
observed value on an indicator (and there must be no missings on 
exogenous predictor variables, but that is not a concern here).


```r
cfa.depress.mlr.fiml <- cfa(model = cfa.depress, data = hbsc,
                            mimic = "Mplus", estimator = "MLR",
                            meanstructure = TRUE, std.ov = TRUE)
```

```
Warning in lav_data_full(data = data, group = group, cluster = cluster, : lavaan WARNING: some cases are empty and will be ignored:
  40 47 121 179 189 233 297 315 325 362 506 526 558 663 779 846 847 1006 1177 1200 1204 1222 1228 1241 1530 1533 1597 1614 1662 1671 1688 1856 1925 1961 2011 2039 2087 2203 2238 2264 2272 2282 2324 2381 2385 2390 2605 2750 2809 2867 3015 3391 3398 3551 3673 3724 3763 3875 3938 3985 4094 4198 4201
```


```r
summary(cfa.depress.mlr.fiml, fit.measures = TRUE, standardized = TRUE)
```


The lavaan output is saved in the file:
[output/cfa.depress.mlr.fiml.Rout](output/cfa.depress.mlr.fiml.Rout "CFA output")


### Method 2 - The ordinal "threshold" model with WLS

A casual inspection of the variables indicates that the 5 point
scales are quite skewed. These might be the "right tail" of a normal
variable that has been split into categorized sections. 

![](tmpout/p-unnamed-chunk-1-1.png)<!-- -->

Because our variables that are named with "_o" are declared as ordered
factors, the fitting function in lavaan will notice that they are not
numeric and estimate them accordingly. We rewrite the lavaan formula
as follows


```r
cfa.depress.ord <- '
depress =~ NA*depress1_o + depress2_o + depress3_o
            + depress4_o + depress5_o + depress6_o
depress ~~ 1*depress
'
```


```r
cfa.depress.ord.wlsmv <-
    cfa(model = cfa.depress.ord, data = hbsc, mimic = "Mplus",
        estimator = "WLSMV", missing = "listwise")
```


```r
summary(cfa.depress.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)
```


<!-- ```{r cfa.depress.ord.summary} -->
<!-- summary(cfa.depress.ord.wlsmv, fit.measures = TRUE, standardized = TRUE) -->
<!-- ``` -->


The lavaan output is saved in the file:
[output/cfa.depress.ord.wlsmv.listwise.Rout](output/cfa.depress.ord.wlsmv.listwise.Rout "CFA output")


* We specify `WLSMV` as the estimator. This is WLS with corrections
  for the standard errors and diagnostic statistics. 
* The option `mimic = "Mplus"` is used in our effort to synchronize these results with
  the estimates from Mplus in the companion exercise.
* The estimates are unchanged if we insert `missing = "listwise"` in
  the function call. That's because listwise deletion is the current
  default.
* The summary method includes `standardized = TRUE`, which does not
  alter the main parameter estimates, but prints supplementary
  information in the form of standardized coefficient estimates on the
  right side of the table.
  
It is not truly necessary to use ordinal factor variables to estimate
this model. We could obtain the same result by declaring the variables
explicitly as ordered. Recall that in our formula `cfa.depress` we
used the names of the numeric variables. The `lavaan` `cfa` function
has an argument `ordered` that allows us to specify that some
variables should be treated as categorical:


```r
cfa.depress.wlsmv2 <-
  cfa(model = cfa.depress, data = hbsc,
    mimic = "Mplus", estimator = "WLSMV",
    ordered = c("depress1", "depress2", "depress3",
                "depress4", "depress5", "depress6"))
```

* Please note that the "Used Number of observations" in the WLSMV
model is 4,103 compared to 4,221 in the ML FIML model where we did not 
enforce listwise deletion. 

* Based on the listwise-deleted data (N = 4,103), the WLSMV estimation
produced better model fit on CFI, TLI, RMSEA, and SRMR.

A summary table comparing the 2 ML models, along with the WLSMV
estimates for the ordinal model, is provided next.

<table style="padding-right:20px;padding-left:20px;">

 <tr><td></td><td colspan = '1'; align = 'center'>ML (FIML)</td><td colspan = '1'; align = 'center'>ML (listwise)</td><td colspan = '1'; align = 'center'>WLSMV</td></tr>
 
 <tr><td></td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td></tr>
 
 <tr><td></td><td colspan = '3'; align = 'center'><span style="text-decoration: underline;">Factor Loadings</span></td></tr> <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">depress</span></td></tr>
<tr><td>depress1</td><td>0.66{(0.02)}<sup>***</sup></td><td>0.67{(0.02)}<sup>***</sup></td><td>0.71{(0.01)}<sup>***</sup></td></tr>
<tr><td>depress2</td><td>0.62{(0.02)}<sup>***</sup></td><td>0.62{(0.02)}<sup>***</sup></td><td>0.66{(0.01)}<sup>***</sup></td></tr>
<tr><td>depress3</td><td>0.65{(0.02)}<sup>***</sup></td><td>0.66{(0.02)}<sup>***</sup></td><td>0.74{(0.01)}<sup>***</sup></td></tr>
<tr><td>depress4</td><td>0.65{(0.02)}<sup>***</sup></td><td>0.65{(0.02)}<sup>***</sup></td><td>0.72{(0.01)}<sup>***</sup></td></tr>
<tr><td>depress5</td><td>0.54{(0.02)}<sup>***</sup></td><td>0.54{(0.02)}<sup>***</sup></td><td>0.60{(0.01)}<sup>***</sup></td></tr>
<tr><td>depress6</td><td>0.54{(0.02)}<sup>***</sup></td><td>0.55{(0.02)}<sup>***</sup></td><td>0.59{(0.01)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '3'; align = 'center'><span style="text-decoration: underline;">Intercepts</span></td></tr>
<tr><td>depress1</td><td>0.00{(0.02)}&nbsp;</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress2</td><td>0.00{(0.02)}&nbsp;</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress3</td><td>0.00{(0.02)}&nbsp;</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress4</td><td>0.00{(0.02)}&nbsp;</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress5</td><td>0.00{(0.02)}&nbsp;</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress6</td><td>0.00{(0.02)}&nbsp;</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '3'; align = 'center'><span style="text-decoration: underline;">Residual Variances</span></td></tr>
<tr><td>depress1</td><td>0.56{(0.02)}<sup>***</sup></td><td>0.55{(0.02)}<sup>***</sup></td><td>0.50<sup>+</sup></td></tr>
<tr><td>depress2</td><td>0.62{(0.02)}<sup>***</sup></td><td>0.62{(0.02)}<sup>***</sup></td><td>0.57<sup>+</sup></td></tr>
<tr><td>depress3</td><td>0.57{(0.02)}<sup>***</sup></td><td>0.57{(0.02)}<sup>***</sup></td><td>0.45<sup>+</sup></td></tr>
<tr><td>depress4</td><td>0.57{(0.02)}<sup>***</sup></td><td>0.57{(0.02)}<sup>***</sup></td><td>0.49<sup>+</sup></td></tr>
<tr><td>depress5</td><td>0.71{(0.02)}<sup>***</sup></td><td>0.71{(0.02)}<sup>***</sup></td><td>0.64<sup>+</sup></td></tr>
<tr><td>depress6</td><td>0.71{(0.02)}<sup>***</sup></td><td>0.70{(0.02)}<sup>***</sup></td><td>0.65<sup>+</sup></td></tr>
<tr><td></td><td colspan = '3'; align = 'center'><span style="text-decoration: underline;">Latent Intercepts</span></td></tr>
<tr><td>depress</td><td>0.00<sup>+</sup></td><td>0.00<sup>+</sup></td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '3'; align = 'center'><span style="text-decoration: underline;">Latent Variances</span></td></tr>
<tr><td>depress</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '3'; align = 'center'><span style="text-decoration: underline;">Thresholds</span></td></tr>
<tr><td>depress1(1)</td><td></td><td></td><td>-0.56{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress1(2)</td><td></td><td></td><td>0.13{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress1(3)</td><td></td><td></td><td>1.10{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress1(4)</td><td></td><td></td><td>1.79{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress2(1)</td><td></td><td></td><td>-0.87{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress2(2)</td><td></td><td></td><td>-0.19{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress2(3)</td><td></td><td></td><td>0.74{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress2(4)</td><td></td><td></td><td>1.51{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress3(1)</td><td></td><td></td><td>0.29{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress3(2)</td><td></td><td></td><td>0.67{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress3(3)</td><td></td><td></td><td>1.18{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress3(4)</td><td></td><td></td><td>1.62{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress4(1)</td><td></td><td></td><td>-0.11{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress4(2)</td><td></td><td></td><td>0.26{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress4(3)</td><td></td><td></td><td>0.89{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress4(4)</td><td></td><td></td><td>1.44{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress5(1)</td><td></td><td></td><td>-0.37{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress5(2)</td><td></td><td></td><td>0.07{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress5(3)</td><td></td><td></td><td>0.67{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress5(4)</td><td></td><td></td><td>1.23{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress6(1)</td><td></td><td></td><td>-0.43{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress6(2)</td><td></td><td></td><td>0.08{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress6(3)</td><td></td><td></td><td>0.74{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress6(4)</td><td></td><td></td><td>1.25{(0.03)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '3'; align = 'center'><span style="text-decoration: underline;">Fit Indices</span></td></tr>
<tr><td>Scaled &chi;<sup>2</sup></td><td>198.93(9)<sup>***</sup></td><td>195.85(9)<sup>***</sup></td><td>315.34(9)<sup>***</sup></td></tr>
<tr><td>CFI</td><td>0.96</td><td>0.96</td><td>0.99</td></tr>
<tr><td>TLI</td><td>0.93</td><td>0.93</td><td>0.98</td></tr>
<tr><td>RMSEA</td><td>0.08</td><td>0.08</td><td>0.07</td></tr>
 <br> <br><td colspan = '3'; align = 'left'><sup>+</sup>Fixed parameter</td></tr><br><td colspan = '3'; align = 'left'><sup>*</sup>p<0.05, <sup>**</sup>p<0.01, <sup>***</sup>p<0.001</td></tr><br> </table><br>
 

The ordinal model is, of course, "longer", in the sense that it 
estimates ordinal thresholds between categories. The coefficients
are thus not directly comparable. However, it is interesting to
compare the them and wonder if treating the variables as numeric
or ordinal really makes "such a big difference." 

The difference between ML with and without listwise deletion is 
a very interesting topic that we have worked on in other reports.
In these examples, we are intereted in comparing the WLSMV estimates
against the ML estimates based on the exact same (listwise deleted)
data. ***After this point, whenever we refer to ML estimates, we refer
to ML with listwise deletion.***

## One-Factor CFA for Bully Victimization

The next construct we present is bullying victimization, which was
measured by nine Likert-type items. Items were framed with the
following item stem:

"Here are some questions about bullying. We say a student is
BEING BULLIED when another student, or a group of students,
say or do nasty or unpleasant things to him or her. It is
also bullying when a student is teased repeatedly in a way
he or she does not like or when they are deliberately left
out of things. But it is NOT BULLYING when two students of
about the same strength or power argue or fight. It is also
not bullying when a student is teased in a friendly and
playful way.

How often have you been bullied at school in the past
couple of months in the ways listed below?" 

Example items include "I was called mean names, was made fun of, or
teased in a hurtful way" and "I was hit, kicked, pushed, shoved
around, or locked indoors."

Item response options include: 1) I haven't been bullied in this way,
2) Only once or twice, 3) 2 or 3 times a month, 4) About once a week,
and 5) Several times a week.

The first model is estimated with ML treating items as integers in R. 
This is a common yet inappropriate practice with ordinal, Likert response types.

* "bullied1_o" coded as ordered-factor variable
* "bullied1" coded as integer varable

### Method 1 - Treat ordinal data as continuous with ML

Items Coded as Integers


```r
cfa.bullied <- '
bullied =~ NA*bullied1 + bullied2 + bullied3
             + bullied4 + bullied5 + bullied6 
             + bullied7 + bullied8 + bullied9
bullied ~~ 1*bullied
'
```


```r
cfa.bullied.mlr.listwise <-
    cfa(model = cfa.bullied, data = hbsc, mimic = "Mplus",
        estimator = "MLR", missing = "listwise", meanstructure = TRUE,
        std.ov = TRUE)
```


```r
summary(cfa.bullied.mlr.listwise, fit.measures = TRUE, standardized = TRUE)
```



The lavaan output is saved in the file:
[output/cfa.bullied.mlr.listwise.Rout](output/cfa.bullied.mlr.listwise.Rout "CFA output")


### Method 2 - The ordinal "threshold" model with WLS

Items Coded as Ordered-Factors


```r
cfa.bullied.ord <- '
bullied =~ NA*bullied1_o + bullied2_o + bullied3_o
             + bullied4_o + bullied5_o + bullied6_o 
             + bullied7_o + bullied8_o  + bullied9_o
bullied ~~ 1*bullied
'
```



```r
cfa.bullied.ord.wlsmv <-
    cfa(model = cfa.bullied.ord, data = hbsc,  mimic = "Mplus",
        estimator = "WLSMV", meanstructure = TRUE)
```

The model summary table can be printed by running:


```r
summary(cfa.bullied.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)
```



The lavaan output is saved in [output/cfa.bullied.ord.wlsmv.listwise.Rout](output/cfa.bullied.ord.wlsmv.listwise.Rout "CFA output").

Rather than discuss the raw output, we prefer to align the output as a
more pleasant table, which can be done with the semTable function in kutils.



<table style="padding-right:20px;padding-left:20px;">

 <tr><td></td><td colspan = '1'; align = 'center'>ML (listwise)</td><td colspan = '1'; align = 'center'>WLSMV</td></tr>
 
 <tr><td></td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td></tr>
 
 <tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Factor Loadings</span></td></tr> <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">bullied</span></td></tr>
<tr><td>bullied1</td><td>0.63{(0.02)}<sup>***</sup></td><td>0.76{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied2</td><td>0.65{(0.03)}<sup>***</sup></td><td>0.78{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied3</td><td>0.69{(0.03)}<sup>***</sup></td><td>0.79{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied4</td><td>0.69{(0.02)}<sup>***</sup></td><td>0.80{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied5</td><td>0.71{(0.03)}<sup>***</sup></td><td>0.83{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied6</td><td>0.72{(0.04)}<sup>***</sup></td><td>0.87{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied7</td><td>0.65{(0.03)}<sup>***</sup></td><td>0.76{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied8</td><td>0.67{(0.05)}<sup>***</sup></td><td>0.87{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied9</td><td>0.66{(0.05)}<sup>***</sup></td><td>0.89{(0.01)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Intercepts</span></td></tr>
<tr><td>bullied1</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied2</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied3</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied4</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied5</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied6</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied7</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied8</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied9</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Residual Variances</span></td></tr>
<tr><td>bullied1</td><td>0.60{(0.03)}<sup>***</sup></td><td>0.43<sup>+</sup></td></tr>
<tr><td>bullied2</td><td>0.58{(0.03)}<sup>***</sup></td><td>0.39<sup>+</sup></td></tr>
<tr><td>bullied3</td><td>0.53{(0.03)}<sup>***</sup></td><td>0.37<sup>+</sup></td></tr>
<tr><td>bullied4</td><td>0.53{(0.03)}<sup>***</sup></td><td>0.36<sup>+</sup></td></tr>
<tr><td>bullied5</td><td>0.49{(0.03)}<sup>***</sup></td><td>0.30<sup>+</sup></td></tr>
<tr><td>bullied6</td><td>0.48{(0.04)}<sup>***</sup></td><td>0.24<sup>+</sup></td></tr>
<tr><td>bullied7</td><td>0.57{(0.03)}<sup>***</sup></td><td>0.42<sup>+</sup></td></tr>
<tr><td>bullied8</td><td>0.55{(0.04)}<sup>***</sup></td><td>0.25<sup>+</sup></td></tr>
<tr><td>bullied9</td><td>0.57{(0.05)}<sup>***</sup></td><td>0.20<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Intercepts</span></td></tr>
<tr><td>bullied</td><td>0.00<sup>+</sup></td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Variances</span></td></tr>
<tr><td>bullied</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Thresholds</span></td></tr>
<tr><td>bullied1(1)</td><td></td><td>0.26{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied1(2)</td><td></td><td>0.85{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(3)</td><td></td><td>1.06{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(4)</td><td></td><td>1.32{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(1)</td><td></td><td>0.47{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied2(2)</td><td></td><td>1.03{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(3)</td><td></td><td>1.24{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(4)</td><td></td><td>1.54{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied3(1)</td><td></td><td>0.90{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied3(2)</td><td></td><td>1.31{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied3(3)</td><td></td><td>1.53{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied3(4)</td><td></td><td>1.78{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied4(1)</td><td></td><td>0.31{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied4(2)</td><td></td><td>0.91{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(3)</td><td></td><td>1.19{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(4)</td><td></td><td>1.46{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied5(1)</td><td></td><td>1.00{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied5(2)</td><td></td><td>1.37{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied5(3)</td><td></td><td>1.56{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied5(4)</td><td></td><td>1.83{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied6(1)</td><td></td><td>1.25{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied6(2)</td><td></td><td>1.57{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied6(3)</td><td></td><td>1.79{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied6(4)</td><td></td><td>2.03{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied7(1)</td><td></td><td>0.65{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(2)</td><td></td><td>1.08{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(3)</td><td></td><td>1.29{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(4)</td><td></td><td>1.57{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(1)</td><td></td><td>1.35{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied8(2)</td><td></td><td>1.68{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(3)</td><td></td><td>1.86{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied8(4)</td><td></td><td>2.06{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied9(1)</td><td></td><td>1.47{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied9(2)</td><td></td><td>1.73{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied9(3)</td><td></td><td>1.87{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied9(4)</td><td></td><td>2.08{(0.06)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Fit Indices</span></td></tr>
<tr><td>Scaled &chi;<sup>2</sup></td><td>536.90(27)<sup>***</sup></td><td>551.13(27)<sup>***</sup></td></tr>
<tr><td>CFI</td><td>0.85</td><td>0.99</td></tr>
<tr><td>TLI</td><td>0.80</td><td>0.99</td></tr>
<tr><td>RMSEA</td><td>0.15</td><td>0.06</td></tr>
 <br> <br><td colspan = '2'; align = 'left'><sup>+</sup>Fixed parameter</td></tr><br><td colspan = '2'; align = 'left'><sup>*</sup>p<0.05, <sup>**</sup>p<0.01, <sup>***</sup>p<0.001</td></tr><br> </table><br>
 

<!-- * The response distribution of bully victimization items deviated even further from the normal -->
<!-- distribution compared to the depression item response distributions. This may explain why the ML -->
<!-- estimation of the CFA model did not fit as well as WLSMV in terms of the CFI, TLI, RMSEA, and SRMR. -->

## One-Factor CFA for Alcohol Use

The final construct we present of our single-factor CFA models is Alcohol Use. This construct
was measured by five Likert-type items.  Example items are as follows: 

    At present, how often do you drink anything alcoholic, such as beer,
    wine, or hard liquor like Vodka or rum?

    A. Beer

    Try to include even those times when you only drink a small amount
    (e.g., one or two sips)."

Items differed in the type of alcohol, including Beer, Wine,
Liquor/Spirits, Pre-mixed drinks (for example, Smirnoff Ice, Bacardi
Breezer, Mike's Hard Lemonade), and Any other drink that contains
alcohol.

Response options indicated the frequency of alcohol use, such as 1)
Everyday, 2) Every week, 3) Every month, 4) Rarely, 5) Never.

### Method 1 - Treat ordinal data as continuous with ML

Items Coded as Integers


```r
cfa.alc <- '
alcohol =~ NA*alc1 + alc2 + alc3
            + alc4 + alc5
alcohol ~~ 1*alcohol
'
```


```r
cfa.alc.mlr.listwise <-
    cfa(model = cfa.alc, data = hbsc, mimic = "Mplus",
        estimator = "MLR", missing = "listwise", meanstructure = TRUE, std.ov = TRUE)
```


```r
summary(cfa.alc.mlr.listwise, fit.measures = TRUE)
```



The lavaan output is saved in the file:
[output/cfa.alc.mlr.listwise.Rout](output/cfa.alc.mlr.listwise.Rout "CFA output")




### Method 2 - The ordinal "threshold" model with WLS
Items Coded as Ordered-Factors

```r
cfa.alc.ord <- '
alcohol =~ NA*alc1_o + alc2_o + alc3_o
            + alc4_o + alc5_o
alcohol ~~ 1*alcohol
'

cfa.alc.ord.wlsmv <-
    cfa(model = cfa.alc.ord, data = hbsc, mimic = "Mplus", estimator = "WLSMV",
        missing = "listwise")
```


```r
summary(cfa.alc.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)
```


The lavaan summary output is saved in
[output/cfa.alc.ord.wlsmv.listwise.Rout](output/cfa.alc.ord.wlsmv.listwise.Rout "CFA output"). 

Comparing the MLR and WLSMV estimates side by side, we
offer the following table:




<table style="padding-right:20px;padding-left:20px;">

 <tr><td></td><td colspan = '1'; align = 'center'>ML (listwise)</td><td colspan = '1'; align = 'center'>WLSMV</td></tr>
 
 <tr><td></td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td></tr>
 
 <tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Factor Loadings</span></td></tr> <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">alcohol</span></td></tr>
<tr><td>alc1</td><td>0.78{(0.04)}<sup>***</sup></td><td>0.87{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc2</td><td>0.68{(0.04)}<sup>***</sup></td><td>0.79{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc3</td><td>0.85{(0.04)}<sup>***</sup></td><td>0.95{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc4</td><td>0.78{(0.04)}<sup>***</sup></td><td>0.88{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc5</td><td>0.84{(0.04)}<sup>***</sup></td><td>0.92{(0.01)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Intercepts</span></td></tr>
<tr><td>alc1</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc2</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc3</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc4</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc5</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Residual Variances</span></td></tr>
<tr><td>alc1</td><td>0.40{(0.03)}<sup>***</sup></td><td>0.24<sup>+</sup></td></tr>
<tr><td>alc2</td><td>0.54{(0.04)}<sup>***</sup></td><td>0.38<sup>+</sup></td></tr>
<tr><td>alc3</td><td>0.27{(0.03)}<sup>***</sup></td><td>0.10<sup>+</sup></td></tr>
<tr><td>alc4</td><td>0.39{(0.03)}<sup>***</sup></td><td>0.22<sup>+</sup></td></tr>
<tr><td>alc5</td><td>0.29{(0.03)}<sup>***</sup></td><td>0.16<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Intercepts</span></td></tr>
<tr><td>alcohol</td><td>0.00<sup>+</sup></td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Variances</span></td></tr>
<tr><td>alcohol</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Thresholds</span></td></tr>
<tr><td>alc1(1)</td><td></td><td>1.13{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc1(2)</td><td></td><td>1.86{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc1(3)</td><td></td><td>2.17{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc1(4)</td><td></td><td>2.32{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc2(1)</td><td></td><td>0.99{(0.02)}<sup>***</sup></td></tr>
<tr><td>alc2(2)</td><td></td><td>1.84{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc2(3)</td><td></td><td>2.09{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc2(4)</td><td></td><td>2.41{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc3(1)</td><td></td><td>1.37{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc3(2)</td><td></td><td>1.85{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc3(3)</td><td></td><td>2.09{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc3(4)</td><td></td><td>2.35{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc4(1)</td><td></td><td>1.03{(0.02)}<sup>***</sup></td></tr>
<tr><td>alc4(2)</td><td></td><td>1.62{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc4(3)</td><td></td><td>1.96{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc4(4)</td><td></td><td>2.21{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc5(1)</td><td></td><td>1.13{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc5(2)</td><td></td><td>1.76{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc5(3)</td><td></td><td>2.04{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc5(4)</td><td></td><td>2.31{(0.06)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Fit Indices</span></td></tr>
<tr><td>Scaled &chi;<sup>2</sup></td><td>12.95(5)<sup>*</sup></td><td>31.14(5)<sup>***</sup></td></tr>
<tr><td>CFI</td><td>0.99</td><td>1.00</td></tr>
<tr><td>TLI</td><td>0.99</td><td>1.00</td></tr>
<tr><td>RMSEA</td><td>0.06</td><td>0.02</td></tr>
 <br> <br><td colspan = '2'; align = 'left'><sup>+</sup>Fixed parameter</td></tr><br><td colspan = '2'; align = 'left'><sup>*</sup>p<0.05, <sup>**</sup>p<0.01, <sup>***</sup>p<0.001</td></tr><br> </table><br>
 



# SECTION-II: A Three-Factor CFA
Factors: Bullying Victimization, Depression, and Alcohol Use

## Method 1 - Treat ordinal data as continuous with ML


```r
cfa.3factor <- '
bullied =~ NA*bullied1 + bullied2 + bullied3
             + bullied4 + bullied5 + bullied6
             + bullied7 + bullied8 + bullied9
bullied ~~ 1*bullied
depress =~ NA*depress1 + depress2 + depress3
            + depress4 + depress5 + depress6
depress ~~ 1*depress
alcohol =~ NA*alc1 + alc2 + alc3
            + alc4 + alc5
alcohol ~~ 1*alcohol
'
```


```r
cfa.3factor.mlr.listwise <-
    cfa(model = cfa.3factor, data = hbsc,  mimic = "Mplus", estimator = "MLR",
        missing = "listwise", meanstructure = TRUE, std.ov = TRUE)
```


```r
summary(cfa.3factor.mlr.listwise, fit.measures = TRUE, standardized = TRUE)
```

```
lavaan 0.6-3 ended normally after 18 iterations

  Optimization method                           NLMINB
  Number of free parameters                         63

                                                  Used       Total
  Number of observations                          2684        4284

  Estimator                                         ML      Robust
  Model Fit Test Statistic                    2201.447    1225.319
  Degrees of freedom                               167         167
  P-value (Chi-square)                           0.000       0.000
  Scaling correction factor                                  1.797
    for the Yuan-Bentler correction (Mplus variant)

Model test baseline model:

  Minimum Function Test Statistic            22007.778   11122.450
  Degrees of freedom                               190         190
  P-value                                        0.000       0.000

User model versus baseline model:

  Comparative Fit Index (CFI)                    0.907       0.903
  Tucker-Lewis Index (TLI)                       0.894       0.890

  Robust Comparative Fit Index (CFI)                         0.912
  Robust Tucker-Lewis Index (TLI)                            0.900

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)             -66255.453  -66255.453
  Scaling correction factor                                  3.082
    for the MLR correction
  Loglikelihood unrestricted model (H1)     -65154.730  -65154.730
  Scaling correction factor                                  2.149
    for the MLR correction

  Number of free parameters                         63          63
  Akaike (AIC)                              132636.906  132636.906
  Bayesian (BIC)                            133008.295  133008.295
  Sample-size adjusted Bayesian (BIC)       132808.125  132808.125

Root Mean Square Error of Approximation:

  RMSEA                                          0.067       0.049
  90 Percent Confidence Interval          0.065  0.070       0.047  0.051
  P-value RMSEA <= 0.05                          0.000       0.886

  Robust RMSEA                                               0.065
  90 Percent Confidence Interval                             0.062  0.069

Standardized Root Mean Square Residual:

  SRMR                                           0.046       0.046

Parameter Estimates:

  Information                                 Observed
  Observed information based on                Hessian
  Standard Errors                   Robust.huber.white

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  bullied =~                                                            
    bullied1          0.626    0.025   25.356    0.000    0.626    0.626
    bullied2          0.647    0.026   24.948    0.000    0.647    0.648
    bullied3          0.686    0.033   20.851    0.000    0.686    0.686
    bullied4          0.686    0.023   29.184    0.000    0.686    0.686
    bullied5          0.718    0.036   20.204    0.000    0.718    0.718
    bullied6          0.722    0.047   15.454    0.000    0.722    0.723
    bullied7          0.650    0.026   24.851    0.000    0.650    0.650
    bullied8          0.671    0.054   12.516    0.000    0.671    0.671
    bullied9          0.653    0.057   11.450    0.000    0.653    0.653
  depress =~                                                            
    depress1          0.665    0.020   33.626    0.000    0.665    0.665
    depress2          0.609    0.020   31.109    0.000    0.609    0.609
    depress3          0.654    0.022   29.635    0.000    0.654    0.654
    depress4          0.653    0.019   34.495    0.000    0.653    0.653
    depress5          0.551    0.020   27.577    0.000    0.551    0.551
    depress6          0.563    0.020   28.069    0.000    0.563    0.563
  alcohol =~                                                            
    alc1              0.753    0.051   14.787    0.000    0.753    0.753
    alc2              0.640    0.049   12.961    0.000    0.640    0.640
    alc3              0.852    0.051   16.721    0.000    0.852    0.852
    alc4              0.784    0.043   18.228    0.000    0.784    0.784
    alc5              0.831    0.047   17.684    0.000    0.831    0.831

Covariances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  bullied ~~                                                            
    depress           0.371    0.031   12.102    0.000    0.371    0.371
    alcohol           0.236    0.041    5.809    0.000    0.236    0.236
  depress ~~                                                            
    alcohol           0.258    0.029    8.778    0.000    0.258    0.258

Intercepts:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .bullied1          0.000    0.019    0.000    1.000    0.000    0.000
   .bullied2         -0.000    0.019   -0.000    1.000   -0.000   -0.000
   .bullied3         -0.000    0.019   -0.000    1.000   -0.000   -0.000
   .bullied4          0.000    0.019    0.000    1.000    0.000    0.000
   .bullied5          0.000    0.019    0.000    1.000    0.000    0.000
   .bullied6          0.000    0.019    0.000    1.000    0.000    0.000
   .bullied7          0.000    0.019    0.000    1.000    0.000    0.000
   .bullied8          0.000    0.019    0.000    1.000    0.000    0.000
   .bullied9         -0.000    0.019   -0.000    1.000   -0.000   -0.000
   .depress1          0.000    0.019    0.000    1.000    0.000    0.000
   .depress2         -0.000    0.019   -0.000    1.000   -0.000   -0.000
   .depress3         -0.000    0.019   -0.000    1.000   -0.000   -0.000
   .depress4          0.000    0.019    0.000    1.000    0.000    0.000
   .depress5          0.000    0.019    0.000    1.000    0.000    0.000
   .depress6         -0.000    0.019   -0.000    1.000   -0.000   -0.000
   .alc1             -0.000    0.019   -0.000    1.000   -0.000   -0.000
   .alc2              0.000    0.019    0.000    1.000    0.000    0.000
   .alc3              0.000    0.019    0.000    1.000    0.000    0.000
   .alc4             -0.000    0.019   -0.000    1.000   -0.000   -0.000
   .alc5              0.000    0.019    0.000    1.000    0.000    0.000
    bullied           0.000                               0.000    0.000
    depress           0.000                               0.000    0.000
    alcohol           0.000                               0.000    0.000

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
    bullied           1.000                               1.000    1.000
    depress           1.000                               1.000    1.000
    alcohol           1.000                               1.000    1.000
   .bullied1          0.608    0.030   20.078    0.000    0.608    0.608
   .bullied2          0.580    0.032   18.218    0.000    0.580    0.581
   .bullied3          0.529    0.033   15.803    0.000    0.529    0.529
   .bullied4          0.530    0.028   18.789    0.000    0.530    0.530
   .bullied5          0.484    0.035   14.034    0.000    0.484    0.485
   .bullied6          0.478    0.040   11.981    0.000    0.478    0.478
   .bullied7          0.578    0.033   17.508    0.000    0.578    0.578
   .bullied8          0.549    0.045   12.232    0.000    0.549    0.549
   .bullied9          0.573    0.049   11.804    0.000    0.573    0.573
   .depress1          0.557    0.020   27.908    0.000    0.557    0.558
   .depress2          0.629    0.021   29.864    0.000    0.629    0.629
   .depress3          0.572    0.023   25.357    0.000    0.572    0.572
   .depress4          0.574    0.021   27.433    0.000    0.574    0.574
   .depress5          0.697    0.022   31.654    0.000    0.697    0.697
   .depress6          0.683    0.022   30.814    0.000    0.683    0.683
   .alc1              0.433    0.038   11.306    0.000    0.433    0.433
   .alc2              0.590    0.046   12.861    0.000    0.590    0.590
   .alc3              0.274    0.035    7.746    0.000    0.274    0.274
   .alc4              0.385    0.038   10.184    0.000    0.385    0.385
   .alc5              0.309    0.032    9.661    0.000    0.309    0.309
```

## Method 2 - The ordinal "threshold" model with WLS

Items Coded as Ordered-Factors


```r
cfa.3factor.ord <- '
bullied =~ NA*bullied1_o + bullied2_o + bullied3_o
             + bullied4_o + bullied5_o + bullied6_o
             + bullied7_o + bullied8_o + bullied9_o
bullied ~~ 1*bullied
depress =~ NA*depress1_o + depress2_o + depress3_o
            + depress4_o + depress5_o + depress6_o
depress ~~ 1*depress
alcohol =~ NA*alc1_o + alc2_o + alc3_o
            + alc4_o + alc5_o
alcohol ~~ 1*alcohol
'
```


```r
cfa.3factor.ord.wlsmv <-
  cfa(model = cfa.3factor.ord, data = hbsc,
      mimic = "Mplus", estimator = "WLSMV")
```


```r
summary(cfa.3factor.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)
```





<table style="padding-right:20px;padding-left:20px;">

 <tr><td></td><td colspan = '1'; align = 'center'>ML (listwise)</td><td colspan = '1'; align = 'center'>WLSMV</td></tr>
 
 <tr><td></td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td></tr>
 
 <tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Factor Loadings</span></td></tr> <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">bullied</span></td></tr>
<tr><td>bullied1</td><td>0.63{(0.02)}<sup>***</sup></td><td>0.75{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied2</td><td>0.65{(0.03)}<sup>***</sup></td><td>0.78{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied3</td><td>0.69{(0.03)}<sup>***</sup></td><td>0.78{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied4</td><td>0.69{(0.02)}<sup>***</sup></td><td>0.81{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied5</td><td>0.72{(0.04)}<sup>***</sup></td><td>0.84{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied6</td><td>0.72{(0.05)}<sup>***</sup></td><td>0.87{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied7</td><td>0.65{(0.03)}<sup>***</sup></td><td>0.77{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied8</td><td>0.67{(0.05)}<sup>***</sup></td><td>0.86{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied9</td><td>0.65{(0.06)}<sup>***</sup></td><td>0.89{(0.02)}<sup>***</sup></td></tr>
 <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">depress</span></td></tr>
<tr><td>depress1</td><td>0.66{(0.02)}<sup>***</sup></td><td>0.70{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress2</td><td>0.61{(0.02)}<sup>***</sup></td><td>0.69{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress3</td><td>0.65{(0.02)}<sup>***</sup></td><td>0.78{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress4</td><td>0.65{(0.02)}<sup>***</sup></td><td>0.84{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress5</td><td>0.55{(0.02)}<sup>***</sup></td><td>0.73{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress6</td><td>0.56{(0.02)}<sup>***</sup></td><td>0.82{(0.04)}<sup>***</sup></td></tr>
 <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">alcohol</span></td></tr>
<tr><td>alc1</td><td>0.75{(0.05)}<sup>***</sup></td><td>0.86{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc2</td><td>0.64{(0.05)}<sup>***</sup></td><td>0.77{(0.02)}<sup>***</sup></td></tr>
<tr><td>alc3</td><td>0.85{(0.05)}<sup>***</sup></td><td>0.95{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc4</td><td>0.78{(0.04)}<sup>***</sup></td><td>0.88{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc5</td><td>0.83{(0.05)}<sup>***</sup></td><td>0.91{(0.01)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Intercepts</span></td></tr>
<tr><td>bullied1</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied2</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied3</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied4</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied5</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied6</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied7</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied8</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied9</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress1</td><td>0.00{(0.02)}&nbsp;</td><td>2.32{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress2</td><td>-0.00{(0.02)}&nbsp;</td><td>2.68{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress3</td><td>-0.00{(0.02)}&nbsp;</td><td>1.80{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress4</td><td>0.00{(0.02)}&nbsp;</td><td>2.22{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress5</td><td>0.00{(0.02)}&nbsp;</td><td>2.50{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress6</td><td>-0.00{(0.02)}&nbsp;</td><td>2.47{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc1</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc2</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc3</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc4</td><td>-0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc5</td><td>0.00{(0.02)}&nbsp;</td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Residual Variances</span></td></tr>
<tr><td>bullied1</td><td>0.61{(0.03)}<sup>***</sup></td><td>0.44<sup>+</sup></td></tr>
<tr><td>bullied2</td><td>0.58{(0.03)}<sup>***</sup></td><td>0.39<sup>+</sup></td></tr>
<tr><td>bullied3</td><td>0.53{(0.03)}<sup>***</sup></td><td>0.39<sup>+</sup></td></tr>
<tr><td>bullied4</td><td>0.53{(0.03)}<sup>***</sup></td><td>0.35<sup>+</sup></td></tr>
<tr><td>bullied5</td><td>0.48{(0.03)}<sup>***</sup></td><td>0.29<sup>+</sup></td></tr>
<tr><td>bullied6</td><td>0.48{(0.04)}<sup>***</sup></td><td>0.25<sup>+</sup></td></tr>
<tr><td>bullied7</td><td>0.58{(0.03)}<sup>***</sup></td><td>0.41<sup>+</sup></td></tr>
<tr><td>bullied8</td><td>0.55{(0.04)}<sup>***</sup></td><td>0.26<sup>+</sup></td></tr>
<tr><td>bullied9</td><td>0.57{(0.05)}<sup>***</sup></td><td>0.20<sup>+</sup></td></tr>
<tr><td>depress1</td><td>0.56{(0.02)}<sup>***</sup></td><td>0.73{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress2</td><td>0.63{(0.02)}<sup>***</sup></td><td>0.82{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress3</td><td>0.57{(0.02)}<sup>***</sup></td><td>0.83{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress4</td><td>0.57{(0.02)}<sup>***</sup></td><td>1.00{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress5</td><td>0.70{(0.02)}<sup>***</sup></td><td>1.34{(0.06)}<sup>***</sup></td></tr>
<tr><td>depress6</td><td>0.68{(0.02)}<sup>***</sup></td><td>1.10{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc1</td><td>0.43{(0.04)}<sup>***</sup></td><td>0.26<sup>+</sup></td></tr>
<tr><td>alc2</td><td>0.59{(0.05)}<sup>***</sup></td><td>0.40<sup>+</sup></td></tr>
<tr><td>alc3</td><td>0.27{(0.04)}<sup>***</sup></td><td>0.09<sup>+</sup></td></tr>
<tr><td>alc4</td><td>0.38{(0.04)}<sup>***</sup></td><td>0.22<sup>+</sup></td></tr>
<tr><td>alc5</td><td>0.31{(0.03)}<sup>***</sup></td><td>0.18<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Intercepts</span></td></tr>
<tr><td>bullied</td><td>0.00<sup>+</sup></td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress</td><td>0.00<sup>+</sup></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alcohol</td><td>0.00<sup>+</sup></td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Variances</span></td></tr>
<tr><td>bullied</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td>depress</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td>alcohol</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Covariances</span></td></tr>
<tr><td>bullied w/depress</td><td>0.37{(0.03)}<sup>***</sup></td><td>0.43{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied w/alcohol</td><td>0.24{(0.04)}<sup>***</sup></td><td>0.26{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress w/alcohol</td><td>0.26{(0.03)}<sup>***</sup></td><td>0.34{(0.03)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Thresholds</span></td></tr>
<tr><td>bullied1(1)</td><td></td><td>0.27{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied1(2)</td><td></td><td>0.85{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(3)</td><td></td><td>1.07{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(4)</td><td></td><td>1.32{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(1)</td><td></td><td>0.47{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(2)</td><td></td><td>1.03{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(3)</td><td></td><td>1.24{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(4)</td><td></td><td>1.54{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied3(1)</td><td></td><td>0.91{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied3(2)</td><td></td><td>1.33{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied3(3)</td><td></td><td>1.55{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied3(4)</td><td></td><td>1.80{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied4(1)</td><td></td><td>0.30{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied4(2)</td><td></td><td>0.92{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(3)</td><td></td><td>1.20{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(4)</td><td></td><td>1.46{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied5(1)</td><td></td><td>1.01{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied5(2)</td><td></td><td>1.37{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied5(3)</td><td></td><td>1.55{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied5(4)</td><td></td><td>1.83{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied6(1)</td><td></td><td>1.25{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied6(2)</td><td></td><td>1.58{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied6(3)</td><td></td><td>1.79{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied6(4)</td><td></td><td>2.03{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied7(1)</td><td></td><td>0.65{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(2)</td><td></td><td>1.08{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(3)</td><td></td><td>1.29{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(4)</td><td></td><td>1.56{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(1)</td><td></td><td>1.36{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied8(2)</td><td></td><td>1.69{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(3)</td><td></td><td>1.89{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied8(4)</td><td></td><td>2.08{(0.06)}<sup>***</sup></td></tr>
<tr><td>bullied9(1)</td><td></td><td>1.49{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied9(2)</td><td></td><td>1.74{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied9(3)</td><td></td><td>1.89{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied9(4)</td><td></td><td>2.07{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc1(1)</td><td></td><td>1.06{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc1(2)</td><td></td><td>1.84{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc1(3)</td><td></td><td>2.19{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc1(4)</td><td></td><td>2.43{(0.08)}<sup>***</sup></td></tr>
<tr><td>alc2(1)</td><td></td><td>0.93{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc2(2)</td><td></td><td>1.82{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc2(3)</td><td></td><td>2.12{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc2(4)</td><td></td><td>2.47{(0.08)}<sup>***</sup></td></tr>
<tr><td>alc3(1)</td><td></td><td>1.32{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc3(2)</td><td></td><td>1.82{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc3(3)</td><td></td><td>2.07{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc3(4)</td><td></td><td>2.43{(0.08)}<sup>***</sup></td></tr>
<tr><td>alc4(1)</td><td></td><td>0.98{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc4(2)</td><td></td><td>1.60{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc4(3)</td><td></td><td>2.00{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc4(4)</td><td></td><td>2.35{(0.07)}<sup>***</sup></td></tr>
<tr><td>alc5(1)</td><td></td><td>1.07{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc5(2)</td><td></td><td>1.72{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc5(3)</td><td></td><td>2.04{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc5(4)</td><td></td><td>2.35{(0.07)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Fit Indices</span></td></tr>
<tr><td>Scaled &chi;<sup>2</sup></td><td>1225.32(167)<sup>***</sup></td><td>993.15(167)<sup>***</sup></td></tr>
<tr><td>CFI</td><td>0.91</td><td>0.99</td></tr>
<tr><td>TLI</td><td>0.89</td><td>0.99</td></tr>
<tr><td>RMSEA</td><td>0.07</td><td>0.04</td></tr>
 <br> <br><td colspan = '2'; align = 'left'><sup>+</sup>Fixed parameter</td></tr><br><td colspan = '2'; align = 'left'><sup>*</sup>p<0.05, <sup>**</sup>p<0.01, <sup>***</sup>p<0.001</td></tr><br> </table><br>
 

One of the questions in CFA methodology that arises from time-to-time
is whether one ought to fit CFA models for each factor separately, or
if one should fit all of the separate factors in the first step. Some
veterans of SEM suggest one ought to dispense with the individual
factor estimates and proceed right to this step, where we have 3 sets
of observed indicators and 3 factors. 

The following table provides 4 sets of estimates side by side. The
estimates for the 3 factor model are in the 4th column, and we
are interested to know if the estimates of the factor loadings in the
individual models are called into question by the larger model.

<table style="padding-right:20px;padding-left:20px;">

 <tr><td></td><td colspan = '1'; align = 'center'>Alcohol</td><td colspan = '1'; align = 'center'>Bullied</td><td colspan = '1'; align = 'center'>Depression</td><td colspan = '1'; align = 'center'>3 factor</td></tr>
 
 <tr><td></td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td></tr>
 
 <tr><td></td><td colspan = '4'; align = 'center'><span style="text-decoration: underline;">Factor Loadings</span></td></tr> <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">alcohol</span></td></tr>
<tr><td>alc1</td><td>0.87{(0.01)}<sup>***</sup></td><td></td><td></td><td>0.86{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc2</td><td>0.79{(0.01)}<sup>***</sup></td><td></td><td></td><td>0.77{(0.02)}<sup>***</sup></td></tr>
<tr><td>alc3</td><td>0.95{(0.01)}<sup>***</sup></td><td></td><td></td><td>0.95{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc4</td><td>0.88{(0.01)}<sup>***</sup></td><td></td><td></td><td>0.88{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc5</td><td>0.92{(0.01)}<sup>***</sup></td><td></td><td></td><td>0.91{(0.01)}<sup>***</sup></td></tr>
 <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">bullied</span></td></tr>
<tr><td>bullied1</td><td></td><td>0.76{(0.01)}<sup>***</sup></td><td></td><td>0.75{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied2</td><td></td><td>0.78{(0.01)}<sup>***</sup></td><td></td><td>0.78{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied3</td><td></td><td>0.79{(0.01)}<sup>***</sup></td><td></td><td>0.78{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied4</td><td></td><td>0.80{(0.01)}<sup>***</sup></td><td></td><td>0.81{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied5</td><td></td><td>0.83{(0.01)}<sup>***</sup></td><td></td><td>0.84{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied6</td><td></td><td>0.87{(0.01)}<sup>***</sup></td><td></td><td>0.87{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied7</td><td></td><td>0.76{(0.01)}<sup>***</sup></td><td></td><td>0.77{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied8</td><td></td><td>0.87{(0.01)}<sup>***</sup></td><td></td><td>0.86{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied9</td><td></td><td>0.89{(0.01)}<sup>***</sup></td><td></td><td>0.89{(0.02)}<sup>***</sup></td></tr>
 <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">depress</span></td></tr>
<tr><td>depress1</td><td></td><td></td><td>0.71{(0.01)}<sup>***</sup></td><td>0.70{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress2</td><td></td><td></td><td>0.66{(0.01)}<sup>***</sup></td><td>0.69{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress3</td><td></td><td></td><td>0.74{(0.01)}<sup>***</sup></td><td>0.78{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress4</td><td></td><td></td><td>0.72{(0.01)}<sup>***</sup></td><td>0.84{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress5</td><td></td><td></td><td>0.60{(0.01)}<sup>***</sup></td><td>0.73{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress6</td><td></td><td></td><td>0.59{(0.01)}<sup>***</sup></td><td>0.82{(0.04)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '4'; align = 'center'><span style="text-decoration: underline;">Intercepts</span></td></tr>
<tr><td>alc1</td><td>0.00<sup>+</sup></td><td></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc2</td><td>0.00<sup>+</sup></td><td></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc3</td><td>0.00<sup>+</sup></td><td></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc4</td><td>0.00<sup>+</sup></td><td></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc5</td><td>0.00<sup>+</sup></td><td></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied1</td><td></td><td>0.00<sup>+</sup></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied2</td><td></td><td>0.00<sup>+</sup></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied3</td><td></td><td>0.00<sup>+</sup></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied4</td><td></td><td>0.00<sup>+</sup></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied5</td><td></td><td>0.00<sup>+</sup></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied6</td><td></td><td>0.00<sup>+</sup></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied7</td><td></td><td>0.00<sup>+</sup></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied8</td><td></td><td>0.00<sup>+</sup></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied9</td><td></td><td>0.00<sup>+</sup></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress1</td><td></td><td></td><td>0.00<sup>+</sup></td><td>2.32{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress2</td><td></td><td></td><td>0.00<sup>+</sup></td><td>2.68{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress3</td><td></td><td></td><td>0.00<sup>+</sup></td><td>1.80{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress4</td><td></td><td></td><td>0.00<sup>+</sup></td><td>2.22{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress5</td><td></td><td></td><td>0.00<sup>+</sup></td><td>2.50{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress6</td><td></td><td></td><td>0.00<sup>+</sup></td><td>2.47{(0.03)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '4'; align = 'center'><span style="text-decoration: underline;">Residual Variances</span></td></tr>
<tr><td>alc1</td><td>0.24<sup>+</sup></td><td></td><td></td><td>0.26<sup>+</sup></td></tr>
<tr><td>alc2</td><td>0.38<sup>+</sup></td><td></td><td></td><td>0.40<sup>+</sup></td></tr>
<tr><td>alc3</td><td>0.10<sup>+</sup></td><td></td><td></td><td>0.09<sup>+</sup></td></tr>
<tr><td>alc4</td><td>0.22<sup>+</sup></td><td></td><td></td><td>0.22<sup>+</sup></td></tr>
<tr><td>alc5</td><td>0.16<sup>+</sup></td><td></td><td></td><td>0.18<sup>+</sup></td></tr>
<tr><td>bullied1</td><td></td><td>0.43<sup>+</sup></td><td></td><td>0.44<sup>+</sup></td></tr>
<tr><td>bullied2</td><td></td><td>0.39<sup>+</sup></td><td></td><td>0.39<sup>+</sup></td></tr>
<tr><td>bullied3</td><td></td><td>0.37<sup>+</sup></td><td></td><td>0.39<sup>+</sup></td></tr>
<tr><td>bullied4</td><td></td><td>0.36<sup>+</sup></td><td></td><td>0.35<sup>+</sup></td></tr>
<tr><td>bullied5</td><td></td><td>0.30<sup>+</sup></td><td></td><td>0.29<sup>+</sup></td></tr>
<tr><td>bullied6</td><td></td><td>0.24<sup>+</sup></td><td></td><td>0.25<sup>+</sup></td></tr>
<tr><td>bullied7</td><td></td><td>0.42<sup>+</sup></td><td></td><td>0.41<sup>+</sup></td></tr>
<tr><td>bullied8</td><td></td><td>0.25<sup>+</sup></td><td></td><td>0.26<sup>+</sup></td></tr>
<tr><td>bullied9</td><td></td><td>0.20<sup>+</sup></td><td></td><td>0.20<sup>+</sup></td></tr>
<tr><td>depress1</td><td></td><td></td><td>0.50<sup>+</sup></td><td>0.73{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress2</td><td></td><td></td><td>0.57<sup>+</sup></td><td>0.82{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress3</td><td></td><td></td><td>0.45<sup>+</sup></td><td>0.83{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress4</td><td></td><td></td><td>0.49<sup>+</sup></td><td>1.00{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress5</td><td></td><td></td><td>0.64<sup>+</sup></td><td>1.34{(0.06)}<sup>***</sup></td></tr>
<tr><td>depress6</td><td></td><td></td><td>0.65<sup>+</sup></td><td>1.10{(0.05)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '4'; align = 'center'><span style="text-decoration: underline;">Latent Intercepts</span></td></tr>
<tr><td>alcohol</td><td>0.00<sup>+</sup></td><td></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied</td><td></td><td>0.00<sup>+</sup></td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress</td><td></td><td></td><td>0.00<sup>+</sup></td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '4'; align = 'center'><span style="text-decoration: underline;">Latent Variances</span></td></tr>
<tr><td>alcohol</td><td>1.00<sup>+</sup></td><td></td><td></td><td>1.00<sup>+</sup></td></tr>
<tr><td>bullied</td><td></td><td>1.00<sup>+</sup></td><td></td><td>1.00<sup>+</sup></td></tr>
<tr><td>depress</td><td></td><td></td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '4'; align = 'center'><span style="text-decoration: underline;">Latent Covariances</span></td></tr>
<tr><td>bullied w/depress</td><td></td><td></td><td></td><td>0.43{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied w/alcohol</td><td></td><td></td><td></td><td>0.26{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress w/alcohol</td><td></td><td></td><td></td><td>0.34{(0.03)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '4'; align = 'center'><span style="text-decoration: underline;">Thresholds</span></td></tr>
<tr><td>alc1(1)</td><td>1.13{(0.03)}<sup>***</sup></td><td></td><td></td><td>1.06{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc1(2)</td><td>1.86{(0.04)}<sup>***</sup></td><td></td><td></td><td>1.84{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc1(3)</td><td>2.17{(0.05)}<sup>***</sup></td><td></td><td></td><td>2.19{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc1(4)</td><td>2.32{(0.06)}<sup>***</sup></td><td></td><td></td><td>2.43{(0.08)}<sup>***</sup></td></tr>
<tr><td>alc2(1)</td><td>0.99{(0.02)}<sup>***</sup></td><td></td><td></td><td>0.93{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc2(2)</td><td>1.84{(0.04)}<sup>***</sup></td><td></td><td></td><td>1.82{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc2(3)</td><td>2.09{(0.05)}<sup>***</sup></td><td></td><td></td><td>2.12{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc2(4)</td><td>2.41{(0.06)}<sup>***</sup></td><td></td><td></td><td>2.47{(0.08)}<sup>***</sup></td></tr>
<tr><td>alc3(1)</td><td>1.37{(0.03)}<sup>***</sup></td><td></td><td></td><td>1.32{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc3(2)</td><td>1.85{(0.04)}<sup>***</sup></td><td></td><td></td><td>1.82{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc3(3)</td><td>2.09{(0.05)}<sup>***</sup></td><td></td><td></td><td>2.07{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc3(4)</td><td>2.35{(0.06)}<sup>***</sup></td><td></td><td></td><td>2.43{(0.08)}<sup>***</sup></td></tr>
<tr><td>alc4(1)</td><td>1.03{(0.02)}<sup>***</sup></td><td></td><td></td><td>0.98{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc4(2)</td><td>1.62{(0.03)}<sup>***</sup></td><td></td><td></td><td>1.60{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc4(3)</td><td>1.96{(0.04)}<sup>***</sup></td><td></td><td></td><td>2.00{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc4(4)</td><td>2.21{(0.05)}<sup>***</sup></td><td></td><td></td><td>2.35{(0.07)}<sup>***</sup></td></tr>
<tr><td>alc5(1)</td><td>1.13{(0.03)}<sup>***</sup></td><td></td><td></td><td>1.07{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc5(2)</td><td>1.76{(0.04)}<sup>***</sup></td><td></td><td></td><td>1.72{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc5(3)</td><td>2.04{(0.05)}<sup>***</sup></td><td></td><td></td><td>2.04{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc5(4)</td><td>2.31{(0.06)}<sup>***</sup></td><td></td><td></td><td>2.35{(0.07)}<sup>***</sup></td></tr>
<tr><td>bullied1(1)</td><td></td><td>0.26{(0.02)}<sup>***</sup></td><td></td><td>0.27{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied1(2)</td><td></td><td>0.85{(0.03)}<sup>***</sup></td><td></td><td>0.85{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(3)</td><td></td><td>1.06{(0.03)}<sup>***</sup></td><td></td><td>1.07{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(4)</td><td></td><td>1.32{(0.03)}<sup>***</sup></td><td></td><td>1.32{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(1)</td><td></td><td>0.47{(0.02)}<sup>***</sup></td><td></td><td>0.47{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(2)</td><td></td><td>1.03{(0.03)}<sup>***</sup></td><td></td><td>1.03{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(3)</td><td></td><td>1.24{(0.03)}<sup>***</sup></td><td></td><td>1.24{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(4)</td><td></td><td>1.54{(0.04)}<sup>***</sup></td><td></td><td>1.54{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied3(1)</td><td></td><td>0.90{(0.03)}<sup>***</sup></td><td></td><td>0.91{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied3(2)</td><td></td><td>1.31{(0.03)}<sup>***</sup></td><td></td><td>1.33{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied3(3)</td><td></td><td>1.53{(0.04)}<sup>***</sup></td><td></td><td>1.55{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied3(4)</td><td></td><td>1.78{(0.04)}<sup>***</sup></td><td></td><td>1.80{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied4(1)</td><td></td><td>0.31{(0.02)}<sup>***</sup></td><td></td><td>0.30{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied4(2)</td><td></td><td>0.91{(0.03)}<sup>***</sup></td><td></td><td>0.92{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(3)</td><td></td><td>1.19{(0.03)}<sup>***</sup></td><td></td><td>1.20{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(4)</td><td></td><td>1.46{(0.04)}<sup>***</sup></td><td></td><td>1.46{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied5(1)</td><td></td><td>1.00{(0.03)}<sup>***</sup></td><td></td><td>1.01{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied5(2)</td><td></td><td>1.37{(0.03)}<sup>***</sup></td><td></td><td>1.37{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied5(3)</td><td></td><td>1.56{(0.04)}<sup>***</sup></td><td></td><td>1.55{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied5(4)</td><td></td><td>1.83{(0.05)}<sup>***</sup></td><td></td><td>1.83{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied6(1)</td><td></td><td>1.25{(0.03)}<sup>***</sup></td><td></td><td>1.25{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied6(2)</td><td></td><td>1.57{(0.04)}<sup>***</sup></td><td></td><td>1.58{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied6(3)</td><td></td><td>1.79{(0.04)}<sup>***</sup></td><td></td><td>1.79{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied6(4)</td><td></td><td>2.03{(0.05)}<sup>***</sup></td><td></td><td>2.03{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied7(1)</td><td></td><td>0.65{(0.03)}<sup>***</sup></td><td></td><td>0.65{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(2)</td><td></td><td>1.08{(0.03)}<sup>***</sup></td><td></td><td>1.08{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(3)</td><td></td><td>1.29{(0.03)}<sup>***</sup></td><td></td><td>1.29{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(4)</td><td></td><td>1.57{(0.04)}<sup>***</sup></td><td></td><td>1.56{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(1)</td><td></td><td>1.35{(0.03)}<sup>***</sup></td><td></td><td>1.36{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied8(2)</td><td></td><td>1.68{(0.04)}<sup>***</sup></td><td></td><td>1.69{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(3)</td><td></td><td>1.86{(0.05)}<sup>***</sup></td><td></td><td>1.89{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied8(4)</td><td></td><td>2.06{(0.05)}<sup>***</sup></td><td></td><td>2.08{(0.06)}<sup>***</sup></td></tr>
<tr><td>bullied9(1)</td><td></td><td>1.47{(0.04)}<sup>***</sup></td><td></td><td>1.49{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied9(2)</td><td></td><td>1.73{(0.04)}<sup>***</sup></td><td></td><td>1.74{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied9(3)</td><td></td><td>1.87{(0.05)}<sup>***</sup></td><td></td><td>1.89{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied9(4)</td><td></td><td>2.08{(0.06)}<sup>***</sup></td><td></td><td>2.07{(0.06)}<sup>***</sup></td></tr>
<tr><td>depress1(1)</td><td></td><td></td><td>-0.56{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress1(2)</td><td></td><td></td><td>0.13{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress1(3)</td><td></td><td></td><td>1.10{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress1(4)</td><td></td><td></td><td>1.79{(0.04)}<sup>***</sup></td><td></td></tr>
<tr><td>depress2(1)</td><td></td><td></td><td>-0.87{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress2(2)</td><td></td><td></td><td>-0.19{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress2(3)</td><td></td><td></td><td>0.74{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress2(4)</td><td></td><td></td><td>1.51{(0.03)}<sup>***</sup></td><td></td></tr>
<tr><td>depress3(1)</td><td></td><td></td><td>0.29{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress3(2)</td><td></td><td></td><td>0.67{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress3(3)</td><td></td><td></td><td>1.18{(0.03)}<sup>***</sup></td><td></td></tr>
<tr><td>depress3(4)</td><td></td><td></td><td>1.62{(0.03)}<sup>***</sup></td><td></td></tr>
<tr><td>depress4(1)</td><td></td><td></td><td>-0.11{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress4(2)</td><td></td><td></td><td>0.26{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress4(3)</td><td></td><td></td><td>0.89{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress4(4)</td><td></td><td></td><td>1.44{(0.03)}<sup>***</sup></td><td></td></tr>
<tr><td>depress5(1)</td><td></td><td></td><td>-0.37{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress5(2)</td><td></td><td></td><td>0.07{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress5(3)</td><td></td><td></td><td>0.67{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress5(4)</td><td></td><td></td><td>1.23{(0.03)}<sup>***</sup></td><td></td></tr>
<tr><td>depress6(1)</td><td></td><td></td><td>-0.43{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress6(2)</td><td></td><td></td><td>0.08{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress6(3)</td><td></td><td></td><td>0.74{(0.02)}<sup>***</sup></td><td></td></tr>
<tr><td>depress6(4)</td><td></td><td></td><td>1.25{(0.03)}<sup>***</sup></td><td></td></tr>
<tr><td></td><td colspan = '4'; align = 'center'><span style="text-decoration: underline;">Fit Indices</span></td></tr>
<tr><td>Scaled &chi;<sup>2</sup></td><td>31.14(5)<sup>***</sup></td><td>551.13(27)<sup>***</sup></td><td>315.34(9)<sup>***</sup></td><td>993.15(167)<sup>***</sup></td></tr>
<tr><td>CFI</td><td>1.00</td><td>0.99</td><td>0.99</td><td>0.99</td></tr>
<tr><td>TLI</td><td>1.00</td><td>0.99</td><td>0.98</td><td>0.99</td></tr>
<tr><td>RMSEA</td><td>0.02</td><td>0.06</td><td>0.07</td><td>0.04</td></tr>
 <br> <br><td colspan = '4'; align = 'left'><sup>+</sup>Fixed parameter</td></tr><br><td colspan = '4'; align = 'left'><sup>*</sup>p<0.05, <sup>**</sup>p<0.01, <sup>***</sup>p<0.001</td></tr><br> </table><br>
 


# SECTION-III: A Two-Factor Structural Model: Bullying Victimization Predicts Alcohol Use

## Method 1 - Treat ordinal data as continuous with ML


```r
sem.01 <- '
## the measurement model
bullied =~ NA*bullied1 + bullied2 + bullied3
             + bullied4 + bullied5 + bullied6
             + bullied7 + bullied8 + bullied9
bullied ~~ 1*bullied
alcohol =~ NA*alc1 + alc2 + alc3
            + alc4 + alc5
alcohol ~~ 1*alcohol
# regress 
alcohol ~ bullied
'

sem.01.mlr.listwise <-
    sem(model = sem.01, data = hbsc,  mimic = "Mplus",
        estimator = "MLR", missing = "listwise")
```


```r
summary(sem.01.mlr.listwise, fit.measures = TRUE,
        standardized = TRUE)
```


The lavaan summary output is saved in
[output/sem.01.mlr.listwise.Rout](output/sem.01.mlr.listwise.Rout "SEM output"). 



## Method 2 - The ordinal "threshold" model with WLS
Items Coded as Ordered-Factors

```r
sem.01.ord <- '
## the measurement model
bullied =~ NA*bullied1_o + bullied2_o + bullied3_o
             + bullied4_o + bullied5_o + bullied6_o
             + bullied7_o + bullied8_o + bullied9_o
bullied ~~ 1*bullied
alcohol =~ NA*alc1_o + alc2_o + alc3_o
            + alc4_o + alc5_o
alcohol ~~ 1*alcohol
## the structural model
alcohol ~ bullied
'
```


```r
sem.01.ord.wlsmv <-
  sem(model = sem.01.ord, data = hbsc,
      mimic = "Mplus", estimator = "WLSMV")
```


```r
summary(sem.01.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)
```



The lavaan summary output is saved in
[output/sem.01.ord.wlsmv.listwise.Rout](output/sem.01.ord.wlsmv.listwise.Rout "SEM output"). 





<table style="padding-right:20px;padding-left:20px;">

 <tr><td></td><td colspan = '1'; align = 'center'>ML (listwise)</td><td colspan = '1'; align = 'center'>WLSMV</td></tr>
 
 <tr><td></td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td></tr>
 
 <tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Factor Loadings</span></td></tr> <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">bullied</span></td></tr>
<tr><td>bullied1</td><td>0.79{(0.03)}<sup>***</sup></td><td>0.74{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied2</td><td>0.73{(0.03)}<sup>***</sup></td><td>0.77{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied3</td><td>0.65{(0.03)}<sup>***</sup></td><td>0.79{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied4</td><td>0.81{(0.03)}<sup>***</sup></td><td>0.80{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied5</td><td>0.66{(0.03)}<sup>***</sup></td><td>0.84{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied6</td><td>0.55{(0.03)}<sup>***</sup></td><td>0.88{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied7</td><td>0.73{(0.03)}<sup>***</sup></td><td>0.76{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied8</td><td>0.48{(0.04)}<sup>***</sup></td><td>0.87{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied9</td><td>0.45{(0.04)}<sup>***</sup></td><td>0.90{(0.01)}<sup>***</sup></td></tr>
 <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">alcohol</span></td></tr>
<tr><td>alc1</td><td>0.43{(0.03)}<sup>***</sup></td><td>0.83{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc2</td><td>0.38{(0.03)}<sup>***</sup></td><td>0.76{(0.02)}<sup>***</sup></td></tr>
<tr><td>alc3</td><td>0.47{(0.03)}<sup>***</sup></td><td>0.91{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc4</td><td>0.51{(0.03)}<sup>***</sup></td><td>0.85{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc5</td><td>0.51{(0.03)}<sup>***</sup></td><td>0.87{(0.01)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Regression Slopes</span></td></tr> <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">alcohol</span></td></tr>
<tr><td>bullied</td><td>0.26{(0.05)}<sup>***</sup></td><td>0.29{(0.03)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Intercepts</span></td></tr>
<tr><td>bullied1</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied2</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied3</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied4</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied5</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied6</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied7</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied8</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied9</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc1</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc2</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc3</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc4</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc5</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Residual Variances</span></td></tr>
<tr><td>bullied1</td><td>1.04{(0.05)}<sup>***</sup></td><td>0.45<sup>+</sup></td></tr>
<tr><td>bullied2</td><td>0.79{(0.04)}<sup>***</sup></td><td>0.40<sup>+</sup></td></tr>
<tr><td>bullied3</td><td>0.46{(0.03)}<sup>***</sup></td><td>0.38<sup>+</sup></td></tr>
<tr><td>bullied4</td><td>0.78{(0.04)}<sup>***</sup></td><td>0.36<sup>+</sup></td></tr>
<tr><td>bullied5</td><td>0.40{(0.03)}<sup>***</sup></td><td>0.29<sup>+</sup></td></tr>
<tr><td>bullied6</td><td>0.26{(0.02)}<sup>***</sup></td><td>0.23<sup>+</sup></td></tr>
<tr><td>bullied7</td><td>0.74{(0.04)}<sup>***</sup></td><td>0.42<sup>+</sup></td></tr>
<tr><td>bullied8</td><td>0.25{(0.02)}<sup>***</sup></td><td>0.24<sup>+</sup></td></tr>
<tr><td>bullied9</td><td>0.25{(0.02)}<sup>***</sup></td><td>0.18<sup>+</sup></td></tr>
<tr><td>alc1</td><td>0.14{(0.01)}<sup>***</sup></td><td>0.25<sup>+</sup></td></tr>
<tr><td>alc2</td><td>0.21{(0.02)}<sup>***</sup></td><td>0.38<sup>+</sup></td></tr>
<tr><td>alc3</td><td>0.09{(0.01)}<sup>***</sup></td><td>0.10<sup>+</sup></td></tr>
<tr><td>alc4</td><td>0.17{(0.02)}<sup>***</sup></td><td>0.22<sup>+</sup></td></tr>
<tr><td>alc5</td><td>0.12{(0.01)}<sup>***</sup></td><td>0.18<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Intercepts</span></td></tr>
<tr><td>bullied</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alcohol</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Variances</span></td></tr>
<tr><td>bullied</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td>alcohol</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Thresholds</span></td></tr>
<tr><td>bullied1(1)</td><td></td><td>0.27{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied1(2)</td><td></td><td>0.85{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(3)</td><td></td><td>1.07{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(4)</td><td></td><td>1.32{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(1)</td><td></td><td>0.47{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied2(2)</td><td></td><td>1.03{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(3)</td><td></td><td>1.24{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(4)</td><td></td><td>1.54{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied3(1)</td><td></td><td>0.90{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied3(2)</td><td></td><td>1.32{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied3(3)</td><td></td><td>1.54{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied3(4)</td><td></td><td>1.80{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied4(1)</td><td></td><td>0.30{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied4(2)</td><td></td><td>0.91{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(3)</td><td></td><td>1.20{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(4)</td><td></td><td>1.46{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied5(1)</td><td></td><td>1.01{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied5(2)</td><td></td><td>1.37{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied5(3)</td><td></td><td>1.55{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied5(4)</td><td></td><td>1.83{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied6(1)</td><td></td><td>1.25{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied6(2)</td><td></td><td>1.57{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied6(3)</td><td></td><td>1.78{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied6(4)</td><td></td><td>2.02{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied7(1)</td><td></td><td>0.65{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(2)</td><td></td><td>1.08{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(3)</td><td></td><td>1.29{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(4)</td><td></td><td>1.57{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(1)</td><td></td><td>1.36{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied8(2)</td><td></td><td>1.68{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(3)</td><td></td><td>1.87{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied8(4)</td><td></td><td>2.06{(0.06)}<sup>***</sup></td></tr>
<tr><td>bullied9(1)</td><td></td><td>1.48{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied9(2)</td><td></td><td>1.74{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied9(3)</td><td></td><td>1.88{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied9(4)</td><td></td><td>2.08{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc1(1)</td><td></td><td>1.06{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc1(2)</td><td></td><td>1.82{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc1(3)</td><td></td><td>2.17{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc1(4)</td><td></td><td>2.39{(0.08)}<sup>***</sup></td></tr>
<tr><td>alc2(1)</td><td></td><td>0.92{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc2(2)</td><td></td><td>1.81{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc2(3)</td><td></td><td>2.10{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc2(4)</td><td></td><td>2.44{(0.08)}<sup>***</sup></td></tr>
<tr><td>alc3(1)</td><td></td><td>1.31{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc3(2)</td><td></td><td>1.81{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc3(3)</td><td></td><td>2.07{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc3(4)</td><td></td><td>2.43{(0.08)}<sup>***</sup></td></tr>
<tr><td>alc4(1)</td><td></td><td>0.99{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc4(2)</td><td></td><td>1.60{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc4(3)</td><td></td><td>1.99{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc4(4)</td><td></td><td>2.32{(0.07)}<sup>***</sup></td></tr>
<tr><td>alc5(1)</td><td></td><td>1.07{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc5(2)</td><td></td><td>1.72{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc5(3)</td><td></td><td>2.03{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc5(4)</td><td></td><td>2.35{(0.07)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Fit Indices</span></td></tr>
<tr><td>Scaled &chi;<sup>2</sup></td><td>727.31(76)<sup>***</sup></td><td>646.90(76)<sup>***</sup></td></tr>
<tr><td>CFI</td><td>0.90</td><td>0.99</td></tr>
<tr><td>TLI</td><td>0.89</td><td>0.99</td></tr>
<tr><td>RMSEA</td><td>0.09</td><td>0.04</td></tr>
 <br> <br><td colspan = '2'; align = 'left'><sup>+</sup>Fixed parameter</td></tr><br><td colspan = '2'; align = 'left'><sup>*</sup>p<0.05, <sup>**</sup>p<0.01, <sup>***</sup>p<0.001</td></tr><br> </table><br>
 



# SECTION-IV: Introducing Mediation: Bullying leads to Depression, which also affects Alcohol Use

The ***direct effect*** of bullying on alcohol is compared with the
***indirect effect*** of bullying on depression, which also
contributes to alcohol use.

## Method 1 - Treat ordinal data as continuous with ML
Items Coded as Integers

```r
sem.02 <- '
## the measurement model
bullied =~ NA*bullied1 + bullied2 + bullied3
             + bullied4 + bullied5 + bullied6 
             + bullied7 + bullied8 + bullied9
bullied ~~ 1*bullied
depress =~ NA*depress1 + depress2 + depress3
            + depress4 + depress5 + depress6
depress ~~ 1*depress
alcohol =~ NA*alc1 + alc2 + alc3
            + alc4 + alc5
alcohol ~~ 1*alcohol
## the structural model
## direct effect (the c path)
alcohol ~ c*bullied
## mediator paths (the a and b path)
depress ~ a*bullied # the a path - IV predicting ME
alcohol ~ b*depress  # the b path - ME predicting DV
## indirect effect (a*b)
## := operator defines new parameters
ab := a*b
## total effect
total := c + (a*b)
'
```

* "verbose = FALSE" will not display the bootstrap iterations on
  screen.
* We change the estimator to `ML`. We are asking for bootstrapped
  standard errors, which are not available with `LMR`.
* "bootstrap = 10" is for demonstration purposes; this number (for
  bootstrap draws) should be increased (i.e., the default is 1000).


```r
NBOOT <- 10
sem.02.mlboot.listwise <- sem(model = sem.02, data = hbsc,
                           mimic = "Mplus", estimator = "ML",
                           missing = "listwise", se = "bootstrap",
                           verbose = TRUE, bootstrap = NBOOT)
```

```
Quasi-Newton steps using NLMINB:
Objective function  = 0.7610958025234247
Objective function  =                Inf
Objective function  = 0.6261883155717491
Objective function  = 0.5969380824175232
Objective function  = 0.5574657831870571
Objective function  = 0.5237220884801737
Objective function  = 0.5132137359131015
Objective function  = 0.4614986716887373
Objective function  = 0.4450837143337729
Objective function  = 0.4300752430023831
Objective function  = 0.4258803144428498
Objective function  = 0.4201880581488773
Objective function  = 0.4207021470190515
Objective function  = 0.4166934490861358
Objective function  = 0.4167723630244318
Objective function  = 0.4138707843922802
Objective function  = 0.4159779242726742
Objective function  = 0.4133172849470856
Objective function  = 0.4129658435237467
Objective function  = 0.4123862404077574
Objective function  = 0.4113982513162817
Objective function  = 0.4113902754435905
Objective function  = 0.4103205563367389
Objective function  = 0.4104473408485134
Objective function  = 0.4102194724071797
Objective function  = 0.4101694948808436
Objective function  = 0.4101331615003705
Objective function  = 0.4101299250257604
Objective function  = 0.4101136960227301
Objective function  = 0.4101166471343305
Objective function  = 0.4101085990565920
Objective function  = 0.4101071829062093
Objective function  = 0.4101063575019559
Objective function  = 0.4101058652012490
Objective function  = 0.4101058726397326
Objective function  = 0.4101056859304251
Objective function  = 0.4101056342819795
Objective function  = 0.4101056856153278
Objective function  = 0.4101056080853311
Objective function  = 0.4101055944153842
Objective function  = 0.4101055883698059
Objective function  = 0.4101055850551489
Objective function  = 0.4101055845019594
Objective function  = 0.4101055842358470
Objective function  = 0.4101055842049419
Objective function  = 0.4101055841711982
Objective function  = 0.4101055841711982
convergence status (0=ok):  0 
nlminb message says:  relative convergence (4) 
number of iterations:  36 
number of function evaluations [objective, gradient]:  46 37 
Computing VCOV for se = bootstrap ...
  ... bootstrap draw number:    1   OK -- niter =   32  fx =    0.473150308 
  ... bootstrap draw number:    2   OK -- niter =   34  fx =    0.491576803 
  ... bootstrap draw number:    3   OK -- niter =   35  fx =    0.422636208 
  ... bootstrap draw number:    4   OK -- niter =   34  fx =    0.490455911 
  ... bootstrap draw number:    5   OK -- niter =   31  fx =    0.481712339 
  ... bootstrap draw number:    6   OK -- niter =   38  fx =    0.465620108 
  ... bootstrap draw number:    7   OK -- niter =   32  fx =    0.546665849 
  ... bootstrap draw number:    8   OK -- niter =   35  fx =    0.452019891 
  ... bootstrap draw number:    9   OK -- niter =   33  fx =    0.506796911 
  ... bootstrap draw number:   10   OK -- niter =   31  fx =    0.479893475 
Number of successful bootstrap draws: 10 
```

```
Warning in lav_model_vcov(lavmodel = lavmodel, lavsamplestats = lavsamplestats, : lavaan WARNING:
    The variance-covariance matrix of the estimated parameters (vcov)
    does not appear to be positive definite! The smallest eigenvalue
    (= -3.402425e-18) is smaller than zero. This may be a symptom that
    the model is not identified.
```

```
 done.
Computing TEST for test = standard ... done.
```


```r
summary(sem.02.mlboot.listwise, fit.measures = TRUE, standardized = TRUE)
```


The lavaan summary output is saved in
[output/sem.02.mlboot.listwise.Rout](output/sem.02.mlboot.listwise.Rout "SEM output").




## Method 2 - The ordinal "threshold" model with WLS
Items Coded as Ordered-Factors

* The ordinal items for this model are coded as factors DWLS (diagonal
weighted least squares) is used to obtain bootstrap samples


```r
sem.02.ord <- '
## the measurement model
bullied =~ NA*bullied1_o + bullied2_o + bullied3_o
             + bullied4_o + bullied5_o + bullied6_o 
             + bullied7_o + bullied8_o + bullied9_o
bullied ~~ 1*bullied
depress =~ NA*depress1_o + depress2_o + depress3_o
            + depress4_o + depress5_o + depress6_o
depress ~~ 1*depress
alcohol =~ NA*alc1_o + alc2_o + alc3_o
            + alc4_o + alc5_o
alcohol ~~ 1*alcohol
## the structural model
## direct effect (the c path)
alcohol ~ c*bullied
## mediator paths (the a and b path)
depress ~ a*bullied # the a path - IV predicting ME
alcohol ~ b*depress  # the b path - ME predicting DV
## indirect effect (a*b)
## := operator defines new parameters
ab := a*b
## total effect
total := c + (a*b)
'
```


```r
sem.02.ord.wlsmv <-
  sem(model = sem.02.ord, data = hbsc, mimic = "Mplus",
      estimator = "DWLS", se = "bootstrap", verbose = TRUE,
      bootstrap = NBOOT)
```

```
Warning in lav_options_set(opt): lavaan WARNING: information will be set to
"expected" for estimator = "DWLS"
```

```
Estimating sample thresholds and correlations ... done
Quasi-Newton steps using NLMINB:
Objective function  = 1.6304782009635415
Objective function  = 4.3078918156426278
Objective function  = 0.5235747585056091
Objective function  = 0.4648468857816795
Objective function  = 0.2962602989148981
Objective function  = 0.5158296626894392
Objective function  = 0.1797810390665835
Objective function  = 0.1794633005574892
Objective function  = 0.1639437760930220
Objective function  = 0.1646792256351011
Objective function  = 0.1643922647433193
Objective function  = 0.1631750766018702
Objective function  = 0.1627453483709781
Objective function  = 0.1623158721605163
Objective function  = 0.1623687520419038
Objective function  = 0.1623792467608654
Objective function  = 0.1622108420962806
Objective function  = 0.1621514247201503
Objective function  = 0.1621324780519056
Objective function  = 0.1621388401834118
Objective function  = 0.1621310484917359
Objective function  = 0.1621297447100510
Objective function  = 0.1621298352933152
Objective function  = 0.1621290450641715
Objective function  = 0.1621291173556043
Objective function  = 0.1621289404318875
Objective function  = 0.1621289056282593
Objective function  = 0.1621289055209841
Objective function  = 0.1621288871512100
Objective function  = 0.1621288847412472
Objective function  = 0.1621288850877061
Objective function  = 0.1621288846146512
Objective function  = 0.1621288846087744
Objective function  = 0.1621288845890413
Objective function  = 0.1621288845956788
Objective function  = 0.1621288845890413
convergence status (0=ok):  0 
nlminb message says:  relative convergence (4) 
number of iterations:  24 
number of function evaluations [objective, gradient]:  35 24 
Computing VCOV for se = bootstrap ...
  ... bootstrap draw number:    1   OK -- niter =   31  fx =    0.165484306 
  ... bootstrap draw number:    2   OK -- niter =   29  fx =    0.240497236 
  ... bootstrap draw number:    3   OK -- niter =   34  fx =    0.203474715 
  ... bootstrap draw number:    4   OK -- niter =   29  fx =    0.196003875 
  ... bootstrap draw number:    5   OK -- niter =   25  fx =    0.239912830 
  ... bootstrap draw number:    6   OK -- niter =   32  fx =    0.174503199 
  ... bootstrap draw number:    7   OK -- niter =   34  fx =    0.171884866 
  ... bootstrap draw number:    8   OK -- niter =   25  fx =    0.204892227 
  ... bootstrap draw number:    9   OK -- niter =   29  fx =    0.169763173 
  ... bootstrap draw number:   10   OK -- niter =   25  fx =    0.174662548 
Number of successful bootstrap draws: 10 
```

```
Warning in lav_model_vcov(lavmodel = lavmodel, lavsamplestats = lavsamplestats, : lavaan WARNING:
    The variance-covariance matrix of the estimated parameters (vcov)
    does not appear to be positive definite! The smallest eigenvalue
    (= -3.025979e-17) is smaller than zero. This may be a symptom that
    the model is not identified.
```

```
 done.
Computing TEST for test = standard ... done.
```


```r
summary(sem.02.ord.wlsmv, fit.measures = TRUE, standardized = TRUE)
```



The lavaan summary output is saved in
[output/sem.02.ord.wlsmv.listwise.Rout](output/sem.02.ord.wlsmv.listwise.Rout "SEM output"). 

Following is the summary table comparing the two models.



<table style="padding-right:20px;padding-left:20px;">

 <tr><td></td><td colspan = '1'; align = 'center'>ML (listwise)</td><td colspan = '1'; align = 'center'>DWLS</td></tr>
 
 <tr><td></td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td><td colspan = '1'; align = 'center'>Estimate(Std.Err.)</td></tr>
 
 <tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Factor Loadings</span></td></tr> <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">bullied</span></td></tr>
<tr><td>bullied1</td><td>0.81{(0.05)}<sup>***</sup></td><td>0.75{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied2</td><td>0.75{(0.03)}<sup>***</sup></td><td>0.78{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied3</td><td>0.64{(0.02)}<sup>***</sup></td><td>0.78{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied4</td><td>0.82{(0.03)}<sup>***</sup></td><td>0.81{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied5</td><td>0.66{(0.04)}<sup>***</sup></td><td>0.84{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied6</td><td>0.54{(0.04)}<sup>***</sup></td><td>0.87{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied7</td><td>0.73{(0.02)}<sup>***</sup></td><td>0.77{(0.01)}<sup>***</sup></td></tr>
<tr><td>bullied8</td><td>0.46{(0.04)}<sup>***</sup></td><td>0.86{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied9</td><td>0.44{(0.04)}<sup>***</sup></td><td>0.89{(0.02)}<sup>***</sup></td></tr>
 <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">depress</span></td></tr>
<tr><td>depress1</td><td>0.68{(0.01)}<sup>***</sup></td><td>0.63{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress2</td><td>0.64{(0.02)}<sup>***</sup></td><td>0.62{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress3</td><td>0.73{(0.04)}<sup>***</sup></td><td>0.70{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress4</td><td>0.79{(0.02)}<sup>***</sup></td><td>0.76{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress5</td><td>0.70{(0.03)}<sup>***</sup></td><td>0.66{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress6</td><td>0.70{(0.03)}<sup>***</sup></td><td>0.74{(0.02)}<sup>***</sup></td></tr>
 <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">alcohol</span></td></tr>
<tr><td>alc1</td><td>0.41{(0.03)}<sup>***</sup></td><td>0.80{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc2</td><td>0.37{(0.03)}<sup>***</sup></td><td>0.72{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc3</td><td>0.46{(0.03)}<sup>***</sup></td><td>0.88{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc4</td><td>0.50{(0.02)}<sup>***</sup></td><td>0.82{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc5</td><td>0.50{(0.02)}<sup>***</sup></td><td>0.84{(0.02)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Regression Slopes</span></td></tr> <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">alcohol</span></td></tr>
<tr><td>bullied</td><td>0.17{(0.06)}<sup>**</sup></td><td>0.15{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress</td><td>0.19{(0.05)}<sup>***</sup></td><td>0.28{(0.03)}<sup>***</sup></td></tr>
 <tr><td colspan = '1'; align = 'left'><span style="text-decoration: underline;">depress</span></td></tr>
<tr><td>bullied</td><td>0.40{(0.05)}<sup>***</sup></td><td>0.47{(0.03)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Intercepts</span></td></tr>
<tr><td>bullied1</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied2</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied3</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied4</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied5</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied6</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied7</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied8</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>bullied9</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress1</td><td></td><td>2.32{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress2</td><td></td><td>2.68{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress3</td><td></td><td>1.80{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress4</td><td></td><td>2.22{(0.02)}<sup>***</sup></td></tr>
<tr><td>depress5</td><td></td><td>2.50{(0.01)}<sup>***</sup></td></tr>
<tr><td>depress6</td><td></td><td>2.47{(0.02)}<sup>***</sup></td></tr>
<tr><td>alc1</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc2</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc3</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc4</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alc5</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Residual Variances</span></td></tr>
<tr><td>bullied1</td><td>1.01{(0.05)}<sup>***</sup></td><td>0.44<sup>+</sup></td></tr>
<tr><td>bullied2</td><td>0.77{(0.03)}<sup>***</sup></td><td>0.39<sup>+</sup></td></tr>
<tr><td>bullied3</td><td>0.46{(0.03)}<sup>***</sup></td><td>0.39<sup>+</sup></td></tr>
<tr><td>bullied4</td><td>0.76{(0.04)}<sup>***</sup></td><td>0.35<sup>+</sup></td></tr>
<tr><td>bullied5</td><td>0.40{(0.03)}<sup>***</sup></td><td>0.29<sup>+</sup></td></tr>
<tr><td>bullied6</td><td>0.27{(0.02)}<sup>***</sup></td><td>0.25<sup>+</sup></td></tr>
<tr><td>bullied7</td><td>0.74{(0.05)}<sup>***</sup></td><td>0.41<sup>+</sup></td></tr>
<tr><td>bullied8</td><td>0.26{(0.02)}<sup>***</sup></td><td>0.26<sup>+</sup></td></tr>
<tr><td>bullied9</td><td>0.26{(0.02)}<sup>***</sup></td><td>0.20<sup>+</sup></td></tr>
<tr><td>depress1</td><td>0.68{(0.02)}<sup>***</sup></td><td>0.73{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress2</td><td>0.81{(0.02)}<sup>***</sup></td><td>0.82{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress3</td><td>0.82{(0.04)}<sup>***</sup></td><td>0.83{(0.03)}<sup>***</sup></td></tr>
<tr><td>depress4</td><td>0.97{(0.03)}<sup>***</sup></td><td>1.00{(0.04)}<sup>***</sup></td></tr>
<tr><td>depress5</td><td>1.31{(0.04)}<sup>***</sup></td><td>1.34{(0.05)}<sup>***</sup></td></tr>
<tr><td>depress6</td><td>1.21{(0.03)}<sup>***</sup></td><td>1.10{(0.01)}<sup>***</sup></td></tr>
<tr><td>alc1</td><td>0.14{(0.01)}<sup>***</sup></td><td>0.26<sup>+</sup></td></tr>
<tr><td>alc2</td><td>0.21{(0.01)}<sup>***</sup></td><td>0.40<sup>+</sup></td></tr>
<tr><td>alc3</td><td>0.09{(0.01)}<sup>***</sup></td><td>0.09<sup>+</sup></td></tr>
<tr><td>alc4</td><td>0.17{(0.02)}<sup>***</sup></td><td>0.22<sup>+</sup></td></tr>
<tr><td>alc5</td><td>0.12{(0.01)}<sup>***</sup></td><td>0.18<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Intercepts</span></td></tr>
<tr><td>bullied</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>depress</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td>alcohol</td><td></td><td>0.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Latent Variances</span></td></tr>
<tr><td>bullied</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td>depress</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td>alcohol</td><td>1.00<sup>+</sup></td><td>1.00<sup>+</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Thresholds</span></td></tr>
<tr><td>bullied1(1)</td><td></td><td>0.27{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(2)</td><td></td><td>0.85{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(3)</td><td></td><td>1.07{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied1(4)</td><td></td><td>1.32{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied2(1)</td><td></td><td>0.47{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied2(2)</td><td></td><td>1.03{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied2(3)</td><td></td><td>1.24{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied2(4)</td><td></td><td>1.54{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied3(1)</td><td></td><td>0.91{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied3(2)</td><td></td><td>1.33{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied3(3)</td><td></td><td>1.55{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied3(4)</td><td></td><td>1.80{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied4(1)</td><td></td><td>0.30{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(2)</td><td></td><td>0.92{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(3)</td><td></td><td>1.20{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied4(4)</td><td></td><td>1.46{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied5(1)</td><td></td><td>1.01{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied5(2)</td><td></td><td>1.37{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied5(3)</td><td></td><td>1.55{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied5(4)</td><td></td><td>1.83{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied6(1)</td><td></td><td>1.25{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied6(2)</td><td></td><td>1.58{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied6(3)</td><td></td><td>1.79{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied6(4)</td><td></td><td>2.03{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(1)</td><td></td><td>0.65{(0.02)}<sup>***</sup></td></tr>
<tr><td>bullied7(2)</td><td></td><td>1.08{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied7(3)</td><td></td><td>1.29{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied7(4)</td><td></td><td>1.56{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(1)</td><td></td><td>1.36{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(2)</td><td></td><td>1.69{(0.03)}<sup>***</sup></td></tr>
<tr><td>bullied8(3)</td><td></td><td>1.89{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied8(4)</td><td></td><td>2.08{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied9(1)</td><td></td><td>1.49{(0.04)}<sup>***</sup></td></tr>
<tr><td>bullied9(2)</td><td></td><td>1.74{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied9(3)</td><td></td><td>1.89{(0.05)}<sup>***</sup></td></tr>
<tr><td>bullied9(4)</td><td></td><td>2.07{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc1(1)</td><td></td><td>1.06{(0.02)}<sup>***</sup></td></tr>
<tr><td>alc1(2)</td><td></td><td>1.84{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc1(3)</td><td></td><td>2.19{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc1(4)</td><td></td><td>2.43{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc2(1)</td><td></td><td>0.93{(0.02)}<sup>***</sup></td></tr>
<tr><td>alc2(2)</td><td></td><td>1.82{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc2(3)</td><td></td><td>2.12{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc2(4)</td><td></td><td>2.47{(0.09)}<sup>***</sup></td></tr>
<tr><td>alc3(1)</td><td></td><td>1.32{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc3(2)</td><td></td><td>1.82{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc3(3)</td><td></td><td>2.07{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc3(4)</td><td></td><td>2.43{(0.07)}<sup>***</sup></td></tr>
<tr><td>alc4(1)</td><td></td><td>0.98{(0.02)}<sup>***</sup></td></tr>
<tr><td>alc4(2)</td><td></td><td>1.60{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc4(3)</td><td></td><td>2.00{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc4(4)</td><td></td><td>2.35{(0.06)}<sup>***</sup></td></tr>
<tr><td>alc5(1)</td><td></td><td>1.07{(0.03)}<sup>***</sup></td></tr>
<tr><td>alc5(2)</td><td></td><td>1.72{(0.04)}<sup>***</sup></td></tr>
<tr><td>alc5(3)</td><td></td><td>2.04{(0.05)}<sup>***</sup></td></tr>
<tr><td>alc5(4)</td><td></td><td>2.35{(0.04)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Constructed</span></td></tr>
<tr><td>ab</td><td>0.08{(0.03)}<sup>**</sup></td><td>0.13{(0.02)}<sup>***</sup></td></tr>
<tr><td>total</td><td>0.25{(0.05)}<sup>***</sup></td><td>0.28{(0.04)}<sup>***</sup></td></tr>
<tr><td></td><td colspan = '2'; align = 'center'><span style="text-decoration: underline;">Fit Indices</span></td></tr>
<tr><td>&chi;<sup>2</sup></td><td>2201.45(167)<sup>***</sup></td><td>745.10(167)<sup>***</sup></td></tr>
<tr><td>CFI</td><td>0.91</td><td>0.99</td></tr>
<tr><td>TLI</td><td>0.89</td><td>0.99</td></tr>
<tr><td>RMSEA</td><td>0.07</td><td>0.04</td></tr>
 <br> <br><td colspan = '2'; align = 'left'><sup>+</sup>Fixed parameter</td></tr><br><td colspan = '2'; align = 'left'><sup>*</sup>p<0.05, <sup>**</sup>p<0.01, <sup>***</sup>p<0.001</td></tr><br> </table><br>
 

# Summary

When the coefficients of the 2 kinds of models are rescaled onto a
more-or-less common scale, the loadings and estimates of underlying
structures are very similar. In this example, we don't find
coefficients that change from "significant" to "insignificant" when 
comparing the ML-as-if-numeric and WLSMV estimates. 

If we allow the ML estimator to use FIML to avoid dropping cases, the
estimates are interestingly different.

# R Session Info

```
R version 3.5.2 (2018-12-20)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 18.10

Matrix products: default
BLAS: /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.8.0
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.8.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] xtable_1.8-3        lavaan_0.6-3        kutils_1.60        
[4] stationery_0.98.5.7

loaded via a namespace (and not attached):
 [1] Rcpp_1.0.0      digest_0.6.18   MASS_7.3-51.1   plyr_1.8.4     
 [5] magrittr_1.5    stats4_3.5.2    evaluate_0.12   zip_1.0.0      
 [9] stringi_1.2.4   pbivnorm_0.6.0  openxlsx_4.1.0  rmarkdown_1.11 
[13] tools_3.5.2     stringr_1.3.1   foreign_0.8-71  yaml_2.2.0     
[17] xfun_0.4        compiler_3.5.2  mnormt_1.5-5    htmltools_0.3.6
[21] knitr_1.21     
```





Available under
[Created Commons license 3.0 <img src="http://crmda.dept.ku.edu/images/cc-3.0.png" alt="CC BY"
style="width: 75px;height: 20px;"/>](http://creativecommons.org/licenses/by/3.0/)
