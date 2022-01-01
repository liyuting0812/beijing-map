#北京城区地图
library(maps)
library(mapdata) 
# library(sp)  #SpatialPolygons
library(maptools)
library(rgdal)

library(ggplot2)
library(plyr)

xian <- sf::st_read("C:/Users/Catherine/Desktop/map/县级行政区.shp")

x <- xian

loc<- which(x$省代码==110000);loc
ll <- x[loc,];ll
b <- c(2,3,4,6,11)

ll$'样本量' <- c(0,31,83,52,0,109,0,0,0,0,91,0,0,0,0,0)

lll <- ll[b,]
china_map <- sf::st_transform(lll, "+init=epsg:4326")
ggplot(china_map)+
  geom_sf(aes(fill=样本量),col="grey95")+
  scale_fill_gradient(low="white",high="steelblue") +
  coord_sf()+
  annotate("text",x=116.37,y=39.92,label="西城区",col=1,cex=2)+
  annotate("text",x=116.53,y=39.92,label="朝阳区",col=1,cex=3)+
  annotate("text",x=116.27,y=39.99,label="海淀区",col=1,cex=3)+
  annotate("text",x=116.13,y=40.22,label="昌平区",col=1,cex=3)+
  annotate("text",x=116.27,y=39.86,label="丰台区",col=1,cex=3)
