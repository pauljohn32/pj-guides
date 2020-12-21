********************************************************************************
*PURPOSE:  Demonstrate how to run SEM with latent endogenous variables in Stata.
*
*AUTHOR: Ben Kite
*
*DATE LAST MODIFIED: 2015-12-22
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

***OPEN LOG FILE***
log using "sem-01-output.txt", text replace

use "../../data/job_placement.dta", clear

sem (MATH -> wratcalc wjcalc waiscalc)(SPELL -> wratspl wjspl waisspl) ///
(MATH <-  edlevel newschl suspend expelled haveld female age) ///
(SPELL <-  edlevel newschl suspend expelled haveld female age) ///
(METAMATH -> MATH@1) (METASPELL -> SPELL@1), latent(MATH SPELL METAMATH METASPELL) ///
cov(METAMATH*edlevel@0) cov(METAMATH*newschl@0) cov(METAMATH*suspend@0) ///
cov(METAMATH*expelled@0) cov(METAMATH*haveld@0) cov(METAMATH*female@0) ///
cov(METAMATH*age@0) ///
cov(METASPELL*edlevel@0) cov(METASPELL*newschl@0) cov(METASPELL*suspend@0) ///
cov(METASPELL*expelled@0) cov(METASPELL*haveld@0) cov(METASPELL*female@0) ///
cov(METASPELL*age@0) cov(METAMATH*METASPELL) /// 
variance(METAMATH@1 METASPELL@1) ///
 method(mlmv)
// This model uses phantom variables to match Mplus
// This model also differs from what Mplus provides because of the missing data.
// Stata either does list-wise deletion, or some sort of FIML method that accounts for 
// missing in both the IVs and DVs.  In contrast, Mplus only uses FIML to account 
// for missing on the DVs.

***CLOSE LOG FILE***
capture log close
