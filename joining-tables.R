library(tidyverse)
library(dslabs)
library(ggrepel)
library(dplyr)
data("murders")
head(murders)
cat("\014")

data("polls_us_election_2016")
head(results_us_election_2016)

identical(results_us_election_2016$state, murders$state)

tab <- left_join(murders, results_us_election_2016, by = "state") %>% select(-others) %>% rename(ev = electoral_votes)
cat("\014")
head(tab)
cat("\014")

tab %>% ggplot(aes(population/10^6, ev, label = abb)) + geom_point() + geom_text_repel() + scale_x_continuous(trans = "log2") + scale_y_continuous(trans = "log2") + geom_smooth(method = "lm", se = FALSE)
  
cat("\14")
tab1 <- slice(murders, 1:6) %>% select(state, population)
tab2 <- results_us_election_2016 %>% filter(state %in% c("Alabama", "Alaska", "Arizona", "California", "Connecticut", "Delaware")) %>% select(state, electoral_votes) %>% rename(ev = electoral_votes)

cat("\14")
tab1
tab2

left_join(tab1, tab2, by = "state")
