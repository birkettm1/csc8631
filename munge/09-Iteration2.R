#data transformations - iteration 2
#create dfStudent and person from enrollments, archetypes, team members
dfStudent <- left_join(dfE, dfAR, by = c("learner_id" = "learner_id")) #enrollment
dfStudentTM <- left_join(dfStudent, dfTM, by = c("learner_id" = "learner_id")) #team member
dfStudentLeavers <- left_join(dfStudentTM, dfLSR, by = c("learner_id" = "learner_id")) #leavers
dfStudentLeavers$left = !is.na(dfStudentLeavers$last_completed_step) #set leaver flag
#summary(dfStudent)

#select out two tables
dfStudentInfo = select(dfStudentLeavers, learner_id, enrolled_at, unenrolled_at,
                       fully_participated_at, purchased_statement_at, 
                       archetype, role, team_role, user_role)

dfPerson = select(dfStudentLeavers, learner_id, gender, country, age_range, 
                  highest_education_level, employment_status, employment_area,
                  detected_country, left)

#steps
dfStep = select(dfSA, learner_id, step, step_number, isComplete, timeToComplete)

#answers
dfAnswers = select(dfQR, learner_id, step, week_number, quiz_question, response, submitted_at, correct)

#sentiment
dfSentiment <- dfSS


#Student Info - Enrolled length of time
dfStudentInfo$totalEnrolledTime = difftime(dfStudentInfo$unenrolled_at, 
                                           dfStudentInfo$enrolled_at, 
                                           units="days") #calculate the difference
