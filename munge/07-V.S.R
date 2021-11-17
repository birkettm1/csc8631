#video stats

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*video.stats.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
dfVS <- lapply(files, function(i){
  read_csv(i, show_col_types = FALSE)
}) %>% bind_rows

#create a primary key need to add this as foreign key to other tables
dfVS %>% 
  arrange(step_position, title) %>%
  mutate(id = row_number())

#working directory back to root
setwd("..")

#head(dfVS)