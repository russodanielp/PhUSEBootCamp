# Dataframes allow us to be able
# to do a lot of things out of the box
# however often times, the code can get
# repetitive and cumbersome.  The dplyr
# package (pronounced dee-ply-er), provides 
# a number of very useful, concise, and
# syntactically pleasing functions for 
# manipulating dataframes.  Here we will 
# cover the five most basic functions.  

library(dplyr)
library(haven)

# lets begin by selecting some 
# animals like we did last week 

bw <- haven::read_xpt('data/bw.xpt')

View(bw)

# before we did
# pretestValues <- bw[bw$BWDY < 0,]
# in dplyr we would do 

pretestValues <- filter(bw, BWDY < 0) 

head(pretestValues)

# but this doesn't look like it
# improves the code much.  dplyrs
# real strength comes from piping
# what if we also wanted to select
# the heaviest animals? e.g., over 300
# we could also do 
heavyPretest <- filter(pretestValues, BWSTRESN > 300)

head(heavyPretest)

# but now we have this variable 
# pretestValues that never really
# gets used.  Piping allows us
# to chain together operations

bw %>%
  filter(BWDY < 0) %>%
  filter(BWSTRESN > 300)

# the filter function allows
# us to select the rows.  
# the select function allows us 
# to pick certain variables 

heavyPretest <- bw %>%
  filter(BWDY < 0, BWSTRESN > 300) %>%
  select(USUBJID, BWDY, BWSTRESN) %>%
  mutate(body_weight_kg = BWSTRESN / 1000)

# we can also use the mutate
# function to create new columns
# on the variable 


# now lets create an end to end 
# analysis where we wanted to 
# do calculate the number of clinical 
# signs on a given study for each dose
# group.  For this, well need CL
# well need set codes from TM
# and a way to link them to the 
# animals in DM


cl <- haven::read_xpt('data/cl.xpt')
tx <- haven::read_xpt('data/tx.xpt')
dm <- haven::read_xpt('data/dm.xpt')

# we are not interested in normal
# and only need subset of columns 

clin_obs <- cl %>%
  filter(CLTESTCD == "CO", CLSTRESC != "NORMAL") %>%
  select(USUBJID, CLDY, CLSTRESC)

View(clin_obs)

# now we need to create a 
# frame with the animal IDs 
# and the labels of their 
# dose groups

View(tx)
View(dm)

setcds <- tx %>%
  select(SETCD, SET) %>%
  distinct() # these labels are duplicated so we call distinct to remove

View(setcds)

# now we can join the labels 
# with the animal ids
dose_groups <- dm %>%
  select(USUBJID, SEX, SETCD) %>%
  left_join(setcds, by = "SETCD")
  

oneObs <- clin_obs %>%
  filter(CLSTRESC == "Haircoat, abnormal") %>%
  left_join(dose_groups, by = "USUBJID")


oneObs %>%
  group_by(CLDY, SET, CLSTRESC) %>%
  summarize(counts = n())

# now lets try and plot it all in ggplot

library(ggplot2)

oneObs %>%
  group_by(CLDY, SET, CLSTRESC) %>%
  summarize(counts = n()) %>%
  filter(SET %in% c('Control Water', 'High Dose')) %>%
  mutate(`Dose Group` = factor(SET, levels = c('High Dose', 'Control Water'))) %>%
  mutate(Count = counts, `Study Day` = CLDY) %>%
  ggplot(aes(x = CLDY, y = counts, fill = `Dose Group`)) +
  geom_col(color='black', size=0.5) +
  scale_fill_brewer(palette = 'Set1') +
  theme_light() + 
  labs(title = "Counts by Day and Treatment Group")



