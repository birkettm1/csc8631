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

#enrollments - no primary key
dfE %>% 
   count(learner_id) %>% 
   filter(n > 1)

dfTM %>% 
   count(learner_id) %>% 
   filter(n > 1)

#(Visualise > Model > Transform) 

#Understand 

#Communicate
