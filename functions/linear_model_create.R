# creates linear regression model to send to plot, table, and interpretation

linear_model <- function(dat, s, t){
  
  if(t == "minute"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(minute) %>% count()
    #model <- lm(n ~ minute, data = lm_data)
    }
  if(t == "hour"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(hour) %>% count()
    #model <- lm(n ~ hour, data = lm_data)
    }
  if(t == "day"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(day) %>% count()
    #model <- lm(n ~ day, data = lm_data)
    }
  if(t == "month"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(month) %>% count()
    #model <- lm(n ~ month, data = lm_data)
    }
  if(t == "year"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(year) %>% count()
    #model <- lm(n ~ year, data = lm_data)
    }

  return(lm_data)

}  

