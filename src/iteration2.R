library('ProjectTemplate'); 
setwd("C:/DevProjects/csc8631")
load.project()

#Iteration 2

#enrollments
dfStudentInfo
dfPerson

#steps
dfStep

#answers
dfAnswers

#sentiment
dfSentiment

#videos
dfVSDevice
dfVSDevicePivot
dfVSLocation
dfVSLocationPivot
dfVSTotals
dfVSTotalsPivot


#Investigation

#roles
table(dfStudentInfo[,6]) # archetype
table(dfStudentInfo[,7]) # role
table(dfStudentInfo[,8]) # team_role
table(dfStudentInfo[,9]) # user_role

#enrollment 
plot.enrollment(dfStudentInfo[,c(1,6)], 'archetype') #role
plot.enrollment(dfStudentInfo[,c(1,7)], 'role') #role
plot.enrollment(dfStudentInfo[,c(1,8)], 'team_role') #team_roles
plot.enrollment(dfStudentInfo[,c(1,9)], 'user_role') #user_role
plot.enrollment(dfPerson, 'left') #leavers
plot.enrollment(dfPerson[,c(1,2)], 'gender') #gender
plot.enrollment(dfPerson[,c(1,3)], 'country') #country
plot.enrollment(dfPerson[,c(1,4)], 'age_range') #age_range
plot.enrollment(dfPerson[,c(1,5)], 'highest_education_level') #highest education
plot.enrollment(dfPerson[,c(1,6)], 'employment_status') #employment status
plot.enrollment(dfPerson[,c(1,7)], 'employment_area') #employment area
plot.enrollment(dfPerson[,c(1,8)], 'detected_country') #detected country

#completed steps - raw counts
dfCompletedSteps = filter(dfStep, isComplete==TRUE)
dfCompletedSteps$step = as.character(dfCompletedSteps$step)
ggplot(data = dfCompletedSteps, aes(x = as.character(step))) +
  geom_bar() +
  labs(title="Completed Steps", y="Count", x = "Step") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu") + 
  theme(axis.text.x = element_text(angle = 90))

plot.progress(dfStudentInfo, 'archetype')
plot.progress(dfStudentInfo, 'role')
plot.progress(dfStudentInfo, 'team_role')
plot.progress(dfStudentInfo, 'user_role')
plot.progress(dfPerson, 'left')
plot.progress(dfPerson, 'gender')
plot.progress(dfPerson, 'country')
plot.progress(dfPerson, 'age_range')
plot.progress(dfPerson, 'highest_education_level')
plot.progress(dfPerson, 'employment_status')
plot.progress(dfPerson, 'employment_area')
plot.progress(dfPerson, 'detected_country')

#question and answers

#answers by question
df = dfAnswers %>% group_by(quiz_question) %>% count(dfAnswers$step)
df = select(df, quiz_question, n)
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
  labs(title="Question Result", y="Count", x = "Question Number") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu") +
  theme(axis.text.x = element_text(angle = 90))

plot.answers(dfStudentInfo, 'archetype')
plot.answers(dfStudentInfo, 'role')
plot.answers(dfStudentInfo, 'team_role')
plot.answers(dfStudentInfo, 'user_role')
plot.answers(dfPerson, 'left')
plot.answers(dfPerson, 'gender')
plot.answers(dfPerson, 'country')
plot.answers(dfPerson, 'age_range')
plot.answers(dfPerson, 'highest_education_level')
plot.answers(dfPerson, 'employment_status')
plot.answers(dfPerson, 'employment_area')
plot.answers(dfPerson, 'detected_country')


#videos
dfVSDevice
dfVSDevicePivot
dfVSLocation
dfVSLocationPivot
dfVSTotals
dfVSTotalsPivot

#video views
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


#continuous data in entire dataset
#get the time enrolled
df <- dfStudentInfo %>% drop_na(totalEnrolledTime)
df <- filter(df, totalEnrolledTime !=0) 
df <- select(df, learner_id, enrolled_at, unenrolled_at, totalEnrolledTime, stage_id.x)
df$totalEnrolledTime = as.double(round(df$totalEnrolledTime, digits=0))
count(df)

#get the steps passed
dfCompletedSteps = filter(dfStep, isComplete==TRUE)
dfCompletedSteps$step = as.character(dfCompletedSteps$step)
count(dfCompletedSteps)

#unique steps
length(unique(dfStep$step))

#group by learner_id and count
dfStepsByLearner = count(dfCompletedSteps, learner_id, step)
arrange(dfStepsByLearner, desc(n), learner_id)

dfTotalStepsByLearner = count(dfCompletedSteps, learner_id)
arrange(dfTotalStepsByLearner, desc(n))
arrange(count(dfSA, learner_id), desc(n))

all.rows(filter(dfCompletedSteps, learner_id == '005b9875-6783-4b4c-aad0-1342b12593bb'))
all.rows(filter(dfStep, learner_id == '005b9875-6783-4b4c-aad0-1342b12593bb'))
all.rows(filter(dfSA, learner_id == '77454a73-6b8b-46a2-8dee-35f36b6c4fc1'))


#mutiple enrollments, 300 roles - what i have called stage_id is better called a cohort id. 
#enrollments against stage_id
ggplot(data = df, aes(x = stage_id.x)) +
  geom_bar() + 
  theme_bw() + 
  labs(title= "Enrollments against Stage", y="Count", x = "Stage ID") +  
  scale_fill_brewer(palette="PuBu", name="Device") +
  theme(axis.text.x = element_text(angle = 90))

arrange(select(df, learner_id, stage_id.x), learner_id, stage_id.x)

#steps against stage_id
ggplot(data = dfCompletedSteps, aes(x = stage_id)) +
  geom_bar() + 
  theme_bw() + 
  labs(title= "Completed Steps against Stage", y="Count", x = "Stage ID") +  
  scale_fill_brewer(palette="PuBu", name="Device") +
  theme(axis.text.x = element_text(angle = 90))

arrange(select(dfCompletedSteps, learner_id, stage_id, step), learner_id, stage_id)


#steps by learner
ggplot(data = dfStepsByLearner, 
       aes(x = step)) +
  geom_bar() + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu", name="Device") +
  theme(axis.text.x = element_text(angle = 90))

#geom_point()

#join the data
#join the answers data
dfTimeEnrolledVsSteps = left_join(df, dfTotalStepsByLearner, by = c("learner_id" = "learner_id"))
dfTimeEnrolledVsSteps <- dfTimeEnrolledVsSteps %>% drop_na(n)

ggplot(data = dfTimeEnrolledVsSteps, aes(x = totalEnrolledTime)) +
  geom_bar() + 
  ylim(0, 30)
  #geom_point()



#Step time to complete
summary(dfStep$timeToComplete)
df <- filter(dfStep, timeToComplete !=0) #29075 rows due to lack of first_visited_at and last_completed_at data


#continuous video data by categorical data



#Investigate if there is any relationship between archetype and views, or drop out rate.
#Investigate any relationship between views and leavers
#Investigate any relationship between sentiment, views and leavers