Codebook
==============================

*Author:* Pierre Gorissen

*Date:* 23-4-2014

# About the data
The raw data for the project was downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

For each record in the draw dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

The original dataset contains a number of files. The README.txt explains the experiments in more detail and lists all the files in the raw data set.
This codebook will limit itself to the data cleaning process and the provided tidy data set.

# Requirements for the tidy data set
The project listed a number of requirements for the resulting tidy data set:

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

For clearity of the code, the script has been split in two parts: functions.r and run_analysis.r
The functions.r file contains all the functions used to read the txt files with the raw data while the run_analysis.r file contains the main logic of the script.
The run_analysis.r script also references the requirements listed above using comments.

# Variables

The run_analysis.r script creates a number of temporary variables, that are removed again at the end of the script:
* activity.labels: data frame with 2 colums:
  *  class.label: identifier for the activity
  *  activity.name: name of the activity
* features: data frame with 2 columns:
  * V1: feature identifier
  * V2: feature description
* labels: data frame with the combined activity identifiers for the merged train and test set and 2 columns:
  * activity.label: identifier for the activity
  * activity.name: name of the activity
* mtidy.set: data frame containing the melted result of tidy.set with 5 colomns:
  * subject: identifier for the subject
  * activity.label: identifier for the activity
  * activity.name: name of the activity
  * variable: column with the domain variables of tidy.set as values
  * value: column with the values for the domain variables listed in the variable column.
* sets: data frame with 561 columns for the merged train and test set. See below for info about the columns.
* sets.sub: data frame with a subselection of sets, based on requirement 2 of the project
* subjects: data frame with the subject identifiers for the merged train and test set. 1 column:
  * subject: identifier for the subject

Only two resulting data frames remain:
* tidy.means: a data frame consisting of 180 observations in 21 variables. See below for info about the columns.
* tidy.set: a data fram consisting of 10299 observations in 21 variables. See below for info about the columns.

# Steps taken by the script
The run_analysis.r script follows the requirements as close as possible.
After reading in the activity.labels and featers data frames, it merges the training and test sets.

## 1. Merge the training and the test sets to create one data set.
The README.txt file explained that the obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
```R
subjects <- rbind(ReadSubjects("train"), ReadSubjects("test") )
labels <- rbind(ReadLabels("train"), ReadLabels("test"))
sets <- rbind(ReadSets("train"), ReadSets("test"))
```
For both the training and test data, the subjects, labels and sets are read into data frames and combined using rbind.
The features data frame is then used to set the column names of the sets data frame:
```R
names(sets) <- features$V2
```
Because the next step calls for the creation of a sub set of the colums in the sets data frame, the three data frames are not yet combined.

## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
The features_info.txt file from the raw data set describes the measurements in more detail. It describes the signals and the resulting variables. For each resulting variable, the overall mean and stand deviation have been extracted. For the purpose of this analysis the measurement for the individual X,Y,Z directions have been discarted.
```R
sets.sub <- sets[,grep("mean\\(\\)$|std\\(\\)$",colnames(sets))]
```
* mean(): Mean value
* std(): Standard deviation

## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately label the data set with descriptive activity names.
These requirements looked (are) very simular. For the purpose of this analysis, the columns in the labels and subjects data frames have been named. The labels from the activity.labels data frame have been used to label the appropriate activities in the labels data frame.
```R
match.idx <- match(labels$V1, activity.labels$class.label)
labels$activity.name <- ifelse(is.na(match.idx),"",activity.labels$activity.name[match.idx])
names(labels)[1] <- "activity.label"
names(subjects)[1] <- "subject"
```

Finally the subjects, labels and sets.sub data frames have been combined to one tidy data set:
```R
tidy.set <- cbind(subjects,labels,sets.sub)
```
## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
In this final step, the tidy.set data frame is melted on subject, activity.label and activity.name allowing for the calculation of means (average) of each variable for each activity and each subject.
```R
mtidy.set <- melt(tidy.set, id=c("subject", "activity.label", "activity.name"))
tidy.means <- cast(mtidy.set, subject+activity.label+activity.name~variable, mean)
```

# Data in the resulting tidy.means data frame

The resulting tidy.mean data frame consists of these variables (columns):
* subject: identifier for the subject
* activity.label: identifier for the activity
* activity.name: name of the activity
* tBodyAccMag-mean() - mean of the time based body acceleration signal
* tBodyAccMag-std() - standard deviation of the time based body acceleration signal
* tGravityAccMag-mean() - mean of the time based magnitude of the body acceleration
* tGravityAccMag-std() - standard deviation of the time based magnitude of the body acceleration
* tBodyAccJerkMag-mean() - mean of the time based derived jerk signal based on the body linear acceleration and angular velocity
* tBodyAccJerkMag-std() - standard deviation of the time based derived jerk signal based on the body linear acceleration and angular velocity
* tBodyGyroMag-mean()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-mean()
* tBodyGyroJerkMag-std()
* fBodyAccMag-mean()
* fBodyAccMag-std()
* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-std()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-std()
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()
