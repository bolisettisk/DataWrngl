library(tidyverse)
library(dslabs)
library(stringr)
library(rvest)
library(dplyr)
library(purrr)
library(rvest)

url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% html_nodes("table")
polls <- tab[[6]] %>% html_table(fill = TRUE)

cat("\014")
dat <- polls %>% setNames(c("dates", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes")) 
polls <- dat %>% mutate(temp = remain) %>% extract(temp, c("a", "b"), regex = "^\\s*(\\d*\\.*\\d*)\\s*(%)\\s*$") %>% filter(!is.na(b)) %>% select(-c(a,b))

# cat("\014")
# dat %>% mutate(temp = remain) %>% extract(temp, c("a", "b"), regex = "^\\s*(\\d*\\.*\\d*)\\s*(%)\\s*$") %>% filter(!is.na(b)) %>% unite(temp, a, b, sep = "")


polls <- polls %>% mutate(undecided = str_replace(undecided, "N/A", "0"))

temp_fun <- function(x) x[length(x)]
head(polls$dates)
head(sapply(polls$dates, function(x) x[length(x)]))

cat("\014")
temp <- str_extract_all(polls$dates, "\\d+\\s[a-zA-Z]+")
end_date <- sapply(temp, function(x) x[length(x)]) # take last element (handles polls that cross month boundaries)

head(polls$dates)
temp
end_date






