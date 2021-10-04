library(tidyverse)
library(dslabs)
library(stringr)
library(rvest)
library(dplyr)
library(purrr)


schedule <- data.frame(day = c("Monday", "Tuesday"), staff = c("Mandy, Chris and Laura", "Steve, Ruth and Frank"))

str_split(schedule$staff, ",|and")
str_split(schedule$staff, ", | and ")
str_split(schedule$staff, ",\\s|\\sand\\s")
str_split(schedule$staff, "\\s?(,|and)\\s?")


schedule <- data.frame(day = c("Monday", "Tuesday"), staff = c("Mandy, Chris and Laura", "Steve, Ruth and Frank"))
schedule

tidy <- schedule %>% mutate(staff = str_split(staff, ", | and ")) %>% unnest(cols = staff)
# tidy <- separate(schedule, staff, into = c("s1","s2","s3"), sep = ",") %>% gather(key = s, value = staff, s1:s3)
# tidy <- schedule %>% mutate(staff = str_split(staff, ", | and ", simplify = TRUE)) #%>% unnest()
tidy

cat("\014")

data("gapminder")
dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country_short = recode(country, "Central African Republic" = "CAR", "Congo, Dem. Rep." = "DRC", "Equatorial Guinea" = "Eq. Guinea"))
head(dat)








