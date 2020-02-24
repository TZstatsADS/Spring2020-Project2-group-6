library(shiny)
library(leaflet)
library(data.table)
library(plotly)
library(shinythemes)
library(shinyWidgets)
library(shinydashboard)


shinyUI(
  dashboardPage(skin='blue',
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
        tabItem(tabName = "menuDash",fluidPage(  
          fluidRow(  
            box(width = 15, title = "Introduction", status = "warning",  
                solidHeader = T, h3("NYC School & Housing Information"),  
                h4("By Guoying Li, Kexin Su, Liangchao Ling, Wenzhong Pan"),  
                h5("In America, which has one of the highest rates of gun homicide in the world, cities experience gun violence at very high rates.  And urban gun violence touches on issues central to American life : safety, equality, opportunity and community. Residents and leaders of America’s cities face few challenges more urgent than gun violence. It takes thousands of lives, depresses the quality of life of whole neighborhoods, drives people to move away, and reduces cities’ attractiveness for newcomers. It makes it harder for schools, businesses, and community institutions to thrive. Urban gun violence also reflects and worsens America’s existing racial and economic disparities. So gun violence is a very severe situation to America, especially to big cities, like New York City."),  
                h5("Our shiny app is about Shooting Crime Map in NYC, we aim at two types of customers: Residents and Police Departments. For residents, they can use our app to check the shooting crimes in different neighborhoods of New York, providing a good way to find a safer place to live and work. For police departments, we can assist them to reduce crime through a better-informed citizenry. Creating more self-reliance among community members is a great benefit to community oriented policing efforts everywhere and has been proven effective in combating crime."),   
                h5("Then, please follow me to use this app!"))),  
          fluidRow(box(width = 15, title = "User Guide", status = "warning",  
                       solidHeader = TRUE, h3("What Does This Map Do?"),  
                       tags$div(tags$ul(  
                         tags$li("Map: This part contains a heatmap and a time series graph, and they are linked with each other. The x-axis of time series graph and the adjustable bar of heatmap represent the 24 hours of a day, and y-axis of time series graph represents the total count number of shooting crimes for the whole 13 years (2006-2018). The darker of the heatmap, the more shooting crimes happened."),  
                         tags$li("Stat: This part is our search map. There are six filters in total: Boroughs, Start Date, End Date, Race, Gender and Age. Users can select their own choice to understand the shooting crimes in their chosen areas. For example, Amy, a 24 years-old Black girl. She’s going to New York to work, but she has never been to New York. Then she can use our map to find places where she thinks safe to live in. Besides, for different boroughs, we have different pie charts for Race, Gender and Age, which could help users understand the situations in these boroughs more intuitively."),  
                         tags$li("Data/Ranking: We have nine graphs for this part in total: Interactive pie-bar charts for different boroughs, Shooting Counts by Year, Season, Week, Boroughs, Murder or not, Race, Age and Gender. All these nine graphs help police departments to better understand the specific factors that drive gun violence."),  
                         ))))  
        )
        ),
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
                fluidRow(box(width=6,textInput("statinput1","Enter Name")),
                         box(width=6,textInput("statinput2","Enter Name")))),
        tabItem(tabName = "menudata",
                dataTableOutput('tableschool'))
        
        )
  )
  
  ))
