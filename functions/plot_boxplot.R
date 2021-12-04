# creates box plot for wilcoxon test

plot_boxplot <- function(filt_dat){
  
bp <- ggplot(filt_dat, aes(x = loc, y = n)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  labs(title = "Distributions for selected locations",
       x = "Location",
       y = "Number of Reports") +
  theme_dark()

return(bp)

}