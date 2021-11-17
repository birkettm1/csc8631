#leaving survey

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*leaving.survey.responses.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
dfLSR <- lapply(files, function(i){
  read_csv(i, col_types=list(
    id = col_integer(),
    last_completed_step = col_character(),
    last_completed_week_number = col_double(),
    last_completed_step_number = col_double()
  ))
}) %>% bind_rows

#fettle the datetimes here
dfLSR$left_at = as.POSIXlt(dfLSR$left_at)
dfLSR$last_completed_step_at = as.POSIXlt(dfLSR$last_completed_step_at)

#working directory back to root
setwd("..")

#head(dfLSR)