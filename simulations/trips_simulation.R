#' Simulate Bike Trips
#' 
#' @description Simulates bike trips over a day
#' @param1 demand_sim a data frame input that holds our simulation for bike 
#' demand for the day
#' @param2 placement input that tracks placement of bikes to optimize on

# Give every station some arbitrary number of bikes to run the trip simulation
# With so we can then optimize on happiness with demand.
unique(arrival_rates$start_station)
unique(arrival_rates$end_station)

placement <- c("R" = 20, "5" = 10, "18" = 20, "21" = 10, "11" = 20,
               "12" = 10, "16" = 20, "17" = 10, "13" = 20, "22" = 10,
               "6" = 20, "7" = 10, "8" = 20, "9" = 10, "4" = 20, "23" = 10,
               "10" = 20, "19" = 10, "14" = 20, "15" = 10, "2" = 20, "24" = 10)

source("~/GitHub/PHP1560-Week12Lab/simulations/demand_simulation.R")

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