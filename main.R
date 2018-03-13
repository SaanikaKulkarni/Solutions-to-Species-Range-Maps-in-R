##Choose a species
name <- "Panthera tigris"

##locs is a data frame that stores the longitude and latitude coordinates of the species
locs <-easy(name)

##hpts is a list that stores the indexes of the points acting as vertices of the convex hull
hpts <-medium(locs$x,locs$y)

##poly_locs is a data frame that stores the coordinates of these points 
poly_locs <-ConvexHullPoints(hpts,locs)

##Final clipping of polygon on land
hard(poly_locs)
