library(shiny)
library(leaflet)
library(stringr)
library(shinydashboard)
library(tigris) 
library(ggplot2)



load('../output/demographic_by_school.Rdata')
load('../output/zip_code.Rdata')
QR <- read_csv('../data/2005_-_2019_Quality_Review_Ratings.csv')



#SL<-SL%>%filter(Location_Category_Description %in% c('Elementary','High school','Junior High-Intermediate-Middle','K-8'))
#house<-house%>%group_by(`ZIP CODE`)%>%summarize(price=median(avg_price_per_square_foot))%>%filter(is.na(`ZIP CODE`)==F)
a<- SL%>%select(c(1,2,3,4,14,15,16,19,21,23,25,27,29,31))%>%mutate(`19 Trust Score`=as.numeric(`19 Trust Score`))


pal <- colorNumeric(
  palette = "Greens",
  domain = char_zips@data$ONE.FAMILY.DWELLINGS)
labels <- 
  paste0(
    "Zip Code: ",
    char_zips@data$GEOID10, "<br/>",
    "price: ",
    scales::dollar(char_zips@data$ONE.FAMILY.DWELLINGS)) %>%
  lapply(htmltools::HTML)


shinyServer(function(input, output) {
  
  
  filteredData <- reactive({
    if(is.null(input$schoollevel)){selected_schoollevel = levels(SL$Level)}
    else{selected_schoollevel = input$schoollevel}

    SL %>% filter(Level %in% selected_schoollevel) 
  })
  
  
  output$map <- renderLeaflet({
    m <- leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(-73.9252853,40.7910694,zoom = 13)
    leafletProxy("map", data = SL) %>%
    addCircleMarkers(lng=~LONGITUDE,
                     lat=~LATITUDE,
                     popup=~location_name,
                     radius=4,
                     opacity=1,
                     fillOpacity =1 ,
                     stroke=F,
                     color='green')%>%
    addPolygons(data = char_zips,
                  fillColor = ~pal(ONE.FAMILY.DWELLINGS),
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
  
  
  observe({
    df.marker = filteredData()
    leafletProxy("map",data = df.marker) %>%
      clearPopups() %>%
      clearMarkers() %>%
      addCircleMarkers(lng = ~LONGITUDE, lat = ~LATITUDE, 
                       popup=~location_name,
                       radius=4,
                       opacity=1,
                       fillOpacity =1 ,
                       stroke=F,
                       color='green')
  })
  
  
  output$tableschool<-DT::renderDataTable({a},filter='top',options = list(pageLength = 20, scrollX=T))
  
  
  
  
  output$plot_total_enrollment1 <- renderPlotly({
    y <- input$choice2
    total_enrollment_history_linechart(y)
  })
  output$plot_total_enrollment2 <- renderPlotly({
    y <- input$choice3
    total_enrollment_history_linechart(y)
  })
  output$plot_gender1 <- renderPlotly({
    y <- input$choice2
    gender_piechart(y)
  })
  output$plot_gender2 <- renderPlotly({
    y <- input$choice3
    gender_piechart(y)
  })
  output$plot_ethnicity1 <- renderPlotly({
    y <- input$choice2
    ethnicity_piechart(y)
  })
  output$plot_ethnicity2 <- renderPlotly({
    y <- input$choice3
    ethnicity_piechart(y)
  })
  
  output$plot_esl1 <- renderPlotly({
    y <- input$choice2
    esl_piechart(y)
  })
  output$plot_esl2 <- renderPlotly({
    y <- input$choice3
    esl_piechart(y)
  })
  output$plot_qr1 <- renderPlotly({
    y <- input$choice2
    qr_radar(y)
  })
  output$plot_qr2 <- renderPlotly({
    y <- input$choice3
    qr_radar(y)
  })
  
})
