library(shiny)
library(leaflet)
library(tidyverse)
library(scales)
library(ggrepel)
library(stringr)
library(plotly)
load('../output/final.RData')
load('../output/demographic_by_school.RData')
load('../output/School_Survey17-19.RData')

gender_piechart <- function(bn) {
  
  gender_df <- demographic_by_school %>% 
    filter (BN == bn & Year == max(Year)) %>%
    select(`School Name`,`% Female`,`% Male`) %>%
    pivot_longer(names_to ="gender", values_to = "prop", cols = c(`% Female`,`% Male`))%>%
    mutate(prop=as.numeric(str_remove(prop, '%')))
  
  pie <- plot_ly(gender_df, labels = ~gender, values = ~prop, type = 'pie') %>%
    layout(title = 'Percentages of the Gender',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  pie
  
}

ethnicity_piechart <- function(bn) {
  
  
  ethnicity_df <- demographic_by_school %>% 
    filter (BN == bn & Year == max(Year)) %>%rename(`%Multiple Race`=`% Multiple Race Categories Not Represented`)%>%
    select(`School Name`,`% Asian`,`% Black`, `% Hispanic`, `% White`, `%Multiple Race`)  %>%
    pivot_longer(names_to ="ethnicity", values_to = "prop", cols = c(`% Asian`,`% Black`, `% Hispanic`, `% White`, `%Multiple Race`))%>%
    mutate(prop=as.numeric(str_remove(prop, '%')))
  
  
  pie <- plot_ly(ethnicity_df, labels = ~ethnicity, values = ~prop, type = 'pie') %>%
    layout(title = 'Percentages of the Ethnicity',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  pie
} 

esl_piechart <- function(bn) {
  
  esl_df <- demographic_by_school %>% 
    filter (BN == bn & Year == max(Year)) %>%
    mutate(`% English Language Learners` = as.numeric(str_remove(`% English Language Learners`,'%')), 
           `% non English Language Learners` = 100 -`% English Language Learners`) %>%
    rename("% ESL" = `% English Language Learners`, "% non ESL"= `% non English Language Learners`)%>%
    select(`School Name`,`% ESL`,`% non ESL`)%>%
    pivot_longer(names_to ="type", values_to = "prop", cols = c(`% ESL`,`% non ESL`))
    
    
  pie <- plot_ly(esl_df, labels = ~type, values = ~prop, type = 'pie') %>%
    layout(title = 'Percentages of the ESL',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  pie
  
}


total_enrollment_history_linechart <- function(bn) {
  total_enrollment_df <- demographic_by_school %>% 
    filter (BN == bn) %>%
    select(`School Name`, Year, `Total Enrollment`) 
  
  total_enrollment_plot <- total_enrollment_plot <- plot_ly(total_enrollment_df, x = ~Year, y = ~`Total Enrollment`, type = 'scatter', mode = 'lines')%>%
    layout(title="Total Enrollment from 2015 to 2019")
  
}

trust_score_linechart <- function(bn){
  ss <- SS%>%filter(BN==bn)
  year <- c('2017','2018','2019')
  trust <- as.numeric(c(ss$`17 Trust Score`,ss$`18 Trust Score`,ss$`19 Trust Score`))
  tr <- as_tibble(cbind(year,trust))
  ggplot(tr,aes(x=year,y=trust,group=1))+geom_line()+geom_point()+theme_light()
}

school_survey_hist <- function(bn){
  ss <- SS%>%dplyr::filter(BN==bn)
}
trust_score_linechart('K001')
