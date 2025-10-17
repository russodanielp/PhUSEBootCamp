
# deeper dive of dplyer
# today we will try and cover more data
# manipulation for common SEND
# these are going to be the functions
# arrange() -> for sorting dataframes
# case_when() -> vectorized if else
# summarizing data with groupby

library(dplyr)
library(haven)

bw <- haven::read_xpt('data/bw.xpt')
dm <- haven::read_xpt('data/dm.xpt')


# lets joim together to do
# something interesting
# we will do a follow up session
# on different types of joins
df <- inner_join(dm, bw, by='USUBJID')
head(df)

# select allows us to remove 
# bloat
df <- df %>%
  select(USUBJID, SETCD, SEX, BWDY, BWSTRESN)

head(df)

# sorting can be done 
# in both directions but
# one or mutiple columns
df_sorted <- df %>%
  arrange(BWDY)

df_rever <- df_sorted %>%
  arrange(desc(BWDY))

head(df_rever)  

# the best part of 
# dplyr is the ease 
# of dataframe manipulation
# and summarizing
weight_classes <- bw %>% 
  mutate(WEIGHT_CLASS = case_when( BWSTRESN > 300 ~ "Heavy", BWSTRESN > 200 ~ "Medium", TRUE ~ "Light" )) %>%
  select(USUBJID, WEIGHT_CLASS)

# most summarized stats will
# use a group by, but
# there are some helpful
# functions 
weight_classes %>% count(WEIGHT_CLASS)

weight_classes %>% 
  group_by(WEIGHT_CLASS) %>%
  summarize(n = n())

group_summaries <- df %>%
  group_by(SETCD, SEX, BWDY) %>%
  summarize(group_average = mean(BWSTRESN)) 


