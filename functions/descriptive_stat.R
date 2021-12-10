
# returns a data frame showing descriptive stats
# uses skimr to prep stats, then pulls from and creates new df

descriptive_stat <- function(choose_stats){

  #data <- read_csv(file = "ufo_data_app.txt")
  
  skimmed <- skim(choose_stats)
  skim_results <- data.frame(skimmed)
  
  dat <- skim_results[,"skim_type"]
  ct <- sum(!is.na(choose_stats))
  mct <- skim_results[,"n_missing"]
  pc <- paste(round(skim_results[,"complete_rate"], digits = 2) * 100, "%", sep = "")
  
    if(skim_results[1, 1] == "numeric"){
      mn <- skim_results[,"numeric.p0"]
     qt1 <- skim_results[,"numeric.p25"]
     avg <- round(skim_results[,"numeric.mean"], digits = 2)
     med <- skim_results[,"numeric.p50"]
     qt3 <- skim_results[,"numeric.p75"]
      mx <- skim_results[,"numeric.p100"]
      rg <- mx - mn
   stdev <- round(skim_results[,"numeric.sd"], digits = 2)
    type <- "Continuous"
   
    results <- data.frame(Statistic = c("Data",
                                        "Type", 
                                        "Min",
                                        "1st Quartile",
                                        "Median",
                                        "3rd Quartile",
                                        "Max",
                                        "Range",
                                        "Mean",
                                        "Std Dev",
                                        "Count",
                                        "Missing Count",
                                        "% Complete"), 
                        Value = c(toTitleCase(dat), type, mn, qt1, med, qt3, mx, rg, avg, stdev, ct, mct, pc))
  
  }else{
    if(skim_results[1, 1] == "character"){
      mn <- skim_results[,"character.min"]
      uniq <- skim_results[,"character.n_unique"]
        mx <- skim_results[,"character.max"]
       emp <- skim_results[,"character.empty"]
      type <- "Categorical"
       
      results <- data.frame(Statistic = c("Data",
                                          "Type",
                                          "Unique Values",
                                          "Min Character Length",
                                          "Max Character Length",
                                          "Empty Characters",
                                          "Count",
                                          "Missing Count",
                                          "% Complete"), 
                            Value = c(toTitleCase(dat), type, uniq, mn, mx, emp, ct, mct, pc))
      }
    }

    return(results)
  
}
