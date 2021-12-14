# UFO Explorer

---

## Table of Contents

1. [Abstract](https://github.com/blunderfist/ufo-explorer/blob/main/README.md#abstract)
2. [How to get started](https://github.com/blunderfist/ufo-explorer/blob/main/README.md#how-to-start-the-software)
3. [Requirements](https://github.com/blunderfist/ufo-explorer/blob/main/README.md#requirements)
4. [Features](https://github.com/blunderfist/ufo-explorer/blob/main/README.md#features)
5. [Descriptive Statistics](https://github.com/blunderfist/ufo-explorer/blob/main/README.md#tab-1-descriptive-statistics)
6. [Visualization](https://github.com/blunderfist/ufo-explorer/blob/main/README.md#tab-2-visualization)
7. [Statistical Analysis](https://github.com/blunderfist/ufo-explorer/blob/main/README.md#tab-3-statistical-analysis)
8. [Tutorial](https://github.com/blunderfist/ufo-explorer/blob/main/README.md#tutorial)

---

## Abstract


UFO Explorer is an interactive web based app that allows users to browse data from reported UFO sightings in North America. The data used for this project is a subset of the original data source, available at [my Kaggle page](https://www.kaggle.com/blunderfist/ufo-sightings). It was scraped from the [National UFO Reporting Center website](http://www.nuforc.org) using [this code](https://github.com/blunderfist/py-ufo-scrape). The [UFO.Rmd](https://github.com/blunderfist/ufo-explorer/blob/main/ufo.rmd) file shows the steps taken to obtain the final version of the data file.

---


## How to start the software

---

### Requirements

 - R 4.0.1 or later
 - Shiny 1.2.0 or later
 - Open R and run the code below

If R is installed and you wish to run on your computer, copy the code chunk below and paste into R terminal.

Note: Some users have reported receiving an error the first time they run this code chunk, but have had success by simply running it again. If you get an error please just rerun the code.

```{r}
#install.packages("shiny")
library(shiny)
shiny::runGitHub("ufo-explorer", "blunderfist", ref = "main")
```

Or visit <https://matt2021.shinyapps.io/UFO-Explorer/> to access the app via the web. (This option is currently only using data from 2011 to 2021 due to the memory limitations of the free service plan.)

## Features

The following explains the features found in the app and how they work. This only a brief description, for more detailed information please see the [tutorial](https://github.com/blunderfist/ufo-explorer/blob/main/UFO-Explorer%20Tutorial.pdf).

---


## Tab 1: Descriptive Statistics

### Descriptive Statistics

Displays interesting descriptive statistics for each variable. User can select a single variable, or a specific location. Information displayed will vary based on chosen variable. Filters can be applied to limit results.

### Summary Statistics

Simple summary statistics for each variable in the data set.

---


## Tab 2: Visualization


### Chart

---

### Bar Chart

Displays a bar char showing selected variable. Filters can be applied.


### Histogram

Displays a histogram showing selected variable. Can only select continuous variables. Filters can be applied.


### Scatter Plot

Displays a scatter plot for selected variables. Additional options include using colors and size to aid in categorizing variables on the plot. Filters can be applied.


### Interactive Map

Displays a map showing blue points for the location of each report. Overlap can be a problem and filters should be used to improve readability.

---


## Tab 3: Statistical Analysis

### Wilcoxon Rank Sum Test

Allows user to compare the amount of reports between two geographic locations. Uses Wilcoxon Rank Sum test because a t test would not be appropriate. Filters can be applied.


### Simple Linear Regression

Displays a linear regression plot, model, and simple interpretation for a selected time period and reported shape. Filters can be applied.


### Comparing Frequencies of Reports

Shows the frequency of reports between either two or three states over a given time period.

---


## Tutorial

---


For more in depth usage information the tutorial for UFO Explorer can be downloaded at <https://github.com/blunderfist/ufo-explorer/blob/main/UFO-Explorer%20Tutorial.pdf>


