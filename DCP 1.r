a<- 5
a
abc <- 'asjbfs'
abc
num<- 5   #A value such as 5 is stored as 5.00.
class(num)
typeof(num)
class(3.3)
typeof(3.3)
zx<-TRUE
print(c(class(zx),typeof(zx)))
cat(class(zx),typeof(zx)) #The 'cat' function is an alternate to 'print'.
conv<-as.integer(zx)
conv
typeof(conv)
class(conv)
a2 <- as.character(3.3)
cat(class(a2),typeof(a2))
a3 <- as.numeric('3.3')
cat(class(a3),typeof(a3))
a3
a4<-c(9.45,3,1,2,0)
as.logical(a4)  #The 'as.logical()' function takes a numeric vector as argument and returns 'TRUE' for any value>0 and 'FALSE' for any value=0.

string<-'This is a string'
string
class(string)
typeof(string)

a1<-'215' #The object 'a1' is a string having a number.
class(a1)
int1<-as.integer(a1)  #Object 'a1' can be converted into an integer only because its inherent value is a numeric. If it was a character, it won't be converted to integer.
cat(class(int1),typeof(int1))
int<-3L  #By typing 'L' at the end of a whole number, it automatically stores its 'class' and 'typeof' as integer.
cat(class(int),typeof(int))
#Summary: Any number will have a 'class' as numeric and 'typeof' as double. Reason being all numbers, even if integers are stored as for eg. 3.00 or 4.00 in R memory.
#So even if they appear whole, in memory they are being stored with 2 decimal places. To force a number to be stored as integer, we use 'as.integer()'.

#Types of Data Structures in R: 1)Vector 2)Matrix 3)Array 4)List 5) Dataframe
cz<-c(1,4,1,7,5,9,3.41,9)  #Vector is a sequence of elements that share the same data type.
cz #'cz' object appears with 2 decimal places. The output appears wrt the values the vector contains. If even 1 value has decimal place, all values appear with decimal places even though they might be whole numbers.
class(cz)
typeof(cz)
is.vector(cz)

cx<-c(1,4,1,7,5,9,'3.41',9) #Here the vector has 1 character value. Now the 'class' and 'typeof' for object 'cx' will be character. This is called implicit coercion i.e. R implicitly  converts all elements to character.
cat(class(cx),typeof(cx))

x1<-seq(2,15,2)
x1
cat(class(x1),typeof(x1))
str(x1) #The 'str' function helps us identify the data structure of the object. So here it tells us 'x1' is a numeric vector. Other types can be character vector, logical vector.
x1[3]

a=c('Deepak'=31,'Raghav'=30.2,'Emma'=21)  #This is a vector in form of key:value pairs.
cat(class(a),typeof(a))
str(a)
a['Deepak']
a[2]
a11=c(Deepak=31,Raghav=30.2,Emma=21)  #This is still the same vector with key:value pairs. Even after removing quotes.
a11

b=c(2,1,6,7)
x=c(a,b)  #We use 'c' to combine 2 or more vectors.
x
typeof(x)
c=c(2,1,9,7.4)
b+c  #Vector addition. Each element from both vectors at same position get added to result in a new vector of same length.
d=c(2,9)
e=c+d  #Here we are adding 2 vectors of different lengths. Vector 'd' is shorter than 'c', still we get the sum vector 'e' of length 4. This is because shorter vector 'd' will replicate itself to become same length
#as longer vector 'c' i.e. it becomes (2,9,2,9). When we add this vector to 'c', we get the resultant vector 'e'.
e

3/5
3%%5
name=c('Emma','Peter','Jai')
age=c(31,42,25)
permanent=c(TRUE,FALSE,TRUE)
out_list<-list(name,age,permanent)  #Create a list from 3 different types of vectors.
out_list
out_list[[1]][3]    #The '1' inside 2 braces means we first move to the 1st object of the list. The '3' inside single brace means we output the 3rd element of this object.
location<-c('Lko','Kanpur','Noida','Agra')
out_list[[4]]<-location   #Add a new vector as 4th object to the list. Notice that this vector has a different length from the ones already there, but still a list has no issues accomodating it.
out_list
out_list[[4]][5]<-'Varanasi'  #Add a new element at 5th position for the 4th object of the list.
out_list

#Create bins/groups on a numeric column.
bins <- c(1,2.5,4,5.5,7)
Petal_length_bins <- cut(iris$Petal.Length,breaks=bins)
table(Petal_length_bins)
