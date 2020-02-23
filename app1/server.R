library(shiny)
library(dplyr)
library(leaflet)
library(stringr)
library(shinydashboard)
library(tidyverse)
library(tigris) 
library(DT)
library(ggplot2)


load('../output/final.RData')
load('../output/demographic_by_school.Rdata')
load('../output/house1.Rdata')
load('../output/zip_code.Rdata')
QR <- read_csv('../data/2005_-_2019_Quality_Review_Ratings.csv')



#SL<-SL%>%filter(Location_Category_Description %in% c('Elementary','High school','Junior High-Intermediate-Middle','K-8'))
#house<-house%>%group_by(`ZIP CODE`)%>%summarize(price=median(avg_price_per_square_foot))%>%filter(is.na(`ZIP CODE`)==F)
a<- SL%>%select(c(1,2,3,4,14,15,16,19,21,23,25,27,29,31))%>%mutate(`19 Trust Score`=as.numeric(`19 Trust Score`))


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
  output$tableschool<-renderDataTable({a},filter='top',options = list(pageLength = 20, scrollX=T))
  output$statimage1 <- renderImage({
    filename <- normalizePath(file.path('../doc/figs',
                                        'Rplot.png'))
    
    # Return a list containing the filename and alt text
    list(src = filename,height=350)
    
  }, deleteFile = FALSE)
  
  output$plot_total_enrollment1 <- renderPlot({
    y <- input$choice2
    total_enrollment_history_linechart(y)
  },width=300)
  
  output$plot_gender1 <- renderPlot({
    y <- input$choice2
    gender_piechart(y)
  },width=300)
  
  output$plot_enthicity1 <- renderPlot({
    y <- input$choice2
    ethnicity_piechart(y)
  },width=300)
  
  output$plot_esl1 <- renderPlot({
    y <- input$choice2
    esl_piechart(y)
  },width=300)
  
  # output right side
  output$plot_total_enrollment2 <- renderPlot({
    y <- input$choice3
    total_enrollment_history_linechart(y)
  },width=300)
  
  output$plot_gender2 <- renderPlot({
    y <- input$choice3
    gender_piechart(y)
  },width=300)
  
  output$plot_enthicity2 <- renderPlot({
    y <- input$choice3
    ethnicity_piechart(y)
  },width=300)
  
  output$plot_esl2 <- renderPlot({
    y <- input$choice3
    esl_piechart(y)
  },width=300)
  
  
  })