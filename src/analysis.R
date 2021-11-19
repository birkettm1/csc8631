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

#enrollments - people
summary(dfE)
table(dfE$gender)
barplot(table(dfE$gender))
barplot(table(dfE$age_range))
barplot(table(dfE$country))
barplot(table(dfE$highest_education_level))
barplot(table(dfE$employment_area))
barplot(table(dfE$employment_status))
barplot(table(dfE$detected_country))
plot.enrollments()

#steps
#step is a week_number.step_number relate to step
dfSA = filter(dfSA, step == 1.1)

#identify complete or incomplete
nrow(filter(dfSA, is.na(dfSA$last_completed_at))) #incomplete stages 37514
nrow(filter(dfSA, !is.na(dfSA$last_completed_at))) #complete stages 385558
select(dfSA, stage_id, first_visited_at, last_completed_at, isComplete, timeToComplete) #check flag
plot.steps()

mean(as.numeric(dfSA$timeToComplete),na.rm=TRUE)
median(as.numeric(dfSA$timeToComplete),na.rm=TRUE)
table(dfSA$timeToComplete) #- create a frequency table of occurrences of data, use with categories / factors
range(as.numeric(dfSA$timeToComplete),na.rm=TRUE) #- get the lowest and highest value
sd(as.numeric(dfSA$timeToComplete),na.rm=TRUE) #- standard deviation
var(as.numeric(dfSA$timeToComplete),na.rm=TRUE) #- variance
quantile(as.numeric(dfSA$timeToComplete),na.rm=TRUE) #- quantile values at 25, 50, 75, 100%


#leavers
#last_completed_step is step
summary(dfLSR)
table(dfLSR)

#step
barplot(table(dfLSR$last_completed_step))
hist(as.numeric(substring(dfLSR$last_completed_step,1,3)))

#reason
barplot(table(dfLSR$leaving_reason), main="Leaving Reasons",
        names.arg = c("Time", "NotSaying", "Other", "Time", "TooEasy", "TooHard", "Different", "NoHelpGoals"))
boxplot(as.numeric(substring(dfLSR$last_completed_step,1,3)) ~ dfLSR$leaving_reason)


#question response
#quiz_question is week_number.step_number.question_number
summary(dfQR)
table(dfQR$quiz_question) 
table(dfQR$week_number) 
table(dfQR$step_number) 
table(dfQR$step)
barplot(table(dfQR$correct))


#video stats
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
