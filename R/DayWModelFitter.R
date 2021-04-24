#' Function to choose optimal forecast model
#'
#' @param data A tsibble.
#' @param Outcome A valid variable name for the Outcome to be modelled in in `data`.
#' @return A mable containing eleven columns.  3 Fourier and ARIMA models; 1 ARIMA, 1 ETS, 3 NNETAR (fourier 1,2,3) and a prophet
#' @examples
#' data(SNWSDPDX)
#' DayWModelFitter(SNWSDPDX, TX)
#' @importFrom rlang ensym
#' @import nnet
#' @importFrom tsibble tsibble
#' @importFrom magrittr %>%
#' @import fabletools
#' @importFrom fable ARIMA ETS NNETAR
#' @importFrom fable.prophet prophet
#' @importFrom dplyr mutate
#' @export
DayWModelFitter <- function(data, Outcome) {
  Outcome <- ensym(Outcome)
  fits <- data %>% as_tsibble() %>%
    model(`K = 1` = ARIMA(!!Outcome ~ fourier(K=1)+PDQ(0,0,0)),
          `K = 2` = ARIMA(!!Outcome ~ fourier(K=2)+PDQ(0,0,0)),
          `K = 3` = ARIMA(!!Outcome ~ fourier(K=3)+PDQ(0,0,0)),
          ARIMA = ARIMA(!!Outcome),
          ETS = ETS(!!Outcome),
          NNET1 = NNETAR(!!Outcome ~ fourier(K=1)),
          NNET2 = NNETAR(!!Outcome ~ fourier(K=2)),
          NNET3 = NNETAR(!!Outcome ~ fourier(K=3)),
          prophet.LAA = prophet(!!Outcome ~ growth(type="linear") + season(period=7)+season(name="annual")),
          prophet.LAA = prophet(!!Outcome ~ growth(type="linear") + season(period=7))
          ) %>%
    mutate(Combo1 = (ARIMA + ETS)/2)
  return(fits)
}
