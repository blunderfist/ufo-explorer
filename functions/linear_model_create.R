# creates linear regression model to send to plot, table, and interpretation

linear_model <- function(dat, s, t){
  
  if(t == "minute"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(minute) %>% count()
    }
  if(t == "hour"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(hour) %>% count()
    }
  if(t == "day"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(day) %>% count()
    }
  if(t == "month"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(month) %>% count()
    }
  if(t == "year"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(year) %>% count()
    }

  return(lm_data)

}  

