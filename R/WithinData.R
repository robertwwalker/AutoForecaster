#' WithinData: A function to create time-series cross-section between data
#'
#' @param data A time series cross-section dataset.
#' @param formula A one sided formula with units on the left hand side; (key ~ .) 
#' @return data.frame A tibble with within data
#' @examples
#' data(FANG)
#' WithinData(symbol ~ ., data=FANG)
#' @import rlang
#' @import tsibble
#' @importFrom stats sd terms
#' @import dplyr
#' @importFrom purrr map_dfr
#' @importFrom janitor tabyl
#' @importFrom magrittr %>%
#' @export
WithinData <- function(formula, data) {
  pform <- terms(formula, data=data)
  # unit captures the lhs of the formula
  unit <- pform[[2]]
  # grab 
  vars <- attr(pform, "term.labels")
  # Add data.frame to strip other attributes.
  data <- data.frame(data)
  # Get classes of the variables
  cls <- sapply(data, class)
  # 8.18.2020 adapted the below line to handle factors and characters by selecting unit
  newdata <- data %>% select(which(cls %in% c("numeric","integer")),unit)
  # Get the variable names to summarise
  varnames <- intersect(names(newdata),vars)
  # The actual summary function for some variable
  sumfunc <- function(data=data, varname, unit) {
    loc.unit <- enquo(unit)
    varname <- ensym(varname)
    wdata <- data %>% 
      filter(!is.na(!! varname)==TRUE) %>% 
      group_by(!! loc.unit) %>% 
      mutate("W.{{ varname }}" := `$`(.data, !! varname) - mean(`$`(.data, !! varname), na.rm=T)) %>% 
      ungroup()
    return(wdata)
  }
  res1 <- map_dfc(varnames, function(x) {sumfunc(data, !!x, !!unit)}) %>% data.frame() %>% select(1:7,starts_with("W."))
#  rownames(res1) <- varnames
  #    Result=data.frame(t(res1)))
  return(res1)
}