library(tidyverse)
library(pdftools)
library(dplyr)
options(digits = 3)    # report 3 significant digits
library(ggplot2)

fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
# only for the first time
#system("cmd.exe", input = paste("start", fn))


txt <- pdf_text(fn)
dat <- txt[9]

x <- str_split(dat, "\n")
class(x)
s <- x[[1]]
class(s)
length(s)


s <- s %>% str_trim()
s[1]


header_index <- str_which(s, "2015")
header_index[1]

header <- s[header_index[1]]
month <- str_split(header, "\\s+", simplify = TRUE)[1]
header <- str_split(header, "\\s+", simplify = TRUE)[-1]
month
header


tail_index <- str_which(s, "Total")
tail_index

cat("\014")
n <- str_count(s, "\\d+") 
n <- which(n ==1)


entries <- c(1:header_index[1], n, tail_index:41)
s <- s[-entries]
length(sn)

s <- str_remove_all(s, "[^\\d\\s]")
s <- str_split_fixed(s, "\\s+", n = 6)[,1:5]
s <- as_tibble(s)
cat("\014")
tab <- setNames(s, c("day", header))

s2015 <- as.numeric(tab$"2015")
mean(s2015)

s2016 <- as.numeric(tab$"2016")
mean(s2016)

s2017pre <- mean(as.numeric(tab$"2017")[1:19])
s2017pre

s2017Post <- mean(as.numeric(tab$"2017")[-c(1:19)])
s2017Post

cat("\014")
tab  <- tab %>% gather(year, deaths, -day) %>% mutate(deaths = as.numeric(deaths), day = as.numeric(day))
tab

tab %>% ggplot(aes(day, deaths, color = year)) + geom_line() + geom_vline(xintercept = 20)

# cat("\014")
# library(dslabs)
# data("gapminder")
# head(gapminder)

