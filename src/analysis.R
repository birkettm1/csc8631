#load some libraries
library('ProjectTemplate'); 
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

#Enrollments
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

#Leaving Surveys
summary(dfSA)
summary(dfLSR)
dfLSR = dfLSR %>% filter(!is.na(last_completed_step))
select(dfLSR, last_completed_step, last_completed_step_number, 
       last_completed_week_number)[1:5,]

table(dfLSR)
leavers = left_join(dfLSR, dfSA, by = c("last_completed_step" = "step_position"), 
                    copy = FALSE, suffix = c(".dfLSR", ".dfSA"), keep = TRUE,
                    na_matched = "na")

leavers = dfLSR %>% left_join(dfSA, by=c("last_completed_step"="step_position")) 

barplot(table(dfLSR$last_completed_step))
barplot(table(dfSA$step_position))
barplot(table(dfLSR$last_completed_step_number))
barplot(table(dfLSR$last_completed_week_number))


barplot(table(dfLSR$reason)
        , main="Reasons for Leaving"
        , xlab="Reason"
        , ylab="Count of Leavers")

#percentage complete
ggplot(data = dfLSR, aes(x = last_completed_step)) +
  geom_bar() +
  labs(y="Count of Leavers", x = "Step Number") + 
  theme_bw() + 
  scale_fill_brewer(palette="PuBu") +
  theme(axis.text.x = element_text(angle = 90))


#step activity
summary(dfSA)

#something about results - relate back to dfSA
summary(dfQR)
table(dfQR$quiz_question) 
table(dfQR$week_number) 
table(dfQR$step_number) 
barplot(table(dfQR$correct))



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
