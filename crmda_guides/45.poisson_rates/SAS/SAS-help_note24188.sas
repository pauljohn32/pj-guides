* Meghan Sullivan Paul Johnson;
* 20181029;
* Modeling rates and estimating rates and rate ratios;
* http://support.sas.com/kb/24/188.html;
* This code replicates some of the analyses done on the above website;

OPTIONS LINESIZE = 100;

* Create example data file;
DATA insure;
  input n c car$ age;
  carnum=1;
  if car="medium" then carnum=2;
  if car="large" then carnum=3;
  nlog = log(n);
  datalines;
  500   42  small  1
  1200  37  medium 1
  100    1  large  1
  400  101  small  2
  500   73  medium 2
  300   14  large  2
;
RUN;

* Rate insurance claims per policy holder, as a function of car size and age;
* Save the fitted model for later use by PROC PLM;
* PROC PLM: estimates rates, SE, CIs;
PROC GENMOD data=insure;
    class car age;
    model c = car age / dist=poisson link=log offset=nlog;
    lsmeans age / ilink cl;
    store out=insmodel;
    output out=out p=pcount xbeta=xb stdxbeta=std;
run;

* NOOFFSET Options computes x'B as rates, BUT;
* Can't use NOOFFSET option because it requires Sas 9.4 TS1M1 version;
* So, output of results will appear different than the website;
PROC PLM source=insmodel;
    score data=insure out=inspred pred stderr lclm uclm / ilink;
run;
         
proc print label; 
 id n c;      
run;


*This computes point estimates of the rates by subtracting the offset and exponentiating;
data predrates;
    set out;
    obsrate=c/n;         /* observed rate */
    lograte=xb-nlog;
    prate=exp(lograte);  /* predicted rate */
    lcl=exp(lograte-probit(.975)*std);
    ucl=exp(lograte+probit(.975)*std);
    keep n c car age prate lcl ucl;
run;

title 'Predicted insurance rates';
proc print data=predrates;
    id n c;
run;


* This provides the parameter coefficients needed in the ESTIMATE statement below;
proc genmod data=insure;
    class car age;
    model c = car age / dist=poisson link=log offset=nlog;
    estimate "Rate: age=1, small" intercept 1 age 1 0 car 0 0 1;
run;




/* * Export same dataset for use in R; */
/* proc export data=insure */
/*     outfile="insure.csv" */
/*     dbms=csv; */
/* run; */


proc export data=Out
    outfile="insure-out.csv"
    dbms=csv;
run;

proc export data=Predrates
    outfile="insure-predRates.csv"
    dbms=csv;
run;

proc export data=Inspred
    outfile="insure-predCounts.csv"
    dbms=csv;
run;

