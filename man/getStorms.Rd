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
getStorms(basin)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{basin}{
  A basin code from the list:
  - NA: North Atlantic
  - SA: South Atlantic
  - NI: North Indian
  - SI: South Indian
  - EP: East Pacific
  - SP: South Pacific
  - WP: West Pacific
}
}
\value{
\code{basinData}, a dataframe
}

\author{
Basile Simon <basile@basilesimon.fr>
}

\examples{
getStorms("WP")
}
