library(Lahman)
cat("\014")
top <- Batting %>% filter(yearID == 2016) %>% arrange(desc(HR)) %>%    # arrange by descending HR count
  slice(1:10)    # take entries 1-10
top %>% as_tibble()

Master %>% as_tibble()

top_names <- top %>% left_join(Master) %>% select(playerID, nameFirst, nameLast, HR)

cat("\014")

top_names

cat("\014")

top_salary <- Salaries %>% filter(yearID == 2016) %>% right_join(top_names) %>% select(nameFirst, nameLast, teamID, HR, salary)

head(top_salary)
top_names

cat("\014")

AP <- AwardsPlayers %>% filter(yearID == 2016)

head(AP)
head(top_names)

dplyr::intersect(AP$playerID, top_names$playerID)
dplyr::setdiff(AP$playerID, top_names$playerID) %>% length()
