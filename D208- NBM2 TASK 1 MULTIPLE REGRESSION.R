#### PROJECT MEDICAL DATA - Class D208 Medical Data
# Jason Smith
# Student ID: 293963
# jsmi268@wgu.edu
# WGU - MSDA
# D208- Task 1: Multiple Regression for Predictive Modeling of Hospital Data
# Program Mentor: Christiana Okhipo

#Part III: Data Preparation

# Version of the environment
R.Version() #4.1.1

# Load libraries
library(dplyr)
library(broom)
library(summarytools)
library(Hmisc)

#open clean csv: C:\Users\smith\OneDrive\Jason\wgu\Assignments\D207 Data Exploration\Data Files
# C:\Users\smith\OneDrive\Jason\wgu\Assignments\D208 Predictive Modeling
meddf<-read.csv(file.choose(), header=TRUE)
summary(meddf)

# Random sampling of 500 rows
set.seed(1000) # make replicable with seed 1K
df_1<-meddf[sample(nrow(meddf),500),]

# Create new data frame with irrelevant columns removed
df <- df_1[,c('Population', 'Area', 'Job',
              'Education', 'Employment', 'Marital', 'Gender', 'ReAdmis',
              'VitD_levels', 'Doc_visits', 'Full_meals_eaten', 'VitD_supp',
              'Soft_drink', 'Initial_admin', 'HighBlood', 'Stroke', 'Treatment',
              'Complication_risk', 'Arthritis', 'Diabetes', 'Hyperlipidemia',
              'BackPain', 'Allergic_rhinitis', 'Reflux_esophagitis', 'Asthma',
              'Services', 'TotalCharge', 'Additional_charges', 'Admissions',
              'Treatment', 'Visits', 'Reliability', 'Options', 'Hours', 'Courteous',
              'Dr_comm', 'Children', 'Age', 'Income', 'Overweight', 'Anxiety',
              'Initial_days')]

meddf$Initial_days #continuous dependent
meddf$Initial_admin

# Minimum sample size:  50 + 8K
min_samp_size <- 50 + 8*ncol(df)
min_samp_size

# Convert Population to categorical 
df$popclass <- cut(df$Population, breaks = c(0,4000,8000, Inf), labels = c("small", "medium", "large"))
summary(df['popclass'])

# drop 7 data points that could not be converted                   
df <- na.omit(df)
summary(df['popclass'])

# Identify char

char_cols <-  unlist(lapply(df, is.character))
chardf <- df[,char_cols]
colnames(chardf)
#chardf$ar <-unclass(chardf$Area)

# Create new df for variable conversions
df2 <- df
str(df2)

# Convert char variables to numeric

unique(df[c("Area")])
df2$Area <- recode(df$Area,
                           "Urban" = 1, "Suburban" = 2, "Rural" = 3) 
unique(df[c("Job")])
df2$Job <- as.integer(as.factor(df$Job))

unique(df[c("Education")])
df2$Education <- recode(df$Education,
                       "Regular High School Diploma" = 1, "Some College, 1 or More Years, No Degree" = 2, "9th Grade to 12th Grade, No Diploma" = 3,
                       "Master's Degree" = 4, "Some College, Less than 1 Year" = 5, "Bachelor's Degree" = 6,
                       "Nursery School to 8th Grade" = 7, "Associate's Degree" = 8, "Professional School Degree" = 9,
                       "No Schooling Completed" = 10, "Doctorate Degree" = 11, "GED or Alternative Credential" = 12)
unique(df[c("Employment")])
df2$Employment <- recode(df$Employment,
                       "Full Time" = 1, "Unemployed" = 2, "Retired" = 3,
                       "Student" = 4, "Part Time" = 5) 
unique(df[c("Marital")])
df2$Marital <- recode(df$Marital,
                             "Widowed" = 1, "Married" = 2, "Never Married" = 3, "Divorced" = 4, "Separated" = 5)
unique(df[c("Gender")])
df2$Gender <- recode(df$Gender,
                          "Male" = 1, "Female" = 2, "Prefer not to answer" = 3) 
