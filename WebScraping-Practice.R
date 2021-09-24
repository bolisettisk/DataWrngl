
library(tidyverse)
library(dplyr)
library(rvest)

url <- "https://en.wikipedia.org/wiki/Demographics_of_India"
h <- read_html(url)

tab <- h %>% html_nodes("table") %>% html_table()

cat("\014")
dat <- tab[[2]]
#dat %>% pivot_longer(-Year, names_to = "Research", values_to = "")

# removing row1
col <- dat[1,]
dat <- setdiff(dat,col)

# combining row1 with names
col_temp <- col %>% pivot_longer(-Year) 
col_temp <- col_temp %>% unite(new, name, value) 
col_temp <- col_temp %>% mutate(temp = "NA")
col_temp1 <- col_temp %>% pivot_wider(names_from = new, values_from = temp)
dat <- dat %>% setNames(names(col_temp1))
setequal(names(dat), names(col_temp1))





