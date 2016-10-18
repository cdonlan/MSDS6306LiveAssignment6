# Author: Benjamin Reddy
# Taken from pages 49-50 of O'Neil and Schutt

#require(gdata)
#require(plyr) #Added by Monnie McGee
#install the gdata and plyr packages and load in to R.
library(plyr)
library(gdata)
#setwd("C:/MSDS 6306-FALL2016/402/Live session 06")

## You need a perl interpreter to do this on Windows.
## It's automatic in Mac
#bk <- read.xls("rollingsales_brooklyn.xls",pattern="BOROUGH")
getwd()

# So, save the file as a csv and use read.csv instead
mh <- read.csv("rollingsales_manhattan.csv",skip=4,header=TRUE)

## Check the data
head(mh)
summary(mh)
str(mh) # Very handy function!

## clean/format the data with regular expressions
## More on these later. For now, know that the
## pattern "[^[:digit:]]" refers to members of the variable name that
## start with digits. We use the gsub command to replace them with a blank space.
# We create a new variable that is a "clean' version of sale.price.
# And sale.price.n is numeric, not a factor.
mh$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", mh$SALE.PRICE))
count(is.na(mh$SALE.PRICE.N))

names(mh) <- tolower(names(mh)) # make all variable names lower case
## Get rid of leading digits
mh$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", mh$gross.square.feet))
head(mh$gross.sqft)
mh$land.sqft <- as.numeric(gsub("[^[:digit:]]","", mh$land.square.feet))
head(mh$land.sqft)
mh$year.built <- as.numeric(as.character(mh$year.built))
head(mh$year.built)

## do a bit of exploration to make sure there's not anything
## weird going on with sale prices
attach(mh)
hist(sale.price.n) 
detach(mh)

## keep only the actual sales

mh.sale <- mh[mh$sale.price.n!=0,]
plot(mh.sale$gross.sqft,mh.sale$sale.price.n)
plot(log10(mh.sale$gross.sqft),log10(mh.sale$sale.price.n))

## for now, let's look at 1-, 2-, and 3-family homes
mh.homes <- mh.sale[which(grepl("FAMILY",mh.sale$building.class.category)),]
dim(mh.homes)
plot(log10(mh.homes$gross.sqft),log10(mh.homes$sale.price.n))
summary(mh.homes[which(mh.homes$sale.price.n<100000),])


## remove outliers that seem like they weren't actual sales
mh.homes$outliers <- (log10(mh.homes$sale.price.n) <=5) + 0
mh.homes <- mh.homes[which(mh.homes$outliers==0),]
head(mh.homes$sale.price.n)
plot(log(mh.homes$gross.sqft),log(mh.homes$sale.price.n))