library(tidyverse)
library(lubridate)
library(scales)
library(dslabs)

# url <- 'http://www.trumptwitterarchive.com/data/realdonaldtrump/%s.json'
# trump_tweets <- map(2009:2017, ~sprintf(url, .x)) %>%
#   map_df(jsonlite::fromJSON, simplifyDataFrame = TRUE) %>%
#   filter(!is_retweet & !str_detect(text, '^"')) %>%
#   mutate(created_at = parse_date_time(created_at, orders = "a b! d! H!:M!:S! z!* Y!", tz="EST")) 


data("trump_tweets")
head(trump_tweets)

names(trump_tweets)


trump_tweets$text[16413] %>% str_wrap(width = options()$width) %>% cat
trump_tweets %>% count(source) %>% arrange(desc(n)) %>% head(5)



campaign_tweets <- trump_tweets %>% extract(source, "source", "Twitter for (.*)") %>% filter(source %in% c("Android", "iPhone") & created_at >= ymd("2015-06-17") & created_at < ymd("2016-11-08")) %>% filter(!is_retweet) %>% arrange(created_at) %>% as.tibble()

cat("\014")


campaign_tweets %>% mutate(hour = hour(with_tz(created_at, "EST"))) %>% count(source, hour) %>% group_by(source) %>% mutate(percent = n/sum(n)) %>% ungroup %>% ggplot(aes(hour, percent, color = source)) + geom_line() + geom_point() + scale_y_continuous(labels = percent_format()) + labs(x = "hour of the day (EST)", y = "% of tweets", colour = "")






