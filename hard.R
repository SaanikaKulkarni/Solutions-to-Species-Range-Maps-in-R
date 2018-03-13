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
