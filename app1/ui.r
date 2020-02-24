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
        menuItem("Guidance", tabName = "menuDash", icon = icon("dashboard")),
        menuItem("Map", tabName = "menuMap", icon = icon("map")),
        menuItem("Comparison Chart", tabName = "menuChart", icon = icon("chart-line")),
        menuItem("Ranking", tabName = "menudata", icon = icon("table")),
        menuItem("Source", tabName = "menuSource", icon = icon("osi"))
        )
    ),
    dashboardBody(
      tabItems( 
<<<<<<< HEAD
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
=======
        tabItem(tabName = "menuDash",
                fluidPage(
                  fluidRow(
                    box(width = 12, #title = "Introduction", 
                        solidHeader = TRUE, h1("Introduction"), h3("NYC School"),
                        h4("By Liangcao Ling, Kexin Su, Guoying Li, Zhongtian Pan, Jack"),
                        h5("Whether you are choosing a school for the first time for your child or your child is making the transition to a new school, you probably have many questions. What are your options? How much choice do you really have? What's the best option for your child and your family? Where should you begin? School choice options available to parents have increased dramatically in recent years. There's a growing national sentiment that promoting competition in public education may spur schools to improve and that parents who invest energy in choosing a school will continue to be involved in their child's education."),
                        h5("Our shiny app is about school and housing in New York city, we aim at two types of customers: parents and students. For parents, they may care about finding the school be close to home or the place to work. Or they will need a school with English as a Second Language (ESL) program as a first generation. When coordinating of their multiple children's educations, school location and student demographic information are helpful for them to find a good quality school or decide whether the school fit their needs well."), 
                        fluidRow(box(width = 12, # title = "User Guide", 
                                     solidHeader = TRUE, h1("User Guide"), h3("What Does This App Do?"),
                                     tags$div(tags$ul(
                                       tags$li("Maps: This part is our search map. There are six filters in total: Boroughs, Start Date, End Date, Race, Gender and Age. Users can select their own choice to understand the shooting crimes in their chosen areas. For example, Amy, a 24 years-old Black girl. She's going to New York to work, but she has never been to New York. Then she can use our map to find places where she thinks safe to live in. Besides, for different boroughs, we have different pie charts for Race, Gender and Age, which could help users understand the situations in these boroughs more intuitively."),
                                       tags$li("Stats: We have nine graphs for this part in total: Interactive pie-bar charts for different boroughs, Shooting Counts by Year, Season, Week, Boroughs, Murder or not, Race, Age and Gender. All these nine graphs help police departments to better understand the specific factors that drive gun violence."),
                                       tags$li("Holidays: This part is our interesting finding. We found that on the day of holiday, there were more shooting crimes than other days. There are four holidays users can choose: Independence Day, Halloween, Christmas Day and New Year's Day. For example, on Christmas Day of 2017, there were 7 shootings in NYC, this was the day with the most shootings from Dec 20, 2017 to Dec 31, 2017. This finding could help police departments to better distribute the polices in important holidays.")
                                     ))))
                    )))),
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
>>>>>>> 2965b1b8ad6e73167da663a48e1f709be3d10886
        tabItem(tabName = "menuChart",
                fluidRow(
                  column(6,
                         selectInput("choice2", 'Choose school 1',
                                     choices = c("M015", "M019", "More"))),
                  column(6,
                         selectInput("choice3", 'Choose school 2',
                                     choices = c("M019", "More")))),
                fluidRow(column(6,plotOutput("plot_total_enrollment1")),column(6,plotOutput("plot_total_enrollment2"))),
                fluidRow(column(6,plotOutput("plot_gender1")),column(6,plotOutput("plot_gender2"))),
                fluidRow(column(6,plotOutput("plot_ethnicity1")),column(6,plotOutput("plot_ethnicity2"))),
                fluidRow(column(6,plotOutput("plot_esl1")),column(6,plotOutput("plot_esl2")))
                ),
    
        tabItem(tabName = "menuSource",
                fluidPage(
                  fluidRow(box(width = 12, title = "Data Source", status = "warning",
                               solidHeader = TRUE, "The source data for this project is from", 
                               tags$a(href = "https://data.cityofnewyork.us/Public-Safety/NYPD-Shooting-Incident-Data-Historic-/833y-fsy8", 
                                      "NYC open data"), ".")),
                  fluidRow(box(width = 12, title = "Project Code", status = "warning",
                               solidHeader = TRUE, "The codes for this project are shared at",
                               tags$a(href = "https://github.com/TZstatsADS/fall2019-proj2--sec2-grp10",
                                      "Github"), ".")))),
        tabItem(tabName = "menudata",
                dataTableOutput('tableschool'))
        
<<<<<<< HEAD
        )
  )
  
  ))
=======
      )
    )
    
  ))
>>>>>>> 2965b1b8ad6e73167da663a48e1f709be3d10886
