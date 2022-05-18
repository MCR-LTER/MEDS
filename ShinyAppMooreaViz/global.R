# Load Packages ----
library(shiny)
library(leaflet)
library(tidyverse)
library(shinyWidgets)
library(here)
library(janitor)
library(raster)
library(viridis)
library(sf)
#library(gstat)
library(sp)
#library(automap)
#library(testthat)
#library(htmlwidgets)
#library(car)
#library(dismo)
#library(spatstat)
library(leafem)
#library(mapview)
#library(ggplot2)
library(patchwork)
library(shinydashboard)
#library(fontawesome)
#library(ncdf4)
#library(slickR)
#library(RColorBrewer)

# Load Data ----

#bleaching data
bleach <- read_csv(here("data", "csv", "percent_bleach_2016.csv")) %>% 
  clean_names()

#nitrogen data
nitrogen_data <- read_csv(here("data", "csv", "N_summary_2016.csv")) %>% 
  clean_names()

#sewage data
sewage_data <- read.csv(here("data/csv/Predicted_nuts.csv")) %>% 
  clean_names()

#temporal data 
temporal_data <- read.csv(here("data/csv/temporal_data_joined.csv")) %>% 
  filter(!year == "2005") %>% 
  group_by(habitat)

#coral trophic groups
trophic_corals <- read.csv(here("data/csv/sum_trophic_corals.csv"))


# Prepare data ----

#select 'longitude', 'latitude', and 'percent_bleached' columns in bleaching data and find the mean percent coral bleaching 
bleaching_data <- bleach %>%
  dplyr::select(longitude, latitude, percent_bleached) %>%
  na.omit() %>% 
  group_by(longitude, latitude) %>% 
  summarise(percent_bleached = mean(percent_bleached))

#merge the nitrogen and sewage data frames together 
sewage_data <- cbind(nitrogen_data, sewage_data)

#select the columns 'longitude', 'latitude', and 'urb_nuts'
sewage_2016 <- sewage_data %>% 
  dplyr::select(longitude, latitude, urb_nuts) %>% 
  na.omit()

#Tidy nitrogen data
n_data <- nitrogen_data %>% 
  pivot_longer(!1:5, names_to = "type", values_to = "percent_n") %>% 
  separate(type, into = c("method","random", "date"), sep = "_") %>% 
  dplyr::select(-random)


# Subset data ----

#retain only rows of percent isotopic nitrogen for july 
july_ni_data <- n_data %>% 
  filter(date == "july", method == "d15n") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()

#retain only rows of percent isotopic nitrogen for may 
may_ni_data <- n_data %>% 
  filter(date == "may", method == "d15n") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()

#retain only rows of percent isotopic nitrogen for january 
jan_ni_data <- n_data %>% 
  filter(date == "jan", method == "d15n") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()

#retain only rows of percent nitrogen for july 
july_np_data <- n_data %>% 
  filter(date == "july", method == "percent") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()

#retain only rows of percent nitrogen for may 
may_np_data <- n_data %>% 
  filter(date == "may", method == "percent") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()

#retain only rows of percent nitrogen for january 
jan_np_data <- n_data %>% 
  filter(date == "jan", method == "percent") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()


# Raster Brick ----

#name object called 'spatial_brick' within the data folder (no lidar data in it)
spatial_brick <- here("data", "spatial_brick.nc")

#define min and max for both x and y coordinates 
ext <- raster(xmn = 189139,
              xmx = 207949,
              ymn = 8051175,
              ymx = 8066264)

#create raster brick
spatial_brick <- brick(spatial_brick) %>% 
  setExtent(ext = ext)

#Moorea Coordinate Reference System (crs) EPSG:2976 
#this is setting the crs as a variable so we can use it later  
crs <- 2976


# Rasters and Color Palettes ----

#this code allows us to plot the raster data on our Leaflet map by turning them into points and a data frame. This code also creates all of the color palettes for the leaflet map legend. 

#percent nitrogen 
jan_data <- as.data.frame(rasterToPoints(spatial_brick[[1]])) %>% 
  mutate(X1 = X1/100)
pal_jan <- colorNumeric(palette = viridis((25), option = "viridis"), domain = jan_data$var1.pred, reverse = TRUE)

may_data <- as.data.frame(rasterToPoints(spatial_brick[[2]])) %>% 
  mutate(X2 = X2/100)
pal_may <- colorNumeric(palette = viridis((25), option = "viridis"), domain = may_data$var1.pred, reverse = TRUE)

july_data <- as.data.frame(rasterToPoints(spatial_brick[[3]])) %>% 
  mutate(X3 = X3/100)
pal_july <- colorNumeric(palette = viridis((25), option = "viridis"), domain = july_data$var1.pred, reverse = TRUE)

