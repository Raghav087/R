install.packages('readr')
install.packages('repr')
install.packages('caret')
library(readr)
library(repr)
library(ggplot2)
library(caret)
library(plyr)
library(dplyr)

loan_df <- read.csv('F:/IIML Sessions/R Codes/Code files & Others/loan_data_set.csv')
head(loan_df)
loan_df1 <- loan_df[-1] #Remove column with index 1 i.e. 'Loan_ID'.
head(loan_df1)
glimpse(loan_df1) #Gives a snapshot of dataframe in an inverted format i.e. columns appearing in rows with values appearing horizontally.
summary(loan_df1) #Gives summary statistics on the numeric columns and basic info(class,length) for character columns.
dim(loan_df1)
colSums(is.na(loan_df1)) #Calculate sum of missing values across each column in a dataframe.
sum(colSums(is.na(loan_df1))>0) #Calculate no. of columns having missing values.
sum(colSums(is.na(loan_df1))==0) #Calculate no. of columns having non-missing values.
sum(rowSums(is.na(loan_df1))>0) #Calculate no. of rows having missing values.
sum(rowSums(is.na(loan_df1))==0) #Calculate no. of rows having non-missing values.

table(loan_df1$Credit_History) #We use 'table' function to see the counts/occurance of each value of 'Credit_History' column in a tabular format.
loan_df1$Credit_History[is.na(loan_df1$Credit_History)]<-1 #As we already know that 'Credit_History' column has missing values, we replace them by 1.
loan_df1$LoanAmount[is.na(loan_df1$LoanAmount)]<-median(loan_df1$LoanAmount,na.rm = TRUE) #We replace the missing values in column 'LoanAmount' by the median of the column calculated by excluding the missing values.
loan_df1$Gender<-ifelse(loan_df1$Gender=='Male',1,0) #The 'ifelse' function has 1st argument as the 'if' condition. The 2nd argument is the 'then' condition while 3rd the 'else' condition.
table(loan_df1$Gender) #Now the 'Male' and 'Female' values have been recoded as 1 and 0.

install.packages('e1071')
library(e1071)
skewness(loan_df1$ApplicantIncome) #Measure the skewness on the selected column values.
skewness(loan_df1$CoapplicantIncome)
loan_df1$LogApplicantIncome <- log(loan_df1$ApplicantIncome) #Transform the column values by taking log.
skewness(loan_df1$LogApplicantIncome) #The skewness in the transformed column is much lesser now after taking log transformation.
# If Skewness < -1 or > 1 then distribution is highly skewed.
# If -1 < Skewness < -0.5 0r 0.5 < Skewness < 1 then distribution is moderately skewed.
# If -0.5 < Skewness < 0.5 then distribution is approximately normal.


#Standardize the columns having different scales.
#As a definition, standardizing a variable X means calculating z-score for each of its values x i.e. z = (x-mean(X))/sd(X)
#Luckily, we have a function called 'scale' which does this for us.
student_id <- 1:10
math <- c(502,600,412,358,495,512,410,625,573,522)
science <- c(95,99,80,82,75,85,80,95,89,86)
english <- c(25,22,18,15,20,28,15,30,27,18)
df <- data.frame(student_id,math,science,english)
df
apply(df[2:4],2,mean) #Calculate mean of specified columns('2' as 2nd argument.'1' for row-wise.) of 'df' dataframe.
apply(df[2:4],2,sd)   #Calculate std. deviation of specified columns.
#As evident, we can't compare 'math','science' and 'english' columns(i.e. mean, s.d. etc.) as they have a different scale. We also can't form a composite score from all 3 unless they are same scale.
z1 <- scale(df[2:4]) #By default, options 'center=TRUE' and 'scale=TRUE'. This is the normal method of standardizing the columns.
z1 <- data.frame(z1) #Since the output of 'scale' function isn't a dataframe, we convert it into one. This enables us to perform calculations on our scaled columns.
z2 <- scale(df[2:4],center=FALSE) #Perform scaling keeping 'center=FALSE'. This will divide the column values by root mean square(rms) value of the column.
z2 <- data.frame(z2)
z3 <- scale(df[2:4],scale=FALSE)  #Perform only centering and not scaling. Here we simply subtract the mean from each value of the column.
z3 <- data.frame(z3)
apply(z1,2,sd) #Now the std. deviation in scaled data has improved compared to the original dataframe.

#Lets apply the standardization to our loan dataframe.
apply(loan_df1[c('ApplicantIncome','LoanAmount')],2,sd)
ldf <- apply(loan_df1[c('ApplicantIncome','LoanAmount')],2,scale) #Scale the specific columns of the dataframe and store the scaled data in a new object.
apply(ldf,2,sd) #The std. deviation on the scaled data is now equal to 1.

#Since we want to standardize only specific columns of dataframe and not all, the 'apply' function isn't a good choice.
#We've specified the columns needed to be standardized, but it also subsets the dataframe on those columns. So 'ldf' dataframe has only 2 columns specified for standardization.
#What if we want to standardize specific columns keeping the rest of columns intact without subsetting?
ldfz<- loan_df1 %>% mutate_at(scale,.vars=vars('LoanAmount','ApplicantIncome'))
head(ldfz) #The original dataframe's columns are still intact, just the specified columns have been standardized.
sd(ldfz$ApplicantIncome) #The column 'ApplicantIncome' has been successfully standardized.