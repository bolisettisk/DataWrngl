library(tidyverse, dslabs)
path <- system.file("extdata", package = "dslabs")
filename <- file.path(path, "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)

new_tidy_data <- pivot_longer(wide_data, '1960':'2015', names_to = "year", values_to = "fertility")
# Or
new_tidy_data <- wide_data %>% pivot_longer('1960':'2015', names_to = "year", values_to = "fertility")
# Or
new_tidy_data <- wide_data %>% pivot_longer(-country, names_to = "year", values_to = "fertility")
# The problem is data in the year column is of data type "character"
class(new_tidy_data$year)
new_tidy_data <- wide_data %>% pivot_longer(-country, names_to = "year", values_to = "fertility") %>% mutate(year = as.integer(year))
class(new_tidy_data$year)