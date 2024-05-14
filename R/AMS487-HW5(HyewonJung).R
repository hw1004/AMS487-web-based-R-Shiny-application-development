### AMS 487 - HW3 (Hyewon Jung)
## Problem 1
p1 <- c(2, 2.5, -99, 5, -999, 10, 1, 2, 11, -9)
names(p1) = letters[1:10]
p1

names(p1) <- letters[1:10]
p1
x <- p1[c(TRUE, FALSE)] 
# TRUE makes first element to be chosen 
# next FALSE 
x

y <- p1[c('a', 'c')]
y

z <- p1 # copy p1
z[z %in% c(-9,-99,-999)] <- NA
z

p2 <- matrix(p1, nrow = 2, byrow = TRUE)
p2

neg.mat <- matrix(p1<0, nrow=2, byrow = TRUE)
neg.mat

neg.vec <- apply(p2, 2, function(x) any(x < 0))
neg.vec

non.neg.mat <- p2[,colSum(p2<0) == 0]
non.neg.mat

## Problem 2
library(MASS)
head(painters)

### permutation test
perm_test <- function(x,y, n_perm = 1000){
  perm_diffs <- numeric(n_perm)
  for (i in 1:n_perm){
    perm_combined <- sample(c(x,y))
    permx <- perm_combined[1:length(x)]
    permy <- perm_combined[(length(x) + 1):length(c(x,y))]
    perm_diffs[i] <- mean(permx) - mean(permy)
  }
  p_value <- mean(abs(perm_diffs) >= abs(mean(x)-mean(y)))
  return(p_value)
}

### t-test
perform_t_test <- function(data, group1, group2) {
  t_test_result <- t.test(data[data$School == group1, "Composition"],
                          data[data$School == group2, "Composition"],
                          var.equal = TRUE)
  welch_t_test_result <- t.test(data[data$School == group1, "Composition"],
                                data[data$School == group2, "Composition"],
                                var.equal = FALSE)
  perm_test_result <- perm_test(data[data$School == group1, "Composition"],
                                data[data$School == group2, "Composition"])
  
  results <- data.frame(
    Test = c("Student's t-test", "Welch's t-test", "Permutation test"),
    T.obs = c(t_test_result$statistic, NA, NA),
    DF = c(t_test_result$parameter, NA, NA),
    SE = c(NA, NA, NA), # SE is not directly provided by t.test function
    Lower = c(t_test_result$conf.int[1], NA, NA),
    Upper = c(t_test_result$conf.int[2], NA, NA),
    P_value = c(t_test_result$p.value, welch_t_test_result$p.value, perm_test_result)
  )
  return(results)
}


results_com <- perform_t_test(painters, "A", "B")
results_exp <- perform_t_test(painters, "D", "G")
print(results_com)
print(results_exp)
result.com.t.test <- data.frame(results_com)
result.com.t.test
result.exp.t.test <- data.frame(results_exp)
result.exp.t.test