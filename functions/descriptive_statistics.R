# descriptive stats for variables
# determines input variable and returns corresponding table of stats
# dat = filtered data, selected_var = variable to create table for
# single = single variable if 1, location specific if 0
# geo_lev = 1 == country, 2 == state, 3 == city

show_desc <- function(dat, selected_var, single, geo_lev){
  
  avg <- 1
  loc <- c("country", "state", "city", "lat", "lng")
  time <- c("year", "month", "day", "hour", "minute", "duration_s")
  
  #total_data required for per_of_northam because filter operation was removing NA values and throwing off calculation
  total_data <- data %>% filter(hour %in% min(hour,na.rm=T):max(hour, na.rm = T), 
                                minute %in% min(minute,na.rm=T):max(minute, na.rm=T), 
                                duration_s %in% min(duration_s,na.rm=T):max(duration_s,na.rm=T))
  
  num_reports <- nrow(dat) 
  per_of_northam <- round((num_reports / nrow(total_data)) * 100, digits = 3)
  yr_denom <- (max(dat$year) - min(dat$year))
  if(yr_denom == 0) yr_denom <- 1 # required to prevent div/0
  yr_avg <- signif(nrow(dat) / yr_denom, 4) 
  mo_avg <- signif(yr_avg / 12, digits = 3)
  wk_avg <- signif(yr_avg / 52, digits = 3)
  da_avg <- signif(yr_avg / 365, digits = 3)
  hr_avg <- signif(da_avg / 24, digits = 2)
  mi_avg <- signif(hr_avg / 60, digits = 2)
  du_avg <- signif((sum(dat$duration_s, na.rm = T))/60 / nrow(dat), digits = 1)
  du_med <- round(median(dat$duration_s, na.rm = T) / 60, digits = 2)
  most_frq <- as.data.frame(dat %>% count(shape) %>% arrange(desc(n)))
  least_frq <- as.data.frame(dat %>% count(shape) %>% arrange((n)))
  loc_most <- as.data.frame(dat %>% select(state, shape) %>% count(state, shape = most_frq[1,1]) %>% arrange(desc(n)))
  loc_least <- as.data.frame(loc_most %>% arrange(n))
  
  if(selected_var == "year"){ 
    avg <- yr_avg
    least <- dat %>% count(year) %>% arrange(n)
  }
  if(selected_var == "month"){
    avg <- mo_avg
    least <- dat %>% count(month) %>% arrange(n)
  }
  if(selected_var == "day"){
    avg <- da_avg
    least <- dat %>% count(day) %>% arrange(n)
  }
  if(selected_var == "hour"){
    avg <- hr_avg
    least <- dat %>% count(hour) %>% arrange(n)
  }
  if(selected_var == "minute"){
    avg <- mi_avg
    least <- dat %>% count(minute) %>% arrange(n)
  }
  if(selected_var == "duration_s"){
    avg <- du_avg
    least <- dat %>% count(duration_s) %>% arrange(n)
  }
  
  # least <- as.data.frame(least)
  # most <- as.data.frame(least %>% arrange(desc(n)))

  if(avg == 0) avg <- 1
  
  avg <- signif(avg, digits = 3)

if(single == 1){
if(!selected_var == "All"){
  if(!selected_var %in% loc){
    if(!selected_var %in% time){ #shape
      var_table <- data.frame(Statistic = c("Variable",
                                          "Most frequent UFO shape",
                                          paste("Count of most frequent UFO shape", " (",most_frq[1,1],")", sep =),
                                          "Percent of reports",
                                          "State most frequent is most often reported",
                                          "Least frequent UFO shape",
                                          paste("Count of least frequent UFO shape", " (",least_frq[1,1],")", sep =),
                                          "Percent of reports",
                                          "Location least frequent is most often reported"),
                              Value = c(toTitleCase(selected_var), 
                                        toTitleCase(most_frq[1,1]),
                                        most_frq[1,2],
                                        paste(round((most_frq[1,2]/num_reports)*100, digits = 2), "%", sep = ""),
                                        loc_most[1,1],
                                        toTitleCase(least_frq[1,1]),
                                        least_frq[1,2],
                                        paste(round((least_frq[1,2]/num_reports)*100, digits = 6), "%", sep = ""),
                                        loc_least[1,1])
    )
      return(var_table)
      
  }else{ #time
    
    least <- as.data.frame(least)
    most <- as.data.frame(least %>% arrange(desc(n)))
    
    if(!selected_var == "duration_s"){
      
    var_table <- data.frame(Statistic = c("Variable",
                                          paste("Avg reports per", selected_var),
                                          paste(toTitleCase(selected_var), "with most reports"),
                                          paste(toTitleCase(selected_var), "with least reports"),
                                          "Median duration (mins)",
                                          "Most frequent UFO shape",
                                          paste("Count of most frequent UFO shape", " (",most_frq[1,1],")", sep =),
                                          "Least frequent UFO shape",
                                          paste("Count of least frequent UFO shape", " (",least_frq[1,1],")", sep =)),
                              Value = c(toTitleCase(selected_var), 
                                      avg, 
                                      paste(most[1,1], " (",most[1,2],")", sep = ""),
                                      paste(least[1,1], " (",least[1,2],")", sep = ""),
                                      du_med, 
                                      toTitleCase(most_frq[1,1]),
                                      most_frq[1,2],
                                      toTitleCase(least_frq[1,1]),
                                      least_frq[1,2])
    )
    return(var_table)

    }else{ #duration
     
      shortest_state <- as.data.frame(dat %>% select(state, duration_s)) %>% arrange(duration_s)
      longest_state <- as.data.frame(shortest_state %>% arrange(desc(duration_s)))
      shortest_shape <- as.data.frame(dat %>% select(shape, duration_s)) %>% arrange(duration_s)
      longest_shape <- as.data.frame(shortest_shape %>% arrange(desc(duration_s)))

      var_table <- data.frame(Statistic = c("Variable",
                                            "Avg duration (mins)",
                                            "Median duration (mins)",
                                            "State with longest duration",
                                            "State with shortest duration",
                                            "UFO shape with longest duration",
                                            "UFO shape with shortest duration"),
                              Value = c(toTitleCase(selected_var), 
                                        signif(mean(dat$duration_s/60), digits = 2), 
                                        du_med, 
                                        longest_state[1,1],
                                        shortest_state[1,1],
                                        toTitleCase(longest_shape[1,1]),
                                        toTitleCase(shortest_shape[1,1]))
      )
      
      return(var_table)

    }
  }}else{ # location general
    
    if(selected_var == "country"){
      least <- as.data.frame(dat %>% count(country) %>% arrange(n) %>% select(country, n))
      most <- as.data.frame(least %>% arrange(desc(n)))
    }
    if(selected_var == "state"){
      least <- as.data.frame(dat %>% count(country, state) %>% arrange(n) %>% select(state, n))
      most <- as.data.frame(least %>% arrange(desc(n)))
    }
    if(selected_var == "city"){
      least <- as.data.frame(dat %>% count(country, state, city) %>% arrange(n) %>% select(city, n))
      most <- as.data.frame(least %>% arrange(desc(n)))
    }
    if(selected_var == "lat"){
      least <- as.data.frame(dat %>% count(lat) %>% select(lat, n)) %>% arrange(n)  
      most <- as.data.frame(least %>% arrange(desc(n)))
      }
    if(selected_var == "lng"){
      least <- as.data.frame(dat %>% count(lng) %>% select(lng, n)) %>% arrange(n)
      most <- as.data.frame(least %>% arrange(desc(n)))
    }
      
      var_table <- data.frame(Statistic = c("Variable",
                                            paste(toTitleCase(selected_var), "with most reports"),
                                            paste(toTitleCase(selected_var), "with least reports"),
                                            "Median duration (mins)",
                                            "Most frequent UFO shape reported",
                                            paste("Count of most frequent UFO shape", " (",most_frq[1,1],")", sep =),
                                            "Least frequent UFO shape reported",
                                            paste("Count of least frequent UFO shape", " (",least_frq[1,1],")", sep =)),
                              Value = c(selected_var,
                                        most[1,1], least[1,1],
                                        du_med,
                                        most_frq[1,1], most_frq[1,2],
                                        least_frq[1,1], least_frq[1,2])
      )
      return(var_table)
    
  }}else{ #"All"
      var_table <- data.frame(Statistic = c("Variable",
                                            "Avg reports per year",
                                            "Avg reports per month",
                                            "Avg reports per week",
                                            "Avg reports per day",
                                            "Avg reports per hour",
                                            "Avg reports per minute",
                                            "State with most reports",
                                            "State with least reports",
                                            "Most frequent UFO shape",
                                            paste("Count of most frequent UFO shape", " (",most_frq[1,1],")", sep =),
                                            "Percent of reports",
                                            "State most frequent is most often reported",
                                            "Least frequent UFO shape",
                                            paste("Count of least frequent UFO shape", " (",least_frq[1,1],")", sep =),
                                            "Percent of reports",
                                            "Location least frequent is most often reported"),
                              Value = c(selected_var,
                                        round(yr_avg, 2), round(mo_avg, 2), signif(wk_avg, 4), signif(da_avg, 4), signif(hr_avg, 4), signif(mi_avg, 4),
                                        loc_most[1,1], loc_least[1,1],
                                        toTitleCase(most_frq[1,1]),
                                        most_frq[1,2],
                                        paste(round((most_frq[1,2]/num_reports)*100, digits = 2), "%", sep = ""),
                                        loc_most[1,1],
                                        toTitleCase(least_frq[1,1]),
                                        least_frq[1,2],
                                        paste(round((least_frq[1,2]/num_reports)*100, digits = 6), "%", sep = ""),
                                        loc_least[1,1])
      )
      return(var_table)
      
  }
  }else{ #loc specific single != 1
    
    loc_lev <- c("Country", "State", "City")
    
    if(geo_lev == 3){
#      loc_lev <- "city"
      var_table <- data.frame(Statistic = c(loc_lev[geo_lev],
                                            "Number of reports",
                                            "Percent of North American reports",
                                            "Yearly Avg reports for location",
                                            "Monthly Avg reports for location",
                                            "Weekly Avg reports for location",
                                            "Daily Avg reports for location",
                                            "Median duration (mins)",
                                            "Most frequent UFO shape reported",
                                            paste("Count of most frequent UFO shape", " (",most_frq[1,1],")", sep =),
                                            "Least frequent UFO shape reported",
                                            paste("Count of least frequent UFO shape", " (",least_frq[1,1],")", sep =)),
                              Value = c(toTitleCase(selected_var),
                                        num_reports,
                                        paste(per_of_northam, "%", sep = ""),
                                        round(yr_avg, digits = 1), mo_avg, wk_avg, da_avg,
                                        du_med,
                                        most_frq[1,1], most_frq[1,2],
                                        least_frq[1,1], least_frq[1,2]))
      return(var_table)
      
    }     
    
    if(geo_lev == 1 & selected_var == "All"){
      least <- as.data.frame(dat %>% count(country) %>% arrange(n))
      most <- as.data.frame(least %>% arrange(desc(n)))
    }
    if(geo_lev == 1 & selected_var != "All"){
      least <- as.data.frame(dat %>% count(country, state) %>% arrange(n) %>% select(state, n))
      most <- as.data.frame(least %>% arrange(desc(n)))      
    }     
      if(geo_lev == 2 ){
        least <- as.data.frame(dat %>% count(country, state, city) %>% arrange(n) %>% select(city, n))
        most <- as.data.frame(least %>% arrange(desc(n)))
      }
      var_table <- data.frame(Statistic = c(loc_lev[geo_lev],
                                            "Number of reports",
                                            "Percent of North American reports",
                                            "Yearly Avg reports for location",
                                            "Monthly Avg reports for location",
                                            "Weekly Avg reports for location",
                                            "Daily Avg reports for location",
                                            paste(toTitleCase(loc_lev[geo_lev+1]), "with most reports"),
                                            paste(toTitleCase(loc_lev[geo_lev+1]), "with least reports"),
                                            "Median duration (mins)",
                                            "Most frequent UFO shape reported",
                                            paste("Count of most frequent UFO shape", " (",most_frq[1,1],")", sep =),
                                            "Least frequent UFO shape reported",
                                            paste("Count of least frequent UFO shape", " (",least_frq[1,1],")", sep =)),
                                Value = c(toTitleCase(selected_var),
                                        num_reports,
                                        paste(per_of_northam, "%", sep = ""),
                                        round(yr_avg, digits = 1), mo_avg, wk_avg, da_avg,
                                        paste(toTitleCase(most[1,1]), " (",most[1,2],")", sep = ""), 
                                        paste(toTitleCase(least[1,1]), " (",least[1,2],")", sep = ""),
                                        du_med,
                                        toTitleCase(most_frq[1,1]), most_frq[1,2],
                                        toTitleCase(least_frq[1,1]), least_frq[1,2]))
 
      return(var_table)
      }
} #end function

