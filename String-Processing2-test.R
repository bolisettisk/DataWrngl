library(tidyverse)
library(dslabs)
library(stringr)
library(rvest)
library(dplyr)

not_inches <- function(x, smallest = 50, tallest = 84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest 
  ind
}

cat("\014")

s <- c("70","5 ft","4'11","",".","Six feet")
pattern <- "\\d|ft"
str_view_all(s, pattern)
cat("\014")

animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[a-z]"
str_detect(animals, pattern)
cat("\014")

animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[A-Z]$"
str_detect(animals, pattern)
cat("\014")

animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[a-z]{4,5}"
str_detect(animals, pattern)
cat("\014")

animals <- c("moose", "monkey", "meerkat", "mountain lion")
pattern <- "moo*"
str_detect(animals, pattern)
cat("\014")

schools <- c("U. Kentucky","Univ New Hampshire","Univ. of Massachusetts","University Georgia","U California","California State University")

finals <- schools %>% str_replace("Univ\\.?\\s|^U\\.?\\s", "University ") %>% str_replace("^University of |^University ", "University of ")
cat("\014")


problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.](\\d*)$"
str_match(problems, pattern_with_groups)
str_replace(problems, pattern_with_groups, "\\1'\\2")
cat("\014")

problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.\\s](\\d*)$"
str_match(problems, pattern_with_groups)
str_replace(problems, pattern_with_groups, "\\1'\\2")
cat("\014")

problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.\\s]*(\\d*)$"
str_match(problems, pattern_with_groups)
str_replace(problems, pattern_with_groups, "\\1'\\2")
cat("\014")

not_inches_or_cm <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- !is.na(inches) &
    ((inches >= smallest & inches <= tallest) |
       (inches/2.54 >= smallest & inches/2.54 <= tallest))
  !ind
}
problems <- reported_heights %>% filter(not_inches_or_cm(height)) %>% .$height
converted <- problems %>% str_replace("feet|foot|ft", "'") %>% str_replace("inches|in|''|\"", "") %>% str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
index <- str_detect(converted, pattern)
converted[!index]
cat("\014")

yes <- c("5 feet 7inches", "5 7")
no <- c("5ft 9 inches", "5 ft 9 inches")
s <- c(yes, no)

converted <- s %>%  str_replace("\\s*(feet|foot|ft)\\s*", "'") %>% str_replace("\\s*(inches|in|''|\")\\s*", "") %>% str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")
cat("\014")
s
converted







