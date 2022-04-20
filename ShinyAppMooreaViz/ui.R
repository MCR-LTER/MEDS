source(here("ShinyAppMooreaViz", "global.R"))
# User Interface ----

ui <- fluidPage(
  
  # Application title ----
  titlePanel("Moorea Coral Reef LTER"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(img(src = "mcr_logo.png", height = 60, width = 150, align = "right"), 
              img(src = "lter_logo.png", height = 60, width = 70, align = "right"), 
              img(src = "nsf_logo.png", height = 60, width = 60, align = "right"))),
  

  # Navigation bar ----
  navbarPage("", 
             
             #home page ----
             tabPanel("Home", icon = icon("info-circle"), 
                      img(src = "MCR60441.jpg", height = 400, width = 400, align = "right"),
                      
                      p("The Moorea Coral Reef (MCR) LTER site, established in 2004, is an interdisciplinary, landscape-scale program whose goal is to advance understanding of key mechanisms that modulate ecosystem processes and community structure of coral reefs through integrated research, education and outreach. Our site is the coral reef complex that encircles the 60 km perimeter of Moorea (17°30'S, 149°50'W), French Polynesia."), 
                      
                      p("A fundamental goal of the the Moorea Coral Reef (MCR) LTER site is to advance understanding that enables accurate forecasts of the behavior of coral reef ecosystems to environmental forcing. To this end we seek to understand the mechanistic basis of change in coral reefs by: (i) elucidating major controls over reef dynamics, and (ii) determining how they are influenced by the major pulse disturbances (e.g., cyclones, coral bleaching, coral predator outbreaks) and local press drivers (e.g., fishing, nutrient enrichment) to which they are increasingly being subjected, against a background of slowly changing environmental drivers associated with global climate change and ocean acidification.")),
             
             
             
             
             #spatial page ----
             
             navbarMenu("Spatial", icon = icon("globe-asia"),
                        
                        #spatial map ----
                        tabPanel(title = "Map",
                                 
                                 
                                 
                                 sidebarLayout(
                                 
                                 sidebarPanel(width = 3,
                                              # Code block for incorporating more years of data
                                              #pickerInput(inputId = "Year",
                                              #label = "Select a Year:",
                                              #choices = c("2016",
                                              #"2017",
                                              #"2018"),
                                              #multiple = FALSE,
                                              #width = 80),
                                              
                                              
                                              pickerInput(inputId = "Month",
                                                                   label = "First, Select Month:",
                                                                   choices = c("January", 
                                                                               "May", 
                                                                               "July"),
                                                          selected = "",
                                                          multiple = F,
                                                          options = pickerOptions(title = "Select Month"),
                                                                   width = 150), 
                                              
                                              pickerInput(inputId = "Variable",
                                                          selected = "",
                                                          multiple = F,
                                                          label = "Now, Select Variable:",
                                                          choices = c("Percent Nitrogen", 
                                                                      "Isotopic Nitrogen"),
                                                          options = pickerOptions(title = "Select Variable"),
                                                          width = 150),
                                              checkboxGroupButtons(inputId = "Clear_2",
                                                                   label = "Remove Layers",
                                                                   choices = c("Clear")),
                                              
                                              hr(style = "border-top: 1px solid #000000;"),
                                              
                                              pickerInput(inputId = "Additional",
                                                                   label = "Select Another Layer:",
                                                                   choices = c("Percent Coral Bleached", 
                                                                               "Predicted Sewage",
                                                                               "Bathymetry"),
                                                          selected = NULL,
                                                          multiple = F,
                                                          options = pickerOptions(title = "Select Additonal"),
                                                                   width = 150),
                                              pickerInput(inputId = "Other",
                                                                   label = "Select an Add on:",
                                                                   choices = c("LTER Sites", 
                                                                               "Observations",
                                                                               "Sites & Observations"),
                                                          selected = NULL,
                                                          multiple = F,
                                                          options = pickerOptions(title = "Select Add On"),
                                                          width = 150),                                                 
                                              checkboxGroupButtons(inputId = "Clear_1",
                                                                   label = "Remove Layers",
                                                                   choices = c("Clear"))),
                                
                        mainPanel(leafletOutput(outputId = "leaflet_base",
                                                         width = 800,
                                                         height = 500), position = c("right")))),
                        
                        
                        
                        #spatial metadata ----
                        
                        
                        tabPanel("Metadata", 
                            fluidPage(
                            titlePanel("This is the metadata for spatial"),
                            sidebarLayout(
                              sidebarPanel(width = 5, 
                                           h3("This is the Nitrogen Data"), 
                                           h4("Isotopic Nitrogen"), 
                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."),
                                           h4("Percent Nitrogen"), 
                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."),
                                           h3("This is Coral Bleaching data"), 
                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually.")
                                           ),
                              
                              mainPanel(width = 6, 
                                        img(src = "MCR60441.jpg", height = 400, width = 400))
                              )))), 
             
             #Temporal page ----
             navbarMenu("Temporal", icon = icon("chart-line"),
                        
                        #figures by variable panel ----
                        tabPanel("Figures by Variable",
                                 (pickerInput(inputId = "Temp_Variable",
                                              label = "Select a Variable",
                                              choices = c("Mean Coral Cover" = "mean_coral_cover",
                                                          "Mean Algae Cover" = "mean_algae_cover",
                                                          "Mean Fish Biomass" = "mean_biomass_p_consumers",
                                                          "COTS Density" = "cots_density"), 
                                              multiple = FALSE)),
                                 plotOutput(outputId = "faceted_plot")),
                        
                        #figures by site panel ----        
                        tabPanel("Figures by Site",
                                 sidebarPanel(checkboxGroupInput(inputId = "site", 
                                                                 label = h4("Choose your Site"),
                                                                 selected = "LTER 1",
                                                                 choices = list("Site 1" = "LTER 1",
                                                                                "Site 2" = "LTER 2", 
                                                                                "Site 3" = "LTER 3", 
                                                                                "Site 4" = "LTER 4", 
                                                                                "Site 5" = "LTER 5", 
                                                                                "Site 6" = "LTER 6"))),
                                 mainPanel(plotOutput(outputId = "variables_by_site_plot"))),
                        

                        #figures by site option 2 ----
                        useShinydashboard(),

                        tabPanel("Figures by Site (option 2)",
                                 column(width = 4,
                                        box(checkboxGroupInput(inputId = "site_2",
                                                               label = h4("Choose your Site"),
                                                               selected = "LTER 1",
                                                               choices = list("Site 1" = "LTER 1",
                                                                              "Site 2" = "LTER 2",
                                                                              "Site 3" = "LTER 3",
                                                                              "Site 4" = "LTER 4",
                                                                              "Site 5" = "LTER 5",
                                                                              "Site 6" = "LTER 6")))
                                   ),

                                 mainPanel(
                                   fluidRow(
                                     box(width = 12,
                                         title = "Plot 1",
                                         plotOutput(outputId = "test_coral_plot"))),
                                   fluidRow(
                                     box(width = 12,
                                         title = "Plot 2",
                                         plotOutput(outputId = "test_algae_plot"))),
                                   fluidRow(
                                     box(width = 12,
                                         title = "Plot 3",
                                         plotOutput(outputId = "test_cots_plot"))),
                                   fluidRow(
                                     box(width = 12,
                                         title = "Plot 4",
                                         plotOutput(outputId = "test_biomass_plot"))))
                                   ), 
                        
                        #temporal metadata ----

                        tabPanel("Metadata",
                                 tabsetPanel(
                                   tabPanel("Mean Coral Cover", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           h4("Isotopic Nitrogen"), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."),
                                                           h3("Data Collection"), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually.")
                                              ),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", height = 400, width = 400))
                                            )),
                                   tabPanel("Mean Algae Cover"),
                                   tabPanel("Mean Fish Biomass"),
                                   tabPanel("Crown of Thorns Density")
                                   
                                  )))))



