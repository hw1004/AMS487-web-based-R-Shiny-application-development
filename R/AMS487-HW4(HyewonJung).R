### AMS 487 - HW4 (Hyewon Jung)
## Problem 1
## 1-1. (5 points) Simulate the data (i.e., generate random numbers) for systolic blood pressure
## (SBP) based on the table below (Hint: use the rnorm and runif functions)
A1 <- rnorm(5, mean=105, sd=25)
A2 <- runif(5, min=150, max=170)
B1 <- rnorm(5, mean=140, sd=15)
B2 <- runif(5, min=135, max=160)

## 1-2. (5 points) Based on the simulated data, test if the two groups, Group A (10 subjects) and
## Group B (10 subjects), have the same variance or not using F-test. Interpret the result.
A <- c(A1, A2)
B <- c(B1, B2)
var.test(A,B,alternative="two.sided")
### p-value = 0.01396 < 0.05 ⇒ reject the null hypothesis ⇒ variances of group A and group B are different

## 1-3. (5 points) Based on the simulated data, test if the two groups, Group A (10 subjects) and
## Group B (10 subjects), have the same mean or not using Welch’s t-test and Student’s t-test, re-
## spectively. Describe the difference between Welch’s t-test and Student’s t-test. Based on the result
## in 1-2, which test seems more reasonable?
t.test(A, B, alternative="two.sided", var.equal=FALSE)
t.test(A, B, alternative="two.sided", var.equal=TRUE)
### p-value = 0.5631 > 0.05 ⇒ accept null hypothesis ⇒ group A and group B have same mean value
### From f-test, we concluded that variances of group A and group B are different. Therefore, Welch’s t-test which is used when two groups have unequal variance is more reasonable.

## 1-4. (10 points) Based on the simulated data, calculate a 95% bootstrap confidence interval for
## the mean of Group A (10 subjects) and Group B (10 subjects), separately. Calculate the compu-
## tational time for this task.
library(boot)
library(car)
mean.function <- function(x, index){
  d <- x[index]
  return(mean(d))
}
bootA <- boot(A, statistic = mean.function, R=10000)
bootB <- boot(B, statistic = mean.function, R=10000)
quantile(bootA$t, probs=c(.025, .975))
confint(bootA, level=0.95, type='perc')
confint(bootB, level=0.95, type='perc')

## 1-5. (5 points) Based on the simulated data, calculate a 95% parametric confidence interval of
## the mean based on the t-distribution for the mean of Group A (10 subjects) and Group B (10
t.test(bootA$t, conf.level=0.95)
t.test(bootB$t, conf.level=0.95)

## 1-6. (10 points) Based on the simulated data, calculate a 95% bootstrap confidence interval of
## the mean for the mean of Treatment T (10 subjects) and Treatment P (10 subjects), separately.
## Calculate the computational time for this task
T <- c(A1, B1)
P <- c(A2, B2)
bootT <- boot(T, statistic = mean.function, R=10000)
bootP <- boot(P, statistic = mean.function, R=10000)
confint(bootT, level=0.95, type='perc')
confint(bootP, level=0.95, type='perc')

## 1-7. (5 points) Based on the simulated data, calculate a 95% parametric confidence interval of
## the mean based on the t-distribution for the mean of Treatment T (10 subjects) and Treatment P
## (10 subjects), separately
t.test(bootT$t, conf.level=0.95)
t.test(bootP$t, conf.level=0.95)

## Problem 2
read.files <- function(directory) {
  
  files <- list.files(directory)
  
  # Create a new directory named 'new' if it doesn't exist
  new_directory <- file.path(directory, "new")
  if (!file.exists(new_directory)) {
    dir.create(new_directory)
  }
  
  # Loop through each file
  for (file in files) {
    # Read the file
    data <- read.table(file.path(directory, file), header = TRUE, sep = "\t")
    
    # Add a new column 'fileName' with the file name
    data$fileName <- file
    
    # Write the modified dataframe to a new file in the 'new' directory
    write.table(data, file = file.path(new_directory, paste0("new_", file)), sep = "\t", row.names = FALSE)
  }
}
directory <- "C:/Users/USER/Assignment4/Data"
read.files(directory)

## Problem 3
LLN <- file.path("C:/Users/USER/Assignment4/Data", "LLN")
dir.create(LLN)
for (i in 1:100){
  script <- paste0(
    "# From the normal distribution with mean 0 and standard deviation ", i, "\n",
    "n <- seq(10, 10000, by = 10)\n",
    "sample_means <- sapply(n, function(x) mean(rnorm(x, mean = 0, sd = ", i, ")))\n",
    "plot(n, sample_means, type = 'p', main = 'Sample Means vs. Sample Sizes', xlab = 'Sample Sizes', ylab = 'Sample Means')"
  )
  
  # Construct the file path using file.path()
  file_path <- file.path(LLN, paste0("LLN-SD-(", i, ").R"))
  
  # Write the script to the file
  writeLines(script, file_path)
}