unique(df[c("ReAdmis")])
df2$ReAdmis <- recode(df$ReAdmis,
                         "Yes" = 1, "No" = 2) 
unique(df[c("Soft_drink")])
df2$Soft_drink <- recode(df$Soft_drink,
                          "Yes" = 1, "No" = 2) 
unique(df[c("Initial_admin")])
df2$Initial_admin <- recode(df$Initial_admin,
                             "Observation Admission" = 1, "Emergency Admission" = 2, "Elective Admission" = 3)
unique(df[c("HighBlood")])
df2$HighBlood <- recode(df$HighBlood,
                             "Yes" = 1, "No" = 2)
unique(df[c("Stroke")])
df2$Stroke <- recode(df$Stroke,
                            "Yes" = 1, "No" = 2) 
unique(df[c("Complication_risk")])
df2$Complication_risk  <- recode(df$Complication_risk ,
                     "Low" = 1, "Medium" = 2, "High"=3) 

unique(df[c("Arthritis")])
df2$Arthritis <- recode(df$Arthritis,
                         "Yes" = 1, "No" = 2) 
unique(df[c("Diabetes")])
df2$Diabetes <- recode(df2$Diabetes,
                            "Yes" = 1, "No" = 2)

unique(df[c("Hyperlipidemia")])
df2$Hyperlipidemia <- recode(df$Hyperlipidemia,
                           "Yes" = 1, "No" = 2) 
unique(df[c("BackPain")])
df2$BackPain <- recode(df$BackPain,
                           "Yes" = 1, "No" = 2) 
unique(df[c("Allergic_rhinitis")])
df2$Allergic_rhinitis <- recode(df$Allergic_rhinitis,
                           "Yes" = 1, "No" = 2) 
unique(df[c("Reflux_esophagitis")])
df2$Reflux_esophagitis <- recode(df$Reflux_esophagitis,
                           "Yes" = 1, "No" = 2) 
unique(df[c("Asthma")])
df2$Asthma <- recode(df$Asthma,
                           "Yes" = 1, "No" = 2) 
unique(df[c("Services")])
df2$Services <- recode(df$Services,
                                     "Blood Work" = 1, "Intravenous" = 2,"MRI" = 3, "CT Scan" = 4)
unique(df[c("popclass")])
df2$popclass <- recode(df$popclass,
                           "small" = 1, "large" = 2, "medium" = 3) 

# Verify df2 conversion to numeric
str(df2)

# Check for missing values
which(is.na(df))

# Verify datatypes
str(df)


# Determine outliers using box plots
num_cols <- unlist(lapply(df, is.numeric))
num_cols
numdf <- df[, num_cols]
boxplot(numdf)
head(numdf)

# Variable groupings(continuous, discrete, binar)
contdf <- df[,c('Population', 'VitD_levels', 'TotalCharge', 'Additional_charges', 'Children', 'Age', 'Income', 'Overweight', 'Anxiety', 'Initial_days')]
colnames(contdf)

discdf <- df[,c('Admissions','Treatment', 'Visits', 'Reliability', 'Options', 'Hours', 'Courteous',
                'Dr_comm','Doc_visits', 'Full_meals_eaten', 'VitD_supp')]
colnames(discdf)

bindf <- df[,c('ReAdmis','Soft_drink', 'HighBlood', 'Stroke', 'Arthritis', 'Diabetes', 'Hyperlipidemia',
'BackPain', 'Allergic_rhinitis', 'Reflux_esophagitis', 'Asthma')]
colnames(bindf)

catdf<- df[,c('Area', 'Job', 'Education', 'Employment', 'Marital', 'Gender',  'Initial_admin', 'Complication_risk', 'Services')]
summary(catdf)
colnames(catdf)

#Reduced set of vars for first regression
regrdf <- df2[,c('Initial_days', 'ReAdmis', 'popclass', 'TotalCharge', 'VitD_levels'
                , 'Admissions','Treatment', 'Visits', 'Hours', 'Courteous'
                , 'Dr_comm', 'Complication_risk')]

# Confirm df components
str(regrdf)

#C2 Summary statistics
summary(contdf)

