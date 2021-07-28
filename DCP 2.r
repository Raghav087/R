mat <- c(1, 2, 1, 5, 6, 9)  #We create a vector 'mat' having 6 values.
a <- matrix(mat, 3, 2)  #We pass vector 'mat' as 1st argument to 'matrix' function. The 2nd argument is the no. of rows and 3rd is the no. of columns the matrix will have.
a
b <- matrix(mat, 3, 2, TRUE) #The 4th argument 'byrows' takes TRUE/FALSE as values. When TRUE, the values get filled row-wise. The default is FALSE i.e. values getting filled column-wise.
b
c <- matrix(mat, 4, 2, TRUE) #The 'mat' vector has 6 values, but here we're trying to pass them into a matrix having 8 cells(4*2). It first shows a warning, fills the 6 values column-wise, then repeats itself and fills the remaining 2 cells.
c

b == 1 #This is a condition as it has a conditional operator '=='. It checks condition at each cell of matrix 'b' whether the cell value is equal to 1. The result is matrix 'b' having values TRUE/FALSE as per condition.
b[b == 1] #We already know what is happening inside the braces. When we write 'b[any condition]' it means we are trying to extract some values from matrix 'b' as output depending on specified condition inside the braces.
          #So this simply gives output as values at those cells where it finds a TRUE.
b[b == 1] <- 15  #This is an assignment. The LHS gives us those values from 'b' as output where condition inside braces holds TRUE. These values are then assigned a new value 15.

#Some more examples on extracting values from 'b' based on certain specified conditions.
b[2, ]
b[, 2]
b[2:3, 2]
b

b1 <- cbind(b, c(7, 8, 9))  #The 'cbind' function adds a vector as a new column to matrix 'b'.
b1
b2 <- rbind(b, c(2, 7))  #The 'rbind' function adds a vector as a new row to matrix 'b'.
b2
b2[b2 == 1] <- 10
b2

ar1 <- array(c(1,2,3,4,5,6,7,8,9),dim=c(3,3,2))  #The input vector stream of elements fits the array dimension. Hence no repetition.
ar1
ar2 <- array(c(1,2,3,4,5,6,7,8,9,10,11),dim=c(3,3,2))  #The input stream of elements exceeds the array dimension. Hence repetition occurs.
ar2
#Here we look at the 'apply' function. It takes 3 arguments; 1st being the object on which we apply the function, 2nd the criteria for function application and 3rd being the function to be applied.
result1 <- apply(ar1, 1, sum)   #Applies 'sum' function to 'ar1' array. The 2nd argument being '1' means the criteria to calculate sum is row-wise.
result1
result2 <- apply(ar1, 2, sum)   #Applies 'sum' function to 'ar1' array. The 2nd argument being '2' means the criteria to calculate sum is column-wise.
result2
result3 <- apply(ar1, 3, sum)   #Applies 'sum' function to 'ar1' array. The 2nd argument being '3' means the criteria to calculate sum is slice or dimension-wise.
result3

#A matrix can have only 1 type of values either of numeric, character, logical or complex. To have columns with different types of values we define a dataframe.
df <- data.frame(emp_id=c(1:5), emp_name=c('ajay', 'vijay', 'harry', 'raghav', 'rohit'), emp_sal=c(1200, 1400, 1500, 2000, 1700), join_date=as.Date(c('2015-06-21', '2020-06-25', '2018-06-02', '2011-09-29', '2017-12-30')), stringsAsFactors = FALSE)
df
str(df)
dim(df)
nrow(df)
ncol(df)

#Extract rows and columns from the dataframe by index.
df1 <- df[2:4, 4]
df1
df2 <- df[c(1, 5), c(1, 4)]
df2

#Add a new vector as a column to an existing dataframe.
df$emp_dept <- c("IT", "HR", "Marketing", "Operations", "Finance")
df

