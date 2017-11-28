## PART 1 PREPARING WORKSPACE
## Setting relevant packages and reading tables into R
## required packages installed and loadad: dplyr and reshape2
## Must download file to working directory
## Get Data and unzip it (working directories may vary from user to user)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "D:/AssignmentData.zip", "auto")
unzip("AssignmentData.zip")

## Set working directory to unzipped file and extract relevant row and column names
setwd("D:/UCI HAR Dataset")
activity_names <- read.table("activity_labels.txt") ## (part of) Row names
features <- read.table("features.txt")[,2] ## Column names

## Note: reading several files into R creates a list. It has to be split and properly named
## to load a proper worskpace. The rm() function is used to clean up the worskpace as we move on.

## Go to directory, get list of desired files and read into R. Then split list into different
## objects.
setwd("train")
filelisttrain <- list.files()[grep(".txt",list.files())] 
tables <- lapply(filelisttrain,read.table) 
names(tables) <- filelisttrain
list2env(tables, envir = .GlobalEnv)

## Once desired dataframes are loaded in R, proper naming of activities, subjects and 
##variables takes place
colnames(X_train.txt) <- features
colnames(subject_train.txt) <- "subject"
colnames(y_train.txt) <- "activity"

## As "Test" and "Train" files are in different folders the code has to navigate through
## the directories to get relevant files. Check for proper filepaths and working directories.
## Note: these next pieces of code repeat the process of the "train" files with the "test" ones.

setwd("D:/UCI HAR Dataset/test")
filelisttest <- list.files()[grep(".txt",list.files())]
tables <- lapply(filelisttest,read.table) 
names(tables) <- filelisttest
list2env(tables, envir = .GlobalEnv)
rm("tables") ## remove object "tables" to free up memory
colnames(X_test.txt) <- features
colnames(subject_test.txt) <- "subject"
colnames(y_test.txt) <- "activity"

##PART 2 WORKING WITH THE DATAFRAMES (ACHIEVING A RAW SINGLE DATA FRAME TO WORK WITH)
## Once everything is properly loaded, the train and test datasets have to be combined. As both
## datasets have their variables assigned, cbind() is the best option. Note that a new variable
## is created, a character vector with the word "train" or "test", to identify the subject
## as belonging to the proper group. 

train_subset <- cbind(group= c(as.character("train")),subject_train.txt, y_train.txt, X_train.txt)
test_subset <- cbind(group= c(as.character("test")),subject_test.txt, y_test.txt, X_test.txt)
rawdata <- rbind(train_subset,test_subset)
rm(list=setdiff(ls(), c("rawdata","features", "activity_names" )))

##PART 3 REFINING RAW DATA SET
## The first lines of code try to drop all variables not related with the mean or the standard
## deviation of the measurments, by creating a vector and using grep() to filter the raw data.

vars <- c("subject","activity","group", grep("[Mm]ean",features, value = T),grep("[Ss][Tt][Dd]",features, value = T))
filterRawData <- rawdata[vars]
colnames(activity_names) <- c("activity","activity_d") ## Cols need to be named to be used as key in merge().
tidy <- merge(filterRawData,activity_names)
tidy$activity <- tidy$activity_d
tidy$activity_d <- NULL
rm(list=setdiff(ls(), c("tidy")))

## PART 4 MELTING, RECASTING & PRINTING
## Use melt() to identify id variables and value variables
## Use cast() to create a new dataframe that crosses subject and activity with the mean of
## the measurements.

melttidy <- melt(tidy, id=c("subject","activity","group"),4:89)
finaltidy <- dcast(melttidy,subject + activity ~variable,mean)
rm(list=setdiff(ls(), c("finaltidy", "tidy")))

## Some corrections to variable names and writing dataset onto file

colnames(finaltidy) <- gsub("BodyBody","Body", finaltidy)
write.table(finaltidy, "D:/SGX_MovementDataTidy.txt", row.names = F )
