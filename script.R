library(here)
library(raster)
library(terra)
library(tidyverse)
library(sf)
library(tmap)

csv <- read.csv('2010_2.csv')
csv <- select(csv,c('countryIsoCode','country','value'))
csv2 <- read.csv('2019_2.csv')
csv2 <- select(csv2,c('countryIsoCode','country','value'))
join <- csv %>% left_join(csv2, by=c('country'))

difference <- join %>% mutate(difference = join$value.y - join$value.x)
difference2 <- select(difference, c('countryIsoCode.y','difference'))

world2 <- world %>% merge(., difference2, by.x= "color_code", by.y= "countryIsoCode.y")
tmap_mode("plot")

world2 %>%
  qtm(.,fill = "difference", style="jenks") + tm_legend(legend.position = c("left", "bottom"),
          main.title = "Changes in Gender Inequality",
          main.title.position = "center")

#add linetest
