# linear model for when to expect a shape based on time

linear_model_table <- function(dat, s){
  
 model <- lm(n ~ unlist(dat[, 1]), data = dat)

  model_table <- data.frame(Coefficients = c("Dependent Variable",
                                             "Independent Variable",
                                             "Intercept",
                                             "Slope"
                                             ), 
                            Values = c(toTitleCase(s),
                                       toTitleCase(names(dat[1])),
                                       round(model$coefficients[["(Intercept)"]], digits = 3),
                                       signif(model$coefficients[['unlist(dat[, 1])']], digits = 3)
                                       ))
  
  return(model_table)
}