#isotopic nitrogen 
jan_i_data <- as.data.frame(rasterToPoints(spatial_brick[[4]]))
pal_jan_i <- colorNumeric(palette = viridis((25), option = "viridis"), domain = jan_i_data$var1.pred, reverse = TRUE)

may_i_data <- as.data.frame(rasterToPoints(spatial_brick[[5]]))
pal_may_i <- colorNumeric(palette = viridis((25), option = "viridis"), domain = may_i_data$var1.pred, reverse = TRUE)

july_i_data <- as.data.frame(rasterToPoints(spatial_brick[[6]]))
pal_july_i <- colorNumeric(palette = viridis((25), option = "viridis"), domain = july_i_data$var1.pred, reverse = TRUE)

#coral bleaching 
bleach_data <- as.data.frame(rasterToPoints(spatial_brick[[7]]))
pal_bleach <- colorNumeric(palette = viridis((25), option = "plasma"), domain = bleach_data$var1.pred, reverse = TRUE)

#sewage 
sew_dat <- as.data.frame(rasterToPoints(spatial_brick[[8]]))

pal_image_sew <- colorRampPalette(c("#FEC44F", "#FE9929","#EC7014","#CC4C02","#993404", "#662506"))

pal_sewage <- colorNumeric(pal_image_sew(25), domain = sew_dat$X8)


#lidar 
bathy_df <- as.data.frame(rasterToPoints(spatial_brick[[9]]))

pal_image_bath <- colorRampPalette(c("#807DBA", "#6A51A3", "#54278F", "#3F007D"))

pal_bathy <- colorNumeric(pal_image_bath(25), domain = bathy_df$X9)



# LTER Sites ----

#polygon data for LTER site 1
latitude <- c(-17.47185366, -17.47185366, -17.48641792, -17.48641792, -17.47185366)
longitude <- c(-149.8455917, -149.829821, -149.829821, -149.8455917, -149.8455917)

#make a data frame with long and lat values for bounding box of LTER site 1
lter_1 <- data.frame(longitude, latitude) %>% 
  mutate(site = 1)%>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs)%>% 
  mutate(geometry = st_combine(geometry)) %>% 
  st_cast("POLYGON")


#polygon data for LTER site 2
latitude <- c(-17.46576169, -17.46576169, -17.48131958, -17.48131958, -17.46576169)
longitude <- c(-149.8116849, -149.7961685, -149.7961685, -149.8116849, -149.8116849)

#make a data frame with long and lat values for bounding box of LTER site 2
lter_2 <- data.frame(longitude, latitude) %>% 
  mutate(site = 2)%>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs)%>% 
  mutate(geometry = st_combine(geometry)) %>% 
  st_cast("POLYGON")

#polygon data for LTER site 3
latitude <- c(-17.50382025, -17.50382025, -17.52087158, -17.52087158, -17.50382025)
longitude <- c(-149.7708619, -149.7519968, -149.7519968, -149.7708619, -149.7708619)

#make a data frame with long and lat values for bounding box of LTER site 3
lter_3 <- data.frame(longitude, latitude) %>% 
  mutate(site = 3)%>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs)%>% 
  mutate(geometry = st_combine(geometry)) %>% 
  st_cast("POLYGON")

#polygon data for LTER site 4
latitude <- c(-17.53305021, -17.53305021, -17.55064263, -17.55064263, -17.53305021)
longitude <- c(-149.7772857, -149.7566866, -149.7566866, -149.7772857, -149.7772857)

#make a data frame with long and lat values for bounding box of LTER site 4
lter_4 <- data.frame(longitude, latitude) %>% 
  mutate(site = 4)%>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs)%>% 
  mutate(geometry = st_combine(geometry)) %>% 
  st_cast("POLYGON")

#polygon data for LTER site 5
latitude <- c(-17.56818162, -17.56818162, -17.59182383, -17.59182383, -17.56818162)
longitude <- c(-149.8869755, -149.8561009, -149.8561009, -149.8869755, -149.8869755)

#make a data frame with long and lat values for bounding box of LTER site 5
lter_5 <- data.frame(longitude, latitude) %>% 
  mutate(site = 5)%>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs)%>% 
  mutate(geometry = st_combine(geometry))%>% 
  st_cast("POLYGON")

#polygon data for LTER site 6
latitude <- c(-17.50735955, -17.50735955, -17.52839766, -17.52839766, -17.50735955)
longitude <- c(-149.934537, -149.9115336, -149.9115336, -149.934537, -149.934537)

#make a data frame with long and lat values for bounding box of LTER site 6
lter_6 <- data.frame(longitude, latitude) %>% 
  mutate(site = 6) %>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs) %>%
  mutate(geometry = st_combine(geometry))%>% 
  st_cast("POLYGON")



