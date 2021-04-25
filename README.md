# AutoForecaster

AutoForecaster is an R package to automate the production of a collection of time series models applied to `tsibble` data structures defined by `index` and `key`.

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