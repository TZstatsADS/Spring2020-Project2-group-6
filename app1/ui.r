library(shiny)
library(leaflet)
library(data.table)
library(plotly)
library(shinythemes)
library(shinyWidgets)
library(shinydashboard)


shinyUI(
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
        tabItem(tabName = 'menuMap', splitLayout(cellWidths = c("40%", "60%"),
        box(width=12,
              checkboxGroupInput("click_school_type", "school Types",
                                                  choices =c('Elementary','High school','Junior High-Intermediate-Middle','K-8'), 
                                 selected =c('Elementary','High school','Junior High-Intermediate-Middle','K-8')),
              checkboxGroupInput("click_school_type", "school Types",
                                 choices =c('Elementary','High school','Junior High-Intermediate-Middle','K-8'), 
                                 selected =c('Elementary','High school','Junior High-Intermediate-Middle','K-8')), 
              h2("result")),
         
            leafletOutput("map",width="100%",height=700))
          ),
        tabItem(tabName = "menuChart")
    )
  )
  
  ))