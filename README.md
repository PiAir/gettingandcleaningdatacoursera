Getting And Cleaning Data
==============================

## About:
Repository for the Coursera Getting and Cleaning Data Course Project.
This repository contains all the files needed for the course project.

## Files:
* README.md - this file
* functions.r - contains all the functions needed
* run_analysis.r - contains the main code to create the tidy data set

## How to use:
The run_analysis.r file contains the main code to create the tidy data set.
It requires the "reshape" package. 
Uncomment the line
```R
# install.packages("reshape")
```
to install it first if you have not done so yet.

If needed, set the working directory to the folder containing run_analysis.r
uncomment and modify 
```R
# kWorkingDirectory = "path/to/your/workingdirectory"
```
and uncomment
```R
# setwd(kWorkingDirectory)
```
below it.


