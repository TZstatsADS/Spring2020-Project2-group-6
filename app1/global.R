library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)
library(plyr)
library(ggrepel)

load('../output/demographic_by_school.RData')
load('../output/School_Survey17-19.RData')

gender_piechart <- function(bn) {
  
  gender_df <- demographic_by_school %>% 
    group_by(`School Name`) %>% 
    filter (BN == bn & Year == max(Year)) %>%
    select(`% Female`,`% Male`) %>%
    gather(key = "gender", value = "value", -`School Name`) %>%
    separate(value, c("prop", "v2"), "%") %>%
    mutate(prop = as.numeric(prop)) %>%
    select(-v2)
  
  pie = ggplot(gender_df, aes(x="", y=prop, fill=gender)) +
    geom_bar(stat="identity", width=1)
  pie = pie + coord_polar("y", start=0) + geom_text_repel(aes(label = paste0(round(prop), "%")), position = position_stack(vjust = 0.5))
  pie = pie + scale_fill_manual(values=c("#55DDE0", "#33658A")) 
  pie = pie + labs(x = NULL, y = NULL, fill = NULL, title = "Percentages of the Gender")
  pie = pie + theme_classic() + theme(axis.line = element_blank(),
                                      axis.text = element_blank(),
                                      axis.ticks = element_blank(),
                                      plot.title = element_text(hjust = 0.5, color = "#666666"))
  pie
  
}

ethnicity_piechart <- function(bn) {
  
  
  ethnicity_df <- demographic_by_school %>% 
    group_by(`School Name`) %>% 
    filter (BN == bn & Year == max(Year)) %>%
    select(`% Asian`,`% Black`, `% Hispanic`, `% White`, `% Multiple Race Categories Not Represented`) %>%
    gather(key = "ethnicity", value = "value", -`School Name`) %>%
    separate(value, c("prop", "v2"), "%") %>%
    mutate(prop = as.numeric(prop)) %>%
    select(-v2)
  
  
  pie = ggplot(ethnicity_df, aes(x="", y=prop, fill=ethnicity)) + geom_bar(stat="identity", width=1)
  pie = pie + coord_polar("y", start=0) + geom_text_repel(aes(label = paste0(round(prop), "%")), position = position_stack(vjust = 0.5))
  pie = pie + scale_fill_manual(values=c("#55DDE0", "#33658A", "#2F4858", "#F6AE2D", "#F26419")) 
  pie = pie + labs(x = NULL, y = NULL, fill = NULL, title = "Percentages of the Ethnicity")
  pie = pie + theme_classic() + theme(axis.line = element_blank(),
                                      axis.text = element_blank(),
                                      axis.ticks = element_blank(),
                                      plot.title = element_text(hjust = 0.5, color = "#666666"))
  pie
} 

esl_piechart <- function(bn) {
  
  esl_df <- demographic_by_school %>% 
    group_by(`School Name`) %>% 
    filter (BN == bn & Year == max(Year)) %>%
    select(`% English Language Learners`) %>%
    separate(`% English Language Learners`, c("% English Language Learners", "v2"), "%") %>%
    select(-v2) %>%
    mutate(`% English Language Learners` = as.numeric(`% English Language Learners`), 
           `% non English Language Learners` = 100 -`% English Language Learners`) %>%
    gather(key = "esl", value = "prop", -`School Name`) %>%
    mutate(prop = as.numeric(prop)) 
  
  pie = ggplot(esl_df, aes(x="", y=prop, fill=esl)) +
    geom_bar(stat="identity", width=1)
  pie = pie + coord_polar("y", start=0) + geom_text_repel(aes(label = paste0(round(prop), "%")), position = position_stack(vjust = 0.5))
  pie = pie + scale_fill_manual(values=c("#2F4858", "#F6AE2D")) 
  pie = pie + labs(x = NULL, y = NULL, fill = NULL, title = "Percentages of English Language Learners")
  pie = pie + theme_classic() + theme(axis.line = element_blank(),
                                      axis.text = element_blank(),
                                      axis.ticks = element_blank(),
                                      plot.title = element_text(hjust = 0.5, color = "#666666"))
  pie
  
}

total_enrollment_history_linechart <- function(bn) {
  total_enrollment_df <- demographic_by_school %>% 
    group_by(`School Name`) %>% 
    filter (BN == bn) %>%
    select(Year, `Total Enrollment`) 
  
  total_enrollment_plot <- total_enrollment_df %>% ggplot(aes(x = Year,y = `Total Enrollment`, group = 1)) +
    geom_line()+
    geom_point() +
    labs(title = "Total Enrollment from 2015 to 2019") +
    theme_classic() + 
    theme(plot.title = element_text(hjust = 0.5, color = "#666666"))
  total_enrollment_plot
  
}

trust_score_linechart <- function(bn){
  ss <- SS%>%filter(BN==bn)
  year <- c('2017','2018','2019')
  trust <- as.numeric(c(ss$`17 Trust Score`,ss$`18 Trust Score`,ss$`19 Trust Score`))
  tr <- as_tibble(cbind(year,trust))
  ggplot(tr,aes(x=year,y=trust,group=1))+geom_line()+geom_point()+theme_light()
}

school_survey_hist <- function(bn){
  ss <- SS%>%filter(BN==bn)
  
}

