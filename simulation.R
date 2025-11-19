#' Simulating Bike Data
#' 
#' @description
#' @param1 

# parameters must be defined
set.seed(123)

simulation <- function() {
  
  #Generate a matrix to store our data results
  matrix = matrix(0, nrow = p, ncol = p)
  for (row in 1:p) {
    for (col in 1:p) {
      cov_mat[row, col] = rho^(abs(row-col))
    }
  }
  
  #Generate "happiness" variable
  #0 is unhappy (no bike), 1 is happy (there is a bike)
  happy <- sample(c(0, 1), size = n, replace = TRUE)
  
  #Generate x
  
  
}.

#Poisson process is here in simulation