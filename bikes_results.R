#Loading in packages
library(tidyverse)
library(MASS) 
library(patchwork) 
library(glmnet)
library(dplyr)
library(tibble)
library(knitr)

# this script runs the final optimization function producing a data frame with 
#the optimized starting number of bikes for each station
# the optimization function does the following:
# runs estimation function: estimates arrival rates using data
# runs demand_simulation: simulates demand using arrival rates
# runs trips_simulation: simulates trips using demand simulation

simulate_trips(demand_sim, placement)

# this data frame just finds the start stations and the number of bikes at each
# we start with 0 bikes, and the optimizing_bikes function will update it
num_bikes <- data.frame(
  station = unique(sample_bike$start_station),
  bikes = 0)

# runs unhappy_customers: finds the number of unhappy customers using demand 
#simulation and num_bikes
unhappy(demand_sim, num_bikes)

# Now we can run optimizing_bikes which calls the previous functions

fleetsize_50 <- optimization(demand_sim, num_bikes, fleet_size = 50)

# This result is a data frame that contains all of the stations and the optimized 
# number of bikes each station should start with

# We run this 2 more times with different fleet sizes which is the number of 
#bikes available

fleetsize_100 <- optimization(demand_sim, num_bikes, fleet_size = 100)

fleetsize_500 <- optimization(demand_sim, num_bikes, fleet_size = 500)

#Create table of each result
kable(fleetsize_50)
kable(fleetsize_100)
kable(fleetsize_500)