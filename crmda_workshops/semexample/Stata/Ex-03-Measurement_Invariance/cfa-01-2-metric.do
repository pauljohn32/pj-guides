********************************************************************************
*PURPOSE:  Demonstrate how to run a metric invariance model in Stata.
*
*
*AUTHOR: Ben Kite
*
*
*DATE LAST MODIFIED: 2015-12-08
********************************************************************************

***INITIAL SETUP***
* clear everything
cscript
* close any open log file
capture log close
* set output window to be printable
set linesize 80
* disable annoying "feature" where the output window won't scroll
set more off
* enable automatic reporting of execution and system time
set rmsg on

log using "cfa-01-2-metric-output.txt", text replace

use "..\..\data\job_placement.dta", clear

sem (MATH -> wratcalc@a1 wjcalc  waiscalc) ///
(SPELL ->  wratspl@a2 wjspl waisspl), group(female) ///
ginvariant(mcoef) latent(MATH SPELL) cov(MATH*SPELL) ///
variance(0: MATH@1 SPELL)  variance(1: MATH SPELL@1) mean(MATH@0 SPELL@0) ///
 nocapslatent method(mlmv)
* This is very interesting, I can do fixed factor identification, 
* but only if each group has one LV variance fixed to 1.  
* This differs from Mplus, which allows the user to specify all of the LV variances in a single group to 1.
* Here I set the LV variance for MATH to 1 in group 1, this causes the factor loadings
* for MATH to match what Mplus provides for MATH (but not SPELL).  If I were to 
* fix the variance of SPELL in group 1 to 1, then the loading for SPELL would
* match what Mplus produces for SPELL. 

***CLOSE LOG FILE***
capture log close
