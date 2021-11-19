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

#leaving reason has multiple reasons for time issues so fettle these
time = filter(dfLSR, grepl("time", dfLSR$leaving_reason, fixed = TRUE)) #time
time$reason = "No time"
easy = filter(dfLSR, grepl("easy", dfLSR$leaving_reason, fixed = TRUE)) #easy
easy$reason = "Easy"
hard = filter(dfLSR, grepl("hard", dfLSR$leaving_reason, fixed = TRUE)) #hard
hard$reason = "Hard"
expected = filter(dfLSR, grepl("expected", dfLSR$leaving_reason, fixed = TRUE)) #expected
expected$reason = "Not as expected"
goals = filter(dfLSR, grepl("goals", dfLSR$leaving_reason, fixed = TRUE)) #goals
goals$reason = "No goals"
notsay = filter(dfLSR, leaving_reason == "I prefer not to say") #not say
notsay$reason = "Not saying"
other = filter(dfLSR, leaving_reason == "Other") #other
other$reason = "Other"

dfLSR = bind_rows(time,easy,hard,expected,goals,notsay,other)
dfLSR

#working directory back to root
setwd("..")

#head(dfLSR)