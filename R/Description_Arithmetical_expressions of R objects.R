# VECTORS
# 1. create vector
mydata = c(2.9, 3.5, 4.5, NA, 3, 2.4)
mydata
colors = c("red", "green", "blue", "yellow", NA,
           "purple")
colors
newLogic = c(TRUE, NA, T, F)
newLogic[3]
newLogic[0:2]
newLogic[c(2,4)] # [1]    NA FALSE

# names attributes of the vector
names(mydata) = c("a", "b", "c", "d", "e", "f")
attributes(mydata)
names(mydata)
mydata

# concatenating a vector
# concatenate function c
newdata = 3.6
newdata
newdata2 = c(mydata,newdata)
newdata2

a = c(1,4)
b = c(2,3)
a+b  # [1] 3 7

#The recycling Rule
# When two vectors of different lengths are used for calculations..
# the shorter one is recycled to match with the longer one
a = c(1,4)
a+5

# If the longer vector is not a multiple of the shorter one, it gives a warning message
cc = c(1,4,2,3) 
a+cc # [1] 2 8 3 7

d = c(5,4,9,1,12)
a+d 
# 경고메시지(들): 
# a + d에서: 두 객체의 길이가 서로 배수관계에 있지 않습니다

# Regular sequences
# 1. seq
seq(2,10)
2:10
seq(2,20, by=3) # [1]  2  5  8 11 14 17 20
seq(2,20, length=7) # [1]  2  5  8 11 14 17 20

x = c(3,5,8,10,0.3,4,5)
seq(2,along=x) # the length of x specified in the along argument determines the length of the result
# so x is a vector of length 7, which means seq(2,along=x) returns result of length 7

seq(x)

# 2. rep
# repeat an object in different ways
rep(2,4) # repeat 2 4 times
rep(1:4,2)


# Random number generator functions
# 1) 100 random numbers / normal distribution / mean 2 / std 3
normData = rnorm(100, 2, 3)
normData
mean(normData)
sd(normData)

# Logical vecotrs (relational operators)
a = c(seq(2,4), NA)
b1 = a > 2 # if elements of a is greater than 2 or not
b2 = a < 2
b1 # [1] FALSE  TRUE  TRUE    NA
b2 # [1] FALSE FALSE FALSE    NA
b1 | b2 # union
!b1 # [1]  TRUE FALSE FALSE    NA

is.na(a) # determine if the element is na or not
a == NA # change all elements to NA

g = c(seq(1,6,by=0.5), 10)
g
sum(g > mean(g))

# all and any
f <- c(3.01, 3.001, 3.0001, 3.00001)
any(f==3.001)
any(f>3.1)
all(f>3)
all(f>3.001)

# Creating a Factor
# used to store categorical data
countyVector = c("la","sb","la","oc","oc","sb")
county = factor(countyVector)
county # eliminate duplicates
attributes(county)
nlevels(county) # number of levels of a factor
as.character(county) # factor => character
# [1] "la" "sb" "la" "oc" "oc" "sb"

# Subsetting a factor
county1 = county[1:3]
county1
nlevels(county1)

# Order of the factor
print.default(county)
mode(county)

bmi = factor(c("Underweight", "Normal", "Overweight", "Obese"), order=TRUE)
bmi

# Numeric Factors
numFactor = factor(seq(1,10, by=2))
numFactor
as.numeric(numFactor)
as.numeric(as.character(numFactor))

# Matrix (dim)
mydata
#  a   b   c   d   e   f 
# 2.9 3.5 4.5  NA 3.0 2.4
dim(mydata) = c(2,3)
mydata
#      [,1] [,2] [,3]
# [1,]  2.9  4.5  3.0
# [2,]  3.5   NA  2.4
dim(mydata) = NULL
mydata # [1] 2.9 3.5 4.5  NA 3.0 2.4

# Matrix (matrix)
matrix(mydata,2,3)
mydata2 = matrix(mydata,2,3,byrow=TRUE)
mydata2
nrow(mydata2)
ncol(mydata2)

# array
x = array(1:12, c(2,2,3))
x

# Lists
student = list(name="John", year = 2, classTaken = c("AMS 394", "AMS 572"), GPA=3.85)
student
# $name
# [1] "John"

# $year
# [1] 2

# $classTaken
# [1] "AMS 394" "AMS 572"

# $GPA
# [1] 3.85

str(student)

# List of 4
# $ name      : chr "John"
# $ year      : num 2
# $ classTaken: chr [1:2] "AMS 394" "AMS 572"
# $ GPA       : num 3.85

student$GPA # access the component

student[3:4]
student[[3]]

# unlist function
unlist(student, use.names = F)
unlist(student, use.names = T)

# Data Frames
gender = c("M", "F", "F", "M", "M")
height = c(65, 63, 60, 62, 57)
d = data.frame(gender, height)
d
# gender height
# 1      M     65
# 2      F     63
# 3      F     60
# 4      M     62
# 5      M     57

colnames(d) # [1] "gender" "height"
rownames(d) # [1] "1" "2" "3" "4" "5"

d[2,3] # NULL
d[1,] # first row
d[,2] # second column
d[1:3, c(1,2)]
d$height[1:3] # access to a variable

# attach and detach functions
d2 = data.frame(name = c("john", "helen"), age = c(20,25))
attach(d2)
d2
search()
detach(d2)
search()

# R Built in functions
# plot
height = c(160, 170, 180, 165, 200)
weight = c(50, 60, 70, 60, 80)
plot(x=height, y=weight)


