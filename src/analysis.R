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

summary(dfTM)

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

par(mfrow=c(2,3))
#graph the enrollment data

#country
countryData = dfE %>%
  group_by(country) %>%
  count(dfE$country) #do a count
countryData = filter(countryData, n > 100) #filter only where greater than 100
countryData = select(countryData, country, n) #select the correct cols
barplot(countryData$n, main="Country",
        names.arg = c("Australia", 'GB', "India", "Nigeria", "Unknown", "US")
        , xlab = "Country"
        , ylab="Count of Enrollments")
#pie(countryData$n, labels = countryData$country, main="Enrollments by country greater than 10")

#gender
genderData = dfE %>%
  group_by(gender) %>%
  count(dfE$gender)
genderData = select(genderData, gender, n)
barplot(genderData$n, main="Gender",
        names.arg = c("Female", 'Male', "Nonbinary", "Other", "Unknown")
        , xlab = "Gender"
        , ylab="Count of Enrollments")
#pie(genderData$n, labels = genderData$gender, main="Enrollments by gender")

#age range
agerangeData = dfE %>%
  group_by(age_range) %>%
  count(dfE$age_range)
agerangeData = select(agerangeData, age_range, n)
barplot(agerangeData$n, main="Age Range",
        names.arg = c("<18", ">65", "18-25", "26-35", "36-45", "46-55", "56-65","Unknown")
        , xlab = "Age Range"
        , ylab="Count of Enrollments")

#highest_education_level
highestEducationData = dfE %>%
  group_by(highest_education_level) %>%
  count(dfE$highest_education_level)
highestEducationData = select(highestEducationData, highest_education_level, n)
barplot(highestEducationData$n, main="Highest Education",
        names.arg = c("Apprenticeship", "<Secondary", "Professional", "Secondary", "Tertiary", "Degree", "Doctrate", "Masters", "Unknown")
        , xlab = "Highest Educational Level"
        , ylab="Count of Enrollments")

#employment area
employmentareaData = dfE %>%
  group_by(employment_area) %>%
  count(dfE$employment_area)
employmentareaData = select(employmentareaData, employment_area, n)
barplot(employmentareaData$n, main="Employment Area",
        names.arg = employmentareaData$employment_area
        , xlab = "Employment Area"
        , ylab="Count of Enrollments")

#employment area
employmentstatusData = dfE %>%
  group_by(employment_status) %>%
  count(dfE$employment_status)
employmentstatusData = select(employmentstatusData, employment_status, n)
barplot(employmentstatusData$n, main="Employment Status",
        names.arg = employmentstatusData$employment_status
        , xlab = "Employment Status"
        , ylab="Count of Enrollments")

par(mfrow=c(1,1))

#leavers
#last_completed_step is step
nrow(dfLSR) #n items
ncol(dfLSR) #p variables
summary(dfLSR)
table(dfLSR)
plot.leavers()

plot(table(dfLSR$last_completed_step))
dfLSR = dfLSR %>% filter(!is.na(last_completed_step))

#percentage complete
ggplot(data = dfLSR, aes(x = last_completed_step)) +
  geom_bar() +
  labs(title= "Leavers by Last Completes Step", y="Count of Leavers", x = "Step Number") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu") +
  theme(axis.text.x = element_text(angle = 90))

#reasons for leaving
barplot(table(dfLSR$reason)
        , main="Reasons for Leaving"
        , xlab="Reason"
        , ylab="Number of Leavers")

#stage
barplot(table(dfLSR$stage_id)
        ,ylim=c(0,200)
        , main="Leaving Surveys by Stage"
        , xlab="Stage"
        , ylab="Number of Leavers")




#steps
#step is a week_number.step_number relate to step
nrow(dfSA) #n items
ncol(dfSA) #p variables
table(dfSA)
dfSA = filter(dfSA, step == 1.1)

#identify complete or incomplete
nrow(filter(dfSA, is.na(dfSA$last_completed_at))) #incomplete stages 37514
nrow(filter(dfSA, !is.na(dfSA$last_completed_at))) #complete stages 385558
select(dfSA, stage_id, first_visited_at, last_completed_at, isComplete, timeToComplete) #check flag
plot.steps()

par(mfrow=c(3,2))

#plot complete or not
barplot(table(dfSA$isComplete), ylim=c(0, 400000) 
        , main="Total Completed Steps"
        , xlab="Complete"
        , ylab="Count of Activity Steps")

boxplot(dfSA$step ~ dfSA$isComplete
        , main="Activity vs Step Number"
        , xlab="Complete"
        , ylab="Step Number")

boxplot(as.numeric(dfSA$timeToComplete) ~ as.numeric(substring(dfSA$step,1,3))
        , main="Time to Complete by Step"
        , xlab="Step"
        , ylab="Number of days")

barplot(table(dfSA$stage_id) 
        , main="Total Completed Steps by Course Stage"
        , xlab="Stage"
        , ylab="Complete steps")

boxplot(as.numeric(dfSA$timeToComplete) ~ dfSA$stage_id
        , main="Time to Complete by Course Stage"
        , xlab="Stage"
        , ylab="Number of days")

par(mfrow=c(1,1))


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

