# filters data for functions

filter_data_desc <- function(f_yr = data$year, 
                             f_mo = data$month,
                             f_da = data$day,
                             f_hr = data$hour,
                             f_du = data$duration_s,
                             f_co = data$country,
                             f_st = data$state,
                             f_ci = data$city){
  
  filt <- data %>% 
    filter(country == f_co,
           state == f_st,
           city == f_ci,
           year %in% f_yr[1]:f_yr[2],
           month %in% f_mo[1]:f_mo[2],
           day %in% f_da[1]:f_da[2],
           hour %in% f_hr[1]:f_hr[2],
           duration_s %in% f_du[1]:f_du[2])
  
  return(filt)

}
