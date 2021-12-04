# creates scatter plot based on user input from Shiny app
# takes filtered data from filters function and scatter plot inputs

plot_scatter <- function(filt_dat, x, y,jit=F, c = NULL, s = NULL){

  sc_plot  <- ggplot(filt_dat, aes(x = unlist(filt_dat[x]), y = unlist(filt_dat[y]), color = c, size = s)) +
    geom_point() +
    labs(title = paste("Scatterplot of", x, "and", y),
         x = toTitleCase(x),
         y = y,
         color = c,
         size = s) +
    theme_dark() +
    theme(plot.title = element_text(), axis.text.x = element_text(angle = 90))
  
  if(jit == F){
    return(sc_plot)
  }else{
  return(sc_plot + geom_jitter())
}
}
