
# returns histogram based on user inputs

plot_barchart <- function(dat, x_var){
  
  b <- ggplot(dat, aes(x = unlist(dat[x_var]))) +
    geom_bar(stat = "count", 
                   fill = "#7db4f1", 
                   color = "#358ef0", 
                   alpha = 0.5) +
    labs(title = paste("Bar chart of", x_var),
         x = toTitleCase(x_var),
         y = "Count of reports") +
    theme_dark() +
    theme(plot.title = element_text(hjust = 0.5),
             axis.text.x = element_text(angle = 90))
    
  return(b)
}
