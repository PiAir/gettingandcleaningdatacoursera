Getting And Cleaning Data
==============================

*Author:* Pierre Gorissen
*Date:* 23-4-2014

## About:
Repository for the Coursera Getting and Cleaning Data Course Project.
This repository contains all the files needed for the course project.

## Files:
* README.md - this file
* functions.r - contains all the functions needed
* run_analysis.r - contains the main code to create the tidy data set
* codebook.md - a file explaining the cleaning process and the data set

## How to use the script:
The functions.r file contains the functions needed to load the data sets
from disk. 
The file is loaded by run_analysis.r and no changes should be required.

The run_analysis.r file contains the main code to create the tidy data set.
It requires the "reshape" package. 
Uncomment this line in run_analysis.r:
```R
# install.packages("reshape")
```
to install it first if you have not done so yet.

If needed, set the working directory to the folder containing run_analysis.r
uncomment and modify these lines in run_analysis.r:
```R
# kWorkingDirectory = "path/to/your/workingdirectory"
# setwd(kWorkingDirectory)
```
to set the working directory.

The script also assumes that the unzipped data set is in a subfolder
of the working directory called "UCI HAR Dataset"
To change its location modify this line in run_analysis.r:
```R
kDataFolder = "UCI HAR Dataset"
```

## Results of the script:
The script outputs two CSV files to the working directory:
* tidy.set.txt
* tidy.means.txt

See the codebook.md file for explanation of the data contained in those two files.

The script als outputs two .md files to the working directory:
* tidy.set.md
* tidy.means.md

They contain a list of table headers for the two CSV files.

