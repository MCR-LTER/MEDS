#read R code from a the global.R file 
source(here("ShinyAppMooreaViz", "global.R"))

# Server ----
#function with instructions on how to build and rebuild the R objects displayed in the UI. (Runs the r code to make the visualizations and transform the data for your app to function)
server <- function(input, output, session) {
  
  #leaflet outputs ----
  output$leaflet_base <- renderLeaflet({
    
    #create base map
    #add mouse coordinate information at top of map
    #add a measure control to the map
    leaflet(crs) %>% 
      addProviderTiles("Esri.WorldImagery") %>% 
      setView(-149.829529, -17.538843, zoom = 11.5) %>% 
      addMouseCoordinates() %>% 
      addMeasure(
        position = "bottomleft",
        primaryLengthUnit = "feet",
        primaryAreaUnit = "sqfeet",
        activeColor = "#3D535D",
        completedColor = "#7D4479") 
    
  })
 
  # temporal figures by variable ----
  

  # reactive data frame 
  temp_reactive_df <- reactive({


      temporal_data %>%
          dplyr::select(year, site, input$Temp_Variable, habitat) %>%
      filter(habitat == input$habitat)
      
  })
  

  
  # fish_title <- expression(paste("Mean Herbivore Fish Biomass", paste(paste("(grams per ", m^{2}, ")"))))
  

  output$faceted_plot <- renderPlot({
    ggplot(data = temp_reactive_df(), aes_string(x = "year", y = input$Temp_Variable)) +
      geom_point(aes(color = site)) +
      geom_line(aes(group = site, color = site)) +
      facet_wrap(~site) +
    labs(title = case_when(input$Temp_Variable == "mean_coral_cover" ~ "Mean Percent Coral Cover",
                           input$Temp_Variable == "Pocillopora" ~ "Mean Percent Coral Cover (Pocillopora)",
                           input$Temp_Variable == "Porites" ~ "Mean Percent Coral Cover (Porites)",
                           input$Temp_Variable == "Acropora" ~ "Mean Percent Coral Cover (Acropora)",
                           input$Temp_Variable == "mean_macroalgae_cover" ~ "Mean Percent Algae Cover (Macroalgae)",
                           input$Temp_Variable == "mean_CTB_algae_cover" ~ "Mean Percent Algae Cover (CTB)", 
                           input$Temp_Variable == "mean_biomass_p_consumers" ~ "Mean Herbivore Fish Biomass",
                           input$Temp_Variable == "cots_density" ~ "Crown-of-Thorns Density"),
         subtitle = 'Moorea, French Polynesia (2006 - 2021)',
         y = case_when(input$Temp_Variable == "mean_coral_cover" ~ "Percent",
                       input$Temp_Variable == "Pocillopora" ~ "Percent",
                       input$Temp_Variable == "Porites" ~ "Percent",
                       input$Temp_Variable == "Acropora" ~ "Percent",
                       input$Temp_Variable == "mean_macroalgae_cover" ~ "Percent",
                       input$Temp_Variable == "mean_CTB_algae_cover" ~ "Percent",
                       input$Temp_Variable == "mean_biomass_p_consumers" ~ "Biomass (g per m^2)",
                       #input$TempVariable == "mean_biomass_p_consumers" ~ TeX(r'($\alpha  x^\alpha$, where $\alpha \in \{1 \ldots 5\}$)'), # uses latex2exp package 
                       input$Temp_Variable == "cots_density" ~ "Density (count per m^2)"),
         x = 'Year',
         color = 'Site') +
      scale_color_manual(values = c("LTER 1" = '#fcd225', "LTER 2" = '#f68d45', "LTER 3" = '#d5546e', 
                                    "LTER 4" = '#a62098', "LTER 5" = '#6300a7', "LTER 6" = '#0d0887'))  +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 0, hjust = 0.5),
          panel.grid.major.x = element_blank(), 
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          axis.title.x = element_text(size=14),
          axis.title.y = element_text(size = 14),
          plot.title = element_text(size = 16)) +
      scale_x_continuous(breaks = seq(2006, 2021, by = 2))
  })
  
  
  
  # temporal figures by site ---- 
  
  # reactive data frame 
  temporal_reactive_df_2 <- reactive({validate(
    need(length(input$site_2) > 0, "Please select at least one site to visualize."),
    need(length(input$habitat_2) > 0, "Please select one habitat")
  )
    temporal_data %>%
      dplyr::filter(habitat %in% input$habitat_2,
             site %in% input$site_2)

  }) 
  

  
  
  # coral_plot
  output$coral_plot <- renderPlot({
    ggplot(data = temporal_reactive_df_2(), aes(x = year, y = mean_coral_cover)) +
      geom_point(aes(color = site)) +
      geom_line(aes(group = site, color = site)) +
      scale_color_manual(values = c("LTER 1" = '#fcd225', "LTER 2" = '#f68d45', "LTER 3" = '#d5546e', 
                                    "LTER 4" = '#a62098', "LTER 5" = '#6300a7', "LTER 6" = '#0d0887')) + 
      labs(x = "Year",
           y = expression("Mean Percent Coral Cover")) +
      ylim(0, NA) +
      theme_bw() +
      theme(axis.text.x = element_text(angle = 0, hjust = 0.5),
            panel.grid.major.x = element_blank(), 
            panel.grid.minor.x = element_blank(),
            panel.grid.minor.y = element_blank(),
            axis.title.x = element_text(size=14),
            axis.title.y = element_text(size = 14),
            plot.title = element_text(size = 16)) +
      scale_x_continuous(breaks = seq(2006, 2021, by = 2))
  })
  
  # algae_plot 
  output$algae_plot <- renderPlot({
      ggplot(data = temporal_reactive_df_2(), aes(x = year, y = mean_macroalgae_cover)) +
      geom_point(aes(color = site)) +
      geom_line(aes(group = site, color = site)) +
      scale_color_manual(values = c("LTER 1" = '#fcd225', "LTER 2" = '#f68d45', "LTER 3" = '#d5546e', 
                                    "LTER 4" = '#a62098', "LTER 5" = '#6300a7', "LTER 6" = '#0d0887'))  +
      labs(x = "Year",
           y = expression("Mean Percent Algae Cover")) +
      ylim(0, NA) +
      theme_bw() +
      theme(axis.text.x = element_text(angle = 0, hjust = 0.5),
            panel.grid.major.x = element_blank(), 
            panel.grid.minor.x = element_blank(),
            panel.grid.minor.y = element_blank(),
            axis.title.x = element_text(size=14),
            axis.title.y = element_text(size = 14),
            plot.title = element_text(size = 16)) +
      scale_x_continuous(breaks = seq(2006, 2021, by = 2))
  })
  

  
  # biomass_plot 
  output$biomass_plot <- renderPlot({
    ggplot(data = temporal_reactive_df_2(), aes(x = year, y = mean_biomass_p_consumers)) +
      geom_point(aes(color = site)) +
      geom_line(aes(group = site, color = site)) +
      scale_color_manual(values = c("LTER 1" = '#fcd225', "LTER 2" = '#f68d45', "LTER 3" = '#d5546e', 
                                    "LTER 4" = '#a62098', "LTER 5" = '#6300a7', "LTER 6" = '#0d0887')) +
      labs(x = "Year",
           y = expression(atop("Mean Herbivore Fish Biomass", paste(paste("(grams per ", m^{2}, ")"))))) +
      theme_bw() +
      theme(axis.text.x = element_text(angle = 0, hjust = 0.5),
            panel.grid.major.x = element_blank(), 
            panel.grid.minor.x = element_blank(),
            panel.grid.minor.y = element_blank(),
            axis.title.x = element_text(size=14),
            axis.title.y = element_text(size = 14),
            plot.title = element_text(size = 16)) +
      scale_x_continuous(breaks = seq(2006, 2021, by = 2))
  })
  
  
  
  # cots_plot
  output$cots_plot <- renderPlot({
    ggplot(data = temporal_reactive_df_2(), aes(x = year, y = cots_density)) +
      geom_point(aes(color = site)) +
      geom_line(aes(group = site, color = site)) +
      scale_color_manual(values = c("LTER 1" = '#fcd225', "LTER 2" = '#f68d45', "LTER 3" = '#d5546e', 
                                    "LTER 4" = '#a62098', "LTER 5" = '#6300a7', "LTER 6" = '#0d0887')) +
      labs(x = "Year",
           y = expression(atop("COTS Density", paste(paste("(Count per ", m^{2}, ")"))))) +
      theme_bw() +
      theme(axis.text.x = element_text(angle = 0, hjust = 0.5),
            panel.grid.major.x = element_blank(), 
            panel.grid.minor.x = element_blank(),
            panel.grid.minor.y = element_blank(),
            axis.title.x = element_text(size=14),
            axis.title.y = element_text(size = 14),
            plot.title = element_text(size = 16)) +
      scale_x_continuous(breaks = seq(2006, 2021, by = 2))
  })
  
 
  
  # reactive observations and data filtering ----
  Observations <- reactive({
    
  
    
    n_data %>% 
      dplyr::select(latitude, longitude) 
  })
  
  
  

  
  # observations and polygons reactive 
  
  observeEvent(input$Other, {
    proxy <- leafletProxy("leaflet_base")
    
    
    if (!is.null(input$Other) && input$Other == "LTER Sites") { 
      proxy %>% clearGroup("LTER Sites") %>% clearGroup("Observations") %>% 
        addPolygons(data = lter_1, group = "LTER Sites", popup = "LTER Site 1", fillOpacity = 0.1, weight = 0.5) %>% 
        addPolygons(data = lter_2, group = "LTER Sites", popup = "LTER Site 2", fillOpacity = 0.1, weight = 0.5) %>% 
        addPolygons(data = lter_3, group = "LTER Sites", popup = "LTER Site 3", fillOpacity = 0.1, weight = 0.5) %>%
        addPolygons(data = lter_4, group = "LTER Sites", popup = "LTER Site 4", fillOpacity = 0.1, weight = 0.5) %>% 
        addPolygons(data = lter_5, group = "LTER Sites", popup = "LTER Site 5", fillOpacity = 0.1, weight = 0.5) %>% 
        addPolygons(data = lter_6, group = "LTER Sites", popup = "LTER Site 6", fillOpacity = 0.1, weight = 0.5)}
      
    else if (!is.null(input$Other) && input$Other == "Observations") { 
      proxy  %>%  clearGroup("Observations") %>% 
        addCircles(data = Observations(), color = "black", group = "Observations", radius = 3, opacity = 0.2, fillOpacity = 0.1,
                   popup = paste("Longitude:", round(n_data$longitude, 4), "<br>", 
                                 "Latitude:", round(n_data$latitude, 4), "<br>",
                                 "January Percent N:", jan_np_data$percent_n, "%", "<br>",
                                 "May Percent N:", may_np_data$percent_n,"%", "<br>",
                                 "July Percent N:", july_np_data$percent_n,"%", "<br>",
                                 "January Isotopic N:", jan_ni_data$percent_n,"δ15N", "<br>", 
                                 "May Isotopic N:", may_ni_data$percent_n,"δ15N", "<br>",
                                 "July Isotopic N:", july_ni_data$percent_n,"δ15N", "<br>",
                                 "Percent Coral Bleached:", round(bleaching_data$percent_bleached, 2),"%", "<br>",
                                 "Predicted Sewage Index:", round(sewage_2016$urb_nuts, 4), "<br>")) %>% 
        clearGroup("LTER Sites")}
    
    else if (!is.null(input$Other) && input$Other == "Sites & Observations") { 
      proxy  %>%  clearGroup("Observations") %>% clearGroup("LTER Sites") %>% 
        addCircles(data = Observations(), color = "black", group = "Observations", radius = 3, opacity = 0.2, fillOpacity = 0.1,
                   popup = paste("Longitude:", round(n_data$longitude, 4), "<br>", 
                                 "Latitude:", round(n_data$latitude, 4), "<br>",
                                 "January Percent N:", jan_np_data$percent_n, "%", "<br>",
                                 "May Percent N:", may_np_data$percent_n,"%", "<br>",
                                 "July Percent N:", july_np_data$percent_n,"%", "<br>",
                                 "January Isotopic N:", jan_ni_data$percent_n,"δ15N", "<br>", 
                                 "May Isotopic N:", may_ni_data$percent_n,"δ15N", "<br>",
                                 "July Isotopic N:", july_ni_data$percent_n,"δ15N", "<br>",
                                 "Percent Coral Bleached:", round(bleaching_data$percent_bleached, 2),"%", "<br>",
                                 "Predicted Sewage Index:", round(sewage_2016$urb_nuts, 4), "<br>")) %>% 
        addPolygons(data = lter_1, group = "LTER Sites", popup = "LTER Site 1", fillOpacity = 0.1, weight = 0.5) %>% 
        addPolygons(data = lter_2, group = "LTER Sites", popup = "LTER Site 2", fillOpacity = 0.1, weight = 0.5) %>% 
        addPolygons(data = lter_3, group = "LTER Sites", popup = "LTER Site 3", fillOpacity = 0.1, weight = 0.5) %>%
        addPolygons(data = lter_4, group = "LTER Sites", popup = "LTER Site 4", fillOpacity = 0.1, weight = 0.5) %>% 
        addPolygons(data = lter_5, group = "LTER Sites", popup = "LTER Site 5", fillOpacity = 0.1, weight = 0.5) %>% 
        addPolygons(data = lter_6, group = "LTER Sites", popup = "LTER Site 6", fillOpacity = 0.1, weight = 0.5)}


    else {
      proxy %>% clearGroup("LTER Sites") %>% clearGroup("Observations")
    } 
    
    
    
  }, ignoreNULL = F)
  
  
  
  
  # reactive jan n %
  
  jan_n <- reactive({
    
    spatial_brick[[1]]
  })
  
  
  # reactive may n %
  may_n <- reactive({
    
    spatial_brick[[2]]
  })
  
  # reactive july n %
  july_n <- reactive({
    
    spatial_brick[[3]]
  })
  
  # reactive jan n i
  
  jan_n_i <- reactive({
    
    spatial_brick[[4]]
  })
  
  
  # reactive may n i
  may_n_i <- reactive({
    
    spatial_brick[[5]]
  })
  
  # reactive july n i
  july_n_i <- reactive({
    
    spatial_brick[[6]]
  })
  
   
  
  #sync button
  proxy <- leafletProxy("leaflet_base", session)
  
  observeEvent({
    c(input$Month, input$Variable)},
    {
      
      if(!is.null(input$Month) && !is.null(input$Variable) && input$Month == "January" 
         && input$Variable == "Percent Nitrogen"){
        proxy  %>%  clearImages() %>% clearControls() %>% 
          addRasterImage(jan_n(), colors = "viridis", group = "January N", opacity = 1, 
                         layerId = "January", ) %>%
          addLegend(data = jan_data, title = 'Percent N', pal = pal_jan, 
                    position = "bottomright", values = ~X1, opacity = 1, 
                    group = "January N", labFormat = labelFormat(transform = function(X1) sort(X1, decreasing = TRUE)))
         
      }
      
      else if(!is.null(input$Month) && !is.null(input$Variable) && input$Month == "January" 
              && input$Variable == "Isotopic Nitrogen"){
        proxy  %>% clearImages() %>% clearControls() %>% 
          addRasterImage(jan_n_i(), colors = "viridis", group = "January N", opacity = 1, 
                         layerId = "January") %>% 
          addLegend(data = jan_i_data, title = 'Isotopic N', pal = pal_jan_i,
                    position = "bottomright",
                    values = ~X4, opacity = 1, group = "January N Isotopic",
                    labFormat = labelFormat(transform = function(X4) sort(X4, decreasing = TRUE)))
      }
      
      else if(!is.null(input$Month) && !is.null(input$Variable) && input$Month == "May" 
              && input$Variable == "Percent Nitrogen"){
        proxy %>% clearImages() %>% clearControls() %>% 
          addRasterImage(may_n(), colors = "viridis", group = "May N", opacity = 1, 
                         layerId = "May") %>% 
          addLegend(data = may_data, title = 'Percent N', pal = pal_may,
                    position = "bottomright",
                    values = ~X2, opacity = 1, group = "May N",
                    labFormat = labelFormat(transform = function(X2) sort(X2, decreasing = TRUE)))
      }
      
      else if(!is.null(input$Month) && !is.null(input$Variable) && input$Month == "May" 
              && input$Variable == "Isotopic Nitrogen"){
        proxy %>% clearImages() %>% clearControls() %>% 
          addRasterImage(may_n_i(), colors = "viridis", group = "May N", opacity = 1, 
                         layerId = "May") %>% 
          addLegend(data = may_i_data, title = 'Isotopic N', pal = pal_may_i,
                    position = "bottomright",
                    values = ~X5, opacity = 1, group = "May N Isotopic",
                    labFormat = labelFormat(transform = function(X5) sort(X5, decreasing = TRUE)))
      }
      else if (!is.null(input$Month) && !is.null(input$Variable) && input$Month == "July"
               && input$Variable == "Percent Nitrogen"){ 
        
        proxy %>% clearImages() %>% clearControls() %>% 
          addRasterImage(july_n(), colors = "viridis", group = "July N", opacity = 1, 
                                 layerId = "July") %>% 
          addLegend(data = july_data, title = 'Percent N', pal = pal_july,
                    position = "bottomright",
                    values = ~X3, opacity = 1, group = "July N",
                    labFormat = labelFormat(transform = function(X3) sort(X3, decreasing = TRUE)))
      }
      
      else if(!is.null(input$Month) && !is.null(input$Variable) && input$Month == "July" 
              && input$Variable == "Isotopic Nitrogen"){
        proxy %>% clearImages() %>% clearControls() %>% 
          addRasterImage(july_n_i(), colors = "viridis", group = "May N", opacity = 1, 
                         layerId = "July") %>% 
          addLegend(data = july_i_data, title = 'Isotopic N', pal = pal_july_i,
                    position = "bottomright",
                    values = ~X6, opacity = 1, group = "July N Isotopic",
                    labFormat = labelFormat(transform = function(X6) sort(X6, decreasing = TRUE)))
      }
      
      
      else {
        proxy %>%  clearImages() %>% clearControls()
      }

      updatePickerInput(session, "Additional", selected = "")

      

    }, ignoreNULL = F)           
  
  
  #clear button
  observeEvent(input$Clear_1,{
      
      if(!is.null(input$Clear_1) &&  input$Clear_1 == "Clear"){
        proxy %>% clearImages() %>% clearGroup("LTER Sites") %>% clearGroup("Observations") %>% clearControls()
      }
    updatePickerInput(session, "Variable", selected = "")
    updatePickerInput(session, "Month", selected = "")
    updatePickerInput(session, "Additional", selected = "")
    updatePickerInput(session, "Other", selected = "")
    updateCheckboxGroupButtons(session, "Clear_1", selected = "")
    }, ignoreNULL = F)  
  
  #clear button
  observeEvent(input$Clear_2,{
    
    if(!is.null(input$Clear_2) &&  input$Clear_2 == "Clear"){
      proxy %>% clearImages() %>% clearGroup("LTER Sites") %>% clearGroup("Observations") %>% clearControls()
    }
    updatePickerInput(session, "Variable", selected = "")
    updatePickerInput(session, "Month", selected = "")
    updatePickerInput(session, "Additional", selected = "")
    updatePickerInput(session, "Other", selected = "")
    updateCheckboxGroupButtons(session, "Clear_2", selected = "")
  }, ignoreNULL = F)  
  
  
  # reactive coral belach
  bleach <- reactive({
    
    spatial_brick[[7]]
  })
  
  # reactive sewage
  sewage <- reactive({
    
    spatial_brick[[8]]
  })
  
  # reactive lidar
  bathy <- reactive({
    
    spatial_brick[[9]]
  })
  
  
  #sync button coral bleach
  observeEvent({
    input$Additional},
    {
      

      
      if(!is.null(input$Additional) && input$Additional == "Percent Coral Bleached" ){
        
        proxy  %>% clearImages() %>%  clearControls() %>% 
          addRasterImage(bleach(), colors = "plasma", group = "Percent Coral Bleached",
                                  opacity = 1, layerId = "Percent Coral Bleached") %>% 
          addLegend(data = bleach_data, title = 'Percent Bleached', pal = pal_bleach,
                    position = "bottomright",
                    values = ~X7, opacity = 1, group = "Percent Bleached",
                    labFormat = labelFormat(transform = function(X7) sort(X7, decreasing = TRUE)))}
      
      else if (!is.null(input$Additional) && input$Additional == "Predicted Sewage" ){
        
        proxy  %>% clearImages() %>% clearControls() %>% 
          addRasterImage(sewage(), colors = pal_image_sew(25), group = "Predicted Sewage",
                                  opacity = 1, layerId = "Predicted Sewage") %>% 
          addLegend(data = sew_dat, title = 'Predicted Sewage', pal = pal_sewage,
                    position = "bottomright",
                    values = ~X8, opacity = 1, group = "Predicted Sewage Index",
                    labFormat = labelFormat(transform = function(X8) sort(X8, decreasing = TRUE)))}
      else if (!is.null(input$Additional) && input$Additional == "Bathymetry" ){
        
        proxy  %>% clearImages() %>% clearControls() %>% 
          addRasterImage(bathy(), colors = pal_image_bath(25), group = "Bathymetry",
                                  opacity = 1, layerId = "Bathymetry") %>% 
          addLegend(data = bathy_df, title = 'Depth (ft)', pal = pal_bathy,
                    position = "bottomright",
                    values = ~X9, opacity = 1, group = 'Depth')}
      
      else {
        proxy %>% clearImages() %>% clearShapes()
      }
      

      updatePickerInput(session, "Month", selected = "")
      updatePickerInput(session, "Variable", selected = "")


    }, ignoreNULL = F)
  
  
}

