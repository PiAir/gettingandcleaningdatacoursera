#
# Getting and Cleaning Data
# functions.r
#
# Date:   23-4-2014
# Author: Pierre Gorissen
#
# Functions
#

CapFirst <- function(s) {
  # Changes the first letter of the first word of a string to capital
  # Source: http://stackoverflow.com/a/16249622
  #
  # Args:
  #  s: string whose first letter of the first word needs to be capitalized
  #
  # Returns:
  #  string with first letter of first word capitalized
  #
  paste(toupper(substring(s, 1, 1)), tolower(substring(s, 2)), sep = "")
}


ReadActivityLabels <- function() {
  # Read activity labels 
  #
  # Returns:
  #  data frame with
  #    class_label: identifier for activity
  #    activity_name: name of the activity
  # 
  t <- read.table(paste(kDataFolder, "/activity_labels.txt", sep=""), sep=" ")
  # Remove underscore in activity name
  t <- as.data.frame(sapply(t,gsub,pattern="_",replacement=" "))
  # Capitalize first letter of activity name
  t[2] <- lapply(t[2], CapFirst)
  names(t)[1] <- "class.label"
  names(t)[2] <- "activity.name"
  return(t)
}


ReadFeatures <- function() {
  # Read features  
  #
  # Requires:
  #  kDataFolder: subfolder of working directory containing features.txt
  # 
  # Returns:
  #  data frame t with  
  #    V1: feature identifier
  #    V2: feature description
  #
  t <- read.table(paste(kDataFolder, "/features.txt", sep=""), sep=" ")
  return(t)
}

ReadSubjects <- function(type) {
  # Read train or test subjects  
  #
  # Requires:
  #  kDataFolder: subfolder of working directory containing features.txt
  #
  # Args:
  #  type: string containing "train" or "test" to indicate which data set to import
  #
  # Returns:
  #  data frame t with  
  #    V1: subject identifier
  #  
  t <- read.table(paste(kDataFolder, "/", type , "/subject_",type,".txt", sep=""), sep="")
  return(t)
}

ReadLabels <- function(type) {
  # Read activity labels for train or test measurements  
  #   
  # Requires:
  #  kDataFolder: subfolder of working directory containing features.txt
  #   
  # Args:
  #  type: string containing "train" or "test" to indicate which data set to import
  #   
  # Returns:
  #  data frame t with  
  #    V1: activity identifier
  #      
  t <- read.table(paste(kDataFolder, "/", type , "/y_",type,".txt", sep=""), sep="")
  return(t)
}

ReadSets <- function(type) {
  # Read data set for train or test measurements  
  #   
  # Requires:
  #  kDataFolder: subfolder of working directory containing features.txt
  #   
  # Args:
  #  type: string containing "train" or "test" to indicate which data set to import
  #   
  # Returns:
  #  data frame t with 561 variables
  #    
  t <- read.table(paste(kDataFolder, "/", type , "/X_",type,".txt", sep=""), sep="")
  return(t)
}