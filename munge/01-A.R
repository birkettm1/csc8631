# Example preprocessing script.

#01 - archetype.responses

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*archetype.survey.responses.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
dfAR <- lapply(files, function(i){
  read_csv(i, col_types=list(
    id = col_character()
  ))
}) %>% bind_rows

#working directory back to root
setwd("..")

#head(dfAR)

