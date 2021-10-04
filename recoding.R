library(tidyverse)
library(dslabs)
library(stringr)
library(rvest)
library(dplyr)
library(purrr)

data("gapminder")
cat("\014")


gapminder %>% filter(region == "Caribbean") %>%
  mutate(country = recode(country, 'Antigua and Barbuda' = "Barbuda", 'Dominican Republic' = "DR", 'St. Vincent and the Grenadines' = "St. Vincent", 'Trinidad and Tobago' = "Trinidad")) %>% ggplot(aes(year, life_expectancy, color = country)) + geom_line()


# gapminder %>% filter(region == "Caribbean") %>% ggplot(aes(year, life_expectancy, color = country)) + geom_line()