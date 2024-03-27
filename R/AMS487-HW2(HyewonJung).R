### AMS 487 - HW2 (Hyewon Jung)
## Problem 1
name <- c("Alfred", "Barbara", "John", "Kerry")
sex <- c("M", "F", "M", "F")
age <- c(23, 35, 25, 19)
height <- c(72, 61, NA, 66)
weight <- c(160.3, 125.4, 175.0, 130.2)
smoke <- c(TRUE, NA, FALSE, FALSE)
# mode of sex, age, smoke
mode(sex) # character
mode(age) # numeric
mode(smoke) # logical
# length of the name vector
length(name)
# add the names attribute for the age vector by using the name vector
names(age) = name
attributes(age)
age
# whose weight is over 150 pounds? To answer this question, you need to create a vector
# that only contains names that corresponds with weight > 150.
names(weight) = name
weight
weight_150 <- names(weight[(weight > 150) == TRUE])
weight_150

## Problem 2
v1 <- c(2, 3, 4, 5, 6, 7, 8, 9, 10)
v2 <- c(15, 12, 9, 6, 3)
v3 <- rep(v1, 2)
v4 <- rep(v2, c(5,4,3,2,1))
# how many elements of v3 are equal to 5?
length(v3[v3 == 5])
# Are any elements of V4 ¡ 1?
any(v4 == 1) # no
# How many elements are greater than 9 in both V1 and V2 combined?
comb12 <- c(v1,v2)
length(comb12[comb12 > 9])
# Consider the vector, f = c(1, 4, 5, 9, -1, NA, 2, NA, 3, NA, 9, 3)
# How many missing values are in the vector f?
f <-c(1, 4, 5, 9, -1, NA, 2, NA, 3, NA, 9, 3)
length(f[f=="NA"])

## Problem 3
# To generate random numbers from the standard normal distribution, we can use the rnorm function. For example, to generate 5 random numbers, you can type rnorm(5).
# Create a 4 by 5 matrix containing 20 random numbers generated from the standard normal
# distribution. Use two different ways to create this matrix. One matrix will be named X1,
# the other one will be named X2.
X1 <- matrix(rnorm(20), 4, 5)
X1
X2 <- array(rnorm(20), c(4,5))
X2
# What is the length and mode of X1?
length(X1)
mode(X1)
# Create a matrix, smallx, by taking the last three rows and first and last columns of X1.
smallx <- X1[c(2,3,4),c(1,5)]
smallx
# What is the dimension of smallx?
dim(smallx)
# How would one change smallx to a one-dimensional array (a vector)?
array(smallx)

## Problem 4
name <- c("Alfred", "Barbara", "John", "Kerry")
sex <- c("M", "F", "M", "F")
age <- c(23, 35, 25, 19)
height <- c(72, 61, NA, 66)
weight <- c(160.3, 125.4, 175.0, 130.2)
smoke <- c(TRUE, NA, FALSE, FALSE)
# Create a list, example.list, using the 6 vectors (from Problem 1) that you created, name, sex,
# age, height, weight, and smoke.
example.list <- list(name, sex, age, height, weight, smoke)
# Create a vectoe, bmi, using the vectors, weight and height, according to the following
# formula: bmi=100*weight/heightˆ2. Then, concatenate bmi to example.list. Make sure
# bmi to be a list before you concatenate it.


bmi <- 100*weight/height^2
bmi <- list(bmi)
bmi
example.list <- c(example.list, bmi)
example.list
# Use the names function to confirm that the names of example.list has names.
names(example.list) <- c("name", "sex", "age", "height", "weight", "smoke")
names(example.list)
# Create a list based on example.list that only contains the name and sex components.
list(example.list$name, example.list$sex)

## Problem 5
# Create a data frame, example, based on the vectors that you created, name, sex, age,
# height, weight, and smoke
example <- data.frame(name, sex, age, height, weight, smoke)
example
# Create a data frame, example.sub, based on example, not the 6 vectors that you created.
# When you create this data frame, keep only name, sex, and age variables
example.sub <- data.frame(example$name, example$sex, example$age)
example.sub
# Change the variable names of example.sub to s.name, s.sex, and s.age.
example.sub <- data.frame(s.name = example$name, s.sex = example$sex, s.age = example$age)
example.sub
# Change the default row names of example.sub to A01, A02, A03, and A04.
rownames(example.sub) <- c("A01", "A02", "A03", "A04")
example.sub
