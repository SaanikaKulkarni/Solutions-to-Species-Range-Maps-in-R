ConvexHullPoints <- function(hpts,locs){
  hpts_polt <- sort(hpts)
  for(i in hpts){
    poly_locs = rbind(poly_locs,locs[as.numeric(rownames(locs))==i,])
  }
  return (poly_locs)
}