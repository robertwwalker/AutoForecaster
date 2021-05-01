#' Function to estimate monthly time series models
#'
#' @param data A tsibble.
#' @param Outcome A valid variable name for the Outcome to be modelled in in `data`.
#' @return A mable containing: \itemize{
#' \item \strong{K=1,2,3}: ARIMA models with fourier(K=1,2,3)
#' \item \strong{ARIMA, .T, .TS}: an ARIMA model .t (with trend) .ts (with trend and season)
#' \item \strong{ETS}: an ETS model
#' \item \strong{NNET}: the model fits of NNETAR with T (trend) TS (trend and season) and numbers indicate K
#' \item \strong{prophet}: a prophet model with monthly seasons
#' \item \strong{Combo1}: the average of ETS and ARIMA
#' \item \strong{Combo2}: the average of ETS, NNETT2 and ARIMA
#' }
#' @examples
#' data(NWSM)
#' MonthModelFitter(NWSM, MaxAvg)
#' @importFrom rlang ensym
#' @importFrom tsibble tsibble
#' @importFrom magrittr %>%
#' @import nnet
#' @import urca
#' @import fabletools
#' @import fable
#' @import feasts
#' @importFrom fable.prophet prophet
#' @importFrom dplyr mutate
#' @export
MonthModelFitter <- function(data, Outcome) {
  Outcome <- enexpr(Outcome)
  fits <- data %>%
    model(`K = 1` = ARIMA(!!Outcome ~ fourier(K=1)+PDQ(0,0,0)),
          `K = 2` = ARIMA(!!Outcome ~ fourier(K=2)+PDQ(0,0,0)),
          `K = 3` = ARIMA(!!Outcome ~ fourier(K=3)+PDQ(0,0,0)),
          `K = 4` = ARIMA(!!Outcome ~ fourier(K=4)+PDQ(0,0,0)),
          ARIMA = ARIMA(!!Outcome),
          ARIMA.T = ARIMA(!!Outcome ~ trend()),
          ARIMA.TS = ARIMA(!!Outcome ~ trend() + season()),
          ETS = ETS(!!Outcome),
          NNETT = NNETAR(!!Outcome ~ trend()),
          NNETTS = NNETAR(!!Outcome ~ trend() + season()),
          NNETT1 = NNETAR(!!Outcome ~ trend() + fourier(K=1)),
          NNETT2 = NNETAR(!!Outcome ~ trend() + fourier(K=2)),
          NNET2 = NNETAR(!!Outcome ~ fourier(K=2)),
          NNET3 = NNETAR(!!Outcome ~ fourier(K=3)),
          prophet = prophet(!!Outcome ~ growth() + season("year", 12)),
    ) %>%
    mutate(Combo1 = (ARIMA + ETS)/2,
           Combo2 = (NNET2 + ARIMA.TS + ETS) / 3)
  return(fits)
}
