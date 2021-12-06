
# checks and installs if missing
if (!require('shiny')) install.packages("shiny")
#if (!require('devtools')) install.packages("devtools")
if (!require('feather')) install.packages("feather")

if (!require('shinythemes')) install.packages("shinythemes")
if (!require('tidyverse')) install.packages("tidyverse")
if (!require('tools')) install.packages("tools")
if (!require('skimr')) install.packages("skimr")
if (!require('leaflet')) install.packages("leaflet")

# data source
data <- read_csv(file = "ufo_data_app.txt", col_types = cols(hour = "i", minute = "i"))

#not using this at the moment, did not reduce memory consumption or speed up
#write_feather(data, "data.feather")
#data <- read_feather("data.feather")

# function scripts
source("functions/filter_data.R")
source("functions/if_blank_filt.R")

source("functions/descriptive_stat.R")
source("functions/descriptive_statistics.R")
source("functions/if_blank_filt_desc.R")
source("functions/filter_data_desc.R")

source("functions/visualize_histogram.R")

source("functions/if_blank_scat.R")
source("functions/visualize_scatter_filters.R")

source("functions/mapping.R")

source("functions/prep_wtest.R")
source("functions/w_test_func.R")
source("functions/wt_conclusion.R")
source("functions/plot_boxplot.R")

source("functions/linear_model_create.R")
source("functions/linear_model_table.R")
source("functions/linear_model_plot_.R")
source("functions/linear_model_interpret.R")

source("functions/if_blank_filt_freq.R")
source("functions/filter_data_freq.R")
source("functions/freq_model_plot.R")
