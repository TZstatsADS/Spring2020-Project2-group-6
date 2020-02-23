library(shiny)
library(dplyr)
library(leaflet)
library(maps)
library(rgdal)
library(stringr)
library(shinydashboard)
library(tidyverse)
library(tigris) 

load('../output/School_Locations.RData')
load('../output/demographic_by_school.Rdata')
load('../output/house1.Rdata')
load('../output/zip_code.Rdata')
QR <- read_csv('../data/2005_-_2019_Quality_Review_Ratings.csv')



#SL<-SL%>%filter(Location_Category_Description %in% c('Elementary','High school','Junior High-Intermediate-Middle','K-8'))
#house<-house%>%group_by(`ZIP CODE`)%>%summarize(price=median(avg_price_per_square_foot))%>%filter(is.na(`ZIP CODE`)==F)
pal <- colorNumeric(
  palette = "Greens",
  domain = char_zips@data$price)
labels <- 
  paste0(
    "Zip Code: ",
    char_zips@data$GEOID10, "<br/>",
    "price: ",
    scales::dollar(char_zips@data$price)) %>%
  lapply(htmltools::HTML)


shinyServer(function(input, output) {
  
  output$map <- renderLeaflet({
    m <- leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(-73.9252853,40.7910694,zoom = 13)
      leafletProxy("map", data = SL) %>%
      addCircleMarkers(lng=~LONGITUDE,lat=~LATITUDE,popup=~location_name,radius=4,opacity=1,fillOpacity =1 ,stroke=F,color='green')%>%
        addPolygons(data = char_zips,
                    fillColor = ~pal(price),
                    weight = 2,
                    opacity = 1,
                    color = "white",
                    dashArray = "3",
                    fillOpacity = 0.5,
                    highlight = highlightOptions(weight = 2,
                                                 color = "#666",
                                                 dashArray = "",
                                                 fillOpacity = 0.7,
                                                 bringToFront = TRUE),
                    label = labels,group='Price')%>%
        addLayersControl(overlayGroups = c('Price'))
    m
  })
  
  output$plot3 <- renderPlot({
    gender_piechart(input)
  })
  
  
  
})