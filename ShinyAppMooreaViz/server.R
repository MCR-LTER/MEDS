
source(here("ShinyAppMooreaViz", "global.R"))

# Server ----
# Runs the r code to make the visualizations and transform the data for your app to function

server <- function(input, output, session) {
  
  #leaflet outputs ----
  output$leaflet_base <- renderLeaflet({
    
    #base map
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
  
  # temporal_reactive_df_variables <- reactive({
  #     
  #     temporal_data %>% 
  #         dplyr::select(year, site, input$Variable)
  # }) 
  
  output$faceted_plot <- renderPlot({
    ggplot(data = temporal_data, aes_string(x = "year", y = input$Temp_Variable)) +
      geom_point(aes(color = site)) +
      geom_line(aes(group = site, color = site)) +
      facet_wrap(~site) +
    labs(title = 'INSERT TITLE',
         subtitle = 'Moorea, French Polynesia (2005 - 2018)',
         # y = 'Density (count/m^2)', # use case_when() to designate label based on user input of variable?
         y = case_when(input$Temp_Variable == "mean_coral_cover" ~ "coral axis",
                       input$Temp_Variable == "mean_algae_cover" ~ "algae axis",
                       input$Temp_Variable == "mean_biomass_p_consumers" ~ "fish axis",
                       input$Temp_Variable == "cots_density" ~ "cots axis"),
         x = 'Year',
         color = 'Site',
         title = case_when(input$Temp_Variable == "mean_coral_cover" ~ "coral title",
                           input$Temp_Variable == "mean_algae_cover" ~ "algae title",
                           input$Temp_Variable == "mean_biomass_p_consumers" ~ "fish title",
                           input$Temp_Variable == "cots_density" ~ "cots title")) +
    scale_color_manual(values = c('#40B5AD', '#87CEEB', '#4682B4', '#6F8FAF', '#9FE2BF', '#6495ED')) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1),
          panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          axis.title.x = element_text(size=14),
          axis.title.y = element_text(size = 14),
          plot.title = element_text(size = 16))
  })
  

  
  #temporal outputs ----
  temporal_reactive_df <- reactive({validate(
    need(length(input$site) > 0, "Please select at least one site to visualize.")
  )
    temporal_data %>%
      filter(site %in% input$site)
  }) 
  
  
  #variables by site outputs ----
  
  output$variables_by_site_plot <- renderPlot({
    coral_plot <- ggplot(data = temporal_reactive_df(), aes(x = year, y = mean_coral_cover)) +
      geom_point(aes(color = site)) +
      geom_line(aes(group = site, color = site)) +
      labs(x = "",
           y = expression(atop("Mean Coral Cover", paste(paste("(% per 0.25 ", m^{2}, ")"))))) 
    
    cots_plot <- ggplot(data = temporal_reactive_df(), aes(x = year, y = cots_density)) +
      geom_point(aes(color = site)) +
      geom_line(aes(group = site, color = site)) +
      labs(x = "",
           y = expression(atop("COTS Density", paste(paste("(Count per ", m^{2}, ")")))))
    
    biomass_plot <- ggplot(data = temporal_reactive_df(), aes(x = year, y = mean_biomass_p_consumers)) +
      geom_point(aes(color = site)) +
      geom_line(aes(group = site, color = site)) +
      labs(x = "",
           y = expression(atop("Mean Fish Biomass", paste(paste("(% per 0.25 ", m^{2}, ")")))))
    
    algae_plot <- ggplot(data = temporal_reactive_df(), aes(x = year, y = mean_algae_cover)) +
      geom_point(aes(color = site)) +
      geom_line(aes(group = site, color = site)) +
      labs(x = "Year",
           y = expression(atop("Mean Algae Cover", paste(paste("(% per 0.25 ", m^{2}, ")"))))) 
      
    
    coral_plot/cots_plot/biomass_plot/algae_plot +
      plot_layout(guides = 'collect') + # combines the legends
      plot_layout(ncol = 1, heights = c(1, 1, 1, 1))
  })
  
  
  
  # reactive observations and data filtering
  Observations <- eventReactive(input$Other, {
    
    geom_line(aes(group = site, color = site))
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
          addRasterImage(jan_n(), colors = "plasma", group = "January N", opacity = 0.7, 
                         layerId = "January") %>%
          addLegend(data = jan_data, title = 'Percent N', pal = pal_jan, 
                    position = "bottomright", values = ~X1, opacity = 1, 
                    group = "January N", labFormat = labelFormat(transform = function(X1) sort(X1, decreasing = TRUE)))
         
      }
      
      else if(!is.null(input$Month) && !is.null(input$Variable) && input$Month == "January" 
              && input$Variable == "Isotopic Nitrogen"){
        proxy  %>% clearImages() %>% clearControls() %>% 
          addRasterImage(jan_n_i(), colors = "plasma", group = "January N", opacity = 0.7, 
                         layerId = "January") %>% 
          addLegend(data = jan_i_data, title = 'Isotopic N', pal = pal_jan_i,
                    position = "bottomright",
                    values = ~X4, opacity = 1, group = "January N Isotopic",
                    labFormat = labelFormat(transform = function(X4) sort(X4, decreasing = TRUE)))
      }
      
      else if(!is.null(input$Month) && !is.null(input$Variable) && input$Month == "May" 
              && input$Variable == "Percent Nitrogen"){
        proxy %>% clearImages() %>% clearControls() %>% 
          addRasterImage(may_n(), colors = "plasma", group = "May N", opacity = 0.7, 
                         layerId = "May") %>% 
          addLegend(data = may_data, title = 'Percent N', pal = pal_may,
                    position = "bottomright",
                    values = ~X2, opacity = 1, group = "May N",
                    labFormat = labelFormat(transform = function(X2) sort(X2, decreasing = TRUE)))
      }
      
      else if(!is.null(input$Month) && !is.null(input$Variable) && input$Month == "May" 
              && input$Variable == "Isotopic Nitrogen"){
        proxy %>% clearImages() %>% clearControls() %>% 
          addRasterImage(may_n_i(), colors = "plasma", group = "May N", opacity = 0.7, 
                         layerId = "May") %>% 
          addLegend(data = may_i_data, title = 'Isotopic N', pal = pal_may_i,
                    position = "bottomright",
                    values = ~X5, opacity = 1, group = "May N Isotopic",
                    labFormat = labelFormat(transform = function(X5) sort(X5, decreasing = TRUE)))
      }
      else if (!is.null(input$Month) && !is.null(input$Variable) && input$Month == "July"
               && input$Variable == "Percent Nitrogen"){ 
        
        proxy %>% clearImages() %>% clearControls() %>% 
          addRasterImage(july_n(), colors = "plasma", group = "July N", opacity = 0.7, 
                                 layerId = "July") %>% 
          addLegend(data = july_data, title = 'Percent N', pal = pal_july,
                    position = "bottomright",
                    values = ~X3, opacity = 1, group = "July N",
                    labFormat = labelFormat(transform = function(X3) sort(X3, decreasing = TRUE)))
      }
      
      else if(!is.null(input$Month) && !is.null(input$Variable) && input$Month == "July" 
              && input$Variable == "Isotopic Nitrogen"){
        proxy %>% clearImages() %>% clearControls() %>% 
          addRasterImage(july_n_i(), colors = "plasma", group = "May N", opacity = 0.7, 
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
                                  opacity = 0.7, layerId = "Percent Coral Bleached") %>% 
          addLegend(data = bleach_data, title = 'Percent Bleached', pal = pal_bleach,
                    position = "bottomright",
                    values = ~X7, opacity = 1, group = "Percent Bleached",
                    labFormat = labelFormat(transform = function(X7) sort(X7, decreasing = TRUE)))}
      
      else if (!is.null(input$Additional) && input$Additional == "Predicted Sewage" ){
        
        proxy  %>% clearImages() %>% clearControls() %>% 
          addRasterImage(sewage(), colors = "plasma", group = "Predicted Sewage",
                                  opacity = 0.7, layerId = "Predicted Sewage") %>% 
          addLegend(data = sew_dat, title = 'Predicted Sewage', pal = pal_sewage,
                    position = "bottomright",
                    values = ~X8, opacity = 1, group = "Predicted Sewage Index",
                    labFormat = labelFormat(transform = function(X8) sort(X8, decreasing = TRUE)))}
      else if (!is.null(input$Additional) && input$Additional == "Bathymetry" ){
        
        proxy  %>% clearImages() %>% clearControls() %>% 
          addRasterImage(bathy(), colors = "plasma", group = "Bathymetry",
                                  opacity = 0.7, layerId = "Bathymetry") %>% 
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

