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
                    menuItem("Chart", tabName = "menuChart", icon = icon("chart-line")),
                    menuItem("Data & Ranking", tabName = "menudata", icon = icon("table")),
                    menuItem("Source", tabName = "menuSource", icon = icon("osi"))
                  )
                ),
                dashboardBody(
                  tags$head( 
                    tags$style(HTML(".main-sidebar { font-size:18px; }")) 
                  ),
                  
                  
                  
                  tabItems( 
                    
                    tabItem(tabName = "menuDash",
                            fluidPage(
                              fluidRow(
                                box(width = 15, title = "Introduction", status = "primary",
                                    solidHeader = TRUE, h3("NYC School & Housing Information"),
                                    h5("By Liangcao Ling, Kexin Su, Guoying Li, Zhongtian Pan, Jiancong(Jack) Shen"),
                                    h4(
                                      tags$div(tags$ul(
                                        tags$li("Whether you are moving to New York with your family and would like 
                                    to find a school for your children, or your children has reached school
                                    age and you have no idea which school they should attend, you probably 
                                    have many questions. What is the quality of each school? What are the 
                                    housing options around the school? What's the best option for your 
                                    children and yonnur family? No worries, our app can help you figure out 
                                    these questions. "),
                                        tags$li("Our shiny app provides you information about school and housing in 
                           New York city, which benefits both parents and student.  For parents, 
                           our app provides detailed school information including teaching 
                           quality score, family-community ties score, etc, that helps parents 
                           select which school they want their children to attend. 
                           When combine school and housing information, parents can choose 
                           the best school option within the family's housing budget. 
                           Furthermore, by looking at the median housing price of the area, 
                           they can also get a sense of the level of development and safety of 
                           the area, as well as the socioeconomic status of the people living 
                           in that neighborhood. For students, they can have a better 
                           understanding of the school they are attending with the school's 
                           demographic information and learning environment score our app 
                           provided.")
                                      )))
                                    
                                    
                                )), 
                              fluidRow(box(width = 15, title = "User Guide", status = "primary",
                                           solidHeader = TRUE, h3("What Does This App Do?"),
                                           h4(
                                             tags$div(tags$ul(
                                               tags$li("Maps: This map displays the school location and median housing price of the neighborhood. Each school is indicated by a green dot, and the median housing price is shown with a heat map: darker green indicates higher median price, and lighter green indicates lower."),
                                               tags$li("Chart: In this page, you can compare any two schools by selecting or entering their borough numbers (BN), which can be found in the Data page. The comparison contains two tabs: 'Total Enrollment & Quality Review', and 'Demographic Information'. The first tab shows the school's total enrollment number from 2015-2019, and its newest quality review score. The second tab includes the schools\' demographic information including gender, ethnicity, and percentage of ESL(English as Second Language) student."),
                                               tags$li("Data & Ranking: This page shows all of the available information of schools. You can use this page to search for a school's borough number (BN), look for complete information of a specific school, or look at the school ranking according to a specific aspect."),
                                               tags$li("Source: This part includes the link to the website where we get our data from. All of our data are from 'NYC open data' and 'NYC Department of Education', and the code to our entire project is shared on Github.")
                                             ))))
                              )
                              
                              
                            )),
                    
                    tabItem(tabName = 'menuMap', splitLayout(cellWidths = c("50%", "50%"),
                                                             box(width=12,
                                                                 pickerInput("schoollevel", 'School Level',
                                                                             choices = c('Elementary','High school','Junior High-Intermediate-Middle','K-8'),
                                                                             options = list(`actions-box` = TRUE),
                                                                             multiple = TRUE, width = '100px'),
                                                                 
                                                                 pickerInput("house_type","House Types",
                                                                             choices = c('ONE.FAMILY.DWELLINGS', 'TWO.FAMILY.DWELLINGS', 'THREE.FAMILY.DWELLINGS', 'RENTALS...ELEVATOR.APARTMENTS','RENTALS...WALKUP.APARTMENTS','RENTALS...4.10.UNIT'),
                                                                             options = list(`actions-box` = TRUE),
                                                                             width = '100px'),
                                                                 h2("result"), h6('First unselect the checkbox for "price" to hide the housing-price layer, '), h6('then click on each school to see detailed school information.'),
                                                                 plotOutput("survey_hist"),
                                                                 plotlyOutput("ss_radar")),
                                                             
                                                             
                                                             leafletOutput("map",width="100%",height=1000))
                    ),
                    tabItem(tabName = "menuChart",fluidPage(
                      fluidRow(
                        column(6,
                               selectizeInput("choice2", 'Choose school 1',
                                              choices = levels(selected_BN$BN)
                               )
                        ),
                        column(6,
                               selectizeInput("choice3", 'Choose school 2',
                                              choices = levels(selected_BN$BN)
                               )
                        )
                      ),
                      
                      tabBox(title = '', width = 12,height = '100%',tabPanel('Total Enrollment & Quality Review',
                                                                             fluidRow(column(6,plotlyOutput("plot_total_enrollment1")),column(6,plotlyOutput("plot_total_enrollment2"))),
                                                                             fluidRow(column(6,plotlyOutput("plot_qr1")),column(6,plotlyOutput("plot_qr2")))),
                             
                             
                             tabPanel('Demographic Information',fluidRow(column(6,plotlyOutput("plot_gender1")),column(6,plotlyOutput("plot_gender2"))),
                                      fluidRow(column(6,plotlyOutput("plot_ethnicity1")),column(6,plotlyOutput("plot_ethnicity2"))),
                                      fluidRow(column(6,plotlyOutput("plot_esl1")),column(6,plotlyOutput("plot_esl2")))
                                      
                             )))),
                    
                    tabItem(tabName = "menudata",
                            DT::dataTableOutput('tableschool')
                    ),
                    tabItem(tabName = "menuSource",
                            fluidPage(
                              fluidRow(box(width = 12, title = "Data Source", status = "primary",
                                           solidHeader = TRUE, "The source data for this project is from the websites", 
                                           tags$a(href = "https://opendata.cityofnewyork.us/data/", 
                                                  "NYC open data"), ',',
                                           tags$a(href = "https://www.schools.nyc.gov/about-us/reports/school-quality/nyc-school-survey", 
                                                  "NYC Department of Education (School Survey data)"),", and",
                                           tags$a(href = "https://www1.nyc.gov/site/finance/taxes/property-rolling-sales-data.page", 
                                                  "NYC Department of Finance (housing data)"),".")),
                              fluidRow(box(width = 12, title = "Project Code", status = "primary",
                                           solidHeader = TRUE, "The codes for this project are shared at",
                                           tags$a(href = "https://github.com/TZstatsADS/Spring2020-Project2-group-6",
                                                  "Github"), "."
                              )
                              )
                            )
                    )
                    
                  )
                )
                
  ))

