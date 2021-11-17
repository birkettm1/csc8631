# Example preprocessing script.

#01 - archetype.responses

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*archetype.survey.responses.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
datalist = lapply(files, function(i){
  
  csv <- read_csv(i, col_types=list(
    id = col_integer()
  ))
  
  csv$stage_id <- substring(i,16,16)
  
  csv
})

#collate datalist to dataframe
dfAR <-dplyr::bind_rows(datalist)
 
#fettle the datetimes here
dfAR$responded_at = as.POSIXlt(dfAR$responded_at)
dfAR$stage_id = as.integer(dfAR$stage_id)

#working directory back to root
setwd("..")

#head(dfAR)



