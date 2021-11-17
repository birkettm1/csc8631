#sentiment survey

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*sentiment.survey.responses.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
dfSS <- lapply(files, function(i){
  read_csv(i, col_types=list(
    id = col_character(),
    week_number = col_double(),
    experience_rating = col_double()
  ))
}) %>% bind_rows

#fettle the datetimes here
dfSS$responded_at = as.POSIXlt(dfSS$responded_at)

#working directory back to root
setwd("..")

#head(dfSS)