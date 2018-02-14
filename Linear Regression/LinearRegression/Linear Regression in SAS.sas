* Linear Regression in SAS;
* Copyright 2013 by Ani Katchova;

proc import out= work.data
datafile= "/folders/myfolders/Econometrics/LinearRegression/regression_auto.csv" 
dbms=csv replace; getnames=yes; datarow=2; 
run;

* Descriptive statistics;
proc means data=data;
var mpg weight1 price foreign;
run;

* Detailed descriptive statistics;
proc univariate data=data;
var mpg;
run;

* Correlations;
proc corr data=data;
var mpg weight1 price foreign;
run; 

* Plotting the data;
proc gplot data=data;
plot mpg*weight1;
run;

* Simple linear regression;
proc reg data=data; 
model mpg = weight1; 
run;

* Multiple linear regression;
proc reg data=data; 
model mpg = weight1 price foreign; 
run;
