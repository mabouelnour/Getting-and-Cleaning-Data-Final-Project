## Set the working directory on the desktop:

setwd("C:/Users/Mohamed/Desktop/Cleaning Data")

## Upload library reshape2 that will be used to melt and dcast the final data.frame 
## similar to gather and spread functions of the tidyr 

library(reshape2)

## Assign varible name to the downloaded zip file

filename <- "getdata_dataset.zip"

## Download and unzip the dataset ifi he file was not aleady unzipped:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, mode="wb")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load features

features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Load activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])


# Extract only the data on mean and standard deviation

# grep the row numbers that contain mean and std features

featuresWanted <- grep(".*mean.*|.*std.*", features[,2])

# save the mean and std fatures into features.name and cleaning the titles
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)


# Load the test and train  datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge the train and data set and assign lables
merged_Data <- rbind(train, test)
colnames(merged_Data) <- c("subject", "activity", featuresWanted.names)

# turn activities & subjects into factors
merged_Data$activity <- factor(merged_Data$activity, levels = activityLabels[,1], labels = activityLabels[,2])
merged_Data$subject <- as.factor(merged_Data$subject)

merged_Data.melted <- melt(merged_Data, id = c("subject", "activity"))
merged_Data.mean <- dcast(merged_Data.melted, subject + activity ~ variable, mean)

write.table(merged_Data.mean, "Final_Cleaned_Data.txt", row.names = FALSE, quote = FALSE)
