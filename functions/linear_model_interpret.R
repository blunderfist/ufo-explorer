# linear regression interpretation

linear_interpret <- function(dat, s, t){
  
  model <- lm(n ~ unlist(dat[, 1]), data = dat)
  slope = round(model$coefficients[['unlist(dat[, 1])']], 2)
  
  time_span <- switch (t,
    "minute" = "hour",
    "hour" = "day",
    "day" = "month",
    "month" = "year",
    "year" = "yearly period"
  )

  if(slope > 0){ 
    direction <- "increases"
      }else direction <- "decreases" 
  
  results <- paste("Based on this model, using the selected filters, 
                   the number of UFO reports for a given ", time_span, 
                   " involving shapes described as ", s, 
                   ", ", direction, "on average, by ", slope, 
                   " for every one ", t, " increase.", sep = " ")

  return(results)
  
}