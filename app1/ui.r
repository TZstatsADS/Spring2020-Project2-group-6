library(data.table)
library(shinythemes)
library(shinyWidgets)
library(shinydashboard)



shinyUI(

  dashboardPage(skin='blue',
    dashboardHeader(title = "Choose Your School"),
    dashboardSidebar(
      width = 250,
      sidebarMenu(
        menuItem("Guidance", tabName = "menuDash", icon = icon("dashboard")),
        menuItem("Map", tabName = "menuMap", icon = icon("map")),
        menuItem("Chart", tabName = "menuChart", icon = icon("chart-line"), startexpanded =T,
            menuSubItem("Overall",tabName = "menuOverall"),
            menuSubItem("Comparison",tabName = "menuComparison")),
        menuItem("Data & Ranking", tabName = "menudata", icon = icon("table")),
        menuItem("Source", tabName = "menuSource", icon = icon("osi"))
        )
    ),
    dashboardBody(
      tags$head( 
        tags$style(HTML(".main-sidebar { font-size: 20px; }")) #change the font size to 20
      ),
      
      
      
      tabItems( 

        tabItem(tabName = "menuDash",
                fluidPage(
                  fluidRow(
                    box(width = 15, title = "Introduction", status = "primary",
                        solidHeader = TRUE, h3("NYC School & Housing Information"),
                        h4("By Liangcao Ling, Kexin Su, Guoying Li, Zhongtian Pan, Jiancong(Jack) Shen"),
                        h3(
                          tags$div(tags$ul(
                            tags$li("Whether you are moving to New York with your family and would like 
                           to find a school for your children, or your children has reached school
                                    age and you have no idea which school they should attend, you probably 
                                    have many questions. What is the quality of each school? What are the 
                                    housing options around the school? What's the best option for your 
                                    children and your family? No worries, our app can help you figure out 
                                    these questions. "),
                            tags$li("Our shiny app provides you information about school and housing in 
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
                           provided.")
                          )))

                        
                    )), 
                  fluidRow(box(width = 15, title = "User Guide", status = "primary",
                               solidHeader = TRUE, h3("What Does This App Do?"),
                               h3(
                                 tags$div(tags$ul(
                                   tags$li("Maps: This part is our search map. There are six filters in total: Boroughs, Start Date, End Date, Race, Gender and Age. Users can select their own choice to understand the shooting crimes in their chosen areas. For example, Amy, a 24 years-old Black girl. She's going to New York to work, but she has never been to New York. Then she can use our map to find places where she thinks safe to live in. Besides, for different boroughs, we have different pie charts for Race, Gender and Age, which could help users understand the situations in these boroughs more intuitively."),
                                   tags$li("Comparison Chart: We have nine graphs for this part in total: Interactive pie-bar charts for different boroughs, Shooting Counts by Year, Season, Week, Boroughs, Murder or not, Race, Age and Gender. All these nine graphs help police departments to better understand the specific factors that drive gun violence."),
                                   tags$li("Ranking: This part is our interesting finding. We found that on the day of holiday, there were more shooting crimes than other days. There are four holidays users can choose: Independence Day, Halloween, Christmas Day and New Year's Day. For example, on Christmas Day of 2017, there were 7 shootings in NYC, this was the day with the most shootings from Dec 20, 2017 to Dec 31, 2017. This finding could help police departments to better distribute the polices in important holidays."),
                                   tags$li("Source: This part is our interesting finding. We found that on the day of holiday, there were more shooting crimes than other days. There are four holidays users can choose: Independence Day, Halloween, Christmas Day and New Year's Day. For example, on Christmas Day of 2017, there were 7 shootings in NYC, this was the day with the most shootings from Dec 20, 2017 to Dec 31, 2017. This finding could help police departments to better distribute the polices in important holidays.")
                                 ))))
                               )
                               
                  
                  )),

        tabItem(tabName = 'menuMap', splitLayout(cellWidths = c("50%", "50%"),
                                                 box(width=12,
                                                     pickerInput("schoollevel", 'School Level',
                                                                 choices = levels(SL$Level),
                                                                 options = list(`actions-box` = TRUE),
                                                                 multiple = TRUE, width = '100px'),
                                                
                                                     h2("result"),plotOutput("survey_hist"),
                                                     plotlyOutput("ss_radar")),
                                                     
                                                 
                                                 leafletOutput("map",width="100%",height=800))
        ),
        tabItem(tabName = "menuComparison",fluidPage(
                fluidRow(
                  column(6,
                         selectizeInput("choice2", 'Choose school 1',
                                        choices = levels(demographic_by_school$BN)
                         )
                  ),
                  column(6,
                         selectizeInput("choice3", 'Choose school 2',
                                        choices = levels(demographic_by_school$BN)
                         )
                  )
                ),
                
                tabBox(title = '', width = 12,height = '100%',tabPanel('tab1',
                fluidRow(column(6,plotlyOutput("plot_total_enrollment1")),column(6,plotlyOutput("plot_total_enrollment2"))),
                fluidRow(column(6,plotlyOutput("plot_qr1")),column(6,plotlyOutput("plot_qr2")))),
                
                
                tabPanel('tab2',fluidRow(column(6,plotlyOutput("plot_gender1")),column(6,plotlyOutput("plot_gender2"))),
                fluidRow(column(6,plotlyOutput("plot_ethnicity1")),column(6,plotlyOutput("plot_ethnicity2"))),
                fluidRow(column(6,plotlyOutput("plot_esl1")),column(6,plotlyOutput("plot_esl2")))
                
                )))),
    
        tabItem(tabName = "menudata",
                DT::dataTableOutput('tableschool')
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
                )

        )
  )
  
  ))

