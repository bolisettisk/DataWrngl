library(dslabs)
library(dplyr)
library(lubridate)
options(digits = 3)    # 3 significant digits


#1 
# Q: Which of the following is the standard ISO 8601 format for dates? 
# Ans: YYYY-MM-DD 

#2
# Q: Which of the following commands could convert this string into the correct date format? 
dates <- c("09-01-02", "01-12-07", "02-03-04")
# Ans: It is impossible to know which format is correct without additional information. 


# 3:
data(brexit_polls)
# Q: How many polls had a start date (startdate) in April (month number 4)?
# Ans:
brexit_polls %>% filter(month(startdate) == 4) %>% count()

# Q: Use the round_date() function on the enddate column with the argument unit="week". How many polls ended the week of 2016-06-12?
# Ans:
brexit_polls %>% mutate(enddate_r = round_date(enddate, unit = "week")) %>% filter(enddate_r == ymd("2016-06-12")) %>% select(enddate, enddate_r) %>% count()


# 4
# Q: Use the weekdays() function from lubridate to determine the weekday on which each poll ended (enddate).
brexit_polls %>% mutate(end_week = weekdays(enddate)) %>% select(end_week) %>% count(end_week) %>% filter(n == max(n))


cat("\014")
# 5
data(movielens)
# This data frame contains a set of about 100,000 movie reviews. The timestamp column contains the review date as the number of seconds since 1970-01-01 (epoch time).

#Convert the timestamp column to dates using the lubridate as_datetime() function.

#  Q: Which year had the most movie reviews?
movielens %>% mutate(date = as_datetime(timestamp), y = year(date)) %>% count(y) %>% filter(n == max(n))

#  Q: Which hour of the day had the most movie reviews?
movielens %>% mutate(date = as_datetime(timestamp), h = hour(date)) %>% count(h) %>% filter(n == max(n))
