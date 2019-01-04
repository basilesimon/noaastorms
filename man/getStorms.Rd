\name{getStorms}
\alias{getStorms}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Get NOAA IBTrack data
}
\description{
Fetch NOAA historical best track storms data
}
\usage{
getStorms(basins, dateRange)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{basins}{
  A vector of basin codes from the list:
  - NA: North Atlantic
  - SA: South Atlantic
  - NI: North Indian
  - SI: South Indian
  - EP: East Pacific
  - SP: South Pacific
  - WP: West Pacific
  }
  \item{dateRange}{
  A vector of two valid dates. Storms dated outside of this date range will be filtered out if this parameter is passed. Ie:
  c(startDate, endDate)
  }
}
\value{
\code{basinData}, a dataframe
}

\author{
Basile Simon <basile@basilesimon.fr>
}

\examples{
getStorms(c('NA', 'SA'))
}
