url <- paste0("https://en.wikipedia.org/w/index.php?title=", "Gun_violence_in_the_United_States_by_state", "&direction=prev&oldid=810166167")

library(tidyverse)
library(rvest)
h <- read_html(url)


#---------------------------------------------------------------------------------------------------------------------
# rvest package

cat("\014")
class(h)

# we can see all the code that defines the downloaded webpage using the html_text function
rd <- html_text(h)

# We don’t show the output here because it includes thousands of characters, but if we look at it, we can see the data we are after are stored in an HTML table: you can see this in this line of the HTML code above <table class="wikitable sortable">. The different parts of an HTML document, often defined with a message in between < and > are referred to as nodes. The rvest package includes functions to extract nodes of an HTML document: 

# html_nodes extracts all nodes of different types and html_node extracts the first one. To extract the tables from the html code we use:

tab <- h %>% html_nodes("table")
# Now, instead of the entire webpage, we have just the html code for the tables in the page

tab
# the table we are interested is the first one

tab[[1]]

# This is clearly not a tidy dataset, not even a data frame. In the code above, you can definitely see a pattern and writing code to extract just the data is very doable. In fact, rvest includes a function just for converting html tables into data frames. 
tab <- tab[[1]] %>% html_table
class(tab)
tab <- tab %>% setNames(c("state", "population", "total", "murder_rate"))
tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
cat("\014")
head(tab)

# We still have wrangling to do. For example, we need to remove the commas and turn characters into numbers.




