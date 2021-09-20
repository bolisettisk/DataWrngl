library(tidyverse)
library(dslabs)
cat("\014")
path <- system.file("extdata", package = "dslabs")
filename <- file.path(path, "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)

new_tidy_data <- wide_data %>% pivot_longer(-country, names_to = "year", values_to = "fertility") %>% mutate(year = as.integer(year))
#new_tidy_data <- wide_data %>% gather(year, fertility, `1960`:`2015`)
new_tidy_data <- wide_data %>% gather(year, fertility, -country)
head(new_tidy_data)
new_tidy_data

new_wide_data <- new_tidy_data %>% pivot_wider(names_from = year, values_from = fertility)
new_wide_data

cat("\014")
filename1 <- file.path(path, "life-expectancy-and-fertility-two-countries-example.csv")
raw_dat <- read_csv(filename1)
dat <- raw_dat %>% pivot_longer(-country)

dat %>% separate(name, c("year", "name"))


