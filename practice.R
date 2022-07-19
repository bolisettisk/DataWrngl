library(dslabs)
library(rvest)
library(dplyr)
library(stringr)

url <- paste0("https://en.wikipedia.org/w/index.php?title=",
              "Gun_violence_in_the_United_States_by_state",
              "&direction=prev&oldid=810166167")
murders_raw <- read_html(url) %>%
  html_node("table") %>%
  html_table() %>%
  setNames(c("state", "population", "total", "murder_rate"))

data(reported_heights)
cat("\014")
head(reported_heights)

class(reported_heights$height)

# x <- as.numeric(reported_heights$height)
# sum(is.na(x))

#reported_heights %>% mutate(new_height = as.numeric(height)) %>% filter(is.na(new_height)) %>% head(n=10)
cat("\014")
not_inches <- function(x, smallest=50, tallest=84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}

problems <- reported_heights %>% filter(not_inches(height)) %>% pull(height)
length(problems)

cat("\014")

pattern <- ","
str_detect(murders_raw$total, pattern)