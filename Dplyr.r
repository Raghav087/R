library(dplyr)
library(hflights)

#Transform an existing dataframe into a tibble.
#Tibbles are a type of dataframe which are easier to use and understand.
#If we have a large data frame, we need to use 'head/tail' function to view its structure otherwise it will print the whole dataframe in console. Very unnecessary.
#Tibble on the other hand automatically prints the first 10 rows of a dataframe along with information on the type of the columns for eg. if they are integer, double, character etc.
#It also tells us how many rows and columns the dataframe has. So a lot of good things and info on top of that !
d1 <- as_tibble(mtcars)
d1
d2 <- as_tibble(hflights)
d2

d1$cyl #Gives a vector O/P having values from the 'cyl' column of 'd1'.
d1['cyl'] #Gives a tibble/dataframe having a single 'cyl' column.
d1[['cyl']] #Does the same job as 'd1$cyl'.

#Using the 'filter' function.
filter(hflights,DepDelay>60,Month %in% c(4,5,6)) #The 1st argument is the dataframe. The 2nd and 3rd arguments separated by a ','(comma) are the filter conditions.
#The comma means an AND condition. We can specify more conditions separated by commas.

filter(hflights, DepDelay >100 | Month %in% c(2,3)) #This is an OR condition i.e. 'DepDelay>100' or 'Month=2/3' or both.

#Using the pipe (%>%) operator.
d1 %>% select(mpg,disp,wt,am) %>% filter(wt>3,am==0) #Select the 4 columns and then filter the rows as per the criteria specified.
d2 %>% select(UniqueCarrier,DepDelay) %>% filter(DepDelay>60)
d2 %>% select(contains(c('Month','Time'))) #If there are multiple columns having a prefix/suffix, we can use 'contains' function instead of typing all column names.

#Select the columns, then filter the rows and then arrange/sort the data in descending order of 'DepDelay' column.
d2 %>% select(UniqueCarrier,DepDelay) %>% filter(DepDelay>60) %>% arrange(-DepDelay) %>% print(n=20) #The 'print' function helps to print more rows in terminal than the default 10 for a tibble.

#Create new variables with 'mutate' function.
d2_new <- d2 %>% mutate(Speed=Distance/AirTime)
d2_new

#Count the no. of flights getting delayed by >30 minutes each month.
d2 %>% group_by(Month) %>% summarise(count_delayed = sum(DepDelay>30,na.rm=TRUE))

#Count the proportion of flights getting delayed by >30 minutes each month.
d2 %>% group_by(Month) %>% summarise(prop_delayed = mean(DepDelay>30,na.rm=TRUE))

#Getting a statistic based on groups.
aggregate(TailNum~Dest, d2, length) #Gives the number of flights landing at each destination.
d2 %>% group_by(Dest) %>% summarise(Count=length(TailNum)) #The 'dplyr' approach for the same. For grouped statistics we will always use 'group_by' together with 'summarise' function.

#For specifically getting count statistic based on groups, we can choose any of the below methods.
d2 %>% group_by(Month,DayofMonth) %>% summarise(flight_count=n()) #Gives the no. of rows for each 'by' group i.e. no. of flights each day.
d2 %>% count(Month,DayofMonth) #Does the same job as above. Much shorter. Hence when we need only grouped counts, we can use 'count' function.
d2 %>% count(TailNum,wt=Distance) #Gorups the data on 'Tailnum' column and calculates the sum of values of 'Distance' column for each group levels.
d2 %>% group_by(Month,DayofMonth) %>% tally(sort=TRUE) #Does the same job as 'n()' in above example. Giving the 'sort=TRUE' option sorts the data in descending order.

#Getting count of distinct rows for each group.
d2 %>% group_by(Dest) %>% summarise(flight_count=n(),plane_count=n_distinct(TailNum)) #Gives the total no. of flights and the unique no. of flights for each 'Dest' level.

#Getting count of rows for each level of a categorical variable.
d2 %>% group_by(Dest) %>% select('Cancelled') %>% table() #Groups the data by 'Dest' column and then gives the tabular count of rows for each level of 'Cancelled' column.

#Getting top/bottom n rows for each level of a group variable.
slice_max(x,n) #Here x is a vector or a column of a dataframe/tibble over which we find the top n values.
slice_min(x,n) #Here x is a vector or a column of a dataframe/tibble over which we find the bottom n values.
d2 %>% select(Dest,ArrDelay,UniqueCarrier) %>% group_by(Dest) %>% slice_max(ArrDelay,n=2) #Gives top 2 rows for each level of 'Dest' column based on values of 'ArrDelay' column.
d2 %>% group_by(Dest) %>% slice_max(ArrDelay,prop=0.02) #Gives top 2% rows based on values of 'ArrDelay' column for each level of 'Dest' column.

#Creating quantile groups(eg. decile, quartile, quintile etc.)
d3 <- d2 %>% mutate(Group=ntile(ArrDelay,10)) #The 'ntile' function creates n equal groups in the range of values of 'ArrDelay' column. Here n=10. So it creates deciles.
d3 %>% group_by(Group) %>% summarise(Max=max(ArrDelay),count=n())

#View the data horizontally with columns in rows. This enables us to view all columns and its type without worrying about the no. of columns, if large.
glimpse(d2)

iris <- as_tibble(iris)
#Randomly take a sample of rows based on number or fraction.
i1 <- iris %>% sample_n(6)
i2 <- iris %>% sample_frac(0.6)

iris %>% filter(grepl('vi',Species)) #filter rows having 'vi' string under 'Species' column
iris %>% summarise(Mean= mean(Sepal.Length),Median=median(Sepal.Length))

iris %>% summarise_at(vars(Sepal.Length,Petal.Width),list(~n(),~mean(.),~median(.)))
iris %>% summarise_at(vars(Sepal.Length,Petal.Length),list(~n(),~mean(.,na.rm=TRUE),missing= ~sum(is.na(.))))

#To perform a bunch of operations on all columns of the dataframe, we use 'summarise_all' function.
mtcars %>% summarise_all(list(~n(),~mean(.,na.rm=TRUE),~median(.,na.rm=TRUE)))
mtcars %>% summarise_all(list(missing=~sum(is.na(.)))) #find missing values across each column of dataset.
mtcars['cyl'] %>% summarise_all(list(~n(),~mean(.,na.rm=TRUE),~median(.,na.rm=TRUE)))

mtcars %>% arrange(desc(disp))
mtcars %>% arrange(cyl,desc(disp))

mtcars %>% group_by(cyl) %>% arrange(drat) %>% do(tail(.,1))  #gives top 1 row from each group based on value for 'drat' column
mtcars %>% group_by(cyl) %>% arrange(desc(drat)) %>% do(head(.,2)) #gives top 2 rows from each group based on value for 'drat' column
mtcars %>% group_by(cyl) %>% arrange(desc(drat)) %>% slice(2) #gives 2nd highest row from each group based on value for 'drat' column
