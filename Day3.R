# Welcome to Day 3 of SEND Coding 
# Bootcamp.  Today we will explore 
# how to make publication quality
# graphics using the ggplot library
# here is a the reference: https://ggplot2.tidyverse.org/articles/ggplot2.html
# that goes into the interesting theory
# behind the packages API, which
# is based off the Grammar of Graphics
# book by Leland Wilkinson: https://link.springer.com/book/10.1007/0-387-28695-0


# We will need to load the ggplot
# library along with our haven
# library for reading xpt files
library(ggplot2)
library(haven)

# in this example we will make few plots
# plotting BW and clinical chemistry test
# by different variables like dose group 
# and sex

# load the necessary data
# BW -> contains animal weight measurements
bw <- haven::read_xpt('data/bw.xpt')

# body weight stores the information
# of every BW measurement for every
# animal
View(bw)

# lets start simple
# and plot a
# distribution of pretest bodyweights
# lets look at pretest values 
pretestValues <- bw[bw$BWDY < 0,]

# the bare minimum plot requires
# data, mapping, and a layer
ggplot(data = pretestValues, mapping = aes(x=BWSTRESN)) + 
  geom_bar()

# however to make interesting plots 
# we need a little more so lets
# combine our body weights with animal
# meta data
# DM -> demographics
# TX -> Trial Sets for exploration
dm <- haven::read_xpt("data/dm.xpt")
tx <- haven::read_xpt("data/tx.xpt")

# lets take a look at the domains
# and familarize ourselves a bit with
# the data
# DM stores information like animal
# and set -> it has the unique
# animal ID 
View(dm)

# trial sets define our groups
# of animals 
View(tx)

# putting our data in tidy format
# is going to make plotting much
# easier
# we have two unique identifier
# that we can merge out domains 
# by using the merge fx
data <- merge(dm, bw, by=c('STUDYID', 'USUBJID'))

# lets take a look just to confirm
# that our all of our plotting 
# data is there
View(data)

# for simplification we will just
# plot the high dose animals
# we could see SET5
highDose <- data[data$SETCD == '5',]

ggplot(data = highDose, aes(x=BWDY, y=BWSTRESN)) + # we first need to give data and mapping
  geom_point(aes(color=SEX)) + # we then plot a single geom
  stat_summary(fun = mean, geom = "point", shape = 4, size = 5, aes(color = SEX)) + # these can be 
  stat_summary(fun = mean, geom = "line", aes(color=SEX)) + # added to multiple layers
  facet_wrap(~ SEX) # facet wrap 


# lets try another plot using
# plotting clinical chemistry 
# against different dose/groups
# sex combinations

# we read in clin chem data
# LB -> laboratory results
lb <- haven::read_xpt('data/lb.xpt')

# create a new dataframe that includes
# our interesting plotting variables
lb_data <- merge(lb, dm, by=c('STUDYID', 'USUBJID'))

# lets just focus on plotting 
# ALT values
lb_data <- lb_data[lb_data$LBTESTCD == 'ALT',]


# GOAL: plot ALT responses against 
# the study day on the x axis, highlighting
# sex and dose group/setcd
# complete themes are available 
ggplot(data = lb_data, aes(x=factor(LBDY), y=LBSTRESN,  color=SETCD), ) + 
  geom_boxplot(fill='grey', outlier.shape = NA) + 
  scale_color_brewer(palette = 'Set1') + 
  facet_wrap(~ SEX) + 
  theme_light()
