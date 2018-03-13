easy <-function(name){
  #install packages to get rgbif database and worldmap
  library(rgbif)
  library(rworldmap)
  #create new blank map
  newmap<- getMap(resolution="low")
  #store data from rgbif corresponing to a particular species in df
  df <- occ_search(scientificName = name, return =  "data")
  #drop all rows with na values in longitude and latitude columns
  df <- subset(df, !is.na(decimalLatitude))
  df <- subset(df, !is.na(decimalLongitude))
  #sets vectors for x and y coordinates of the plot
  x <- df$decimalLatitude
  y<- df$decimalLongitude
  #plots map
  species_map<-plot(newmap)
  points(y,x, col = "red")
  #returns coordinates in a dataframe
  return(data.frame(x,y))
  
}