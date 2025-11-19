#Reading in the data
sample_bike <- read.csv(".../sample_bike.csv")

#Cleaning data to remove extra column
sample_bike <- sample_bike[,2:6]