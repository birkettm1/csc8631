#load some libraries
library('ProjectTemplate'); 
#library(dplyr)
#library(readr)
#library(DiagrammeR)

#load the project
load.project()


#business understanding, data understanding, data preparation, modelling, evaluation

#iteration 1
#Import - load 5 data frames - munge folder files 1 to 6
head(dfE) #enrollments #pk is id
head(dfTM) #team members #pk is id
head(dfAR) #archetype responses #pk is id
head(dfSA) #step activity
head(dfQR) #question response #pk is id
head(dfLSR) #leaving survey #pk is id
head(dfVS) #video stats #pk is id
head(dfSS) #sentiment survey #pk is id

#Tidy

#dfQR$question_number - does that relate somewhere
#dfLSR has last_completed_step and last_completed_step_number - does that relate into step_number at $dfSA_step_number
#dfQR$step_number - does that relate to dfSA$step_number
#dfTM has person names and roles with learner_id can this be related on id?
#dfSA$step (1.1) looks like it relates to  dfVS$step_position


#create a diagram of the relationships between tables
create.erd.flowchart()

#(Visualise > Model > Transform) 

#2 data sources
plot(movies$length, movies$rating)
#categorical
barplot(table(categorical))
#continuous
hist(continuous)
boxplot(continuous ~ categorical)

#something about people - enrollments
summary(dfE)
table(dfE$gender)
barplot(table(dfE$gender))
barplot(table(dfE$age_range))
barplot(table(dfE$country))
barplot(table(dfE$highest_education_level))
barplot(table(dfE$employment_area))
barplot(table(dfE$employment_status))
barplot(table(dfE$detected_country))
barplot(table(dfE$enrolled_at))
barplot(table(dfE$unenrolled_at))
plot.enrollments()


#learned - people come from GB, India, US, NG

#something about results - relate back to dfSA
summary(dfQR)
table(dfQR$quiz_question) 
table(dfQR$week_number) 
table(dfQR$step_number) 
barplot(table(dfQR$correct))

#something about leavers - relate back to dfSA
summary(dfLSR)
table(dfLSR)
barplot(table(dfLSR$last_completed_step))
barplot(table(dfLSR$last_completed_step_number))
barplot(table(dfLSR$last_completed_week_number))

#some about video stats
summary(dfVS)
barplot(table(dfVS$total_transcript_views))
barplot(table(dfVS$viewed_five_percent))
barplot(table(dfVS$viewed_onehundred_percent))

#something about sentiment - relate back via week_number
summary(dfSS)
table(dfSS$reason)
count(dfSS, reason)

#Understand 

#Communicate
