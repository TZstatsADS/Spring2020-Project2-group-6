library(shiny)
library(leaflet)
library(stringr)
library(shinydashboard)
library(tigris) 
library(ggplot2)


load('output/demographic_by_school.RData')
load('output/zip_code.RData')





#SL<-SL%>%filter(Location_Category_Description %in% c('Elementary','High school','Junior High-Intermediate-Middle','K-8'))
#house<-house%>%group_by(`ZIP CODE`)%>%summarize(price=median(avg_price_per_square_foot))%>%filter(is.na(`ZIP CODE`)==F)



pal <- colorNumeric(
  palette = "Greens",
  domain = char_zips@data$price)
labels <- 
  paste0(
    "Zip Code: ",
    char_zips@data$GEOID10, "<br/>",
    "Housing Price: ",
    scales::dollar(char_zips@data$price)) %>%
  lapply(htmltools::HTML)


shinyServer(function(input, output) {
  
  
  filteredData <- reactive({
    if(is.null(input$schoollevel)){selected_schoollevel = levels(SL$Level)}
    else{selected_schoollevel = input$schoollevel}
    
    SL %>% filter(Level %in% selected_schoollevel) 
  })
  
  
  ##Map Section: initialization
  output$map <- renderLeaflet({
    m <- leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(-73.9252853,40.7910694,zoom = 13)
    leafletProxy("map", data = SL) %>%
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
      addCircleMarkers(lng=~LONGITUDE,
                       lat=~LATITUDE,
                       popup=~ paste0("<b>",location_name,"</b>",
                                      "<br/>", "BN: ", BN,
                                      "<br/>", "Address: ", primary_address_line_1, 
                                      " ") ,
                       radius=4,
                       opacity=1,
                       fillOpacity =1 ,
                       stroke=F,
                       color='green',
                       layerId = ~BN)%>%
      addLayersControl(overlayGroups = c('Price'),options = layersControlOptions(collapsed = FALSE))
    m
  })  
  
  ## Map section: some hard coding to change element on maps, one may find simpler ways to do this.
  observe({
    click<-input$map_marker_click
    if(is.null(click))
      return()
    g1<-school_survey_hist1(click$id)
    g2<-newest_ss_radar(click$id)
    output$survey_hist<-renderPlot({
      g1
    })
    output$ss_radar<-renderPlotly({
      g2
    })
    
  })
  
  observe({
    df.marker = filteredData()
    leafletProxy("map",data = df.marker) %>%
      clearPopups() %>%
      clearMarkers() %>%
      addCircleMarkers(lng = ~LONGITUDE, lat = ~LATITUDE, 
                       popup=~ paste0("<b>",location_name,"</b>",
                                      "<br/>", "BN: ", BN,
                                      "<br/>", "Address: ", primary_address_line_1, 
                                      " ") ,
                       radius=4,
                       opacity=1,
                       fillOpacity =1 ,
                       stroke=F,
                       color='green',
                       layerId = ~BN)
  })
  
  
  observe({
    choose_type<-input$house_type
    if(choose_type=="ONE.FAMILY.DWELLINGS"){
      pal0 <- colorNumeric(
        palette = "Greens",
        domain = char_zips@data$ONE.FAMILY.DWELLINGS)
      
      labels0 <-paste0("Zip Code: ",
                       char_zips@data$GEOID10, "<br/>",
                       "Housing Price: ",
                       scales::dollar(char_zips@data$ONE.FAMILY.DWELLINGS)) %>%
        lapply(htmltools::HTML)
      
      leafletProxy("map") %>%
        clearShapes() %>%
        addPolygons(data = char_zips,
                    fillColor = ~pal0(ONE.FAMILY.DWELLINGS),
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
                    label = labels0,group='Price')}
    
  })
  observe({
    choose_type<-input$house_type
    if(choose_type=="TWO.FAMILY.DWELLINGS"){
      pal0 <- colorNumeric(
        palette = "Greens",
        domain = char_zips@data$TWO.FAMILY.DWELLINGS)
      
      labels0 <-paste0("Zip Code: ",
                       char_zips@data$GEOID10, "<br/>",
                       "Housing Price: ",
                       scales::dollar(char_zips@data$TWO.FAMILY.DWELLINGS)) %>%
        lapply(htmltools::HTML)
      
      leafletProxy("map") %>%
        clearShapes() %>%
        addPolygons(data = char_zips,
                    fillColor = ~pal0(TWO.FAMILY.DWELLINGS),
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
                    label = labels0,group='Price')}
    
  })
  observe({
    choose_type<-input$house_type
    if(choose_type=="THREE.FAMILY.DWELLINGS"){
      pal0 <- colorNumeric(
        palette = "Greens",
        domain = char_zips@data$THREE.FAMILY.DWELLINGS)
      
      labels0 <-paste0("Zip Code: ",
                       char_zips@data$GEOID10, "<br/>",
                       "Housing Price: ",
                       scales::dollar(char_zips@data$THREE.FAMILY.DWELLINGS)) %>%
        lapply(htmltools::HTML)
      
      leafletProxy("map") %>%
        clearShapes() %>%
        addPolygons(data = char_zips,
                    fillColor = ~pal0(THREE.FAMILY.DWELLINGS),
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
                    label = labels0,group='Price')}
    
  })
  observe({
    choose_type<-input$house_type
    if(choose_type=="RENTALS...ELEVATOR.APARTMENTS"){
      pal0 <- colorNumeric(
        palette = "Greens",
        domain = char_zips@data$RENTALS...ELEVATOR.APARTMENTS)
      
      labels0 <-paste0("Zip Code: ",
                       char_zips@data$GEOID10, "<br/>",
                       "Housing Price: ",
                       scales::dollar(char_zips@data$RENTALS...ELEVATOR.APARTMENTS)) %>%
        lapply(htmltools::HTML)
      
      leafletProxy("map") %>%
        clearShapes() %>%
        addPolygons(data = char_zips,
                    fillColor = ~pal0(RENTALS...ELEVATOR.APARTMENTS),
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
                    label = labels0,group='Price')}
    
  })
  observe({
    choose_type<-input$house_type
    if(choose_type=="RENTALS...WALKUP.APARTMENTS"){
      pal0 <- colorNumeric(
        palette = "Greens",
        domain = char_zips@data$RENTALS...WALKUP.APARTMENTS)
      
      labels0 <-paste0("Zip Code: ",
                       char_zips@data$GEOID10, "<br/>",
                       "Housing Price: ",
                       scales::dollar(char_zips@data$RENTALS...WALKUP.APARTMENTS)) %>%
        lapply(htmltools::HTML)
      
      leafletProxy("map") %>%
        clearShapes() %>%
        addPolygons(data = char_zips,
                    fillColor = ~pal0(RENTALS...WALKUP.APARTMENTS),
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
                    label = labels0,group='Price')}
    
  })
  observe({
    choose_type<-input$house_type
    if(choose_type=="RENTALS...4.10.UNIT"){
      pal0 <- colorNumeric(
        palette = "Greens",
        domain = char_zips@data$RENTALS...4.10.UNIT)
      
      labels0 <-paste0("Zip Code: ",
                       char_zips@data$GEOID10, "<br/>",
                       "Housing Price: ",
                       scales::dollar(char_zips@data$RENTALS...4.10.UNIT)) %>%
        lapply(htmltools::HTML)
      
      leafletProxy("map") %>%
        clearShapes() %>%
        addPolygons(data = char_zips,
                    fillColor = ~pal0(RENTALS...4.10.UNIT),
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
                    label = labels0,group='Price')}
    
  })
  
  
  # Data & Ranking Section.
  output$tableschool<-DT::renderDataTable({info},filter='top',options = list(pageLength = 20, scrollX=T, autoWidth = TRUE))
  
  
  
  
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
