library(shiny)
library(choroplethr)
library(dplyr)
library(leaflet)
library(maps)
library(rgdal)
library(stringr)
library(shinydashboard)
library(tidyverse)

load('../output/School_Locations.RData')
load('../output/demographic_by_school.Rdata')
QR <- read_csv('../data/2005_-_2019_Quality_Review_Ratings.csv')
SS_17 <- read_csv('../data/School Survey 2017.csv')

SL <- School_Locations%>%filter(Status_descriptions=='Open')%>%
  select(location_code,location_name,location_type_description,Location_Category_Description,
         primary_address_line_1,LONGITUDE,LATITUDE)

bn_sl <- SL %>% select (location_code, location_name)
QR_1519 <- QR%>%
  filter(Start_Date>='2015-01-01')%>%
  merge(bn_sl, by.x=c("BN"),by.y=c("location_code"))%>%
  select(BN,location_name, School_Year,Indicator_1.1,Indicator_1.2,Indicator_1.3,Indicator_1.4,
<<<<<<< HEAD
         Indicator_2.2,Indicator_3.1,Indicator_3.4,Indicator_4.1,Indicator_4.2,Indicator_5.1) %>% 
  pivot_wider(names_from = School_Year,values_from = starts_with('Indicator'))

=======
         Indicator_2.2,Indicator_3.1,Indicator_3.4,Indicator_4.1,Indicator_4.2,Indicator_5.1)%>%
  pivot_wider(names_from = School_Year,values_from = starts_with('Indicator'))
>>>>>>> c3de004c8491a20994807691ae07e76676610266


shinyServer(function(input, output) {
  
  output$map <- renderLeaflet({
    m <- leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(-73.9252853,40.7910694,zoom = 13)
      leafletProxy("map", data = SL) %>%
      addCircleMarkers(lng=~LONGITUDE,lat=~LATITUDE,popup=~location_name,radius=4,opacity=1,fillOpacity =1 ,stroke=F,color='#c4f1f2')
    
    m
  })  
  
})