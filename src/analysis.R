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
head(dfE) #enrollments
head(dfTM) #team members
head(dfAR) #archetype responses
head(dfSA) #step activity
head(dfQR) #question response
head(dfLSR) #leaving survey
head(dfVS) #video stats
head(dfSS) #sentiment survey

#Tidy - explore and sort out with dplyr

#dfQR$question_number - does that relate somewhere
#dfLSR has last_completed_step and last_completed_step_number - does that relate into step_number at $dfSA_step_number
#dfQR$step_number - does that relate to dfSA$step_number
#dfTM has person names and roles with learner_id can this be related on id?
#dfSA$step (1.1) looks like it relates to  dfVS$step_position


#create a diagram of the relationships between tables
grViz("digraph flowchart {
      # node definitions with substituted label text
      node [fontname = Helvetica, shape = rectangle]        
      tab1 [label = '@@1']
      tab2 [label = '@@2']
      tab3 [label = '@@3']
      tab4 [label = '@@4']
      tab5 [label = '@@5']
      tab6 [label = '@@6']
      tab7 [label = '@@7']
      tab8 [label = '@@8']

      # edge definitions with the node IDs
      tab1 -> tab2;
      tab2 -> tab3;
      tab2 -> tab4;
      tab2 -> tab5;
      tab5 -> tab6;
      tab5 -> tab7;
      tab5 -> tab8;
      }

      [1]: 'Archtype (dfSA)'
      [2]: 'Enrollments (dfE)'
      [3]: 'Team Member (dfTM)'
      [4]: 'Leaving Survey (dfLSR)'
      [5]: 'Step Activity (dfSA)'
      [6]: 'Question Response (dfQR)'
      [7]: 'Video Stats (dfVS)'
      [8]: 'Sentiment Survey (dfSS)'
      ")


#(Visualise > Model > Transform) 

#Understand 

#Communicate
