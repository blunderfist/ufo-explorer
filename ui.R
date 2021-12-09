# 
# Interactive Shiny App that allows users to explore UFO reports
# 

shinyUI(fluidPage(
  includeCSS("www/shiny.css"),
  theme = shinytheme("cyborg"),
    # Application title
    titlePanel(h2(class = "custom_font", "UFO Explorer")),

    # begin navigation bar
    navbarPage("Navigation",

    # First Tab: Descriptive Statistics
    navbarMenu("Descriptive Statistics",

               tabPanel(title = "Descriptive Statistics",
                        sidebarLayout(
                          sidebarPanel(
                            
                            radioButtons(inputId = "single_loc",
                                         label = "",
                                         choices = c("Single Variable" = "single",
                                                     "Location specific" = "loc_spec")),
                            
                            conditionalPanel(condition = "input.single_loc == 'single'",
                            
                            selectInput(inputId = "chosen_var",
                                        label = "Choose a variable",
                                        choices = c("All", names(data))),
                            ), #conditional panel 1
                            
                            conditionalPanel(condition = "input.single_loc == 'loc_spec'",
                            
                              selectInput(inputId = "desc_co",
                                          label = "Country",
                                          choices = c("All", levels(factor(data$country)))),
                                             
                              #updates on country filter selection
                              selectInput(inputId = "desc_st",
                                          label = "State",
                                          choices = c("All")),
                                             
                              #updates on state filter selection
                              selectInput(inputId = "desc_ci",
                                          label = "City",
                                          choices = c("All")),                                  
                                             
                            ), #conditional panel 2
                            
                            actionButton("update_desc",
                                         "Update"),
                            hr(),
                            h6("Filters"),
                           
                            sliderInput("desc_yr",
                                        label = "Years",
                                        min = min(data$year),
                                        max = max(data$year),
                                        value = c(min(data$year), max(data$year))),
                            
                            sliderInput("desc_mon",
                                        label = "Months",
                                        min = min(data$month),
                                        max = max(data$month),
                                        value = c(min(data$month), max(data$month))),
                            
                            sliderInput("desc_day",
                                        label = "Days",
                                        min = min(data$day),
                                        max = max(data$day),
                                        value = c(min(data$day), max(data$day))),
                            
                            sliderInput("desc_hr",
                                        label = "Hours",
                                        min = min(data$hour, na.rm = T),
                                        max = max(data$hour, na.rm = T),
                                        value = c(min(data$hour, na.rm = T),
                                                  max(data$hour, na.rm = T))),
                            
                            sliderInput("desc_du",
                                        label = "Duration",
                                        min = min(data$duration_s, na.rm = T),
                                        max = max(data$duration_s, na.rm = T),
                                        value = c(min(data$duration_s, na.rm = T), max(data$duration_s, na.rm = T)))
                            
                          ), #sidebar panel
                          
                  mainPanel(h4("Descriptive Statistics"),
                      tableOutput("descriptive_statistics")
                          ) # main Panel
                        ) #sidebar layout
               ), # end tab panel
                              
      # basic summary stats page
      
      tabPanel(title = "Summary Statistics",
               sidebarLayout(
                 sidebarPanel(
                   selectInput(inputId = "choose_stat",
                               label = "Choose a Variable",
                               names(data)),
                   p("Select a variable from the list above to learn more about it. 
            The summary statistics will be shown to the right.")
                 ), #sidebarPanel
                 
                 mainPanel(
                   h4(textOutput("descriptive_title")),
                           tableOutput("descriptive")) #mainPanel
               ) #sidebarLayout
      ) #tabpanel descriptive stats
      
    ), #navbar descriptive stats

    # Second Tab: Visualizations
    navbarMenu("Visualization",

               # bar chart / histogram page
               tabPanel(title = "Chart",
                        sidebarLayout(
                          sidebarPanel(
                            

                            radioButtons(inputId = "chart_type", 
                                         label = "Chart Type", 
                                         choices = c("Bar Chart", "Histogram")),

                            conditionalPanel(condition = "input.chart_type == 'Bar Chart'",
                                             
                                selectInput(inputId = "choose_barchart",
                                            label = "Choose a Variable",
                                            choices = c(names(data[-10])),
                                            selected = "year"),
                            ), # condition 1

                            conditionalPanel(condition = "input.chart_type == 'Histogram'",
                                             
                            selectInput(inputId = "choose_hist",
                                        label = "Choose a Variable",
                                        choices = c("year", "month", "day", "hour", "minute", "lat", "lng"),
                                        selected = "year"),
                            
                            sliderInput("hist_bins",
                                        "Number of bins:",
                                        min = 1,
                                        max = 120,
                                        value = 120),
                            
                            sliderInput("bin_w",
                                        "Bin Width:",
                                        min = 1,
                                        max = 60,
                                        value = 1),
                            ), # condition 2
                            
                            actionButton("update_chart",
                                         "Plot"),
                            
                            
                            hr(),
                            h6("Filters"),
                            
                            selectInput(inputId = "ch_co",
                                        label = "Country",
                                        choices = c("All", levels(factor(data$country)))),
                            
                            #updates on country filter selection
                            
                            selectInput(inputId = "ch_st",
                                        label = "State",
                                        choices = c("All")),
                            
                            selectInput(inputId = "ch_sh",
                                        label = "Shape",
                                        choices = c("All", levels(factor(data$shape)))),
                            
                            sliderInput("ch_yr",
                                        label = "Years",
                                        min = min(data$year),
                                        max = max(data$year),
                                        value = c(min(data$year), max(data$year))),
                            
                            sliderInput("ch_mon",
                                        label = "Months",
                                        min = min(data$month),
                                        max = max(data$month),
                                        value = c(min(data$month), max(data$month))),
                            
                            sliderInput("ch_day",
                                        label = "Days",
                                        min = min(data$day),
                                        max = max(data$day),
                                        value = c(min(data$day), max(data$day))),
                            
                            sliderInput("ch_hr",
                                        label = "Hours",
                                        min = min(data$hour, na.rm = T),
                                        max = max(data$hour, na.rm = T),
                                        value = c(min(data$hour, na.rm = T), max(data$hour, na.rm = T))),
                            
                            sliderInput("ch_du",
                                        label = "Duration",
                                        min = min(data$duration_s, na.rm = T),
                                        max = max(data$duration_s, na.rm = T),
                                        value = c(min(data$duration_s, na.rm = T), max(data$duration_s, na.rm = T)))
                            
                          ), #sidebar panel
                          
                          mainPanel(h4(textOutput("chart_title")),
                                    fluidRow(class = "blur",
                                             plotOutput("visualize_chart"))
                                    
                          ) #mainPanel
                        ) #sidebar layout
               ), # end tab panel histogram
               

       # Scatter plot tab
       tabPanel(title = "Scatter Plot",
                sidebarLayout(
                  sidebarPanel(
                    
                    selectInput(inputId = "x",
                                label = "Choose a Variable for X",
                                names(data), selected = "lat"),
                    selectInput(inputId = "y",
                                label = "Choose a Variable for Y",
                                names(data), selected = "lng"),
                    selectInput(inputId = "color",
                                label = "Choose a color (optional)",
                                choices = c("blank", names(data))),
                    selectInput(inputId = "size",
                                label = "Choose a size (optional)",
                                choices = c("blank", names(data))),

                    checkboxInput("jitter", "Jitter"),
                    actionButton("update_scatter",
                                 "Plot"),                    
                    hr(),
                    h6("Filters"),
                    
                    selectInput(inputId = "filter_co",
                                label = "Country",
                                choices = c("All", levels(factor(data$country)))),
                    
                    #updates on country filter selection
                    selectInput(inputId = "filter_st",
                                label = "State",
                                choices = c("All")),
                    
                    selectInput(inputId = "filter_sh",
                                label = "Shape",
                                choices = c("All", levels(factor(data$shape)))),
                    
                    sliderInput("filter_yr",
                                label = "Years",
                                min = min(data$year),
                                max = max(data$year),
                                value = c(min(data$year), max(data$year))),
                    
                    sliderInput("filter_mon",
                                label = "Months",
                                min = min(data$month),
                                max = max(data$month),
                                value = c(min(data$month), max(data$month))),
                    
                    sliderInput("filter_day",
                                label = "Days",
                                min = min(data$day),
                                max = max(data$day),
                                value = c(min(data$day), max(data$day))),
                    
                    sliderInput("filter_hr",
                                label = "Hours",
                                min = min(data$hour, na.rm = T),
                                max = max(data$hour, na.rm = T),
                                value = c(min(data$hour, na.rm = T),
                                          max(data$hour, na.rm = T))),

                    sliderInput("filter_du",
                                label = "Duration",
                                min = min(data$duration_s, na.rm = T),
                                max = max(data$duration_s, na.rm = T),
                                value = c(min(data$duration_s, na.rm = T), max(data$duration_s, na.rm = T)))
                    
                  ), #sidebar panel
       
                   mainPanel(h4("Scatter Plot"),
                          fluidRow(class = "blur",
                      plotOutput("visualize_scatter"))
                  ) #mainPanel
                ) #sidebay layout
       ), # end scatter tab
       
       
       # Map
       tabPanel("Interactive Map", h4(class = "custom_font", "Interactive Map"),

          fluidRow(
            
                column(width = 4,
                  
                  h6("Filters"),
                  sliderInput("map_year",
                              label = "Years",
                              min = min(data$year),
                              max = max(data$year),
                              value = c(min(data$year), max(data$year))),

                  sliderInput("map_month",
                              label = "Months",
                              min = min(data$month),
                              max = max(data$month),
                              value = c(min(data$month), max(data$month))),#,
                  
                  sliderInput("map_day",
                              label = "Days",
                              min = min(data$day),
                              max = max(data$day),
                              value = c(min(data$day), max(data$day)))
                  ),

                column(width = 4,

                       selectInput(inputId = "map_country",
                                   label = "Country",
                                   choices = c("All", levels(factor(data$country))),
                                   selected = "US"),

                       #updates on country filter selection
                       selectInput(inputId = "map_state",
                                   label = "State",
                                   choices = c("All"),
                                   selected = "FL"),
                       
                       selectInput(inputId = "map_shape",
                                   label = "Shape",
                                   choices = c("All", levels(factor(data$shape))))

                ),

                column(width = 4,

                       sliderInput("map_hour",
                                   label = "Hours",
                                   min = min(data$hour, na.rm = T),
                                   max = max(data$hour, na.rm = T),
                                   value = c(min(data$hour, na.rm = T),
                                             max(data$hour, na.rm = T))),
                    
                    sliderInput("map_dur",
                                label = "Duration",
                                min = min(data$duration_s, na.rm = T)/3600,
                                max = max(data$duration_s, na.rm = T)/3600,
                                value = c(min(data$duration_s, na.rm = T)/3600, max(data$duration_s, na.rm = T)/3600)),

                       actionButton(inputId = "click_map", label = "Update")
                       
                )), #fluid row
          
          br(),
          fluidRow(width = 10, offset = 1,
                   column(12, div(class = "cir_grad",
                   leafletOutput("visualize_map"))))
          
              ) #tabpanel map
            ),  # navbarMenu visualization

    # Third Tab: Statistical Analysis
    navbarMenu("Statistical Analysis",
               
    tabPanel(title = "Compare the mean number of reports between two locations",

       sidebarLayout(

        sidebarPanel(

            radioButtons(inputId = "region",
                         label = "Compare by: ",
                         choices = c(Country = "by_country",
                                     State = "by_state",
                                     City = "by_city")),
            
            conditionalPanel(condition = "input.region == 'by_country'",
                             
                             selectInput(inputId = "country1",
                                         label = "Country",
                                         choices = c(levels(factor(data$country))),
                                         selected = "US"),
                             
                             selectInput(inputId = "country2",
                                         label = "Country",
                                         choices = c(levels(factor(data$country))),
                                         selected = "CA")
                             
            ), # conditionalPanel 1
            
            conditionalPanel(condition = "input.region == 'by_state'",
                             
                             selectInput(inputId = "state1",
                                         label = "State",
                                         choices = c(levels(factor(data$state)))),
                             
                             selectInput(inputId = "state2",
                                         label = "State",
                                         choices = c(levels(factor(data$state))))
                             
            ), # conditionalPanel 2
            
            conditionalPanel(condition = "input.region == 'by_city'",

                             selectInput(inputId = "state_c1",
                                         label = "State",
                                         choices = c(levels(factor(data$state)))),
                             
                             #updates on state filter selection
                             selectInput(inputId = "city1",
                                         label = "City",
                                         choices = ""),
                             
                             selectInput(inputId = "state_c2",
                                         label = "State",
                                         choices = c(levels(factor(data$state)))),
                                                     
                             #updates on state filter selection
                             selectInput(inputId = "city2",
                                         label = "City",
                                         choices = "")
                             
            ), # conditionalPanel 3            
            
                        conditionalPanel(condition = "input.region == 'by_shape'", 
                             
                             selectInput(inputId = "desc_sh",
                                         label = "Shape",
                                         choices = c("All", levels(factor(data$shape))))#,
                             
            ), #conditional panel 2
            
            radioButtons(inputId = "yr_or_mo",
                         label = "",
                         choices = c(Year = "by_yr",
                                     Month = "by_mo")),
            
            actionButton("update_wtest",
                         "Update"),
            hr(),
            h6("Filters"),
            
            sliderInput("wt_yr",
                        label = "Years",
                        min = min(data$year),
                        max = max(data$year),
                        value = c(min(data$year), max(data$year))),
            
            sliderInput("wt_mon",
                        label = "Months",
                        min = min(data$month),
                        max = max(data$month),
                        value = c(min(data$month), max(data$month))),
            
            sliderInput("wt_day",
                        label = "Days",
                        min = min(data$day),
                        max = max(data$day),
                        value = c(min(data$day), max(data$day))),
            
            sliderInput("wt_hr",
                        label = "Hours",
                        min = min(data$hour, na.rm = T),
                        max = max(data$hour, na.rm = T),
                        value = c(min(data$hour, na.rm = T),
                                  max(data$hour, na.rm = T))),
            
            sliderInput("wt_du",
                        label = "Duration",
                        min = min(data$duration_s, na.rm = T),
                        max = max(data$duration_s, na.rm = T),
                        value = c(min(data$duration_s, na.rm = T), max(data$duration_s, na.rm = T)))
            
            ), #sidebar panel

                
        # main panel
        mainPanel(h4("Wilcoxon rank sum test"),
            
            tableOutput("wtest_results"),
            hr(),
            textOutput("wt_conc"),
            hr(),      
         checkboxInput("bp_view", "Show Box plot"),

         conditionalPanel(condition = "input.bp_view==1",
                          fluidRow(class = "blur_b",
            plotOutput("visualize_boxplot"))
         )  
            ) #mainpanel
            ) #sidebarlayout
       ), #tab panel wilcoxon rank sum test
    

    # # Linear Regression tab
    tabPanel(title = "Linear Regression",

             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = "lin_1",
                             label = "Choose a shape",
                             choices = c(levels(factor(data$shape))),
                             selected = "unknown"),

                 selectInput(inputId = "lin_2",
                             label = "Choose a unit of time",
                             choices = c("minute", "hour", "day", "month", "year"),
                             selected = "hour"),

                 actionButton(inputId = "lin_click",
                              label = "Update"),
                 hr(),
                 p("Choose a shape and a time to plot linear regression."),
                 hr(),
                 h6("Filters"),

                 selectInput(inputId = "lin_co",
                             label = "Country",
                             choices = c("All", levels(factor(data$country)))),
                 
                 # causing an error when selected, removing causes bug in country filter, leave blank for final and fix later
                 #updates on country filter selection
                 selectInput(inputId = "lin_st",
                             label = "State (not selectable)",
                             choices = c("All")),
             
                 sliderInput("lin_yr",
                             label = "Years",
                             min = min(data$year),
                             max = max(data$year),
                             value = c(min(data$year), max(data$year))),

                 sliderInput("lin_mon",
                             label = "Months",
                             min = min(data$month),
                             max = max(data$month),
                             value = c(min(data$month), max(data$month))),

                 sliderInput("lin_day",
                             label = "Days",
                             min = min(data$day),
                             max = max(data$day),
                             value = c(min(data$day), max(data$day))),

                 sliderInput("lin_hr",
                             label = "Hours",
                             min = min(data$hour, na.rm = T),
                             max = max(data$hour, na.rm = T),
                             value = c(min(data$hour, na.rm = T), max(data$hour, na.rm = T))),

                 sliderInput("lin_du",
                             label = "Duration",
                             min = min(data$duration_s, na.rm = T),
                             max = max(data$duration_s, na.rm = T),
                             value = c(min(data$duration_s, na.rm = T), max(data$duration_s, na.rm = T)))

               ), #sidebar panel
               mainPanel(h4("Linear Regression"),
                         
                         fluidRow(class = "blur_b",
                         plotOutput("linear_plot")),
                         hr(),
                         tableOutput("linear_table"),
                         hr(),
                         textOutput("interpret_linear"))
             ) #sidebarlayout
    ), #tab panel linear regression


    # Plotting frequencies of reports
    tabPanel(title = "Compare Frequency",
             
             sidebarLayout(
               sidebarPanel(

                 selectInput(inputId = "freq_st1",
                             label = "Choose a state",
                             choices = c(levels(factor(data$state))),
                             selected = "FL"),
                 
                 selectInput(inputId = "freq_st2",
                             label = "Choose a state",
                             choices = c(levels(factor(data$state))),
                             selected = "CA"),
                 
                 selectInput(inputId = "freq_st3",
                             label = "Choose a state",
                             choices = c("None", levels(factor(data$state))),
                             selected = "None"),
                 
                 selectInput(inputId = "freq_t",
                             label = "Choose a unit of time",
                             choices = c("minute", "hour", "day", "month", "year"),
                             selected = "hour"),
                 
                 actionButton(inputId = "freq_click",
                              label = "Update"),
                 
                 hr(),
                 
                 p("Choose up to three states and a time period to compare the frequency of reports."),
                 
                 hr(),
                 h6("Filters"),
                 
                 selectInput(inputId = "freq_sh",
                             label = "Shape",
                             choices = c("All", levels(factor(data$shape))),
                             selected = "All"),
                 
                 sliderInput("freq_yr",
                             label = "Years",
                             min = min(data$year),
                             max = max(data$year),
                             value = c(min(data$year), max(data$year))),
                 
                 sliderInput("freq_mon",
                             label = "Months",
                             min = min(data$month),
                             max = max(data$month),
                             value = c(min(data$month), max(data$month))),
                 
                 sliderInput("freq_day",
                             label = "Days",
                             min = min(data$day),
                             max = max(data$day),
                             value = c(min(data$day), max(data$day))),
                 
                 sliderInput("freq_hr",
                             label = "Hours",
                             min = min(data$hour, na.rm = T),
                             max = max(data$hour, na.rm = T),
                             value = c(min(data$hour, na.rm = T), max(data$hour, na.rm = T))),
                 
                 sliderInput("freq_du",
                             label = "Duration",
                             min = min(data$duration_s, na.rm = T),
                             max = max(data$duration_s, na.rm = T),
                             value = c(min(data$duration_s, na.rm = T), max(data$duration_s, na.rm = T)))
                 
               ), #sidebar panel
               mainPanel(h4("Compare frequency of reports between states"),
                         fluidRow(class = "blur_b",
                          plotOutput("freq_plot")) # fluid row
                         ) #main panel
             ) #sidebarlayout
    ) #tab panel
    ) #navmenu #3
    ) #navbar
  
) #fluidpage
) #shiny
