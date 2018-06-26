TSdiagram <- function(t,S,xlim=c(30,38),ylim=c(-5,30)){
  # Libraries needed for this function
  library(marelac)
  library(plot3D)
  
  # Create density contours
  S.seq  <- seq(from = xlim[1], to = xlim[2], length.out = 100)
  t.seq  <- seq(from = ylim[1], to = ylim[2], length.out = 100)
  sig.mat <- outer(S.seq, t.seq, FUN = function(S, t) sw_dens(S = S, t = t) - 1000)
  
  #Plot contours
  contour2D(x = S.seq, y = t.seq, z = sig.mat, lwd = 2,
   xlab = "Salinity (psu)", ylab = "Temperature (deg C)", 
   main = "Sigma, p = 0 dbars")
  
  #Scatter plot temperature
  scatter2D(S, t, col = 'black', pch = '.', cex = 2, add = TRUE, 
   colkey = FALSE)

# for colored points
# sigma <- sw_dens(S = S, t = t) - 1000       
# scatter2D(S, t, colvar = sigma, pch = 18, cex = 2, add = TRUE, clim = range(sig.mat), colkey = FALSE)

}