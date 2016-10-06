# install.packages("sp")
# install.packages("rgdal")

library("sp")
library("rgdal")

# load the store locations data file
store_locations <- read.csv("../Exercise/store_locations.csv",
                            stringsAsFactors = FALSE)
store_locations

# format the coordinates as a tuple
coordinates(store_locations) <- c("Longitude","Latitude") #NOTE longitude comes first
store_locations

# set the CRS (coordinate reference system)
proj4string(store_locations) <- CRS("+proj=longlat +datum=WGS84")

# write out the file in .kml format
writeOGR(store_locations, "store_locations.kml", layer="Store Locations", driver="KML") 

