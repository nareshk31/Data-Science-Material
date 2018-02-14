* Probit and Logit Models in SPSS.
* Copyright 2014 by Ani Katchova.

GET
  FILE='C:\Econometrics\Data\probit_insurance.sav'.

* Descriptive statistics.
DESCRIPTIVES VARIABLES=ins retire age hstatusg hhincome educyear married hisp
  /STATISTICS=MEAN STDDEV MIN MAX.

* Regression.
* Analyze > Regression > Linear. Dependent: (Yvar), Independent (Xvar).
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT ins
  /METHOD=ENTER retire age hstatusg hhincome educyear married hisp.

* Logit model.
* Analyze > Regression > Binary Logistic.  Dependent: (Yvar), Covariates (Xvar). Save (Predicted Probablities).
LOGISTIC REGRESSION VARIABLES ins
  /METHOD=ENTER retire age hstatusg hhincome educyear married hisp 
  /SAVE=PRED
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).


