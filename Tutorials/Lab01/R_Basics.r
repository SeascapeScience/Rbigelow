# R Basics (acknowledgements: Lisa Kerr, GMRI; Chris Legault, NEFSC)
# Below are the commands used in the R Basics presentation
# There are many notes included along the way as well
# the pound (hashtag) sign is a comment -- anything following # is ignored by R

#-------------------------------------------------------------------------------
# Help
help(min)                     # will open a new window with help on function min
 
#-------------------------------------------------------------------------------
# Examples
example(mean)                 # will run an example of the function mean
                              # good way to see how a function works
                              
#-------------------------------------------------------------------------------
# Starting Out
setwd('~/Work/Teaching/Colby/ColbyAtBigelow2016/Labs/Lab01/')     # sets working directory                                              
                                              # can also do "c://...." (double slash in this dir)
                                              # but "c:\RSession" won't work
                                              # note will get error message if folder does not exist
           
#-------------------------------------------------------------------------------
# Calculations
1+1                           # can use R as a calculator
7*63
52*7
3/4
1^2
4^2

#-------------------------------------------------------------------------------
# Objects
x <- 4                        # means assign variable x the value 4
x                             # prints out the value of x
y = 7                         # another way to assign a variable a value
y                             # print out y
x+y                           # can do arithmetic with these numeric objects
y^x
z <- "R is fun"               # can also assign a character string to a variable
z                             # prints out the string

#-------------------------------------------------------------------------------
# Syntax               
x <- 10                       # replaces previous value of x
X <- 20                       # R is case sensitive, x and X are different
x
X
x.1 <- 14                     # can include periods in variable names
x<-1;y<-2;x;y                # semicolon separates multiple commands on 1 line
# Use pound/hashtag sign (#) for comments


length                        # length is a function
                              # do not use it as a variable name
len <- 42                     # len is not a function, so OK to use as a variable
x+z                           # error because trying to add a number and string
#-------------------------------------------------------------------------------
# Workspace
ls()                          # lists all the R objects in workspace
rm(z)                         # removes z from workspace
ls()                          # note z is now gone
                              # use rm(list=ls()) to get rid of everything
                              # often helpful when you want to start over
                              
#-------------------------------------------------------------------------------
# Creating Objects
x <- 5                        # redefine value for x
y <- 8                        # redefine value for y
z <- x+y                      # can use a variable to define result 
z                             # result is 13
w <- c(x,y)                   # c() joins x and y objects into a new object
w                             # note w has two elements 5 and 8
a <- z+w                      # adding 13 to each element of w
a                             # results in 18 and 21
                              
#-------------------------------------------------------------------------------
# Creating Vectors
rep(5,3)                      # repeat the number 5 three times
seq(1,6)                      # create a sequence of numbers from 1 to 6 by 1 (default)
seq(5,1,-1)                   # can count backwards
seq(1,4,0.5)                  # can use fractional steps
seq(1,3,2)                    # can use steps greater than 1
seq(1,3,3)                    # if step beyond last number, last number does not appear
runif(5,2,20)                 # random number generator for uniform distribution
                              # 5 values are created between the nubmers 2 and 20
                              # lots of other random number generators available
                              # see help for rnorm, rlnorm, and others
                              
#-------------------------------------------------------------------------------
# Vector Arithmetic
m <- seq(1,5)                 # define a vector with 5 values
n <- seq(6,10)                # define another vector of 5 values

p <- m+n                      # adding the vectors adds element by element
p                             # 1st value is 1+6, 2nd value is 2+7, etc.
r <- seq(1,10)                # a vector with 10 elements
m+r                           # adding vectors with unequal length will cause
                              # shorter vector to be repeated: note no warning
                              # message in this case because evenly divisible
v <- seq(1,3)                 # vector with 3 elements
m+v                           # this time get warning message, but it does work

#-------------------------------------------------------------------------------
# Properties
m                             # look at the vector m 
length(m)                     # how many elements are in m
                              # note length is a function, so don't use as name
r                             # look at the vector r
length(r)                     # how many elements in r
mode(r)                       # mode is the type of elements
                              # can be numeric, character, or logical
z <- "R is fun"               # create a string variable
mode(z)                       # this variable has mode character
y <- TRUE                     # note TRUE in red denotes logical value
mode(y)                       # mode is logical 
 
#-------------------------------------------------------------------------------
# Vectors Example
Linf <- 55.0                 # define values for the von B growth function
K <- 0.3
t0 <- -0.3
age <- seq(0,10)             # create vector of 11 ages from zero to ten
                             # use vector arithmetic to calc len for all 11 ages at once
len <- Linf*(1-exp(-K*(age-t0)))  
len                          # show the resulting vector of length for each age
lw.alpha <- 0.00005          # set up length weight relationship parameters
lw.beta <- 3.01              # note beta is a function, so use lw.beta instead
wt <- lw.alpha * len^lw.beta # now getting vector of weights for all 11 lengths
wt                           # take a look at the vector
plot(len,wt)
#-------------------------------------------------------------------------------
# Not a Number (NaN) vs Not Available (NA) (aka Missing)
x = -16                      # set x to be a negative number
log.x <- log(x)              # natural logarithm of neg number undefined
log.x                        # produces NaN
sqrt.x <- sqrt(x)            # square root of neg number undefined
sqrt.x                       # produces NaN
y <- c(seq(1,5),NA,seq(7,10))# create series with a missing value
y                            # look at the vector
y2 <- y^2                    # square each element
y2                           # NA^2 is still NA
 
