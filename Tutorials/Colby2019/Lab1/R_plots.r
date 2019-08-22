install.packages("faraway") # If you don't have the package installed
library(faraway)
data("worldcup") # some data on players in the 2010 World Cup 

library(ggplot2)

# relationship between the amount of time each player played and the number of passes he made
ggplot(worldcup, aes(x = Time, y = Passes)) + 
  geom_point()

# use color to show player position and size to show shots on goal
ggplot(worldcup, aes(x = Time, y = Passes, color = Position, size = Shots)) + 
  geom_point()

