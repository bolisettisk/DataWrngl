library(tidyverse)
library(dslabs)
library(ggrepel)
library(dplyr)


#---------------------------------------------------------------------------------------------------------------------
# binding
# datasets are combined is by binding them. Unlike the join function, the binding functions do not try to match by a variable, but instead simply combine datasets. If the datasets don’t match by the appropriate dimensions, one obtains an error.

bind_cols(a = 1:3, b = 4:6)