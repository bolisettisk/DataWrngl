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

# Encoding multiple variables in a column name is such a common problem that the readr package includes a function to separate these columns into two or more. Apart from the data, the separate function takes three arguments: the name of the column to be separated, the names to be used for the new columns, and the character that separates the variables. So, a first attempt at this is:


# dat %>% separate(name, c("year", "name"), "_") : The default seperator for the separate function is "_". So this argument doesn't need to be defined in this case
dat %>% separate(name, c("year", "name"))


