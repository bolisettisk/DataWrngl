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

# The function does separate the values, but we run into a new problem. We receive the warning Too many values at 112 locations: and that the life_expectancy variable is truncated to life. This is because the _ is used to separate life and expectancy, not just year and variable name! We could add a third column to catch this and let the separate function know which column to fill in with missing values, NA, when there is no third value. 

var_names <- c("year", "first_variable_name", "second_variable_name")
dat %>% separate(name, var_names, fill = "right")

# However, if we read the separate help file, we find that a better approach is to merge the last two variables when there is an extra separation:
cat("\014")
dat %>% separate(name, c("year", "name"), extra = "merge")


# achieves the separation we wanted. However, we are not done yet. We need to create a column for each variable. As we learned, the pivot_wider function can do this:
  
dat %>% separate(name, c("year", "name"), extra = "merge") %>% pivot_wider()
# dat %>% separate(name, c("year", "name"), extra = "merge") %>% pivot_wider(names_from = country)