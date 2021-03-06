% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xtsum.R
\name{xtsum}
\alias{xtsum}
\title{xtsum: A function to create time-series cross-section summaries in R}
\usage{
xtsum(formula, data)
}
\arguments{
\item{formula}{A one sided formula; (key ~ .)}

\item{data}{A tidyquant daily OHLC tibble.}
}
\value{
data.frame A data frame with between and within data
}
\description{
xtsum: A function to create time-series cross-section summaries in R
}
\examples{
xtsum(symbol ~ ., data=FANG)
}
