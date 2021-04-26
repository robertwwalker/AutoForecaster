#' Function to create trading days/weeks from a tsibble/grouped tsibble
#'
#' @param data A tidyquant daily OHLC tibble.
#' @param DateVar A time index for the tsibble.
#' @param key The key for the tsibble supplied.
#' @return A tsibble indexed by trading_day.  The function will also work with generic messy time units such as weeks.
#' @examples
#' data(FANG)
#' TradingDayCreator(FANG, DateVar=date, key=symbol)
#' @import tsibble
#' @import dplyr
#' @importFrom janitor tabyl
#' @importFrom magrittr %>%
#' @export
TradingDayCreator <- function(data, DateVar, key) {
  data <- data
  DateVar <- ensym(DateVar)
  key <- ensym(key)
  Stocks.to.Return <- left_join(
    as_tibble(data), 
    (left_join((data %>% 
            as_tibble() %>%
            tabyl(!! key) %>%
            slice_max(order_by = n, n = 1, with_ties = FALSE) %>%
            select(!! key)), data) %>% 
    mutate(trading_day = row_number()) %>% 
    select(!!DateVar, trading_day))) %>% 
    as_tsibble(index=trading_day, key=!! key, regular=TRUE)
return(Stocks.to.Return)
}
