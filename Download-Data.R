
url <- "https://raw.githubusercontent.com/rafalab/dslabs/master/inst/extdata/murders.csv"
dat <- read_csv(url)

filename <- "murders_download.csv"
destpath <- file.path(getwd(), filename)

download.file(url, filename)

tmp_filename <- tempfile()
download.file(url, temp_filename)
dat <- read_csv(tmp_filename)
file.remove(tmp_filename)