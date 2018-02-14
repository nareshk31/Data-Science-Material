* Panel Data Models in SAS;
* Copyright 2013 by Ani Katchova;

proc import out= work.data
datafile= "C:\Econometrics\Data\panel_wage.csv" 
dbms=csv replace; getnames=yes; 
run;

proc means data=data;
var id t lwage exp exp2 wks ed;
run;

proc sort data=data;
by id t;
run;

*Pooled OLS estimator;
proc reg data=data;
model lwage = exp exp2 wks ed;
run;

*Pooled OLS estimator;
proc panel data=data;
id id t;
model lwage = exp exp2 wks ed /POOLED;
run;

*Between group estimator;
proc panel data=data;
id id t;
model lwage = exp exp2 wks ed /BTWNG;
run;

*Fixed effects or within estimator;
proc panel data=data;
id id t;
model lwage = exp exp2 wks ed /FIXONE;
run;

*Fixed effects or within estimator;
proc tscsreg data=data;
id id t;
model lwage = exp exp2 wks ed /FIXONE;
run;

*Random effects estimator;
proc tscsreg data=data;
id id t;
model lwage = exp exp2 wks ed /RANONE;
run;

*Random effects estimator;
proc panel data=data;
id id t;
model lwage = exp exp2 wks ed /RANONE;
run;

*Random effects estimator with Breusch-Pagan LM test;
proc panel data=data;
id id t;
model lwage = exp exp2 wks ed /RANONE BP;
run;

