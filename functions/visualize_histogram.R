
# returns histogram based on user inputs

plot_histogram <- function(dat, x_var, b, binw){
  
  h <- ggplot(dat, aes(x = unlist(dat[x_var]))) +
    geom_histogram(stat = "count",
                   bins = b, 
                   binwidth = binw, 
                   fill = "#1fde55", 
                   color = "#1fde2e", 
                   alpha = 0.5) +
    labs(title = paste("Histogram of", x_var), 
         subtitle = paste(b, "bins,", "bin width =", binw),
         x = toTitleCase(x_var),
         y = "Frequency of reports") +
    theme_dark() +
    theme(plot.title = element_text(hjust = 0.5),
          plot.subtitle = element_text(hjust = 0.5),
             axis.text.x = element_text(angle = 90))
    
  return(h)
}
