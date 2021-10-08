library(tidyverse)
library(lubridate)
library(scales)
library(dslabs)
library(tidytext)
library(textdata)

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

cat("\014")

campaign_tweets <- trump_tweets %>% extract(source, "source", "Twitter for (.*)") %>% filter(source %in% c("Android", "iPhone") & created_at >= ymd("2015-06-17") & created_at < ymd("2016-11-08")) %>% filter(!is_retweet) %>% arrange(created_at) %>% as.tibble() 

cat("\014")


campaign_tweets %>% mutate(hour = hour(with_tz(created_at, "EST"))) %>% count(source, hour) %>% group_by(source) %>% mutate(percent = n/sum(n)) %>% ungroup %>% ggplot(aes(hour, percent, color = source)) + geom_line() + geom_point() + scale_y_continuous(labels = percent_format()) + labs(x = "hour of the day (EST)", y = "% of tweets", colour = "")

# Text as data

poem <- c("Roses are red", "Violets are blue", "Sugar is sweet", "And so are you")
example <- tibble(line = c(1,2,3,4), text = poem)

example %>% unnest_tokens(word, text)

# using tweet example again
cat("\014")

i <- 3008
campaign_tweets$text[i] %>% str_wrap(width = 65) %>% cat()

campaign_tweets[i,] %>% unnest_tokens(word, text) %>% pull(word)

campaign_tweets[i,] %>% unnest_tokens(word, text, token = "tweets") %>% pull(word)

links <- "https://t.co/[A-Za-z\\d]+|&amp;"

campaign_tweets[i,] %>% 
  mutate(text = str_replace_all(text, links, ""))  %>%
  unnest_tokens(word, text, token = "tweets") %>%
  pull(word)

cat("\014")

tweet_words <- campaign_tweets %>% mutate(text = str_replace_all(text, links, ""))  %>%
  unnest_tokens(word, text, token = "tweets")

tweet_words %>% 
  count(word) %>%
  arrange(desc(n))

tweet_words <- campaign_tweets %>% 
  mutate(text = str_replace_all(text, links, ""))  %>%
  unnest_tokens(word, text, token = "tweets") %>%
  filter(!word %in% stop_words$word )

tweet_words %>% 
  count(word) %>%
  top_n(10, n) %>%
  mutate(word = reorder(word, n)) %>%
  arrange(desc(n))

tweet_words <- campaign_tweets %>% 
  mutate(text = str_replace_all(text, links, ""))  %>%
  unnest_tokens(word, text, token = "tweets") %>%
  filter(!word %in% stop_words$word &
           !str_detect(word, "^\\d+$")) %>%
  mutate(word = str_replace(word, "^'", ""))

cat("\014")
android_iphone_or <- tweet_words %>% count(word, source) %>% pivot_wider(names_from = "source", values_from = "n", values_fill = 0) %>% mutate(or = (Android + 0.5) / (sum(Android) - Android + 0.5) / ((iPhone + 0.5) / (sum(iPhone) - iPhone + 0.5))) 

android_iphone_or %>% arrange(desc(or))
android_iphone_or %>% arrange(or)
android_iphone_or %>% filter(Android+iPhone > 100) %>%
  arrange(desc(or))
cat("\014")
android_iphone_or %>% filter(Android+iPhone > 100) %>%
  arrange(or)


# Sentiment analysis
cat("\014")
get_sentiments("bing")
get_sentiments("afinn")
get_sentiments("loughran") %>% count(sentiment)
get_sentiments("nrc") %>% count(sentiment)



nrc <- get_sentiments("nrc") %>% select(word, sentiment)
nrc
tweet_words %>% inner_join(nrc, by = "word") %>% select(source, word, sentiment) %>% sample_n(5)

cat("\014")

sentiment_counts <- tweet_words %>% left_join(nrc, by = "word") %>% count(source, sentiment) %>% pivot_wider(names_from = "source", values_from = "n") %>% mutate(sentiment = replace_na(sentiment, replace = "none"))
sentiment_counts %>% head(20)

sentiment_counts %>%
  mutate(Android = Android / (sum(Android) - Android) , 
         iPhone = iPhone / (sum(iPhone) - iPhone), 
         or = Android/iPhone) %>%
  arrange(desc(or))





