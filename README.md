# D208---Predictive-Modeling
Using multi-linear regression to predict hospital readmissions

## Research question:
This study will attempt to answer the following question:
Can hospital patient readmissions be predicted based on the services received at the hospital during his or her initial visit? What are the best predictors of hospital readmissions? 

## Objective and Goals
The project stakeholders require the ability to predict which patients are most likely to be readmitted into the hospital and any correlations that may offer clues that lead to patient readmittance. 
These patients can then be targeted for additional information and more attention to potentially avoid costly readmission

## Summary of Assumptions for Multiple Linear Regression model: 
•	The dependent variable value is what we would like to predict based on relationships of dependent variables.
•	Linear relationship between the independent and dependent variables. Tested using scatter plots
•	The residuals are normally distributed and have a mean of 0. 
•	Sample data is picked randomly.
•	Independent variables are not strongly correlated. 
•	There is a homogeneity of variance (homoscedasticity) present with the data which means the error of the prediction is reasonably consistent across all data values (Bevans, 10/26/2020). 

## Tools and Benefits:  
I chose to use R for this analysis for several reasons.  I wanted more exposure to R and further build my comfort level.  It is relatively easy to learn and use.  It has powerful data science libraries. 

##  Appropriate Technique:  
Single Linear Regression is used to develop models and make predictions based from a single variable. Sometimes Simple Linear Regression is not capable of establishing relationships using a single variable based on complex datasets. 

Multiple Linear Regression analysis is used to make predictions based from more than one dependent variable.  Multiple linear regression will help determine which one or more predictors relationships that lead to patient readmission. Improper variable selection and analysis can lead to misleading results. 

## Visualizations
![alt text] (https://github.com/smithjs135/D208---Predictive-Modeling/blob/main/courteous.jpg “Courteous”)
![alt text] (https://github.com/smithjs135/D208---Predictive-Modeling/blob/main/dr_comm.jpg “dr_comm”)
![alt text](https://github.com/smithjs135/D208---Predictive-Modeling/blob/main/equat_of_line.jpg “Eq_line”)
![alt text](https://github.com/smithjs135/D208---Predictive-Modeling/blob/main/full_meals.jpg “full_meals”)
![alt text] (https://github.com/smithjs135/D208---Predictive-Modeling/blob/main/heatmap.jpg “heatmap”)

## Initial Model
<initial_model>

## Justification of Model Reduction: 
An initial multiple regression was performed using 12 variables.  Continuous variable, "Initial_days" was chosen as the target variable and the independent variables follow: "ReAdmis", "popclass", "TotalCharge", "VitD_levels", "Admissions", "Treatment", "Visits", Hours", "Courteous", "Dr_comm", "Complication_risk". 
The summary () function was called on the model.  The resulting R-squared indicates 68% of the "Initial_days” can be explained by the model.  The P-value of the model is < 2.2e-16 which shows significance because it is much lower than the alpha value of 0.05. Furthermore, four variables displayed significant P-values.  These variables include “ReAdmis”, “TotalCharge”, “VitD_Levels” and “Complications_risk”.

## Model Comparison:
•  Variable selection:
The initial linear regression analysis was reduced to avoid over fitting.  The following variables were selected: “Initial_days”, “ReAdmis”, “TotalCharge”, “VitD_Levels” and “Complications_risk”.  These variables were selected due to their low P-values scores in relation to alpha threshold of 0.05.  
<equat_of_line>


## Output and Calculations
<summary>
<predicted vs act>

< hist_of_resid>
<resid_charts>

## Summary
The equation of a lined from step 1 was used to evaluate ‘Initial_days’ of 49.28 days based on the inputted values. 
 
•  Revised model coefficients:
The revised model consisted of the following independent variables with coefficients “ReAdmis”(-7.08), “TotalCharge”(0.0077), “VitD_Levels”(-2.96) and “Complications_risk”(-2.35).  

•  Statistical and practical significance of the model
The multiple R-squared value indicates the revised model has a 67% chance of correctly predicting initial days based on the independent variables.  The P_values for all of the independent variables are below the alpha threshold of 0.05 which implies significance.  See P-values below:
“ReAdmis”( 0.00286), “TotalCharge”(- 2e-16), “VitD_Levels”(- 2e-16) and “Complications_risk”( 0.00905).  
The residual standard error(a.k.a RMSE) is 14.3 calculated on a sample size of 492.
The P_value of the model is 2e-16 and the f-statistic is 252 which implies model significance. 
The Residuals vs Fitted and Scale-Location plots show some heteroskedasticity which is an indication of a non-normal distribution.  In addition, Scale_Location and Residuals vs Leverage plots show patterns in residual variance from the fitted values. The Normal Q-Q plot generally plotted a straight line on the diagonal. 

•  Limitations of the data analysis
The heteroskedasticity displayed in Residuals vs Fitted, Scale-Location, and Residuals vs Leverage plots indicate the residuals are not equally balanced on either side of the fitted line.  This possibly indicates some tendencies of a non-normal distribution. A higher R-squared value would beneficially indicate higher model accuracy. 

## Recommendations
Patients that have been readmitted, have higher charge amounts, lower values for complication & risk, and lower vitamin D levels do tend to have longer initial visits. Hospital management may wish to target these patients in their attempts to reduce the length of the initial visit.

## Sources for Third Party Code 
1.	RStudio Community(2018, P.1)SOLVED: Recode variable from text to numbers - General - RStudio Community.https://community.rstudio.com/t/solved-recode-variable-from-text-to-numbers/10580/12
2.	M, Klisovic RB, Penza S, Schmidt CR. (October 15, 2011–April 15, 2012). Examination of Unplanned 30-Day Readmissions to a Comprehensive Cancer Hospital. https://ascopubs.org/doi/10.1200/JOP.2014.001546
3.	Mary MchHugh (Jun, 2013, Section: Introduction). The Chi-square test of independence
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3900058


## Sources(in-line)

1.	Giuseppe Ciaburro. (2018, (p.162 - 206)). Regression Analysis with R. 
2.	Statistics Solutions(p. 1). Assumptions of Multiple Linear Regression
https://www.statisticssolutions.com/wp-content/uploads/wp-post-to-pdf-enhanced-cache/1/assumptions-of-multiple-linear-regression.pdf#:~:text=Assumptions%20of%20Multiple%20Linear%20Regression%20Multiple%20linear%20regression,assumptions%3A%20Linear%20relationshipMultivariate%20normalityNo%20or%20little%20multicollinearityNo%20auto-correlationHomoscedasticity
3.	M Moocarme(p. 1). R vs. Python – Linear Regression
http://www.mattmoocar.me/R-Vs-Python-LinRegress/
4.	Rebecca Bevans (October 26, 2020).  An Introduction to Multiple Linear Regression
https://www.scribbr.com/statistics/multiple-linear-regression/
5.	Angela. R. Guess. (2015, p.1). The Many Benefits of R 
https://www.dataversity.net/the-many-benefits-of-r/
6.	“broom: let’s tidy up a bit”(p.1), 
https://www.r-project.org/nosvn/pandoc/broom.html#:~:text=The%20broom%20package%20takes%20the%20messy%20output%20of,a%20powerful%20framework%20for%20data%20manipulation%20and%20analysis.


