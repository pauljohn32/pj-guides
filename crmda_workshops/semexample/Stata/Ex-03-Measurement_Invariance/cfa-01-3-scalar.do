********************************************************************************
*PURPOSE:  Demonstrate how to run a scalar invariance model in Stata.
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

log using "cfa-01-3-scalar-output.txt", text replace

use "..\..\data\job_placement.dta", clear

sem (MATH -> wratcalc@a1 wjcalc  waiscalc) ///
(SPELL ->  wratspl@a2 wjspl waisspl), group(female) ///
ginvariant(mcoef mcons) latent(MATH SPELL) cov(MATH*SPELL) ///
variance(0: MATH@1 SPELL)  variance(1: MATH SPELL@1) mean(0: MATH@0 SPELL) ///
mean(1: MATH SPELL@0) nocapslatent method(mlmv)

***CLOSE LOG FILE***
capture log close
