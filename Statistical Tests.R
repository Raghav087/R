library(dplyr)
library(purrr)
library(gapminder)
##CHI-SQUARE TEST for difference between >2 sample proportions.
#We'll have 2 categorical variables- one having exactly 2 levels and the other having n levels thereby giving us a 2 x n contingency table.
#The categorical variable with n levels signifies n samples to be tested for significant difference in proportions across the 2 levels
#coming from the other categorical variable.
#Creating a table from scratch.Then applying chi-square test for difference in proportions between 2 samples A and B.
d23 <- matrix(c(17, 25, 39, 42, 32, 5, 21, 34, 49, 25), byrow = T, ncol = 5)
colnames(d23) <- c('C1', 'C2', 'C3', 'C4', 'C5')
rownames(d23) <- c('A', 'B')
t1 <- as.table(d23)
t1  #This is a 2 x 5 contingency table. We want to test whether the 5 samples have statistically different proportions of A and B.
chisq.test(t1)

#Creating a table and then applying chi-square test for difference in proportions between 2 samples Male and Female.
d22 <- matrix(c(60, 54, 46, 41, 40, 44, 53, 57), byrow = T, ncol = 4)
colnames(d22) <- c('High School', 'Bachelors', 'Masters', 'Phd')
rownames(d22) <- c('Female', 'Male')
t2 <- as.table(d22)
t2  #This is a 2 x 4 contingency table. We want to test whether the 4 samples have statistically different proportions of Female and Male.
chisq.test(t2)



#CHI-SQUARE TEST for Goodness of Fit.
#Here we'll have 1 categorical variable with k levels each with some observed frequency. The idea is to calculate either expected frequency
#or expected probability based on the underlying distribution the variable comes from and hence test the hypothesis whether the underlying
#distribution is a "good fit" for the observed frequency distribution.
#The following tests a categorical variable having 5 levels with its observed frequencies whether there exists a significant difference
#in the proportions or the difference observed is just by random chance.
chisq.test(x = c(180, 120, 225, 250, 225), p= c(0.2, 0.2, 0.2, 0.2, 0.2))
               #OR
chisq.test(x = c(180, 120, 225, 250, 225)) #When each level has same expected probability, then we can skip to supply the 'p' argument.

#Following example tests whether the proportion of observed frequencies for each level of 'gear' variable is statistically significantly
#different or the observed difference isn't high enough and thus attributed to random chance.
chisq.test(table(mtcars$gear))
#Similarly, we test for categorical variable 'carb'.
table(mtcars$carb) %>% chisq.test()



#CHI-SQUARE TEST for Independence.
#Here we test the hypothesis whether the 2 categorical variables are dependent/associated to each other.
m1 <- matrix(c(18,12,6,3,36,36,9,9,21,45,9,9,9,36,3,6,6,21,3,3), byrow = F, ncol = 5)
rownames(m1) <- c('Never Married', 'Married', 'Divorced','Widowed')
colnames(m1) <- c('Middle School','High School','Bachelors','Masters','Phd +')
t3 <- as.table(m1)
t3
chisq.test(t3) #We get a warning 'Chi-squared approximation may be incorrect' as 1 or more cell values in contingency table is < 5.



#ANALYSIS OF VARIANCE(ANOVA)
head(iris)
#Following returns full summary statistics on each numeric column for each level/group of 'Species' variable.
iris %>% split(.$Species) %>% map(summary)
#We can also use following to output a specific summary stat based on levels of a categorical variable.
iris %>% group_by(Species) %>% summarize(Mean = mean(Sepal.Length))
#We notice the mean of 'Sepal.Length' appears different for each level of 'Species' column.

#One-Way ANOVA
#Here the values of a numeric variable(dependent) 'Sepal.Length' are affected by levels of only one factor(independent) i.e. 'Species'.
f1 <- aov(iris$Sepal.Length ~ iris$Species, data = iris)
summary(f1)
#Based on the result, we reject the null hypothesis and conclude that mean of 'Sepal.Length' is statistically significantly different
#for each level of 'Species' column.

#Two-Way ANOVA
#Here the values of a numeric variable(dependent) are affected by levels of two categorical variable. The levels of one variable lie along
#row while that of the other variable lie along the column in contingency table format.
#We have two types of 2-Way ANOVA - with replication and without replication.
#Following are the 3 null hypothesis we construct in Two-Way ANOVA :
#Ho1 : All levels of Row Factor have same effect on dependent variable.(Mean of all row levels is equal)
#Ho2 : All levels of Column Factor have same effect on dependent variable.(Mean of all column levels is equal)
#Ho3 : There is no interaction effect between Factor A and Factor B. Hence each combination of levels of both has same effect on
#      dependent variable.(This hypothesis is ONLY applicable for ANOVA with replication.)






head(ToothGrowth)
?ToothGrowth
