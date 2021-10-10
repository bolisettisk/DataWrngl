library(dslabs)
library(dplyr)
library(lubridate)
library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)


# Project Gutenberg is a digital archive of public domain books. The R package gutenbergr facilitates the importation of these texts into R. We will combine this with the tidyverse and tidytext libraries to practice text mining.


#6
# Q: Use str_detect() to find the ID of the novel Pride and Prejudice.
# How many different ID numbers are returned?
# Ans:
gutenberg_metadata %>% filter(!is.na(title)) %>% mutate(log = str_detect(title, "Pride and Prejudice")) %>% filter(log == "TRUE") %>% count()
# OR
gutenberg_metadata %>% mutate(log = str_detect(title, "Pride and Prejudice")) %>% filter(log == "TRUE") %>% count()


cat("\014")
#7
# Notice that there are several versions of the book. The gutenberg_works() function filters this table to remove replicates and include only English language works. Use this function to find the ID for Pride and Prejudice.
# Q: What is the correct ID number?
# Ans: 
gutenberg_works() %>% filter(!is.na(author)) %>% mutate(log = str_detect(title, "Pride and Prejudice")) %>% filter(log == "TRUE")


#8
# Use the gutenberg_download() function to download the text for Pride and Prejudice. Use the tidytext package to create a tidy table with all the words in the text. Save this object as words.
# Q: How many words are present in the book?
# Ans: 
# book <- gutenberg_download(1342) 
# book %>% unnest_tokens(word, text) %>% nrow()
# Question is not clear. The book contains "preface" which the exam doesn't take into account. The book from the mirror "http://gutenberg.readingroo.ms/" doesn't contain the preface. 
book <- gutenberg_download(1342, mirror="http://gutenberg.readingroo.ms/") 
words <- book %>% unnest_tokens(word, text)
book %>% unnest_tokens(word, text) %>% count()


# 9
# Remove stop words from the words object. Recall that stop words are defined in the stop_words data frame from the tidytext package.
# Q: How many words remain?
# Ans:
book %>% unnest_tokens(word, text) %>% filter(!word %in% stop_words$word) %>% count()


# 10
# After removing stop words, detect and then filter out any token that contains a digit from words.
# Q: How many words remain?
# Ans:
book %>% unnest_tokens(word, text) %>% filter(!word %in% stop_words$word & !str_detect(word, "\\d+")) 


# 11
# Analyze the most frequent words in the novel after removing stop words and tokens with digits.

# Q: How many words appear more than 100 times in the book?
# Ans:
book %>% unnest_tokens(word, text) %>% filter(!word %in% stop_words$word & !str_detect(word, "\\d+")) %>% count(word) %>% filter(n >= 100) %>% count()

# Q: What is the most common word in the book? and How many times does that most common word appear?
# Ans:
book %>% unnest_tokens(word, text) %>% filter(!word %in% stop_words$word & !str_detect(word, "\\d+")) %>% count(word) %>% filter(n == max(n))


cat("\014")
# 12
# Define the afinn lexicon:
afinn <- get_sentiments("afinn")
# Note that this command will trigger a question in the R Console asking if you want to download the AFINN lexicon. Press 1 to select "Yes" (if using RStudio, enter this in the Console tab).

# Use this afinn lexicon to assign sentiment values to words. Keep only words that are present in both words and the afinn lexicon. Save this data frame as afinn_sentiments.

words <- words %>% filter(!word %in% stop_words$word)
afinn_sentiments <- words %>% inner_join(afinn, by = "word") %>% select(word, value)

# Q: How many elements of words have sentiments in the afinn lexicon?
# Ans: 
#afinn_sentiments <- afinn_sentiments %>% mutate(dup = duplicated(word)) %>% filter(dup == "FALSE") %>% select(!dup) 
afinn_sentiments %>% count()

# Q: What proportion of words in afinn_sentiments have a positive value?
# Ans
total <- afinn_sentiments %>% count()
positive <- afinn_sentiments %>% filter(value >= 0) %>% count()
positive/total

# Q: How many elements of afinn_sentiments have a value of 4?

afinn_sentiments %>% filter(value == 4) %>% count()





