library(rvest)
library(dplyr)
library(tidyverse)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)

nodes <- html_nodes(h, "table")


html_text(nodes[[8]])
cat("\014")

html_table(nodes[17:21])
html_text(nodes)

cat("\014")

tab_1 <- html_table(nodes[[10]])
tab_2 <- html_table(nodes[[19]])

#tab1 <- as.data.frame(tab_1)
#tab2 <- as.data.frame(tab_2)

cat("\014") 
tab_1 <- tab_1 %>% setNames(c("name", "Team", "Payroll", "Average")) %>% select(-name)
tab_2 <- tab_2 %>% setNames(c("Team", "Payroll", "Average"))
#tab_1 <- tab_1 %>% select(-name)
tab_1 <- dplyr::setdiff(tab_1, tab_1[1,])
tab_2 <- dplyr::setdiff(tab_2, tab_2[1,])
head(tab_1)
head(tab_2)
cat("\014")
full_join(tab_1, tab_2, by = "Team")