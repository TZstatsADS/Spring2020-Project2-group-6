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
        menuItem("Chart", tabName = "menuChart", icon = icon("chart-line"), startexpanded =T,
            menuSubItem("Overall",tabName = "menuOverall"),
            menuSubItem("Comparison",tabName = "menuComparison")),
        menuItem("Data & Ranking", tabName = "menudata", icon = icon("table")),
        menuItem("Source", tabName = "menuSource", icon = icon("osi"))
        )
    ),
    dashboardBody(
      tabItems( 

        tabItem(tabName = "menuDash",
                fluidPage(
                  fluidRow(
                    box(width = 12, title = "Introduction", status = "primary",
                        solidHeader = TRUE, h3("NYC School & Near By Housing Information"),
                        h4("By Liangcao Ling, Kexin(Colleen) Su, Guoying Li, Zhongtian Pan, Jiancong(Jack) Shen"),
                        h5("Whether you are moving to New York with your family and 
                           would like to find a school for your children or your 
                           children has reached school age and you have no idea which 
                           school they should attend, you probably have many questions. 
                           How is the quality of each school? What are the housing 
                           options around the school? What's the best option for your 
                           children and your family? No worries, our app can help you 
                           figure out these questions. "),
                        h5("Our shiny app provides you information about school and 
                           housing in New York City, which benefits both parents and 
                           students. For parents, our app provides detailed school 
                           information including teaching quality score, 
                           family-community ties score, etc, that helps the parents to 
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
                                 tags$li("Maps: This map displays the school location and median housing price of the neighborhood. Each school is indicated by a green dot, and the median housing price is shown with a heat map: darker green indicates higher median price, and lighter green indicates lower."),
                                 tags$li("Chart: This page is divided into two sub-part: “Overall” and “Comparison”. In “Overall”, you will find the average scores of all the schools in NYC. In “Comparison”: You can compare any two schools by selecting or entering their borough numbers (DBN), which can be found in the ‘Data’ page. The comparison will show both school’s total enrollment number from 2015-2019 and their demographic information including gender, ethnicity, and percentage of ESL(English as Second Language) student."),
                                 tags$li("Data & Ranking: This page shows all of the available information of schools. You can use this page to search for a school’s borough number (DBN), look for complete information of a specific school, or look at the school ranking according to a specific aspect."),
                                 tags$li("Source: This page includes the link to the website where we get our data from. All of our data are from ‘NYC open data’, and the starter code is from the class website on Github.")
                                ))))
                  
                  )),

        tabItem(tabName = 'menuMap', splitLayout(cellWidths = c("40%", "60%"),
                                                 box(width=12,
                                                     pickerInput("schoollevel", 'School Level',
                                                                 choices = levels(SL$Level),
                                                                 options = list(`actions-box` = TRUE),
                                                                 multiple = TRUE, width = '100px'),
                                                     checkboxGroupInput("click_school_type", "school Types",
                                                                        choices =c('Elementary','High school','Junior High-Intermediate-Middle','K-8'), 
                                                                        selected =c('Elementary','High school','Junior High-Intermediate-Middle','K-8')), 
                                                     h2("result"),plotOutput("survey_hist")),
                                                     
                                                 
                                                 leafletOutput("map",width="100%",height=800))
        ),
        tabItem(tabName = "menuComparison",
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
                
                navbarPage(title = '', tabPanel('tab1',
                fluidRow(column(6,plotlyOutput("plot_total_enrollment1")),column(6,plotlyOutput("plot_total_enrollment2"))),
                fluidRow(column(6,plotlyOutput("plot_gender1")),column(6,plotlyOutput("plot_gender2")))),
                
                
                tabPanel('tab2',fluidRow(column(6,plotlyOutput("plot_qr1")),column(6,plotlyOutput("plot_qr2"))),
                fluidRow(column(6,plotlyOutput("plot_ethnicity1")),column(6,plotlyOutput("plot_ethnicity2"))),
                fluidRow(column(6,plotlyOutput("plot_esl1")),column(6,plotlyOutput("plot_esl2")))
                
                ))),
    
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

