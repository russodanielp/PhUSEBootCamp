# deeper dive of dplyer
# today we will try and cover more data
# manipulation for common SEND
# these are going to be the functions
# arrange() -> for sorting dataframes
# case_when() -> vectorized if else
# count() if time

library(dplyr)
library(haven)

bw <- read_xpt('data/bw.xpt')

head(bw)

# select allows us to remove 
# bloat
bw <- bw %>% 
  select(USUBJID, BWDY, BWSTRESN)

head(bw)

# sorting can be done 
# in both directions but
# one or mutiple columns
bw_sorted <- bw %>%
  arrange(BWDY)

head(bw_sorted)

bw_sorted_desc <- bw %>% 
  arrange(desc(BWDY))

head(bw_sorted_desc)

# sorting can be done 
# on multiple columns 
# in the dataframe
bw_sorted_animal <- bw %>%
  arrange(USUBJID, BWDY)

head(bw_sorted_animal)

# the best part of 
# dplyr is the ease 
# of dataframe manipulation
# and summarizing
weight_classes <- bw_sorted_animal %>%
  mutate(WEIGHT_CLASS = case_when(BWSTRESN > 300 ~ "Heavy", BWSTRESN > 200 ~ "Medium", .default = "Light")) %>%
  select(USUBJID, WEIGHT_CLASS)

head(weight_classes)

# most summarized stats will
# use a group by, which well 
# cover later, but
# there are some helpful
# functions 
weight_classes %>% count(WEIGHT_CLASS)
