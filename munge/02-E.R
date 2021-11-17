#enrollments

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*enrolments.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
dfE <- lapply(files, function(i){
  read_csv(i, show_col_types = FALSE)
}) %>% bind_rows

#fettle the datetimes here
dfE$enrolled_at = as.POSIXlt(dfE$enrolled_at)
dfE$unenrolled_at = as.POSIXlt(dfE$unenrolled_at)
dfE$fully_participated_at = as.POSIXlt(dfE$fully_participated_at)
dfE$purchased_statement_at = as.POSIXlt(dfE$purchased_statement_at)

#create a primary key need to add this as foreign key to other tables
dfE %>% 
  arrange(learner_id, enrolled_at) %>%
  mutate(id = row_number())
  
#working directory back to root
setwd("..")

#head(dfE)