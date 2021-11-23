#video stats

#working directory to the data directory
setwd("data/")

#working files
files = list.files(pattern="*video.stats.csv")

#bind into 1 data frame using readr https://readr.tidyverse.org/articles/readr.html
datalist = lapply(files, function(i){
  csv <- read_csv(i, show_col_types = FALSE)
  csv$stage_id <- substring(i,16,16)
  csv
})

#collate datalist to dataframe
dfVS <-dplyr::bind_rows(datalist)

#create a primary key need to add this as foreign key to other tables
dfVS %>% 
  arrange(step_position, title) %>%
  mutate(id = row_number())

dfVS$stage_id = as.integer(dfVS$stage_id)

#create sub views for working with separate datasets
#calculate real values rather than percents
#totals
dfVSTotals = dfVS[,c(1,2,4, 9:15)]
dfVSTotals$"05" = as.percent(dfVSTotals$total_views, dfVSTotals$viewed_five_percent)
dfVSTotals$"10" = as.percent(dfVSTotals$total_views, dfVSTotals$viewed_ten_percent)
dfVSTotals$"25" = as.percent(dfVSTotals$total_views, dfVSTotals$viewed_twentyfive_percent)
dfVSTotals$"50" = as.percent(dfVSTotals$total_views, dfVSTotals$viewed_fifty_percent)
dfVSTotals$"75" = as.percent(dfVSTotals$total_views, dfVSTotals$viewed_seventyfive_percent)
dfVSTotals$"95" = as.percent(dfVSTotals$total_views, dfVSTotals$viewed_ninetyfive_percent)
dfVSTotals$"99" = as.percent(dfVSTotals$total_views, dfVSTotals$viewed_onehundred_percent)
dfVSTotals = select(dfVSTotals, step_position, title, "05", "10", "25", "50", "75", "95", "99")
dfVSTotalsPivot = dfVSTotals %>% 
  pivot_longer(!(1:2), names_to = "percentviewed", values_to = "count") #createpivot

#devices
dfVSDevice = dfVS[,c(1,2,4, 16:21)]
dfVSDevice$Console = as.percent(dfVSDevice$total_views, dfVSDevice$console_device_percentage)
dfVSDevice$Desktop = as.percent(dfVSDevice$total_views, dfVSDevice$desktop_device_percentage)
dfVSDevice$Mobile = as.percent(dfVSDevice$total_views, dfVSDevice$mobile_device_percentage)
dfVSDevice$TV = as.percent(dfVSDevice$total_views, dfVSDevice$tv_device_percentage)
dfVSDevice$Tablet = as.percent(dfVSDevice$total_views, dfVSDevice$tablet_device_percentage)
dfVSDevice = select(dfVSDevice, step_position, title, Console, Desktop, Mobile, TV, Tablet)
dfVSDevicePivot = dfVSDevice %>% 
  pivot_longer(!(1:2), names_to = "percentviewed", values_to = "count") #createpivot


#location
dfVSLocation = dfVS[,c(1,2,4,22:28)]
dfVSLocation$Europe = as.percent(dfVSLocation$total_views, dfVSLocation$europe_views_percentage)
dfVSLocation$Oceania = as.percent(dfVSLocation$total_views, dfVSLocation$oceania_views_percentage)
dfVSLocation$Asia = as.percent(dfVSLocation$total_views, dfVSLocation$asia_views_percentage)
dfVSLocation$NorthAmerica = as.percent(dfVSLocation$total_views, dfVSLocation$north_america_views_percentage)
dfVSLocation$SouthAmerica = as.percent(dfVSLocation$total_views, dfVSLocation$south_america_views_percentage)
dfVSLocation$Africa = as.percent(dfVSLocation$total_views, dfVSLocation$africa_views_percentage)
dfVSLocation$Antartica = as.percent(dfVSLocation$total_views, dfVSLocation$antarctica_views_percentage)
dfVSLocation = select(dfVSLocation, step_position, title, Europe, Oceania, Asia, NorthAmerica, SouthAmerica, Africa, Antartica)
dfVSLocationPivot = dfVSLocation %>% 
  pivot_longer(!(1:2), names_to = "percentviewed", values_to = "count") #createpivot



#working directory back to root
setwd("..")

#head(dfVS)