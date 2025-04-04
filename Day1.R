# Welcome to Day 1 of the PhUSE SEND
# Coding Bootcamp!  This is your first 
# R Script!  Below are different R commands,
# and anything preceded by a # is a 'comment'
# and effectively ignored by the R interpreter.
# These are good for documenting code.
# Good luck and happy coding! 

# The basics 
# R can be a calculator

# running code - this
# will get displayed to the 
# console
2+2

# assigning variables allows 
# information to be 'stored' in 
# a 'container'.  This is generally 
# done by an assignment operation using <-.
# they can be explicit or results of operations
myNumber <- 2
myNumber
result <- 2+2
result

# they can be very powerful and allow
# for more complex code
resultNumTwo <- myNumber + 2
resultNumTwo

# but they can always be reassigned
myNumber <- 100
myNumber

# types
aString <- "This is a string"
aString

# operations depend on type
# for example, this results in
# an error:
aString * 2


# functions are code 
# that take 'input' and 
# produce an output
# combine is a popular function
myVector <- c(1, 2)
myVector

# vectors can be created as a 
# range too
myNumbers <- 1:10
myNumbers

# operations on vectors
# are different and the result
# is element-wise
numbersTimesTwo <- myNumbers  * 2
numbersTimesTwo

# installing packages
# these should already be installed
# in your posit cloud workspace

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

# comma separates rows and
# columns, i.e., i-th row, 
# j-th column [i,j]
bw[1,3]
bw[1, 'USUBJID']

# can also subset for a range
# i.e., the first twenty-five rows
bw[1:25,]

# we can do operations on vectors
bw['BWSTRESN'] / 1000

# we can create new columns
# via assignment
bw['BWSTRESN_KG'] <- bw['BWSTRESN'] / 1000

# Vectors that match will add
# (or replace) the column with a vector
# scalar assignment repeats for the length
# of the dataframe (tibble)
bw['BWSTRESU_COPY'] <- 'kg'

View(bw)
