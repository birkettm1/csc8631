#video stats

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*video.stats.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
datalist = lapply(files, function(i){
  csv <- read_csv(i, show_col_types = FALSE)
  csv$stage_id <- substring(i,16,16)
  csv
})

#collate datalist to dataframe
dfVS <-dplyr::bind_rows(datalist)

#create a primary key need to add this as foreign key to other tables
dfVS %>% 
  arrange(step_position, title) %>%
  mutate(id = row_number())

dfVS$stage_id = as.integer(dfVS$stage_id)

#create sub views for working with separate datasets
dfVSTotals = dfVS[,1:15]
dfVSDevice = dfVS[,c(1,2,16:21)]
dfVSLocation = dfVS[,c(1,2,22:28)]

#working directory back to root
setwd("..")

#head(dfVS)