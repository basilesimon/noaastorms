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
#'   @param basin: a vector of basin codes
#'   @param dateRange: a vector of two valid dates: c(startDate, endDate)
#'   @example
#'   getStorms(c('NA', 'SA'))
#'   getStorms(c('NA', 'SA'),
#'     dateRange = c(as.Date('2010-01-01'), as.Date('2012-01-01')))
#'
#'   Build and Reload Package:  'Cmd + Shift + B'
#'   Check Package:             'Cmd + Shift + E'
#'   Test Package:              'Cmd + Shift + T'

#' @export
makeURL <- function(basinCode) {
  # file <- stringr::str_glue('Basin.{basinCode}.ibtracs_all.v03r10.csv')
  # urlPrefix <- 'ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r10/all/csv/basin/'
  file <- stringr::str_glue('ibtracs.{basinCode}.list.v04r00.csv')
  urlPrefix <- 'ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v04r00/provisional/csv/'
  url <- stringr::str_glue('{urlPrefix}{file}')
  print(url)
  return(url)
}

#' @export
cleanDataframe <- function(basinData) {
  # first column is garbled, disegard
  basinData <- basinData[-1, ]

  # cleaner columns
  basinData$SEASON <- as.numeric(basinData$SEASON)
  basinData$LAT <- as.numeric(gsub("^ ", "", basinData$LAT))
  basinData$LON <- as.numeric(gsub("^ ", "", basinData$LON))
  basinData$WMO_WIND <- as.numeric(gsub("^ ", "", basinData$WMO_WIND))
  basinData$NAME <- as.factor(basinData$NAME)
  basinData$ISO_TIME <- as.Date(basinData$ISO_TIME)

  # filter apparent erroneous coordinates
  basinData.filtered <- dplyr::filter(basinData,
                                      !LAT == -999,
                                      !LON == -999)

  return(basinData.filtered)
}

filterDateRange <- function(basinData, dateRange) {
  basinData.dateFiltered <- dplyr::filter(basinData,
                                          ISO_TIME > dateRange[1],
                                          ISO_TIME < dateRange[2])
  return(basinData.dateFiltered)
}

getStorms <- function(basins, dateRange) {

  validBasins <- c('EP', 'NA', 'NI', 'SA', 'SI', 'SP', 'WP')

  # Stop if one basin code passed if found invalid
  if(!all(basins %in% validBasins)) stop('You have specified an incorrect basin code')

  # iterate over basin codes as we've done for one before
  # then merge result
  allData <- data.frame()
  for (basin in basins) {
    url <- makeURL(basin)
    basinData <- read.csv(file = url, stringsAsFactors = FALSE)

    cleanData <- cleanDataframe(basinData)

    if (hasArg(dateRange)) {
      cleanData <- filterDateRange(cleanData, dateRange)
    }
    allData <- rbind(allData, cleanData)
  }

  return(allData)
}
