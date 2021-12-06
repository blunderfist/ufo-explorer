# creates box plot for wilcoxon test

plot_boxplot <- function(filt_dat){
  
bp <- ggplot(filt_dat, aes(x = loc, y = n)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot(color = "#1637fa",
               fill = "#9bf6ea",
               alpha = 0.5) +
  labs(title = "Distributions for selected locations",
       x = "Location",
       y = "Number of Reports") +
  theme_dark() +
  theme(plot.title = element_text(hjust = 0.5))

return(bp)

}