descr(contdf,
      headings = FALSE, # remove headings
      stats = "common") #most common descriptive statistics)

descr(discdf,
      headings = FALSE, # remove headings
      stats = "common") #most common descriptive statistics)

descr(regrdf,
      headings = FALSE, # remove headings
      stats = "common" # most common descriptive statistics
)

# Discrete data
# frequency table
library(summarytools)

freq(catdf, report.nas = FALSE, # remove NA information
     totals = FALSE, # remove totals
     cumul = FALSE, # remove cumuls
     headings = FALSE # remove headings
)

freq(bindf, report.nas = FALSE, # remove NA information
     totals = FALSE, # remove totals
     cumul = FALSE, # remove cumuls
     headings = FALSE # remove headings
)

# Cross tab 
ctable(
  x = regrdf$ReAdmis,
  y = regrdf$Treatment
)

ctable(
  x = regrdf$ReAdmis, 
  y= regrdf$Admissions
)

ctable(
  x = regrdf$ReAdmis, 
  y= regrdf$Complication_risk
)

ctable(
  x = regrdf$ReAdmis, 
  y= regrdf$Dr_comm
)

ctable(
  x = regrdf$ReAdmis, 
  y= regrdf$popclass
)



# C4 Visualizations
#univariate

# Histograms
library(Hmisc)
hist.data.frame(contdf)

# Use pairs function to create scatter plots to determin variable relation 
pairs(numdf[1:7], cex.labels =2, font.labels =2)
pairs(numdf[7:14], cex.labels =2, font.labels =2)
pairs(numdf[14:21], cex.labels =2, font.labels =2)
pairs(numdf[1:7], cex.labels =2, font.labels =2)
pairs(numdf[7:14], cex.labels =2, font.labels =2)
pairs(numdf[14:21], cex.labels =2, font.labels =2)


# Use correlation matrix to determine relationships
R<-cor(df2)

# Boxplot 
boxplot(cont_df) #of continuous data
boxplot(discdf)

# Histograms
hist(cont_df)

# Heatmap
heatmap(R) # correlated data

# C5 Prepared data
# Writing CSV file in R
write.csv(df,"c:\\jason\\D208_regression_data.csv", row.names = FALSE)

#Part IV: Model Comparison and Analysis

#D1 Initial Model:

# See col names of initial model
n<- names(regrdf)
n

# Select dependent and independent variables
form1 = as.formula(paste("Initial_days ~", paste(n[!n %in% "NumOfInitialDays"]
                                                 , collapse = " + "))) 

#Fit a multiple linear regression 
MLModel = lm(form1,data = regrdf) #* warning message
MLModel

# Summarize model
summary(MLModel)

#D3 Reduced multiple regression model 

# New reduced data frame
regrdf2 <-regrdf[,c('Initial_days', 'ReAdmis', 'TotalCharge', 'VitD_levels'
                    , 'Complication_risk')]

# Column names of new data frame
n <- names(regrdf2)


# Select dependent and independent variables
form1 = as.formula(paste("Initial_days ~", paste(n[!n %in% "NumOfInitialDays"]
                                                 , collapse = " + "))) 

#Fit a multiple linear regression 
MLModel = lm(form1,data = regrdf2) #* warning message
MLModel

# Summarize model
summary(MLModel)

# E1 Model Comparison
# Equation of a line
  # ReAdmis
Xa <- 1.00
  # TotalCharge
Xb <- 500.00
# VitD_levels
Xc <- 1.00
  # Complication_risk
Xd <- 3.00

  # Equation of a line containing coefficients and values for X(a,b,c,d)
Initial_days = 62.52 - 7.08 * Xa + 0.0077 *Xb - 2.96*Xc - 2.35*Xd
Initial_days

# Predictions
Pred <- predict(MLModel)

# Histogram of residuals
hist(residuals(MLModel), col = "steelblue")

#Plot of predicted values versus actual values 
plot(regrdf[,5], Pred,
     xlab= "Actual", ylab= "Predicted")
abline(a=0, b=1) #ab line with slope of 1

# Analysis of residuals
par(mfrow=c(2,2))
plot(MLModel)
