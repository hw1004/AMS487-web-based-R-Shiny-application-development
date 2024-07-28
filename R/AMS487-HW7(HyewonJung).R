### AMS 487 - HW7 (Hyewon Jung)
## Problem 1
file.path <- "C:/Users/USER/Desktop/혜원/SPRING 2024/AMS 487/Assignment 7 (Data)/Assignment 7 (Data)/chol.txt"
dat <- read.table(file.path, header=TRUE, sep="\t", na.strings="NA")
dat
names(dat)
sapply(dat, class)
# Calculate the mean for each numeric variable.
# ht, wt, bmi are numeric variables
mean(dat$ht, na.rm = TRUE) # 61.42849
mean(dat$wt, na.rm = TRUE) # 123.551
mean(dat$bmi, na.rm = TRUE) # 3.100473

# Calculate the mean for each category of sex in each numeric variable.
aggregate(. ~ sex, data = dat[, c('sex', 'ht', 'wt', 'bmi')], FUN = mean)

# Create a new variable, chol.dic, based on the chol variable. If chol is greater than the mean
# of chol, then chol.dic = ”High”; otherwise, chol.dic = ”Low”.
chol_mean <- mean(dat$chol, na.rm = TRUE)
dat$chol.dic <- ifelse(dat$chol > chol_mean, "High", "Low")
dat

# Calculate the standard deviation of bmi for each category of chol.dic
tapply(dat$bmi, list(dat$sex, dat$chol.dic), mean)
tapply(dat$bmi, list(dat$sex, dat$chol.dic), sd)

# Create a 2 x 2 contingency table with counts for the two categorical variables chol.dic and
# sex, and then add margins to the table with row sums and column sums.
contingency_table <- table(dat$chol.dic, dat$sex)
contingency_table
addmargins(contingency_table)

# Create a 2 x 2 contingency table with proportions for the two categorical variables chol.dic
# and sex, where the sum of each column of the table equals to 1, and then add margins to the
# table with column sums.
contingency_table_prop <- prop.table(table(dat$chol.dic, dat$sex), margin = 2)
addmargins(contingency_table_prop)

# Use the Pearson’s chi-square test to see if the two categorical variables chol.dic and sex are
# associated or not. Report the p-value, and make a conclusion based on the p-value
contingency_table <- table(dat$chol.dic, dat$sex)
pearson_chi_square <- chisq.test(contingency_table)
pearson_chi_square
pearson_chi_square$p.value
# p-value > 0.05 => accept null hypothesis
# two variables are independent and have no significant association between them

# Use the Fisher’s exact test to see if the two categorical variables chol.dic and sex are asso-
# ciated or not. Report the p-value, and make a conclusion based on the p-value
fisher_test_result <- fisher.test(contingency_table)
fisher_test_result
fisher_test_result$p.value
# p-value > 0.05 => accept null hypothesis
# two variables are independent and have no significant association between them

## Problem 2
numeric_vars <- c('ht', 'wt', 'bmi')
result_df <- data.frame(
  female.mean = numeric(length(numeric_vars)),
  male.mean = numeric(length(numeric_vars)),
  lower.bound = numeric(length(numeric_vars)),
  upper.bound = numeric(length(numeric_vars)),
  p.value = numeric(length(numeric_vars)),
  row.names = numeric_vars
)
result_df
for (var in numeric_vars){
  # t-test by sex
  t_test_result <- t.test(dat[dat$sex == "F", var], dat[dat$sex == "M", var], var.equal = FALSE)
  
  result_df[var, "female.mean"] <- mean(dat[dat$sex == "F", var])
  result_df[var, "male.mean"] <- mean(dat[dat$sex == "M", var])
  result_df[var, c("lower.bound", "upper.bound")] <- t_test_result$conf.int
  result_df[var, "p.value"] <- t_test_result$p.value
}
result_df


