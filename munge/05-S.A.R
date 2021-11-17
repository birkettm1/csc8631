#step activity

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*step.activity.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
dfSA <- lapply(files, function(i){
  read_csv(i, show_col_types = FALSE)
}) %>% bind_rows

#fettle the datetimes here
dfSA$first_visited_at = as.POSIXlt(dfSA$first_visited_at)
dfSA$last_completed_at = as.POSIXlt(dfSA$last_completed_at)

#set col names
colnames(dfSA) <- c("learner_id","step_position", "step_number", "first_visited_at", "last_completed_at")



#working directory back to root
setwd("..")

#head(dfSA)

