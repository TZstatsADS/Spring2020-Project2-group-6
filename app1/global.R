library(shiny)
library(leaflet)
library(tidyverse)
library(scales)
library(ggrepel)
library(stringr)
library(plotly)
library(fmsb)
load('../output/final.RData')
load('../output/demographic_by_school.RData')
load('../output/School_Survey17-19.RData')
load('../output/School_Survey_newest.RData')
load('../output/qr_processed.RData')

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
  plot_ly(tr, x = ~year, y = ~trust, type = 'scatter', mode = 'lines')%>%
    layout(title="Trust Score from 2017 to 2019",
           yaxis=list(title='trust score',rangemode = "normal",range=c(0,5)))
}

school_survey_hist <- function(bn){
  ss <- SS_newest%>%filter(BN==bn)
  new <- cbind(c('Collaborative Teachers Score','Effective School Leadership Score',
                 'Rigorous Instruction Score','Supportive Environment Score',
                 'Strong Family-Community Ties Score','Trust Score'),
               c(ss$colab_teacher,ss$eff_sch_leader,ss$rig_instr,ss$suprt_env,ss$fam_com_tie,ss$trust_score)
  )
  new <- data.frame(new)%>%mutate(X1=as.factor(X1),X2=as.numeric(as.character(X2)))%>%rename(`score type`=X1,score=X2)
  ggplot(new, aes(x=c('S1','S2','S3','S4','S5','S6'),
                  y=score,fill=`score type`))+ geom_bar(stat = "identity")+ylim(0,5)+
    geom_text(aes(x = c('S1','S2','S3','S4','S5','S6'),
                  y = score, label = round(score, 2)))+
    labs(title='Latest School Survey Score',x='score type')+theme_light()+
    theme(plot.title = element_text(hjust = 0.5))
}

qr_radar <- function(bn) {
  qr_df <- df %>% 
    filter (BN == bn) 
  tit <- qr_df$location_name
  qr_df <- qr_df[-c(1,2)]
  qr_df <- as.numeric(as.character(qr_df))
  data <- data.frame(matrix(qr_df,ncol = 5))
  colnames(data) <- c("Curriculum","Pedagogy","Assessment","Expectation","Leadership")
  data <- rbind(rep(5,5) , rep(0,5) ,data)
  radarchart(data, axistype=1 , 
                       #custom polygon
                       pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 , 
                       #custom the grid
                       cglcol="black", cglty=1, axislabcol="black", caxislabels=c(0,1,2,3,4,5), cglwd=0.8,
                       #custom labels
                       vlcex=1.05, 
                       title = "Quality Review"
                    
  )
}

