source(here("ShinyAppMooreaViz", "global.R"))
# User Interface ----

ui <- fluidPage(
  
 # tags$head(
 #   tags$link(rel = "stylesheet", type = "text/css", href = "theme.css")
 # ),
  
  # Application title ----
  titlePanel(""),
  fluidPage(
    fluidRow(column(6, 
                    h1("Moorea Coral Reef LTER")),
             column(6, 
                    img(src = "mcr_logo.png", height = 60, width = 140, align = "right"), 
                    img(src = "lter_logo.png", height = 60, width = 70, align = "right"), 
                    img(src = "nsf_logo.png", height = 60, width = 60, align = "right")))),
  

  # Navigation bar ----
  navbarPage("", 
             
             #home page ----
             tabPanel("Home", icon = icon("info-circle"), 
                      fluidPage(
                        fluidRow(
                        column(12, align="center",
                      div(style="display: inline-block;",
                          img(src="Moorea Scenery_197.jpg", 
                              height=300, 
                              width=300)),
                      div(style="display: inline-block;",
                          img(src="MCR60441.jpg", 
                              height=300, 
                              width=300)),
                      div(style="display: inline-block;",
                          img(src="Underwater_Gump_080.jpg", 
                              height=300, 
                              width=300)))),
                      
                     # fluidRow(
                      #  column(12, "         ")), #trying to add space between the pictures an dwords
                      
                      fluidRow(
                        column(12, p("The Moorea Coral Reef (MCR) LTER site, established in 2004, is an interdisciplinary, landscape-scale program whose goal is to advance understanding of key mechanisms that modulate ecosystem processes and community structure of coral reefs through integrated research, education and outreach. Our site is the coral reef complex that encircles the 60 km perimeter of Moorea (17°30'S, 149°50'W), French Polynesia."), 
                               
                               p("A fundamental goal of the the Moorea Coral Reef (MCR) LTER site is to advance understanding that enables accurate forecasts of the behavior of coral reef ecosystems to environmental forcing. To this end we seek to understand the mechanistic basis of change in coral reefs by: (i) elucidating major controls over reef dynamics, and (ii) determining how they are influenced by the major pulse disturbances (e.g., cyclones, coral bleaching, coral predator outbreaks) and local press drivers (e.g., fishing, nutrient enrichment) to which they are increasingly being subjected, against a background of slowly changing environmental drivers associated with global climate change and ocean acidification."))))), 
                  
             
             
             
             
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
                                 tabsetPanel(
                                   tabPanel("Isotopic Nitrogen", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"),
                                                           p("The use of naturally occurring stable isotopes of N (15N: 14N, expressed as δ 15N) is particularly useful for distinguishing between natural and sewage-derived N because natural sources generally have low signatures while sewage-derived N is high in 15N (with δ 15N values ranging from ~ 5% to 20%) (Risk et al. 2009, Kendall et al. 2012). In the lagoons of Moorea, N likely comes from a mix of oceanic and terrestrial sources, the latter including synthetic and organic fertilizers, livestock, and human sewage. Because synthetic fertilizers tend to have δ 15N signatures that are similar to or lower than natural sources (generally ranging from -4 to 4%) (Dailer et al. 2010), elevated δ 15N values would indicate that human sewage or animal waste are important sources of N but would not rule out the importance of fertilizers or other sources."),
                                                           h3("Data Collection"), 
                                                           p("Isotopic analysis on dried and ground algal tissue was conducted using a Thermo Finnigan Delta-Plus Advantage isotope mass spectrometer with a Costech EAS elemental analyzer at the University of California, Santa Barbara, Marine Science Institute Analytical Laboratory. "), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.4", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", height = 400, width = 400)))),
                                   
                                   tabPanel("Percent Nitrogen", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           p(" Like other macroalgae, Turbinaria responds to N pulses by storing surplus N (Schaffelke 1999) and consequently N tissue content is believed to be an excellent time-integrated indicator of N availability"), 
                                                           h3("Data Collection"), 
                                                           p("To map N availability in the lagoons of Moorea, we collected samples of Turbinaria at ~ 180 sites around the island during three different sampling periods, corresponding with different rainfall and wave regimes (January 2016, May 2016, and August 2016) (Burkepile and Adam 2020). Sites were at least 0.5 km apart and were spaced to maximize coverage of the different reef habitats within the lagoons, including the fringing reefs, mid-lagoon/back reef, reef crest, reef passes, and bays. Sampling was conducted over ~ 3 weeks during each of the three sampling periods; due to logistic constraints, some sites were not sampled in all three sampling periods (January n = 184, May n = 171, August n = 173). At each of the sites, we collected thalli from 10 different patches of Turbinaria across an area of ~ 500 m2 . Samples were immediately placed on ice and transported to the laboratory. One blade from each of 10 thalli was sampled at 5 cm below the apical tip. Blades were scrubbed of epiphytes and rinsed with fresh water before being dried at 60° C to a constant weight and ground to a fine powder. Total N content was determined via elemental analysis using a CHN Carlo-Erba elemental analyzer (NA1500) at the University of Georgia, Center for Applied Isotope Studies."), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.8", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", height = 400, width = 400)))),
                                   
                                   tabPanel("Coral Bleaching", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           p("Here is why this is important"),
                                                           h3("Data Collection"), 
                                                           p("We surveyed 167 sites around Moorea and recorded bleaching on colonies of Pocillopora and Acropora, which were present at 149 of the sites. Sites were at least 0.5 km apart, and at each site two snorkelers conducted 10-minute swims in opposite directions recording all observed colonies of Pocillopora and Acropora. Sites were distributed around the entire island, and were categorized by habitat (fringing reef and back reef) and by the dominant cardinal direction of the coastline (North, East, West). We surveyed the two most common and widespread genera of branching corals in the system, Acropora and Pocillopora."), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.6", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", height = 400, width = 400)))),
                                   
                                   tabPanel("Predicted Sewage", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           p("Modeled N enrichment based on locations of septic systems and sources of untreated sewage.
"),
                                                           h3("Data Collection"), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.1039", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", height = 400, width = 400)), ))))), 
             
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
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.4", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", height = 400, width = 400)))),
                                   
                                   tabPanel("Mean Algae Cover", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           h4("Isotopic Nitrogen"), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."),
                                                           h3("Data Collection"), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.8", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", height = 400, width = 400)))),
                                   
                                   tabPanel("Mean Fish Biomass", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           h4(""), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."),
                                                           h3("Data Collection"), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.6", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", height = 400, width = 400)))),
                                   
                                   tabPanel("Crown of Thorns Density", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           h4("Isotopic Nitrogen"), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."),
                                                           h3("Data Collection"), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.1039", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", height = 400, width = 400)), )))))))
