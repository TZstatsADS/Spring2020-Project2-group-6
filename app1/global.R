library(shiny)
library(leaflet)
library(scales)
library(ggrepel)
library(stringr)
library(plotly)
library(tidyverse)
library(stringr)


load('output/schoolfinal.RData')
load('output/demographic_by_school.RData')
load('output/survey_newest.RData')
load('output/qr_processed.RData')
load('output/selected_BN.RData')
load('output/survey_clean.RData')
load('output/schoolinfo.RData')

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
    layout(title="Total Enrollment")
  
}

trust_score_linechart <- function(bn){
  ss <- SS%>%filter(BN==bn)
  year <- c('2017','2018','2019')
  trust <- as.numeric(c(ss$`17 Trust Score`,ss$`18 Trust Score`,ss$`19 Trust Score`))
  tr <- as_tibble(cbind(year,trust))
  plot_ly(tr, x = ~year, y = ~trust, type = 'scatter', mode = 'lines')%>%
    layout(title="Trust Score from 2017 to 2019",
           yaxis=list(title='trust score',rangemode = "normal",range=c(0,5)))
}

school_survey_hist1 <- function(bn){
  test<-S %>% filter(BN == bn) %>% na.omit()
  ggplot(test,aes(Score, as.numeric(value))) +
    geom_col(aes(fill = as.factor(Year)),
             width = 0.8,
             position = position_dodge2(width = 0.8, preserve = "single")) +
    ylab("Score") +
    xlab("Score Criteria") +
    ylim(0,5) +
    labs(fill = "Year") +
    theme(axis.text.x = element_text(angle = 20, hjust = 1)) +
    geom_text(aes(label = value),position = position_dodge2(width = 0.8, preserve = "single"))
}

newest_ss_radar <- function(bn){
  ss <- SS_newest%>%filter(BN==bn)
  tit <- ss$BN
  qr_df <- ss[-c(1,2)]
  qr_df <- as.numeric(as.character(qr_df))
  labels<- c("Collaborative Teachers","Effective School Leadership","Rigorous Instruction",
             "Supportive Environment","Strong Family-Community Ties",'Trust Score')
  abbr <- c('S1','S2','S3','S4','S5','S6')
  p <- plot_ly(
    type = 'scatterpolar',fill = 'toself',mode = 'line') %>%
    add_trace(r = qr_df,theta = abbr,name = tit,hoverinfo = "text",
              text = ~paste(labels, '<br> Score: ', qr_df)) %>%
    layout(title='Newest School Survey Score',
           polar = list(radialaxis = list(visible = T,range = c(0,5))))
  p
}


qr_radar <- function(bn) {
  qr_df <- df %>% 
    filter (BN == bn) 
  tit <- qr_df$location_name
  qr_df <- qr_df[-c(1,2)]
  qr_df <- as.numeric(as.character(qr_df))
  labels<- c("Curriculum","Pedagogy","Assessment","Expectation","Leadership")
  
  p <- plot_ly(
    type = 'scatterpolar',
    fill = 'toself',
    mode = 'line'
  ) %>%
    add_trace(
      r = qr_df,
      theta = labels,
      name = tit,
      hoverinfo = "text",
      text = ~paste(labels, '<br> Score: ', qr_df)
    ) %>%
    layout(
      polar = list(
        radialaxis = list(
          visible = T,
          range = c(0,5)
        )
      )
    )
  
  p
  
}

