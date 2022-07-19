library(dslabs)
library(rvest)
library(dplyr)

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

cat("\014")
problems <- reported_heights %>% filter(not_inches(height)) %>% pull(height)
length(problems)