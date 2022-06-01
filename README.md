
<!-- README.md is generated from README.Rmd. Please edit this file and not the README.md file, knit to move changes to the other file -->

# Moorea Coral Reef LTER Shiny Application <a href='http://mcr.lternet.edu/'><img src='ShinyAppMooreaViz/www/mcr_logo.png' align="right" height="138.5" /></a>

This repository contains all necessary files, data, and code used for the development of the MCR LTER Shiny application created by the MEDS 2022 Capstone group, MooreaViz. This application serves as an easy-to-use interactive platform to visualize various spatial and temporal data collected by the MCR LTER since 2006. Please see the User Guide file which contains code and data management and information on app maintenance.   

## About the data

### Spatial Data

This Shiny application currently uses 2016 spatial data with layers for nitrogen from _Turbinaria ornata_, isotopic nitrogen, coral bleaching, predicted sewage, and bathymetry. After spatially interpolating the original data points to produce individual raster layers for each variable, these layers were all combined into an interactive map where the user can choose to explore whichever variables they might be interested in. 

### Temporal Data

The second main component of this app includes temporal visualizations produced from 2006-2022 LTER datasets for coral cover, algae cover, herbivore fish biomass, and Crown-of-Thorns density. With two options within the app, the user can choose between visualizations by variable and visualizations by site. Visualizations by variable can be helpful for a user to explore the trends of a single variable across all sites. Visualizations by site can be helpful for a user to compare trends across the four variables for their chosen sites of interest. 

## References

**Data originally published in:**

## The Shiny app can be accessed here: https://shinyapps.bren.ucsb.edu/ShinyAppMooreaViz/ 
