
# interprets w test results, returns text

wt_conclusion <- function(filt_data){
  
  check_enough <- filt_data %>% group_by(loc) %>% count()
  
  test_error <- ""
    
  if(is.na(check_enough$n[2])) return(test_error)  
  
  wt <- wilcox.test(I(n) ~ loc, data = filt_data)
  
  if(wt$p.value < 0.05){
    conclusion <- "The p value is significant, reject the null hypothesis, the means are statistically different."
  }else{
    conclusion <- "The p value is not significant, retain the null hypothesis, the means are not statistically different."
  }
  
  return(conclusion)

}