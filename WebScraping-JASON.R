#---------------------------------------------------------------------------------------------------------------------
# JASON

# Sharing data on the internet has become more and more common. Unfortunately, providers use different formats, which makes it harder for data scientists to wrangle data into R. Yet there are some standards that are also becoming more common. Currently, a format that is widely being adopted is the JavaScript Object Notation or JSON. Because this format is very general, it is nothing like a spreadsheet. This JSON file looks more like the code you use to define a list.

library(jsonlite)
cat("\014")

res <- fromJSON('http://ergast.com/api/f1/2004/1/results.json')
citi_bike <- fromJSON("http://citibikenyc.com/stations/json")
# this downloads a list. the first argument tells you when you downloaded it.
citi_bike$executionTime
# and the second is a data table
citi_bike$stationBeanList %>% as_tibble()