#Create a new dataframe.
df_new <- data.frame(emp_id = c(6:8), emp_name = c("emma", "toni", "nico"), emp_sal = c(1000,1100,1250), join_date = as.Date(c('2014-02-27', '2015-07-29', '2019-10-20')), emp_dept=c("HR", "IT", "IT"), stringsAsFactors = FALSE)
df_new
df_new1 <- data.frame(city = c("Agra", "Lucknow", "Varanasi", "Delhi", "Pune"), state=c("UP", "UP", "UP", "Delhi", "Maharashtra"), stringsAsFactors = FALSE)
df_new1

#Bind 2 dataframes.
df_f <- rbind(df, df_new)
df_f
df_f1 <- cbind(df, df_new1)
df_f1

#Extract values from a dataframe by specifying criteria inside square brackets.
df_f1[df_f1$state == "UP", ]  #All rows where 'state' has value 'UP' and all columns.
df_f[df_f$emp_sal > 1500, ]  #All rows where 'emp_sal' is more than 1500 and all columns.
df_f[df_f$emp_dept %in% c("IT", "HR"), ]  #All rows where 'emp_dept' has value 'IT' or 'HR' and all columns.
df_f1[c('emp_name', 'emp_sal')]  #Extract only specified columns. Note how we haven't specified '$' sign and also didn't specify a comma. For simply column extraction, comma isn't a requirement.
df_f1[c(1:4)] #We can also extract columns by simply providing the column indices. Again, no need for commas for only column extraction.
df_f1[-c(1,3)] #Remove columns by specifying their indices.
complete.cases(df_f1) #This function checks whether every row is complete or not(i.e. has no missing values) and returns a TRUE/FALSE value for each row.
sum(complete.cases(df_f1)) #This gives no. of complete rows in our 'df_f1' dataframe.
duplicated(df_f1) #This function checks whether each row is a duplicate or not and returns a TRUE/FALSE value for each row.
sum(duplicated(df_f1)) #This gives no. of duplicate rows in our 'df_f1' dataframe.
df_f1[complete.cases(df_f1),] #Extract only those rows which are complete.
dup <- df_f1[4,] #Extract 4th row of 'df_f1' dataframe.
df_f2 <- rbind(df_f1,dup) #Add the 'dup' row to the 'df_f1' dataframe as a duplicate.
df_f2[duplicated(df_f2),] #Extract only those rows which are duplicate.
df_f2[!duplicated(df_f2),] #Extract only those rows which are not duplicates.
unique(df_f2) #Does the same job as above code i.e. extract the rows which are not duplicates.


#Remove columns by specifying the name of columns.
drop <- c('emp_id','join_date') #We create a vector of columns to be dropped.
names(df_f1) %in% drop #The LHS gives us column names. The '%in%' checks the condition whether each column name is present in the vector on the RHS. Gives TRUE/FALSE as output.
df_f1[!(names(df_f1) %in% drop)] #By supplying a '!' we tell R to flip the TRUE values to FALSE and vice-versa.Thus now we get a TRUE on columns to be included and FALSE on columns to be dropped.
                  #OR
df_f1[c('emp_id','join_date')]<-list(NULL)
df_f1 #As seen, this method alters the dataframe. So the columns are dropped permanently. We can choose to make a copy of our dataframe before going for this method.

install.packages('dplyr')
library(dplyr)
#'filter' function is use to filter rows based on given criterias.
#Here we gave a vertical bar '|' which stands for the 'OR' condition. So we filter rows where 'emp_sal'<1500 OR 'state' has value 'Delhi'.
filter(df_f1, emp_sal < 1500 | state == "Delhi")
#Here we gave an ampersand '&' which stands for the 'AND' condition. So we filter rows where 'emp_sal'<1500 AND 'state' has value 'UP'.
filter(df_f1, emp_sal < 1500 & state == "UP")

#The 'factor' function converts a character vector to a factor. By default, it prints the levels in ascending order or alphabetical order.
food <- c('low', 'high', 'medium', 'medium', 'low', 'low', 'medium')
f1 <- factor(food)
f1
#When we want to have a specific order of levels, we specify it under the 'levels' option. As we see, low,medium,high makes more sense than an alphabetical order.
f2 <- factor(food, levels=c('low','medium','high'))
f2
nlevels(f2)
levels(f2)
#A character vector will show only its character elements if printed as O/P. However, a factor when printed shows the elements as well as the distict levels as seen above.

