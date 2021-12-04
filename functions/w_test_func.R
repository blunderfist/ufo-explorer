# wilcoxon test

w_test_func <- function(filt_data){

  check_enough <- filt_data %>% group_by(loc) %>% count()

    test_error <- data.frame(Results = c("Error:",
                                           "Explanation:",
                                           "Remedy:"),
                               Values = c("Not enough data for test",
                                          "There are not enough reports for the locations/period selected",
                                          "If filtering by a time period try expanding the period"))
    
    if(is.na(check_enough$n[1]) | is.na(check_enough$n[2])) return(test_error)
    
  wt <- wilcox.test(I(n) ~ loc, data = filt_data, conf.int = T)

  test_results <- data.frame(Results = c("Method",
                                         "W",
                                         "p-value"),
                             Values = c(wt$method,
                                        wt$statistic,
                                        signif(wt$p.value, 3)))

  return(test_results)

}


