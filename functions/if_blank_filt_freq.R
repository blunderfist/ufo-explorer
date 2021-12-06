# runs through options for filters
# if "All" it doesn't send a parameter so the filter_scatter function uses the entire data column
# instead of a subset

if_blank_filt_freq <- function(f_yr, f_mo, f_da, f_hr, f_du, f_sh){#} = NULL) {
  if(f_sh != "All"){
    return(filter_data_freq(f_yr, f_mo, f_da, f_hr, f_du, f_sh))
    }else{
    return(filter_data_freq(f_yr, f_mo, f_da, f_hr, f_du))
}
}