library(shiny)
library(choroplethr)
library(dplyr)
library(leaflet)
library(maps)
library(rgdal)
library(stringr)
library(shinydashboard)

load("../output/School_Locations.RData")

a<-School_Locations%>%filter(location_code=='K001'|location_code=='K002'|location_code=='K003')

shinyServer(function(input, output) {
  
  output$map <- renderLeaflet({
    m <- leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(-73.9252853,40.7910694,zoom = 13)
      leafletProxy("map", data = School_Locations) %>%
      addCircleMarkers(lng=~LONGITUDE,lat=~LATITUDE,popup=~location_name,radius=4,opacity=1,fillOpacity =1 ,stroke=F,color='#c4f1f2')
    
    m
  })  
  
})