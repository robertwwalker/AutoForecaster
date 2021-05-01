#' Time-series cross-section summaries in R
#' \code{xtsum2} returns three datasets for cross-sectional time series tsibble.
#'
#' @param data A tibble with clean time and unit(key) indices.
#' @param key.var The unit/(key) index.
#' @return a list containing three named elements: Between, Within, and Combined.
#' @examples
#' data(FANG)
#' xtsum2(FANG, key.var=symbol)
#' @import tsibble
#' @importFrom stats sd terms
#' @import dplyr
#' @importFrom purrr map_dfr
#' @importFrom janitor tabyl
#' @importFrom magrittr %>%
#' @export
xtsum2 <- function(data, key.var) {
  data <- data
  key.var <- ensym(key.var)
  Between <- data %>% 
    group_by(!! key.var) %>% 
    select_if(function(x) { 
      is.numeric(x) | is.integer(x) 
      }) %>% 
    summarise(across(.cols = everything(), 
                     mean, na.rm=TRUE, 
                     .names = "B.{.col}")) 
  Within <- data %>% 
    group_by(!! key.var) %>% 
    select_if(function(x) { 
      is.numeric(x) | is.integer(x) 
      }) %>% 
    mutate(across(.cols=everything(), 
                  ~scale(.x, scale=FALSE)[,1], 
                  .names = "W.{.col}")) %>% ungroup() 
  Combined <- left_join(left_join(data, Within), Between)
  return(list(Between=Between, Within=Within, Combined=Combined))
}
