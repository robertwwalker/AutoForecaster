#' Function to choose optimal daily seasonal forecast model
#'
#' @param data A daily tsibble.
#' @param Outcome A valid variable name for the Outcome to be modelled in in `data`.
#' @param DateVar A valid variable name for the time index in `data`.
#' @param H.Horizon An integer for the forecast horizon/test subset of `data`.
#' @examples
#' data(SNWSDPDX)
#' DayWModelPicker(SNWSDPDX, TX, date, H.Horizon=14)
#' @importFrom rlang ensym
#' @import ggplot2
#' @importFrom dplyr slice_max slice_min anti_join select filter
#' @import fabletools
#' @import fable
#' @import distributional
#' @import tsibble
#' @import fpp3
#' @import feasts
#' @importFrom magrittr %>%
#' @return A list containing: \itemize{
#' \item \strong{Accuracy.Table}: accuracy for the forecast horizon against the test sample.
#' \item \strong{test}: the test set
#' \item \strong{train}: the training set
#' \item \strong{Model.Fits}: the model fits
#' \item \strong{Model.Forecasts}: the forecasts
#' \item \strong{Min.Model}: the minimum model by MAE
#' \item \strong{Min.Report}: the minimum model report
#' \item \strong{Min.Res.Plot NW}: the gg_tsdisplay for the minimum model
#' \item \strong{Min.Forecast.Plot NW}: a plot of the minimum forecast by MAE
#' }
#' @export
DayWModelPicker <- function(data, Outcome, DateVar, H.Horizon=14) {
  # Turn the symbols -- names that will make sense in their environments when called -- that the user supplies into symbolics.  This is the role of ensym.
  Outcome <- ensym(Outcome)
  DateVar <- ensym(DateVar)
  # Create test using H.Horizon
  test <- slice_max(data, order_by=!!DateVar, n=H.Horizon) %>% as_tsibble(index=!!DateVar) # Create train
  train <- anti_join(data, test) %>% as_tsibble(index=!!DateVar)
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
  Min.Report <- fits %>% select(Min.Model$.model) %>% report()
  # Create a plot of the time series residuals for the best fit
  Min.Res.Plot <- ( fits %>% select(Min.Model$.model) %>% gg_tsresiduals() )
  # Create a forecast plot for the best fitting model.
#  Min.ForeCPlot <- ( filter(FC, .model==Min.Model$.model) %>%
#    autoplot() +
#    autolayer(select(data, !!Outcome)) +
#    theme_minimal() +
#    labs(title="Winner Forecast") )
  # Return a named list with all the stuff we calculated along the way.
  fit.list <- list(test=test,
                   train=train,
                   Model.Fits = fits,
                   Model.Forecasts = FC,
                   Accuracy.Table=Accuracy.Table,
                   Min.Model = Min.Model,
                   Min.Report = Min.Report,
                   Min.Res.Plot = Min.Res.Plot
#                   Forecast.Plot = Min.ForeCPlot
                   )
  return(fit.list)
}
