devtools::install_github("njtierney/ukpolice")
library(ukpolice)
library(ggplot2)
library(dplyr)

#create months for list 
months<-paste0(2015,"-", formatC(c(1:12),flag=0,width=2))

#create object to store data
data<-list()

for(i in months){

  crime_data <- ukp_crime(lat = 51.518654, 
                                 lng = -0.040372,
                                 date = i)
  data[[i]]<- crime_data
  }

#bind data together in list into dataframe
data_all<-do.call(rbind, data)

View(data_all)

table(data_all$category)

ggplot(data= data_all) + 
  geom_bar(aes(x = category, fill = category))+
  facet_wrap(~date)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#removeASB
dataNotASB<- data_all%>% filter (category != "anti-social-behaviour")


ggplot(data= dataNotASB) + 
  geom_bar(aes(x = category, fill = category))+
  facet_wrap(~date)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#just for one month instead
crime_data_August <- ukp_crime(lat = 51.518654, 
                             lng = -0.040372,
                             date = "2016-08")

View(crime_data_August)


