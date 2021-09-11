library(tidyverse, dslabs)
path <- system.file("extdata", package = "dslabs")
filename <- file.path(path, "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)

new_tidy_data <- pivot_longer(wide_data, '1960':'2015', names_to = "year", values_to = "fertility")
# or
new_tidy_data <- wide_data %>% pivot_longer('1960':'2015', names_to = "year", values_to = "fertility")