# Welcome to Day 2 of the PhUSE SEND
# Coding Bootcamp!  We will continue
# our delve into the R programming language
# by understanding booleans and 
# how they can be used to control the 
# flow of your program.  


# Conditionals are capable of controlling the 
# flow of your program and can 
# generally are done using if/else 
# statements which look like this

if (2 != 1) {
  print("Two is not equal to 1!")
} else {
  print("Two is equal to 1!")
}

# this is very helpful for 
# running code under various
# conditions

x <- 2*30

# adding an if conditional will 
# only get evaluated it the 
# condition is true
if (x > 100){
  print("x is greater than 100")
}
print(x)

# sometimes its helpful to 
# run other code if the condition
# is not met.  These are called 
# if/else statements

if (x > 100) {
  print("x is greater than 100")
} else {
  print("x is less than or equal to 100")
}

# its often helpful to to evaluate
# multiple conditions.
if (x > 100) {
  print("x is greater than 100")
} else if (x > 50) {
  print("x is less or eqaul to 100 but greater than 50")
} else {
  print("x is less than 50")
}


# what if we had data stored in 
# vector (or in a DataFrame)
myVector <- 1:100
myVector

if (x == myVector) {
  print("x is in the vector")
}

# comparing to a vector requires 
# different methods.  The any
# or all functions are examples

# any evaluates if any of the results
# are true 
any(x == myVector)

# all evaluates if all of the results
# are true 
all(x==myVector)

# both of these can be 
# used in conditionals
if (any(x == myVector)) {
  print("The number is in the vector!")
}

##### For loops
# sometimes we want to do the same 
# thing over and over.  Or maybe we 
# want to do something on a collection
# for loops allow us to do both of these 
# this.  For loops work with any
# iterable, collection, etc. 

oneThroughTen <- 1:10

for (i in oneThroughTen) {
  print(i)
}

# the can be 'looped'
# together 
shortList <- 1:5
letterList <- c('a', 'b', 'c', 'd', 'e')

for (i in shortList) {
  for (j in letterList) {
    print(i)
    print(k)
  }
}

# or even used to jsut
# do the same thing over
for (i in 1:10) {
  print(i)
  newI <- i+10
  print(newI)
}

# lets bring it all together
# to write an "program"
# that goes through a set 
# of numbers, 1-100 and prints 
# whether the number is even or
# off

# create a list 
myList <- 1:100

for (num in myList) {
  if (num %% 2 == 0) {
    myString <- paste(num, "is", "even")
  } else {
    myString <- paste(num, "is", "odd")
  }
  print(myString)
}


# booleans, when vectorized
# i.e., in a set of vectors, 
# allow us to slice our dataframes

library(haven)

bw <- haven::read_xpt('data/bw.xpt')
View(bw)

under200 <- bw[(bw$BWSTRESN < 200),]
View(under200)
