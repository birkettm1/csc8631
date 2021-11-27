library('ProjectTemplate'); 
load.project()

#Question Responses
summary(dfQR)

#data quality
#basic data quality checks
type_check <- validator(
  is.character(learner_id)
  , is.character(quiz_question)
  , is.character(question_type)
  , is.double(week_number)
  , is.double(step_number) 
  , is.double(question_number)
  , is.double(response)
  , is.logical(cloze_response)
  , is.Date(submitted_at)
  , is.logical(correct)
)
type_check_results <- confront(dfQR, type_check)
summary(type_check_results)
#plot(type_check_results)

#check missingness
missing_check <- validator(
  !is.na(learner_id)
  , !is.na(quiz_question)
  , !is.na(question_type)
  , !is.na(week_number)
  , !is.na(step_number) 
  , !is.na(question_number)
  , !is.na(response)
  , !is.na(cloze_response)
  , !is.na(submitted_at)
  , !is.na(correct)
)
missing_check_results <- confront(dfQR, missing_check)
summary(missing_check_results)
#plot(missing_check_results)

#data investigation
table(dfQR$quiz_question) 
table(dfQR$week_number) 
table(dfQR$step_number) 
table(dfQR$cloze_response)
barplot(table(dfQR$correct))

dfQRNumbers <- select(dfQR, quiz_question, week_number, step_number, question_number)
dfQRNumbers <- group_by(dfQRNumbers)
dfQRNumbers %>%
  group_by(quiz_question)
unique(dfQRNumbers)
#table(dfQRNumbers)

answerCount = dfQR %>%
  group_by(quiz_question) %>%
  count(dfQR$response)
answerCount = select(answerCount, quiz_question, n)

#responses by question
barplot(answerCount$n
        , main="Count of Responses by Question"
        , xlab="Question"
        , ylab="Count")