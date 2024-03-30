### AMS 487 - HW3 (Hyewon Jung)
## Problem 1
# The purpose of this problem is to count the number of extreme values in a numeric vector. You can
# consider the values greater than or less than 3 times standard deviation from the mean as extreme
# values.
# Write a function, extreme, to count the number of extreme values in a numeric vector.
extreme <- function(x){
  meanval <- mean(x)
  stdval <- sd(x)
  threshold <- 3 * stdval
  extreme_values <- sum(x > meanval + threshold | x < meanval - threshold)
  
  if (extreme_values == 0) {
    print("There is no extreme value.")
  } else if (extreme_values == 1) {
    print("There is 1 extreme value.")
  } else {
    extreme_values <- as.character(extreme_values)
    print(paste("There are", extreme_values, "extreme values."))
  }
}


ran.num <- rnorm(1000)
extreme(ran.num)

## Problem 2
calCS <- function(measure, r){
  AC <- pi*(r^2)
  CC <- 2*pi*r
  VS <- (4/3) *pi*(r^3)
  AS <- 4*pi*(r^2)
  
  if (toupper(measure) == "AC")
    return(AC)
  else if (toupper(measure) == "CC")
    return(CC)
  else if (toupper(measure) == "VS")
    return(VS)
  else if (toupper(measure) == "AS")
    return(AS)
  else return("Your measure is not supported.")
}
calCS("AC", 3)

# Problem 3
calCS <- function(measure, r){
  measure <- toupper(measure)
  
  result <- switch(measure,
                   AC = pi*(r^2),
                   CC = 2*pi*r,
                   VS = (4/3)*pi*(r^3),
                   AS = 4*pi*(r^2),
                   "Your measure is not supported.")
  return(result)
}
calCS("AC", 3)

# Problem 4
a = c(2, 8, 9, -1, 20, 3, 5)
prod(a)
products = 1
for (i in a){
  products = products*i
}
print(products)

# Problem 5
# For circles with radii 5, 10, 15, 20, and 25, write a loop to calculate the area of a circle by using
# the function that you wrote. In previous functions, to calculate the area of a circle with radius 5,
# we can simply write calCS(“AC”, 5). However, when you insert the function inside the loop, you
# need to explicitly use the print function. For example, print(calCS(“AC”, 5))
for (i in c(5,10,15,20,25)){
  print(calCS("AC",i))
}

# Problem 6
# From the normal distribution with mean 1 and standard deviation 0.5, generate random samples
# with sizes n = 10, n = 20, . . . , n = 10000, respectively, and calculate their sample means. Draw
# the scatter plot for the sample sizes vs. sample means. Describe the results based on the law of
# large numbers
for (n in seq(10, 10000, 10)){
  samples = rnorm(n, 1, 0.5)
  sample_means = mean(samples)
  
  plot(n, sample_means, xlab="sample sizes", ylab="sample means", main="sample sizes vs. sample means")
}
# for n = 10000, sample means almost converges to 1.0
# which is followed by the law of large numbers

# Problem 7
# From the Poisson distribution with mean = 0.2, generate 100,000 random samples with size n =
# 20 and calculate their sample means. Draw the histogram of the sample means and calculate the
# mean and variance of the sample means. * Repeat it for the sample sizes n = 40, n = 60, n = 80,
# and n = 100, respectively. Describe the results based on the central limit theorem
sam.means <- numeric()
sample_sizes = c(20, 40, 60, 80, 100)
poiss_mean = 0.2
for (n in sample_sizes){
  for (i in 1:100000){
    sam.means[i] <- mean(rpois(n, 0.2))
    print(sam.means[i])
  }
}
sam.means
hist(sam.means, xlab = 'sample means', main='Histogram of the sample means')
mean(sam.means)
sd(sam.means)
# According to the central limit theorem, the sample distribution follows the normal distribution
