### AMS 487 - HW8 (Hyewon Jung)
## Problem 1
### one sample t-test or one sample bootstrap test
one.sam.t.b <- function(x,mu0 = 0,method = c("t-test", "bootstrap"), n.sim = 5000){
  method <- match.arg(method)
  
  if (method == "t-test"){
    # one-sample t-test
    t_test_result <- t.test(x, mu = mu0)
    
    result <- list(method = "t-test", p.value = t_test_result$p.value, conf.int = t_test_result$conf.int)
    return(result)
  }
  
  else if (method == "bootstrap"){
    # one-sample bootstrap test
    # generates bootstrap samples and calculates the 95% confidence interval using 'quantile'
    bootstrap_means <- replicate(n.sim, mean(sample(x, replace=TRUE)))
    conf_int <- quantile(bootstrap_means, c(0.025, 0.975)) # 95% confidence interval
    
    result <- list(method = "bootstrap", conf.int = conf_int)
    return(result)
    
  }
  else{
    stop("Invalid method")
  }
}
## Problem 2
two.sam.t.p <- function(x,y,method=c("t-test", "permutation"), n.perm = 5000, ...){
  method <- match.arg(method)
  
  if (method == "t-test"){
    # Welch's(Var = false) and Student(var = true) t-test
    welch_t_test_result <- t.test(x,y, var.equal = FALSE,...)
    
    welch_result <- list(method = welch_t_test_result$method, p.value = welch_t_test_result$p.value)
    invisible(welch_result)
    
    student_t_test_result <- t.test(x,y,var.equal = TRUE,...)
    
    student_result <- list(method = student_t_test_result$method, p.value = student_t_test_result$p.value)
    invisible(student_result)
    
  }

  else if (method == "permutation"){
    observed_diff <- mean(x) - mean(y)
    combined <- c(x, y)
    perm_diffs <- numeric(n.perm)
    for (i in 1:perm_diffs){
      perm_indices <- sample(length(combined))
      perm_x <- combined[perm_indices[1:length(x)]]
      perm_y <- combined[perm_indices[(length(X)+1):(length(x)+length(y))]]
      perm_diffs[i] <- mean(perm_x) - mean(perm_y)
    }
    
    p_value <- mean(abs(perm_diffs) >= abs(observed_diff))
    
    permutation_result <- list(method = "permutation", p.value = p_value)
    invisible(result)
  }
  
  else{
    stop("invalid method")
  }
}
