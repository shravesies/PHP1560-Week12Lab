#' Unhappy Customers
#' 
#' @description This function will find the number of customers that did not have a bike at their station
#' @param1 demand_sim a data frame that has the start and end stations and times for each bike trip
#' @param2 num_bikes a data frame that shows the number of bikes each station has
#' @return This function returns a data frame with station, number of bikes, and number of unhappy customers

source("~/GitHub/PHP1560-Week12Lab/simulations/demand_simulation.R")

# save a data frame with number of bikes to keep track of optimized
# placements
num_bikes <- data.frame(
  station = unique(c(demand_sim$origin, demand_sim$destination)),
  bikes = 0)

unhappy <- function(demand_sim, num_bikes) {
  demand_sim <- demand_sim[order(demand_sim$time), ]
  
  num_bikes$unhappy <- 0

  for (i in 1:nrow(demand_sim)) {
    start <- demand_sim$origin[i]
    end   <- demand_sim$destination[i]
    
    s <- num_bikes$station == start
    e <- num_bikes$station == end
    
    if (num_bikes$bikes[s] > 0) {
      num_bikes$bikes[s] <- num_bikes$bikes[s] - 1
      num_bikes$bikes[e] <- num_bikes$bikes[e] + 1
    } else {
      num_bikes$unhappy[s] <- num_bikes$unhappy[s] + 1
    }
  }
  
  return(num_bikes)
}