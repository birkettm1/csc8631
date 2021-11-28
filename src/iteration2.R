library('ProjectTemplate'); 
setwd("C:/DevProjects/csc8631")
load.project()

#Iteration 2
head(dfE) #enrollments #pk is id
head(dfTM) #team members #pk is id
head(dfAR) #archetype responses #pk is id
head(dfSA) #step activity
head(dfQR) #question response #pk is id
head(dfLSR) #leaving survey #pk is id
head(dfVS) #video stats #pk is id
head(dfSS) #sentiment survey #pk is id

#data transformations
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
dfStep = select(dfSA, learner_id, step, isComplete, timeToComplete)

#answers
dfAnswers = select(dfQR, learner_id, step, week_number, quiz_question, response, submitted_at, correct)

#videos - from iteration 1
dfVSDevice
dfVSDevicePivot
dfVSLocation
dfVSLocationPivot
dfVSTotals
dfVSTotalsPivot

#sentiment
dfSentiment <- dfSS

#some investigation

#roles
table(dfStudentInfo[,6]) # archetype
table(dfStudentInfo[,7]) # role
table(dfStudentInfo[,8]) # team_role
table(dfStudentInfo[,9]) # user_role

#archetypes
df <- dfStudentInfo[,c(1,6)] %>% drop_na(archetype)
ggplot(data = df, aes(x = archetype)) +
  geom_bar() +
  labs(title= "Students by Archetype", y="Count", x = "Archetype") +  
  theme_bw() + 
  scale_fill_brewer(palette="PuBu")
  # + theme(axis.text.x = element_text(angle = 90))

#team roles
df <- dfStudentInfo[,c(1,8)] %>% drop_na(team_role)
ggplot(data = df, aes(x = team_role)) +
  geom_bar() +
  labs(title="Students by Team Role", y="Count", x = "Team Role") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu")
  #+ theme(axis.text.x = element_text(angle = 90))

#leavers
ggplot(data = dfPerson, aes(x = left)) +
  geom_bar() +
  labs(title="Leaver Students", y="Count", x = "Left") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu")

#completed steps - raw counts
dfCompletedSteps = filter(dfStep, isComplete==TRUE)
dfCompletedSteps$step = as.character(dfCompletedSteps$step)
ggplot(data = dfCompletedSteps, aes(x = step)) +
  geom_bar() +
  labs(title="Completed Steps", y="Count", x = "Step") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu") + 
  theme(axis.text.x = element_text(angle = 90))

#completed steps by archetype
df <- left_join(dfStudentInfo, dfStep, by = c("learner_id" = "learner_id"))
df <- select(df, learner_id, step, archetype, isComplete)
df <- df %>% drop_na(archetype)
#summary(df)
ggplot(data = df, aes(fill=isComplete, x = archetype, y=step)) +
  geom_bar(stat="identity") +
  labs(title="Step Outcomes by Student Archetype", y="Count", x = "Archetype") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu", name="Complete") + 
  theme(axis.text.x = element_text(angle = 90))

#completed steps by team role #learner students don't have a team role
df <- left_join(dfStudentInfo, dfStep, by = c("learner_id" = "learner_id"))
df <- select(df, learner_id, step, team_role, isComplete)
df <- df %>% drop_na(team_role)
summary(df)
ggplot(data = df, aes(fill=isComplete, x = team_role, y=step)) +
  geom_bar(stat="identity") +
  labs(title="Step Outcomes by Student Team Role", y="Count", x = "Team Role") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu", name="Complete") 
  # + theme(axis.text.x = element_text(angle = 90))

#completed steps by highest education level
df <- left_join(dfPerson, dfStep, by = c("learner_id" = "learner_id"))
df <- select(df, learner_id, step, highest_education_level, isComplete)
df <- filter(df, df$highest_education_level != "Unknown")
df <- df %>% drop_na(highest_education_level)
#summary(df)
ggplot(data = df, aes(fill=isComplete, x = highest_education_level, y=step)) +
  geom_bar(stat="identity") +
  labs(title="Step Outcomes by Student Highest Education Level", y="Count", x = "Highest Education Level") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu", name="Complete") +
  theme(axis.text.x = element_text(angle = 90))

