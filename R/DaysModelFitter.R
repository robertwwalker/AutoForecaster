#' Function to estimate daily time series models
#'
#' @param data A tsibble.
#' @param Outcome A valid variable name for the Outcome to be modelled in in `data`.
#' @return A mable containing: \itemize{
#' \item \strong{K=1,2,3}: ARIMA models with fourier(K=1,2,3)
#' \item \strong{ARIMA}: an ARIMA model
#' \item \strong{ETS}: an ETS model
#' \item \strong{NNETAR(K=1,2,3)}: the model fits
#' \item \strong{prophet.Linear}: a prophet model with linear trend
#' \item \strong{prophet.Logis}: a prophet model with logistic trend
#' \item \strong{Combo1}: the average of ETS and ARIMA
#' }
#' @examples
#' data(fb_returns)
#' DaysModelFitter(fb_returns, daily.returns)
#' @importFrom rlang ensym
#' @import fabletools
#' @import fable
#' @import nnet
#' @import urca
#' @import feasts
#' @importFrom tsibble tsibble
#' @importFrom magrittr %>%
#' @importFrom fable.prophet prophet
#' @importFrom dplyr mutate
#' @export
DaysModelFitter <- function(data, Outcome) {
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
          prophet.Linear = prophet(!!Outcome ~ growth(type="linear")),
          prophet.Logis = prophet(!!Outcome ~ growth(type="logistic"))
    ) %>%
    mutate(Combo1 = (ARIMA + ETS)/2)
  return(fits)
}
