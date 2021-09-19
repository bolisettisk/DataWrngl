library(tidyverse)
library(dslabs)
library(ggrepel)
library(dplyr)

data("murders")
tab <- left_join(murders, results_us_election_2016, by = "state") %>% select(-others) %>% rename(ev = electoral_votes)

#---------------------------------------------------------------------------------------------------------------------
# binding columns
# datasets are combined is by binding them. Unlike the join function, the binding functions do not try to match by a variable, but instead simply combine datasets. If the datasets don’t match by the appropriate dimensions, one obtains an error.

bind_cols(a = 1:3, b = 4:6)
# Note that R-base function cbind has the exact same functionality. However, cbind can create different types of objects but bind_cols always produces a data frame.

tab_1 <- tab[, 1:3]
tab_2 <- tab[, 4:6]
tab_3 <- tab[, 7:8]
new_tab <- bind_cols(tab_1, tab_2, tab_3)
cat("\014")
head(new_tab)


#---------------------------------------------------------------------------------------------------------------------
# binding rows
# The bind_rows function is similar to bind_cols, but binds rows instead of columns

bind_rows(tab_1, tab_2)
#This is based on an R-base function rbind

