#' Portland, Oregon Monthly Weather Data [NWSM]
#'
#' A monthly tsibble (index = Month) for Portland, Oregon containing the average monthly maximum, minimum temperatures in degrees Fahrenheit and precipitation and snow amounts.
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

#' Portland, Oregon Daily Weather Data [NWSD]
#'
#' A daily tsibble (index=date) for Portland, Oregon containing the daily maximum, minimum temperatures in degrees Fahrenheit and precipitation and snow amounts.
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

#' Shortened Portland, Oregon Daily Weather Data [SNWSDPDX]
#'
#' A shortened daily tsibble (index=date) for Portland, Oregon containing the daily maximum, minimum temperatures in degrees Fahrenheit and precipitation and snow amounts for 2017 to 2019.
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
#' A quarterly tsibble (index=Quarter) for Portland, Oregon containing the daily maximum, minimum temperatures in degrees Fahrenheit and precipitation and snow amounts.
#' The variables are as follows [as obtained from the national weather service]:
#'
#' @format A data frame with 316 rows and 5 variables:
#' \describe{
#'   \item{Quarter}{yearquarter: a yearquarter (1941 Q1--2019 Q4)}
#'   \item{TX}{average maximum temperature F (39--87.5)}
#'   \item{TN}{average maximum temperature F (27.97--61.4)}
#'   \item{PR}{Total precipitation in inches (0--15.24)}
#'   \item{SN}{Total snow in inches (0--19)}
#' }
"NWSQ"

#' Facebook daily returns[fb_returns]
#'
#' A daily dataset (tsibble) of stock price data and returns for Facebook from 2013 through the end of 2016.
#'
#' @format A tsibble (index=trading_day) with 1008 rows and 8 variables:
#' \describe{
#'   \item{symbol}{Facebook's ticker ("FB")}
#'   \item{date}{a calendar date (2013-01-02--2016-12-30)}
#'   \item{open}{opening price (22.99--133.5)}
#'   \item{high}{high price for the day (23.09--133.50)}
#'   \item{low}{low price for the day (22.67--132.22)}
#'   \item{close}{closing price for the day (23.09--133.3)}
#'   \item{volume}{shares traded for the day (5913100--365457900)}
#'   \item{adjusted}{adjusted closing price for the day (22.90--133.28)}
#'   \item{daily.returns}{daily returns for the trading day (-0.069--0.296)}
#'   \item{trading_day}{the trading day (1--1008)}
#' }
"fb_returns"

#' FANG Stock Data [FANG]
#'
#' An irregular daily tibble (index=date, key=symbol) of stock prices in OHLC for Facebook, Amazon, Netflix, and Google.
#'
#' @format An irregular daily tsibble with 4032 rows and 8 variables:
#' \describe{
#'   \item{symbol}{a character ticker symbol (1--31)}
#'   \item{date}{a date [in yy-mm-dd] (2013-01-02--2016-12-30)}
#'   \item{open}{opening price (22.99--1226.80)}
#'   \item{high}{high price for the day (23.09--1228.88)}
#'   \item{low}{low price for the day (22.67--1218.60)}
#'   \item{close}{closing price for the day (22.9--1220.20)}
#'   \item{volume}{shares traded for the day (7900--365457900)}
#'   \item{adjusted}{adjusted closing price for the day (13.14--844.36)}
#' }
"FANG"
