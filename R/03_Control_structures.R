# 1. Single statements and blocks
# blocks
{
  x = 0
  x+5
}

# 2. conditional execution of statements
# if statement
x = rnorm(10)
{
  if (mean(x) > median(x)) print("Mean > Median")
  else print("Mean < Median")
}

# calculate the central tendency
central = function(y, measure) {
  if (measure == "mean") return(mean(y))
  else if(measure == "median") return(median(y))
  else stop("Your measure is not supported")
}
z = rnorm(10, 2, 3)
central(z, "mean")

# 3. ifelse and switch functions
# ifelse
treatment = c(rep("case",3), rep("control",2))
treat.ind = ifelse(treatment == "case", 1, 0)
treat.ind

# switch
x = 3
switch(x, 2+2, mean(1:10), rnorm(5))
switch(2, 2+2, mean(1:10), rnorm(5))
foo = switch(6, 2+2, mean(1:10), rnorm(5))
foo

# 4. Looping
# Explicit looping (for, while, repeat)
ss = 0
total = 0
for (i in c(20, 30, 25, 40)){
  total = total + i
  ss = ss + i^2
}
ss
total

x = 0
test = 1
while (test > 0){
  x = x+1
  print(x^2)
  test=(x<6)
}

x = 0
repeat{
  x = x+1
  print(x^2)
  if(x==6)break
}

# Law of Large numbers
# if a fair coin is tossed many times and the proportion
# of heads is caculated, that proportion will be close to 1/2
p <- 0.5
sam.sizes <- seq(10, 1000, 10)
sam.means <- numeric()
sam.means
for (n in sam.sizes){
  ran.sam <- rbinom(n,1,p)  # binomial distribution
  sam.means[n/10] <- mean(ran.sam)
  }

plot(sam.sizes, sam.means, xlab="n", ylab="sample mean", main="Law of Large Numbers", type="l")

# Central Limit Theorem
# If X's are independent random variables from a distribution with mean and variance,
# then sample mean follows a normal distribution
n = 5
sam.means <- numeric()
for (i in 1:100000){
  ran.sam <- rpois(n,1) # poisson distribution
  sam.means[i] <- mean(ran.sam)
}

hist(sam.means, xlab = "Sample Mean", main = "Histogram of Sample Means")
mean(sam.means)
var(sam.means)

n = 10
sam.means <- numeric()
for (i in 1:100000){
  ran.sam <- rpois(n,1) # poisson distribution
  sam.means[i] <- mean(ran.sam)
}

hist(sam.means, xlab = "Sample Mean", main = "Histogram of Sample Means")
mean(sam.means)
var(sam.means)

n = 100
sam.means <- numeric()
for (i in 1:100000){
  ran.sam <- rpois(n,1) # poisson distribution
  sam.means[i] <- mean(ran.sam)
}

hist(sam.means, xlab = "Sample Mean", main = "Histogram of Sample Means")
mean(sam.means)
var(sam.means)

# if n goes to infinity, the sample follows the normal distribution

# Bootstrapping
# Bootstrapping is any test or metric that uses random sampling with replacement.
set.seed(394)
sam = rexp(100, 1) # the exponential distribution
bs.means = numeric()
for (i in 1:100000){
  bs.means[i] = mean(sample(sam, replace=TRUE))
}
mean(bs.means)
var(bs.means)
hist(bs.means, xlab="Bootstrap Mean", ylab = "Frequency", main="Histogram of Bootstrap Means")
abline(v = mean(sam), col="Red")

quantile(bs.means, c(0.025, 0.975))

# one sample t-test
# to test the null hypothesis that the population mean is equal to specified value 

t.val = qt(0.975, length(sam) - 1)  # the student t distribution
se = sd(x) / sqrt(length(sam))
ci.low = mean(sam) - t.val*se
ci.upp = mean(sam) + t.val*se
c(ci.low, ci.upp)