#A simple 'for' loop. A 'for' loop iterates till it has taken all the values in the sequence vector.
values <- c(2, 4, "Raghav", 9)
values
for(i in values){
    print(i)
}
#A nested 'for' loop.
mat <- matrix(1:24,4,6)
mat
for(i in seq(ncol(mat))){
    for(j in seq(nrow(mat))){
        print(mat[j,i])
    }
}

#A simple 'while' loop. Note that a while loop iterates till the condition is TRUE. Also, the counter is always incremented inside the loop to go to next iteration.
val<-5
while(val<8){
    cat('Value=',val,'\n')  #Type 1: This prints 'Value= val' then goes to the next line. In next iteration, prints again 'Value= val' then goes next line and so on.
    val=val+1
}

val<-5
while(val<8){
    cat('Value=',val,'\t')  #Type 2: This prints 'Value= val' then creates an indent space.In next iteration, prints again 'Value= val' then creates an indent space and so on.
    val=val+1
}

val<-5
while(val<8){
    cat('Value=',val,sep=',')  #Type 3: This prints 'Value=' then creates a separator comma and then prints 'val'.In next iteration, prints again 'Value=' then creates a comma and then prints 'val' and so on.
    val=val+1
}

#A simple 'if-elseif' condition statement.
time <- 5
if (time<=3){
    print('Great Job !')
} else if (time>3 & time<=5){
    print('Decent Effort !')
} else print('Not Good enough !')

#A simple 'repeat' loop. It keeps repeating whatever occurs in the body unless we specify to exit using a 'break' command.
counter=6
repeat{
    print(counter)
    counter=counter+1
    if (counter == 13){
        break()
    }
}

#The 'next' commands skips a specific iteration and continues to the next one.
val=seq(1,20)
for (i in val){
    if(i==15){
        next()
          }
    print(i)
}

#Creating a basic function which takes radius and height as input and calculates area of cylinder.
area_of_cylinder <- function(r,h){
    area=pi*r^2*h
    return(area)
}
area_of_cylinder(2,5)

#Use of 'rep' function.
rep(c(5,10,15),times=3)
rep(c(5,10,15),times=c(1,2,3))
rep(c(5,10,15),each=3)
rep(c(5,10,15),length.out=20)

#Use of 'any' and 'all' functions.
c(1,3,9) %in% c(1,2,3,4)
any(c(1,3,9) %in% c(1,2,3,4))
all(c(1,3,9) %in% c(1,2,3,4))

sample(seq(1,20,0.1),20,replace = TRUE) #The function 'sample' takes 1st argument as a population from which to draw sample. 2nd argument is the no. of samples to be drawn.
                                        #3rd argument is whether we want sampling with or without replacement.
sample(seq_len(30),7) #The function 'seq_len' creates a vector of values from 1 to 30. We then select a random sample of 7 from this vector.


install.packages('tidyr')
library(tidyr)
#R follows a set of conventions that makes one layout of tabular data easier to work with than others. A data will be easier to work in R if it follows following rules:
#1. Each variable in the dataset is placed in its own column.
#2. Each observation is placed in its own row.
#3. Each value is placed in its own cell.

#A dataframe is a list of vectors that R displays as a table.
#A key:value pair is a simple way to record information. A pair contains 2 parts- a key which explains what the information describes and a value that contains the actual information.
#Data values in a dataframe naturally exist as key:value pairs. The value is the value of the pair while the variable the value describes is the key.
#In a tidy data, each cell will contain a value and each column name will contain a key.

