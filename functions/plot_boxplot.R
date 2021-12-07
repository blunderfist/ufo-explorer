# creates box plot for wilcoxon test

plot_boxplot <- function(filt_dat){
  
bp <- ggplot(filt_dat, aes(x = loc, y = n)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot(color = "#9b068b",
               fill = "#ed94ec",
               alpha = 0.5) +
  labs(title = "Distributions for selected locations",
       x = "Location",
       y = "Number of Reports") +
  theme_dark() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.background = element_rect(fill = "#c1f9ea", 
                                       color = "#c1f9ea"))

return(bp)

}