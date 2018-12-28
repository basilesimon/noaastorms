# NOAA Storms wrapper

Get NOAA IBTrack data ready to use in R

# Installing

```r
library(devtools)
install_github("basilesimon/noaastorms")
```

## Available functions

`getStorms`: Fetch NOAA historical best track storms data

```r
> df <- getStorms(basin)
> head(df[1:5])
     Serial_Num Season Num Basin Sub_basin    Name
2 1902276N14266   1902  01    EP        MM UNNAMED
3 1902276N14266   1902  01    EP        MM UNNAMED
4 1902276N14266   1902  01    EP        MM UNNAMED
5 1902276N14266   1902  01    EP        MM UNNAMED
6 1902276N14266   1902  01    EP        MM UNNAMED
```

**Arguments**: A basin code from the list:
  - NA: North Atlantic
  - SA: South Atlantic
  - NI: North Indian
  - SI: South Indian
  - EP: East Pacific
  - SP: South Pacific
  - WP: West Pacific

## Usage

```r
wm <- map_data("world")
library("PBSmapping")
data.table::setnames(wm, c("X","Y","PID","POS","region","subregion"))
worldmap = clipPolys(wm, xlim=c(20,110),ylim=c(0, 45), keepExtra=TRUE)

spStorms <- getStorms('NI')
spStorms <- spStorms %>% filter(!Latitude == -999,
                                !Longitude == -999)

library(dplyr)
ggplot(spStorms, aes(x = Longitude, y = Latitude, group = Serial_Num)) + 
  geom_polygon(data = worldmap, aes(x = X, y = Y, group = PID), 
               fill = "whitesmoke", colour = "gray10", size = 0.2) +
  geom_path(alpha = 0.1, size = 0.8,
            color = "red") +
  coord_map(xlim = c(20,110), ylim = c(0, 45)) 
```

![](./Rplot.png)