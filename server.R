
shinyServer <- function(input, output, session) {

  ######## Descriptive Statistics ########
  
  data_desc <- eventReactive(input$clicks, {
    input$single_loc
    input$chosen_var
    input$desc_co
    input$desc_st
    input$desc_ci
    input$desc_sh
    input$desc_yr
    input$desc_mon
    input$desc_day
    input$desc_du
  })
  
  
  #updates descriptive stats on clicking action button update_desc
  update_stats <- function(){
    if(!input$update_desc){
      return(isolate({output$descriptive_statistics}))
    }else{
      return(output$descriptive_statistics)
    }
  }
  
  
  output$descriptive_statistics <- renderTable({
    input$update_desc
    
    isolate(
      #returns filtered data for desc stats
      desc_data <- if_blank_filt_desc(input$desc_yr,
                                      input$desc_mon,
                                      input$desc_day,
                                      input$desc_hr,
                                      input$desc_du,
                                      input$desc_co,
                                      input$desc_st,
                                      input$desc_ci
      )) 

    isolate(
    if(input$single_loc == 'single') single <- 1 else single <- 0)
    isolate(
    if(single == 1){
      select_var <- input$chosen_var
    }else{
      if(input$desc_co != "All"){
        if(input$desc_st != "All"){
          if(input$desc_ci != "All"){
            select_var <- input$desc_ci # if city selected use city as input
            geo_lev <- 3
          }else{
            select_var <- input$desc_st # if city "All" use state as input
            geo_lev <- 2
          }}else{
            select_var <- input$desc_co # if state "All" and use country as input
            geo_lev <- 1
            }
        }else{
          select_var <- input$desc_co # if country selected and no state use country as input
          geo_lev <- 1
          }
      })
      
    isolate(show_desc(desc_data, select_var, single, geo_lev))
  })
  
  # updates state selection after choosing country
  observe({
    descr_co <- input$desc_co
    if (is.null(descr_co))
      descr_co <- character(0)
    updateSelectInput(session, "desc_st",
                      label = "State",
                      choices = c("All", levels(factor(data$state[data$country == input$desc_co]))),
                      selected = "All"
    )
  })
  
  # updates city selection after choosing state
  observe({
    descr_st <- input$desc_st
    if (is.null(descr_st))
      descr_st <- character(0)
    updateSelectInput(session, "desc_ci",
                      label = "City",
                      choices = c("All", levels(factor(data$city[data$state == input$desc_st]))),
                      selected = "All"
    )
  })
  
  # print selection on page
  output$descriptive_title <- renderText({
    toTitleCase(input$choose_stat)
  })
  
  ######## Histogram ########
  
  #updates histogram on clicking action button update_hist
  update_histogram <- function(){
    if(!input$update_hist){
      return(isolate({output$visualize_histogram}))
    }else{
      return(output$visualize_histogram)
    }
  }
  
  output$descriptive <- renderTable({
    descriptive_stat(data[input$choose_stat])
  })

    output$visualize_histogram <- renderPlot({
    input$update_hist
    isolate(
      #returns filtered data for histogram plot
      hist_data <- if_blank_filt(input$h_yr,
                                 input$h_mon,
                                 input$h_day,
                                 input$h_hr,
                                 input$h_du,
                                 input$h_co,
                                 input$h_st,
                                 input$h_sh))
    isolate(
      plot_histogram(
        hist_data,
        input$choose_hist,
        input$hist_bins,
        input$bin_w))
  })
  
    
  data_hist <- eventReactive(input$clicks, {
    input$choose_hist
    input$hist_bins
    input$bin_w
    input$h_yr
    input$h_mon
    input$h_day
    input$h_co
    input$h_st
    input$h_sh
    input$h_hr
    input$h_du
  })
  
  observe({
    hist_co <- input$h_co
    if (is.null(hist_co))
      hist_co <- character(0)
    updateSelectInput(session, "h_st",
                      label = "Filter by State",
                      choices = c("All", levels(factor(data$state[data$country == input$h_co]))),
                      selected = "All"
    )
  })
  
  ######## Scatter Plot ########
  
  #updates scatter plot on clicking action button update_scatter
  update_scatterplot <- function(){
    if(!input$update_scatter){
      return(isolate({output$visualize_scatter}))
    }else{
      return(output$visualize_scatter)
    }
  }
  
  data_scatter <- eventReactive(input$clicks, { 
    input$x
    input$y
    input$color
    input$size
    input$filter_yr
    input$filter_mon
    input$filter_day
    input$filter_co
    input$filter_st
    input$filter_sh
    input$filter_hr
    input$filter_du
    input$jitter
  })
  
  output$visualize_scatter <- renderPlot({
    input$update_scatter
    isolate(
    #returns filtered data for scatter plot
      scatter_dat <- if_blank_filt(input$filter_yr,
                                   input$filter_mon,
                                   input$filter_day,
                                   input$filter_hr,
                                   input$filter_du,
                                   input$filter_co,
                                   input$filter_st,
                                   input$filter_sh))
      isolate(
    if_blank_scat(
             scatter_dat, #filtered data
             input$x,
             input$y,
             input$color,
             input$size,
             input$jitter))
    })
  
  # updates state selection options based on country input
  observe({
    s_co <- input$filter_co
    if (is.null(s_co))
      s_co <- character(0)
    updateSelectInput(session, "filter_st",
                      label = "Filter by State",
                      choices = c("All", levels(factor(data$state[data$country == input$filter_co]))),
                      selected = "All"
    )
  })
  
  ######## Map ########

  #updates map on clicking action button click_map
  update_map <- function(){
    if(!input$click_map){
      return(isolate({output$visualize_map}))
    }else{
      return(output$visualize_map)
    }
  }
  
  data_map <- eventReactive(input$clicks, {
    input$map_year
    input$map_month
    input$map_day
    input$map_hour
    input$map_dur
    input$map_country
    input$map_state
    input$map_shape
    })

  observe({
    m_co <- input$map_country
    if (is.null(m_co))
      m_co <- character(0)
    updateSelectInput(session, "map_state",
                      label = "State",
                      choices = c("All", levels(factor(data$state[data$country == input$map_country]))),
                      selected = "FL"
    )
  })

    output$visualize_map <- renderLeaflet({
    input$click_map
    isolate(
      #returns filtered data for map
      map_dat <- if_blank_filt(input$map_year,
                               input$map_month,
                               input$map_day,
                               input$map_hour,
                               input$map_dur,
                               input$map_country,
                               input$map_state,
                               input$map_shape))
    isolate(
      create_map(
        map_dat
        )
      )

  })
    
    ######## Wilcoxon Test ########    
    
    data_bp <- eventReactive(input$clicks, {
      input$update_wtest
      input$country1
      input$country2
      input$state1
      input$state2
      input$city1
      input$city2
      input$wt_yr
      input$wt_mon
      input$wt_day
      input$wt_du
    })

    #updates boxplot on clicking action button update_bp
    update_bp <- function(){
      if(!input$update_wtest){
        return(isolate({output$visualize_boxplot}))
      }else{
        return(output$visualize_boxplot)
      }
    }
    
    output$visualize_boxplot <- renderPlot({
      input$update_wtest
      isolate(
      if(input$yr_or_mo == "by_yr") y_o_m <- 1 else y <- 0)
      isolate(
      if(input$region == "by_country") geo_lev <- 1)
      isolate(
      if(input$region == "by_state") {
        geo_lev <- 2
        s1 <- input$state1
        s2 <- input$state2
      })
      isolate(
      if(input$region == "by_city"){
        geo_lev <- 3
        s1 <- input$state_c1
        s2 <- input$state_c2
      })
      isolate(
        #returns filtered data for box plot
        bp_data <- filter_data(input$wt_yr,
                              input$wt_mon,
                              input$wt_day,
                              input$wt_hr,
                              input$wt_du))
      isolate(
        plot_boxplot(prep_wtest(
          bp_data,
          y_o_m, #year code
          geo_lev, # level code
          input$country1,
          input$country2,
          s1, #input$state1,
          s2, #input$state2,
          input$city1,
          input$city2)))
    })

    #updates wilcoxon test on clicking action button update_wtest
    update_wt <- function(){
      if(!input$update_wtest){
        return(isolate({output$wtest_results}))
      }else{
        return(output$wtest_results)
      }
    }
    
    output$wtest_results <- renderTable({
      input$update_wtest
      isolate(
        if(input$yr_or_mo == "by_yr") y_o_m <- 1 else y_o_m <- 0)
      isolate(
        if(input$region == "by_country") geo_lev <- 1)
      isolate(
        if(input$region == "by_state") {
          geo_lev <- 2
          s1 <- input$state1
          s2 <- input$state2
        })
      isolate(
        if(input$region == "by_city"){
          geo_lev <- 3
          s1 <- input$state_c1
          s2 <- input$state_c2
        })
      isolate(
        #returns filtered data for box plot
        bp_data <- filter_data(input$wt_yr,
                              input$wt_mon,
                              input$wt_day,
                              input$wt_hr,
                              input$wt_du))
      isolate(
        w_test_func(prep_wtest(
          bp_data,
          y_o_m, #year code
          geo_lev, # level code
          input$country1,
          input$country2,
          s1, #input$state1,
          s2, #input$state2,
          input$city1,
          input$city2)))
    })
    
    # w test city1
    observe({
      wt_c1 <- input$state_c1
      if (is.null(wt_c1))
        wt_c1 <- character(0)
      updateSelectInput(session, "city1",
                        label = "City",
                        choices = c(levels(factor(data$city[data$state == input$state_c1])))
      )
    })
    
    # w test city2
    observe({
      wt_c2 <- input$state_c2
      if (is.null(wt_c2))
        wt_c2 <- character(0)
      updateSelectInput(session, "city2",
                        label = "City",
                        choices = c(levels(factor(data$city[data$state == input$state_c2])))
      )
    })

    output$wt_conc <- renderText({
        input$update_wtest
        isolate(if(input$yr_or_mo == "by_yr") y_o_m <- 1 else y_o_m <- 0)
        isolate(if(input$region == "by_country") geo_lev <- 1)
        isolate(if(input$region == "by_state") geo_lev <- 2)
        isolate(if(input$region == "by_city") geo_lev <- 3)
        isolate(#returns filtered data for box plot
          bp_data <- filter_data(input$wt_yr, input$wt_mon, input$wt_day, input$wt_hr, input$wt_du))
        isolate(wt_conclusion(prep_wtest(bp_data,
                                         y_o_m, #year code
                                         geo_lev, # level code
                                         input$country1,
                                         input$country2,
                                         input$state1,
                                         input$state2,
                                         input$city1,
                                         input$city2)))
      })
    

    ######## Linear Regression Table ########
    
    lin <- eventReactive(input$clicks, {
      input$lin_click
      input$lin_co
      input$lin_st
      input$lin_yr
      input$lin_mon
      input$lin_day
      input$lin_hr
      input$lin_du
    })
    
    #updates linear model on clicking action button lin_click
    update_lin <- function(){
      if(!input$lin_click){
        return(isolate({output$linear_table}))
      }else{
        return(output$linear_table)
      }
    }
    
    
    # updates state selection linear model filter
    observe({
      l_co <- input$lin_st
      if (is.null(l_co))
        l_co <- character(0)
      updateSelectInput(session, "lin_st",
                        label = "State",
                        choices = c("All", levels(factor(data$state[data$country == input$lin_co]))),
                        selected = "All"
      )
    })

        
    #output for linear model table
    output$linear_table <- renderTable({
      input$lin_click
      isolate(
        #returns filtered data for linear model
        dat <- if_blank_filt(input$lin_yr,
                             input$lin_mon,
                             input$lin_day,
                             input$lin_hr,
                             input$lin_du,
                             input$lin_co,
                             input$lin_st))
      isolate(
        linear_model_table(
          linear_model(dat, input$lin_1, input$lin_2), #filtered data
          input$lin_1))#, input$lin_2))
    })
    
    ######## Linear Regression Plot ########
    
    #updates linear model plot on clicking action button lin_click
    update_lin <- function(){
      if(!input$lin_click){
        return(isolate({output$linear_plot}))
      }else{
        return(output$linear_plot)
      }
    }
    
    #output for linear model plot
    output$linear_plot <- renderPlot({
      input$lin_click
      isolate(
        #returns filtered data for linear model plot
        dat <- if_blank_filt(input$lin_yr,
                             input$lin_mon,
                             input$lin_day,
                             input$lin_hr,
                             input$lin_du,
                             input$lin_co,
                             input$lin_st))
      isolate(
        linear_model_plot( 
          linear_model(dat, input$lin_1, input$lin_2), #filtered data
          
          #          dat, #filtered data
          input$lin_1,
          input$lin_2))
    })
    
    # displays text describing the linear model
    output$interpret_linear <- renderText({
      input$lin_click
      isolate(
        #returns filtered data for linear model interpretation
        dat <- if_blank_filt(input$lin_yr,
                             input$lin_mon,
                             input$lin_day,
                             input$lin_hr,
                             input$lin_du,
                             input$lin_co,
                             input$lin_st))
      isolate(linear_interpret(linear_model(dat, input$lin_1, input$lin_2),
                                            input$lin_1,
                                            input$lin_2))
    })
    
    
    ######## Freq Plot ########
    
    #output for freq plot
    output$freq_plot <- renderPlot({
      input$freq_click
      isolate(
        #returns filtered data for freq plot
        dat <- if_blank_filt_freq(input$freq_yr,
                             input$freq_mon,
                             input$freq_day,
                             input$freq_hr,
                             input$freq_du,
                             input$freq_sh))
      
      isolate(if(input$freq_st3 == "None"){
        st3 <- NULL
      }else st3 = input$freq_st3)
      
      isolate(
        freq_model_plot(
         dat, #filtered data
         input$freq_st1,
         input$freq_st2,
         st3,
         input$freq_t))
    })

}
