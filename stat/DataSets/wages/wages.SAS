data wages; 
infile 'C:\Users\TEMP\Documents\wages.txt' firstobs=2; 
input EDUCATION SOUTH SEX EXPERIENCE UNION WAGE AGE RACE OCCUPATION SECTOR MARR; 
run;

proc print data=wages;
run;