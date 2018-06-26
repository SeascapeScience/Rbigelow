library('fields')
lat <- c(43+54.130/60,43+51.8/60,43+48.56/60,43+44.87/60)
TEM <- matrix(NA,nrow=100,ncol=4)
for (i in 1:4)
{
  CTD <- read.csv(paste('20170912Colbysta',i,'.csv',sep=""))
  for (j in 1:100)
  {
    TEM[j,i] <- mean(CTD[ceiling(CTD[,1])==j,2])
  }    
}
image.plot(x=lat[4:1],y=-100:-1,t(TEM[100:1,4:1]),
           zlim=c(8,20),
           col=tim.colors(24),
           xlab='latitude (deg N)',
           ylab='Depth (m)',
           breaks=seq(8,20,.5),las=1,
           legend.lab='Temperature (C)',
           legend.line=2.5)

image.plot(x=lat[4:1],y=-100:-1,t(TEM[100:1,4:1]),
           zlim=c(10,14),
           col=tim.colors(20),
           xlab='latitude (deg N)',
           ylab='Depth (m)',
           breaks=seq(10,14,.2),las=1,
           legend.lab='Temperature (C)',
           legend.line=2.5)

image.plot(x=lat[4:1],y=-100:-1,t(TEM[100:1,4:1]),
           col=tim.colors,
           xlab='latitude (deg N)',
           ylab='Depth (m)',
           las=1,
           legend.lab='Temperature (C)',
           legend.line=2.5)







#TEM2 <- TEM
#TEM2[is.na(TEM)] <- -1
#filled.contour(x=lat[4:1],y=-100:-1,t(TEM2[100:1,4:1]),
#               levels=seq(8,20),
#               color=function(x)rev(rainbow(x)))


