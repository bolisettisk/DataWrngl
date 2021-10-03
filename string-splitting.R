library(tidyverse)
library(dslabs)
library(stringr)
library(rvest)
library(dplyr)
library(purrr)


cat("\014")
filename <- system.file("extdata/murders.csv", package = "dslabs")
lines <- readLines(filename)
lines %>% head()

x <- str_split(lines, ",")
head(x,2)
cat("\014")

col_names <- x[[1]]
x <- x[-1]

map(x, function(y) y[1]) %>% head(2)
map(x,1) %>% head(2)

dat <- tibble(map_chr(x,1),
              map_chr(x,2),
              map_chr(x,3),
              map_chr(x,4),
              map_chr(x,5)) %>%
  mutate_all(parse_guess) %>%
  set_names(col_names)
cat("\014")


dat <- x %>%
  transpose() %>%
  map( ~ parse_guess(unlist(.))) %>%
  setNames(col_names) %>% 
  as.data.frame() 
head(dat,4)
head(x,4)

cat("\014")
x <- str_split(lines, ",", simplify = TRUE) 
col_names <- x[1,]
x <- x[-1,]
x %>% as_data_frame() %>%
  setNames(col_names) %>%
  mutate_all(parse_guess)
cat("\014")
x

x