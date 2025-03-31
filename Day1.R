# The basics 
# R can be a calculator

# running code
2+2

# assigning variables 
result <- 2+2
result

# types
aString <- "This is a string"
aString

# functions

myVector <- c(1, 2)

myNumbers <- 1:10

# operators

print(myNumbers)



# getting help 
?"<-"

# installing packages

# install.packages('haven')
# install.packages('ggplot2')
# install.packages('dplyr')
# 

# loading packakges
library(haven)


# reading an XPT file.  Lets
# just take a look at BW 
haven::read_xpt('data/bg.xpt')

bw <- haven::read_xpt('data/bw.xpt')

head(bw)
View(bw)


# think of columns as vectors 
bw$USUBJID

# there are several different ways
# to get the same column
bw['USUBJID']
bw[['USUBJID']]
bw[,'USUBJID']

# comma seperates rows and
# columns, i.e., i-th row, 
# j-th column i,j
bw[1,3]
bw[1, 'USUBJID']

# can also subset for a range
# i.e., the first tweny-five rows
bw[1:25,]

# we can do operations on vectors
bw['BWSTRESN'] / 1000

# we can create new columns
# via assignment
bw['BWSTRESN_KG'] <- bw['BWSTRESN'] / 1000

# Vectors that match will add
# (or raplce) the column with a vector
# scalar assignment repeats for the length
# of the dataframe (tibble)
bw['BWSTRESU_COPY'] <- 'kg'

View(bw)
