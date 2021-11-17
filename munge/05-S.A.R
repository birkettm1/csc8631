#step activity

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*step.activity.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
datalist = lapply(files, function(i){
  csv <- read_csv(i, show_col_types = FALSE)
  csv$stage_id <- as.integer(substring(i,16,16))
  csv
})

#collate datalist to dataframe
dfSA <-dplyr::bind_rows(datalist)

#fettle the datetimes here
dfSA$first_visited_at = as.POSIXlt(dfSA$first_visited_at)
dfSA$last_completed_at = as.POSIXlt(dfSA$last_completed_at)

#set col names
colnames(dfSA) <- c("learner_id","step_position", "step_number", "first_visited_at", "last_completed_at", "stage_id")

#working directory back to root
setwd("..")

#head(dfSA)

