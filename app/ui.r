library(shiny)
library(leaflet)
library(data.table)
library(plotly)
library(shinythemes)
library(shinyWidgets)
library(shinydashboard)


shinyUI(fluidPage(
  dashboardPage(
    dashboardHeader(title = "School dashboard"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Map", tabName = "menuMap", icon = icon("map"))
      )
    ),
    dashboardBody(
      tabItem(tabName = 'menuMap',
        leafletOutput("map",width="100%",height=700)
             
             
             
             
      )      
             
    )
    )
  
  )
)