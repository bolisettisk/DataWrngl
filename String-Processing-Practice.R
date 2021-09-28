library(tidyverse)
library(dslabs)
library(stringr)
library(rvest)

# read in raw murders data from Wikipedia
url <- "https://en.wikipedia.org/w/index.php?title=Gun_violence_in_the_United_States_by_state&direction=prev&oldid=810166167"
murders_raw <- read_html(url) %>% 
  html_nodes("table") %>% 
  html_table() %>%
  .[[1]] %>%
  setNames(c("state", "population", "total", "murder_rate"))

cat("\014")

pattern <- ","
str_detect(murders_raw$total, pattern)

str_detect(reported_heights$height, "cm")

cat("\014")

yes <- c("180 cm", "70 inches")
no <- c("180", "70''")
s <- c(yes, no)
str_detect(s, "cm") | str_detect(s, "inches")
str_detect(s, "cm|inches")
 
cat("\014")
yes <- c("5", "6", "5'10", "5 feet", "4'11")
no <- c("", ".", "Five", "six")
s <- c(yes, no)
pattern <- "\\d"
str_detect(s, pattern)
str_view(s, pattern)
str_view_all(s, pattern)
str_view(s, "[56]")
cat("\014")
 
yes <- as.character(4:7)
no <- as.character(1:3)
s <- c(yes, no)
str_detect(s, "[4-7]")
cat("\014")

#Anchors
pattern <- "^\\d$"
yes <- c("1", "5", "9")
no <- c("12", "123", "1", "a4", "b")
s <- c(yes, no)
str_view_all(s, pattern)
cat("\014")

#Quantifiers
pattern <- "^\\d{1,2}$"
yes <- c("1", "5", "9", "12")
no <- c("123", "a4", "b")
s <- c(yes, no)
str_view(s, pattern)

cat("\014")
pattern <- "^[4-7]'\\d{1,2}\"$"

yes <- c("5'7\"", "6'2\"", "5'12\"")
no <- c("6,2\"", "6.2\"", "I am 5'11\"", "3'2\"", "64")

str_detect(yes, pattern)
str_detect(no, pattern)
cat("\014")

# White Space \s
yes <- c("5' 7\"", "6'2\"", "5'12\"")
pattern_2 <- "^[4-7]'\\s\\d{1,2}\"$"
str_subset(yes, pattern_2)

