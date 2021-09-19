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


#---------------------------------------------------------------------------------------------------------------------
# left join 

tab <- left_join(murders, results_us_election_2016, by = "state") %>% select(-others) %>% rename(ev = electoral_votes)
cat("\014")
head(tab)
cat("\014")

tab %>% ggplot(aes(population/10^6, ev, label = abb)) + geom_point() + geom_text_repel(max.overlaps = 25) + scale_x_continuous(trans = "log2") + scale_y_continuous(trans = "log2") + geom_smooth(method = "lm", se = FALSE)
  
cat("\14")
tab1 <- slice(murders, 1:6) %>% select(state, population)
tab2 <- results_us_election_2016 %>% filter(state %in% c("Alabama", "Alaska", "Arizona", "California", "Connecticut", "Delaware")) %>% select(state, electoral_votes) %>% rename(ev = electoral_votes)

cat("\14")
tab1
tab2

left_join(tab1, tab2, by = "state")
# table with same rows as the first (tab1)
# Suppose we want a table like tab_1, but adding electoral votes to whatever states we have available. For this, we use left_join with tab_1 as the first argument. We specify which column to use to match with the by argument.
# NA s are added to the two states not appearing in tab2


#---------------------------------------------------------------------------------------------------------------------
# right join

tab1 %>% right_join(tab2, by = "state")
# table with same rows as the second (tab2)
# If instead of a table with the same rows as first table, we want one with the same rows as second table, we can use right_join


#---------------------------------------------------------------------------------------------------------------------
# inner join

inner_join(tab1, tab2, by = "state")
# If we want to keep only the rows that have information in both tables, we use inner_join. You can think of this as an intersection


#---------------------------------------------------------------------------------------------------------------------
# full join

full_join(tab1, tab2, by = "state")
# If we want to keep all the rows and fill the missing parts with NAs, we can use full_join. You can think of this as a union


#---------------------------------------------------------------------------------------------------------------------
# semi join

semi_join(tab1, tab2, by = "state")
# The semi_join function lets us keep the part of first table for which we have information in the second. It does not add the columns of the second


#---------------------------------------------------------------------------------------------------------------------
# anti join

anti_join(tab1, tab2, by = "state")
# The function anti_join is the opposite of semi_join. It keeps the elements of the first table for which there is no information in the second




