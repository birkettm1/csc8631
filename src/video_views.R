library('ProjectTemplate'); 
load.project()

#some about video stats
summary(dfVS)

#data quality
#data quality
#basic data quality checks
type_check <- validator(
  is.character(step_position)
  , is.character(title)
  , is.character(video_duration)
  , is.double(total_views)
  , is.double(total_downloads) 
  , is.double(total_caption_views)
  , is.double(total_transcript_views)
  , is.double(viewed_hd)
  
  , is.double(viewed_five_percent)
  , is.double(viewed_ten_percent)
  , is.double(viewed_twentyfive_percent)
  , is.double(viewed_fifty_percent)
  , is.double(viewed_seventyfive_percent)
  , is.double(viewed_ninetyfive_percent)
  , is.double(viewed_onehundred_percent)
  
  , is.double(console_device_percentage)
  , is.double(desktop_device_percentage)
  , is.double(mobile_device_percentage)
  , is.double(tv_device_percentage)
  , is.double(tablet_device_percentage)
  , is.double(unknown_device_percentage)
  
  , is.double(europe_views_percentage)
  , is.double(oceania_views_percentage)
  , is.double(asia_views_percentage)
  , is.double(north_america_views_percentage)
  , is.double(south_america_views_percentage)
  , is.double(africa_views_percentage)
  , is.double(antarctica_views_percentage)
)
type_check_results <- confront(dfVS, type_check)
summary(type_check_results)
#plot(type_check_results)

#check missingness
missing_check <- validator(
  !is.na(step_position)
  , !is.na(title)
  , !is.na(video_duration)
  , !is.na(total_views)
  , !is.na(total_downloads) 
  , !is.na(total_caption_views)
  , !is.na(total_transcript_views)
  , !is.na(viewed_hd)
  
  , !is.na(viewed_five_percent)
  , !is.na(viewed_ten_percent)
  , !is.na(viewed_twentyfive_percent)
  , !is.na(viewed_fifty_percent)
  , !is.na(viewed_seventyfive_percent)
  , !is.na(viewed_ninetyfive_percent)
  , !is.na(viewed_onehundred_percent)
  
  , !is.na(console_device_percentage)
  , !is.na(desktop_device_percentage)
  , !is.na(mobile_device_percentage)
  , !is.na(tv_device_percentage)
  , !is.na(tablet_device_percentage)
  , !is.na(unknown_device_percentage)
  
  , !is.na(europe_views_percentage)
  , !is.na(oceania_views_percentage)
  , !is.na(asia_views_percentage)
  , !is.na(north_america_views_percentage)
  , !is.na(south_america_views_percentage)
  , !is.na(africa_views_percentage)
  , !is.na(antarctica_views_percentage)
)
missing_check_results <- confront(dfVS, missing_check)
summary(missing_check_results)
#plot(missing_check_results)

barplot(table(dfVS$total_transcript_views))
barplot(table(dfVS$viewed_five_percent))
barplot(table(dfVS$viewed_onehundred_percent))

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

