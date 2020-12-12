OPTIONS LINESIZE=80;

PROC IMPORT OUT=WORK.injury
            DATAFILE= "../workingdata/fireworks-1617.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2;
RUN;

/* PROC PRINT DATA=injury; */
/* RUN; */

DATA injury;
    set injury;
    hourslog = LOG(hours);
    /* if month="June" OR month="Jul" then junjul=1 */
    /*     else junjul=0 */
    junjul = month in ("June" "Jul");
RUN;    
  
PROC PRINT DATA=injury;
RUN;  
    
PROC GENMOD DATA=injury;
    class year(ref="2016");
    model accidents = year / dist=poisson link=log offset=hourslog;
    output out=out1 p=pcount xbeta=xb stdxbeta=std;
run;


/* 95pct confidence interval for rate at 200000 hours */
/* tk = new variable = 200000*/
/* must first subtract hourslog, then add back tklog */
/* to get 200000 based rate */
data predrates1;
   set out1;
   tk=200000;
   tklog=log(tk);
   obsrate= accidents/tk;
   lograte=xb-hourslog;
   prate=exp(lograte + tklog);
   lcl95=exp(lograte + tklog - probit(.975)*std);
   ucl95=exp(lograte + tklog + probit(.975)*std);
   lcl90=exp(lograte + tklog - probit(.925)*std);
   ucl90=exp(lograte + tklog + probit(.925)*std);
   lcl80=exp(lograte + tklog - probit(.9)*std);
   ucl80=exp(lograte + tklog + probit(.9)*std);
run;

PROC PRINT DATA=predrates1;
run;







 /* Interestingly, we get same rate estimate and CI if we use annual data */

DATA injuryagg;
  input year year accidents  hours hourslog;
  datalines;
 2016 2016  248 16449192 16.61579  2016
 2017 2017  272 15890895 16.58126  2017
 ;

PROC GENMOD DATA=injuryagg;
    class year(ref="2016");
    model accidents = year / dist=poisson link=log offset=hourslog;
    output out=out2 p=pcount xbeta=xb stdxbeta=std;
run;

data predrates2;
   set out2;
   tk=200000;
   tklog=log(tk);
   obsrate= accidents/tk;
   lograte=xb-hourslog;
   prate=exp(lograte + tklog);
   lcl95=exp(lograte + tklog - probit(.975)*std);
   ucl95=exp(lograte + tklog + probit(.975)*std);
   lcl90=exp(lograte + tklog - probit(.925)*std);
   ucl90=exp(lograte + tklog + probit(.925)*std);
   lcl80=exp(lograte + tklog - probit(.9)*std);
   ucl80=exp(lograte + tklog + probit(.9)*std);
run;

PROC PRINT DATA=predrates2;
run;



PROC GENMOD DATA=injury;
    class year(ref="2016") junjul(ref="0");
    model accidents = year junjul / dist=poisson link=log offset=hourslog;
    output out=out2 p=pcount xbeta=xb stdxbeta=std;
run;


/* 95pct confidence interval for rate at 200000 hours */
/* tk = new variable = 200000*/
/* must first subtract hourslog, then add back tklog */
/* to get 200000 based rate */
data predrates2;
   set out2;
   tk=200000;
   tklog=log(tk);
   obsrate= accidents/tk;
   lograte=xb-hourslog;
   prate=exp(lograte + tklog);
   lcl95=exp(lograte + tklog - probit(.975)*std);
   ucl95=exp(lograte + tklog + probit(.975)*std);
   lcl90=exp(lograte + tklog - probit(.925)*std);
   ucl90=exp(lograte + tklog + probit(.925)*std);
   lcl80=exp(lograte + tklog - probit(.9)*std);
   ucl80=exp(lograte + tklog + probit(.9)*std);
run;

PROC PRINT DATA=predrates2;
run;
