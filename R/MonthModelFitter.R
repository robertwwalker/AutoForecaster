#' Function to choose optimal forecast model
#'
#' @param data A tsibble.
#' @param Outcome A valid variable name for the Outcome to be modelled in in `data`.
#' @return A mable containing eleven columns.  3 Fourier and ARIMA models; 1 ARIMA, 1 ETS, 3 NNETAR (fourier 1,2,3) and a prophet
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
  Outcome <- ensym(Outcome)
  fits <- data %>%
    model(`K = 1` = ARIMA(!!Outcome ~ fourier(K=1)+PDQ(0,0,0)),
          `K = 2` = ARIMA(!!Outcome ~ fourier(K=2)+PDQ(0,0,0)),
          `K = 3` = ARIMA(!!Outcome ~ fourier(K=3)+PDQ(0,0,0)),
          ARIMA = ARIMA(!!Outcome),
          ETS = ETS(!!Outcome),
          NNET1 = NNETAR(!!Outcome ~ fourier(K=1)),
          NNET2 = NNETAR(!!Outcome ~ fourier(K=2)),
          NNET3 = NNETAR(!!Outcome ~ fourier(K=3)),
          prophet = prophet(!!Outcome ~ growth() + season("year", 12))
  ) %>%
    mutate(Combo1 = (ARIMA + ETS)/2)
  return(fits)
}