par(mfrow=c(3,2))

answerCount = dfQR %>%
  group_by(quiz_question) %>%
  count(dfQR$response)
answerCount = select(answerCount, quiz_question, n)

#responses by question
barplot(answerCount$n
        , main="Count of Responses by Question"
        , xlab="Question"
        , ylab="Count")

answerCount = dfQR %>%
  group_by(quiz_question) %>%
  count(correct) 

#correct answers
correctCount = filter(answerCount, correct==TRUE)
barplot(correctCount$n
        , las=2
        , main="Count of Correct Answer by Question"
        , xlab="Question"
        , ylab="Count")

incorrectCount = filter(answerCount, correct==FALSE)

#incorrect answers
barplot(incorrectCount$n
        , las=2
        , main="Count of Incorrect Answer by Question"
        , xlab="Question"
        , ylab="Count"
        , cex.main=1, cex.lab=1, cex.axis=1)
par(mfrow=c(1,1))


#video stats
nrow(dfVS) #n items
ncol(dfVS) #p variables
summary(dfVS)
barplot(table(dfVS$total_transcript_views))
barplot(table(dfVS$viewed_five_percent))
barplot(table(dfVS$viewed_onehundred_percent))
dfVS$id

#totals
summary(dfVSTotals)

#par(mfrow=c(3,3))
#hist(dfVSTotals$total_views)
#hist(dfVSTotals$viewed_five_percent)
#hist(dfVSTotals$viewed_ten_percent)
#hist(dfVSTotals$viewed_twentyfive_percent)
#hist(dfVSTotals$viewed_fifty_percent)
#hist(dfVSTotals$viewed_seventyfive_percent)
#hist(dfVSTotals$viewed_ninetyfive_percent)
#hist(dfVSTotals$viewed_onehundred_percent)
#par(mfrow=c(1,1))
#pairs(dfVSTotals[,3:10])

#export
#write.csv(dfVSTotals,"c:\\temp\\viewtotals.csv", row.names = FALSE)

#manual pivot
summary(dfVSTotals)
#dfVSTotalsPivot = dfVSTotals %>% 
#  pivot_longer(!(1:2), names_to = "percentviewed", values_to = "count")
#dfVSTotalsPivot$title = paste(dfVSTotalsPivot$step_position, dfVSTotalsPivot$title, pos=" ")


vid1 = ggplot(data = dfVSTotalsPivot, aes(fill=percentviewed, y = count, x = as.character(step_position))) +
  geom_bar(stat="identity", position="dodge") +
  labs(title= "Views by Video Completion", y="Views", x = "Video") + 
  scale_fill_brewer(palette="PuBu", name="Viewed",
                    breaks=c("05", "10", "25" ,"50","75","95", "99"),
                    labels=c("5%", "10%", "25%" ,"50%","75%","95%", "100%")) +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90))

#video by device
vid2 = ggplot(data = dfVSDevicePivot, aes(fill=percentviewed, y = count, x = as.character(step_position))) +
  geom_bar(stat="identity", position="dodge") +
  labs(title= "Views by Device", y="Views", x = "Video") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu", name="Device") +
  theme(axis.text.x = element_text(angle = 90))

#video by location
vid3 = ggplot(data = dfVSLocationPivot, aes(fill=percentviewed, y = count, x = as.character(step_position))) +
  geom_bar(stat="identity", position="dodge") +
  labs(title= "Views by Location", y="Views", x = "Video") + 
  scale_fill_brewer(palette="PuBu", name="Location") +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90))

grid.arrange(vid1, vid2, vid3, ncol=2, nrow=2)



#something about sentiment - relate back via week_number
nrow(dfSS) #n items
ncol(dfSS) #p variables
summary(dfSS)
table(dfSS$reason)
count(dfSS, reason)
#experience_rating categorical, reason string
barplot(table(dfSS$experience_rating)
        , main="Weekly Experience Rating"
        , xlab="Rating"
        , ylab="Count")
table(dfSS$experience_rating)
table(dfSS$week_number)
hist(dfSS$experience_rating)
select(dfSS, id, experience_rating, week_number)
typeof(dfSS$week_number)

ggplot(data = dfSS, aes(y = experience_rating, x = week_number )) +
  geom_bar(stat="identity") +
  labs(title= "Weekly Experience Rating", y="Experience Rating", x = "Week Number") + 
  scale_fill_brewer(palette="PuBu", name="Location")

ggplot(data = dfSS, aes(fill = experience_rating, x = week_number, y=experience_rating)) + 
  geom_bar(stat="identity", position = "dodge")

ggplot(dfSS, aes(x = experience_rating, fill = week_number )) + 
  geom_bar(position = "stack")

barplot(table(dfSS$week_number)
        , main="Weekly Experience Rating"
        , xlab="Week"
        , ylab="Count")

ggplot(dfSS, aes(x=week_number, fill=factor(experience_rating))) + 
  geom_bar(position="stack") +
  labs(title= "Weekly Experience Rating", y="Count", x = "Week Number") +
  theme_bw() + 
  scale_fill_brewer(palette="PuBu", name="Experience Rating")

#Understand 

#Communicate
