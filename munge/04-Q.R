#question response

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*question.response.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
datalist = lapply(files, function(i){
  csv <- read_csv(i, show_col_types = FALSE)
  csv$stage_id <- substring(i,16,16)
  csv
})

#collate datalist to dataframe
dfQR <-dplyr::bind_rows(datalist)

#fettle the datetimes here
dfQR$submitted_at = as.POSIXlt(dfQR$submitted_at)
dfQR$cloze_response = as.logical(dfQR$cloze_response)
dfQR$correct = as.logical(dfQR$correct)

#create a primary key need to add this as foreign key to other tables
dfQR %>% 
  arrange(learner_id, week_number, step_number, question_number) %>%
  mutate(id = row_number())

dfQR$stage_id = as.integer(dfQR$stage_id)

x = strsplit(dfQR$quiz_question,split='.', fixed=TRUE)

#split out the quiz question get first two elements and use as step
dfQR$step = strsplit(dfQR$quiz_question,split='.', fixed=TRUE)
dfQR$step = sapply(dfQR$step, function(i){
  x = i[1]
  y = i[2]
  a = paste(x,y, sep=".")
})

#working directory back to root
setwd("..")

#head(dfQR)