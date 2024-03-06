# Use R as a calculator
3*2+4
4^2+1
log(2)+exp(5)

# Expressions and Assignment
5+2
1+exp(2)
5+2; 1+exp(2) # also separated by a semi-colon

a = 15
a
print(a)

# Vectorized Arithmetic
# Could be constructed by using c(...)
weight = c(60, 72, 57, 90, 95, 72)
weight
height = c(1.75, 1.8, 1.65, 1.9, 1.74, 1.91)
# Calculations with vectors of the same length are possible
bmi = weight/height^2
bmi
# mean
sum(height)/length(height)
mean(height)

# Standard Procedures
# one-sample t-test => if the mean of the BMI = 22.5
t.test(bmi, mu=22.5)
# result
# hypothesis: mean of the bmi is assumed as 22.5
# since p-value 0.7442 > 0,05 => mean is close to 22.5

# Graphs
# suppose that we would like to investigate the relationship between weight and height using a scatter plot
plot(height, weight)

# Mode and class (two most important attributes)
# mode: describes the data type or storage mode of an object
n1 = c(1, 4, pi, 10)
mode(n1); class(n1)  # numeric, character, logical
# class: describes the data structure of an object
n2 = matrix(n1, nrow=2)  # matrix with 2 rows => fit n1 data into the matrix
n2
mode(n2); class(n2)
# n1 is a vector(one-dimensional array - numeric)
# n2 is a matrix(two-dimensional array - array)

# attributes function
attributes(n1)  # no other attributes than the ones from the mode and class functions => NULL
attributes(n2)  # dim attribute : dimension of n2
dim(n1) # NULL
dim(n2) # 2 2
n3 = n2
attributes(n3) = NULL
dim(n3)
n3  # [1]  1.000000  4.000000  3.141593 10.000000

# The 'is.XXX' Function
is.numeric(n2) # TRUE
is.character(n2) # FALSE
is.vector(n2); is.matrix(n2)

# The 'as.XXX' Function
# convert an object to another one
# with a different mode or data structure
as.character(n1)
as.vector(n2)

# Missing Values
# NA is not a value but a marker for a missing value
c1 = c("A", "B", "C")
as.numeric(c1)
# is.na
n4 = c(1, NA, 3)
is.na(n4)
# sum elements of n4 excluding NA
sum(n4, na.rm=T)

# Working directory and workspace
dir()
# setwd() => change the directory
objects()
ls()
# remove some of the objects from the workspace
rm(height, weight)
ls()
# remove everything
rm(list = ls())
ls()
# workspaces currently making up the search
search()
library(MASS)
search()

# details of the search path
searchpaths()

# objects stored in the library at position 2
objects(2)

# find the location of an object
find('iris3')
find('quine')

# Mass package has object name Traffic.
# If we define Traffic as a below vector, we get 2 places on the search path
Traffic = c(1, 2, 3)
find('Traffic') # ".GlobalEnv"   "package:MASS"
