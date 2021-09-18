library(tidyverse, dslabs)
path <- system.file("extdata", package = "dslabs")
filename <- file.path(path, "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)

# pivot_longer
new_tidy_data <- wide_data %>% pivot_longer(-country, names_to = "year", values_to = "fertility") %>% mutate(year = as.integer(year))
cat("\014")

# pivot_wider
new_wide_data <- new_tidy_data %>% pivot_wider(names_from = year, values_from = fertility)
select(new_wide_data, country, '1960':'1967')

cat("\014")
# separate
filename <- "life-expectancy-and-fertility-two-countries-example.csv"
filename <-  file.path(path, filename)
raw_data <- read_csv(filename)
select(raw_data, 1:5)

dat <- raw_data %>% pivot_longer(-country)
#dat %>% separate(name, c("year", "name"))

#var_names <- c("year", "first_variable_name", "second_variable_name")
#dat %>% separate(name, var_names, fill = "right")

cat("\014")
dat %>% separate(name, c("year", "name"), extra = "merge") %>% pivot_wider()

# unite
cat("\014")
var_names <- c("year", "first_variable_name", "second_variable_name")
dat %>% separate(name, var_names, fill = "right") %>% unite(name, first_variable_name, second_variable_name) %>% pivot_wider() %>% rename(fertility = fertility_NA)



