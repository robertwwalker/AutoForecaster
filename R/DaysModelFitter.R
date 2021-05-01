#' Function to estimate daily time series models
#'
#' @param data A tsibble.
#' @param Outcome A valid expression for the Outcome to be modelled in in `data`.
#' @return A mable containing: \itemize{
#' \item \strong{K=1,2,3}: ARIMA models with fourier(K=1,2,3)
#' \item \strong{ARIMA}: an ARIMA model
#' \item \strong{ARIMA.T}: an ARIMA model with trend
#' \item \strong{ETS}: an ETS model
#' \item \strong{NNETAR}: the model fits from NNETAR with 30 networks
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
  Outcome <- enexpr(Outcome)
  fits <- data %>% as_tsibble() %>%
    model(ARIMA = ARIMA(!!Outcome),
          ARIMA.T = ARIMA(!!Outcome ~ trend()),
          ETS = ETS(!!Outcome),
          NNET1 = NNETAR(!!Outcome, n_networks =  30)
 #         prophet.Linear = prophet(!!Outcome ~ growth(type="linear", origin=1))
    ) %>%
    mutate(Combo1 = (ARIMA + ETS)/2)
  return(fits)
}
