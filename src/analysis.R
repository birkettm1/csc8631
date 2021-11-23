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

#location analysis
#mean(as.numeric(dfSA$timeToComplete),na.rm=TRUE)
#median(as.numeric(dfSA$timeToComplete),na.rm=TRUE)
#table(dfSA$timeToComplete) #- create a frequency table of occurrences of data, use with categories / factors
#range(as.numeric(dfSA$timeToComplete),na.rm=TRUE) #- get the lowest and highest value
#sd(as.numeric(dfSA$timeToComplete),na.rm=TRUE) #- standard deviation
#var(as.numeric(dfSA$timeToComplete),na.rm=TRUE) #- variance
#quantile(as.numeric(dfSA$timeToComplete),na.rm=TRUE) #- quantile values at 25, 50, 75, 100%

#graphical analysis
#2 data sources
#plot(movies$length, movies$rating) 
#categorical
#barplot(table(categorical)) #continuous data
#continuous
#hist(continuous) #distribution of a value
#boxplot(continuous ~ categorical) #continuous vs a categorical
#pairs(data[,colNumbers]) #continuous vs continuous

#enrollments - people
summary(dfE)
nrow(dfE) #n items
ncol(dfE) #p variables
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
nrow(dfSA) #n items
ncol(dfSA) #p variables
dfSA = filter(dfSA, step == 1.1)

#identify complete or incomplete
nrow(filter(dfSA, is.na(dfSA$last_completed_at))) #incomplete stages 37514
nrow(filter(dfSA, !is.na(dfSA$last_completed_at))) #complete stages 385558
select(dfSA, stage_id, first_visited_at, last_completed_at, isComplete, timeToComplete) #check flag
plot.steps()

#leavers
#last_completed_step is step
nrow(dfLSR) #n items
ncol(dfLSR) #p variables
summary(dfLSR)
table(dfLSR)
plot.leavers()

#compare leaver stage to step
plot(dfLSR$last_completed_step, dfLSR$stage_id
     , pch=16
     , main="Comparison of Stage ID vs Last Completed Step"
     , xlab="Step Number"
     , ylab="Stage Number")


#question response
nrow(dfQR) #n items
ncol(dfQR) #p variables
#quiz_question is week_number.step_number.question_number
summary(dfQR)
table(dfQR$step_number) 
table(dfQR$step)
table(dfQR$quiz_question) 
table(dfQR$week_number) 

barplot(table(dfQR$correct))
pairs(dfQR[,4:5])
hist(dfQR$week_number)
hist(as.numeric(dfQR$step))
barplot(dfQR$step_number)

plot.question.responses()

#video stats
nrow(dfVS) #n items
ncol(dfVS) #p variables
summary(dfVS)
barplot(table(dfVS$total_transcript_views))
barplot(table(dfVS$viewed_five_percent))
barplot(table(dfVS$viewed_onehundred_percent))
dfVS$id

#totals
dfVSTotals
#pairs(dfQR[,4:5])
ggplot(data = dfVS, aes(x = total_views, y = viewed_fifty_percent))

#device
dfVSDevice

#origin
dfVSLocation

#something about sentiment - relate back via week_number
nrow(dfSS) #n items
ncol(dfSS) #p variables
summary(dfSS)
table(dfSS$reason)
count(dfSS, reason)

#Understand 

#Communicate
