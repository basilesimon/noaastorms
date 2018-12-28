#'   Fetch NOAA historical best track storms data
#'
#'   Available basins:
#'   - NA: North Atlantic
#'   - SA: South Atlantic
#'   - NI: North Indian
#'   - SI: South Indian
#'   - EP: East Pacific
#'   - SP: South Pacific
#'   - WP: West Pacific
#'
#'   @param basin: a string from the list of available basins
#'   @example
#'   getStorms('WP')
#'
#'   Build and Reload Package:  'Cmd + Shift + B'
#'   Check Package:             'Cmd + Shift + E'
#'   Test Package:              'Cmd + Shift + T'

getStorms <- function(basin) {

  validBasins <- c('EP', 'NA', 'NI', 'SA', 'SI', 'SP', 'WP')
  if (!basin %in% validBasins) stop('You have specified an incorrect basin code')

  file <- stringr::str_glue('Basin.{basin}.ibtracs_all.v03r10.csv')
  urlPrefix <- 'ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r10/all/csv/basin/'
  url <- stringr::str_glue('{urlPrefix}{file}')

  basinData <- read.csv(file = url, skip = 1, stringsAsFactors = FALSE)

  # first column is garbled, disegard
  basinData <- basinData[-1, ]

  # cleaner columns
  basinData$Season <- as.numeric(basinData$Season)
  basinData$Latitude <- as.numeric(gsub("^ ", "", basinData$Latitude))
  basinData$Longitude <- as.numeric(gsub("^ ", "", basinData$Longitude))
  basinData$Wind.WMO. <- as.numeric(gsub("^ ", "", basinData$Wind.WMO.))
  basinData$Name <- as.factor(basinData$Name)

  return(basinData)
}
