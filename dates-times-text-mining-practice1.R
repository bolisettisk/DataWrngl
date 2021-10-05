library(tidyverse)
library(dslabs)
library(lubridate)

data("polls_us_election_2016")


polls_us_election_2016 %>% head()
cat("\014")
class(polls_us_election_2016$startdate)
as.numeric(polls_us_election_2016$startdate) %>% head()
polls_us_election_2016$startdate %>% head()


as.Date("1970-01-31") %>% as.numeric()

cat("\014")

polls_us_election_2016 %>% filter(pollster == "Ipsos" &  state == "U.S.") %>% ggplot(aes(startdate, rawpoll_trump)) + geom_line()


# Lubridate Package

cat("\014")
set.seed(2002)
dates <- sample(polls_us_election_2016$startdate, 10) %>% sort()
dates
cat("\014")
tibble(date = dates, month = month(dates), day = day(dates), year = year(dates))

month(dates, label = TRUE)

cat("\014")
x <- 01052021
dmy(x)




