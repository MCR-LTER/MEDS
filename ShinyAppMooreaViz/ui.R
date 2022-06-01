source(here("ShinyAppMooreaViz", "global.R"))
# User Interface ----

ui <- fluidPage(
  
  # Themeing! ----
  includeCSS(here("ShinyAppMooreaViz/theme.css")),
  
  # set theme 
  theme = bs_theme(bootswatch = "sandstone",
                   bg = "#e3f1fa", # light blue
                   fg = "#0076a0", # MCR dark blue from bottom of page
                   primary = "#a9a9a9", # MCR dark blue font
                   secondary = "#0f4d76", # blue controls the clear buttons
                   success = "#397B1E", # light green
                   info = "#97D4EA", # light blue from bar
                   warning = "#C3512C",# yellow
                   danger = "#FACE00", # orange red
                   base_font = font_google("Open Sans"), 
                   heading_font = font_google("Source Sans Pro")),

  
  # Application title ----
  titlePanel(""),
  fluidPage(
    fluidRow(column(6, 
                    h1("Moorea Coral Reef LTER")),
             column(6, 
                    HTML("<a href='http://mcr.lternet.edu/'><img src='mcr_logo.png' align= 'right' height= '60' width = '150' alt='This is the Moorea Coral Reef logo' /></a>"),
                    HTML("<a href='https://lternet.edu/'><img src='lter_logo.png' align= 'right' height= '60' width = '70' alt='This is the Long Term Ecological Research Program logo' /></a>"),
                    HTML("<a href='https://www.nsf.gov/'><img src='nsf_logo.png' align= 'right' height= '60' width = '60' alt='This is the National Science Foundation logo'/></a>")))),
  

  # Navigation bar ----
  navbarPage("", 
             
             #home page ----
             tabPanel("Home", icon = icon("info-circle"), 
                      fluidPage(
                        fluidRow(
                        column(12, align="center",
                      div(style="display: inline-block;",
                          img(src="Underwater_Gump_095.jpg", 
                              height = 300, 
                              width = 300, 
                              alt = "Photo of one brown coral head in the middle of the picture surrounded by blue water")),
                      div(style="display: inline-block;",
                          img(src="Moorea Scenery_197.jpg", 
                              height=300, 
                              width=300, 
                              alt = "Photo of Moorea scenery, with tall green mountians, blue sky with white clounds and the bottom half of the page the blue ocean. ")),
                      div(style="display: inline-block;",
                          img(src="Underwater_Gump_080.jpg", 
                              height=300, 
                              width=300, 
                              alt = "A shot of the coral reef and water column, with sreaks from the sun shining through the water")))),
                      
                      h1("Background"),
                      
                      fluidRow(
                        column(12, p("The Moorea Coral Reef (MCR) LTER site, established in 2004, is an interdisciplinary, landscape-scale program whose goal is to advance understanding of key mechanisms that drive ecosystem processes and community dynamics of coral reefs through integrated research, education, and outreach. The research site is the coral reef complex that encircles the 60 km perimeter of Moorea (17°30'S, 149°50'W), French Polynesia."), 
                               
                               p("A fundamental goal of the Moorea Coral Reef (MCR) LTER site is to advance our understanding of coral reef community dynamics that can then be used to predict precise and accurate community dynamics through the lense of changing environmental variables. We seek to understand the mechanistic basis of change in coral reefs by: (i) elucidating major controls over reef dynamics, and (ii) determining how they are influenced by the major pulse disturbances (e.g., cyclones, coral bleaching, coral predator outbreaks) and local press drivers (e.g., fishing, nutrient enrichment) to which they are increasingly being subjected, against a background of slowly changing environmental drivers associated with global climate change and ocean acidification."), 
                               
                               p("The Moorea Coral Reef LTER site became the 26th node in the U.S. Long-Term Ecological Research (LTER) program in September of 2004. The Moorea Coral Reef LTER site can act as a model for pacific island coral reef community dynamics and is located at the island of Moorea, French Polynesia (17°30'S, 149°50'W). Moorea is a small, triangular volcanic island 20 km west of Tahiti in the Society Islands of French Polynesia."))), 
                      
                      h1("Outreach"), 
                      
                      fluidRow(
                        column(4, 
                               img(src="Local Outreach_Gump_071.jpg", 
                                   height=300, 
                                   width=400, 
                                   alt = "A photo of some MCR staff and young children looking at animals in touch tanks")),
                        column(8, 
                               p("The MCR LTER supports many different outreach and educational efforts. The",
                                 tags$a(href = "http://mcrlter.msi.ucsb.edu/education/", 
                                        "Coral Reefs of Moorea Education"),
                                 "is an educational resource of the Moorea Coral Reef Long Term Ecological Research (LTER) program. A website was created in an effort to inform students and the public about the ocean, corals reefs, and the research of the MCR LTER program. An exciting feature of this website is the", 
                                 tags$a(href = "http://mcrlter.msi.ucsb.edu/education/encyclopedia/",
                                        "Marine Life of Moorea Encyclopedia"),", where visitors can learn about the organisms that make up Moorea’s coral reef ecosystem. Our",
                                 tags$a(href = "http://mcrlter.msi.ucsb.edu/education/lessonplans.html",
                                        "Lesson Plan Library"), "contains FREE standards-based curricula available for download that focus on the coral reef ecosystem and current MCR LTER research. These hands-on activities are a great way for educators to teach students about scientific standards and coral reef ecology in their classrooms."), 
                               p("Undergraduate students at universities affiliated with the MCR LTER have the opportunity to get hands-on research experience in the lab and in the field. Check out the",
                                 tags$a(href = "http://mcr.lternet.edu/education/undergraduate-education", 
                                        "Undergraduate Education") ,
                                 "page for more information."),
                               p("Many of the important discoveries made by MCR LTER scientists are the result of graduate student research. Our", 
                                 tags$a(href = "http://mcrlter.msi.ucsb.edu/education/gradresearch.html", 
                                        "Graduate Education"), 
                                 "page describes some of the exciting projects being conducted by MCR LTER graduate students."))),
                      
                      h1("App Purpose"), 
                      
                      fluidRow(
                        column(12, p("Every year, MCR researchers collect data on a wide variety of biotic and abiotic variables at different spatial and temporal resolutions, but there has been no easy way for researchers to quickly visualize these changes across space and time. To address this issue, this interactive web application has been developed for MCR LTER researchers to quickly visualize and explore community dynamics, ecological changes, and anthropogenic stressors affecting the coral reefs surrounding Moorea. Built using the Shiny package in R, this web app allows users to hone in on certain locations or variables of interest in order to identify vulnerable areas within the coral reefs and explore coral reef ecosystem dynamics. Additionally, this app will act as a research and outreach tool to bring awareness to the status of coral reefs and allow for better management and protection of Moorea’s coral reefs. 
"), 
                               
                               p("In the navigation bar you will find two tabs, one to explore spatial data and one to explore temporal data. This Shiny application currently uses 2016 spatial data with layers for percent nitrogen and isotopic nitrogen levels drawn from Turbinaria ornata samples, percent coral bleaching, indexed predicted sewage, and LiDAR bathymetry. After interpolating the spatial data through ordinary kriging, individual raster layers for each variable were created. The layers were then combined into an interactive map where the user can choose to explore the variables of interest. The second component of the app includes temporal visualizations produced from the six long-term LTER sites with data aggregated to annual site means for percent coral cover, percent macro-algae cover, percent cover of CTB (CCA, turf algae, and bare space), herbivore fish biomass density, crown-of-thorns seastar density, and percent cover for three coral genera:", em("Pocillopora, Acropora,"), "and", em("Porites."), "There are two temporal options within the app in which the user can choose between visualizations by variable and visualizations by site. Visualizations by variable can be helpful for a user to explore the trends of a single variable across all sites. Visualizations by site can be helpful for a user to compare trends across multiple variables for the sites of interest. For more information on spatial and temporal data collection, importance, and download, please see the corresponding Metadata tabs."),

                                p("The GitHub repository including all files and code associated with the creation of this Shiny app can be found",
                                  tags$a(href = "https://github.com/MCR-LTER/MEDS",
                                         "here"),"."))),
                      
                      
                      h1("Data Use Policy"),
                      
                      fluidRow(
                        column(6,
                               p("Data collected at MCR LTER are released under the", 
                                 tags$a(href="https://creativecommons.org/licenses/by/4.0/", 
                                        "Creative Commons license Attribution 4.0 International."),
                                 "This license states that consumers (Data Users herein) may distribute, adapt, reuse, remix, and build upon this work, as long as they give appropriate credit, provide a link to the license, and indicate if changes were made. If redistributed, a Data User may not apply additional restrictions or technological measures that prevent access."), 
                               
                               p("The Data User has an ethical obligation to cite the data source appropriately in any publication or product that results from its use, and notify the data contact or creator. Communication, collaboration, or co-authorship (as appropriate) with the creators of this data package is encouraged to prevent duplicate research or publication. The Data User is urged to contact the owners of these data if any questions about methodology or results occur. The Data User should realize that these data may be actively used by others for ongoing research and that coordination may be necessary to prevent duplication or inappropriate use. The Data User should realize that misinterpretation may occur if data are used outside of the context of the original study. The Data User should be aware that data are updated periodically and it is the responsibility of the Data User to check for new versions of the data."), 
                               
                               p("While substantial efforts are made to ensure the accuracy of data and associated documentation, complete accuracy of data sets cannot be guaranteed. This data package (with its components) is made available as is and with no warranty of accuracy or fitness for use. The creators of this data package and the repository where these data were obtained shall not be liable for any damages resulting from misinterpretation, use or misuse of the data package or its components."),
                                 
                                 p("The user agrees to cite the data set author and MCR LTER in all publications in which the data are used, as per the instructions in the data documentation.")), 
                      
                        column(6,align="center",
                               img(src="Work Around Gump_011.jpg", 
                                   height=400, 
                                   width=500, 
                                   alt = "A picture of two women working in a boat, one reaching towards the otehr who is in the water"))),
                      
                      h1("About the Creators"),
                      fluidRow(
                        column(6, p("This application was created by students in the 2022 Master of Environmental Data Science program at UCSB's Bren School of Environmental Science & Management as the focus of their Master's Capstone Project."), 
                               
                               p("The creators include Charles Hendrickson, Jake Eisaguirre, Allie Cole, and Felicia Cruz (in order of photo).")),
                        column(6, align = "center",
                               img(src = "MooreaViz.jpg",
                                   height=300,
                                   width=300,
                                   alt = "The four MEDS students who created this Shiny application."))),
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
                                              sidebarPanel(width = 6, 
                                                           h3("Background"),
                                                           p("The use of naturally occurring stable isotopes of N (15N: 14N, expressed as δ 15N) is particularly useful for distinguishing between natural and sewage-derived nitrogen because natural sources generally have low signatures while sewage-derived N is high in 15N (with δ 15N values ranging from ~ 5% to 20%) (MCR LTER research). In the lagoons of Moorea, nitrogen likely comes from a mix of oceanic and terrestrial sources, the latter including synthetic and organic fertilizers, livestock, and human sewage. Because synthetic fertilizers tend to have δ 15N signatures that are similar to or lower than natural sources (generally ranging from -4 to 4%) (Dailer et al. 2010), elevated δ 15N values would indicate that human sewage or animal waste are important sources of nitrogen but would not rule out the importance of fertilizers or other sources. For further background and details on data collection see Adam et al. 2021."),
                                                           h3("Data Collection"), 
                                                           p("To map nitrogen levels in the lagoons of Moorea, samples were collected of Turbinaria at ~ 180 sites around the island during three different sampling periods, corresponding with different rainfall and wave regimes (January 2016, May 2016, and August 2016) (Burkepile and Adam 2020). Sites were at least 0.5 km apart and were spaced to maximize coverage of the different reef habitats within the lagoons, including the fringing reefs, mid-lagoon/back reef, reef crest, reef passes, and bays. Sampling was conducted over ~ 3 weeks during each of the three sampling periods; due to logistic constraints, some sites were not sampled in all three sampling periods (January n = 184, May n = 171, August n = 173). At each of the sites, thalli were collected from 10 different patches of Turbinaria across an area of ~ 500 m2. Isotopic analysis on dried and ground algal tissue was conducted using a Thermo Finnigan Delta-Plus Advantage isotope mass spectrometer with a Costech EAS elemental analyzer at the University of California, Santa Barbara, Marine Science Institute Analytical Laboratory."), 
                                                           h3("Importance"), 
                                                           p("Knowing the levels of isotopic nitrogen throughout the lagoon will help researchers identify locations on the reef that may be prone to macroalgae over growth, possible coral bleaching, and increased transmission of coral diseases due to human waste. Areas with consistently high levels of nitrogen can be examined to determine where the input source of human waste is coming from."),
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.4", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "Underwater_Gump_063.jpg", 
                                                            height = 400, 
                                                            width = 400, 
                                                            alt = "Photo of a scuba diver holding tools and algae")))),
                                   
                                   tabPanel("Percent Nitrogen", 
                                            sidebarLayout(
                                              sidebarPanel(width = 6, 
                                                           h3("Background"), 
                                                           p("Like other macroalgae, Turbinaria responds to nitrogen pulses by storing surplus nitrogen (Schaffelke 1999) and consequently nitrogen tissue content is believed to be an excellent time-integrated indicator of nitrogen availability. For further background and details on data collection see Adam et al. 2021."), 
                                                           h3("Data Collection"), 
                                                           p("To map N availability in the lagoons of Moorea, samples were collected of Turbinaria at ~ 180 sites around the island during three different sampling periods, corresponding with different rainfall and wave regimes (January 2016, May 2016, and August 2016) (Burkepile and Adam 2020). Sites were at least 0.5 km apart and were spaced to maximize coverage of the different reef habitats within the lagoons, including the fringing reefs, mid-lagoon/back reef, reef crest, reef passes, and bays. Sampling was conducted over ~ 3 weeks during each of the three sampling periods; due to logistic constraints, some sites were not sampled in all three sampling periods (January n = 184, May n = 171, August n = 173). At each of the sites, thalli were collected from 10 different patches of Turbinaria across an area of ~ 500 m2. Samples were immediately placed on ice and transported to the laboratory. One blade from each of 10 thalli was sampled at 5 cm below the apical tip. Blades were scrubbed of epiphytes and rinsed with fresh water before being dried at 60° C to a constant weight and ground to a fine powder. Total nitrogen content was determined via elemental analysis using a CHN Carlo-Erba elemental analyzer (NA1500) at the University of Georgia, Center for Applied Isotope Studies."), 
                                                           
                                                           h3("Importance"), 
                                                           p("Knowing the levels of nitrogen throughout the lagoon will help researchers identify locations on the reef that may be prone to macroalgae over growth, possible coral bleaching, and increased transmission of coral diseases. This knowledge can help guide management decisions."),
                                                           
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.8", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60369.jpg", 
                                                            height = 400, 
                                                            width = 400, 
                                                            alt = "Photo of a scuba diver holding tools")))),
                                   
                                   tabPanel("Coral Bleaching", 
                                            sidebarLayout(
                                              sidebarPanel(width = 6, 
                                                           h3("Background"), 
                                                           p("Coral Bleaching is the whitening of corals due to expulsion of symbiotic algae and/or their pigments, which can lead to coral mortality (Brown 1997). Bleaching events are increasing in frequency and magnitude due to climate change causing increases in maximum water temperatures that exceed coral heat stress thresholds. Additionally, nutrient pollution from coastal development can act synergistically with heat stress to increase coral bleaching (Donovan et al. 2020). This data set was collected from coral bleaching surveys that were conducted to test the hypothesis that bleaching prevalence and severity were correlated with differences in heat stress and nutrient availability."),
                                                           h3("Data Collection"), 
                                                           p("167 sites were surveyed around Moorea and bleaching on colonies of", em("Pocillopora"), "and", em("Acropora"), "were recorded, which were present at 149 of the sites. Sites were at least 0.5 km apart, and at each site two snorkelers conducted 10-minute swims in opposite directions recording all observed colonies of", em("Pocillopora"), "and", em("Acropora,"), "the two most common and widespread genera of branching corals in the system. Sites were distributed around the entire island, and were categorized by habitat (fringing reef and back reef) and by the dominant cardinal direction of the coastline (North, East, West)."), 
                                                           h3("Importance"), 
                                                           p("Visualizing the spatial extent of coral bleaching is critical for researchers as they can quickly see a snapshot of the entire reef's health following a thermal stress event. Understanding where corals are more prone to bleaching can help scientists understand the factors driving coral bleaching and can help guide spatial management."),
                                                           p("Here is the link to download this", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.5033", 
                                                                    "dataset"))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60402.jpg", 
                                                            height = 400, 
                                                            width = 400, 
                                                            alt = "Photo of white coral that had been bleached, with purple tips")))),
                                   
                                   tabPanel("Predicted Sewage", 
                                            sidebarLayout(
                                              sidebarPanel(width = 6, 
                                                           h3("Background"), 

                                                           p("Spatial patterns of nitrogen (N) enrichment are found to be associated with anthropogenic N inputs into Moorea's lagoons, such as sewage. Additionally, isotopic nitrogen (δ 15N) signatures were well predicted by modeled sewage input, particularly during the rainy season when waste treatment systems may be overwhelmed, suggesting that δ 15N is a good proxy for anthropogenic nutrients (Adam et al. 2021). Overall, Nitrogen enrichment in the form of sewage can damage the health of coral reefs, making it an important variable to map around Moorea's lagoons."),


                                                           h3("Data Collection"), 
                                                           p("The relative sewage discharge was mapped by combining household density along the coast and the water treatment system used in each individual household (n = 8,614). Each treatment system was assigned a value based on its overall environmental impact (no treatment = 2; treatment with a sump = 1; and treatment with a plant = 0; data from ISPF), which was subsequently used as a weighting component of household density. Then this was extrapolated onto the reef using linear decay, assuming that pollution from sewage discharge spread linearly into the lagoon from the source. Kernel estimation was completed using the Heatmap plugin in QGIS v2.18.14 (QGIS Development Team 2016) (Adam et al. 2021)."), 
                                                           p("This dataset is not avaible for download through the MCR."),
                                                     
                                                           h3("Importance"),
                                                           p("Sewage run-off can lead to nutrient loading which can cause macroalgae over growth, possible coral bleaching, and increased transmission of coral diseases for the Moorea Lagoon. Identifying locations where human sewage input could be high could inform mitigation plans to reduce the amount of human sewage entering the Moorea Lagoon.")),

                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60441.jpg", 
                                                            height = 400, 
                                                            width = 400, 
                                                            alt = ""))))))), 

             #Temporal page ----
             navbarMenu("Temporal", icon = icon("chart-line"),
                        
                        #figures by variable panel ----
                        tabPanel("Figures by Variable", 
                                 
                                 sidebarLayout(
                                   sidebarPanel( width = 3,
                                 
                                 (pickerInput(inputId = "habitat",
                                              label = "Select a Habitat",
                                              choices = c("Fringing Reef" = "Fringing",
                                                          "Forereef" = "Forereef"),
                                              multiple = FALSE)),
                                 (pickerInput(inputId = "Temp_Variable",
                                              label = "Select a Variable",
                                              choices = c("Mean Percent Coral Cover" = "mean_coral_cover",
                                                          "Mean Percent Algae Cover (Macroalgae)" = "mean_macroalgae_cover",
                                                          "Total Herbivore Fish Biomass Density" = "total_biomass_p_consumers",
                                                          "Crown-of-Thorns Density" = "cots_density",
                                                          "Mean Percent Coral Cover (Pocillopora)" = "Pocillopora",
                                                          "Mean Percent Coral Cover (Porites)" = "Porites",
                                                          "Mean Percent Coral Cover (Acropora)" = "Acropora",
                                                          "Mean Percent Algae Cover (CTB)" = "mean_CTB_algae_cover"), 
                                              multiple = FALSE))),
                                 
                                 mainPanel(plotOutput(outputId = "faceted_plot")))),

                        

                        #figures by site option 2 ----
    
                        tabPanel("Figures by Site",
                                 
                                 sidebarLayout(
                                   
                                 sidebarPanel(width = 3,
                                        selectInput(inputId = "habitat_2",
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
                                                                              "LTER 6"))),

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
                                         title = "Total Herbivore Fish Biomass Density",
                                         plotOutput(outputId = "biomass_plot"))))
                                   )), 
                        
                        #temporal metadata ----

                        tabPanel("Metadata",
                                 tabsetPanel(
                                   tabPanel("Mean Percent Coral Cover", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           p("This dataset contains the percentage cover of the stony corals (Scleractinia) and other major groups analyzed from 0.5 x 0.5 m photographic quadrats in several reef habitats at the Moorea Coral Reef LTER, French Polynesia. This survey has been repeated annually in April since 2005. Functional groups (i.e., dependent variables) counted are: Scleractinian Corals (by genus where appropriate, see methods), Macroalgae, Crustose Coralline Algae / Bare Space, Soft Corals, Hydrocorals (Millepora), Algal Turf and Sand. The coral community was sampled photographically in all habitats surrounding the island: Fringing Reef, Lagoon (Backreef), and Outer Reef (Forereef.) Here we show the Fringing reef and Forereef at 10 m. Figures were further broken down to show individual trends of three specific Scleractinian genera of coral,", em("Porities, Acropora, Pocillopora.")),
                                                           
                                                           h3("Data Collection"), 
                                                           p("The sampling strategy was designed to facilitate tests of the effect of time, shore, and depth on the coral community structure of the fringing, and outer reef habitats of Moorea. For the purpose of this analysis, fringing communities were defined as reefs adjacent to the shore and within ca. 50 m of the land. Outer reef habitats were censused at 10 and 17 m depth in order to sample habitats that are representative of the outer reefs of Moorea, and within the depth range tractable to diving research. For the purposes of this app only the depths of 10 m were used in the visualizations. The project was designed with 40 quadrats at each site/depth combination, but sometimes this number was not achieved because all quadrats did not fit in the space measured between markers (a perpetual effect once the site was established in 2005), or quadrats were missed in error on the sampling day (unique to each year). To facilitate field sampling, the 40 m transect was recorded in 5 contiguous sectors that are not independent (one begins where the previous ends) and are not intended to be a factor in the statistical design. All census methods were designed to quantify coral community structure in terms of the dominant constituents of the benthic community - scleractinian corals, macroalgae, crustose coralline algae, algal turf, Millepora, and sand. In addition to establishing an orthogonal contrast of coral community structure, a subset of the sites and habitats were selected for more detailed analyses of the population density of coral recruits and juvenile corals, as well as the demographic analysis of selected coral species. The time-consuming nature of these analyses prevented them from being measured in all site/habitat combinations."), 
                                                           
                                                           h3("Importance"), 
                                                           p("Tracking the amount of coral found on the reef is invaluable to researchers as knowing the abundance of corals can be directly related to the health of the reef. The three additional coral genera we visualized separately are important Sclerctinian reef building corals, and some of the more common corals found."),
                                                           
                                                           
                                                           p("Here is the link to download the original", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.4", 
                                                                    "dataset."))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60366.jpg", 
                                                            height = 400, 
                                                            width = 400, 
                                                            alt = "Photo of a snorkler holding tools")))),
                                   
                                   tabPanel("Mean Percent Algae Cover", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"),
                                                           p("The visualizations for Macroalgae and CTB were created using observations for these functional groups recorded in the coral dataset. This dataset contains the percentage cover of the stony corals (Scleractinia) and other major groups analyzed from 0.5 x 0.5 m photographic quadrats in several reef habitats at the Moorea Coral Reef LTER, French Polynesia. This survey has been repeated annually in April since 2005. Functional groups (i.e., dependent variables) counted are: Scleractinian Corals (by genus where appropriate, see methods), Macroalgae, Crustose Coralline Algae / Bare Space, Soft Corals, Hydrocorals (Millepora), Algal Turf and Sand. The coral community was sampled photographically in all habitats surrounding the island: Fringing Reef, Lagoon (Backreef), and Outer Reef (Forereef.) Temporal Figures by Variable were broken down to show trends of Macroalgae and CTB, while the Temporal Figures by Site just show Macroalgae trends."),
                                                           
                                                           h3("Data Collection"), 
                                                           p("The sampling strategy was designed to facilitate tests of the effect of time, shore, and depth on the coral community structure of the fringing, and outer reef habitats of Moorea. For the purpose of this analysis, fringing communities were defined as reefs adjacent to the shore and within ca. 50 m of the land. Outer reef habitats were censused at 10 and 17 m depth in order to sample habitats that are representative of the outer reefs of Moorea, and within the depth range tractable to diving research. For the purposes of this app only the depths of 10 m were used in the visualizations. The project was designed with 40 quadrats at each site/depth combination, but sometimes this number was not achieved because all quadrats did not fit in the space measured between markers (a perpetual effect once the site was established in 2005), or quadrats were missed in error on the sampling day (unique to each year). To facilitate field sampling, the 40 m transect was recorded in 5 contiguous sectors that are not independent (one begins where the previous ends) and are not intended to be a factor in the statistical design. All census methods were designed to quantify coral community structure in terms of the dominant constituents of the benthic community - scleractinian corals, macroalgae, crustose coralline algae, algal turf, Millepora, and sand. In addition to establishing an orthogonal contrast of coral community structure, a subset of the sites and habitats were selected for more detailed analyses of the population density of coral recruits and juvenile corals, as well as the demographic analysis of selected coral species. The time-consuming nature of these analyses prevented them from being measured in all site/habitat combinations."),
                                                           p("Note: There are missing data values for CTB in 2020 during the Covid-19 pandemic, as the camera used to collect the data could not decipher between CTB and sand." ),
                                                           
                                                           h3("Importance"), 
                                                           p("Tracking the percent algae cover found on the reef is useful to researchers because the presence of macroalgae and CTB can affect the health of the reef. Macroalgae cover is important to researchers as algae can outcompete coral for space and light due to its fast growing nature relative to corals, ultimately leading to decreased coral densities."),
                                                           
                                                           p("Here is the link to download the original", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.4", 
                                                                    "dataset."))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "Work Around Gump_044.jpg", 
                                                            height = 400, 
                                                            width = 400, 
                                                            alt = "Photo of two women driving a boat with mountians in the background")))),
                                   
                                   tabPanel("Total Herbivore Fish Biomass Density", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"), 
                                                           h4(""), 
                                                           p("These data describe the species abundance and size distributions of fishes surveyed as part of MCR LTER's annual reef fish time series. This study began in 2005 and the dataset is updated annually."),
                                                           h3("Data Collection"), 
                                                           p("The abundances of all mobile taxa of fishes (Scarids, Labrids, Acanthurids, Serranids, etc.) observed on a five by fifty meter transect which extends from the bottom to the surface of the water column are recorded by a diver using SCUBA. The diver then swims back along a one by fifty meter section of the original transect line and records the abundances of all non-mobile or cryptic taxa of fishes (Pomacentids, Gobiids, Cirrhitids, Holocentrids etc). Surveys are conducted between 0900 and 1600 hours (Moorea time) during late July or early August each year. In 2006, divers also began to estimate the size (length) of each fish observed to the nearest half cm. Four replicate transects are surveyed in each of six locations on the forereef (two on each of Moorea's three sides), six locations on the backreef (two on each of Moorea's three sides) and on six locations on the fringing reef (two on each of Moorea's three sides) for a total of 72 individual transects. Transects are permanently marked using a series of small, stainless steel posts affixed to the reef. Transects on the forereef are located at a depth of approximately 12m, those on the backreef are located at a depth of approximately 1.5m and those on the fringing reef are located at a depth of approximately 10m. In addition to the biotic data collected, divers also record data on the date and time each transect was surveyed, wind speed and sea state, swell height in m, amount of cloud cover in % and horizontal visibility in m."), 
                                                           
                                                           h3("Importance"), 
                                                           p("Herbivore fish biomass is important because herbivores can suppress algae that can have detrimental impacts on corals. Human activities, including fishing can depress the biomass of herbivorous fishes. This can result in increased algal abundance which can be detrimental to corals and can impede the ability of reefs to recover from disturbances."),
                                                           
                                                           p("Here is the link to download the original", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.6", 
                                                                    "dataset."))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "MCR60459.jpg", 
                                                            height = 400, 
                                                            width = 400, 
                                                            alt = "Photo of a snorkler holding tools swimming right above a reef with a school of fish to the left of them")))),
                                   
                                   tabPanel("Crown-of-Thorns Density", 
                                            sidebarLayout(
                                              sidebarPanel(width = 5, 
                                                           h3("Background"),
                                                           p("These data describe the abundance of Acanthaster planci, crown-of-thorns sea stars (COTS), surveyed as part of MCR LTER's annual reef fish monitoring program. This study began in 2005 and the dataset is updated annually."),
                                                           h3("Data Collection"), 
                                                           p("The abundances of A. planci observed on a five by fifty meter transect are recorded by a diver using SCUBA. Surveys are conducted between 0900 and 1600 hours (Moorea time) during late July or early August each year. Four replicate transects are surveyed in each of three habitats (forereef, backreef and fringing reef) at six locations, two on each of Moorea's three sides, on the forereef, six locations on the backreef (two on each of Moorea's three sides for a total of 72 individual transects. Transects are permanently marked using a series of small, stainless steel posts affixed to the reef. Transects on the forereef are located at a depth of approximately 12m, those on the backreef are located at a depth of approximately 1.5m and those on the fringing reef are located at a depth of approximately 10m."), 
                                                           
                                                           h3("Importance"), 
                                                           p("Crown-of-thorns density is important because they are a corallivore, meaning they eat coral, and if their populations are left unchecked they will voraciously consume all the corals on a reef leading to the coral reef collapsing. 
"),
                                                           
                                                           p("Here is the link to download the original", 
                                                             tags$a(href="http://mcrlter.msi.ucsb.edu/cgi-bin/showDataset.cgi?docid=knb-lter-mcr.1039", 
                                                                    "dataset."))),
                                              
                                              mainPanel(width = 6, 
                                                        img(src = "Underwater_Gump_095.jpg", 
                                                            height = 400, 
                                                            width = 400, 
                                                            alt = "Photo of a large brown coral with blue water in the background"))
                                              )))))))