data1 <- data.frame(country=c('Russia','Russia','China','China','USA','USA'), year=c(1999,1999,2001,2001,2005,2005), key=c('cases','population','cases','population','cases','population'), value=c(745,199345,367,123918,612,176126))
data1
#The 'spread' function is used to convert an untidy pair of key:value columns into a pair of tidy key columns.
tidy_data1 <- spread(data1, key, value) #It takes 1st argument as untidy dataframe. 2nd argument as the column name having keys and 3rd as the column name having values.
tidy_data1  #As seen, it spreads the untidy key column into 2 tidy key columns.It basically adds a new column for each unique value of untidy key column.
            #The values in untidy value column then get distributed between the tidy key columns.
            #Note that inside the 'spread' function the column names were provided as it is without quotes.

ID <- 1:6
month <- month.abb[1:6] #The function 'month.abb' gives us a sequence of calendar months as output.
delhi <- sample(seq(0,47,by=0.01),3,rep=TRUE)
mumbai <-sample(seq(0,47,by=0.01),3,rep=TRUE)
chennai <-sample(seq(0,47,by=0.01),3,rep=TRUE)
bangalore <- sample(seq(0,47,by=0.01),3,rep=TRUE)
kolkata <- sample(seq(0,47,by=0.01),3,rep=TRUE)
data2 <- data.frame(month,ID,delhi,mumbai,bangalore,chennai,kolkata)
data2
#The 'gather' function does the opposite of 'spread'.
#It gathers a set of column names and places them into a single 'key' column. It also gathers the cell values of those columns and places them in to a single value column.
gather(data2, 'city', 'rainfall',3:7) #The 1st argument is the dataframe we want to gather. The 2nd argument is the name of 'key' column where we want to gather all separate columns.
                                      #The 3rd argument is the name of the 'value' column where we want to gather all cell values. The 4th argument is the range of columns which the 'gather' function collapses.

#The 'unite' function is used to combine multiple columns into a single column.
months <- c("jan","feb","jan","feb","march","march")
year <- c("2019","2019","2020","2020","2019","2020")
production <- c(36.74,41.43,6.05,30.20,42.20,45.80)
delhi_prod <- data.frame(months,year,production)
delhi_prod
united_df <- unite(delhi_prod,'interval',months:year,sep='.')
united_df  #As seen, it combines the 'months' and 'year' columns into 'interval' column. By default, it adds an underscore as a separator.We can add our own separator in 'sep' option.

#The 'separate' function does the opposite of 'unite'. It turns a single character column into multiple columns by splitting the values where it sees a separator.
sep_df <- separate(united_df,interval, c('months', 'year'))
sep_df
#In both 'separate' and 'unite' function, quotes are supplied on newly created columns while not supplied on existing columns.

#The 'melt' function is used to collect/melt multiple columns into a single column. It is very similar to 'gather' function discussed earlier.
library(reshape2)
melt1 <- melt(data2) #This is the most basic use of the 'melt' function. We didn't specify any argument apart from the dataframe 'data2'. Hence R does some stuff on its own.
melt1                #R intelligently took 'month' column as the 'id' variable(focal point) and melted rest of the columns into a single 'variable' column.
                     #The values under all those wide columns also gets melted into a single 'value' column.
melt2 <- melt(data2,variable.name='City',value.name='Values')
melt2 #Here we have supplied 2 more arguments. We renamed the 'variable' column as 'City' and 'value' column as 'Values'.
      #The 'variable' and 'value' columns were previously created on its own by R which we now have renamed by supplying the necessary arguments.
#R chose the 'month' column as the 'id' variable by default on its own. We can also specify our own 'id' variable by including an option.
melt3 <- melt(data2,id=c('ID','month'),variable.name='City',value.name='Values')
melt3 #Here we specified 2 columns as 'id' variables. Hence the function melts all columns while keeping these two as the focal point.

#The 'dcast' function is the opposite of 'melt' function. It is similar to the 'spread' function discussed earlier.
cast1 <- dcast(melt3,month+ID~City)
cast1 #The LHS of the '~' includes columns to be included as 'id' variables. The RHS has a single character column which needs to be casted into multiple columns.
cast2 <- dcast(melt3,ID+month~City)
cast2 #Here we make a slight change. We re-arrange the LHS columns. The 'id' columns now will have 'ID' as the main variable. So 'ID' gets sorted in ascending order which was 'month' in previous case.
