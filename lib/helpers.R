helper.function <- function()
{
  return(1)
}

#create the flow chart
create.erd.flowchart <- function()
{
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

      [1]: 'Archtype (dfAR)'
      [2]: 'Enrollments (dfE)'
      [3]: 'Team Member (dfTM)'
      [4]: 'Leaving Survey (dfLSR)'
      [5]: 'Step Activity (dfSA)'
      [6]: 'Question Response (dfQR)'
      [7]: 'Video Stats (dfVS)'
      [8]: 'Sentiment Survey (dfSS)'
      ")
  
}

plot.enrollments = function(x){
  par(mfrow=c(3,2))
  #graph the enrollment data
  
  #country
  countryData = dfE %>%
    group_by(country) %>%
    count(dfE$country) #do a count
  countryData = filter(countryData, n > 100) #filter only where greater than 100
  countryData = select(countryData, country, n) #select the correct cols
  barplot(countryData$n, main="Enrollments by country greater than 100",
          names.arg = c("Australia", 'GB', "India", "Nigeria", "Unknown", "US"))
  #pie(countryData$n, labels = countryData$country, main="Enrollments by country greater than 10")
  
  #gender
  genderData = dfE %>%
    group_by(gender) %>%
    count(dfE$gender)
  genderData = select(genderData, gender, n)
  barplot(genderData$n, main="Enrollments by gender",
          names.arg = c("Female", 'Male', "Nonbinary", "Other", "Unknown"))
  #pie(genderData$n, labels = genderData$gender, main="Enrollments by gender")
  
  #age range
  agerangeData = dfE %>%
    group_by(age_range) %>%
    count(dfE$age_range)
  agerangeData = select(agerangeData, age_range, n)
  barplot(agerangeData$n, main="Enrollments by age range",
          names.arg = c("<18", ">65", "18-25", "26-35", "36-45", "46-55", "56-65","Unknown"))
  #pie(agerangeData$n, labels = agerangeData$age_range, main="Enrollments by age range")
  
  #highest_education_level
  highestEducationData = dfE %>%
    group_by(highest_education_level) %>%
    count(dfE$highest_education_level)
  highestEducationData = select(highestEducationData, highest_education_level, n)
  barplot(highestEducationData$n, main="Enrollments by highest education",
          names.arg = c("Apprenticeship", "<Secondary", "Professional", "Secondary", "Tertiary", "Degree", "Doctrate", "Masters", "Unknown"))
  #pie(highestEducationData$n, labels = highestEducationData$highest_education_level, main="Enrollments by highest education")
  
  #employment area
  employmentareaData = dfE %>%
    group_by(employment_area) %>%
    count(dfE$employment_area)
  employmentareaData = select(employmentareaData, employment_area, n)
  barplot(employmentareaData$n, main="Enrollments by employment area",
          names.arg = employmentareaData$employment_area)
  #pie(employmentareaData$n, labels = employmentareaData$employment_area, main="Enrollments by employment area")
  
  #employment area
  employmentstatusData = dfE %>%
    group_by(employment_status) %>%
    count(dfE$employment_status)
  employmentstatusData = select(employmentstatusData, employment_status, n)
  barplot(employmentstatusData$n, main="Enrollments by employment status",
          names.arg = employmentstatusData$employment_status)
  #pie(employmentstatusData$n, labels = employmentstatusData$employment_status, main="Enrollments by employment status")
  
  par(mfrow=c(1,1))
}