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
        menuItem("Dashboard", tabName = "menuDash", icon = icon("dashboard")),
        menuItem("Map", tabName = "menuMap", icon = icon("map")),
        menuItem("Stat", tabName = "menuChart", icon = icon("chart-line"))
      )
    ),
    dashboardBody(
      tabItems( 
        tabItem(tabName = "menuDash",h2("tab content")),
        tabItem(tabName = 'menuMap',
          leafletOutput("map",width="100%",height=700)),
        tabItem(tabName = "menuChart")
      
      )        
    )
  )
  
  ))