library(tidyverse)
library(dslabs)
library(ggrepel)
library(dplyr)

data("murders")
tab <- left_join(murders, results_us_election_2016, by = "state") %>% select(-others) %>% rename(ev = electoral_votes)


# Another set of commands useful for combining datasets are the set operators. When applied to vectors, these behave as their names suggest. Examples are intersect, union, setdiff, and setequal. However, if the tidyverse, or more specifically dplyr, is loaded, these functions can be used on data frames as opposed to just on vectors.


#---------------------------------------------------------------------------------------------------------------------
# intersect

cat("\014")
intersect(1:10, 6:15)
# You can take intersections of vectors of any type, such as numeric
# or characters
intersect(c("a", "b", "c"), c("b", "c", "d"))

# The dplyr package includes an intersect function that can be applied to tables with the same column names. This function returns the rows in common between two tables. To make sure we use the dplyr version of intersect rather than the base package version, we can use dplyr::intersect like this

tab_1 <- tab[1:5,]
tab_2 <- tab[3:7,]
dplyr::intersect(tab_1, tab_2)


#---------------------------------------------------------------------------------------------------------------------
# union

cat("\014")
union(1:10, 6:15)
# union takes the union of vectors.
union(c("a","b","c"), c("b","c","d"))

# The dplyr package includes a version of union that combines all the rows of two tables with the same column names.
tab_1 <- tab[1:5,]
tab_2 <- tab[3:7,]
dplyr::union(tab_1, tab_2)


#---------------------------------------------------------------------------------------------------------------------
# setdiff

cat("\014")
setdiff(1:10, 6:15)
setdiff(6:15, 1:10)
# The set difference between a first and second argument can be obtained with setdiff. Unlike intersect and union, this function is not symmetric

#As with the functions shown above, dplyr has a version for data frames
tab_1 <- tab[1:5,]
tab_2 <- tab[3:7,]
dplyr::setdiff(tab_1, tab_2)




