#' Function to choose optimal forecast model for monthly data
#'
#' @param data A monthly tsibble.
#' @param Outcome A valid variable name for the Outcome to be modelled in in `data`.
#' @param DateVar A valid variable name for the time index in `data`.
#' @param H.Horizon An integer for the forecast horizon/test subset of `data`.
#' @return A list containing: \itemize{
#' \item **Accuracy.Table**: `accuracy` for the forecast horizon against the test sample.
#' \item **test**: the test set
#' \item **train**: the training set
#' \item **Model.Fits**: the model fits
#' \item **Model.Forecasts**: the forecasts
#' \item **Min.Model**: the minimum model by MAE
#' \item **Min.Report**: the minimum model report
#' \item **Min.Res.Plot**: the gg_tsdisplay for the minimum model
#' \item **Min.Forecast.Plot**: a plot of the minimum forecast by MAE
#' }
#' @examples
#' data(NWSM)
#' MonthModelPicker(NWSM, MaxAvg, Month, H.Horizon=12)
#' @importFrom rlang ensym
#' @import ggplot2
#' @import distributional
#' @import tsibble
#' @import fpp3
#' @importFrom dplyr slice_max slice_min anti_join select filter
#' @import fabletools
#' @import fable
#' @importFrom feasts gg_tsresiduals
#' @importFrom magrittr %>%
#' @export
MonthModelPicker <- function(data, Outcome, DateVar, H.Horizon=14) {
  # Turn the symbols -- names that will make sense in their environments when called -- that the user supplies into symbolics.  This is the role of ensym.
  Outcome <- enquo(Outcome)
  DateVar <- ensym(DateVar)
  # Create test using H.Horizon
  test <- slice_max(data, order_by=!!DateVar, n=H.Horizon) # Create train
  train <- anti_join(data, test)
  # Estimate some models and store them as fits.
  # !! calls the variable name in the given environment
  fits <- MonthModelFitter(train, !!Outcome)
  # Forecast the models
  FC <- fits %>% forecast(h=H.Horizon)
  # Compare train and test using accuracy
  Accuracy.Table <- FC %>% accuracy(test)
  # Show the best fit
  Min.Model <- slice_min(Accuracy.Table, order_by=MAE, n=1)
  # Report on the best fitting model
#  Min.Report <- fits %>% select(.model=Min.Model$.model) %>% report()
  # Create a plot of the time series residuals for the best fit
#  Min.Res.Plot <- fits %>% select(.model=Min.Model$.model) %>% gg_tsresiduals()
  # Create a forecast plot for the best fitting model.
  #Min.ForeCPlot <- filter(FC, .model==Min.Model$.model) %>%
  #  autoplot() +
  #  autolayer(select(data, !!Outcome)) +
  #  theme_minimal() +
  #  labs(title="Winner Forecast")
  # Return a named list with all the stuff we calculated along the way.
  fit.list <- list(test=test,
                   train=train,
                   Model.Fits = fits,
                   Model.Forecasts = FC,
                   Accuracy.Table=Accuracy.Table,
                   Min.Model = Min.Model
#                   Min.Report = Min.Report,
#                   Min.Res.Plot = Min.Res.Plot,
#                   Min.Forecast.Plot = Min.ForeCPlot
                   )
  return(fit.list)
}
