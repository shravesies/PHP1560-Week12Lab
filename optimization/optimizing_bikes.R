#' Optimizing Bikes
#' 
#' @description This function will find the number of bikes that each station should start with
#' @param1 demand_sim a data frame that has the start and end stations and times for each bike trip
#' @param2 num_bikes a data frame that shows the number of bikes each station has
#' @return This function returns a data frame with station, number of bikes

source("~/GitHub/PHP1560-Week12Lab/optimization/unhappy_customers.R")

optimization <- function(demand_sim, num_bikes, fleet_size, seed) {
  
  seed <- set.seed()
  
  customer_data <- unhappy(demand_sim, num_bikes)
  total_unhappy <- sum(customer_data$unhappy)
  
  while (sum(num_bikes$bikes) < fleet_size) {
    
    saddest_station <- customer_data$station[which.max(customer_data$unhappy)]
    
    num_bikes$bikes[num_bikes$station == saddest_station] <-
      num_bikes$bikes[num_bikes$station == saddest_station] + 1
    
    customer_data <- unhappy(demand_sim, num_bikes)
  }
  
  return(num_bikes)
}

