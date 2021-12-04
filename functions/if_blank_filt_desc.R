# runs through options for filters
# if "All" it doesn't send a parameter so the filter_scatter function uses the entire data column
# instead of a subset

if_blank_filt_desc <- function(f_yr, f_mo, f_da, f_hr, f_du, f_co = NULL, f_st = NULL, f_ci = NULL) {
  if(f_co != "All"){
    if(f_st != "All"){
        if(f_ci != "All"){
          return(filter_data_desc(f_yr, f_mo, f_da, f_hr, f_du, f_co, f_st, f_ci))
        }else{
            return(filter_data_desc(f_yr, f_mo, f_da, f_hr, f_du, f_co, f_st))
        }
        }else{
          return(filter_data_desc(f_yr, f_mo, f_da, f_hr, f_du, f_co))
              }
          }else{
            return(filter_data_desc(f_yr, f_mo, f_da, f_hr, f_du))
                }
}
