#question response

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*question.response.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
dfQR <- lapply(files, function(i){
  read_csv(i, show_col_types = FALSE)
}) %>% bind_rows

#fettle the datetimes here
dfQR$submitted_at = as.POSIXlt(dfQR$submitted_at)
dfQR$cloze_response = as.logical(dfQR$cloze_response)
dfQR$correct = as.logical(dfQR$correct)

#working directory back to root
setwd("..")

#head(dfQR)