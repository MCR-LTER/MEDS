source(here("ShinyAppMooreaViz", "global.R"))
# User Interface ----

ui <- fluidPage(
  
  # Themeing!
  includeCSS("theme.css"),
  tags$head(tags$style(HTML('.navbar {background-color: #6ebee0; color:#0f4d76}',
             '.navbar-default .navbar-nav>.active>a, .navbar-default .navbar-nav>.active>a:focus, .navbar-default .navbar-nav>.active>a:hover {color: #2084C9; background-color: #d6e7f1;}'
                            ))),
  
  # Application title ----
  titlePanel(""),
  fluidPage(
    fluidRow(column(6, 
                    h1("Moorea Coral Reef LTER")),
             column(6, 
                    HTML("<a href='http://mcr.lternet.edu/'><img src='mcr_logo.png' align= 'right' height= '60' width = '150' /></a>"),
                    HTML("<a href='https://lternet.edu/'><img src='lter_logo.png' align= 'right' height= '60' width = '70' /></a>"),
                    HTML("<a href='https://www.nsf.gov/'><img src='nsf_logo.png' align= 'right' height= '60' width = '60' /></a>")))),
  

  # Navigation bar ----
  navbarPage("", 
             
             #home page ----
             tabPanel("Home", icon = icon("info-circle"), 
                      fluidPage(
                        fluidRow(
                        column(12, align="center",
                      div(style="display: inline-block;",
                          img(src="Underwater_Gump_095.jpg", 
                              height=300, 
                              width=300)),
                      div(style="display: inline-block;",
                          img(src="Moorea Scenery_197.jpg", 
                              height=300, 
                              width=300)),
                      div(style="display: inline-block;",
                          img(src="Underwater_Gump_080.jpg", 
                              height=300, 
                              width=300)))),
                      
                      h1("Background"),
                      
                      fluidRow(
                        column(12, p("The Moorea Coral Reef (MCR) LTER site, established in 2004, is an interdisciplinary, landscape-scale program whose goal is to advance understanding of key mechanisms that modulate ecosystem processes and community structure of coral reefs through integrated research, education and outreach. Our site is the coral reef complex that encircles the 60 km perimeter of Moorea (17°30'S, 149°50'W), French Polynesia."), 
                               
                               p("A fundamental goal of the the Moorea Coral Reef (MCR) LTER site is to advance understanding that enables accurate forecasts of the behavior of coral reef ecosystems to environmental forcing. To this end we seek to understand the mechanistic basis of change in coral reefs by: (i) elucidating major controls over reef dynamics, and (ii) determining how they are influenced by the major pulse disturbances (e.g., cyclones, coral bleaching, coral predator outbreaks) and local press drivers (e.g., fishing, nutrient enrichment) to which they are increasingly being subjected, against a background of slowly changing environmental drivers associated with global climate change and ocean acidification."), 
                               
                               p("The Moorea Coral Reef LTER site became the 26th node in the U.S. Long-Term Ecological Research (LTER) program in September of 2004. The Moorea Coral Reef LTER site encompasses the coral reef complex that surrounds the island of Moorea, French Polynesia (17°30'S, 149°50'W). Moorea is a small, triangular volcanic island 20 km west of Tahiti in the Society Islands of French Polynesia."))), 
                      
                      h1("Outreach"), 
                      
                      fluidRow(
                        column(4, 
                               img(src="Local Outreach_Gump_071.jpg", 
                                   height=300, 
                                   width=400)),
                        column(8, 
                               p("The MCR likes to do outreach!
                                 The Coral Reefs of Moorea Education is an educational resource of the Moorea Coral Reef Long Term Ecological Research (LTER) program. A website was created in an effort to inform students and the public about the ocean, corals reefs, and the research of the MCR LTER program. An exciting feature of this website is the Marine Life of Moorea Encyclopedia, where visitors can learn about the organisms that make up Moorea’s coral reef ecosystem. Our Lesson Plan Library contains FREE standards-based curricula available for download that focus on the coral reef ecosystem and current MCR LTER research. These hands-on activities are a great way for educators to teach Life Science and Investigation content standards in their classrooms."), 
                               p("Undergraduate students at universities affiliated with the MCR LTER have the opportunity to get hands-on research experience in the lab and in the field. Check out the Undergraduate Education page for more information."))),
                      
                      
                      h1("What this app is for??"), 
                      
                      fluidRow(
                        column(12, p("The Moorea Coral Reef (MCR) LTER site, established in 2004, is an interdisciplinary, landscape-scale program whose goal is to advance understanding of key mechanisms that modulate ecosystem processes and community structure of coral reefs through integrated research, education and outreach. Our site is the coral reef complex that encircles the 60 km perimeter of Moorea (17°30'S, 149°50'W), French Polynesia."), 
                               
                               p("A fundamental goal of the the Moorea Coral Reef (MCR) LTER site is to advance understanding that enables accurate forecasts of the behavior of coral reef ecosystems to environmental forcing. To this end we seek to understand the mechanistic basis of change in coral reefs by: (i) elucidating major controls over reef dynamics, and (ii) determining how they are influenced by the major pulse disturbances (e.g., cyclones, coral bleaching, coral predator outbreaks) and local press drivers (e.g., fishing, nutrient enrichment) to which they are increasingly being subjected, against a background of slowly changing environmental drivers associated with global climate change and ocean acidification."))),
                      
                      
                      h1("A bit about the data used in this app"),
                      
                      fluidRow(
                        column(6,
                               p("Data collected at MCR LTER are released under the", 
                                 tags$a(href="https://creativecommons.org/licenses/by/4.0/", 
                                        "Creative Commons license Attribution 4.0 International."),
                                 "This license states that consumers (Data Users herein) may distribute, adapt, reuse, remix, and build upon this work, as long as they give appropriate credit, provide a link to the license, and indicate if changes were made. If redistributed, a Data User may not apply additional restrictions or technological measures that prevent access."), 
                               
                               p("The Data User has an ethical obligation to cite the data source appropriately in any publication or product that results from its use, and notify the data contact or creator. Communication, collaboration, or co-authorship (as appropriate) with the creators of this data package is encouraged to prevent duplicate research or publication. The Data User is urged to contact the authors of these data if any questions about methodology or results occur. The Data User should realize that these data may be actively used by others for ongoing research and that coordination may be necessary to prevent duplication or inappropriate use. The Data User should realize that misinterpretation may occur if data are used outside of the context of the original study. The Data User should be aware that data are updated periodically and it is the responsibility of the Data User to check for new versions of the data."), 
                               
                               p("While substantial efforts are made to ensure the accuracy of data and associated documentation, complete accuracy of data sets cannot be guaranteed. This data package (with its components) is made available as is and with no warranty of accuracy or fitness for use. The creators of this data package and the repository where these data were obtained shall not be liable for any damages resulting from misinterpretation, use or misuse of the data package or its components."),
                                 
                                 p("The user agrees to cite the data set author and MCR LTER in all publications in which the data are used, as per the instructions in the data documentation.")), 
                      
                        column(6,align="center",
                               img(src="Work Around Gump_011.jpg", 
                                   height=400, 
                                   width=500))),
                      
                      h1("About the creators of this app?")
                  )), 
                  
             
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
                                                           p(" To map N availability in the lagoons of Moorea, samples were collected of Turbinaria at ~ 180 sites around the island during three different sampling periods, corresponding with different rainfall and wave regimes (January 2016, May 2016, and August 2016) (Burkepile and Adam 2020). Sites were at least 0.5 km apart and were spaced to maximize coverage of the different reef habitats within the lagoons, including the fringing reefs, mid-lagoon/back reef, reef crest, reef passes, and bays. Sampling was conducted over ~ 3 weeks during each of the three sampling periods; due to logistic constraints, some sites were not sampled in all three sampling periods (January n = 184, May n = 171, August n = 173). At each of the sites, thalli was collected from 10 different patches of Turbinaria across an area of ~ 500 m2. Isotopic analysis on dried and ground algal tissue was conducted using a Thermo Finnigan Delta-Plus Advantage isotope mass spectrometer with a Costech EAS elemental analyzer at the University of California, Santa Barbara, Marine Science Institute Analytical Laboratory. "), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.4", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "Underwater_Gump_063.jpg", 
                                                            height = 400, 
                                                            width = 400)))),
                                   
                                   tabPanel("Percent Nitrogen", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           p(" Like other macroalgae, Turbinaria responds to N pulses by storing surplus N (Schaffelke 1999) and consequently N tissue content is believed to be an excellent time-integrated indicator of N availability"), 
                                                           h3("Data Collection"), 
                                                           p("To map N availability in the lagoons of Moorea, samples were collected of Turbinaria at ~ 180 sites around the island during three different sampling periods, corresponding with different rainfall and wave regimes (January 2016, May 2016, and August 2016) (Burkepile and Adam 2020). Sites were at least 0.5 km apart and were spaced to maximize coverage of the different reef habitats within the lagoons, including the fringing reefs, mid-lagoon/back reef, reef crest, reef passes, and bays. Sampling was conducted over ~ 3 weeks during each of the three sampling periods; due to logistic constraints, some sites were not sampled in all three sampling periods (January n = 184, May n = 171, August n = 173). At each of the sites, thalli was collected from 10 different patches of Turbinaria across an area of ~ 500 m2. Samples were immediately placed on ice and transported to the laboratory. One blade from each of 10 thalli was sampled at 5 cm below the apical tip. Blades were scrubbed of epiphytes and rinsed with fresh water before being dried at 60° C to a constant weight and ground to a fine powder. Total N content was determined via elemental analysis using a CHN Carlo-Erba elemental analyzer (NA1500) at the University of Georgia, Center for Applied Isotope Studies."), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.8", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60369.jpg", 
                                                            height = 400, 
                                                            width = 400)))),
                                   
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
                                                        img(src = "MCR60402.jpg", 
                                                            height = 400, 
                                                            width = 400)))),
                                   
                                   tabPanel("Predicted Sewage", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           p("dhhdehfl3"),
                                                           h3("Data Collection"), 
                                                           p("Sewage"), 
                                                           p("This dataset is not avaible 
                                                             for download through the MCR as 
                                                             the data was collected by....")),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", 
                                                            height = 400, 
                                                            width = 400))))))), 
             
             #Temporal page ----
             navbarMenu("Temporal", icon = icon("chart-line"),
                        
                        #figures by variable panel ----
                        tabPanel("Figures by Variable",
                                 (pickerInput(inputId = "habitat",
                                              label = "Select a Habitat",
                                              choices = c("Fringing Reef" = "Fringing",
                                                          "Forereef" = "Forereef"),
                                              multiple = FALSE)),
                                 (pickerInput(inputId = "Temp_Variable",
                                              label = "Select a Variable",
                                              choices = c("Mean Percent Coral Cover" = "mean_coral_cover",
                                                          "Mean Percent Algae Cover (Macroalgae)" = "mean_macroalgae_cover",
                                                          "Mean Herbivore Fish Biomass" = "mean_biomass_p_consumers",
                                                          "Crown-of-Thorns Density" = "cots_density",
                                                          "Mean Percent Coral Cover (Pocillopora)" = "Pocillopora",
                                                          "Mean Percent Coral Cover (Porites)" = "Porites",
                                                          "Mean Percent Coral Cover (Acropora)" = "Acropora",
                                                          "Mean Percent Algae Cover (CTB)" = "mean_CTB_algae_cover"), 
                                              multiple = FALSE)),
                                 plotOutput(outputId = "faceted_plot")),

                        

                        #figures by site option 2 ----
                        useShinydashboard(),

                        tabPanel("Figures by Site",
                                 column(width = 4,
                                        box(selectInput(inputId = "habitat_2",
                                                         label = "Select a Habitat",
                                                         choices = c("Fringing",
                                                                     "Forereef"),
                                                        multiple = F),
                                          checkboxGroupInput(inputId = "site_2",
                                                               label = h4("Choose your Site"),
                                                               selected = "LTER 1",
                                                               choices = list("LTER 1",
                                                                              "LTER 2",
                                                                              "LTER 3",
                                                                              "LTER 4",
                                                                              "LTER 5",
                                                                              "LTER 6")))
                                   ),

                                 mainPanel(
                                   fluidRow(
                                     box(width = 12,
                                         title = "Mean Percent Coral Cover",

                                         plotOutput(outputId = "coral_plot"))),
                                   fluidRow(
                                     box(width = 12,
                                         title = "Mean Percent Algae Cover (Macroalgae)",
                                         plotOutput(outputId = "algae_plot"))),
                                   fluidRow(
                                     box(width = 12,
                                         title = "Crown-of-Thorns Density",
                                         plotOutput(outputId = "cots_plot"))),
                                   fluidRow(
                                     box(width = 12,
                                         title = "Mean Herbivore Fish Biomass",
                                         plotOutput(outputId = "biomass_plot"))))
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
                                                        img(src = "MCR60366.jpg", height = 400, width = 400)))),
                                   
                                   tabPanel("Mean Algae Cover", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           h4("Isotopic Nitrogen"), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."),
                                                           h3("Data Collection"), 
                                                           p("There is misisng data values for 2020 as during covid the camera used to collect the data could not decifer between the different algae types, turf, and sand. "), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.8", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "Work Around Gump_044.jpg", height = 400, width = 400)))),
                                   
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
                                                        img(src = "MCR60459.jpg", height = 400, width = 400)))),
                                   
                                   tabPanel("Crown of Thorns Density", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"),
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."),
                                                           h3("Data Collection"), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."), 
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.1039", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "Underwater_Gump_095.jpg", height = 400, width = 400))
                                              )))))))
