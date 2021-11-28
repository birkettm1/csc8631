library('ProjectTemplate'); 
load.project()

#something about sentiment - relate back via week_number
summary(dfSS)

#basic data quality checks
type_check <- validator(
  is.character(id)
  , is.date(responded_at)
  , is.double(week_number)
  , is.double(experience_rating)
  , is.character(reason) 
)
type_check_results <- confront(dfSS, type_check)
summary(type_check_results)
#plot(type_check_results)

#check missingness
missing_check <- validator(
  !is.na(id)
  , !is.na(responded_at)
  , !is.na(week_number)
  , !is.na(experience_rating)
  , !is.na(reason) 
)
missing_check_results <- confront(dfSS, missing_check)
summary(missing_check_results)
#plot(missing_check_results)

table(dfSS$reason)
count(dfSS, reason)

ggplot(dfSS, aes(x=week_number, fill=factor(experience_rating))) + 
  geom_bar(position="stack") +
  labs(title= "Weekly Experience Rating", y="Count", x = "Week Number") +
  theme_bw() + 
  scale_fill_brewer(palette="PuBu", name="Experience Rating")