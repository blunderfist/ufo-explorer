
# interprets w test results, returns text

wt_conclusion <- function(filt_data){
  
  check_enough <- filt_data %>% group_by(loc) %>% count()
  
  test_error <- "Despite the results displayed in the table above there is not enough data to make a conclusion."
    
  if(is.na(check_enough$n[2])) return(test_error)  
  
  wt <- wilcox.test(I(n) ~ loc, data = filt_data)
  
  if(wt$p.value <= 0.05){
    conclusion <- "The p value is significant, the mean number of reports for each selected location are statistically different."
  }else{
    conclusion <- "The p value is not significant, the mean number of reports for each selected location are not statistically different."
  }
  
  return(conclusion)

}
