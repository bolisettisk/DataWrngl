library(tidyverse)

filename <- "murders.csv"
dat <- read_csv(filename)

library(readr) #Included in tidyverse package. Don't need to be installed.
# To read data stored in text file formats
read_lines(filename, n_max = 3)

library(readxl) #Included in tidyverse package. Don't need to be installed
# For data stored in Microsoft Excel formats

names(dat)

cat("\014") # clears R console

# Scan function example
path <-  system.file("extdata", package = "dslabs")

x <- scan(file.path(path, filename), sep = ",", what = "c")
x[1:10]

