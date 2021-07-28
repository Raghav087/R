df_1 <- read.csv('F:/Study/IIML Sessions/R Codes/Code files & Others/Online_Retail.csv')
head(df_1)
dim(df_1)

#The dataframe basically consists of details about purchases made by customers.
length(unique(df_1$CustomerID)) #Gives the no. of unique customers who made the purchase.
sum(is.na(df_1$CustomerID)) #Gives the no. of rows where 'CustomerID' column has a missing values.

#Subset data where there is a value in column 'CustomerID'.
df_2 <- df_1[!is.na(df_1$CustomerID),]

#Calculate a frequency table based on a specific column of the dataframe.
table(df_2$Country)

#Subset the data where country is United Kingdom.
df_uk <- df_2[df_2$Country=='United Kingdom',]
dim(df_uk)
head(df_uk)

#Calculate the no. of unique transactions and unique customers.
length(unique(df_uk$InvoiceNo))
length(unique(df_uk$CustomerID))

#The 'grep' and 'grepl' functions.
x <- c('Anna','Emma','Erica','Alok','Sterling')
grep('E',x) #The 'grep' function gives a vector having index no. of the position where it finds an exact match.
grepl('E',x) #The 'grepl' function gives a logical vector of TRUE/FALSE depending whether it finds an exact match or not.

#Subset the dataframe on those rows which has a cancel invoice i.e. column 'InvoiceNo' starts with a 'C'.
uk1 <- df_uk[grep('C',df_uk$InvoiceNo),]
head(uk1)

#Create a new column which indicates whether a transaction was cancelled or not.
df_uk$Cancelled <- grepl('C',df_uk$InvoiceNo)
head(df_uk)

#Create a new column which indicates whether a purchase was made or not.
df_uk$Purchased <- ifelse(df_uk$Cancelled=='TRUE',0,1)
head(df_uk)

customer_list <- as.data.frame(unique(df_uk$CustomerID))
head(customer_list)
names(customer_list) <- 'CustomerID'
head(customer_list)

#Sample specific no. of rows randomly from the dataframe.
sample1 <- sample_n(df_uk,15) #The 'sample_n' function from 'dplyr' package is used to randomly select/sample 15 rows from the 'df_uk' dataframe.
sample2 <- df_uk[sample(seq_len(nrow(df_uk)),15),] #Sample in a more simple way of Base R. Does the same job as above line code.

#Calculate no. of days past from a base date since the customer made a purchase.
head(df_uk$InvoiceDate)
df_uk$InvoiceDate <- as.Date(df_uk$InvoiceDate)
head(df_uk)
df_uk$DaysPast <- as.Date('2012-12-31') - df_uk$InvoiceDate
head(df_uk)

#Subset the dataframe on customers who have made a purchase.
purchased <- df_uk[df_uk$Purchased==1,]
head(purchased)

#Calculate the most recent purchase done by each customer.
recent <- aggregate(DaysPast~CustomerID,purchased,min,na.rm=TRUE)
head(recent)

df_invoices <- df_uk[c('CustomerID','InvoiceNo','Purchased')]
head(df_invoices)
df_invoices <- df_invoices[!duplicated(df_invoices),]  #Remove duplicate rows from the dataframe.
df_invoices <- df_invoices[order(df_invoices$CustomerID),]
head(df_invoices)
row.names(df_invoices)<- NULL #Remove unnecessary row names from the dataframe.
head(df_invoices)

#Calculating the no. of purchases made by each Customer.
df_freq <- aggregate(Purchased~CustomerID,df_invoices,sum)
head(df_freq)
names(df_freq)[names(df_freq)=='Purchased'] <- 'Frequency' #Rename the column as 'Frequency'.
head(df_freq)

#Merge the frequency dataframe with the customer dataframe by key 'CustomerID'.
List_Customers <- merge(customer_list,df_freq,by='CustomerID',sort=TRUE,all=TRUE)
head(List_Customers)

table(List_Customers$Frequency)

#Subset those rows where customers purchased atleast 1 item.
df_customers <- List_Customers[List_Customers$Frequency>0,]

#The 'aggregate' function.
head(mtcars)
aggregate(wt~cyl,mtcars,mean) #This gives us the mean of 'wt' column for each level of 'cyl' column in 'mtcars' dataframe.
aggregate(wt~cyl+am,mtcars,mean) #This gives us the mean of 'wt' column for each combination levels of 'cyl' and 'am' columns.
aggregate(cbind(wt,mpg)~cyl+am,mtcars,mean) #This gives us the mean of 'wt' and 'mpg' columns for each combination levels of 'cyl' and 'am' columns.

#The 'sort' function is used to sort a vector.
sort(mtcars$drat)
sort(mtcars$drat,decreasing = TRUE)

#The 'order' function.
order(mtcars$drat) #It returns the index position of the lowest value in 'drat' column, followed by index of 2nd lowest value and so on till the index of the highest value in a vector.
#As seen, when used on a vector alone, doesn't give a very fruitful output. However, its major importance lies when it is used as a condition on a dataframe.
mtcars[order(mtcars$drat),] #Here the 'order' function enables us to extract rows based on the indices.
#Hence the 1st row is the one having lowest value of 'drat' column, the 2nd row is the one having the 2nd lowest value and so on.
#It therefore arranges the 'mtcars' dataframe based on increasing order of 'drat' column.
mtcars[order(mtcars$drat,decreasing = TRUE),] #By giving the 'decreasing' option as value 'TRUE' it arranges the dataframe in decreasing order of 'drat' column.
