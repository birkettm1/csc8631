#video stats

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*video.stats.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
dfVS <- lapply(files, function(i){
  read_csv(i, show_col_types = FALSE)
}) %>% bind_rows

#working directory back to root
setwd("..")

#head(dfVS)