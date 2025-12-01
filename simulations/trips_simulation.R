#' Simulate Bike Trips
#' 
#' @description Simulates bike trips over a day
#' @param1 demand_sim a data frame input that holds our simulation for bike 
#' demand for the day
#' @param2 placement input that tracks placement of bikes to optimize on

source("~/GitHub/PHP1560-Week12Lab/simulations/demand_simulation.R")

# Give every station some arbitrary number of bikes to run the trip simulation
# With so we can then optimize on happiness with demand.
unique(arrival_rates$start_station)
unique(arrival_rates$end_station)

placement <- c("R" = 10, "5" = 10, "18" = 10, "21" = 10, "11" = 10,
               "12" = 10, "16" = 10, "17" = 10, "13" = 10, "22" = 10,
               "6" = 10, "7" = 10, "8" = 10, "9" = 10, "4" = 10, "23" = 10,
               "10" = 10, "19" = 10, "14" = 10, "15" = 10, "2" = 10, "24" = 10)

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
      bikes[end] <- bikes[end] + 1
      completed <- completed + 1
    }
  }
  
  as.data.frame(list(
    completed_trips = completed,
    end_bikes = bikes)
  )
}

sim_trips <- simulate_trips(demand_sim, placement)