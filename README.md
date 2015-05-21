# Coursera: Getting and Cleaning Data - Course Project
This repository contains the following files:

* README.md
  this readme file
* CodeBook.md
  code book describing the cleaned dataset in UCI_HAR_cleaned.txt
* run_analysis.R
  R script creating the cleaned dataset from the original source
* UCI_HAR_cleaned.txt
  cleaned dataset created by the run_analysis.R script from the original source

Note that the run_analysis.R script does not download the dataset, but expects it to be present unzipped in the working directory of R.

run_analysis.R contains a single function which does not expect any additional arguments. It returns a data frame with the cleaned data set.

More precisely, it merges training and test data sets, extracts only mean and stadard deviation columns, and aggregates the data by activity and subject.


