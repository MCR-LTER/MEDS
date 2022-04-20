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
library(gstat)
library(sp)
library(automap)
library(testthat)
library(htmlwidgets)
library(ggvoronoi)
library(car)
library(dismo)
library(spatstat)
library(leafem)
library(mapview)
library(ggplot2)
library(patchwork)
library(shinydashboard)
library(fontawesome)
library(ncdf4)

# Load Data ----

#nitrogen data
nitrogen_data <- read_csv(here("data", "csv", "N_summary_2016.csv")) %>% 
  clean_names()

#bleaching data
bleach <- read_csv(here("data", "csv", "percent_bleach_2016.csv")) %>% 
  clean_names()

#site polygons
#site_poly <- read_csv(here("data", "csv", "site_poly.csv"))

#sewage data
sewage_data <- read.csv(here("data/csv/Predicted_nuts.csv")) %>% 
  clean_names()

sewage_data <- cbind(nitrogen_data, sewage_data)

sewage_2016 <- sewage_data %>% 
  dplyr::select(longitude, latitude, urb_nuts) %>% 
  na.omit()

#temporal data 
temporal_data <- read.csv(here("data/csv/temporal_data_joined.csv"))

#Select column bleach
bleaching_data <- bleach %>%
  dplyr::select(longitude, latitude, percent_bleached) %>%
  na.omit() %>% 
  group_by(longitude, latitude) %>% 
  summarise(percent_bleached = mean(percent_bleached))

#Tidy Nitrogen Data
n_data <- nitrogen_data %>% 
  mutate(percent_n_jan = percent_n_jan *100,
         percent_n_may = percent_n_may *100,
         percent_n_july = percent_n_july *100) %>% #turning them into %s 
  pivot_longer(!1:5, names_to = "type", values_to = "percent_n") %>% 
  separate(type, into = c("method","random", "date"), sep = "_") %>% 
  dplyr::select(-random)

# selecting n-july data
july_ni_data <- n_data %>% 
  filter(date == "july", method == "d15n") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()

# selecting n-may data
may_ni_data <- n_data %>% 
  filter(date == "may", method == "d15n") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()

# selecting n-jan data
jan_ni_data <- n_data %>% 
  filter(date == "jan", method == "d15n") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()

# selecting n-july data
july_np_data <- n_data %>% 
  filter(date == "july", method == "percent") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()

# selecting n-may data
may_np_data <- n_data %>% 
  filter(date == "may", method == "percent") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()
# selecting n-jan data
jan_np_data <- n_data %>% 
  filter(date == "jan", method == "percent") %>%
  dplyr::select(longitude, latitude, percent_n) %>% 
  na.omit()

#raster brick minus lidar
spatial_brick <- here("data", "spatial_brick.nc")

spatial_brick <- brick(spatial_brick)


#crs 
crs <- 3297

# Tidy Nitrogen Data
# n_data <- nitrogen_data %>% 
#     mutate(percent_n_jan = percent_n_jan *100,
#            percent_n_may = percent_n_may *100,
#            percent_n_july = percent_n_july *100) %>% #turning them into %s 
#     pivot_longer(!1:5, names_to = "type", values_to = "percent_n") %>% 
#     separate(type, into = c("method","random", "date"), sep = "_") %>% 
#     dplyr::select(-random)

#Pals
# percent nitrogen 
jan_data <- as.data.frame(rasterToPoints(spatial_brick[[1]]))
pal_jan <- colorNumeric(palette = viridis((25), option = "plasma"), domain = jan_data$var1.pred, reverse = TRUE)

may_data <- as.data.frame(rasterToPoints(spatial_brick[[2]]))
pal_may <- colorNumeric(palette = viridis((25), option = "plasma"), domain = may_data$var1.pred, reverse = TRUE)

july_data <- as.data.frame(rasterToPoints(spatial_brick[[3]]))
pal_july <- colorNumeric(palette = viridis((25), option = "plasma"), domain = july_data$var1.pred, reverse = TRUE)

