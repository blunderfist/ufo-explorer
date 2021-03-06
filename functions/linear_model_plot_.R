# linear model for when to expect a shape based on time

linear_model_plot <- function(dat, s, t){
  
  p <- ggplot(dat, aes(x = dat[[1]], y = n)) +
    geom_point() +
    geom_smooth(method = "lm", se = F, size = 1.5) +
    theme_dark() +
    theme(plot.background = element_rect(fill = "#c1f9ea", 
                                         color = "#c1f9ea"),
          plot.title = element_text(hjust = 0.5),
          plot.subtitle = element_text(hjust = 0.5)) +
    scale_x_continuous(breaks = seq(1, max(dat[[1]]), by = 2)) +
    labs(title = "Simple Linear Regression",
         subtitle = paste(toTitleCase(s), "~", t),
         x = toTitleCase(t),
         y = paste("Frequency of", toTitleCase(s)))
  return(p)
}
