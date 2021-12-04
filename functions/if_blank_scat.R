# runs through options of scatter plot inputs
# only sends input data, lets default take over if "blank"

if_blank_scat <- function(dat, x, y, c, s, j) {
  if(c != "blank"){
    if(s != "blank"){
      return(plot_scatter(dat, x, y,j, unlist(dat[c]), unlist(dat[s])))
    }else{
      return(plot_scatter(dat, x, y,j, unlist(dat[c])))
      }
  }else{
    return(plot_scatter(dat, x, y, j))
    }
}

