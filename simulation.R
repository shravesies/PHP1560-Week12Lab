#' Simulating Demand for Bikes
#' 
#' @description
#' @param1 

arrival_rates <- estimate_arrival_rates(sample_bike)

simulation_trips <- function(arrival_rates, day = 24) {
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

    hr <- floor(t)
    lambda_vector <- pair_rates$mu_hat[pair_rates$hour == hr]
    
    lambda_time <- if (length(lambda_vector) == 0) {
      0
    } else {
      mean(lambda_vector)
    }
    
    lambda_time <- ifelse(is.na(lambda_time), 0, lambda_time)
    
    if (runif(1) < lambda_time / lambda_max) {
      demand <- c(demand, t)
    }
  }
  if (length(demand) > 0) {
    all_demand[[paste(orig, dest, sep = "_")]] <- data.frame(
        time = demand,
        origin = orig,
        destination = dest)
    }
  }
  
  bind_rows(all_demand)
}

demand_sim <- simulation_trips(arrival_rates)