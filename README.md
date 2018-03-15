# Solutions-to-Species-Range-Maps-in-R

## Libraries 
```
library(rworldmap)
library(rgbif)
library(maps)
library(sp)
library(rgeos)
library(maptools)
library(raster)
```
Pick whatever species you wish to plot
```
name<- "Panthera tigris"
```

## Easy
The following function imports Species occurrence data from the rgbif database and plots it on a world map.
```
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
```
![Text](https://github.com/SaanikaKulkarni/Solutions-to-Species-Range-Maps-in-R/blob/master/Panthera%20tigris%20Species%20plot.png)

locs is a data frame that stores the longitude and latitude coordinates of the species
```
locs <-easy(name)
```

## Medium
The folowing functions constructs a convex polygon around the plotted points.
```
medium <-function (xcoord,ycoord){
  hpts <- chull(x=xcoord,y=ycoord)
  hpts <- c(hpts,hpts[1])
  poly<-lines(ycoord[hpts],xcoord[hpts],col="blue")
  return (hpts)
}
```
hpts is a list that stores the indexes of the points acting as vertices of the convex hull
```
hpts <-medium(locs$x,locs$y)
```
![](https://github.com/SaanikaKulkarni/Solutions-to-Species-Range-Maps-in-R/blob/master/Panthera%20tigris%20Convex%20Hull%20Polygon.png)

## Hard
The following functions clip the generated convex hull polygon to only the land regions.
```
ConvexHullPoints <- function(hpts,locs){
  ##sorts list in ascending order of index
  hpts_polt <- sort(hpts)
  ##iterates over every item in the list and appends the row from locs which rowname matches its index  
  for(i in hpts){
    poly_locs = rbind(poly_locs,locs[as.numeric(rownames(locs))==i,])
  }
  ##return a data frame consisting of coordinates of vertices of the convex hull polygon
  return (poly_locs)
}
```

poly_locs is a data frame that stores the vertices of the convex hull polygon 
```
poly_locs <-ConvexHullPoints(hpts,locs)
```

```
plotforcontinent <- function(poly_locs){
  library(rgeos)
  library(sp)
  ##convert data frame of locations to a formal Polygon p
  p <- Polygon(poly_locs)
  ## Converts Formal Polygon p into a Spatial Polygon ps
  ps <-SpatialPolygons(list(Polygons(list(p), ID = "a")), proj4string=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
  ##finds areas of intersection of this Spatial Polygon ps and the world map
  gI <- gIntersects(newmap,ps,byid = TRUE)
  ##determines which portions of the map to disregard
  out <- lapply( which(gI) , function(x){ gIntersection( newmap[x,] , ps ) } )
  table( sapply( out , class ) )
  ##determines which ones to keep
  keep <- sapply(out, class)
  out <- out[keep == "SpatialPolygons"]
  ##treats various portions of the map as multiple polygons and iterates over them
  finalresult <- SpatialPolygons( lapply( 1:length( out ) , function(i) { Pol <- 
  slot(out[[i]], "polygons")[[1]]; slot(Pol, "ID") <- as.character(i)
  Pol
  }))
  ##plots the final map
  plot(finalresult,col="purple",add=TRUE)
}
```

Final clipping of polygon on land
```
hard(poly_locs)
```
![](https://github.com/SaanikaKulkarni/Solutions-to-Species-Range-Maps-in-R/blob/master/Panthera%20tigris%20Clipped%20Convex%20Hull%20Plot.png)

