library('ProjectTemplate'); 
load.project()

#Enrollments
summary(dfE)
table(dfE$gender)

#do some data quality checks
library(validate)

#check types
type_check <- validator(
  is.character(learner_id)
  , is.Date(enrolled_at)
  , is.Date(unenrolled_at)
  , is.character(role)
  , is.Date(fully_participated_at) 
  , is.Date(purchased_statement_at)
  , is.character(gender)
  , is.character(country)          
  , is.character(age_range)
  , is.character(highest_education_level)
  , is.character(employment_status)  
  , is.character(employment_area)    
  , is.character(detected_country)      
)
type_check_results <- confront(dfE, type_check)
summary(type_check_results)
plot(type_check_results)

#check missingness
missing_check <- validator(
  !is.na(learner_id)
  , !is.na(enrolled_at)
  , !is.na(unenrolled_at)
  , !is.na(role)
  , !is.na(fully_participated_at) 
  , !is.na(purchased_statement_at)
  , !is.na(gender)
  , !is.na(country)          
  , !is.na(age_range)
  , !is.na(highest_education_level)
  , !is.na(employment_status)  
  , !is.na(employment_area)    
  , !is.na(detected_country)  
)
missing_check_results <- confront(dfE, missing_check)
summary(missing_check_results)
#plot(missing_check_results)


#investigate categorical data
barplot(table(dfE$gender))
barplot(table(dfE$age_range))
barplot(table(dfE$country))
barplot(table(dfE$highest_education_level))
barplot(table(dfE$employment_area))
barplot(table(dfE$employment_status))
barplot(table(dfE$detected_country))
barplot(table(dfE$enrolled_at))
barplot(table(dfE$unenrolled_at))

#graph the enrollment data
par(mfrow=c(2,3))

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