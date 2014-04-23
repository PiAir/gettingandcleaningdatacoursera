#
# Getting and Cleaning Data
# run_analysis.R
#
# Date:   23-4-2014
# Author: Pierre Gorissen
#
#
# License:
# ========
# Use of the dataset in publications must be acknowledged by referencing the following publication [1] 
# 
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
# Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
# International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
#
# Assignment:
# Create one R script called run_analysis.R that does the following. 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive activity names. 
# 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# install the reshape package if needed
# install.packages("reshape")
library(reshape)

#
# Change the Working Directory folder to the folder containing the R script if needed
# Uncomment the two lines to run them
#
# kWorkingDirectory = "path/to/your/workingdirectory"
# setwd(kWorkingDirectory)
#
# kDataFolder is the folder containing the unzipped data set
# it is relative to the working directory
kDataFolder = "UCI HAR Dataset"

#
# Optional TODO - add option to have the script download the data set and unzip file
# http://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data
#

#
# functions.r contains all the functions used in the script
#
source("functions.r")

#
# read activity labels and features
#
activity.labels <- ReadActivityLabels()
features <- ReadFeatures()

# 1) Merge the training and the test sets to create one data set.
subjects <- rbind(ReadSubjects("train"), ReadSubjects("test") )
labels <- rbind(ReadLabels("train"), ReadLabels("test"))
sets <- rbind(ReadSets("train"), ReadSets("test"))
# link the feature names to the columns in the data set
names(sets) <- features$V2

# 2) Extract only the measurements on the mean and standard deviation for each measurement. 
# filter colum names ending om mean() or std()
sets.sub <- sets[,grep("mean\\(\\)$|std\\(\\)$",colnames(sets))]

# 3) Use descriptive activity names to name the activities in the data set
# 4) Appropriately label the data set with descriptive activity names. 
# match the descriptive labesl with the identifier for the activity
match.idx <- match(labels$V1, activity.labels$class.label)
labels$activity.name <- ifelse(is.na(match.idx),"",activity.labels$activity.name[match.idx])
names(labels)[1] <- "activity.label"
names(subjects)[1] <- "subject"
# create the resulting set
tidy.set <- cbind(subjects,labels,sets.sub)

# 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.



mtidy.set <- melt(tidy.set, id=c("subject", "activity.label", "activity.name"))
tidy.means <- cast(mtidy.set, subject+activity.label+activity.name~variable, mean)

#
# export the two data sets to comma delimeted file
# in working directory
#
write.table(tidy.set, "tidy.set.txt", sep=",")
write.table(tidy.means, "tidy.means.txt", sep=",")


datanames <- names(tidy.set)
outputlines <- paste("* ",datanames , sep="")
#write.table will create tidy.set.md in the current working directory
write.table(outputlines,file="tidy.set.md", quote = FALSE, col.names=FALSE, row.names=FALSE)

datanames <- names(tidy.means)
outputlines <- paste("* ",datanames , sep="")
#write.table will create tidy.means.md in the current working directory
write.table(outputlines,file="tidy.means.md", quote = FALSE, col.names=FALSE, row.names=FALSE)



#
# cleanup - remove temp data
#

rm(activity.labels)
rm(features)
rm(labels)
rm(mtidy.set)
rm(sets)
rm(sets.sub)
rm(subjects)
rm(match.idx)