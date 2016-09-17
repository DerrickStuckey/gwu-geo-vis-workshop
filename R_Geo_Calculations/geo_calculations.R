# calculate distance between two latitude/longitude points
# approximating the earth as a sphere
# 1 degree latitude ~ 69 miles
distance_in_miles <- function(lat1,lng1,lat2,lng2) {
  lat <- (lat1 + lat2) / 2
  # multiplier for longitudinal distance due to curvature of the earth
  x_multiplier <- cos(lat/180*pi)
  x_dist <- (lng2-lng1)*x_multiplier*69
  y_dist <- (lat2-lat1)*69
  total_dist <- sqrt(x_dist**2+y_dist**2)
  return(total_dist)
}

# return combination of entries in df1, df2 that are within max_dist_miles of each other
# expects each data frame to have a "Latitude" and "Longitude" column
merge_by_distance <- function(df1, df2, max_dist_miles) {
  # use dummy column to construct cartesian product
  df1$Dummy <- TRUE
  df2$Dummy <- TRUE
  cartesian_product <- merge(df1,df2,by="Dummy")
  # drop dummy column
  cartesian_product <- subset(cartesian_product, select=-Dummy)
  # calculate distance for each combination
  cartesian_product$distance <- distance_in_miles(cartesian_product$Latitude.x,cartesian_product$Longitude.x,
                                                  cartesian_product$Latitude.y,cartesian_product$Longitude.y)
  # only keep combinations less than the max distance
  valid_combinations <- cartesian_product[cartesian_product$distance<=max_dist_miles,]
  return(valid_combinations)
}

### TEST ###
# store_locations <- read.csv("~/Desktop/Projects/GWU/gwu-geo-vis-workshop/Exercise/store_locations.csv")
# head(store_locations)
# distance_in_miles(store_locations$Latitude[1],store_locations$Longitude[1],
#                   store_locations$Latitude[2],store_locations$Longitude[2])

# store_locations2 <- store_locations
# store_locations2$Latitude <- store_locations2$Latitude + 1/69
# store_locations2$Longitude <- store_locations2$Longitude + 2/69

# within_2_miles <- merge_by_distance(store_locations,store_locations2,2)
# within_2_miles