#-------------------------------------------------------------------------------
# Matrices
abc <- array(c(1,2,3,4,5,6),dim=c(2,3))
abc                          # abc defined using array function
                             # note row and column labels when printed
def <- matrix(c(7,8,9,10,11,12),nrow=2,ncol=3)
def                          # def defined using matrix function
                             # note order that elements are filled
                             
#-------------------------------------------------------------------------------
# Creating a constant matrix
# useful for defining size of matrix before using it 
ghi <- matrix(NA,nrow=6,ncol=5)
ghi                             

#-------------------------------------------------------------------------------
# Matrix Operations
abc                          # a matrix with 2 rows and 3 columns
abc+abc                      # element by element addition
abc*abc                      # element by element multiplication

#-------------------------------------------------------------------------------
# Data Frames                # note period between "data" and "frame"
xy <- data.frame(fish=seq(1,4),gender=c("F","M","M","M"))
xy                           # allows columns to have different modes

#-------------------------------------------------------------------------------
# Lists                      # grouped information of possibly different types
my.list <- list(a1=seq(1,5),b2=c("A","B","C"),c3=c(T,F))
my.list                      # note how each object defined and then
                             # each element in the object

#-------------------------------------------------------------------------------
# Info about lists
names(my.list)               # gives the object names within my.list
length(my.list)              # how many objects within my.list
my.list$b2                   # prints the elements of object b2 within my.list
                             # note use of $ to refer to object within list
length(my.list$c3)           # how many elements in object c3
mode(my.list)                # mode of a list is "list"
mode(my.list$a1)             # mode of objects within list depends on the object

#-------------------------------------------------------------------------------
#Regression Example
x <- seq(1,10)
y <- 1 + 2*x + rnorm(10)     # y is related to x with normally distributed noise
                             # note had to create 10 normal deviates due to 10 x
y
plot(x,y)                    # Plotting the variables against each other

z <- lm(y~x)                 # function lm is simple linear regression of y on x
                             # use help(lm) to get more info about lm
z                            # only very basic output to screen
names(z)                     # lots more info contained within z
z$residuals                  # print residuals from regression
mode(z)                      # z is a list
plot(z) 


#-------------------------------------------------------------------------------
# Sub-sampling Vectors
orig <- seq(10,1,-1)         # create a vector of numbers from 10 to 1
orig                         # print it
a <- orig[7]                 # select the 7th element of vector orig
                             # using square brackets
a                            # 4 is the 7th element
b <- orig[3:5]               # select elements 3 through 5 inclusive using colon
b                            # result is a vector of length 3

#-------------------------------------------------------------------------------
# Sub-sampling Vectors
orig <- seq(10,0,-2)         # a new vector with 6 elements
orig                         # print it
a <- orig[orig>5]            # select only elements > 5
a                            # results in a vector with 3 elements
b <- c(orig,orig)            # replicate vector so new one is length 12
b                            # see each number repeated twice
d <- b[b==4]                 # select only elements equal to 4
d                            # result is a vector of length 2
                             # useful for counting how many observations have
                             # a specific value
                             
#-------------------------------------------------------------------------------
# Sub-sampling Matrices
xyz <- array(seq(1,12),dim=c(3,4))
xyz                          # look at the 3 x 4 matrix
e23 <- xyz[2,3]              # select value in 2nd row and 3rd column
                             # using square brackets as was done for vectors
e23                          # value is 8
zz <- xyz[2:3,2:3]           # use colons to select a matrix within the matrix
zz                           # result is a 2 x 2 matrix with elements 5,6,8,9

#-------------------------------------------------------------------------------
# Sub-sampling Matrices
nc2 <- xyz[,-2]              # use minus sign to remove the second column
                             # note placement of comma
nc2                          # result is a 3 x 3 matrix with renumbered columns
nr2 <- xyz[-2,]              # use minus sign to remove the second row
                             # note the placement of comma
nr2                          # result is a 2 x 4 matrix
  
#-------------------------------------------------------------------------------
# Loops
N <- rep(NA,10)              # set up vector for results
N[1] <- 100                  # define first N to be 100
for (i in 2:10)              # for loop using i as counter from 2 to 10
{                            # need to use curly brackets with for loops
  N[i] <- N[i-1]*exp(-0.4)   # apply exponential decline to N at age
}                            # don't forget to close the brackets
N                            # print out vector of N at age
plot(N)
#-------------------------------------------------------------------------------
# If Statements (Conditionals)
a <- rnorm(10)               # create vector of 10 random numbers ~N(0,1)
a                            # take a look at the vector
for (i in 1:10)              # another for loop
{
  if (a[i]<=0) a[i]=0        # if condition in parentheses, response after
}                            # this example sets all negative values to zero
a                            # see how they changed
a[a<=0] <- 0                 # Note: This is a shorter way to do it

ifelse(a[10]<=0,b<-0,b<-1)   # ifelse: condition, true response, false response
b                            # was the last element of a zero or positive

#-------------------------------------------------------------------------------
# Summarizing Data
a <- rnorm(100)              # create vector of 100 random numbers ~N(0,1)
a.summary <- summary(a)      # summary computes basic statistics
a.summary                    # min, 1st quartile, median, mean, 3rd qrtile, max
a.var <- var(a)              # variance of a
a.var
a.mean <- mean(a)            # mean of a, note same as from summary
a.mean

#-------------------------------------------------------------------------------
# Summarizing Data (2)
b <- c(rnorm(99),NA)           # data with a missing value
summary(b)                     # note summary provides count of missing
mean(b)                        # regular mean results in NA
mean(b,na.rm=TRUE)             # option na.rm (remove missing) results in same 
                               #    value as summary mean
                               # na.rm available in many functions

