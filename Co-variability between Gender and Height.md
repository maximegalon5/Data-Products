Co-variability between Gender and Height
========================================================
author: Vivek Narayan
date: October 19, 2018
width: 1440
height: 1000

Difference in weight between males and females
========================================================


If one didn't know anything about human physiology, one could naively think the difference in weight was due to gender, per se. However, that would fail to account for the fact that on average human males tend to be taller than human females.

![plot of chunk unnamed-chunk-2](Co-variability between Gender and Height-figure/unnamed-chunk-2-1.png)


Variability in Human weight due to height
========================================================


```

Call:
lm(formula = log(mini_data_set$Weight) ~ mini_data_set$Height)

Residuals:
    Min      1Q  Median      3Q     Max 
-1.0982 -0.1451 -0.0132  0.1308  1.2417 

Coefficients:
                      Estimate Std. Error t value Pr(>|t|)    
(Intercept)          6.9985893  0.0353172  198.16   <2e-16 ***
mini_data_set$Height 0.0116506  0.0002075   56.16   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.2099 on 9108 degrees of freedom
Multiple R-squared:  0.2572,	Adjusted R-squared:  0.2571 
F-statistic:  3154 on 1 and 9108 DF,  p-value: < 2.2e-16
```

Note the R-squared value: ~25 % of the variability in Weight can be attributed to the variability in Height. What attribution can be made to Gender?


The App Overview
========================================================

- The app allows users to choose between displaying the distibution of Weight (Data obtained from the BRFSS Dataset) <https://www.cdc.gov/brfss/annual_data/annual_2017.html> through the framing reference of:
    + Gender
    + Aerobic Excercise - whether a survey respondant met the aerobic activitiy requirements or not per BRFSS research guidelines (see `X_PAINDX1` in dataset codebook <https://www.cdc.gov/brfss/annual_data/2017/pdf/codebook17_llcp-v2-508.pdf>

- The app then invites the user to click a button to perform a regression analysis on Weight v. their chosen factor variable after controlling for Height.

- Apart from satisfying the requirements of the submission, the objective to the app is to demonstrate the co-variability between Gender and Height when considering variability in Weight among humans. Why not check it out?


Links
========================================================

The app can be found here <https://gormonjee.shinyapps.io/Fun_with_weight/>

The BRFSS dataset can be found here <https://www.cdc.gov/brfss/annual_data/annual_2017.html>

The github repo for the entire project can be found here <https://github.com/maximegalon5/Data-Products>
