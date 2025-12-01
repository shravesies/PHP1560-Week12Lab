#' Simulate Bike Trips
#' 
#' @description Simulates bike trips over a day
#' @param1 demand_sim a data frame input that holds our simulation for bike 
#' demand for the day
#' @param2 placement input that tracks placement of bikes to optimize on

simulate_trips <- function(demand_sim, placement) {
  # Organize in sequential order (otherwise bikes may be out of time order)
  demand_sim <- demand_sim %>% 
    arrange(time)
  
  # Code for tracking the amount of completed trips, bikes available, and
  # placement input
  bikes <- placement
  completed <- 0
  
  for (i in 1:nrow(demand_sim)) {
    start <- demand_sim$origin[i]
    end <- demand_sim$destination[i]
    
  # Code for if a bike can take a trip or not and then add it to the list
  # of completed trips
    if (bikes[start] > 0) {
      bikes[start] <- bikes[start] - 1
      bikes[end] <- bikes[endd] + 1
      completed <- completed + 1
    }
  }
  
  list(
    completed_trips = completed,
    end_bikes = bikes
  )
}