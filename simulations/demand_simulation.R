#' Simulating Demand for Bikes
#' 
#' @description This function is meant to simulate the demand for bikes
#' for one day (24 hours) from the sample_bike data.
#' @param1 arrival_rates a data frame that estimates the arrival rates
#' from one station to another at different hours, giving us average
#' bike availability and mu_hat as well, which will act as our lambda
#' for this simulation.
#' @param2 day a set measure for how many hours there are in our simulation,
#' setting the max to 24.
#' @return This function returns a data frame with time, origin station,
#' and destination station.

#Make sure data is loaded in properly using sample_bike data
arrival_rates <- estimate_arrival_rates(sample_bike)

#Set demand_simulation as a function given the parameters, setting seed 
#to randomize and to create a new vector that will intake all bike demand
demand_simulation <- function(arrival_rates, day = 24) {
  set.seed(123)
  all_demand <- c()
  
#Create pairings for each origin and destination station
  station_pairs <- arrival_rates %>%
    distinct(start_station, end_station)

#Start setting up the Poisson Process  
#For each station pairing (origin and destination), set the rates of pairings
#and lambda max (the maximum of mu_hat which is our lambda)
  for (i in 1:nrow(station_pairs)) {
    orig <- station_pairs$start_station[i]
    dest <- station_pairs$end_station[i]
    
    pair_rates <- arrival_rates %>% 
      filter(start_station == orig, end_station == dest)
    
    pair_rates$mu_hat <- ifelse(is.na(pair_rates$mu_hat), 0, pair_rates$mu_hat)
    lambda_max <- max(pair_rates$mu_hat, na.rm = TRUE)
    if (lambda_max == 0) next

#Start time at 0 and store demand in a vector
  t <- 0
  demand <- c()

#Starting at time 0 (for one day), find current arrival  
  while (t < day) {
    t <- t + rexp(1, rate = lambda_max)
    if (t > day) break

#Set an hour, rounded down so that we don't have problems with empty vectors
    hr <- floor(t)
    lambda_vector <- pair_rates$mu_hat[pair_rates$hour == hr]
    
    lambda_time <- if (length(lambda_vector) == 0) {
      0
    } else {
      mean(lambda_vector)
    }
  
#Make sure to remove NAs (it was not working when they were not removed)
    lambda_time <- ifelse(is.na(lambda_time), 0, lambda_time)

#Do the thinning (Generate simulation for non-homogeneous Poisson Process)
    if (runif(1) < lambda_time / lambda_max) {
      demand <- c(demand, t)
    }
  }

#Create data frame from the vector with all demands
  if (length(demand) > 0) {
    all_demand[[paste(orig, dest)]] <- data.frame(
        time = demand,
        origin = orig,
        destination = dest)
    }
  }
  
  bind_rows(all_demand)
}

#Run function so that the data frame is created and we can then simulate trips
#given our demand to see if they can occur. We will optimize from there.
demand_sim <- demand_simulation(arrival_rates)