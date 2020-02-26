#read on packages
library(data.table)
library(tidyverse)

#read in data
setwd("~/Downloads/ads-project1/Spring2020-Project2-group-6/data")
pluto<-fread(paste0('Primary_Land_Use_Tax_Lot_Output__PLUTO_.csv'))

PLUTO<-pluto %>% 
  select(c("borough","schooldist","postcode","assesstot","yearbuilt",
                       "latitude","longitude","bldgclass","bldgarea")) %>%
  filter(bldgclass %like% "A|B|C|D|L|R|S") %>%
  filter(!bldgclass %in% c("R5","R7","R8","RA","RB","RH","RK","RW","RC")) %>% #residential buildings
  mutate(price_per_square = assesstot/bldgarea) %>%
  na.omit()
PLUTO$bldgclass<- substr(PLUTO$bldgclass,0,1)
House_Price<- PLUTO %>%
  group_by(postcode,bldgclass) %>%
  summarise(avg_price = mean(price_per_square))


setwd("~/Downloads/ads-project1/Spring2020-Project2-group-6/app1/output")
save(House_Price,file = "house.RData")
save(S, file = 'school_survey_tidied.RData')









