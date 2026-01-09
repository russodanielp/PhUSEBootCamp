# Today we will go over the different types
# of joins.  We will focus on four the 
# four major types of joins:
# left join
# inner join
# full/outer join
# right join


library(dplyr)
library(haven)

# We will first explore 
# connecting animal meta data with
# findings data, a common use case
# when analyzing send data

# lets explore the different 
# types by merging dm and lb
dm <- read_xpt('data/dm.xpt')
lb <- read_xpt('data/lb.xpt')

# DM has one row per animal
count(dm, STUDYID, USUBJID)
n_distinct(dm$USUBJID)

# LB usually has multiple 
# tests/time points per animal
count(lb, STUDYID, USUBJID)
n_distinct(lb$USUBJID)

# let say we wanted to "supplement"
# our DM dataset with the data in LB
# left join will keep everything
# from left table and only bring
# matching rows from right
# here we will not lose anything 
# from DM and only bring into the
# frame matches from LB
dm_lb_left <- dm %>%
  left_join(
    lb,
    by = c("STUDYID", "USUBJID")
  )

# number of rows after join
count(dm_lb_left, STUDYID, USUBJID)
View(dm_lb_left)

# all DM animals are still present
# regardless if they have lab tests remain
# they will just have missing LB columns
# animals with multiple test will have their 
# demographic information repeated over an 
# over again

# inner join will keep 
# only the rows where both
# dataframes match.  Useful
# if you are interested only
# in the "intersection" of both
# domains
dm_lb_inner <- dm %>%
  inner_join(
    lb,
    by = c("STUDYID", "USUBJID")
  )

count(dm_lb_inner, STUDYID, USUBJID)
n_distinct(dm_lb_inner$USUBJID)

# Only animals that are in both remain
# the animals in DM without lab tests 
# were dropped.  Very useful for doing 
# analysis on data -- e.g., LB stats



# full join will keep from both
dm_lb_full <- dm %>%
  full_join(
    lb,
    by = c("STUDYID", "USUBJID")
  )

count(dm_lb_full, STUDYID, USUBJID)
n_distinct(dm_lb_full$USUBJID)

View(dm_lb_full)

# right join is not functionally
# different than left join
dm_lb_right <- dm %>%
  right_join(
    lb,
    by = c("STUDYID", "USUBJID")
  )


# you can also match columsn that
# arent named the same
# like if you wanted to relate exposure
# levels to a particular clin finding
# here we will just do BW and cl for demo 
# purposes
cl <- read_xpt('data/cl.xpt')
bw <- read_xpt('data/bw.xpt')

bw_cl_inner <- bw %>%
  inner_join(
    cl,
    by = c("STUDYID", "USUBJID", 'BWDY'='CLDY')
  )


n_distinct(bw$USUBJID)
n_distinct(pc$USUBJID)
View(bw_cl_inner)

