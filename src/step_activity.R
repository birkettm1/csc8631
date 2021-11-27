library('ProjectTemplate'); 
load.project()

#step activity
summary(dfSA)

#basic data quality checks
type_check <- validator(
  is.character(learner_id)
  , is.double(step)
  , is.double(week_number)
  , is.double(step_number)
  , is.Date(first_visited_at) 
  , is.Date(last_completed_at)
)
type_check_results <- confront(dfSA, type_check)
summary(type_check_results)
plot(type_check_results)

#check the types
typeof(dfSA$first_visited_at)
typeof(dfSA$last_completed_at)

#check missingness
missing_check <- validator(
  !is.na(learner_id)
  , !is.na(step)
  , !is.na(week_number)
  , !is.na(step_number)
  , !is.na(first_visited_at) 
  , !is.na(last_completed_at)
)
missing_check_results <- confront(dfSA, missing_check)
summary(missing_check_results)
#plot(missing_check_results)


#investigate step vs week and step numbers
select(dfSA, step, week_number, step_number)[1:5,]
summary(dfSA$step)


par(mfrow=c(3,2))

#uses feature engineered isComplete
#plot complete or not
barplot(table(dfSA$isComplete), ylim=c(0, 400000) 
        , main="Total Completed Steps"
        , xlab="Complete"
        , ylab="Count of Activity Steps")

boxplot(dfSA$step ~ dfSA$isComplete
        , main="Activity vs Step Number"
        , xlab="Complete"
        , ylab="Step Number")

#uses feature engineered timetocomplete
boxplot(as.numeric(dfSA$timeToComplete) ~ as.numeric(substring(dfSA$step,1,3))
        , main="Time to Complete by Step"
        , xlab="Step"
        , ylab="Number of days")

boxplot(as.numeric(dfSA$timeToComplete) ~ dfSA$stage_id
        , main="Time to Complete by Course Stage"
        , xlab="Stage"
        , ylab="Number of days")

barplot(table(dfSA$stage_id) 
        , main="Total Completed Steps by Course Stage"
        , xlab="Stage"
        , ylab="Complete steps")



par(mfrow=c(1,1))