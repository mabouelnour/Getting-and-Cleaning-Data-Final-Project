# Getting-and-Cleaning-Data-Final-Project

As per the assignment requirements, the R script does the following:

1-Set the working directory of the appropriate foler

2-Check the existance of the dataset and upload it if it was not existed (useful for testing the code)

3-Load the features info

4-Load the activity info

5-Load train dataset

6-Load test dataset

7-Select the columns that contain mean and std

8-bind the  activity and subject data with train and test data sets

9-Merges the two datasets into one large merged data set

10-Converts the activity and subject columns into factors

11-Using the melt and dcast functions of reshape2 package, creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

12-The Final Text file is saved as  Final_Cleaned_Data.txt
