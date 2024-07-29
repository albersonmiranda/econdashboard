#' @description Retrieve a time series from the BCB API with retries
#' @param series_id The series ID to retrieve
#' @param max_retries The maximum number of retries to BCB API before returning an error
#' @param wait_time Time between retries in seconds
#' @param start_date The start date of the series
#' @param end_date The end date of the series
#' @return A tibble with the date and value of the series
#' @noRd
get_series_with_retries <- function(series_id, max_retries = 5, wait_time = 5, start_date = NULL, end_date = NULL) {
  retry_count <- 0
  success <- FALSE

  while (!success && retry_count < max_retries) {
    try(
      {
        serie <- rbcb::get_series(series_id, start_date = start_date, end_date = end_date)
        success <- TRUE
      },
      silent = TRUE
    )

    if (!success) {
      retry_count <- retry_count + 1
      message(paste("Attempt", retry_count, "failed. Retrying in", wait_time, "seconds..."))
      Sys.sleep(wait_time)
    }
  }

  if (!success) {
    stop("Failed to retrieve serie", series_id, "after", max_retries, "attempts.")
  }

  names(serie) <- c("date", "value")

  return(serie)
}