# isotopic nitrogen 
jan_i_data <- as.data.frame(rasterToPoints(spatial_brick[[4]]))
pal_jan_i <- colorNumeric(palette = viridis((25), option = "plasma"), domain = jan_i_data$var1.pred, reverse = TRUE)

may_i_data <- as.data.frame(rasterToPoints(spatial_brick[[5]]))
pal_may_i <- colorNumeric(palette = viridis((25), option = "plasma"), domain = may_i_data$var1.pred, reverse = TRUE)

july_i_data <- as.data.frame(rasterToPoints(spatial_brick[[6]]))
pal_july_i <- colorNumeric(palette = viridis((25), option = "plasma"), domain = july_i_data$var1.pred, reverse = TRUE)

bleach_data <- as.data.frame(rasterToPoints(spatial_brick[[7]]))
pal_bleach <- colorNumeric(palette = viridis((25), option = "plasma"), domain = bleach_data$var1.pred, reverse = TRUE)

# sewage 
sew_dat <- as.data.frame(rasterToPoints(spatial_brick[[8]]))
pal_sewage <- colorNumeric(palette = viridis((25), option = "plasma"), domain = sewage_data$var1.pred, reverse = TRUE)

# lidar 
bathy_df <- as.data.frame(rasterToPoints(spatial_brick[[9]]))
pal_bathy <- colorNumeric(palette = viridis((25), option = "plasma"), domain = bathy_df$layer, reverse = TRUE)

# polygon data
latitude <- c(-17.47185366, -17.47185366, -17.48641792, -17.48641792, -17.47185366)
longitude <- c(-149.8455917, -149.829821, -149.829821, -149.8455917, -149.8455917)

lter_1 <- data.frame(longitude, latitude) %>% 
  mutate(site = 1)%>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs)%>% 
  mutate(geometry = st_combine(geometry)) %>% 
  st_cast("POLYGON")


latitude <- c(-17.46576169, -17.46576169, -17.48131958, -17.48131958, -17.46576169)
longitude <- c(-149.8116849, -149.7961685, -149.7961685, -149.8116849, -149.8116849)

lter_2 <- data.frame(longitude, latitude) %>% 
  mutate(site = 2)%>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs)%>% 
  mutate(geometry = st_combine(geometry)) %>% 
  st_cast("POLYGON")


latitude <- c(-17.50382025, -17.50382025, -17.52087158, -17.52087158, -17.50382025)
longitude <- c(-149.7708619, -149.7519968, -149.7519968, -149.7708619, -149.7708619)

lter_3 <- data.frame(longitude, latitude) %>% 
  mutate(site = 3)%>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs)%>% 
  mutate(geometry = st_combine(geometry)) %>% 
  st_cast("POLYGON")


latitude <- c(-17.53305021, -17.53305021, -17.55064263, -17.55064263, -17.53305021)
longitude <- c(-149.7772857, -149.7566866, -149.7566866, -149.7772857, -149.7772857)

lter_4 <- data.frame(longitude, latitude) %>% 
  mutate(site = 4)%>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs)%>% 
  mutate(geometry = st_combine(geometry)) %>% 
  st_cast("POLYGON")


latitude <- c(-17.56818162, -17.56818162, -17.59182383, -17.59182383, -17.56818162)
longitude <- c(-149.8869755, -149.8561009, -149.8561009, -149.8869755, -149.8869755)

lter_5 <- data.frame(longitude, latitude) %>% 
  mutate(site = 5)%>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs)%>% 
  mutate(geometry = st_combine(geometry))%>% 
  st_cast("POLYGON")


latitude <- c(-17.50735955, -17.50735955, -17.52839766, -17.52839766, -17.50735955)
longitude <- c(-149.934537, -149.9115336, -149.9115336, -149.934537, -149.934537)

lter_6 <- data.frame(longitude, latitude) %>% 
  mutate(site = 6) %>% 
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs) %>%
  mutate(geometry = st_combine(geometry))%>% 
  st_cast("POLYGON")



