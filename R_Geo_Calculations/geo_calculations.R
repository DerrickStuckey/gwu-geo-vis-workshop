# calculate distance between two latitude/longitude points
# approximating the earth as a sphere
# 1 degree latitude ~ 69 miles
distance_in_miles <- function(lat1,lng1,lat2,lng2) {
  lat <- mean(lat1,lat2)
  x_multiplier <- cos(lat/180*pi)
  x_dist <- (lng2-lng1)*x_multiplier*69
  y_dist <- (lat2-lat1)*69
  total_dist <- sqrt(x_dist**2+y_dist**2)
  return(total_dist)
}




### TEST ###
# store_locations <- read.csv("~/Desktop/Projects/GWU/gwu-geo-vis-workshop/Exercise/store_locations.csv")
# head(store_locations)
# distance_in_miles(store_locations$Latitude[1],store_locations$Longitude[1],
#                   store_locations$Latitude[2],store_locations$Longitude[2])

