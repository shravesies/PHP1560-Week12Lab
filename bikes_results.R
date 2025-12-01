#Loading in packages
library(tidyverse)
library(MASS) 
library(patchwork) 
library(glmnet)
library(dplyr)

# this script runs the final optimization function producing a data frame with 
#the optimized starting number of bikes for each station
# the optimization function does the following:
# runs estimation function: estimates arrival rates using data
# runs demand_simulation: simulates demand using arrival rates
# runs trips_simulation: simulates trips using demand simulation

# this data frame just finds the start stations and the number of bikes at each
# we start with 0 bikes, and the optimizing_bikes function will update it
num_bikes <- data.frame(
  station = unique(sample_bike$start_station),
  bikes = 0)

# runs unhappy_customers: finds the number of unhappy customers using trip 
#simulation and num_bikes
unhappy(output_dataframe_of_trip_simulation, num_bikes)

# Now we can run optimizing_bikes which calls all the previous functions

optimizing bikes(output_dataframe_of_trip_simulation, num_bikes)

# This result is a data frame that contains all of the stations and the optimized 
# number of bikes each station should start with
# the unhappy column should be zero since the while loop only ends when there
# are no unhappy customers left
