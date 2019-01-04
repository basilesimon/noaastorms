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
#'   @param dateRange: a vector of two valid dates: c(startDate, endDate)
#'   @example
#'   getStorms('WP')
#'   getStorms('EP',
#'     dateRange = c(as.Date('2010-01-01'), as.Date('2012-01-01')))
#'
#'   Build and Reload Package:  'Cmd + Shift + B'
#'   Check Package:             'Cmd + Shift + E'
#'   Test Package:              'Cmd + Shift + T'

#' @export
makeURL <- function(basinCode) {
  file <- stringr::str_glue('Basin.{basinCode}.ibtracs_all.v03r10.csv')
  urlPrefix <- 'ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r10/all/csv/basin/'
  url <- stringr::str_glue('{urlPrefix}{file}')
  print(url)
  return(url)
}

#' @export
cleanDataframe <- function(basinData) {
  # first column is garbled, disegard
  basinData <- basinData[-1, ]

  # cleaner columns
  basinData$Season <- as.numeric(basinData$Season)
  basinData$Latitude <- as.numeric(gsub("^ ", "", basinData$Latitude))
  basinData$Longitude <- as.numeric(gsub("^ ", "", basinData$Longitude))
  basinData$Wind.WMO. <- as.numeric(gsub("^ ", "", basinData$Wind.WMO.))
  basinData$Name <- as.factor(basinData$Name)
  basinData$ISO_time.parsed <- as.Date(basinData$ISO_time)

  # filter apparent erroneous coordinates
  basinData.filtered <- dplyr::filter(basinData,
                                      !Latitude == -999,
                                      !Longitude == -999)

  return(basinData.filtered)
}

filterDateRange <- function(basinData, dateRange) {
  basinData.dateFiltered <- dplyr::filter(basinData,
                                          ISO_time.parsed > dateRange[1],
                                          ISO_time.parsed < dateRange[2])
  return(basinData.dateFiltered)
}

getStorms <- function(basin, dateRange) {

  validBasins <- c('EP', 'NA', 'NI', 'SA', 'SI', 'SP', 'WP')
  if (!length(basin) == 1) stop('Please specify one basin code at a time')
  if (!basin %in% validBasins) stop('You have specified an incorrect basin code')

  url <- makeURL(basin)
  basinData <- read.csv(file = url, skip = 1, stringsAsFactors = FALSE)

  cleanData <- cleanDataframe(basinData)

  if (hasArg(dateRange)) {
    cleanData <- filterDateRange(cleanData, dateRange)
  }

  return(cleanData)
}
