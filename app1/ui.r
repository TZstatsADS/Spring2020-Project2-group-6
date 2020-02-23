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
        menuItem("Stat", tabName = "menuChart", icon = icon("chart-line")),
        menuItem("Data", tabName = "menudata", icon = icon("table"))
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
         
            leafletOutput("map",width="100%",height=800))
          ),
        tabItem(tabName = "menuChart",
                fluidRow(imageOutput("statimage1")),
                fluidRow(box(width=6,textInput("choice2","Enter Name")),
                         box(width=6,textInput("choice3","Enter Name"))),
                
                # left side
                fluidRow(plotOutput("plot_total_enrollment1")), 
                fluidRow(plotOutput("plot_gender1")), 
                fluidRow(plotOutput("plot_enthicity1")), 
                fluidRow(plotOutput("plot_esl1")), 
                #right side
                fluidRow(plotOutput("plot_total_enrollment2")), 
                fluidRow(plotOutput("plot_gender2")), 
                fluidRow(plotOutput("plot_enthicity2")), 
                fluidRow(plotOutput("plot_esl2"))
                
                ),
        tabItem(tabName = "menudata",
                dataTableOutput('tableschool'))
    
        )
  )
  
  ))