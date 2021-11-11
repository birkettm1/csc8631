#question response

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*question.response.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
dfQR <- lapply(files, function(i){
  read_csv(i, show_col_types = FALSE)
}) %>% bind_rows

#working directory back to root
setwd("..")

#head(dfQR)