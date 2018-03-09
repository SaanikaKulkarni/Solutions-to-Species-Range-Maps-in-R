#installs necessary packages
install.packages("rworldmap")
install.packages("rgbif")
library(rgbif)
library(rworldmap)

#set name as the species name for which we'd like to perform plotting
name <- "Panthera tigris"

##Easy

#create new blank map
newmap<- getMap(resolution="low")

#store data from rgbif corresponing to a particular species in df
df <- occ_search(scientificName = name, return =  "data")
#drop all rows with na values in longitude and latitude columns
df <- subset(df, !is.na(decimalLatitude))
df <- subset(df, !is.na(decimalLongitude))

#sets vectors for x and y coordinates of the plot
xcoord <- df$decimalLatitude
ycoord <- df$decimalLongitude
#plots map
species_map<-plot(newmap)
points(ycoord,xcoord, col = "red")

##Medium

hpts <- chull(x=xcoord,y=ycoord)
hpts <- c(hpts,hpts[1])
lines(ycoord[hpts],xcoord[hpts],col="blue")
