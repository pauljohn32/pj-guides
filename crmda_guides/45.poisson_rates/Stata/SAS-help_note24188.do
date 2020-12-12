--------------------------------------------
      name:  <unnamed>
       log:  /home/pauljohn/GIT/CRMDA/guides
> /45.poisson_rates/Stata/SAS-help_note24188
> .do
  log type:  text
 opened on:   1 Nov 2018, 17:49:25

. 
end of do-file

. do "/tmp/SD30222.000000"

. import delimited "../workingdata/insure.csv"
(6 vars, 6 obs)

. 
end of do-file

. do "/tmp/SD30222.000000"

. label define carlabel 1 "small" 2 "medium" 3 "large", repl
> ace

. label values carnum carlabel

. label define agelabel 1 "young" 2 "old", replace

. label values age  agelabel

. tab carnum age

           |          age
    carnum |     young        old |     Total
-----------+----------------------+----------
     small |         1          1 |         2 
    medium |         1          1 |         2 
     large |         1          1 |         2 
-----------+----------------------+----------
     Total |         3          3 |         6 


. 
end of do-file

. do "/tmp/SD30222.000000"

. glm c i.age i.carnum, offset(ln) family(poisson)

Iteration 0:   log likelihood = -27.428491  
Iteration 1:   log likelihood = -16.695145  
Iteration 2:   log likelihood = -16.463954  
Iteration 3:   log likelihood = -16.463792  
Iteration 4:   log likelihood = -16.463792  

Generalized linear models                         No. of obs
>       =                                                   
>                  6
Optimization     : ML                             Residual d
> f                                                         
>       =                                                   
>                  2
                                                  Scale para
> meter                                                     
>       =                                                   
>                  1
Deviance         =  2.820664694                   (1/df) Dev
> iance                                                     
>       =                                                   
>           1.410332
Pearson          =  2.841608434                   (1/df) Pea
> rson                                                      
>       =                                                   
>           1.420804

Variance function: V(u) = u                       [Poisson]
Link function    : g(u) = ln(u)                   [Log]

                                                  AIC       
>       =                                                   
>           6.821264
Log likelihood   =  -16.4637917                   BIC       
>       =                                                   
>          -.7628542

------------------------------------------------------------
> ------------------
             |                 OIM
           c |      Coef.   Std. Err.      z    P>|z|     [9
> 5% Con                                                    
>       f. Interval]
-------------+----------------------------------------------
> ------------------
         age |
        old  |   1.319933    .135896     9.71   0.000     1.
> 053582                                                    
>           1.586284
             |
      carnum |
     medium  |  -.6927778   .1282483    -5.40   0.000    -.9
> 441398                                                    
>          -.4414157
      large  |  -1.764281   .2723683    -6.48   0.000    -2.
> 298113                                                    
>          -1.230449
             |
       _cons |  -2.636691   .1318015   -20.01   0.000    -2.
> 895017                                                    
>          -2.378365
          ln |          1  (offset)
------------------------------------------------------------
> ------------------

. 
end of do-file

. do "/tmp/SD30222.000000"

. glm c i.age i.carnum, offset(ln) family(poisson)

Iteration 0:   log likelihood = -27.428491  
Iteration 1:   log likelihood = -16.695145  
Iteration 2:   log likelihood = -16.463954  
Iteration 3:   log likelihood = -16.463792  
Iteration 4:   log likelihood = -16.463792  

Generalized linear models                         No. of obs      =          6
Optimization     : ML                             Residual df     =          2
                                                  Scale parameter =          1
Deviance         =  2.820664694                   (1/df) Deviance =   1.410332
Pearson          =  2.841608434                   (1/df) Pearson  =   1.420804

Variance function: V(u) = u                       [Poisson]
Link function    : g(u) = ln(u)                   [Log]

                                                  AIC             =   6.821264
Log likelihood   =  -16.4637917                   BIC             =  -.7628542

------------------------------------------------------------------------------
             |                 OIM
           c |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         age |
        old  |   1.319933    .135896     9.71   0.000     1.053582    1.586284
             |
      carnum |
     medium  |  -.6927778   .1282483    -5.40   0.000    -.9441398   -.4414157
      large  |  -1.764281   .2723683    -6.48   0.000    -2.298113   -1.230449
             |
       _cons |  -2.636691   .1318015   -20.01   0.000    -2.895017   -2.378365
          ln |          1  (offset)
------------------------------------------------------------------------------

. 
end of do-file

. do "/tmp/SD30222.000000"

. predict glm1mu, mu

. predict glm1xb, xb

. 
end of do-file

. do "/tmp/SD30222.000000"

. margins, at(age=(1 2) carnum=(1 2 3)) atmeans

Adjusted predictions                            Number of obs     =          6
Model VCE    : OIM

Expression   : Predicted mean c, predict()

1._at        : age             =           1
               carnum          =           1

2._at        : age             =           1
               carnum          =           2

3._at        : age             =           1
               carnum          =           3

4._at        : age             =           2
               carnum          =           1

5._at        : age             =           2
               carnum          =           2

6._at        : age             =           2
               carnum          =           3

------------------------------------------------------------------------------
             |            Delta-method
             |     Margin   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         _at |
          1  |    35.7989   4.718348     7.59   0.000     26.55111    45.04669
          2  |   17.90606   2.261238     7.92   0.000     13.47412    22.33801
          3  |   6.132707   1.758683     3.49   0.000     2.685751    9.579663
          4  |   134.0014   12.09759    11.08   0.000     110.2905    157.7122
          5  |   67.02544   7.314568     9.16   0.000     52.68915    81.36173
          6  |   22.95576   5.932639     3.87   0.000       11.328    34.58352
------------------------------------------------------------------------------

. 
end of do-file

. do "/tmp/SD30222.000000"

. marginsplot

  Variables that uniquely identify margins: age carnum

. 
end of do-file

. do "/tmp/SD30222.000000"

. margins, at(carnum=(1 2 3) age=(1 2)) atmeans vsquish post

Adjusted predictions                            Number of obs     =          6
Model VCE    : OIM

Expression   : Predicted mean c, predict()
1._at        : age             =           1
               carnum          =           1
2._at        : age             =           1
               carnum          =           2
3._at        : age             =           1
               carnum          =           3
4._at        : age             =           2
               carnum          =           1
5._at        : age             =           2
               carnum          =           2
6._at        : age             =           2
               carnum          =           3

------------------------------------------------------------------------------
             |            Delta-method
             |     Margin   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         _at |
          1  |    35.7989   4.718348     7.59   0.000     26.55111    45.04669
          2  |   17.90606   2.261238     7.92   0.000     13.47412    22.33801
          3  |   6.132707   1.758683     3.49   0.000     2.685751    9.579663
          4  |   134.0014   12.09759    11.08   0.000     110.2905    157.7122
          5  |   67.02544   7.314568     9.16   0.000     52.68915    81.36173
          6  |   22.95576   5.932639     3.87   0.000       11.328    34.58352
------------------------------------------------------------------------------

. 
end of do-file

. do "/tmp/SD30222.000000"

. marginsplot

  Variables that uniquely identify margins: carnum age

. 
end of do-file

. generate rate glm1mu/n
variable glm1mu already defined
r(110);

. generate rate=glm1mu/n

. exit, clear
