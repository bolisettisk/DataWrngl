library(tidyverse)

filename <- "murders.csv"
dat <- read.csv(filename)

library(readr) #Included in tidyverse package. Don't need to be installed.
# To read data stored in text file formats
read_lines(filename, n_max = 3)

library(readxl) #Included in tidyverse package. Don't need to be installed
# For data stored in Microsoft Excel formats


