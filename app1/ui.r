library(data.table)
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

        tabItem(tabName = "menuDash",
                fluidPage(
                  fluidRow(
                    box(width = 12, title = "Introduction", status = "primary",
                        solidHeader = TRUE, h3("NYC School & Housing Information"),
                        h4("By Liangcao Ling, Kexin Su, Guoying Li, Zhongtian Pan, Jiancong(Jack) Shen"),
                        h5("Whether you are moving to New York with your family and would like 
                           to find a school for your children, or your children has reached school
                           age and you have no idea which school they should attend, you probably 
                           have many questions. What is the quality of each school? What are the 
                           housing options around the school? What's the best option for your 
                           children and your family? No worries, our app can help you figure out 
                           these questions. "),
                        h5("Our shiny app provides you information about school and housing in 
                           New York city, which benefits both parents and student.  For parents, 
                           our app provides detailed school information including teaching 
                           quality score, family-community ties score, etc, that helps parents 
                           select which school they want their children to attend. 
                           When combine school and housing information, parents can choose 
                           the best school option within the family’s housing budget. 
                           Furthermore, by looking at the median housing price of the area, 
                           they can also get a sense of the level of development and safety of 
                           the area, as well as the socioeconomic status of the people living 
                           in that neighborhood. For students, they can have a better 
                           understanding of the school they are attending with the school’s 
                           demographic information and learning environment score our app 
                           provided."), 
                    )), 
                  fluidRow(box(width = 12, title = "User Guide", status = "primary",
                               solidHeader = TRUE, h3("What Does This App Do?"),
                               tags$div(tags$ul(
                                 tags$li("Maps: This part is our search map. There are six filters in total: Boroughs, Start Date, End Date, Race, Gender and Age. Users can select their own choice to understand the shooting crimes in their chosen areas. For example, Amy, a 24 years-old Black girl. She's going to New York to work, but she has never been to New York. Then she can use our map to find places where she thinks safe to live in. Besides, for different boroughs, we have different pie charts for Race, Gender and Age, which could help users understand the situations in these boroughs more intuitively."),
                                 tags$li("Stats: We have nine graphs for this part in total: Interactive pie-bar charts for different boroughs, Shooting Counts by Year, Season, Week, Boroughs, Murder or not, Race, Age and Gender. All these nine graphs help police departments to better understand the specific factors that drive gun violence."),
                                 tags$li("Holidays: This part is our interesting finding. We found that on the day of holiday, there were more shooting crimes than other days. There are four holidays users can choose: Independence Day, Halloween, Christmas Day and New Year's Day. For example, on Christmas Day of 2017, there were 7 shootings in NYC, this was the day with the most shootings from Dec 20, 2017 to Dec 31, 2017. This finding could help police departments to better distribute the polices in important holidays.")
                               ))))
                  
                  )),

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
                fluidRow(
                  column(6,
                         selectInput("choice2", 'Choose school 1',
                                     choices = c("M015", "M019", "More")
                                     )
                         ),
                  column(6,
                         selectInput("choice3", 'Choose school 2',
                                     choices = c("M019", "More")
                                     )
                         ),
                fluidRow(column(6,plotOutput("plot_total_enrollment1")),column(6,plotOutput("plot_total_enrollment2"))),
                fluidRow(column(6,plotlyOutput("plot_gender1")),column(6,plotlyOutput("plot_gender2"))),
                fluidRow(column(6,plotOutput("plot_ethnicity1")),column(6,plotOutput("plot_ethnicity2"))),
                fluidRow(column(6,plotOutput("plot_esl1")),column(6,plotOutput("plot_esl2")))
                )
              ),
    
        tabItem(tabName = "menuSource",
                fluidPage(
                  fluidRow(box(width = 12, title = "Data Source", status = "primary",
                               solidHeader = TRUE, "The source data for this project is from", 
                               tags$a(href = "https://data.cityofnewyork.us/Public-Safety/NYPD-Shooting-Incident-Data-Historic-/833y-fsy8", 
                                      "NYC open data"), ".")),
                  fluidRow(box(width = 12, title = "Project Code", status = "primary",
                               solidHeader = TRUE, "The codes for this project are shared at",
                               tags$a(href = "https://github.com/TZstatsADS/fall2019-proj2--sec2-grp10",
                                      "Github"), "."
                               )
                           )
                  )
                ),
        tabItem(tabName = "menudata",
                dataTableOutput('tableschool')
        )

        )
  )
  
  ))

