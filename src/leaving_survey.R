library('ProjectTemplate'); 
load.project()

#Leaving Surveys
summary(dfLSR)

#data quality
#basic data quality checks
type_check <- validator(
  is.double(id)
  , is.character(learner_id)
  , is.Date(left_at)
  , is.character(leaving_reason)
  , is.Date(last_completed_step_at)
  , is.character(last_completed_step) 
  , is.character(last_completed_week_number)
  , is.character(last_completed_step_number)
)
type_check_results <- confront(dfLSR, type_check)
summary(type_check_results)
plot(type_check_results)

#check missingness
missing_check <- validator(
  !is.na(id)
  , !is.na(learner_id)
  , !is.na(left_at)
  , !is.na(leaving_reason)
  , !is.na(last_completed_step_at) 
  , !is.na(last_completed_step)
  , !is.na(last_completed_week_number)
  , !is.na(last_completed_step_number)
)
missing_check_results <- confront(dfLSR, missing_check)
summary(missing_check_results)
#plot(missing_check_results)


dfLSR = dfLSR %>% filter(!is.na(last_completed_step))
select(dfLSR, last_completed_step, last_completed_step_number, 
       last_completed_week_number)[1:5,]

table(dfLSR)
leavers = left_join(dfLSR, dfSA, by = c("last_completed_step" = "step_position"), 
                    copy = FALSE, suffix = c(".dfLSR", ".dfSA"), keep = TRUE,
                    na_matched = "na")

leavers = dfLSR %>% left_join(dfSA, by=c("last_completed_step"="step_position")) 

barplot(table(dfLSR$last_completed_step))
barplot(table(dfSA$step_position))
barplot(table(dfLSR$last_completed_step_number))
barplot(table(dfLSR$last_completed_week_number))

#investigate leaving_reasons
table(dfLSR$leaving_reason)

barplot(table(dfLSR$reason)
        , main="Reasons for Leaving"
        , xlab="Reason"
        , ylab="Count of Leavers")

barplot(table(dfLSR$reason)
        , main="Reasons for Leaving"
        , xlab="Reason"
        , ylab="Count of Leavers")

#percentage complete
ggplot(data = dfLSR, aes(x = last_completed_step)) +
  geom_bar() +
  labs(y="Count of Leavers", x = "Step Number") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu") +
  theme(axis.text.x = element_text(angle = 90))