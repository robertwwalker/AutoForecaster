#' Portland, Oregon Weather Data [NWSM]
#'
#' A monthly dataset for Portland, Oregon containing the average monthly maximum, minimum temperatures in degrees Fahrenheit and precipitation and snow amounts.
#' The variables are as follows [as obtained from the national weather service]:
#'
#' @format A data frame with 240 rows and 7 variables:
#' \describe{
#'   \item{MO}{an integer Month (1--12)}
#'   \item{YR}{four digit calendar year (2000--2019)}
#'   \item{MaxAvg}{maximum average temperature F (39--87.5)}
#'   \item{MinAvg}{maximum average temperature F (27.97--61.4)}
#'   \item{Precip}{Precipitation in in (0--15.24)}
#'   \item{Snow}{Snow in in (0--19)}
#'   \item{Month}{a yearmonth time counter (2000 Jan--2019 Dec)}
#' }
"NWSM"

#' Portland, Oregon Weather Data [NWSD]
#'
#' A daily dataset for Portland, Oregon containing the daily maximum, minimum temperatures in degrees Fahrenheit and precipitation and snow amounts.
#' The variables are as follows [as obtained from the national weather service]:
#'
#' @format A data frame with 5478 rows and 8 variables:
#' \describe{
#'   \item{Day}{an integer Day of the Month (1--31)}
#'   \item{YR}{four digit calendar year (1941--2019)}
#'   \item{MO}{two digit calendar month (1--12)}
#'   \item{TX}{maximum average temperature F (14--107)}
#'   \item{TN}{maximum average temperature F (-3--74)}
#'   \item{PR}{Precipitation in in (0--2.69)}
#'   \item{SN}{Snow in in (0--14.4)}
#'   \item{date}{a date [Date format] (1941 Jan 1--2019 Dec 31)}
#' }
"NWSD"

#' Portland, Oregon Weather Data [SNWSDPDX]
#'
#' A shortened daily dataset for Portland, Oregon containing the daily maximum, minimum temperatures in degrees Fahrenheit and precipitation and snow amounts for 2017 to 2019.
#' The variables are as follows [as obtained from the national weather service]:
#'
#' @format A data frame with 1095 rows and 8 variables:
#' \describe{
#'   \item{Day}{an integer Day of the Month (1--31)}
#'   \item{YR}{four digit calendar year (2017--2019)}
#'   \item{MO}{two digit calendar month (1--12)}
#'   \item{TX}{maximum average temperature F (39--87.5)}
#'   \item{TN}{maximum average temperature F (27.97--61.4)}
#'   \item{PR}{Precipitation in in (0--15.24)}
#'   \item{SN}{Snow in inches (0--19)}
#'   \item{date}{a date [Date format] (2017 Jan 1--2019 Dec 31)}
#' }
"SNWSDPDX"

#' Portland, Oregon Quarterly Weather Data [NWSQ]
#'
#' A quarterly dataset for Portland, Oregon containing the daily maximum, minimum temperatures in degrees Fahrenheit and precipitation and snow amounts.
#' The variables are as follows [as obtained from the national weather service]:
#'
#' @format A data frame with 316 rows and 5 variables:
#' \describe{
#'   \item{Quarter}{yearquarter: a yearquarter (1941 Q1--2019 Q4)}
#'   \item{TX}{average maximum temperature F (39--87.5)}
#'   \item{TN}{average maximum temperature F (27.97--61.4)}
#'   \item{PR}{Total precipitation in in (0--15.24)}
#'   \item{SN}{Total snow in in (0--19)}
#' }
"NWSQ"
