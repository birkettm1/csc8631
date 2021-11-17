#leaving survey

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*leaving.survey.responses.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
datalist = lapply(files, function(i){
  csv <-  read_csv(i, col_types=list(
    id = col_integer(),
    last_completed_step = col_character(),
    last_completed_week_number = col_double(),
    last_completed_step_number = col_double()
  ))
  csv$stage_id <- substring(i,16,16)
  csv
})

#collate datalist to dataframe
dfLSR <-dplyr::bind_rows(datalist)

#fettle the datetimes here
dfLSR$left_at = as.POSIXlt(dfLSR$left_at)
dfLSR$last_completed_step_at = as.POSIXlt(dfLSR$last_completed_step_at)
dfLSR$stage_id = as.integer(dfLSR$stage_id)

#working directory back to root
setwd("..")

#head(dfLSR)