medium <-function (xcoord,ycoord){
  hpts <- chull(x=xcoord,y=ycoord)
  hpts <- c(hpts,hpts[1])
  poly<-lines(ycoord[hpts],xcoord[hpts],col="blue")
  return (hpts)
}