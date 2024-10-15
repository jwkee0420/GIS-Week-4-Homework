library(here)
library(raster)
library(terra)
library(tidyverse)
library(sf)

csv <- read.csv('2010_2.csv')
csv <- select(csv,c('countryIsoCode','country','value'))
csv2 <- read.csv('2019_2.csv')
csv2 <- select(csv2,c('countryIsoCode','country','value'))
join <- csv %>% left_join(csv2, by=c('country'))

difference <- join %>% mutate(difference = join$value.y - join$value.x)
