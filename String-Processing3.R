library(tidyverse)
library(dslabs)
library(stringr)
library(rvest)
library(dplyr)

cat("\014")
s <- c("5'10", "6'1")
tab <- data.frame(x = s)

# the separate and extract functions behave similarly
tab %>% separate(x, c("feet", "inches"), sep = "'")
tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")
cat("\014")

# second example - some heights with unusual formats
s <- c("5'10", "6'1\"","5'8inches")
tab <- data.frame(x = s)
# separate fails because it leaves in extra characters, but extract keeps only the digits because of regex groups
tab %>% separate(x, c("feet","inches"), sep = "'", fill = "right")
tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")
cat("\014")

yes <- c("5", "6", "5")
no <- c("5'", "5''", "5'4")
s <- c(yes, no)
str_replace(s, "^([4-7])$", "\\1'0")
str_replace(s, "^([56])'?$", "\\1'0")
cat("\014")

yes <- c("5", "6", "5")
no <- c("5'6.4", "5''", "5'4")
s <- c(yes, no)
pattern <- "^[4-7]\\s*'\\s*(\\d+\\.?\\d*)$"
str_detect(s, pattern)
cat("\014")

yes <- c("1,7", "1, 8", "2, " )
no <- c("5,8", "5,3,2", "1.7")
s <- c(yes, no)
str_replace(s, "^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2")
cat("\014")

str_trim("5 ' 9 ")
