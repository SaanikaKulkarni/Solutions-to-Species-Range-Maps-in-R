plotforcontinent <- function(poly_locs){
  library(rgeos)
  library(sp)
      ps <-SpatialPolygons(list(Polygons(list(p), ID = "a")), proj4string=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
      gI <- gIntersects(newmap,ps,byid = TRUE)
      out <- lapply( which(gI) , function(x){ gIntersection( newmap[x,] , ps ) } )
      table( sapply( out , class ) )
      keep <- sapply(out, class)
      out <- out[keep == "SpatialPolygons"]
      finaltrial <- SpatialPolygons( lapply( 1:length( out ) , function(i) { Pol <- 
        slot(out[[i]], "polygons")[[1]]; slot(Pol, "ID") <- as.character(i)
        Pol
        }))
      plot(finaltrial,col="purple",add=TRUE)
}
