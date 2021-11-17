#team members

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*team.members.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
dfTM <- lapply(files, function(i){
  read_csv(i, show_col_types = FALSE)
}) %>% bind_rows

#set col names
colnames(dfTM) <- c("learner_id","forename", "surname", "team_role", "user_role")

#create a primary key need to add this as foreign key to other tables
dfTM %>% 
  arrange(learner_id) %>%
  mutate(id = row_number())

#working directory back to root
setwd("..")

#head(dfTM)