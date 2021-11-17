#sentiment survey

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*sentiment.survey.responses.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
datalist = lapply(files, function(i){
  csv <- read_csv(i, col_types=list(
    id = col_character(),
    week_number = col_double(),
    experience_rating = col_double()
  ))
  csv$stage_id <- substring(i,16,16)
  csv
})

#collate datalist to dataframe
dfSS <-dplyr::bind_rows(datalist)

#fettle the datetimes here
dfSS$responded_at = as.POSIXlt(dfSS$responded_at)
dfSS$stage_id = as.integer(dfSS$stage_id)

#working directory back to root
setwd("..")

#head(dfSS)