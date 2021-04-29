# AutoForecaster

AutoForecaster is an R package to automate the production of a collection of time series models applied to `tsibble` data structures defined by `index` and `key`.  It also provides some basic functions for working with `tsibble` data structures as cross-sectional time series or panel data.

[The pkgdown site](https://robertwwalker.github.io/AutoForecaster) and the [main github development page](https://github.com/robertwwalker/AutoForecaster/).

## Installation

```
# Install development version from GitHub
devtools::install_github("robertwwalker/AutoForecaster")
```

## Usage

```
library(AutoForecaster)
```

The package contains four (current) forecasting functions.

```
DayWModelPicker(data, Outcome, index, H.Horizon=14)
MonthModelPicker(data, Outcome, index, H.Horizon=12)
DaysModelPicker(data, Outcome, index, H.Horizon=14)
QuarterModelPicker(data, Outcome, index, H.Horizon=12)
```

supported by

```
DayWModelFitter(data, Outcome)
MonthModelFitter(data, Outcome)
DaysModelFitter(data, Outcome)
QuarterModelFitter(data, Outcome)
```

that fits the models.

## WithinData

Creates within data for all numeric and integer variables in a `tsibble`.

## BetweenData

Creates between data for all numeric and integer variables in a `tsibble`.

## xtsum

A function that creates a cross-sectional time series summary of numeric and integer data in a `tsibble`.

## TradingDayCreator

A function to take a `tsibble` of tidyquant equities data, possibly starting at different times, and computing a `trading_day` index for a revised `tsibble`.