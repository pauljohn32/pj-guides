<div class="row">

<div class="col-sm-3">

<!---
<img src="https://crmda.dept.ku.edu/images/logoleft.png">
--->

</div>

<div class="col-sm-6">

<h1 class="title" id="meta">

Basic Exploratory Factor Analysis (EFA) Example

</h1>

<div class="separator">

</div>

<div class="author_info">

<table>

<tr>

<td class="author">

Ben Kite,

</td>

<td class="institute">

CRMDA,

</td>

<td class="email">

<>

</td>

</tr>

</table>

</div>

<div class="keywords" id="meta">

Tags: 

</div>

</div>

<div class="col-sm-3">

<!---
<img src="https://crmda.dept.ku.edu/images/logo-vert.png">
--->

<div class="date" id="meta">

2018-07-27

</div>

</div>

</div>

<div class="abstract" id="meta">

Abstract: 

</div>


# Table of Contents

1.  [Title Command](#orgc9933c5)
2.  [Data Command](#org392e7cb)
3.  [Variable Command](#org77918ff)
4.  [Analysis Command](#orgf56ad3e)
5.  [Output](#org4b118f6)
6.  [Review the Results](#org18d6d2c)


<a id="orgc9933c5"></a>

# Title Command

This is used to name your Mplus input file. Insert a memorable
description of the exercise, so you can remember what it does
when you return in the future.

    TITLE:
    Example 1 - Exploratory Factor Analysis


<a id="org392e7cb"></a>

# Data Command

This is where the data file is specified.  If the data file is in the
same folder as your .inp file, the user simply needs to specify the
name of the file (e.g., "FILE IS `job_placement.csv`").  If the data
file is in different folder, the user needs to specify the path to the
datafile here. Below the "`../../data/job_placement.csv`" command is
telling Mplus to start in the folder where the .inp file is saved,
then go back two levels ("../../"), go into the "data" folder
("data/"), and then find the data file ("`job_placement.csv`").  Note
that the FILE is line ends with a semicolon, this is required at the
end of each line in all commands except the TITLE command.  Remember,
the datafile can only be a matrix of numerical values, no variable
names are allowed in the imported data.

    DATA:
      FILE IS "../../data/job_placement.csv";


<a id="org77918ff"></a>

# Variable Command

Once the data file is read in, information about the dataset must be
provided. This is done in the VARIABLE command. There are no variable
names in the data file, so these must be entered here by the
user. Under "NAMES ARE", the user must list the variable columns in the
data file from left to right. It is extremely important that the
number of variables and the order of the variables are entered
correctly. 

    VARIABLE:
      NAMES ARE
      id wjcalc wjspl wratspl wratcalc waiscalc waisspl
      edlevel newschl suspend expelled haveld female age;

After the variables in the data file are named, the user
can then specify which variables they want to include in the model
under "USEVARIABLES ARE". In this example the user wants to run an EFA
with six indicator variables, so only those six variables are entered
into the "USEVARIABLES ARE" command.  

    USEVARIABLES ARE
    wjcalc wjspl wratspl wratcalc waiscalc waisspl;

Lastly, there are missing values
in the data file that have been replaced with "99999".  The "MISSING
ARE all (99999);" command tells Mplus that all values equal to 99999 are
not truly equal to 99999 and that they should be treated as missing.

    MISSING ARE all(99999);


<a id="orgf56ad3e"></a>

# Analysis Command

The ANALYSIS command can be used to specify a variety of analyses.
Here the line "TYPE = EFA 1 2;" is telling Mplus to do an EFA and to
fit models with 1 and 2 factors, plus all whole numbers in between
(there are none in this case).  If we were to enter "TYPE = EFA 1 3;",
then Mplus would test models with 1, 2, and 3 latent factors.

    ANALYSIS:
      TYPE = EFA 1 2;


<a id="org4b118f6"></a>

# Output

    mplus efa-01.inp

    
    Mplus VERSION 8 (Linux)
    MUTHEN & MUTHEN
    
    Running input file 'efa-01.inp'...
    
    Beginning Time:  15:34:56
       Ending Time:  15:34:56
      Elapsed Time:  00:00:00
    
    Output saved in 'efa-01.out'.


<a id="org18d6d2c"></a>

# Review the Results

Click [efa-01.out](efa-01.out) to see the output.

