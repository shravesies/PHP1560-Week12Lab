#Loading in packages
library(tidyverse)
library(MASS) 
library(patchwork) 
library(glmnet)
library(dplyr)
library(tibble)
library(knitr)

# this script runs the final optimization function producing a data frame with 
# the optimized starting number of bikes for each station
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

fleetsize_50 <- optimization(demand_sim, num_bikes, fleet_size = 50, seed = 1)

# This result is a data frame that contains all of the stations and the optimized 
# number of bikes each station should start with

# We run this 2 more times with different fleet sizes which is the number of 
#bikes available

fleetsize_100 <- optimization(demand_sim, num_bikes, fleet_size = 100, seed = 2)

fleetsize_500 <- optimization(demand_sim, num_bikes, fleet_size = 500, seed = 3)

#Create table of each result and analyze
kable(fleetsize_50)
#With a fleet size of 50, we optimized using the optimization function.
#This function allows us to find the number of bikes each station should
#start with, given a specific fleet size. Then, from this fleet size, we would
#want to start with 14 bikes at station 16, 19 bikes at station 17, 5 at
#station 13 and 12 at station 16. There are zero at the rest (all given by
#the table). From this, we can understand that trips at the start of the day 
#tend to be from these stations when the fleet size for bikes is 50. Therefore
#to optimize happy customers (people whose trip was fulfilled), we will
#optimize at this number

kable(fleetsize_100)
#Similarly, we can interpret the results from the table for fleet size
#of 100 same as we did for fleet size 100. From our table, the previously
#mentioned stations still will have a majority of the starting bikes
#as well as stations 21 and 11 now having starting bikes when optimizing
#at this level. We will optimize at this level, given this strategy and
#this begins to show the importance of specific stations over others,
#such as stations 16, 17, 13, and 23 which will always have bikes across
#all these sizes.

kable(fleetsize_500)
#Finally, when looking at these results, we get a large change in distribution
#of starting bikes, with most notably station R suddenly going from no bikes
#to over 100 bikes starting in its station which may be odd. Notably, all
#stations besides station 5 and 15 have starting bikes when optimized, showing
#us that perhaps these stations are of least importance/have the least amount
#of demand. Stations with the most amount of starting bikes are stations
#R, 13, 7 and 17 (in order of most bikes to lesser bikes). 

#Then, from these results and analysis, fleet size will change results for 
#the optimal placement of starting bikes, which is important to note.
#Particularly, the change in the fleet size of 100 to 500 is the most notable.
#However, the more bikes we have, the more optimized on happy customers we can
#become. From these results all together, we would then argue that the most
#important stations to have bikes on would be stations 17 and 13 because
#throughout ever results table for each fleet size, they will always need bikes
#to optimize and in fact will tend to have a high number of bikes too, making
#demand at the start the highest. Stations with bikes at fleet size 50 and 100
#are also important as they are more necessary for optimizing at every level
#as well, but not as much as the previously mentioned stations. Station R is
#also one of the more important stations considering how when the fleet size
#increases to a much larger number, the optimized placement for bikes shows
#that many bikes will be placed there at the start to optimize at that level.
#Therefore, stations 17, 13, and perhaps R prove to be of great importance.