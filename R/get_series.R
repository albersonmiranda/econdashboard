
# Function to get series with retries
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