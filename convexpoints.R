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
