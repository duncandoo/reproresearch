#put functions here that are used in the analysis

savepdf <- function(file, width=16, height=10)
{
  #To use:
  #savepdf("filename")
  ## Plotting commands here
  #dev.off()
  fname <- paste("figures/",file,".pdf",sep="")
  pdf(fname, width=width/2.54, height=height/2.54,
      pointsize=10)
  par(mgp=c(2.2,0.45,0), tcl=-0.4, mar=c(3.3,3.6,1.1,1.1))
}