#completed steps by employment status
df <- left_join(dfPerson, dfStep, by = c("learner_id" = "learner_id"))
df <- select(df, learner_id, step, employment_status, isComplete)
df <- filter(df, df$employment_status != "Unknown")
df <- df %>% drop_na(employment_status)
#summary(df)
ggplot(data = df, aes(fill=isComplete, x = employment_status, y=step)) +
  geom_bar(stat="identity") +
  labs(title="Step Outcomes by Student Employment Status", y="Count", x = "Employment Status") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu", name="Complete") +
  theme(axis.text.x = element_text(angle = 90))


#answers
dfAnswers

#answers by question
df = dfAnswers %>% group_by(quiz_question) %>% count(dfAnswers$step)
df = select(answerCount, quiz_question, n)
ggplot(data = df, aes(x = quiz_question, y=n)) +
  geom_bar(stat="identity") +
  labs(title="Questions Answered", y="Answers", x = "Question Number") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu") +
  theme(axis.text.x = element_text(angle = 90))

#outcome by question
df = dfAnswers %>% group_by(quiz_question) %>% count(dfAnswers$correct)
colnames(df) <- c('Quiz_Question', 'Correct', 'Count')
ggplot(data = df, aes(fill=Correct, x = Quiz_Question, y=Count)) +
  geom_bar(stat="identity") +
  labs(title="Question Outcome", y="Count", x = "Question Number") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu") +
  theme(axis.text.x = element_text(angle = 90))

#outcome by ...
dfPerson
dfStudentInfo
dfAnswers

#archetype
df = left_join(dfStudentInfo, dfAnswers, by = c("learner_id" = "learner_id"))
df <- select(df, learner_id, archetype, quiz_question, correct)
df <- df %>% drop_na(archetype)
df <- df %>% drop_na(correct)
#summary(df)
ggplot(data = df, aes(fill=correct, x = archetype)) +
  geom_bar() +
  labs(title="Question Outcome by Archetype", y="Count", x = "Archetype") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu") +
  theme(axis.text.x = element_text(angle = 90))

#highest educational achievement
df = left_join(dfPerson, dfAnswers, by = c("learner_id" = "learner_id"))
df <- select(df, learner_id, highest_education_level , quiz_question, correct)
df <- filter(df, df$highest_education_level != "Unknown")
df <- df %>% drop_na(highest_education_level)
df <- df %>% drop_na(correct)
ggplot(data = df, aes(fill=correct, x = highest_education_level )) +
  geom_bar() +
  labs(title="Question Outcome by Highest Educational Level", y="Count", x = "Archetype") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu") +
  theme(axis.text.x = element_text(angle = 90))

#videos
dfVSDevice
dfVSDevicePivot
dfVSLocation
dfVSLocationPivot
dfVSTotals
dfVSTotalsPivot

ggplot(data = dfVSTotalsPivot, aes(fill=percentviewed, y = count, x = as.character(step_position))) +
  geom_bar(stat="identity", position="dodge") +
  labs(title= "Views by Video Completion", y="Views", x = "Video") + 
  scale_fill_brewer(palette="PuBu", name="Viewed",
                    breaks=c("05", "10", "25" ,"50","75","95", "99"),
                    labels=c("5%", "10%", "25%" ,"50%","75%","95%", "100%")) +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90))

#video by device
ggplot(data = dfVSDevicePivot, aes(fill=percentviewed, y = count, x = as.character(step_position))) +
  geom_bar(stat="identity", position="dodge") +
  labs(title= "Views by Device", y="Views", x = "Video") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu", name="Device") +
  theme(axis.text.x = element_text(angle = 90))

#video by location
ggplot(data = dfVSLocationPivot, aes(fill=percentviewed, y = count, x = as.character(step_position))) +
  geom_bar(stat="identity", position="dodge") +
  labs(title= "Views by Location", y="Views", x = "Video") + 
  scale_fill_brewer(palette="PuBu", name="Location") +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90))

#Investigate if there is any relationship between archetype and views, or drop out rate.
#Investigate any relationship between views and leavers
#Investigate any relationship between sentiment, views and leavers