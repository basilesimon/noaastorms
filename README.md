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
