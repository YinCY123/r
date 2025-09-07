#
#
library(magrittr)
library(terra)

longitude <- c(-116.7, -120.4, -116.7, -113.5, -115.5, -120.8, -119.5, -113.7, -113.7, -110.7)
latitude <- c(45.3, 42.6, 38.9, 42.1, 35.7, 38.9, 36.2, 39, 41.6, 36.9)
lonlat <- cbind(longitude, latitude)

pts <- vect(lonlat)
pts %>% class
pts %>% geom
pts %>% ext
pts
#
#
#
crdref <- "+proj=longlat +datum=WGS84"
pts <- vect(lonlat, crs = crdref)

pts %>% crs

precipvalue <- runif(nrow(lonlat), min = 0, max = 100)
df <- data.frame(ID=1:nrow(lonlat), precip = precipvalue)
ptv <- vect(lonlat, atts = df, crs = crdref)
ptv
#
#
#
#
#
#