## Problem 3
dat$sex
t_test_function <- function(var){
  t_test_result <- t.test(dat[dat$sex == "F", var], dat[dat$sex == "M", var], var.equal = FALSE)
  
  female_mean <- mean(dat[dat$sex == "F", var])
  male_mean <- mean(dat[dat$sex == "M", var])
  ci <- t_test_result$conf.int
  p_value <- t_test_result$p.value
  
  return(c("female.mean" = female_mean,
           "male.mean" = male_mean,
           "lower.bound" = ci[1],
           "upper.bound" = ci[2],
           "p.value" = p_value))
}

result_list <- lapply(numeric_vars, t_test_function)
result_list
class(result_list)

result_df <- as.data.frame(do.call(rbind, result_list))
rownames(result_df) <- numeric_vars
result_df

## Problem 4
# Re-do problem 2 using the permutation test (not the two-sample t-test)
# female.mean, male.mean, p.value
set.seed(3)
numeric_vars
ht <- dat$ht
wt <- dat$wt
bmi <- dat$bmi
sex <- dat$sex
d = as.data.frame(cbind(ht,wt,bmi,sex))
d
ind.male = which(d$sex == 'M')
ind.male
ind.female = which(d$sex == 'F')
ind.female
d$ht = as.numeric(d$ht)
d$wt = as.numeric(d$wt)
d$bmi = as.numeric(d$bmi)
# To find the difference in same mean between males and females
T.obs.ht = mean(d$ht[ind.male]) - mean(d$ht[ind.female])
T.obs.wt = mean(d$wt[ind.male]) - mean(d$wt[ind.female])
T.obs.bmi = mean(d$bmi[ind.male]) - mean(d$bmi[ind.female])

# null values
T.null.ht = numeric()
for (i in 1:10000){
  sex.label = sample(d$sex)
  ind.male = which(sex.label == 'M')
  ind.female = which(sex.label == 'F')
  T.null.ht[i] = mean(d$ht[ind.male]) - mean(d$ht[ind.female])
}
T.null.wt = numeric()
for (i in 1:10000){
  sex.label = sample(d$sex)
  ind.male = which(sex.label == 'M')
  ind.female = which(sex.label == 'F')
  T.null.wt[i] = mean(d$wt[ind.male]) - mean(d$wt[ind.female])
}
T.null.bmi = numeric()
for (i in 1:10000){
  sex.label = sample(d$sex)
  ind.male = which(sex.label == 'M')
  ind.female = which(sex.label == 'F')
  T.null.bmi[i] = mean(d$bmi[ind.male]) - mean(d$bmi[ind.female])
}
hist(T.null.ht, xlab = "Mean difference", ylab = "Frequency", main = "Histogram of permuted Mean differences", col = rgb(1,0,0,0.5))
abline(v=T.obs.ht, col='red')
p.val.ht = (sum(abs(T.null.ht) > abs(T.obs.ht)) + 1)/10001
p.val.ht
hist(T.null.wt, xlab = "Mean difference", ylab = "Frequency", main = "Histogram of permuted Mean differences", col = rgb(1,0,0,0.5))
abline(v=T.obs.wt, col='red')
p.val.wt = (sum(abs(T.null.wt) > abs(T.obs.wt)) + 1)/10001
p.val.wt
hist(T.null.bmi, xlab = "Mean difference", ylab = "Frequency", main = "Histogram of permuted Mean differences", col = rgb(1,0,0,0.5))
abline(v=T.obs.bmi, col='red')
p.val.bmi = (sum(abs(T.null.bmi) > abs(T.obs.bmi)) + 1)/10001
p.val.bmi

permutation_df <- data.frame(
  female.mean = c(mean(d$ht[ind.female]), mean(d$wt[ind.female]), mean(d$bmi[ind.female])),
  male.mean = c(mean(d$ht[ind.male]), mean(d$wt[ind.male]), mean(d$bmi[ind.male])),
  p.vale = c(p.val.ht, p.val.wt, p.val.bmi)
)
permutation_df
rownames(permutation_df) <- numeric_vars
permutation_df
