library(tidyverse, dslabs)

path <- system.file("extdata", package = "dslabs")
filename <- "life-expectancy-and-fertility-two-countries-example.csv"
filename <- file.path(path, filename)

raw_data <- read_csv(filename)
select(raw_data, 1:5)

cat("\014") # Clear Console

dat <- raw_data %>% pivot_longer(-country)
# column name "year" is not used since it also contains variable type
head(dat)
dat$name[1:5]


var_names <- c("year", "first_variable_name", "second_variable_name")
dat %>% separate(name, var_names, fill = "right")

dat %>% separate(name, var_names, fill = "right") %>% unite(name, first_variable_name, second_variable_name) %>% pivot_wider(names_from = name) %>% rename(fertility = fertility_NA)


