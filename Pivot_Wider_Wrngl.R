# Pivot wider function is the inverse of Pivot longer function

new_wide_data <- new_tidy_data %>% pivot_wider(names_from = year, values_from = fertility)
select(new_wide_data, country, '1960':'1967')