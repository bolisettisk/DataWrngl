filename <- "murders.csv"
dir <-  system.file("extdata", package = "dslabs")
fullpath <- file.path(dir, filename)
destpath <- file.path(getwd(), filename)
file.copy(fullpath, destpath)

list.files()
file.exists(filename)

# getwd() returns the absolute file path
# setwd(dir) is used to set the working directory to dir