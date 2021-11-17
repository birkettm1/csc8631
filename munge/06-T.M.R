#team members

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*team.members.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
datalist = lapply(files, function(i){
  csv <- read_csv(i, show_col_types = FALSE)
  csv$stage_id <- substring(i,16,16)
  csv
})

#collate datalist to dataframe
dfTM <-dplyr::bind_rows(datalist)

#set col names
colnames(dfTM) <- c("learner_id","forename", "surname", "team_role", "user_role", "stage_id")

#create a primary key need to add this as foreign key to other tables
dfTM %>% 
  arrange(learner_id) %>%
  mutate(id = row_number())

dfTM$stage_id = as.integer(dfTM$stage_id)

#working directory back to root
setwd("..")

#head(dfTM)